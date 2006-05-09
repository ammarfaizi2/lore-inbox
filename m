Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751402AbWEIKxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbWEIKxu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 06:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbWEIKxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 06:53:50 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:64941 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751402AbWEIKxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 06:53:49 -0400
Date: Tue, 9 May 2006 12:53:49 +0200
From: Michael Holzheu <holzheu@de.ibm.com>
To: greg@kroah.com, akpm@osdl.org
Cc: ioe-lkml@rameria.de, joern@wohnheim.fh-wedel.de,
       linux-kernel@vger.kernel.org, mschwid2@de.ibm.com,
       penberg@cs.helsinki.fi
Subject: [PATCH 1/2] Add /sys/hypervisor
Message-Id: <20060509125349.72c974b2.holzheu@de.ibm.com>
Organization: IBM
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, Hi Andrew,

As discussed, here comes the final patch:

To have a home for all hypervisors, this patch
creates /sys/hypervisor.
A new config option SYS_HYPERVISOR is introduced,
which should to be set by architecture dependent
hypervisors (e.g. s390 or Xen).

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>

---

 drivers/base/Kconfig      |    4 ++++
 drivers/base/Makefile     |    1 +
 drivers/base/base.h       |    5 +++++
 drivers/base/hypervisor.c |   19 +++++++++++++++++++
 drivers/base/init.c       |    1 +
 include/linux/kobject.h   |    2 ++
 6 files changed, 32 insertions(+)

diff -urpN linux-2.6.17-rc3-mm1/drivers/base/Kconfig linux-2.6.17-rc3-mm1-sys-hypervisor/drivers/base/Kconfig
--- linux-2.6.17-rc3-mm1/drivers/base/Kconfig	2006-05-08 15:56:23.000000000 +0200
+++ linux-2.6.17-rc3-mm1-sys-hypervisor/drivers/base/Kconfig	2006-05-08 16:00:58.000000000 +0200
@@ -38,3 +38,7 @@ config DEBUG_DRIVER
 	  If you are unsure about this, say N here.
 
 endmenu
+
+config SYS_HYPERVISOR
+	bool
+	default n
diff -urpN linux-2.6.17-rc3-mm1/drivers/base/Makefile linux-2.6.17-rc3-mm1-sys-hypervisor/drivers/base/Makefile
--- linux-2.6.17-rc3-mm1/drivers/base/Makefile	2006-05-08 15:56:23.000000000 +0200
+++ linux-2.6.17-rc3-mm1-sys-hypervisor/drivers/base/Makefile	2006-05-08 16:00:41.000000000 +0200
@@ -9,6 +9,7 @@ obj-$(CONFIG_FW_LOADER)	+= firmware_clas
 obj-$(CONFIG_NUMA)	+= node.o
 obj-$(CONFIG_MEMORY_HOTPLUG) += memory.o
 obj-$(CONFIG_SMP)	+= topology.o
+obj-$(CONFIG_SYS_HYPERVISOR) += hypervisor.o
 
 ifeq ($(CONFIG_DEBUG_DRIVER),y)
 EXTRA_CFLAGS += -DDEBUG
diff -urpN linux-2.6.17-rc3-mm1/drivers/base/base.h linux-2.6.17-rc3-mm1-sys-hypervisor/drivers/base/base.h
--- linux-2.6.17-rc3-mm1/drivers/base/base.h	2006-05-08 15:57:02.000000000 +0200
+++ linux-2.6.17-rc3-mm1-sys-hypervisor/drivers/base/base.h	2006-05-09 10:18:06.000000000 +0200
@@ -5,6 +5,11 @@ extern int devices_init(void);
 extern int buses_init(void);
 extern int classes_init(void);
 extern int firmware_init(void);
+#ifdef CONFIG_SYS_HYPERVISOR
+extern int hypervisor_init(void);
+#else
+static inline int hypervisor_init(void) { return 0; }
+#endif
 extern int platform_bus_init(void);
 extern int system_bus_init(void);
 extern int cpu_dev_init(void);
diff -urpN linux-2.6.17-rc3-mm1/drivers/base/hypervisor.c linux-2.6.17-rc3-mm1-sys-hypervisor/drivers/base/hypervisor.c
--- linux-2.6.17-rc3-mm1/drivers/base/hypervisor.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17-rc3-mm1-sys-hypervisor/drivers/base/hypervisor.c	2006-05-08 16:00:20.000000000 +0200
@@ -0,0 +1,19 @@
+/*
+ * hypervisor.c - /sys/hypervisor subsystem.
+ *
+ * This file is released under the GPLv2
+ *
+ */
+
+#include <linux/kobject.h>
+#include <linux/device.h>
+
+#include "base.h"
+
+decl_subsys(hypervisor, NULL, NULL);
+EXPORT_SYMBOL_GPL(hypervisor_subsys);
+
+int __init hypervisor_init(void)
+{
+	return subsystem_register(&hypervisor_subsys);
+}
diff -urpN linux-2.6.17-rc3-mm1/drivers/base/init.c linux-2.6.17-rc3-mm1-sys-hypervisor/drivers/base/init.c
--- linux-2.6.17-rc3-mm1/drivers/base/init.c	2006-05-08 15:56:23.000000000 +0200
+++ linux-2.6.17-rc3-mm1-sys-hypervisor/drivers/base/init.c	2006-05-08 16:00:07.000000000 +0200
@@ -27,6 +27,7 @@ void __init driver_init(void)
 	buses_init();
 	classes_init();
 	firmware_init();
+	hypervisor_init();
 
 	/* These are also core pieces, but must come after the
 	 * core core pieces.
diff -urpN linux-2.6.17-rc3-mm1/include/linux/kobject.h linux-2.6.17-rc3-mm1-sys-hypervisor/include/linux/kobject.h
--- linux-2.6.17-rc3-mm1/include/linux/kobject.h	2006-05-08 15:57:05.000000000 +0200
+++ linux-2.6.17-rc3-mm1-sys-hypervisor/include/linux/kobject.h	2006-05-08 15:59:35.000000000 +0200
@@ -190,6 +190,8 @@ struct subsystem _varname##_subsys = { \
 
 /* The global /sys/kernel/ subsystem for people to chain off of */
 extern struct subsystem kernel_subsys;
+/* The global /sys/hypervisor/ subsystem  */
+extern struct subsystem hypervisor_subsys;
 
 /**
  * Helpers for setting the kset of registered objects.
