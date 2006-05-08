Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbWEHMYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbWEHMYT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 08:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbWEHMYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 08:24:19 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:62080 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S932075AbWEHMYS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 08:24:18 -0400
Date: Mon, 8 May 2006 14:24:16 +0200
From: Michael Holzheu <holzheu@de.ibm.com>
To: greg@kroah.com
Cc: akpm@osdl.org, ioe-lkml@rameria.de, joern@wohnheim.fh-wedel.de,
       linux-kernel@vger.kernel.org, mschwid2@de.ibm.com,
       penberg@cs.helsinki.fi
Subject: Re: [PATCH] s390: Hypervisor File System
Message-Id: <20060508142416.4356e774.holzheu@de.ibm.com>
Organization: IBM
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Greg KH <greg@kroah.com> wrote on 05/05/2006 11:14:47 PM:
> > I added a invisible config option CONFIG_SYS_HYPERVISOR. If this
> > option is enabled, /sys/hypervisor is created. CONFIG_S390_HYPFS
> > enables this option automatically using "select".
> > 
> > This the following patch acceptable for you?

Ok, I modified the patch according to your input. So
hopefully that's the final one... ok?

---

diff -urpN linux-2.6.16/drivers/base/Kconfig linux-2.6.16-hypervisor/drivers/base/Kconfig
--- linux-2.6.16/drivers/base/Kconfig	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.16-hypervisor/drivers/base/Kconfig	2006-05-08 13:22:52.000000000 +0200
@@ -38,3 +38,7 @@ config DEBUG_DRIVER
 	  If you are unsure about this, say N here.
 
 endmenu
+
+config SYS_HYPERVISOR
+	bool
+	default n
diff -urpN linux-2.6.16/drivers/base/Makefile linux-2.6.16-hypervisor/drivers/base/Makefile
--- linux-2.6.16/drivers/base/Makefile	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.16-hypervisor/drivers/base/Makefile	2006-05-08 13:22:35.000000000 +0200
@@ -9,6 +9,7 @@ obj-$(CONFIG_FW_LOADER)	+= firmware_clas
 obj-$(CONFIG_NUMA)	+= node.o
 obj-$(CONFIG_MEMORY_HOTPLUG) += memory.o
 obj-$(CONFIG_SMP)	+= topology.o
+obj-$(CONFIG_SYS_HYPERVISOR) += hypervisor.o
 
 ifeq ($(CONFIG_DEBUG_DRIVER),y)
 EXTRA_CFLAGS += -DDEBUG
diff -urpN linux-2.6.16/drivers/base/base.h linux-2.6.16-hypervisor/drivers/base/base.h
--- linux-2.6.16/drivers/base/base.h	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.16-hypervisor/drivers/base/base.h	2006-05-08 14:13:18.000000000 +0200
@@ -5,6 +5,11 @@ extern int devices_init(void);
 extern int buses_init(void);
 extern int classes_init(void);
 extern int firmware_init(void);
+#ifdef CONFIG_SYS_HYPERVISOR
+extern int hypervisor_init(void);
+#else
+#define hypervisor_init() do { } while(0)
+#endif
 extern int platform_bus_init(void);
 extern int system_bus_init(void);
 extern int cpu_dev_init(void);
diff -urpN linux-2.6.16/drivers/base/hypervisor.c linux-2.6.16-hypervisor/drivers/base/hypervisor.c
--- linux-2.6.16/drivers/base/hypervisor.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.16-hypervisor/drivers/base/hypervisor.c	2006-05-08 13:22:45.000000000 +0200
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
diff -urpN linux-2.6.16/drivers/base/init.c linux-2.6.16-hypervisor/drivers/base/init.c
--- linux-2.6.16/drivers/base/init.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.16-hypervisor/drivers/base/init.c	2006-05-08 13:22:39.000000000 +0200
@@ -27,6 +27,7 @@ void __init driver_init(void)
 	buses_init();
 	classes_init();
 	firmware_init();
+	hypervisor_init();
 
 	/* These are also core pieces, but must come after the
 	 * core core pieces.
diff -urpN linux-2.6.16/include/linux/kobject.h linux-2.6.16-hypervisor/include/linux/kobject.h
--- linux-2.6.16/include/linux/kobject.h	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.16-hypervisor/include/linux/kobject.h	2006-05-08 13:22:21.000000000 +0200
@@ -186,6 +186,8 @@ struct subsystem _varname##_subsys = { \
 
 /* The global /sys/kernel/ subsystem for people to chain off of */
 extern struct subsystem kernel_subsys;
+/* The global /sys/hypervisor/ subsystem  */
+extern struct subsystem hypervisor_subsys;
 
 /**
  * Helpers for setting the kset of registered objects.

