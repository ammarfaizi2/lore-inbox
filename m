Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbWIUANf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWIUANf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 20:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbWIUANf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 20:13:35 -0400
Received: from gw.goop.org ([64.81.55.164]:63886 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1750804AbWIUANe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 20:13:34 -0400
Message-ID: <4511D92A.3090204@goop.org>
Date: Wed, 20 Sep 2006 17:13:30 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
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
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Linux Markers 0.4 (+dynamic probe loader) for 2.6.17
References: <20060920234517.GA29171@Krystal>
In-Reply-To: <20060920234517.GA29171@Krystal>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers wrote:
> +#define MARK_SYM(name)	__asm__ ("__mark_kprobe_" #name ":")
>   

This will need to be "asm volatile()" so that gcc doesn't get rid of it 
altogether.  Also, there's nothing to make gcc keep this in any 
particular place in the instruction stream, since it doesn't have any 
data dependencies on anything else.  A "memory" clobber might help, but 
ideally it would have some explicit data dependency on an important 
value at that point.

> +#else 
> +#define MARK_SYM(name)
> +#endif
> +
> +
> +#ifdef CONFIG_MARK_JUMP_CALL
> +#define MARK_JUMP_CALL_PROTOTYPE(name) \
> +	static void \
> +		(*__mark_##name##_call)(const char *fmt, ...) \
> +		asm ("__mark_"#name"_call") = \
> +			__mark_empty_function
> +#define MARK_JUMP_CALL(name, format, args...) \
> +	do { \
> +		preempt_disable(); \
> +		(void) (__mark_##name##_call(format, ## args)); \
>   

(*foo)(args) is the preferred style for calling function pointers, since 
it makes the pointerness explicit.  Though in this case there's enough 
other complexity that the function call syntax is pretty much irrelevant 
here.

> +		preempt_enable_no_resched(); \
> +	} while(0)
> +#else
> +#define MARK_JUMP_CALL_PROTOTYPE(name)
> +#define MARK_JUMP_CALL(name, format, args...)
> +#endif
> +
> +#ifdef CONFIG_MARK_JUMP_INLINE
> +#define MARK_JUMP_INLINE(name, format, args...) \
> +		(void) (__mark_##name##_inline(format, ## args))
> +#else
> +#define MARK_JUMP_INLINE(name, format, args...)
> +#endif
> +
> +#define MARK_JUMP(name, format, args...) \
> +	do { \
> +		__label__ over_label, call_label, inline_label; \
> +		volatile static void *__mark_##name##_jump_over \
> +				asm ("__mark_"#name"_jump_over") = \
> +					&&over_label; \
> +		volatile static void *__mark_##name##_jump_call \
> +				asm ("__mark_"#name"_jump_call") \
> +				__attribute__((unused)) =  \
> +					&&call_label; \
> +		volatile static void *__mark_##name##_jump_inline \
> +				asm ("__mark_"#name"_jump_inline") \
> +				__attribute__((unused)) =  \
> +					&&inline_label; \
> +		MARK_JUMP_CALL_PROTOTYPE(name); \
> +		goto *__mark_##name##_jump_over; \
> +call_label: \
> +		MARK_JUMP_CALL(name, format, ## args); \
> +		goto over_label; \
> +inline_label: \
> +		MARK_JUMP_INLINE(name, format, ## args); \
> +over_label: \
> +		do {} while(0); \
> +	} while(0)
>   

I have to admit I haven't been following all this tracing stuff, but 
this is pretty opaque.  What's it trying to achieve?  Hm, OK, I think I 
see what you're getting at here - see below.

> +
> +#define MARK(name, format, args...) \
> +	do { \
> +		__mark_check_format(format, ## args); \
> +		MARK_SYM(name); \
> +		MARK_JUMP(name, format, ## args); \
> +	} while(0)
>   

Does this assume that the symbol injected by MARK_SYM() will label the 
MARK_JUMP() code?  Because it won't.

> 	
> 	printk("Installing hook\n");
> 	*target_mark_call = (void*)do_mark1;
> 	saved_over = *target_mark_jump_over;
> 	*target_mark_jump_over = *target_mark_jump_call;
>   

So the point of this is to set up the new function, then update the 
jumpover to point to it, in a way that's SMP safe?  This assumes two things:

   1. that your pointer updates are atomic
   2. that these writes don't get reordered

1 might be safe, but I don't think its guaranteed for all 
architectures.  2 is not true without some explicit barriers in there.  
You'll probably need some in MARK_JUMP too.


> 	return 0;
> }
>
> int init_module(void)
> {
> 	return mark_install_hook();
> }
>
> void cleanup_module(void)
> {
> 	printk("Removing hook\n");
> 	*target_mark_jump_over = saved_over;
> 	*target_mark_call = __mark_empty_function;
>
> 	/* Wait for instrumentation functions to return before quitting */
> 	synchronize_sched();
> }
>   

What if multiple people hook onto the same mark?  Are you assuming LIFO?

    J
