Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbUCIT0H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 14:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbUCITYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 14:24:50 -0500
Received: from palrel13.hp.com ([156.153.255.238]:18859 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S262109AbUCITQD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 14:16:03 -0500
Date: Tue, 9 Mar 2004 11:16:00 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] (14/14) move last of irsyms.c to irmod.c
Message-ID: <20040309191600.GO14543@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir264_irsyms_14_irmod.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Original patch from Stephen Hemminger>
(14/14) move last of irsyms.c to irmod.c

Move last bits of code out of irsyms and onto irmod.c where
initialization happens.

Move irda_debug parameter out of irsyms.c into irmod.c
and make it a new style module parameter.

Removes file net/irda/irsyms.c completely; check this in case mailer
seems to barf on the line the character in University of Tromso

diff -u -p -r linux/include/net/irda.sD/irda.h linux/include/net/irda/irda.h
--- linux/include/net/irda.sD/irda.h	Mon Mar  8 18:50:27 2004
+++ linux/include/net/irda/irda.h	Tue Mar  9 10:20:32 2004
@@ -61,7 +61,7 @@ typedef __u32 magic_t;
 
 #ifdef CONFIG_IRDA_DEBUG
 
-extern __u32 irda_debug;
+extern unsigned int irda_debug;
 
 /* use 0 for production, 1 for verification, >2 for debug */
 #define IRDA_DEBUG_LEVEL 0
diff -u -p -r --new-file linux/net/irda.sD/Makefile linux/net/irda/Makefile
--- linux/net/irda.sD/Makefile	Wed Dec 17 18:59:35 2003
+++ linux/net/irda/Makefile	Mon Mar  8 19:55:27 2004
@@ -10,6 +10,6 @@ obj-$(CONFIG_IRCOMM) += ircomm/
 irda-y := iriap.o iriap_event.o irlmp.o irlmp_event.o irlmp_frame.o \
           irlap.o irlap_event.o irlap_frame.o timer.o qos.o irqueue.o \
           irttp.o irda_device.o irias_object.o crc.o wrapper.o af_irda.o \
-	  discovery.o parameters.o irsyms.o
+	  discovery.o parameters.o irmod.o
 irda-$(CONFIG_PROC_FS) += irproc.o
 irda-$(CONFIG_SYSCTL) += irsysctl.o
