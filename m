Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750932AbWIYUKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbWIYUKo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 16:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbWIYUKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 16:10:44 -0400
Received: from tomts20-srv.bellnexxia.net ([209.226.175.74]:7164 "EHLO
	tomts20-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1750932AbWIYUKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 16:10:42 -0400
Date: Mon, 25 Sep 2006 16:10:36 -0400
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Martin Bligh <mbligh@google.com>, "Frank Ch. Eigler" <fche@redhat.com>,
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
Message-ID: <20060925201036.GB13049@Krystal>
References: <20060925151028.GA14695@Krystal> <45181CE9.1080204@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <45181CE9.1080204@goop.org>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 15:51:26 up 33 days, 17:00,  7 users,  load average: 0.20, 0.25, 0.46
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jeremy Fitzhardinge (jeremy@goop.org) wrote:
> Mathieu Desnoyers wrote:
> >Good morning everyone,
> >
> >Following Jeremy Fitzhardinge's advice, I rewrote my marker mechanism 
> >taking in
> >consideration inline functions (and therefore also unrolled loops). This 
> >new
> >marker version is a complete rewrite of the previous one. It allows :
> >
> >- Multiple occurrences of the same marker name.
> >- Declaration of a marker in an inline function.
> >- Declaration of a marker in an unrolled loop.
> >- It _does not_ change the compiler optimisations.
> >  
> 
> Well, it will a little bit. If you put a mark on a statement which would 
> have otherwise been removed, then it will not be removed; the labels 
> effectively change the potential control flow graph as far as the 
> compiler is concerned. But if marks are used appropriately the impact 
> should be pretty minimal.
> 

Yes, I agree : data dependencies are added.

> [MARK_CALL]
> >+		asm volatile(	".section .markers, \"a\";\n\t" \
> >+				".long %0, %1;\n\t" \
> >+				".previous;\n\t" : : \
> >  
> [MARK_JUMP]
> >+		asm volatile(	".section .markers, \"a\";\n\t" \
> >+				".long %0, %1, %2;\n\t" \
> >+				".previous;\n\t" : : \
> >+			"m" (*&&jump_select_label), \
> >+			"m" (*&&call_label), \
> >+			"m" (*&&over_label)); \
> >  
> 
> If you're going to put different types in the .markers section 
> (presumably per-architecture, rather than different types for within one 
> architecture) you should probably also define a structure in the same 
> place, if nothing
> 

Yes, it would probably be useful in some situations, I will correct this.

> >+		asm volatile (	".align 16;\n\t" : : ); \
> >+		asm volatile (	".byte 0xeb;\n\t" : : ); \
> >+jump_select_label: \
> >+		asm volatile (	".byte %0-%1;\n\t" : : \
> >+				"m" (*&&over_label), "m" (*&&call_label)); \
> >  
> 
> There's absolutely nothing to guarantee that these three asm() will be 
> kept together in the generated code, or in the same place with respect 
> to any other asms.
> 

I could declare my jump_select_label directly in assembly then.

> >+call_label: \
> >+		asm volatile ("" : : ); \
> >+		MARK_CALL(name, format, ## args); \
> >+		asm volatile ("" : : ); \
> >+over_label: \
> >+		asm volatile ("" : : ); \
> >  
> 
> These asm volatiles won't do anything at all. What are you trying to 
> achieve?
> 

I want to make sure that the call_label's address will be exactly after the 2nd
byte of the jump instruction. The over_label does not really matter, as long as
it points to a correct spot in the execution flow. The most important is that
it stays near the jump instruction.

I could probably do all this in assembly too.

> >+#ifdef CONFIG_MARKERS
> >+#define MARK(name, format, args...) \
> >+	do { \
> >+		__label__ here; \
> >+here:   	asm volatile(	".section .markers, \"a\";\n\t" \
> >+				".long %0, %1;\n\t" \
> >+				".previous;\n\t" : : \
> >+			"m" (*(#name)), \
> >+			"m" (*&&here)); \
> >  
> 
> Seems like a bad idea that MARK() can put one type of record in 
> .markers, but MARK_JUMP and MARK_CALL can put different records in the 
> same section? How do you distinguish them? Or are they certain to be 
> exclusive? Either way, I'd probably put different mark records in 
> different sections: .markers.jump, .markers.call, markers.labels. And 
> define appropriate structures for the record types in each section.
> 


struct __mark_marker {
        const char *name;
        const void *location;
        char *select;
        const void *jump_call;
        const void *jump_over;
        marker_probe_func **call;
        const char *format;
};

is the structure which defines a complete record in the mark section. They are
all tied to the same marker site, so I think it makes sense to keep them in the
same record.


> Also, expecting to call a varargs function from a non-varargs callsite 
> is skating on very thin ice. Lots of architectures have very different 
> calling conventions for varadic vs non-varadic functions, and I wouldn't 
> rely on being able to make any sweeping generalizations about it. 
> regparm is only documented to do anything on i386; it almost certainly 
> won't make a non-varadic callsite look like a varadic call to a varadic 
> function on architectures who's ABIs use different conventions for the 
> two types of function.
> 

Right, well, I wanted to keep a generic caller and try to make assumptions about
the stack layout in the called function but if there is now way to do this, we
can think of using the varargs in the probe.

Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
