Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbWCLIqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbWCLIqh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 03:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbWCLIqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 03:46:36 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:53261 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750971AbWCLIqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 03:46:36 -0500
Date: Sun, 12 Mar 2006 09:46:32 +0100
From: Willy Tarreau <willy@w.ods.org>
To: James Yu <cyu021@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: weird behavior from kernel
Message-ID: <20060312084632.GB21493@w.ods.org>
References: <60bb95410603111923icba8adeid90c1dfa94f2e566@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60bb95410603111923icba8adeid90c1dfa94f2e566@mail.gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2006 at 11:23:17AM +0800, James Yu wrote:
> Hi folks,
> 
> I am modifying linux-2.4.18 for ARM (based on S3C2410), I enable only
> the timer interrupt and disable all the others in "init" thread before
> "execve("/sbin/init",argv_init,envp_init);" is taking place.
> I also create two kernel threads by invoking "kernel_thread" right
> after disbling the interrupts. This is how the kernel thread looks
> like:
> 
>         923 void eos_1(void)
> -       924 {
> |       925     DECLARE_WAITQUEUE(wait, current);
> |       926
> |       927     while (1)
> |-      928     {
> ||      929         printk("\n%s[%d], period:%d, deadline:%d, jiffies:%d.\n",
> ||      930                 current->comm, current->pid,
> current->period, current->deadline, jiffies);
> ||      931         eos_tail();
> ||      932     }
> |       933 }
> 
>         905 #define eos_tail() \
> -       906 do { \
> |       907     static int deadline = 0; \
> |       908     if ((current->deadline - jiffies) > 0) \
> |-      909     { \
> ||      910         deadline = current->deadline; \
> ||      911         current->deadline = deadline + current->period; \
> ||      912         sleep_on_timeout(&wait, (deadline - jiffies)); \
> ||      913     } \
> |       914     else \
> |-      915     { \
> ||      916         printk("\n!!! %s[%d] missed deadline !!!\n",
> current->comm, current->pid); \
> ||      917         return (0); \
> ||      918     } \
> |       919 } while(0)
> 
> Now I am trying to modify the "schedule" function. I insert the
> following segment into schedule function after the part that
> re-calculate counters --> if(unlikely(!c)).
> 
> |-      634         {
> ||      635             int latch = 0;
> ||      636
> ||      637             list_for_each(tmp, &runqueue_head)
> ||-     638             {
> |||     639                 //p = list_entry(tmp, struct task_struct, run_list);
> |||     640                 latch = latch + 1;
> |||     641             }
> ||      642             printk("{%d}", latch);
> ||      643         }
> 
> This is where weird thing happens! If I uncomment line 639, kernel
> complains that I am passing an illegal value into "sleep_on_timeout",
> which is called in my kernel thread inside "eos_tail". I copy both
> line 637 and 639 from schedule itself (they were used to pick next job
> to run).
> 
> I am simply doing copy & paste inside "schedule", can someone please
> tell me what is happening ?

It might be a wrong gcc optimization which generates bad code. If you're
working on such an old kernel (about 5 years old), maybe you're using
and old, broken compiler too ? gcc-2.95[.1], gcc-2.96, 3.0 and 3.1 have
been known to produce bad code for a long time. Also ensure that you
pass the "-fno-strength-reduce" option to gcc.

Anyway, if you're starting a new dev, I would suggest using a more
recent kernel : 2.6.1[56] or 2.4.32 if you need 2.4.

> Thanks a lot,
> --
> James
> cyu021@gmail.com

regards,
Willy

