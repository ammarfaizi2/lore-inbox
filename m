Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129461AbRBRWyI>; Sun, 18 Feb 2001 17:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129563AbRBRWx6>; Sun, 18 Feb 2001 17:53:58 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11021 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129461AbRBRWxm>;
	Sun, 18 Feb 2001 17:53:42 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200102182253.f1IMrHp17404@flint.arm.linux.org.uk>
Subject: Re: kernel_thread() & thread starting
To: kenn@linux.ie (Kenn Humborg)
Date: Sun, 18 Feb 2001 22:53:16 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux-Kernel)
In-Reply-To: <20010218222416.D22176@excalibur.research.wombat.ie> from "Kenn Humborg" at Feb 18, 2001 10:24:16 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kenn Humborg writes:
> When starting bdflush and kupdated, bdflush_init() uses a semaphore to
> make sure that the threads have run before continuing.  Shouldn't
> start_context_thread() do something similar?

I think this would be a good idea.  Here is a patch to try.  Please report
back if it works so that it can be forwarded to Linus.  Thanks.

--- orig/kernel/context.c	Tue Jan 30 13:31:11 2001
+++ linux/kernel/context.c	Sun Feb 18 22:51:56 2001
@@ -63,7 +63,7 @@
 	return ret;
 }
 
-static int context_thread(void *dummy)
+static int context_thread(void *sem)
 {
 	struct task_struct *curtask = current;
 	DECLARE_WAITQUEUE(wait, curtask);
@@ -79,6 +79,8 @@
 	recalc_sigpending(curtask);
 	spin_unlock_irq(&curtask->sigmask_lock);
 
+	up((struct semaphore *)sem);
+
 	/* Install a handler so SIGCLD is delivered */
 	sa.sa.sa_handler = SIG_IGN;
 	sa.sa.sa_flags = 0;
@@ -148,7 +150,9 @@
 	
 int start_context_thread(void)
 {
-	kernel_thread(context_thread, NULL, CLONE_FS | CLONE_FILES);
+	DECLARE_MUTEX_LOCKED(sem);
+	kernel_thread(context_thread, &sem, CLONE_FS | CLONE_FILES);
+	down(&sem);
 	return 0;
 }
 


--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

