Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161027AbWCCSyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161027AbWCCSyr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 13:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161029AbWCCSyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 13:54:47 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:17790 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1161027AbWCCSyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 13:54:46 -0500
Date: Fri, 3 Mar 2006 19:54:54 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, ehrhardt@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 1/2] s390: Increase spinlock retry code performance.
Message-ID: <20060303185454.GA16574@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Ehrhardt <ehrhardt@de.ibm.com>

[patch 1/2] s390: Increase spinlock retry code performance.

Currently the code tries up to spin_retry times to grab a lock using the cs
instruction. The cs instruction has exclusive access to a memory region and
therefore invalidates the appropiate cache line of all other cpus. If there
is contention on a lock this leads to cache line trashing.
This can be avoided if we first check wether a cs instruction is likely to
succeed before the instruction gets actually executed.

Signed-off-by: Christian Ehrhardt <ehrhardt@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/lib/spinlock.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff -urpN linux-2.6/arch/s390/lib/spinlock.c linux-2.6-patched/arch/s390/lib/spinlock.c
--- linux-2.6/arch/s390/lib/spinlock.c	2006-03-03 18:52:23.000000000 +0100
+++ linux-2.6-patched/arch/s390/lib/spinlock.c	2006-03-03 18:53:20.000000000 +0100
@@ -2,8 +2,7 @@
  *  arch/s390/lib/spinlock.c
  *    Out of line spinlock code.
  *
- *  S390 version
- *    Copyright (C) 2004 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ *    Copyright (C) IBM Corp. 2004, 2006
  *    Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com)
  */
 
@@ -44,6 +43,8 @@ _raw_spin_lock_wait(raw_spinlock_t *lp, 
 			_diag44();
 			count = spin_retry;
 		}
+		if (__raw_spin_is_locked(lp))
+			continue;
 		if (_raw_compare_and_swap(&lp->lock, 0, pc) == 0)
 			return;
 	}
@@ -56,6 +57,8 @@ _raw_spin_trylock_retry(raw_spinlock_t *
 	int count = spin_retry;
 
 	while (count-- > 0) {
+		if (__raw_spin_is_locked(lp))
+			continue;
 		if (_raw_compare_and_swap(&lp->lock, 0, pc) == 0)
 			return 1;
 	}
@@ -74,6 +77,8 @@ _raw_read_lock_wait(raw_rwlock_t *rw)
 			_diag44();
 			count = spin_retry;
 		}
+		if (!__raw_read_can_lock(rw))
+			continue;
 		old = rw->lock & 0x7fffffffU;
 		if (_raw_compare_and_swap(&rw->lock, old, old + 1) == old)
 			return;
@@ -88,6 +93,8 @@ _raw_read_trylock_retry(raw_rwlock_t *rw
 	int count = spin_retry;
 
 	while (count-- > 0) {
+		if (!__raw_read_can_lock(rw))
+			continue;
 		old = rw->lock & 0x7fffffffU;
 		if (_raw_compare_and_swap(&rw->lock, old, old + 1) == old)
 			return 1;
@@ -106,6 +113,8 @@ _raw_write_lock_wait(raw_rwlock_t *rw)
 			_diag44();
 			count = spin_retry;
 		}
+		if (!__raw_write_can_lock(rw))
+			continue;
 		if (_raw_compare_and_swap(&rw->lock, 0, 0x80000000) == 0)
 			return;
 	}
@@ -118,6 +127,8 @@ _raw_write_trylock_retry(raw_rwlock_t *r
 	int count = spin_retry;
 
 	while (count-- > 0) {
+		if (!__raw_write_can_lock(rw))
+			continue;
 		if (_raw_compare_and_swap(&rw->lock, 0, 0x80000000) == 0)
 			return 1;
 	}
