Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261979AbUK3Emg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbUK3Emg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 23:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261980AbUK3Emg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 23:42:36 -0500
Received: from ozlabs.org ([203.10.76.45]:60645 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261979AbUK3Emd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 23:42:33 -0500
Subject: [PATCH] Fix Occasional stop_machine() Lockup with > 2 CPUs
From: Rusty Russell <rusty@rustcorp.com.au>
To: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Srivatsa Vaddagiri <vatsa@in.ibm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Tue, 30 Nov 2004 15:42:30 +1100
Message-Id: <1101789751.14565.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Name: Fix Occasional stop_machine() Lockup
Status: Tested on 2.6.10-rc2-bk13
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

Stephen Rothwell noted a case where one CPU was sitting in userspace,
one in stop_machine() waiting for everyone to enter stopmachine().
This can happen if migration occurs at exactly the wrong time with
more than 2 CPUS.  Say we have 4 CPUS:

1) stop_machine() on CPU 0creates stopmachine() threads for CPUS 1, 2
   and 3, and yields waiting for them to migrate to their CPUs and
   ack.

2) stopmachine(2) gets rebalanced (probably on exec) to CPU 1.

3) stopmachine(2) calls set_cpus_allowed on CPU 1, sleeps awaiting
   migration thread.

4) stopmachine(1) calls set_cpus_allowed on CPU 0, moves onto CPU1 and
   starts spinning.

Now the migration thread never runs, and we deadlock.  The simplest
solution is for stopmachine() to yield until they are all in place.

Index: linux-2.6.10-rc2-bk13-Misc/kernel/stop_machine.c
===================================================================
--- linux-2.6.10-rc2-bk13-Misc.orig/kernel/stop_machine.c	2004-11-30 13:48:40.000000000 +1100
+++ linux-2.6.10-rc2-bk13-Misc/kernel/stop_machine.c	2004-11-30 14:07:00.089957464 +1100
@@ -52,7 +52,10 @@
 			mb(); /* Must read state first. */
 			atomic_inc(&stopmachine_thread_ack);
 		}
-		cpu_relax();
+		if (!prepared && !irqs_disabled)
+			yield();
+		else
+			cpu_relax();
 	}
 
 	/* Ack: we are exiting. */

-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

