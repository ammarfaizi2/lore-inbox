Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292730AbSDDS2d>; Thu, 4 Apr 2002 13:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292855AbSDDS2X>; Thu, 4 Apr 2002 13:28:23 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:38128 "EHLO
	e31.esmtp.ibm.com") by vger.kernel.org with ESMTP
	id <S292730AbSDDS2K>; Thu, 4 Apr 2002 13:28:10 -0500
Message-ID: <3CAC9B32.2050000@us.ibm.com>
Date: Thu, 04 Apr 2002 10:28:02 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: torvalds@transmeta.com
CC: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org,
        Robert Love <rml@tech9.net>
Subject: Re: Patch: linux-2.5.8-pre1/kernel/exit.c change caused BUG() at
 boot time
In-Reply-To: <20020404035910.A281@baldur.yggdrasil.com> <3CAC7E15.203@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------090400030103000901010304"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090400030103000901010304
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

David C. Hansen wrote:
> Adam J. Richter wrote:
>> The was a small change to to kernel/exit.c
>> in 2.5.8-pre1 which deleted a kernel_lock() call.  Restoring that line
>> resulted in a kernel that booted fine.
>>
> I take it you don't have a copy of the BUG().   I was going to ask if 
> preemption was enabled, but I see that it was from another message.  I 
> was guessing that preemption contributed to this, but now I know.  The 
> lock_kernel() has 2 different effects here.  It locks the kernel_flag, 
> AND it disables preemption.  The correct fix here will probably be to 
> disable preemption, rather than readd the lock_kernel(). 

I've replicated the problem too.
I've diabled preemption in the area where it used to be disabled because 
of the old lock_kernel().  I'm sending this message from a machine with 
that patch applied, so the patch does fix it.  As the comment says, this 
is something that the preempt experts need to take a look at.
Linus, this is a hack, and there is probably still a window where 
preemption can happen.  But, it is a band-aid until we find the real 
problem.


-- 
Dave Hansen
haveblue@us.ibm.com

--------------090400030103000901010304
Content-Type: text/plain;
 name="do_exit-add_preempt_disable.2.5.8-pre1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="do_exit-add_preempt_disable.2.5.8-pre1.patch"

--- linux-2.5.8-pre1-clean/kernel/exit.c	Thu Apr  4 08:58:31 2002
+++ linux/kernel/exit.c	Thu Apr  4 10:19:37 2002
@@ -499,6 +499,11 @@
 	acct_process(code);
 	__exit_mm(tsk);
 
+	/* I removed the lock_kernel() from here.  It caused preempt kernels
+	   to oops.  This fixes it for now, but the real cause needs to 
+	   be found.  
+           - Dave Hansen <haveblue@us.ibm.com> 04-04-2002 */
+	preempt_disable();
 	sem_exit();
 	__exit_files(tsk);
 	__exit_fs(tsk);
@@ -515,6 +520,7 @@
 
 	tsk->exit_code = code;
 	exit_notify();
+	preempt_enable_no_resched(); /* partner of above preempt_disable(); */
 	schedule();
 	BUG();
 /*

--------------090400030103000901010304--

