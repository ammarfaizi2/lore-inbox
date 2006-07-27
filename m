Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751944AbWG0SwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751944AbWG0SwP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 14:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbWG0SwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 14:52:15 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:58534 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751944AbWG0SwO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 14:52:14 -0400
Subject: [PATCH] acpi: Add lock annotations to acpi_os_acquire_lock and
	acpi_os_release_lock
From: Josh Triplett <josht@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Len Brown <len.brown@intel.com>,
       linux-acpi@vger.kernel.org
Content-Type: text/plain
Date: Thu, 27 Jul 2006 11:52:15 -0700
Message-Id: <1154026335.12517.111.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

acpi_os_acquire_lock acquires an acpi_spinlock (AKA spinlock_t *), and
acpi_os_release_lock releases it.  Add lock annotations to these two functions
so that sparse can check callers for lock pairing, and so that sparse will not
complain about these functions since they intentionally use locks in this
manner.  Since some of these annotations fall in OS-independent header files,
modify the OS abstraction layer to define empty macros for __acquires and
__releases if not already defined.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 drivers/acpi/osl.c      |    2 ++
 include/acpi/acpiosxf.h |    6 ++++--
 include/acpi/actypes.h  |   10 ++++++++++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index b7d1514..d042862 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -994,6 +994,7 @@ EXPORT_SYMBOL(max_cstate);
  */
 
 acpi_cpu_flags acpi_os_acquire_lock(acpi_spinlock lockp)
+	__acquires(*lockp)
 {
 	acpi_cpu_flags flags;
 	spin_lock_irqsave(lockp, flags);
@@ -1005,6 +1006,7 @@ acpi_cpu_flags acpi_os_acquire_lock(acpi
  */
 
 void acpi_os_release_lock(acpi_spinlock lockp, acpi_cpu_flags flags)
+	__releases(*lockp)
 {
 	spin_unlock_irqrestore(lockp, flags);
 }
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index 0cd63bc..f7b391e 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -102,9 +102,11 @@ acpi_status acpi_os_create_lock(acpi_spi
 
 void acpi_os_delete_lock(acpi_spinlock handle);
 
-acpi_cpu_flags acpi_os_acquire_lock(acpi_spinlock handle);
+acpi_cpu_flags acpi_os_acquire_lock(acpi_spinlock handle)
+	__acquires(*handle);
 
-void acpi_os_release_lock(acpi_spinlock handle, acpi_cpu_flags flags);
+void acpi_os_release_lock(acpi_spinlock handle, acpi_cpu_flags flags)
+	__releases(*handle);
 
 /*
  * Semaphore primitives
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 64b603c..d13352f 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -261,6 +261,16 @@ #ifndef acpi_spinlock
 #define acpi_spinlock                   void *
 #endif
 
+/* Macros providing lock annotations for static analysis tools */
+
+#ifndef __acquires
+#define __acquires(x)
+#endif
+
+#ifndef __releases
+#define __releases(x)
+#endif
+
 /* Flags for acpi_os_acquire_lock/acpi_os_release_lock */
 
 #ifndef acpi_cpu_flags


