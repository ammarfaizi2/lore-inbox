Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbVJQJBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbVJQJBL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 05:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbVJQJBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 05:01:10 -0400
Received: from [210.76.114.20] ([210.76.114.20]:56973 "EHLO ccoss.com.cn")
	by vger.kernel.org with ESMTP id S932174AbVJQJBK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 05:01:10 -0400
Message-ID: <43536892.9070607@ccoss.com.cn>
Date: Mon, 17 Oct 2005 17:02:10 +0800
From: liyu <liyu@ccoss.com.cn>
Reply-To: liyu@ccoss.com.cn
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: zh-cn,zh
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Question] one question about 'current' in scheduler_tick()
References: <43535B35.5020603@ccoss.com.cn> <Pine.LNX.4.58.0510170416090.5859@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.58.0510170416090.5859@localhost.localdomain>
Content-Type: text/plain; charset=gb18030; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:

>Hi Liyu (once again :-)
>
>On Mon, 17 Oct 2005, liyu wrote:
>
>  
>
>>Hi, All.
>>
>>    I found scheduler_tick() use current macro to get task_struct of
>>current task.
>>
>>    I seen scheduler_tick() is called every timer interrupt at most
>>time. In this
>>case, I think scheduler_tick() is in interrupt context (enter kernel by
>>interrupt),
>>    
>>
>
>Yes, scheduler_tick is called from interrupt context.
>
>  
>
>>So I have a hunch that there have not thread_info which it need in
>>kernel stack. But
>>It seem it can work perfectly.
>>    
>>
>
>Although it is said that you can't access user memory from an interrupt
>context, the reasons are simple.  One, most user memory access can
>schedule, and an interrupt service routine must not schedule. Also, an
>interrupt service routine can happen on any thread, so you can't be sure
>what thread is there.
>
>But, when an interrupt goes off, whatever thread is running is still
>there.  The thread's context _is_ still there.  The changing to the
>interrupt stack takes special care to make sure that current still works.
>So a copy of the thread_info is also done. Look in the do_IRQ in
>arch/i386/kernel/irq.c and search for 4KSTACKS.  You will see there the
>copying of thread_info.
>
>  
>
>>    I can not understand this. Would any expert like explain clearly for
>>it ?
>>
>>    
>>
>
>Hope this helps,
>
>-- Steve
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>
Hi Steve, Thanks once again :)

    I searched arch/i386/kernel/irq.c, and got this line of code:

    irqctx->tinfo.task = curctx->tinfo.task;

    I think it just is answer that I want to get. It seem interrupt 
stack is
created at top of the original kernel stack. Are my words right?

    In passing, How 'current' work in this case when we disable 4KSTACK?
I just found these code only be compiled when we define CONFIG_4KSTACK,
but cann't found #else branch relevantly.

   
-liyu






