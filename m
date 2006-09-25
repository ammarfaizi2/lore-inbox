Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751408AbWIYSQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbWIYSQU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 14:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbWIYSQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 14:16:20 -0400
Received: from gw.goop.org ([64.81.55.164]:50339 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751408AbWIYSQT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 14:16:19 -0400
Message-ID: <45181CE9.1080204@goop.org>
Date: Mon, 25 Sep 2006 11:16:09 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
CC: Martin Bligh <mbligh@google.com>, "Frank Ch. Eigler" <fche@redhat.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Karim Yaghmour <karim@opersys.com>,
       Pavel Machek <pavel@suse.cz>, Joe Perches <joe@perches.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Jose R. Santos" <jrs@us.ibm.com>
Subject: Re: [PATCH] Linux Kernel Markers 0.11 for 2.6.17
References: <20060925151028.GA14695@Krystal>
In-Reply-To: <20060925151028.GA14695@Krystal>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers wrote:
> Good morning everyone,
>
> Following Jeremy Fitzhardinge's advice, I rewrote my marker mechanism taking in
> consideration inline functions (and therefore also unrolled loops). This new
> marker version is a complete rewrite of the previous one. It allows :
>
> - Multiple occurrences of the same marker name.
> - Declaration of a marker in an inline function.
> - Declaration of a marker in an unrolled loop.
> - It _does not_ change the compiler optimisations.
>   

Well, it will a little bit. If you put a mark on a statement which would 
have otherwise been removed, then it will not be removed; the labels 
effectively change the potential control flow graph as far as the 
compiler is concerned. But if marks are used appropriately the impact 
should be pretty minimal.

[MARK_CALL]
> +		asm volatile(	".section .markers, \"a\";\n\t" \
> +				".long %0, %1;\n\t" \
> +				".previous;\n\t" : : \
>   
[MARK_JUMP]
> +		asm volatile(	".section .markers, \"a\";\n\t" \
> +				".long %0, %1, %2;\n\t" \
> +				".previous;\n\t" : : \
> +			"m" (*&&jump_select_label), \
> +			"m" (*&&call_label), \
> +			"m" (*&&over_label)); \
>   

If you're going to put different types in the .markers section 
(presumably per-architecture, rather than different types for within one 
architecture) you should probably also define a structure in the same 
place, if nothing

> +		asm volatile (	".align 16;\n\t" : : ); \
> +		asm volatile (	".byte 0xeb;\n\t" : : ); \
> +jump_select_label: \
> +		asm volatile (	".byte %0-%1;\n\t" : : \
> +				"m" (*&&over_label), "m" (*&&call_label)); \
>   

There's absolutely nothing to guarantee that these three asm() will be 
kept together in the generated code, or in the same place with respect 
to any other asms.

> +call_label: \
> +		asm volatile ("" : : ); \
> +		MARK_CALL(name, format, ## args); \
> +		asm volatile ("" : : ); \
> +over_label: \
> +		asm volatile ("" : : ); \
>   

These asm volatiles won't do anything at all. What are you trying to 
achieve?

> +#ifdef CONFIG_MARKERS
> +#define MARK(name, format, args...) \
> +	do { \
> +		__label__ here; \
> +here:   	asm volatile(	".section .markers, \"a\";\n\t" \
> +				".long %0, %1;\n\t" \
> +				".previous;\n\t" : : \
> +			"m" (*(#name)), \
> +			"m" (*&&here)); \
>   

Seems like a bad idea that MARK() can put one type of record in 
.markers, but MARK_JUMP and MARK_CALL can put different records in the 
same section? How do you distinguish them? Or are they certain to be 
exclusive? Either way, I'd probably put different mark records in 
different sections: .markers.jump, .markers.call, markers.labels. And 
define appropriate structures for the record types in each section.

Also, expecting to call a varargs function from a non-varargs callsite 
is skating on very thin ice. Lots of architectures have very different 
calling conventions for varadic vs non-varadic functions, and I wouldn't 
rely on being able to make any sweeping generalizations about it. 
regparm is only documented to do anything on i386; it almost certainly 
won't make a non-varadic callsite look like a varadic call to a varadic 
function on architectures who's ABIs use different conventions for the 
two types of function.

J
