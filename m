Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262721AbTIVAUK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 20:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbTIVATn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 20:19:43 -0400
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:14989 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S262721AbTIVARo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 20:17:44 -0400
Date: Sun, 21 Sep 2003 20:10:42 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Fixes for 2.6.0-test5
Message-ID: <20030921201042.GD24897@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
References: <20030921200935.GB24897@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030921200935.GB24897@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# --------------------------------------------
# 03/09/21	ambx1@neo.rr.com	1.1356
# [PNPBIOS] move detection code into core.c
# 
# This patch moves the detection code to a more appropriate file.
# --------------------------------------------
#
diff -Nru a/drivers/pnp/pnpbios/bioscalls.c b/drivers/pnp/pnpbios/bioscalls.c
--- a/drivers/pnp/pnpbios/bioscalls.c	Sun Sep 21 19:46:04 2003
+++ b/drivers/pnp/pnpbios/bioscalls.c	Sun Sep 21 19:46:04 2003
@@ -23,41 +23,7 @@
 #include <asm/system.h>
 #include <asm/byteorder.h>
 
-
-/* PnP BIOS signature: "$PnP" */
-#define PNP_SIGNATURE   (('$' << 0) + ('P' << 8) + ('n' << 16) + ('P' << 24))
-
-#pragma pack(1)
-union pnp_bios_expansion_header {
-	struct {
-		u32 signature;    /* "$PnP" */
-		u8 version;	  /* in BCD */
-		u8 length;	  /* length in bytes, currently 21h */
-		u16 control;	  /* system capabilities */
-		u8 checksum;	  /* all bytes must add up to 0 */
-
-		u32 eventflag;    /* phys. address of the event flag */
-		u16 rmoffset;     /* real mode entry point */
-		u16 rmcseg;
-		u16 pm16offset;   /* 16 bit protected mode entry */
-		u32 pm16cseg;
-		u32 deviceID;	  /* EISA encoded system ID or 0 */
-		u16 rmdseg;	  /* real mode data segment */
-		u32 pm16dseg;	  /* 16 bit pm data segment base */
-	} fields;
-	char chars[0x21];	  /* To calculate the checksum */
-};
-#pragma pack()
-
-static union pnp_bios_expansion_header * pnp_bios_hdr = NULL;
-
-/*
- * Call this only after init time
- */
-static int pnp_bios_present(void)
-{
-	return (pnp_bios_hdr != NULL);
-}
+#include "pnpbios.h"
 
 static struct {
 	u16	offset;
@@ -557,10 +523,10 @@
 
 
 /*
- * Probing and Initialization
+ * Initialization
  */
 
-static void pnpbios_prepare_bios_calls(union pnp_bios_expansion_header *header)
+void pnpbios_calls_init(union pnp_bios_install_struct *header)
 {
 	int i;
 	spin_lock_init(&pnp_bios_lock);
@@ -575,53 +541,4 @@
 		Q_SET_SEL(i, PNP_CS16, header->fields.pm16cseg, 64 * 1024);
 		Q_SET_SEL(i, PNP_DS, header->fields.pm16dseg, 64 * 1024);
 	}
-}
-
-int pnpbios_probe_installation(void)
-{
-	union pnp_bios_expansion_header *check;
-	u8 sum;
-	int length, i;
-
-	printk(KERN_INFO "PnPBIOS: Scanning system for PnP BIOS support...\n");
-
-	/*
- 	 * Search the defined area (0xf0000-0xffff0) for a valid PnP BIOS
-	 * structure and, if one is found, sets up the selectors and
-	 * entry points
-	 */
-	for (check = (union pnp_bios_expansion_header *) __va(0xf0000);
-	     check < (union pnp_bios_expansion_header *) __va(0xffff0);
-	     ((void *) (check)) += 16) {
-		if (check->fields.signature != PNP_SIGNATURE)
-			continue;
-		printk(KERN_INFO "PnPBIOS: Found PnP BIOS installation structure at 0x%p\n", check);
-		length = check->fields.length;
-		if (!length) {
-			printk(KERN_ERR "PnPBIOS: installation structure is invalid, skipping\n");
-			continue;
-		}
-		for (sum = 0, i = 0; i < length; i++)
-			sum += check->chars[i];
-		if (sum) {
-			printk(KERN_ERR "PnPBIOS: installation structure is corrupted, skipping\n");
-			continue;
-		}
-		if (check->fields.version < 0x10) {
-			printk(KERN_WARNING "PnPBIOS: PnP BIOS version %d.%d is not supported\n",
-			       check->fields.version >> 4,
-			       check->fields.version & 15);
-			continue;
-		}
-		printk(KERN_INFO "PnPBIOS: PnP BIOS version %d.%d, entry 0x%x:0x%x, dseg 0x%x\n",
-                       check->fields.version >> 4, check->fields.version & 15,
-		       check->fields.pm16cseg, check->fields.pm16offset,
-		       check->fields.pm16dseg);
-		pnp_bios_hdr = check;
-		pnpbios_prepare_bios_calls(check);
-		return 1;
-	}
-
-	printk(KERN_INFO "PnPBIOS: PnP BIOS support was not detected.\n");
-	return 0;
 }
diff -Nru a/drivers/pnp/pnpbios/core.c b/drivers/pnp/pnpbios/core.c
--- a/drivers/pnp/pnpbios/core.c	Sun Sep 21 19:46:04 2003
+++ b/drivers/pnp/pnpbios/core.c	Sun Sep 21 19:46:04 2003
@@ -74,6 +74,13 @@
  *
  */
 
