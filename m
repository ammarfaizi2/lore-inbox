Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267809AbUGWP51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267809AbUGWP51 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 11:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267821AbUGWP5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 11:57:12 -0400
Received: from fmr06.intel.com ([134.134.136.7]:24707 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S267809AbUGWPlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 11:41:12 -0400
Date: Fri, 23 Jul 2004 08:49:31 -0700
From: inaky.perez-gonzalez@intel.com
To: linux-kernel@vger.kernel.org
Cc: inaky.perez-gonzalez@intel.com, robustmutexes@lists.osdl.org
Subject: [RFC/PATCH] FUSYN 9/11: Modifications to the core: basic
Message-ID: <0407230849.XbjdYbRaAasd1aIaAbkbWb3asaLdbaLb17066@intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <0407230849.WchaEbYd9c3cLaPbBdbaSa0awclaLcQa17066@intel.com>
X-Mailer: patchbomb 0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add list_replace() to list.h. Configuration stuff.


 include/linux/list.h |   27 +++++++++++++++++++++++++++
 init/Kconfig         |   40 ++++++++++++++++++++++++++++++++++++++++
 kernel/Makefile      |    4 ++++
 3 files changed, 71 insertions(+)

--- include/linux/list.h:1.1.1.7 Tue Apr 6 01:51:36 2004
+++ include/linux/list.h Wed May 12 00:28:11 2004
@@ -177,6 +177,33 @@
 }
 
 /**
+ * list_replace - replaces an entry with another one.
+ * @new: entry to replace with.
+ * @old: entry to replace.
+ */
+static inline
+void list_replace (struct list_head *new, struct list_head *old)
+{
+	old->prev->next = new;
+	new->prev = old->prev;
+	old->next->prev = new;
+	new->next = old->next;
+}
+
+/**
+ * list_replace - replaces an entry with another one, reinitializing
+ * the old one. 
+ * @new: entry to replace with.
+ * @old: entry to replace and reinitialize.
+ */
+static inline
+void list_replace_init (struct list_head *new, struct list_head *old)
+{
+	list_replace (new, old);
+	INIT_LIST_HEAD (old);
+}
+
+/**
  * list_move - delete from one list and add as another's head
  * @list: the entry to move
  * @head: the head that will precede our entry
--- init/Kconfig:1.1.1.12 Tue Apr 6 01:51:37 2004
+++ init/Kconfig Wed May 26 22:14:57 2004
@@ -206,6 +206,46 @@
 	  support for "fast userspace mutexes".  The resulting kernel may not
 	  run glibc-based applications correctly.
 
+config FUSYN
+	bool "Enable fusyn support" if EMBEDDED
+	default y
+	help
+	  Disabling this option will cause the kernel to be built without
+	  support for the fusyn synchronization infrastructure. This
+          means no support in the kernel for fuqueues (priority sorted
+          wait queues) nor fulocks (priority sorted, inheriting and/or
+          protected mutexes).
+
+config FULOCK
+	bool "Enable fulock support" if EMBEDDED && FUSYN
+	default y if FUSYN
+        default n
+	help
+	  Disabling this option will cause the kernel to be built without
+	  support for the fulocks of fusyn synchronization
+          infrastructure. This means no support in the kernel for
+          priority sorted, inheriting and/or protected mutexes.
+
+config UFUSYN
+	bool "Enable user-space fusyn support" if EMBEDDED && FUSYN
+	default y if FUSYN
+        default n
+	help
+	  Disabling this option will cause the kernel to be built without
+	  support for the user-space fusyn synchronization
+          infrastructure. This means that neither fuqueues nor fulocks
+          are available for user space to use them.
+
+config UFULOCK
+	bool "Enable user-space fulock support" if EMBEDDED && UFUSYN && FULOCK
+	default y if FULOCK
+        default n
+	help
+	  Disabling this option will cause the kernel to be built without
+	  support for the user-space fulocks of the fusyn
+          synchronization infrastructure. This means fulocks are not
+          available for user-space to use it.  mutexes.
+
 config EPOLL
 	bool "Enable eventpoll support" if EMBEDDED
 	default y
--- kernel/Makefile:1.1.1.10 Tue Apr 6 01:51:37 2004
+++ kernel/Makefile Wed May 26 22:14:57 2004
@@ -21,6 +21,10 @@
 obj-$(CONFIG_IKCONFIG) += configs.o
 obj-$(CONFIG_IKCONFIG_PROC) += configs.o
 obj-$(CONFIG_STOP_MACHINE) += stop_machine.o
+obj-$(CONFIG_FUSYN) += fuqueue.o
+obj-$(CONFIG_FULOCK) += fulock.o 
+obj-$(CONFIG_UFUSYN) += vlocator.o ufuqueue.o
+obj-$(CONFIG_UFULOCK) += ufulock.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
