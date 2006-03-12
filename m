Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751261AbWCLDXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbWCLDXS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 22:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbWCLDXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 22:23:18 -0500
Received: from xproxy.gmail.com ([66.249.82.198]:18050 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751261AbWCLDXS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 22:23:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=pmyCRzxgUkua6OzlN/JCcKKLXslYSWMxOaKWYxgeJXTm9i8dXoO2Ki9bk6om0ikhHgnRGzfnMnO+YneCaanhV0IOKc6ig1Vu95eeaufDpW2AMpqqBrLdO+RW42z96Wstmd/QlCwWnha2WkXDGNtc6QM7K1P3REeOXqY15aHOpfQ=
Message-ID: <60bb95410603111923icba8adeid90c1dfa94f2e566@mail.gmail.com>
Date: Sun, 12 Mar 2006 11:23:17 +0800
From: "James Yu" <cyu021@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: weird behavior from kernel
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I am modifying linux-2.4.18 for ARM (based on S3C2410), I enable only
the timer interrupt and disable all the others in "init" thread before
"execve("/sbin/init",argv_init,envp_init);" is taking place.
I also create two kernel threads by invoking "kernel_thread" right
after disbling the interrupts. This is how the kernel thread looks
like:

        923 void eos_1(void)
-       924 {
|       925     DECLARE_WAITQUEUE(wait, current);
|       926
|       927     while (1)
|-      928     {
||      929         printk("\n%s[%d], period:%d, deadline:%d, jiffies:%d.\n",
||      930                 current->comm, current->pid,
current->period, current->deadline, jiffies);
||      931         eos_tail();
||      932     }
|       933 }

        905 #define eos_tail() \
-       906 do { \
|       907     static int deadline = 0; \
|       908     if ((current->deadline - jiffies) > 0) \
|-      909     { \
||      910         deadline = current->deadline; \
||      911         current->deadline = deadline + current->period; \
||      912         sleep_on_timeout(&wait, (deadline - jiffies)); \
||      913     } \
|       914     else \
|-      915     { \
||      916         printk("\n!!! %s[%d] missed deadline !!!\n",
current->comm, current->pid); \
||      917         return (0); \
||      918     } \
|       919 } while(0)

Now I am trying to modify the "schedule" function. I insert the
following segment into schedule function after the part that
re-calculate counters --> if(unlikely(!c)).

|-      634         {
||      635             int latch = 0;
||      636
||      637             list_for_each(tmp, &runqueue_head)
||-     638             {
|||     639                 //p = list_entry(tmp, struct task_struct, run_list);
|||     640                 latch = latch + 1;
|||     641             }
||      642             printk("{%d}", latch);
||      643         }

This is where weird thing happens! If I uncomment line 639, kernel
complains that I am passing an illegal value into "sleep_on_timeout",
which is called in my kernel thread inside "eos_tail". I copy both
line 637 and 639 from schedule itself (they were used to pick next job
to run).

I am simply doing copy & paste inside "schedule", can someone please
tell me what is happening ?

Thanks a lot,
--
James
cyu021@gmail.com
