Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932362AbVJRB5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbVJRB5n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 21:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbVJRB5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 21:57:43 -0400
Received: from [210.76.114.20] ([210.76.114.20]:7354 "EHLO ccoss.com.cn")
	by vger.kernel.org with ESMTP id S932362AbVJRB5n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 21:57:43 -0400
Message-ID: <435456DB.70404@ccoss.com.cn>
Date: Tue, 18 Oct 2005 09:58:51 +0800
From: liyu <liyu@ccoss.com.cn>
Reply-To: liyu@ccoss.com.cn
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: zh-cn,zh
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Question] one question about 'current' in scheduler_tick()
References: <43535B35.5020603@ccoss.com.cn> <Pine.LNX.4.58.0510170416090.5859@localhost.localdomain> <43536892.9070607@ccoss.com.cn> <Pine.LNX.4.58.0510170519540.5859@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.58.0510170519540.5859@localhost.localdomain>
Content-Type: text/plain; charset=gb18030; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:

>On Mon, 17 Oct 2005, liyu wrote:
>
>  
>
>>Hi Steve, Thanks once again :)
>>
>>    I searched arch/i386/kernel/irq.c, and got this line of code:
>>
>>    irqctx->tinfo.task = curctx->tinfo.task;
>>
>>    I think it just is answer that I want to get. It seem interrupt
>>stack is
>>created at top of the original kernel stack. Are my words right?
>>    
>>
>
>Not with 4KSTACK.  With 4KSTACK defined, the interrupts have their own
>stack.  So lets look at how current works (for x86).
>
>static inline struct task_struct * get_current(void)
>{
>	return current_thread_info()->task;
>}
>
>#define current get_current()
>
>OK, current is really a MACRO that calls get_current, which then calls
>current_thread_info to get the task structure.
>
>Now current_thread_info is
>
>/* how to get the thread information struct from C */
>static inline struct thread_info *current_thread_info(void)
>{
>	struct thread_info *ti;
>	__asm__("andl %%esp,%0; ":"=r" (ti) : "0" (~(THREAD_SIZE - 1)));
>	return ti;
>}
>
>
>Where THREAD_SIZE is really the size of the kernel stack:
>
>#ifdef CONFIG_4KSTACKS
>#define THREAD_SIZE            (4096)
>#else
>#define THREAD_SIZE		(8192)
>#endif
>
>4K when CONFIG_4KSTACKS is defined, and 8K otherwise.  Since 4K is half of
>8K (obviously) you need to be more carefull not to overflow the stack.  So
>to help with this, we give interrupts there own stacks.  When
>CONFIG_4KSTACKS is _not_ defined, interrupts just use the stack of the
>current running thread.
>
>So the thread_info is really just placed on the bottom (or top, depending
>on your view of where things get added).  This memory used for the stack
>is _always_ page aligned and always a multiple of pages. So the kernel
>takes advantage of this. By placing the thread_info at the bottom of the
>stack, you only need to mask off the bits on the stack pointer to find the
>thread_info.
>
>  
>
>>    In passing, How 'current' work in this case when we disable 4KSTACK?
>>I just found these code only be compiled when we define CONFIG_4KSTACK,
>>but cann't found #else branch relevantly.
>>
>>    
>>
>
>You don't need to do this copy when CONFIG_4KSTACKS is not defined,
>because it is already there.  Since the thread_info is on the threads
>stack, and the interrupts also use the current thread's stack (when
>CONFIG_4KSTACKS is not defined), there's no need to copy.
>
>Now when you do define CONFIG_4KSTACKS, which make the interrupts use
>their own stack, you must copy the thread_info to the interrupt stack
>otherwise current will not work for interrupts.
>
>-- Steve
>
>  
>
Hi, Steve:

    I read carefully code about it in arch/i386/kernel/irq.c. Follow is
my understand on it:

    When we disabled/undefined CONFIG_4KSTACK, IOW, we use more bigger 
kernel stack,
the interrupt handler will use kernel stack of current task quietly at 
this time,
elsewise, the the interrupt handler will use 
&hardirq_stack[current_cpu_num*THREAD_SIZE]
as its kernel stack, and beacause of interrupt is disabled when one 
interrupt is
handling (on i386 architecture at least), so although this kernel stack 
of interrupt is
static allocated, we still do not need care we only have one this stack.

    Of course, our kernel stack at all time is page aligned. so current 
macro can work
normally.

    While I already thanks Steve N times :) , I still send my thanks to 
him again.

-liyu


