Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268633AbUHLRjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268633AbUHLRjL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 13:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268629AbUHLRjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 13:39:11 -0400
Received: from cantor.suse.de ([195.135.220.2]:30853 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268634AbUHLRhx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 13:37:53 -0400
Date: Thu, 12 Aug 2004 19:37:51 +0200
From: Olaf Hering <olh@suse.de>
To: David Boutcher <boutcher@us.ibm.com>, Olaf Hering <olh@suse.de>
Cc: linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: module.viomap support for ppc64
Message-ID: <20040812173751.GA30564@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,

these 2 patches add support for a modules.viomap to depmod.

It needs also a kernel change.
Current MODULE_DEVICE_TABLE(vio, $table); defines 2 char pointers. I'm
not sure if depmod can really handle it. Where do they point to in the
module binary? I could find an answer, so far. I just declared an array.
According to Segher, the "name" and "compatible" properties have an
undefined size. So we have to pick a value and stick with it. I used 32,
for alignment reasons.

What additional padding is required in VIO_DEVICE_SIZE64?


The depmod change produces a file like that:
/lib/modules/2.6.5-0-pseries64/modules.viomap 
# vio module         name                             compatible                      
ibmveth              network                          IBM,l-lan                       
ibmvscsic            scsi-3                           IBM,v-scsi                      
ibmvscsis            v-scsi-host                      IBM,v-scsi-host                 
hvcs                 serial-server                    hvterm2                         

diff -purNX /suse/olh/kernel/kernel_exclude.txt x/linux-2.6.5/drivers/char/hvcs.c R/linux-2.6.5/drivers/char/hvcs.c
--- x/linux-2.6.5/drivers/char/hvcs.c	2004-08-12 19:01:32.438100493 +0200
+++ R/linux-2.6.5/drivers/char/hvcs.c	2004-08-12 18:06:44.088172299 +0200
@@ -416,7 +416,7 @@ int khvcsd(void *unused)
 
 static struct vio_device_id hvcs_driver_table[] __devinitdata= {
 	{"serial-server", "hvterm2"},
-	{ 0,}
+	{ "", ""}
 };
 MODULE_DEVICE_TABLE(vio, hvcs_driver_table);
 
diff -purNX /suse/olh/kernel/kernel_exclude.txt x/linux-2.6.5/drivers/net/ibmveth.c R/linux-2.6.5/drivers/net/ibmveth.c
--- x/linux-2.6.5/drivers/net/ibmveth.c	2004-08-12 19:02:22.639596208 +0200
+++ R/linux-2.6.5/drivers/net/ibmveth.c	2004-08-12 18:07:38.302627485 +0200
@@ -1123,7 +1123,7 @@ static void ibmveth_proc_unregister_driv
 
 static struct vio_device_id ibmveth_device_table[] __devinitdata= {
 	{ "network", "IBM,l-lan"},
-	{ 0,}
+	{ "",""}
 };
 
 MODULE_DEVICE_TABLE(vio, ibmveth_device_table);
diff -purNX /suse/olh/kernel/kernel_exclude.txt x/linux-2.6.5/drivers/scsi/ibmvscsi/ibmvscsis.c R/linux-2.6.5/drivers/scsi/ibmvscsi/ibmvscsis.c
--- x/linux-2.6.5/drivers/scsi/ibmvscsi/ibmvscsis.c	2004-08-12 19:01:32.336116964 +0200
+++ R/linux-2.6.5/drivers/scsi/ibmvscsi/ibmvscsis.c	2004-08-12 18:07:10.481881479 +0200
@@ -2754,7 +2754,7 @@ static int ibmvscsis_remove(struct vio_d
 
 static struct vio_device_id ibmvscsis_device_table[] __devinitdata = {
 	{"v-scsi-host", "IBM,v-scsi-host"},
-	{0,}
+	{"", ""}
 };
 
 MODULE_DEVICE_TABLE(vio, ibmvscsis_device_table);
diff -purNX /suse/olh/kernel/kernel_exclude.txt x/linux-2.6.5/drivers/scsi/ibmvscsi/rpa_vscsi.c R/linux-2.6.5/drivers/scsi/ibmvscsi/rpa_vscsi.c
--- x/linux-2.6.5/drivers/scsi/ibmvscsi/rpa_vscsi.c	2004-08-12 19:01:32.261995623 +0200
+++ R/linux-2.6.5/drivers/scsi/ibmvscsi/rpa_vscsi.c	2004-08-12 18:05:39.506800342 +0200
@@ -270,7 +270,7 @@ static struct vio_device_id rpa_device_t
 	{"scsi-3", "IBM,v-scsi"},	/* Note: This entry can go away when 
 					   all the firmware is up to date */
 	{"vscsi", "IBM,v-scsi"},
-	{0,}
+	{"", ""}
 };
 
 /**
diff -purNX /suse/olh/kernel/kernel_exclude.txt x/linux-2.6.5/include/asm-ppc64/vio.h R/linux-2.6.5/include/asm-ppc64/vio.h
--- x/linux-2.6.5/include/asm-ppc64/vio.h	2004-08-12 19:01:24.135107346 +0200
+++ R/linux-2.6.5/include/asm-ppc64/vio.h	2004-08-12 18:07:40.535531015 +0200
@@ -85,9 +85,10 @@ static inline int vio_set_dma_mask(struc
 
 extern struct bus_type vio_bus_type;
 
+#define VIO_DEVTABLE_PROPERTY_LENGTH 32
 struct vio_device_id {
-	char *type;
-	char *compat;
+	char type[VIO_DEVTABLE_PROPERTY_LENGTH];
+	char compat[VIO_DEVTABLE_PROPERTY_LENGTH];
 };
 
 struct vio_driver {



diff -p -purN module-init-tools-3.0-pre10.orig/depmod.c module-init-tools-3.0-pre10/depmod.c
--- module-init-tools-3.0-pre10.orig/depmod.c	2004-01-23 02:28:17.000000000 +0100
+++ module-init-tools-3.0-pre10/depmod.c	2004-08-12 19:18:04.236399137 +0200
@@ -595,6 +595,7 @@ static struct depfile depfiles[] = {
 	{ "modules.usbmap", output_usb_table },
 	{ "modules.ccwmap", output_ccw_table },
 	{ "modules.ieee1394map", output_ieee1394_table },
+	{ "modules.viomap", output_vio_table },
 	{ "modules.isapnpmap", output_isapnp_table },
 	{ "modules.inputmap", output_input_table },
 	{ "modules.alias", output_aliases },
diff -p -purN module-init-tools-3.0-pre10.orig/depmod.h module-init-tools-3.0-pre10/depmod.h
--- module-init-tools-3.0-pre10.orig/depmod.h	2003-12-24 03:10:57.000000000 +0100
+++ module-init-tools-3.0-pre10/depmod.h	2004-08-12 14:57:28.000000000 +0200
@@ -36,6 +36,8 @@ struct module
 	void *pci_table;
 	unsigned int usb_size;
 	void *usb_table;
+	unsigned int vio_size;
+	void *vio_table;
 	unsigned int ieee1394_size;
 	void *ieee1394_table;
 	unsigned int ccw_size;
diff -p -purN module-init-tools-3.0-pre10.orig/moduleops_core.c module-init-tools-3.0-pre10/moduleops_core.c
--- module-init-tools-3.0-pre10.orig/moduleops_core.c	2003-12-24 06:17:07.000000000 +0100
+++ module-init-tools-3.0-pre10/moduleops_core.c	2004-08-12 15:21:44.000000000 +0200
@@ -176,6 +176,10 @@ static void PERBIT(fetch_tables)(struct 
 	module->ccw_table = PERBIT(deref_sym)(module->data,
 					"__mod_ccw_device_table");
 
+	module->vio_size = PERBIT(VIO_DEVICE_SIZE);
+	module->vio_table = PERBIT(deref_sym)(module->data,
+					"__mod_vio_device_table");
+
 	module->ieee1394_size = PERBIT(IEEE1394_DEVICE_SIZE);
 	module->ieee1394_table = PERBIT(deref_sym)(module->data,
 					"__mod_ieee1394_device_table");
diff -p -purN module-init-tools-3.0-pre10.orig/tables.c module-init-tools-3.0-pre10/tables.c
--- module-init-tools-3.0-pre10.orig/tables.c	2003-12-24 06:23:38.000000000 +0100
+++ module-init-tools-3.0-pre10/tables.c	2004-08-12 19:19:01.708780583 +0200
@@ -127,7 +127,31 @@ void output_ieee1394_table(struct module
 			output_ieee1394_entry(fw, shortname, out);
 	}
 }
+static void output_vio_entry(struct vio_device_id *fw, char *name, FILE *out)
+{
+	fprintf(out, "%-20s %-32s %s\n",
+		name, fw->name, fw->compat);
+}
 
+void output_vio_table(struct module *modules, FILE *out)
+{
+	struct module *i;
+
+	fprintf(out, "%-20s %-32s compatible\n", "# vio module", "name");
+
+	for (i = modules; i; i = i->next) {
+		struct vio_device_id *fw;
+		char shortname[strlen(i->pathname) + 1];
+
+		if (!i->vio_table)
+			continue;
+		
+		make_shortname(shortname, i->pathname);
+		for (fw = i->vio_table; *fw->name;
+		     fw = (void *) fw + i->vio_size)
+			output_vio_entry(fw, shortname, out);
+	}
+}
 
 /* We set driver_data to zero */
 static void output_ccw_entry(struct ccw_device_id *ccw, char *name, FILE *out)
diff -p -purN module-init-tools-3.0-pre10.orig/tables.h module-init-tools-3.0-pre10/tables.h
--- module-init-tools-3.0-pre10.orig/tables.h	2003-12-24 06:18:54.000000000 +0100
+++ module-init-tools-3.0-pre10/tables.h	2004-08-12 18:09:54.000000000 +0200
@@ -35,6 +35,15 @@ struct usb_device_id {
 #define USB_DEVICE_SIZE32 (5 * 2 + 6 * 1 + 4)
 #define USB_DEVICE_SIZE64 (5 * 2 + 6 * 1 + 8)
 
+#define VIO_DEVTABLE_PROPERTY_LENGTH 32
+struct vio_device_id {
+	char name[VIO_DEVTABLE_PROPERTY_LENGTH];
+	char compat[VIO_DEVTABLE_PROPERTY_LENGTH];
+};
+
+#define VIO_DEVICE_SIZE32 (2 * VIO_DEVTABLE_PROPERTY_LENGTH + 4)
+#define VIO_DEVICE_SIZE64 (2 * VIO_DEVTABLE_PROPERTY_LENGTH + 8)
+
 struct ieee1394_device_id {
 	unsigned int match_flags;
 	unsigned int vendor_id;
@@ -119,6 +128,7 @@ struct input_device_id_32 {
 /* Functions provided by tables.c */
 struct module;
 void output_usb_table(struct module *modules, FILE *out);
+void output_vio_table(struct module *modules, FILE *out);
 void output_ieee1394_table(struct module *modules, FILE *out);
 void output_pci_table(struct module *modules, FILE *out);
 void output_ccw_table(struct module *modules, FILE *out);
-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
