Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263597AbTE0NxJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 09:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263600AbTE0NxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 09:53:09 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:37636 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S263597AbTE0NxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 09:53:07 -0400
Date: Tue, 27 May 2003 18:05:50 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: "T. Weyergraf" <kirk@colinet.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.70 dies on alpha-SMP
Message-ID: <20030527180550.B2292@jurassic.park.msu.ru>
References: <kirk-1030527151258.A0117853@hydra.colinet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <kirk-1030527151258.A0117853@hydra.colinet.de>; from kirk@colinet.de on Tue, May 27, 2003 at 03:12:58PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 03:12:58PM +0200, T. Weyergraf wrote:
> the stock 2.5.70 dies early upon boot on my alpha UP2000
> ( dual EV67, DP264 vector ). It happens, after the kernel
> tries to start the second CPU. The error happens regardless
> of the compilers i tried ( gcc 3.2.3 and 2.95.4 ).

Does this help?

Ivan.

--- 2.5/arch/alpha/kernel/smp.c	Wed May 21 15:20:27 2003
+++ linux/arch/alpha/kernel/smp.c	Wed May 21 15:27:23 2003
@@ -417,12 +417,7 @@ fork_by_hand(void)
 	/* Don't care about the contents of regs since we'll never
 	   reschedule the forked task. */
 	struct pt_regs regs;
-	int pid;
-	pid = do_fork(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0, NULL, NULL);
-	if (pid < 0)
-		return NULL;
-
-	return find_task_by_pid (pid);
+	return copy_process(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0, NULL, NULL);
 }
 
 /*
@@ -441,8 +436,10 @@ smp_boot_one_cpu(int cpuid)
 	   wish.  We can't use kernel_thread since we must avoid
 	   rescheduling the child.  */
 	idle = fork_by_hand();
-	if (!idle)
+	if (IS_ERR(idle))
 		panic("failed fork for CPU %d", cpuid);
+
+	wake_up_forked_process(idle);
 
 	init_idle(idle, cpuid);
 	unhash_process(idle);
