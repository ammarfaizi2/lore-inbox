Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbWBFVWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWBFVWw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 16:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbWBFVWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 16:22:52 -0500
Received: from mail.suse.de ([195.135.220.2]:17629 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932127AbWBFVWu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 16:22:50 -0500
From: Andi Kleen <ak@suse.de>
To: torvalds@osdl.org
Subject: [PATCH] Prevent spinlock debug from timing out too early
Date: Mon, 6 Feb 2006 22:16:28 +0100
User-Agent: KMail/1.8.2
Cc: mingo@elte.hu, akpm@osdl.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602062216.28943.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In modern Linux loops_per_jiffie doesn't have much relationship to how
fast the CPU can really execute loops because delay works in a different way. 
Unfortunately the spinlock debugging code used it for that, which
caused it it time timeout much earlier that a second.

A second is quite a long time for a spinlock, but there are situations
that can hold them quite long (debug output over slow serial
line, SCSI driver in recovery etc.), so it's better to not time out
too early.

This patch changes it to use jiffies to check for the timeout.
It has the small drawback over the previous case that if jiffies 
doesn't tick anymore you won't get any timed out spinlocks, but 
normally NMI watchdog should catch that anyways.

Signed-off-by:  Andi Kleen <ak@suse.de>

Index: linux-2.6.15/lib/spinlock_debug.c
===================================================================
--- linux-2.6.15.orig/lib/spinlock_debug.c
+++ linux-2.6.15/lib/spinlock_debug.c
@@ -68,13 +68,13 @@ static inline void debug_spin_unlock(spi
 static void __spin_lock_debug(spinlock_t *lock)
 {
 	int print_once = 1;
-	u64 i;
 
 	for (;;) {
-		for (i = 0; i < loops_per_jiffy * HZ; i++) {
-			cpu_relax();
+		unsigned long timeout = jiffies + HZ;
+		while (time_before(jiffies, timeout)) {
 			if (__raw_spin_trylock(&lock->raw_lock))
 				return;
+			cpu_relax();
 		}
 		/* lockup suspected: */
 		if (print_once) {
