Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263725AbUFQVpe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263725AbUFQVpe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 17:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263810AbUFQVpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 17:45:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:33472 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263725AbUFQVp3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 17:45:29 -0400
Date: Thu, 17 Jun 2004 14:45:22 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Zwane Mwaikambo <zwane@fsmlabs.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][2.6] fix bridge sysfs improperly initialised knobject
Message-Id: <20040617144522.04ae5de7@dell_ss3.pdx.osdl.net>
In-Reply-To: <Pine.LNX.4.58.0406161247140.1944@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0406161247140.1944@montezuma.fsmlabs.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The whole effort to avoid hotplug was misguided.  If it is really a problem
(which it doesn't appear to be) then it can more easily be addressed by smarter
hotplug scripts in user space.

This patch gets rid of the whole subsystem hack for bridge kobjects.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

diff -Nru a/net/bridge/br.c b/net/bridge/br.c
--- a/net/bridge/br.c	2004-06-17 14:14:16 -07:00
+++ b/net/bridge/br.c	2004-06-17 14:14:16 -07:00
@@ -33,8 +33,6 @@
 {
 	br_fdb_init();
 
-	br_sysfs_init();
-
 #ifdef CONFIG_BRIDGE_NETFILTER
 	if (br_netfilter_init())
 		return 1;
@@ -69,7 +67,6 @@
 #endif
 
 	br_handle_frame_hook = NULL;
-	br_sysfs_fini();
 	br_fdb_fini();
 }
 
diff -Nru a/net/bridge/br_private.h b/net/bridge/br_private.h
--- a/net/bridge/br_private.h	2004-06-17 14:14:16 -07:00
+++ b/net/bridge/br_private.h	2004-06-17 14:14:16 -07:00
@@ -217,9 +217,6 @@
 extern void br_sysfs_freeif(struct net_bridge_port *p);
 
 /* br_sysfs_br.c */
-extern struct subsystem bridge_subsys;
-extern void br_sysfs_init(void);
-extern void br_sysfs_fini(void);
 extern int br_sysfs_addbr(struct net_device *dev);
 extern void br_sysfs_delbr(struct net_device *dev);
 
@@ -228,8 +225,6 @@
 #define br_sysfs_addif(p)	(0)
 #define br_sysfs_removeif(p)	do { } while(0)
 #define br_sysfs_freeif(p)	kfree(p)
-#define br_sysfs_init()		do { } while(0)
-#define br_sysfs_fini()		do { } while(0)
 #define br_sysfs_addbr(dev)	(0)
 #define br_sysfs_delbr(dev)	do { } while(0)
 #endif /* CONFIG_SYSFS */
diff -Nru a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
--- a/net/bridge/br_sysfs_br.c	2004-06-17 14:14:16 -07:00
+++ b/net/bridge/br_sysfs_br.c	2004-06-17 14:14:16 -07:00
@@ -300,25 +300,6 @@
 	.read = brforward_read,
 };
 
-
-/*
- * This is a dummy kset so bridge objects don't cause
- * hotplug events 
- */
-struct subsystem bridge_subsys = { 
-	.kset = { .hotplug_ops = NULL },
-};
-
-void br_sysfs_init(void)
-{
-	subsystem_register(&bridge_subsys);
-}
-
-void br_sysfs_fini(void)
-{
-	subsystem_unregister(&bridge_subsys);
-}
-
 /*
  * Add entries in sysfs onto the existing network class device
  * for the bridge.
@@ -353,7 +334,7 @@
 	
 	kobject_set_name(&br->ifobj, SYSFS_BRIDGE_PORT_SUBDIR);
 	br->ifobj.ktype = NULL;
-	br->ifobj.kset = &bridge_subsys.kset;
+	br->ifobj.kset = NULL;
 	br->ifobj.parent = brobj;
 
 	err = kobject_register(&br->ifobj);
diff -Nru a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
--- a/net/bridge/br_sysfs_if.c	2004-06-17 14:14:16 -07:00
+++ b/net/bridge/br_sysfs_if.c	2004-06-17 14:14:16 -07:00
@@ -227,7 +227,7 @@
 	kobject_set_name(&p->kobj, SYSFS_BRIDGE_PORT_ATTR);
 	p->kobj.ktype = &brport_ktype;
 	p->kobj.parent = &(p->dev->class_dev.kobj);
-	p->kobj.kset = &bridge_subsys.kset;
+	p->kobj.kset = NULL;
 
 	err = kobject_add(&p->kobj);
 	if(err)
