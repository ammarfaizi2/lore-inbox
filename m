Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbVH2R5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbVH2R5O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 13:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbVH2R5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 13:57:13 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:49120 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751247AbVH2R5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 13:57:11 -0400
Date: Mon, 29 Aug 2005 19:57:06 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 9/10] s390: spinlock corner case.
Message-ID: <20050829175706.GI6796@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 9/10] s390: spinlock corner case.

From: Heiko Carstens <heiko.carstens@de.ibm.com>

On s390 the lock value used for spinlocks consists of the lower 32 bits
of the PSW that holds the lock. If this address happens to be on a four
gigabyte boundary the lock is left unlocked. This allows other cpus to
grab the same lock and enter a lock protected code path concurrently.
In theory this can happen if the vmalloc area for the code of a module
crosses a 4 GB boundary.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 include/asm-s390/spinlock.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -urpN linux-2.6/include/asm-s390/spinlock.h linux-2.6-patched/include/asm-s390/spinlock.h
--- linux-2.6/include/asm-s390/spinlock.h	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/spinlock.h	2005-08-29 19:18:12.000000000 +0200
@@ -47,7 +47,7 @@ extern int _raw_spin_trylock_retry(spinl
 
 static inline void _raw_spin_lock(spinlock_t *lp)
 {
-	unsigned long pc = (unsigned long) __builtin_return_address(0);
+	unsigned long pc = 1 | (unsigned long) __builtin_return_address(0);
 
 	if (unlikely(_raw_compare_and_swap(&lp->lock, 0, pc) != 0))
 		_raw_spin_lock_wait(lp, pc);
@@ -55,7 +55,7 @@ static inline void _raw_spin_lock(spinlo
 
 static inline int _raw_spin_trylock(spinlock_t *lp)
 {
-	unsigned long pc = (unsigned long) __builtin_return_address(0);
+	unsigned long pc = 1 | (unsigned long) __builtin_return_address(0);
 
 	if (likely(_raw_compare_and_swap(&lp->lock, 0, pc) == 0))
 		return 1;