+static union pnp_bios_install_struct * pnp_bios_install = NULL;
+
+int pnp_bios_present(void)
+{
+	return (pnp_bios_install != NULL);
+}
+
 struct pnp_dev_node_info node_info;
 
 void *pnpbios_kmalloc(size_t size, int f)
@@ -410,7 +417,56 @@
 __setup("pnpbios=", pnpbios_setup);
 #endif
 
-subsys_initcall(pnpbios_init);
+/* PnP BIOS signature: "$PnP" */
+#define PNP_SIGNATURE   (('$' << 0) + ('P' << 8) + ('n' << 16) + ('P' << 24))
+
+int __init pnpbios_probe_system(void)
+{
+	union pnp_bios_install_struct *check;
+	u8 sum;
+	int length, i;
+
+	printk(KERN_INFO "PnPBIOS: Scanning system for PnP BIOS support...\n");
+
+	/*
+ 	 * Search the defined area (0xf0000-0xffff0) for a valid PnP BIOS
+	 * structure and, if one is found, sets up the selectors and
+	 * entry points
+	 */
+	for (check = (union pnp_bios_install_struct *) __va(0xf0000);
+	     check < (union pnp_bios_install_struct *) __va(0xffff0);
+	     ((void *) (check)) += 16) {
+		if (check->fields.signature != PNP_SIGNATURE)
+			continue;
+		printk(KERN_INFO "PnPBIOS: Found PnP BIOS installation structure at 0x%p\n", check);
+		length = check->fields.length;
+		if (!length) {
+			printk(KERN_ERR "PnPBIOS: installation structure is invalid, skipping\n");
+			continue;
+		}
+		for (sum = 0, i = 0; i < length; i++)
+			sum += check->chars[i];
+		if (sum) {
+			printk(KERN_ERR "PnPBIOS: installation structure is corrupted, skipping\n");
+			continue;
+		}
+		if (check->fields.version < 0x10) {
+			printk(KERN_WARNING "PnPBIOS: PnP BIOS version %d.%d is not supported\n",
+			       check->fields.version >> 4,
+			       check->fields.version & 15);
+			continue;
+		}
+		printk(KERN_INFO "PnPBIOS: PnP BIOS version %d.%d, entry 0x%x:0x%x, dseg 0x%x\n",
+                       check->fields.version >> 4, check->fields.version & 15,
+		       check->fields.pm16cseg, check->fields.pm16offset,
+		       check->fields.pm16dseg);
+		pnp_bios_install = check;
+		return 1;
+	}
+
+	printk(KERN_INFO "PnPBIOS: PnP BIOS support was not detected.\n");
+	return 0;
+}
 
 int __init pnpbios_init(void)
 {
@@ -421,9 +477,12 @@
 	}
 
 	/* scan the system for pnpbios support */
-	if (!pnpbios_probe_installation())
+	if (!pnpbios_probe_system())
 		return -ENODEV;
 
+	/* make preparations for bios calls */
+	pnpbios_calls_init(pnp_bios_install);
+
 	/* read the node info */
 	if (pnp_bios_dev_node_info(&node_info)) {
 		printk(KERN_ERR "PnPBIOS: Unable to get node info.  Aborting.\n");
@@ -446,6 +505,8 @@
 
 	return 0;
 }
+
+subsys_initcall(pnpbios_init);
 
 static int __init pnpbios_thread_init(void)
 {
diff -Nru a/drivers/pnp/pnpbios/pnpbios.h b/drivers/pnp/pnpbios/pnpbios.h
--- a/drivers/pnp/pnpbios/pnpbios.h	Sun Sep 21 19:46:04 2003
+++ b/drivers/pnp/pnpbios/pnpbios.h	Sun Sep 21 19:46:04 2003
@@ -1,14 +1,38 @@
 /*
- * pnpbios.h - contains definitions for functions used only locally.
+ * pnpbios.h - contains local definitions
  */
 
+#pragma pack(1)
+union pnp_bios_install_struct {
+	struct {
+		u32 signature;    /* "$PnP" */
+		u8 version;	  /* in BCD */
+		u8 length;	  /* length in bytes, currently 21h */
+		u16 control;	  /* system capabilities */
+		u8 checksum;	  /* all bytes must add up to 0 */
+
+		u32 eventflag;    /* phys. address of the event flag */
+		u16 rmoffset;     /* real mode entry point */
+		u16 rmcseg;
+		u16 pm16offset;   /* 16 bit protected mode entry */
+		u32 pm16cseg;
+		u32 deviceID;	  /* EISA encoded system ID or 0 */
+		u16 rmdseg;	  /* real mode data segment */
+		u32 pm16dseg;	  /* 16 bit pm data segment base */
+	} fields;
+	char chars[0x21];	  /* To calculate the checksum */
+};
+#pragma pack()
+
+extern int pnp_bios_present(void);
+
 extern int pnpbios_parse_data_stream(struct pnp_dev *dev, struct pnp_bios_node * node);
 extern int pnpbios_read_resources_from_node(struct pnp_resource_table *res, struct pnp_bios_node * node);
 extern int pnpbios_write_resources_to_node(struct pnp_resource_table *res, struct pnp_bios_node * node);
 extern void pnpid32_to_pnpid(u32 id, char *str);
 
 extern void pnpbios_print_status(const char * module, u16 status);
-extern int pnpbios_probe_installation(void);
+extern void pnpbios_calls_init(union pnp_bios_install_struct * header);
 
 #ifdef CONFIG_PROC_FS
 extern int pnpbios_interface_attach_device(struct pnp_bios_node * node);
