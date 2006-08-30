Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964770AbWH3EKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964770AbWH3EKi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 00:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964833AbWH3EKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 00:10:38 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:65516 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964770AbWH3EKi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 00:10:38 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: [patch 2.6.18-rc5] Make touch_nmi_watchdog fall back to touch_softlockup_watchdog
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 30 Aug 2006 14:10:26 +1000
Message-ID: <17651.1156911026@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some architectures define their own touch_nmi_watchdog and these all
include a call to touch_softlockup_watchdog.  Change all architectures
so touch_nmi_watchdog includes a call to touch_softlockup_watchdog, to
get a consistent soft watchdog state.

Also take the opportunity to kill ARCH_HAS_NMI_WATCHDOG.

Signed-off-by: Keith Owens <kaos@ocs.com.au>

---
 include/asm-i386/irq.h   |    2 +-
 include/asm-x86_64/irq.h |    2 +-
 include/linux/nmi.h      |    8 +++++---
 3 files changed, 7 insertions(+), 5 deletions(-)

Index: linux/include/asm-i386/irq.h
===================================================================
--- linux.orig/include/asm-i386/irq.h
+++ linux/include/asm-i386/irq.h
@@ -21,7 +21,7 @@ static __inline__ int irq_canonicalize(i
 }
 
 #ifdef CONFIG_X86_LOCAL_APIC
-# define ARCH_HAS_NMI_WATCHDOG		/* See include/linux/nmi.h */
+# define touch_nmi_watchdog touch_nmi_watchdog
 #endif
 
 #ifdef CONFIG_4KSTACKS
Index: linux/include/asm-x86_64/irq.h
===================================================================
--- linux.orig/include/asm-x86_64/irq.h
+++ linux/include/asm-x86_64/irq.h
@@ -45,7 +45,7 @@ static __inline__ int irq_canonicalize(i
 }
 
 #ifdef CONFIG_X86_LOCAL_APIC
-#define ARCH_HAS_NMI_WATCHDOG		/* See include/linux/nmi.h */
+# define touch_nmi_watchdog touch_nmi_watchdog
 #endif
 
 #ifdef CONFIG_HOTPLUG_CPU
Index: linux/include/linux/nmi.h
===================================================================
--- linux.orig/include/linux/nmi.h
+++ linux/include/linux/nmi.h
@@ -11,12 +11,14 @@
  * 
  * If the architecture supports the NMI watchdog, touch_nmi_watchdog()
  * may be used to reset the timeout - for code which intentionally
- * disables interrupts for a long time. This call is stateless.
+ * disables interrupts for a long time. This call is stateless.  For other
+ * architectures, fall back to touch_softlockup_watchdog, which may itself be a
+ * no-op.
  */
-#ifdef ARCH_HAS_NMI_WATCHDOG
+#ifdef touch_nmi_watchdog
 extern void touch_nmi_watchdog(void);
 #else
-# define touch_nmi_watchdog() do { } while(0)
+# define touch_nmi_watchdog() touch_softlockup_watchdog()
 #endif
 
 #endif

