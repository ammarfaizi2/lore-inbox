Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266139AbUAQSqu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 13:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266123AbUAQSoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 13:44:11 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:24485 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S266119AbUAQSns (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 13:43:48 -0500
Message-ID: <40098260.20800@colorfullife.com>
Date: Sat, 17 Jan 2004 19:43:44 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] remove sleep_on from sunrpc
Content-Type: multipart/mixed;
 boundary="------------080709000405040605080002"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080709000405040605080002
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

sunrpc uses sleep_on to wait until the rpciod thread has died. This
could race if rpciod_down is called without lock_kernel. Right now all
calls in the main tree are under lock_kernel, but rpciod is an exported
function and sleep_on should die.
Additionally, I've replaced spin_lock_irqsave() with spin_lock_irq():
rpciod_down sleeps, interrupts are guaranteed to be enabled.

--
        Manfred





--------------080709000405040605080002
Content-Type: text/plain;
 name="patch-sleep_on_sunrpc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-sleep_on_sunrpc"

--- 2.6/net/sunrpc/sched.c	2004-01-17 12:19:50.000000000 +0100
+++ build-2.6/net/sunrpc/sched.c	2004-01-17 12:52:33.000000000 +0100
@@ -1060,7 +1060,7 @@
 void
 rpciod_down(void)
 {
-	unsigned long flags;
+	DECLARE_WAITQUEUE(wait, current);
 
 	down(&rpciod_sema);
 	dprintk("rpciod_down pid %d sema %d\n", rpciod_pid, rpciod_users);
@@ -1085,17 +1085,22 @@
 	/*
 	 * Display a message if we're going to wait longer.
 	 */
-	while (rpciod_pid) {
+	add_wait_queue(&rpciod_killer, &wait);
+	for (;;) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (rpciod_pid == 0)
+			break;
 		dprintk("rpciod_down: waiting for pid %d to exit\n", rpciod_pid);
 		if (signalled()) {
 			dprintk("rpciod_down: caught signal\n");
 			break;
 		}
-		interruptible_sleep_on(&rpciod_killer);
+		schedule();
 	}
-	spin_lock_irqsave(&current->sighand->siglock, flags);
+	remove_wait_queue(&rpciod_killer, &wait);
+	spin_lock_irq(&current->sighand->siglock);
 	recalc_sigpending();
-	spin_unlock_irqrestore(&current->sighand->siglock, flags);
+	spin_unlock_irq(&current->sighand->siglock);
 out:
 	up(&rpciod_sema);
 }





--------------080709000405040605080002--

