Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265369AbSLBHRq>; Mon, 2 Dec 2002 02:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265402AbSLBHRp>; Mon, 2 Dec 2002 02:17:45 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:44550 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265369AbSLBHRf>;
	Mon, 2 Dec 2002 02:17:35 -0500
Date: Mon, 2 Dec 2002 00:25:25 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: [PATCH] PCI Hotplug changes for 2.5.50
Message-ID: <20021202082525.GB12121@kroah.com>
References: <20021202082443.GA12121@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021202082443.GA12121@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.871.3.1, 2002/11/26 11:23:49-08:00, greg@kroah.com

PCI hotplug: moved cpci_hotplug.o to be built into pci_hotplug.o if enabled.


diff -Nru a/drivers/hotplug/Makefile b/drivers/hotplug/Makefile
--- a/drivers/hotplug/Makefile	Sun Dec  1 23:26:33 2002
+++ b/drivers/hotplug/Makefile	Sun Dec  1 23:26:33 2002
@@ -8,13 +8,17 @@
 obj-$(CONFIG_HOTPLUG_PCI_COMPAQ)	+= cpqphp.o
 obj-$(CONFIG_HOTPLUG_PCI_IBM)		+= ibmphp.o
 obj-$(CONFIG_HOTPLUG_PCI_ACPI)		+= acpiphp.o
-obj-$(CONFIG_HOTPLUG_PCI_CPCI)		+= cpci_hotplug.o
 obj-$(CONFIG_HOTPLUG_PCI_CPCI_ZT5550)	+= cpcihp_zt5550.o
 obj-$(CONFIG_HOTPLUG_PCI_CPCI_GENERIC)	+= cpcihp_generic.o
 
 pci_hotplug-objs	:=	pci_hotplug_core.o	\
 				pci_hotplug_util.o
 
+ifdef CONFIG_HOTPLUG_PCI_CPCI
+pci_hotplug-objs	+=	cpci_hotplug_core.o	\
+				cpci_hotplug_pci.o
+endif
+
 cpqphp-objs		:=	cpqphp_core.o	\
 				cpqphp_ctrl.o	\
 				cpqphp_proc.o	\
@@ -30,9 +34,6 @@
 				acpiphp_glue.o	\
 				acpiphp_pci.o	\
 				acpiphp_res.o
-
-cpci_hotplug-objs	:=	cpci_hotplug_core.o	\
-				cpci_hotplug_pci.o
 
 ifdef CONFIG_HOTPLUG_PCI_ACPI
   EXTRA_CFLAGS  += -D_LINUX -I$(TOPDIR)/drivers/acpi
diff -Nru a/drivers/hotplug/cpci_hotplug_core.c b/drivers/hotplug/cpci_hotplug_core.c
--- a/drivers/hotplug/cpci_hotplug_core.c	Sun Dec  1 23:26:33 2002
+++ b/drivers/hotplug/cpci_hotplug_core.c	Sun Dec  1 23:26:33 2002
@@ -891,16 +891,17 @@
 	return;
 }
 
-static int __init
-cpci_hotplug_init(void)
+int __init
+cpci_hotplug_init(int debug)
 {
 	spin_lock_init(&list_lock);
+	cpci_debug = debug;
 
 	info(DRIVER_DESC " version: " DRIVER_VERSION);
 	return 0;
 }
 
-static void __exit
+void __exit
 cpci_hotplug_exit(void)
 {
 	/*
@@ -909,14 +910,6 @@
 	cleanup_slots();
 }
 
-module_init(cpci_hotplug_init);
-module_exit(cpci_hotplug_exit);
-
-MODULE_AUTHOR(DRIVER_AUTHOR);
-MODULE_DESCRIPTION(DRIVER_DESC);
-MODULE_LICENSE("GPL");
-MODULE_PARM(cpci_debug, "i");
-MODULE_PARM_DESC(cpci_debug, "Debugging mode");
 
 EXPORT_SYMBOL_GPL(cpci_hp_register_controller);
 EXPORT_SYMBOL_GPL(cpci_hp_unregister_controller);
diff -Nru a/drivers/hotplug/pci_hotplug_core.c b/drivers/hotplug/pci_hotplug_core.c
--- a/drivers/hotplug/pci_hotplug_core.c	Sun Dec  1 23:26:33 2002
+++ b/drivers/hotplug/pci_hotplug_core.c	Sun Dec  1 23:26:33 2002
@@ -60,8 +60,8 @@
 /* local variables */
 static int debug;
 
-#define DRIVER_VERSION	"0.4"
-#define DRIVER_AUTHOR	"Greg Kroah-Hartman <greg@kroah.com>"
+#define DRIVER_VERSION	"0.5"
+#define DRIVER_AUTHOR	"Greg Kroah-Hartman <greg@kroah.com>, Scott Murray <scottm@somanetworks.com>"
 #define DRIVER_DESC	"PCI Hot Plug PCI Core"
 
 
@@ -89,7 +89,7 @@
 static spinlock_t mount_lock;		/* protects our mount_count */
 static spinlock_t list_lock;
 
-LIST_HEAD(pci_hotplug_slot_list);
+static LIST_HEAD(pci_hotplug_slot_list);
 
 /* these strings match up with the values in pci_bus_speed */
 static char *pci_bus_speed_strings[] = {
@@ -121,6 +121,14 @@
 static const char *slotdir_name = "slots";
 #endif
 
+#ifdef CONFIG_HOTPLUG_PCI_CPCI
+extern int cpci_hotplug_init(int debug);
+extern void cpci_hotplug_exit(void);
+#else
+static inline int cpci_hotplug_init(int debug) { return 0; }
+static inline void cpci_hotplug_exit(void) { }
+#endif
+
 static struct inode *pcihpfs_get_inode (struct super_block *sb, int mode, dev_t dev)
 {
 	struct inode *inode = new_inode(sb);
@@ -1273,19 +1281,30 @@
 		goto exit;
 	}
 
+	result = cpci_hotplug_init(debug);
+	if (result) {
+		err ("cpci_hotplug_init with error %d\n", result);
+		goto error_fs;
+	}
+
 #ifdef CONFIG_PROC_FS
 	/* create mount point for pcihpfs */
 	slotdir = proc_mkdir(slotdir_name, proc_bus_pci_dir);
 #endif
 
 	info (DRIVER_DESC " version: " DRIVER_VERSION "\n");
-
+	goto exit;
+	
+error_fs:
+	unregister_filesystem(&pcihpfs_type);
 exit:
 	return result;
 }
 
 static void __exit pci_hotplug_exit (void)
 {
+	cpci_hotplug_exit();
+
 	unregister_filesystem(&pcihpfs_type);
 
 #ifdef CONFIG_PROC_FS
