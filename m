Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262788AbTCVPve>; Sat, 22 Mar 2003 10:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262802AbTCVPvd>; Sat, 22 Mar 2003 10:51:33 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:24500 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S262788AbTCVPvb>; Sat, 22 Mar 2003 10:51:31 -0500
Date: Sat, 22 Mar 2003 17:00:32 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5] pcmcia (2/5): add bus_type pcmcia_bus_type
Message-ID: <20030322160032.GB12342@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Register a bus_type pcmcia_bus_type. This means the initialization of
the ds module needs to be done in two levels: one quite early
(subsys_initcall) so that drivers may use the bus_type; the other one
must stay that late (late_initcall). As only one initcall can be
specified within one module, some tweaking is needed.

	  Dominik

diff -ruN linux-original/drivers/pcmcia/ds.c linux/drivers/pcmcia/ds.c
--- linux-original/drivers/pcmcia/ds.c	2003-03-22 16:12:08.000000000 +0100
+++ linux/drivers/pcmcia/ds.c	2003-03-22 16:11:50.000000000 +0100
@@ -881,7 +881,18 @@
 
 /*====================================================================*/
 
-int __init init_pcmcia_ds(void)
+struct bus_type pcmcia_bus_type = {
+	.name = "pcmcia",
+};
+EXPORT_SYMBOL(pcmcia_bus_type);
+
+static int __init init_pcmcia_bus(void)
+{
+	bus_register(&pcmcia_bus_type);
+	return 0;
+}
+
+static int __init init_pcmcia_ds(void)
 {
     client_reg_t client_reg;
     servinfo_t serv;
@@ -967,11 +978,8 @@
     return 0;
 }
 
-late_initcall(init_pcmcia_ds);
-
-#ifdef MODULE
 
-void __exit cleanup_module(void)
+static void __exit exit_pcmcia_ds(void)
 {
     int i;
 #ifdef CONFIG_PROC_FS
@@ -984,6 +992,23 @@
 	pcmcia_deregister_client(socket_table[i].handle);
     sockets = 0;
     kfree(socket_table);
+    bus_unregister(&pcmcia_bus_type);
 }
 
+#ifdef MODULE
+
+/* init_pcmcia_bus must be done early, init_pcmcia_ds late. If we load this 
+ * as a module, we can only specify one initcall, though... 
+ */
+static int __init init_pcmcia_module(void) {
+	init_pcmcia_bus();
+	return init_pcmcia_ds();
+}
+module_init(init_pcmcia_module);
+
+#else /* !MODULE */
+subsys_initcall(init_pcmcia_bus);
+late_initcall(init_pcmcia_ds);
 #endif
+
+module_exit(exit_pcmcia_ds);
diff -ruN linux-original/include/pcmcia/ds.h linux/include/pcmcia/ds.h
--- linux-original/include/pcmcia/ds.h	2003-03-22 16:12:08.000000000 +0100
+++ linux/include/pcmcia/ds.h	2003-03-22 16:12:25.000000000 +0100
@@ -32,6 +32,7 @@
 
 #include <pcmcia/driver_ops.h>
 #include <pcmcia/bulkmem.h>
+#include <linux/device.h>
 
 typedef struct tuple_parse_t {
     tuple_t		tuple;
@@ -143,6 +144,8 @@
 #define register_pcmcia_driver register_pccard_driver
 #define unregister_pcmcia_driver unregister_pccard_driver
 
+extern struct bus_type pcmcia_bus_type;
+
 #endif /* __KERNEL__ */
 
 #endif /* _LINUX_DS_H */
