Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313318AbSDOWZE>; Mon, 15 Apr 2002 18:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313319AbSDOWZD>; Mon, 15 Apr 2002 18:25:03 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:30972 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S313318AbSDOWZD>; Mon, 15 Apr 2002 18:25:03 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15547.21305.584901.125769@wombat.chubb.wattle.id.au>
Date: Tue, 16 Apr 2002 08:24:57 +1000
To: mingo@redhat.com
CC: linux-kernel@vger.kernel.org
Subject: Remove a compilation warning in brlock.c
X-Mailer: VM 7.03 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
	Because the type of brlock_read_lock_t can vary depending on
whether SPINLOCK_DEBUG is defined, I suspect that the initialisation
of __brlock_array in lib/brlock.c is incorrect.

I suspect the initialisation in the __BRLOCK_USE_ATOMICS case whould
be to RW_LOCK_UNLOCKED, not zero.  Otherwise, nasty things will happen
-- and wakeups may be missed on i386 (the rwlock_t should be initialised to
-MAXINT-1 for i386, not zero, as the transition from negative->positive
is used to trigger wakeups.  Other architectures have other requirements)

--- /tmp/geta28567	Tue Apr 16 08:19:38 2002
+++ linux-2.5/lib/brlock.c	Tue Apr 16 08:16:22 2002
@@ -18,7 +18,7 @@
 #ifdef __BRLOCK_USE_ATOMICS
 
 brlock_read_lock_t __brlock_array[NR_CPUS][__BR_IDX_MAX] =
-   { [0 ... NR_CPUS-1] = { [0 ... __BR_IDX_MAX-1] = {0, 0} } };
+	{ [0 ... NR_CPUS-1] = { [0 ... __BR_IDX_MAX-1] = RW_LOCK_UNLOCKED } };
 
 void __br_write_lock (enum brlock_indices idx)
 {
