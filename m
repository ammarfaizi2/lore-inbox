Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbUFBKxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbUFBKxI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 06:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbUFBKwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 06:52:34 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:53425 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S261745AbUFBKwQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 06:52:16 -0400
Date: Wed, 2 Jun 2004 12:52:20 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (1/4): core s390.
Message-ID: <20040602105220.GB7108@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: core changes.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

s390 core changes:
 - Make use of the ipte instruction for ptep_set_access_flags
 - Fix atomic64_inc_and_test primitive as well.
 - Fix return type handler for __copy_in_user.
 - New default configuration.

diffstat:
 arch/s390/defconfig        |    9 +++------
 include/asm-s390/atomic.h  |    2 +-
 include/asm-s390/pgtable.h |    4 ++++
 include/asm-s390/uaccess.h |    4 ++--
 4 files changed, 10 insertions(+), 9 deletions(-)

diff -urN linux-2.6/arch/s390/defconfig linux-2.6-s390/arch/s390/defconfig
--- linux-2.6/arch/s390/defconfig	Wed Jun  2 11:29:01 2004
+++ linux-2.6-s390/arch/s390/defconfig	Wed Jun  2 11:29:25 2004
@@ -28,6 +28,7 @@
 CONFIG_IKCONFIG_PROC=y
 # CONFIG_EMBEDDED is not set
 CONFIG_KALLSYMS=y
+# CONFIG_KALLSYMS_ALL is not set
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_IOSCHED_NOOP=y
@@ -112,7 +113,6 @@
 # Some SCSI devices (e.g. CD jukebox) support multiple LUNs
 #
 CONFIG_SCSI_MULTI_LUN=y
-# CONFIG_SCSI_REPORT_LUNS is not set
 CONFIG_SCSI_CONSTANTS=y
 CONFIG_SCSI_LOGGING=y
 
@@ -126,6 +126,7 @@
 # SCSI low-level drivers
 #
 # CONFIG_SCSI_AIC7XXX_OLD is not set
+# CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_SCSI_SATA is not set
 # CONFIG_SCSI_EATA_PIO is not set
 # CONFIG_SCSI_DEBUG is not set
@@ -310,11 +311,7 @@
 # CONFIG_MII is not set
 
 #
-# Ethernet (1000 Mbit)
-#
-
-#
-# Ethernet (10000 Mbit)
+# Gigabit Ethernet (1000/10000 Mbit)
 #
 
 #
diff -urN linux-2.6/include/asm-s390/atomic.h linux-2.6-s390/include/asm-s390/atomic.h
--- linux-2.6/include/asm-s390/atomic.h	Wed Jun  2 11:29:07 2004
+++ linux-2.6-s390/include/asm-s390/atomic.h	Wed Jun  2 11:29:25 2004
@@ -145,7 +145,7 @@
 }
 static __inline__ long long atomic64_inc_and_test(volatile atomic64_t * v)
 {
-	return __CSG_LOOP(v, 1, "agr") != 0;
+	return __CSG_LOOP(v, 1, "agr") == 0;
 }
 static __inline__ void atomic64_dec(volatile atomic64_t * v)
 {
diff -urN linux-2.6/include/asm-s390/pgtable.h linux-2.6-s390/include/asm-s390/pgtable.h
--- linux-2.6/include/asm-s390/pgtable.h	Wed Jun  2 11:29:08 2004
+++ linux-2.6-s390/include/asm-s390/pgtable.h	Wed Jun  2 11:29:25 2004
@@ -587,6 +587,9 @@
 	set_pte(ptep, entry);
 }
 
+#define ptep_set_access_flags(__vma, __address, __ptep, __entry, __dirty) \
+	ptep_establish(__vma, __address, __ptep, __entry)
+
 /*
  * Test and clear dirty bit in storage key.
  * We can't clear the changed bit atomically. This is a potential
@@ -784,6 +787,7 @@
 #define pgtable_cache_init()	do { } while (0)
 
 #define __HAVE_ARCH_PTEP_ESTABLISH
+#define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_DIRTY
diff -urN linux-2.6/include/asm-s390/uaccess.h linux-2.6-s390/include/asm-s390/uaccess.h
--- linux-2.6/include/asm-s390/uaccess.h	Wed Jun  2 11:29:08 2004
+++ linux-2.6-s390/include/asm-s390/uaccess.h	Wed Jun  2 11:29:25 2004
@@ -326,12 +326,12 @@
 	return n;
 }
 
-extern long __copy_in_user_asm(const void *from, long n, void *to);
+extern unsigned long __copy_in_user_asm(const void *from, long n, void *to);
 
 static inline unsigned long
 __copy_in_user(void __user *to, const void __user *from, unsigned long n)
 {
-	__copy_in_user_asm(from, n, to);
+	return __copy_in_user_asm(from, n, to);
 }
 
 static inline unsigned long
