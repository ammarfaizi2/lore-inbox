Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964807AbVLPXNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbVLPXNZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 18:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932564AbVLPXNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 18:13:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:31964 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932560AbVLPXNX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 18:13:23 -0500
Date: Fri, 16 Dec 2005 23:13:07 GMT
Message-Id: <200512162313.jBGND7m0019625@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 2/12]: MUTEX: Provide SWAP-based mutex for FRV
In-Reply-To: <dhowells1134774786@warthog.cambridge.redhat.com>
References: <dhowells1134774786@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch permits the FRV architecture to make use of the xchg()
based mutex, overriding the use of xchg() with something based on the FRV
SWAP/SWAPI atomic op instructions. Note that xchg() in FRV is not actually
based on SWAP/SWAPI at the moment.

The patch also renames DECLARE_MUTEX*() for this arch to DECLARE_SEM_MUTEX*().

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 mutex-frv-2615rc5-2.diff
 arch/frv/Kconfig         |    4 ++++
 arch/frv/kernel/irq.c    |    2 +-
 include/asm-frv/system.h |   19 +++++++++++++++++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff -uNrp linux-2.6.15-rc5/arch/frv/Kconfig linux-2.6.15-rc5-mutex/arch/frv/Kconfig
--- linux-2.6.15-rc5/arch/frv/Kconfig	2005-08-30 13:56:10.000000000 +0100
+++ linux-2.6.15-rc5-mutex/arch/frv/Kconfig	2005-12-16 17:40:50.000000000 +0000
@@ -10,6 +10,10 @@ config UID16
 	bool
 	default y
 
+config ARCH_XCHG_MUTEX
+	bool
+	default y
+
 config RWSEM_GENERIC_SPINLOCK
 	bool
 	default y
diff -uNrp linux-2.6.15-rc5/include/asm-frv/system.h linux-2.6.15-rc5-mutex/include/asm-frv/system.h
--- linux-2.6.15-rc5/include/asm-frv/system.h	2005-06-22 13:52:26.000000000 +0100
+++ linux-2.6.15-rc5-mutex/include/asm-frv/system.h	2005-12-16 21:43:32.000000000 +0000
@@ -99,6 +99,25 @@ do {							\
 	((__get_PSR() & PSR_PIL) >= PSR_PIL_14)
 
 /*
+ * mutex implementation
+ */
+#define __mutex_trylock(mutex)					\
+({								\
+	int oldstate;						\
+								\
+	asm volatile("swap%I0 %M0,%1"				\
+		     : "+m"(mutex->state), "=r"(oldstate)	\
+		     : "1"(1)					\
+		     : "memory");				\
+								\
+	oldstate == 0;						\
+})
+
+#define __mutex_release(mutex)	do { (mutex)->state = 0; } while(0)
+
+#define mutex_is_locked(mutex)	((mutex)->state)
+
+/*
  * Force strict CPU ordering.
  */
 #define nop()			asm volatile ("nop"::)
diff -uNrp linux-2.6.15-rc5/arch/frv/kernel/irq.c linux-2.6.15-rc5-mutex/arch/frv/kernel/irq.c
--- linux-2.6.15-rc5/arch/frv/kernel/irq.c	2005-03-02 12:07:44.000000000 +0000
+++ linux-2.6.15-rc5-mutex/arch/frv/kernel/irq.c	2005-12-15 17:14:56.000000000 +0000
@@ -503,7 +503,7 @@ void free_irq(unsigned int irq, void *de
  * unassigned IRQ will cause GxICR_DETECT to be set
  */
 
-static DECLARE_MUTEX(probe_sem);
+static DECLARE_SEM_MUTEX(probe_sem);
 
 /**
  *	probe_irq_on	- begin an interrupt autodetect
