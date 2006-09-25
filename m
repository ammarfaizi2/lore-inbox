Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751012AbWIYUZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbWIYUZR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 16:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbWIYUZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 16:25:17 -0400
Received: from gw.goop.org ([64.81.55.164]:8862 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751012AbWIYUZP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 16:25:15 -0400
Message-ID: <45183B20.2080907@goop.org>
Date: Mon, 25 Sep 2006 13:25:04 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
CC: Martin Bligh <mbligh@google.com>, "Frank Ch. Eigler" <fche@redhat.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
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
References: <20060925151028.GA14695@Krystal> <45181CE9.1080204@goop.org> <20060925201036.GB13049@Krystal>
In-Reply-To: <20060925201036.GB13049@Krystal>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers wrote:
> I could declare my jump_select_label directly in assembly then.
>   

Maybe, but it could be tricky to make that label visible to C code.

>>> +call_label: \
>>> +		asm volatile ("" : : ); \
>>> +		MARK_CALL(name, format, ## args); \
>>> +		asm volatile ("" : : ); \
>>> +over_label: \
>>> +		asm volatile ("" : : ); \
>>>  
>>>       
>> These asm volatiles won't do anything at all. What are you trying to 
>> achieve?
>>     
>
> I want to make sure that the call_label's address will be exactly after the 2nd
> byte of the jump instruction. The over_label does not really matter, as long as
> it points to a correct spot in the execution flow. The most important is that
> it stays near the jump instruction.
>   

The "volatile" modifier for "asm" *only* means that the asm emitted if 
the code is reachable at all; it doesn't make any constraints about 
relative ordering of the various asm volatile statement with respect to 
each other, or with respect to other code.

> I could probably do all this in assembly too.
>   

Perhaps, though doing as much as possible visible to gcc has its 
benefits.  Tricky either way.

>>> +#ifdef CONFIG_MARKERS
>>> +#define MARK(name, format, args...) \
>>> +	do { \
>>> +		__label__ here; \
>>> +here:   	asm volatile(	".section .markers, \"a\";\n\t" \
>>> +				".long %0, %1;\n\t" \
>>> +				".previous;\n\t" : : \
>>> +			"m" (*(#name)), \
>>> +			"m" (*&&here)); \
>>>  
>>>       
>> Seems like a bad idea that MARK() can put one type of record in 
>> .markers, but MARK_JUMP and MARK_CALL can put different records in the 
>> same section? How do you distinguish them? Or are they certain to be 
>> exclusive? Either way, I'd probably put different mark records in 
>> different sections: .markers.jump, .markers.call, markers.labels. And 
>> define appropriate structures for the record types in each section.
>>
>>     
>
>
> struct __mark_marker {
>         const char *name;
>         const void *location;
>         char *select;
>         const void *jump_call;
>         const void *jump_over;
>         marker_probe_func **call;
>         const char *format;
> };
>
> is the structure which defines a complete record in the mark section. They are
> all tied to the same marker site, so I think it makes sense to keep them in the
> same record.
>   

I don't understand.  Your asms put things into the marker section with 
".long A, B, C".  Does does that correspond to this structure?

> Right, well, I wanted to keep a generic caller and try to make assumptions about
> the stack layout in the called function but if there is now way to do this, we
> can think of using the varargs in the probe.
>   

i386 is about the only architecture which uses the stack for calls by 
default.

    J