diff -u -p -r --new-file linux/net/irda.sD/irmod.c linux/net/irda/irmod.c
--- linux/net/irda.sD/irmod.c	Wed Dec 31 16:00:00 1969
+++ linux/net/irda/irmod.c	Tue Mar  9 10:17:52 2004
@@ -0,0 +1,185 @@
+/*********************************************************************
+ *                
+ * Filename:      irmod.c
+ * Version:       0.9
+ * Description:   IrDA stack main entry points
+ * Status:        Experimental.
+ * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Created at:    Mon Dec 15 13:55:39 1997
+ * Modified at:   Wed Jan  5 15:12:41 2000
+ * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * 
+ *     Copyright (c) 1997, 1999-2000 Dag Brattli, All Rights Reserved.
+ *     Copyright (c) 2000-2004 Jean Tourrilhes <jt@hpl.hp.com>
+ *      
+ *     This program is free software; you can redistribute it and/or 
+ *     modify it under the terms of the GNU General Public License as 
+ *     published by the Free Software Foundation; either version 2 of 
+ *     the License, or (at your option) any later version.
+ *  
+ *     Neither Dag Brattli nor University of Tromsø admit liability nor
+ *     provide warranty for any of this software. This material is 
+ *     provided "AS-IS" and at no charge.
+ *     
+ ********************************************************************/
+
+/*
+ * This file contains the main entry points of the IrDA stack.
+ * They are in this file and not af_irda.c because some developpers
+ * are using the IrDA stack without the socket API (compiling out
+ * af_irda.c).
+ * Jean II
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+
+#include <net/irda/irda.h>
+#include <net/irda/irmod.h>		/* notify_t */
+#include <net/irda/irlap.h>		/* irlap_init */
+#include <net/irda/irlmp.h>		/* irlmp_init */
+#include <net/irda/iriap.h>		/* iriap_init */
+#include <net/irda/irttp.h>		/* irttp_init */
+#include <net/irda/irda_device.h>	/* irda_device_init */
+
+/* irproc.c */
+extern void irda_proc_register(void);
+extern void irda_proc_unregister(void);
+/* irsysctl.c */
+extern int  irda_sysctl_register(void);
+extern void irda_sysctl_unregister(void);
+/* af_irda.c */
+extern int  irsock_init(void);
+extern void irsock_cleanup(void);
+/* irlap_frame.c */
+extern int  irlap_driver_rcv(struct sk_buff *, struct net_device *, 
+			     struct packet_type *);
+
+/*
+ * Module parameters
+ */
+#ifdef CONFIG_IRDA_DEBUG
+unsigned int irda_debug = IRDA_DEBUG_LEVEL;
+module_param_named(debug, irda_debug, uint, 0);
+MODULE_PARM_DESC(irda_debug, "IRDA debugging level");
+EXPORT_SYMBOL(irda_debug);
+#endif
+
+/* Packet type handler.
+ * Tell the kernel how IrDA packets should be handled.
+ */
+static struct packet_type irda_packet_type = {
+	.type	= __constant_htons(ETH_P_IRDA),
+	.func	= irlap_driver_rcv,	/* Packet type handler irlap_frame.c */
+};
+
+/*
+ * Function irda_notify_init (notify)
+ *
+ *    Used for initializing the notify structure
+ *
+ */
+void irda_notify_init(notify_t *notify)
+{
+	notify->data_indication = NULL;
+	notify->udata_indication = NULL;
+	notify->connect_confirm = NULL;
+	notify->connect_indication = NULL;
+	notify->disconnect_indication = NULL;
+	notify->flow_indication = NULL;
+	notify->status_indication = NULL;
+	notify->instance = NULL;
+	strlcpy(notify->name, "Unknown", sizeof(notify->name));
+}
+EXPORT_SYMBOL(irda_notify_init);
+
+/*
+ * Function irda_init (void)
+ *
+ *  Protocol stack initialisation entry point.
+ *  Initialise the various components of the IrDA stack
+ */
+int __init irda_init(void)
+{
+	IRDA_DEBUG(0, "%s()\n", __FUNCTION__);
+
+	/* Lower layer of the stack */
+ 	irlmp_init();
+	irlap_init();
+	
+	/* Higher layers of the stack */
+	iriap_init();
+ 	irttp_init();
+	irsock_init();
+	
+	/* Add IrDA packet type (Start receiving packets) */
+        dev_add_pack(&irda_packet_type);
+
+	/* External APIs */
+#ifdef CONFIG_PROC_FS
+	irda_proc_register();
+#endif
+#ifdef CONFIG_SYSCTL
+	irda_sysctl_register();
+#endif
+
+	/* Driver/dongle support */
+ 	irda_device_init();
+
+	return 0;
+}
+
+/*
+ * Function irda_cleanup (void)
+ *
+ *  Protocol stack cleanup/removal entry point.
+ *  Cleanup the various components of the IrDA stack
+ */
+void __exit irda_cleanup(void)
+{
+	/* Remove External APIs */
+#ifdef CONFIG_SYSCTL
+	irda_sysctl_unregister();
+#endif	
+#ifdef CONFIG_PROC_FS
+	irda_proc_unregister();
+#endif
+
+	/* Remove IrDA packet type (stop receiving packets) */
+        dev_remove_pack(&irda_packet_type);
+	
+	/* Remove higher layers */
+	irsock_cleanup();
+	irttp_cleanup();
+	iriap_cleanup();
+
+	/* Remove lower layers */
+	irda_device_cleanup();
+	irlap_cleanup(); /* Must be done before irlmp_cleanup()! DB */
+
+	/* Remove middle layer */
+	irlmp_cleanup();
+}
+
+/*
+ * The IrDA stack must be initialised *before* drivers get initialised,
+ * and *before* higher protocols (IrLAN/IrCOMM/IrNET) get initialised,
+ * otherwise bad things will happen (hashbins will be NULL for example).
+ * Those modules are at module_init()/device_initcall() level.
+ *
+ * On the other hand, it needs to be initialised *after* the basic
+ * networking, the /proc/net filesystem and sysctl module. Those are
+ * currently initialised in .../init/main.c (before initcalls).
+ * Also, IrDA drivers needs to be initialised *after* the random number
+ * generator (main stack and higher layer init don't need it anymore).
+ *
+ * Jean II
+ */
+subsys_initcall(irda_init);
+module_exit(irda_cleanup);
+ 
+MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no> & Jean Tourrilhes <jt@hpl.hp.com>");
+MODULE_DESCRIPTION("The Linux IrDA Protocol Stack"); 
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_NETPROTO(PF_IRDA);
diff -u -p -r --new-file linux/net/irda.sD/irsyms.c linux/net/irda/irsyms.c
--- linux/net/irda.sD/irsyms.c	Mon Mar  8 19:24:58 2004
+++ linux/net/irda/irsyms.c	Wed Dec 31 16:00:00 1969
@@ -1,202 +0,0 @@
-/*********************************************************************
- *                
- * Filename:      irsyms.c
- * Version:       0.9
- * Description:   IrDA module symbols
- * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
- * Created at:    Mon Dec 15 13:55:39 1997
- * Modified at:   Wed Jan  5 15:12:41 2000
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
- * 
- *     Copyright (c) 1997, 1999-2000 Dag Brattli, All Rights Reserved.
- *     Copyright (c) 2000-2001 Jean Tourrilhes <jt@hpl.hp.com>
- *      
- *     This program is free software; you can redistribute it and/or 
- *     modify it under the terms of the GNU General Public License as 
- *     published by the Free Software Foundation; either version 2 of 
- *     the License, or (at your option) any later version.
- *  
- *     Neither Dag Brattli nor University of Tromsø admit liability nor
- *     provide warranty for any of this software. This material is 
- *     provided "AS-IS" and at no charge.
- *     
- ********************************************************************/
-
-#include <linux/config.h>
-#include <linux/module.h>
-
-#include <linux/init.h>
-#include <linux/poll.h>
-#include <linux/proc_fs.h>
-#include <linux/smp_lock.h>
-#include <linux/if_arp.h>		/* ARPHRD_IRDA */
-
-#include <net/irda/irda.h>
-#include <net/irda/irlap.h>
-#include <net/irda/irlmp.h>
-#include <net/irda/iriap.h>
-#include <net/irda/irias_object.h>
-#include <net/irda/irttp.h>
-#include <net/irda/irda_device.h>
-#include <net/irda/wrapper.h>
-#include <net/irda/timer.h>
-#include <net/irda/parameters.h>
-#include <net/irda/crc.h>
-
-extern struct proc_dir_entry *proc_irda;
-
-extern void irda_proc_register(void);
-extern void irda_proc_unregister(void);
-extern int  irda_sysctl_register(void);
-extern void irda_sysctl_unregister(void);
-
-extern int irda_proto_init(void);
-extern void irda_proto_cleanup(void);
-
-extern int irda_device_init(void);
-extern int irlan_init(void);
-extern int irlan_client_init(void);
-extern int irlan_server_init(void);
-extern int ircomm_init(void);
-extern int ircomm_tty_init(void);
-extern int irlpt_client_init(void);
-extern int irlpt_server_init(void);
-
-extern int  irsock_init(void);
-extern void irsock_cleanup(void);
-extern int  irlap_driver_rcv(struct sk_buff *, struct net_device *, 
-			     struct packet_type *);
-
-/* Main IrDA module */
-#ifdef CONFIG_IRDA_DEBUG
-EXPORT_SYMBOL(irda_debug);
-#endif
-EXPORT_SYMBOL(irda_notify_init);
-
-/* IrLAP */
-
-
-#ifdef CONFIG_IRDA_DEBUG
-__u32 irda_debug = IRDA_DEBUG_LEVEL;
-#endif
-
-/* Packet type handler.
- * Tell the kernel how IrDA packets should be handled.
- */
-static struct packet_type irda_packet_type = {
-	.type	= __constant_htons(ETH_P_IRDA),
-	.func	= irlap_driver_rcv,	/* Packet type handler irlap_frame.c */
-};
-
-/*
- * Function irda_notify_init (notify)
- *
- *    Used for initializing the notify structure
- *
- */
-void irda_notify_init(notify_t *notify)
-{
-	notify->data_indication = NULL;
-	notify->udata_indication = NULL;
-	notify->connect_confirm = NULL;
-	notify->connect_indication = NULL;
-	notify->disconnect_indication = NULL;
-	notify->flow_indication = NULL;
-	notify->status_indication = NULL;
-	notify->instance = NULL;
-	strlcpy(notify->name, "Unknown", sizeof(notify->name));
-}
-
-/*
- * Function irda_init (void)
- *
- *  Protocol stack initialisation entry point.
- *  Initialise the various components of the IrDA stack
- */
-int __init irda_init(void)
-{
-	IRDA_DEBUG(0, "%s()\n", __FUNCTION__);
-
-	/* Lower layer of the stack */
- 	irlmp_init();
-	irlap_init();
-	
-	/* Higher layers of the stack */
-	iriap_init();
- 	irttp_init();
-	irsock_init();
-	
-	/* Add IrDA packet type (Start receiving packets) */
-        dev_add_pack(&irda_packet_type);
-
-	/* External APIs */
-#ifdef CONFIG_PROC_FS
-	irda_proc_register();
-#endif
-#ifdef CONFIG_SYSCTL
-	irda_sysctl_register();
-#endif
-
-	/* Driver/dongle support */
- 	irda_device_init();
-
-	return 0;
-}
-
-/*
- * Function irda_cleanup (void)
- *
- *  Protocol stack cleanup/removal entry point.
- *  Cleanup the various components of the IrDA stack
- */
-void __exit irda_cleanup(void)
-{
-	/* Remove External APIs */
-#ifdef CONFIG_SYSCTL
-	irda_sysctl_unregister();
-#endif	
-#ifdef CONFIG_PROC_FS
-	irda_proc_unregister();
-#endif
-
-	/* Remove IrDA packet type (stop receiving packets) */
-        dev_remove_pack(&irda_packet_type);
-	
-	/* Remove higher layers */
-	irsock_cleanup();
-	irttp_cleanup();
-	iriap_cleanup();
-
-	/* Remove lower layers */
-	irda_device_cleanup();
-	irlap_cleanup(); /* Must be done before irlmp_cleanup()! DB */
-
-	/* Remove middle layer */
-	irlmp_cleanup();
-}
-
-/*
- * The IrDA stack must be initialised *before* drivers get initialised,
- * and *before* higher protocols (IrLAN/IrCOMM/IrNET) get initialised,
- * otherwise bad things will happen (hashbins will be NULL for example).
- * Those modules are at module_init()/device_initcall() level.
- *
- * On the other hand, it needs to be initialised *after* the basic
- * networking, the /proc/net filesystem and sysctl module. Those are
- * currently initialised in .../init/main.c (before initcalls).
- * Also, IrDA drivers needs to be initialised *after* the random number
- * generator (main stack and higher layer init don't need it anymore).
- *
- * Jean II
- */
-subsys_initcall(irda_init);
-module_exit(irda_cleanup);
- 
-MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no> & Jean Tourrilhes <jt@hpl.hp.com>");
-MODULE_DESCRIPTION("The Linux IrDA Protocol Stack"); 
-MODULE_LICENSE("GPL");
-#ifdef CONFIG_IRDA_DEBUG
-MODULE_PARM(irda_debug, "1l");
-#endif
-MODULE_ALIAS_NETPROTO(PF_IRDA);
diff -u -p -r --new-file linux/net/irda.sD/irsysctl.c linux/net/irda/irsysctl.c
--- linux/net/irda.sD/irsysctl.c	Wed Dec 17 18:58:46 2003
+++ linux/net/irda/irsysctl.c	Tue Mar  9 10:23:23 2004
@@ -29,7 +29,7 @@
 #include <linux/sysctl.h>
 #include <linux/init.h>
 
-#include <net/irda/irda.h>
+#include <net/irda/irda.h>		/* irda_debug */
 #include <net/irda/irias_object.h>
 
 #define NET_IRDA 412 /* Random number */
@@ -52,10 +52,6 @@ extern int  sysctl_max_tx_window;
 extern int  sysctl_max_noreply_time;
 extern int  sysctl_warn_noreply_time;
 extern int  sysctl_lap_keepalive_time;
-
-#ifdef CONFIG_IRDA_DEBUG
-extern unsigned int irda_debug;
-#endif
 
 /* this is needed for the proc_dointvec_minmax - Jean II */
 static int max_discovery_slots = 16;		/* ??? */
