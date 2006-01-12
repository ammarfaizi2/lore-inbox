Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbWALRRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbWALRRz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 12:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbWALRRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 12:17:54 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:57566 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S932315AbWALRRv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 12:17:51 -0500
Date: Thu, 12 Jan 2006 18:16:57 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 8/13] s390: spinlock fixes.
Message-ID: <20060112171657.GI16629@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[patch 8/13] s390: spinlock fixes.

Remove useless spin_retry_counter and fix compilation for UP kernels.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

---

 arch/s390/lib/Makefile   |    3 ++-
 arch/s390/lib/spinlock.c |    7 -------
 kernel/sysctl.c          |    2 +-
 3 files changed, 3 insertions(+), 9 deletions(-)

diff -urpN linux-2.6/arch/s390/lib/Makefile linux-2.6-patched/arch/s390/lib/Makefile
--- linux-2.6/arch/s390/lib/Makefile	2006-01-12 15:43:19.000000000 +0100
+++ linux-2.6-patched/arch/s390/lib/Makefile	2006-01-12 15:43:58.000000000 +0100
@@ -4,5 +4,6 @@
 
 EXTRA_AFLAGS := -traditional
 
-lib-y += delay.o string.o spinlock.o
+lib-y += delay.o string.o
 lib-y += $(if $(CONFIG_64BIT),uaccess64.o,uaccess.o)
+lib-$(CONFIG_SMP) += spinlock.o
\ No newline at end of file
diff -urpN linux-2.6/arch/s390/lib/spinlock.c linux-2.6-patched/arch/s390/lib/spinlock.c
--- linux-2.6/arch/s390/lib/spinlock.c	2006-01-12 15:43:19.000000000 +0100
+++ linux-2.6-patched/arch/s390/lib/spinlock.c	2006-01-12 15:43:58.000000000 +0100
@@ -13,7 +13,6 @@
 #include <linux/init.h>
 #include <asm/io.h>
 
-atomic_t spin_retry_counter;
 int spin_retry = 1000;
 
 /**
@@ -45,7 +44,6 @@ _raw_spin_lock_wait(raw_spinlock_t *lp, 
 			_diag44();
 			count = spin_retry;
 		}
-		atomic_inc(&spin_retry_counter);
 		if (_raw_compare_and_swap(&lp->lock, 0, pc) == 0)
 			return;
 	}
@@ -58,7 +56,6 @@ _raw_spin_trylock_retry(raw_spinlock_t *
 	int count = spin_retry;
 
 	while (count-- > 0) {
-		atomic_inc(&spin_retry_counter);
 		if (_raw_compare_and_swap(&lp->lock, 0, pc) == 0)
 			return 1;
 	}
@@ -77,7 +74,6 @@ _raw_read_lock_wait(raw_rwlock_t *rw)
 			_diag44();
 			count = spin_retry;
 		}
-		atomic_inc(&spin_retry_counter);
 		old = rw->lock & 0x7fffffffU;
 		if (_raw_compare_and_swap(&rw->lock, old, old + 1) == old)
 			return;
@@ -92,7 +88,6 @@ _raw_read_trylock_retry(raw_rwlock_t *rw
 	int count = spin_retry;
 
 	while (count-- > 0) {
-		atomic_inc(&spin_retry_counter);
 		old = rw->lock & 0x7fffffffU;
 		if (_raw_compare_and_swap(&rw->lock, old, old + 1) == old)
 			return 1;
@@ -111,7 +106,6 @@ _raw_write_lock_wait(raw_rwlock_t *rw)
 			_diag44();
 			count = spin_retry;
 		}
-		atomic_inc(&spin_retry_counter);
 		if (_raw_compare_and_swap(&rw->lock, 0, 0x80000000) == 0)
 			return;
 	}
@@ -124,7 +118,6 @@ _raw_write_trylock_retry(raw_rwlock_t *r
 	int count = spin_retry;
 
 	while (count-- > 0) {
-		atomic_inc(&spin_retry_counter);
 		if (_raw_compare_and_swap(&rw->lock, 0, 0x80000000) == 0)
 			return 1;
 	}
diff -urpN linux-2.6/kernel/sysctl.c linux-2.6-patched/kernel/sysctl.c
--- linux-2.6/kernel/sysctl.c	2006-01-12 15:43:35.000000000 +0100
+++ linux-2.6-patched/kernel/sysctl.c	2006-01-12 15:43:58.000000000 +0100
@@ -648,7 +648,7 @@ static ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
 	},
-#if defined(CONFIG_S390)
+#if defined(CONFIG_S390) && defined(CONFIG_SMP)
 	{
 		.ctl_name	= KERN_SPIN_RETRY,
 		.procname	= "spin_retry",
