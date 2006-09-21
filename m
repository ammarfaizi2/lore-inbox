Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750994AbWIUCD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbWIUCD5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 22:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbWIUCD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 22:03:57 -0400
Received: from tomts13-srv.bellnexxia.net ([209.226.175.34]:35473 "EHLO
	tomts13-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1750969AbWIUCD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 22:03:56 -0400
Date: Wed, 20 Sep 2006 21:58:40 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
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
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Linux Markers 0.4 (+dynamic probe loader) for 2.6.17
Message-ID: <20060921015840.GB13504@Krystal>
References: <20060920234517.GA29171@Krystal> <4511D92A.3090204@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <4511D92A.3090204@goop.org>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 21:39:32 up 28 days, 22:48,  1 user,  load average: 0.01, 0.12, 0.11
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeremy,

Thanks for the insightful comments, see below :

* Jeremy Fitzhardinge (jeremy@goop.org) wrote:
> Mathieu Desnoyers wrote:
> >+#define MARK_SYM(name)	__asm__ ("__mark_kprobe_" #name ":")
> >  
> 
> This will need to be "asm volatile()" so that gcc doesn't get rid of it 
> altogether.  Also, there's nothing to make gcc keep this in any 
> particular place in the instruction stream, since it doesn't have any 
> data dependencies on anything else.  A "memory" clobber might help, but 
> ideally it would have some explicit data dependency on an important 
> value at that point.
> 

Yup, good catch. I have not seen gcc removing this asm in my objdump however, by
I guess we cannot be sure. This MARK_SYM() is only useful for kprobe
insertion : I don't use it myself for the jump markup stuff. I don't know how
relevant it is for kprobes users for the symbol to be at a specific location,
as they don't know themself what data they are interested in and they simply
don't want to modify the instruction stream. I fact, if the asm volatile
modifies the instruction stream, it would be an unwanted side-effect :(

> >+#else 
> >+#define MARK_SYM(name)
> >+#endif
> >+
> >+
> >+#ifdef CONFIG_MARK_JUMP_CALL
> >+#define MARK_JUMP_CALL_PROTOTYPE(name) \
> >+	static void \
> >+		(*__mark_##name##_call)(const char *fmt, ...) \
> >+		asm ("__mark_"#name"_call") = \
> >+			__mark_empty_function
> >+#define MARK_JUMP_CALL(name, format, args...) \
> >+	do { \
> >+		preempt_disable(); \
> >+		(void) (__mark_##name##_call(format, ## args)); \
> >  
> 
> (*foo)(args) is the preferred style for calling function pointers, since 
> it makes the pointerness explicit.  Though in this case there's enough 
> other complexity that the function call syntax is pretty much irrelevant 
> here.
> 

Ok, will fix


> >+		preempt_enable_no_resched(); \
> >+	} while(0)
> >+#else
> >+#define MARK_JUMP_CALL_PROTOTYPE(name)
> >+#define MARK_JUMP_CALL(name, format, args...)
> >+#endif
> >+
> >+#ifdef CONFIG_MARK_JUMP_INLINE
> >+#define MARK_JUMP_INLINE(name, format, args...) \
> >+		(void) (__mark_##name##_inline(format, ## args))
> >+#else
> >+#define MARK_JUMP_INLINE(name, format, args...)
> >+#endif
> >+
> >+#define MARK_JUMP(name, format, args...) \
> >+	do { \
> >+		__label__ over_label, call_label, inline_label; \
> >+		volatile static void *__mark_##name##_jump_over \
> >+				asm ("__mark_"#name"_jump_over") = \
> >+					&&over_label; \
> >+		volatile static void *__mark_##name##_jump_call \
> >+				asm ("__mark_"#name"_jump_call") \
> >+				__attribute__((unused)) =  \
> >+					&&call_label; \
> >+		volatile static void *__mark_##name##_jump_inline \
> >+				asm ("__mark_"#name"_jump_inline") \
> >+				__attribute__((unused)) =  \
> >+					&&inline_label; \
> >+		MARK_JUMP_CALL_PROTOTYPE(name); \
> >+		goto *__mark_##name##_jump_over; \
> >+call_label: \
> >+		MARK_JUMP_CALL(name, format, ## args); \
> >+		goto over_label; \
> >+inline_label: \
> >+		MARK_JUMP_INLINE(name, format, ## args); \
> >+over_label: \
> >+		do {} while(0); \
> >+	} while(0)
> >  
> 
> I have to admit I haven't been following all this tracing stuff, but 
> this is pretty opaque.  What's it trying to achieve?  Hm, OK, I think I 
> see what you're getting at here - see below.
> 

Default behavior : load "over_label" and jump to its address.
I can override dynamically the behavior by setting the jump target to either
call_label or inline_label.

The call_label is reponsible for calling an empty function by default. The
function pointer can be overridden.


> >+
> >+#define MARK(name, format, args...) \
> >+	do { \
> >+		__mark_check_format(format, ## args); \
> >+		MARK_SYM(name); \
> >+		MARK_JUMP(name, format, ## args); \
> >+	} while(0)
> >  
> 
> Does this assume that the symbol injected by MARK_SYM() will label the 
> MARK_JUMP() code?  Because it won't.
> 

No, MARK_SYM() is only useful for kprobes, unrelated to MARK_JUMP.

> >	
> >	printk("Installing hook\n");
> >	*target_mark_call = (void*)do_mark1;
> >	saved_over = *target_mark_jump_over;
> >	*target_mark_jump_over = *target_mark_jump_call;
> >  
> 
> So the point of this is to set up the new function, then update the 
> jumpover to point to it, in a way that's SMP safe?  This assumes two things:
> 
>   1. that your pointer updates are atomic

Yes : the pointer is aligned and all of the architectures that I know write
pointer-sized information atomically when it is aligned.

>   2. that these writes don't get reordered
> 

It doesn't matter :) You are absolutely right, they can get reordered, and the
fact is : we don't care. The function above sets the *target_mark_call before
the *target_mark_jump_over, so that the function pointer is set up before the
jump can call it. But imagine the inverse : the will be able to the function
call before the function call handler is set up. It really doesn't matter
because the function pointer is always pointing to a valid function : either the
"empty" default function or the inserted one.

> 
> 
> >	return 0;
> >}
> >
> >int init_module(void)
> >{
> >	return mark_install_hook();
> >}
> >
> >void cleanup_module(void)
> >{
> >	printk("Removing hook\n");
> >	*target_mark_jump_over = saved_over;
> >	*target_mark_call = __mark_empty_function;
> >
> >	/* Wait for instrumentation functions to return before quitting */
> >	synchronize_sched();
> >}
> >  
> 
> What if multiple people hook onto the same mark?  Are you assuming LIFO?
> 

That's the "proof of concept module" part. I plan to do a kernel/marker.c that
will deal with all marker activation from a centralized, coherent mechanism. The
functions that will be called will simply sit in modules.

Before activating a probe, the marker.ko module will 1- take proper locking
and 2- verify that the function pointer and jmp target are at their default
values, otherwise the "install" operation fails, increment the probe-module
refcount and then set them up.

Setting them back to disabled is always the same operation : setting back the
default jmp and call values, synchronize_sched() and release the probe-module
refcount.

The marker.ko module will also deal with inline jump selection, which is the
same case as presented here, but without the function pointer, module refcount
and synchronization.

Thanks,

Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
