Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030246AbWFUTt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030246AbWFUTt7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030254AbWFUTt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:49:58 -0400
Received: from mail.suse.de ([195.135.220.2]:30385 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030249AbWFUTtu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:49:50 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Michael Holzheu <holzheu@de.ibm.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 13/22] [PATCH] Driver Core: Add /sys/hypervisor when needed
Reply-To: Greg KH <greg@kroah.com>
Date: Wed, 21 Jun 2006 12:45:56 -0700
Message-Id: <11509192043044-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11509192022315-git-send-email-greg@kroah.com>
References: <20060621194511.GA23982@kroah.com> <11509191652021-git-send-email-greg@kroah.com> <11509191682051-git-send-email-greg@kroah.com> <11509191721672-git-send-email-greg@kroah.com> <1150919175882-git-send-email-greg@kroah.com> <11509191781796-git-send-email-greg@kroah.com> <11509191812079-git-send-email-greg@kroah.com> <115091918546-git-send-email-greg@kroah.com> <11509191893358-git-send-email-greg@kroah.com> <1150919192294-git-send-email-greg@kroah.com> <11509191951525-git-send-email-greg@kroah.com> <11509191982588-git-send-email-greg@kroah.com> <11509192022315-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Holzheu <holzheu@de.ibm.com>

To have a home for all hypervisors, this patch creates /sys/hypervisor.
A new config option SYS_HYPERVISOR is introduced, which should to be set
by architecture dependent hypervisors (e.g. s390 or Xen).

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/Kconfig      |    4 ++++
 drivers/base/Makefile     |    1 +
 drivers/base/base.h       |    5 +++++
 drivers/base/hypervisor.c |   19 +++++++++++++++++++
 drivers/base/init.c       |    1 +
 include/linux/kobject.h   |    2 ++
 6 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index f0eff3d..80502dc 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -38,3 +38,7 @@ config DEBUG_DRIVER
 	  If you are unsure about this, say N here.
 
 endmenu
+
+config SYS_HYPERVISOR
+	bool
+	default n
diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index e99471d..659cde6 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_FW_LOADER)	+= firmware_clas
 obj-$(CONFIG_NUMA)	+= node.o
 obj-$(CONFIG_MEMORY_HOTPLUG) += memory.o
 obj-$(CONFIG_SMP)	+= topology.o
+obj-$(CONFIG_SYS_HYPERVISOR) += hypervisor.o
 
 ifeq ($(CONFIG_DEBUG_DRIVER),y)
 EXTRA_CFLAGS += -DDEBUG
diff --git a/drivers/base/base.h b/drivers/base/base.h
index 122498a..79115ef 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
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
diff --git a/drivers/base/hypervisor.c b/drivers/base/hypervisor.c
new file mode 100644
index 0000000..0c85e9d
--- /dev/null
+++ b/drivers/base/hypervisor.c
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
diff --git a/drivers/base/init.c b/drivers/base/init.c
index c648914..3713815 100644
--- a/drivers/base/init.c
+++ b/drivers/base/init.c
@@ -27,6 +27,7 @@ void __init driver_init(void)
 	buses_init();
 	classes_init();
 	firmware_init();
+	hypervisor_init();
 
 	/* These are also core pieces, but must come after the
 	 * core core pieces.
diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index c187c53..2d22932 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -190,6 +190,8 @@ struct subsystem _varname##_subsys = { \
 
 /* The global /sys/kernel/ subsystem for people to chain off of */
 extern struct subsystem kernel_subsys;
+/* The global /sys/hypervisor/ subsystem  */
+extern struct subsystem hypervisor_subsys;
 
 /**
  * Helpers for setting the kset of registered objects.
-- 
1.4.0

