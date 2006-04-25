Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751604AbWDYQjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604AbWDYQjk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 12:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751601AbWDYQjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 12:39:36 -0400
Received: from www.osadl.org ([213.239.205.134]:47488 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751587AbWDYQjM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 12:39:12 -0400
Message-Id: <20060425162421.149115000@localhost.localdomain>
References: <20060425162414.896662000@localhost.localdomain>
Date: Tue, 25 Apr 2006 16:41:06 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Subject: [patch 2/4] futex-pi: Enforce waiter bit when owner died is detected
Content-Disposition: inline; filename=futex-pi-enforce-waiter-bit.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Enforce the waiter bit to be set, when the previous owner has died. This
simplifies the glibc handling of the possible race from userspace tasks
which try to get hold of the lock and cleanup the mess which was leftover
by the unexpectedly died previous owner.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

 kernel/futex.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

Index: linux-2.6.17-rc1-mm3/kernel/futex.c
===================================================================
--- linux-2.6.17-rc1-mm3.orig/kernel/futex.c
+++ linux-2.6.17-rc1-mm3/kernel/futex.c
@@ -1161,11 +1161,16 @@ static int futex_lock_pi(u32 __user *uad
 		 * failed. When the OWNER_DIED bit is set, then we
 		 * know that this is a robust futex and we actually
 		 * take the lock. This is safe as we are protected by
-		 * the hash bucket lock.
+		 * the hash bucket lock. We also set the waiters bit
+		 * unconditionally here, to simplify glibc handling of
+		 * multiple tasks racing to acquire the lock and
+		 * cleanup the problems which were left by the dead
+		 * owner.
 		 */
 		if (curval & FUTEX_OWNER_DIED) {
 			uval = newval;
-			newval = current->pid | FUTEX_OWNER_DIED;
+			newval = current->pid |
+				FUTEX_OWNER_DIED | FUTEX_WAITERS;
 
 			inc_preempt_count();
 			curval = futex_atomic_cmpxchg_inatomic(uaddr,

--

