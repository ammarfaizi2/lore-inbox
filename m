Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262718AbTIVAQr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 20:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262720AbTIVAQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 20:16:47 -0400
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:13453 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S262718AbTIVAQh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 20:16:37 -0400
Date: Sun, 21 Sep 2003 20:09:35 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] PnP Fixes for 2.6.0-test5
Message-ID: <20030921200935.GB24897@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# --------------------------------------------
# 03/09/21	ambx1@neo.rr.com	1.1354
# [PNPBIOS] compilation fix for pnpbios without proc support
#
# Here's an updated patch that will correct the compile error when PROC
# FS is disabled.  It also introduces better proc error recovery and
# moves the local proc functions to the local include file.  Thanks to
# Daniele Bellucci for finding the problem and contributing to this
# patch.
#
# --------------------------------------------
#
diff -Nru a/drivers/pnp/pnpbios/core.c b/drivers/pnp/pnpbios/core.c
--- a/drivers/pnp/pnpbios/core.c	Sun Sep 21 19:46:16 2003
+++ b/drivers/pnp/pnpbios/core.c	Sun Sep 21 19:46:16 2003
@@ -431,14 +431,15 @@
 	}
 
 	/* register with the pnp layer */
-	pnp_register_protocol(&pnpbios_protocol);
+	if (pnp_register_protocol(&pnpbios_protocol)) {
+		printk(KERN_ERR "PnPBIOS: Unable to register driver.  Aborting.\n");
+		return -EIO;
+	}
 
-#ifdef CONFIG_PROC_FS
 	/* start the proc interface */
 	ret = pnpbios_proc_init();
 	if (ret)
-		return ret;
-#endif
+		printk(KERN_ERR "PnPBIOS: Failed to create proc interface.\n");
 
 	/* scan for pnpbios devices */
 	build_devlist();
diff -Nru a/drivers/pnp/pnpbios/pnpbios.h b/drivers/pnp/pnpbios/pnpbios.h
--- a/drivers/pnp/pnpbios/pnpbios.h	Sun Sep 21 19:46:16 2003
+++ b/drivers/pnp/pnpbios/pnpbios.h	Sun Sep 21 19:46:16 2003
@@ -9,3 +9,13 @@
 
 extern void pnpbios_print_status(const char * module, u16 status);
 extern int pnpbios_probe_installation(void);
+
+#ifdef CONFIG_PROC_FS
+extern int pnpbios_interface_attach_device(struct pnp_bios_node * node);
+extern int pnpbios_proc_init (void);
+extern void pnpbios_proc_exit (void);
+#else
+static inline int pnpbios_interface_attach_device(struct pnp_bios_node * node) { return 0; }
+static inline int pnpbios_proc_init (void) { return 0; }
+static inline void pnpbios_proc_exit (void) { ; }
+#endif /* CONFIG_PROC */
diff -Nru a/drivers/pnp/pnpbios/proc.c b/drivers/pnp/pnpbios/proc.c
--- a/drivers/pnp/pnpbios/proc.c	Sun Sep 21 19:46:16 2003
+++ b/drivers/pnp/pnpbios/proc.c	Sun Sep 21 19:46:16 2003
@@ -31,6 +31,8 @@
 
 #include <asm/uaccess.h>
 
+#include "pnpbios.h"
+
 static struct proc_dir_entry *proc_pnp = NULL;
 static struct proc_dir_entry *proc_pnp_boot = NULL;
 
@@ -213,6 +215,9 @@
 	struct proc_dir_entry *ent;
 
 	sprintf(name, "%02x", node->handle);
+
+	if (!proc_pnp)
+		return -EIO;
 	if ( !pnpbios_dont_use_current_config ) {
 		ent = create_proc_entry(name, 0, proc_pnp);
 		if (ent) {
@@ -221,6 +226,9 @@
 			ent->data = (void *)(long)(node->handle);
 		}
 	}
+
+	if (!proc_pnp_boot)
+		return -EIO;
 	ent = create_proc_entry(name, 0, proc_pnp_boot);
 	if (ent) {
 		ent->read_proc = proc_read_node;
@@ -228,6 +236,7 @@
 		ent->data = (void *)(long)(node->handle+0x100);
 		return 0;
 	}
+
 	return -EIO;
 }
 
@@ -257,8 +266,9 @@
 {
 	int i;
 	char name[3];
-	
-	if (!proc_pnp) return;
+
+	if (!proc_pnp)
+		return;
 
 	for (i=0; i<0xff; i++) {
 		sprintf(name, "%02x", i);
diff -Nru a/include/linux/pnpbios.h b/include/linux/pnpbios.h
--- a/include/linux/pnpbios.h	Sun Sep 21 19:46:16 2003
+++ b/include/linux/pnpbios.h	Sun Sep 21 19:46:16 2003
@@ -26,7 +26,7 @@
 #ifdef __KERNEL__
 
 #include <linux/types.h>
-#include <linux/pci.h>
+#include <linux/pnp.h>
 
 /*
  * Return codes
@@ -135,9 +135,6 @@
 extern struct pnp_dev_node_info node_info;
 extern void *pnpbios_kmalloc(size_t size, int f);
 extern int pnpbios_init (void);
-extern int pnpbios_interface_attach_device(struct pnp_bios_node * node);
-extern int pnpbios_proc_init (void);
-extern void pnpbios_proc_exit (void);
 
 extern int pnp_bios_dev_node_info (struct pnp_dev_node_info *data);
 extern int pnp_bios_get_dev_node (u8 *nodenum, char config, struct pnp_bios_node *data);
