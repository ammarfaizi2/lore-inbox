Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265008AbTBYBPc>; Mon, 24 Feb 2003 20:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264920AbTBYBOj>; Mon, 24 Feb 2003 20:14:39 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:57103 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264730AbTBYBNq>;
	Mon, 24 Feb 2003 20:13:46 -0500
Subject: Re: [PATCH] PCI hotplug changes for 2.5.63
In-reply-to: <1046135762798@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Mon, 24 Feb 2003 17:16 -0800
Message-id: <10461357624080@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1022.1.5, 2003/02/24 16:26:59-08:00, greg@kroah.com

[PATCH] Compaq PCI Hotplug: move /proc files to sysfs


diff -Nru a/drivers/hotplug/cpqphp.h b/drivers/hotplug/cpqphp.h
--- a/drivers/hotplug/cpqphp.h	Mon Feb 24 17:15:46 2003
+++ b/drivers/hotplug/cpqphp.h	Mon Feb 24 17:15:46 2003
@@ -403,31 +403,8 @@
 #define msg_button_ignore	"PCI slot #%d - button press ignored.  (action in progress...)\n"
 
 
-/* Proc functions for the hotplug controller info */
-#ifdef CONFIG_PROC_FS
-extern int cpqhp_proc_init_ctrl		(void);
-extern int cpqhp_proc_destroy_ctrl	(void);
-extern int cpqhp_proc_create_ctrl	(struct controller *ctrl);
-extern int cpqhp_proc_remove_ctrl	(struct controller *ctrl);
-#else
-static inline int cpqhp_proc_init_ctrl (void)
-{
-	return 0;
-}
-static inline int cpqhp_proc_destroy_ctrl (void)
-{
-	return 0;
-}
-static inline int cpqhp_proc_create_ctrl (struct controller *ctrl)
-{
-	return 0;
-}
-static inline int cpqhp_proc_remove_ctrl (struct controller *ctrl)
-{
-	return 0;
-}
-#endif
-
+/* sysfs functions for the hotplug controller info */
+extern void cpqhp_create_ctrl_files		(struct controller *ctrl);
 
 /* controller functions */
 extern void	cpqhp_pushbutton_thread		(unsigned long event_pointer);
diff -Nru a/drivers/hotplug/cpqphp_core.c b/drivers/hotplug/cpqphp_core.c
--- a/drivers/hotplug/cpqphp_core.c	Mon Feb 24 17:15:46 2003
+++ b/drivers/hotplug/cpqphp_core.c	Mon Feb 24 17:15:46 2003
@@ -1038,6 +1038,7 @@
 	dbg ("    pcix_support           %s\n", ctrl->pcix_support == 0 ? "not supported" : "supported");
 
 	ctrl->pci_dev = pdev;
+	pci_set_drvdata(pdev, ctrl);
 
 	/* make our own copy of the pci bus structure, as we like tweaking it a lot */
 	ctrl->pci_bus = kmalloc (sizeof (*ctrl->pci_bus), GFP_KERNEL);
@@ -1231,11 +1232,7 @@
 	// Done with exclusive hardware access
 	up(&ctrl->crit_sect);
 
-	rc = cpqhp_proc_create_ctrl (ctrl);
-	if (rc) {
-		err("cpqhp_proc_create_ctrl failed\n");
-		goto err_free_irq;
-	}
+	cpqhp_create_ctrl_files (ctrl);
 
 	return 0;
 
@@ -1309,10 +1306,6 @@
 		goto error;
 	}
 
-	retval = cpqhp_proc_init_ctrl();
-	if (retval)
-		goto error;
-
 	initialized = 1;
 
 	return retval;
@@ -1343,8 +1336,6 @@
 	ctrl = cpqhp_ctrl_list;
 
 	while (ctrl) {
-		cpqhp_proc_remove_ctrl (ctrl);
-
 		if (ctrl->hpc_reg) {
 			u16 misc;
 			rc = read_slot_enable (ctrl);
@@ -1431,8 +1422,6 @@
 		}
 	}
 
-	remove_proc_entry("hpc", 0);
-
 	// Stop the notification mechanism
 	cpqhp_event_stop_thread();
 
@@ -1490,9 +1479,6 @@
 
 static void __exit cpqhpc_cleanup(void)
 {
-	dbg("cleaning up proc entries\n");
-	cpqhp_proc_destroy_ctrl();
-
 	dbg("unload_cpqphpd()\n");
 	unload_cpqphpd();
 
diff -Nru a/drivers/hotplug/cpqphp_proc.c b/drivers/hotplug/cpqphp_proc.c
--- a/drivers/hotplug/cpqphp_proc.c	Mon Feb 24 17:15:46 2003
+++ b/drivers/hotplug/cpqphp_proc.c	Mon Feb 24 17:15:46 2003
@@ -2,7 +2,7 @@
  * Compaq Hot Plug Controller Driver
  *
  * Copyright (c) 1995,2001 Compaq Computer Corporation
- * Copyright (c) 2001 Greg Kroah-Hartman (greg@kroah.com)
+ * Copyright (c) 2001,2003 Greg Kroah-Hartman (greg@kroah.com)
  * Copyright (c) 2001 IBM Corp.
  *
  * All rights reserved.
@@ -36,27 +36,20 @@
 #include "cpqphp.h"
 
 
+/* A few routines that create sysfs entries for the hot plug controller */
 
-static struct proc_dir_entry *ctrl_proc_root;
-
-/* A few routines that create proc entries for the hot plug controller */
-
-static int read_ctrl (char *buf, char **start, off_t offset, int len, int *eof, void *data)
+static int show_ctrl (struct device *dev, char *buf)
 {
-	struct controller *ctrl = (struct controller *)data;
+	struct pci_dev *pci_dev;
+	struct controller *ctrl;
 	char * out = buf;
 	int index;
 	struct pci_resource *res;
 
-	if (offset > 0)	return 0; /* no partial requests */
-	len  = 0;
-	*eof = 1;
-
-	out += sprintf(out, "hot plug ctrl Info Page\n");
-	out += sprintf(out, "bus = %d, device = %d, function = %d\n",
-		       ctrl->bus, PCI_SLOT(ctrl->pci_dev->devfn),
-		       PCI_FUNC(ctrl->pci_dev->devfn));
-	out += sprintf(out, "Free resources: memory\n");
+	pci_dev = container_of (dev, struct pci_dev, dev);
+	ctrl = pci_get_drvdata(pci_dev);
+
+	out += sprintf(buf, "Free resources: memory\n");
 	index = 11;
 	res = ctrl->mem_head;
 	while (res && index--) {
@@ -85,29 +78,22 @@
 		res = res->next;
 	}
 
-	*start = buf;
-	len = out-buf;
-
-	return len;
+	return out - buf;
 }
+static DEVICE_ATTR (ctrl, S_IRUGO, show_ctrl, NULL);
 
-static int read_dev (char *buf, char **start, off_t offset, int len, int *eof, void *data)
+static int show_dev (struct device *dev, char *buf)
 {
-	struct controller *ctrl = (struct controller *)data;
+	struct pci_dev *pci_dev;
+	struct controller *ctrl;
 	char * out = buf;
 	int index;
 	struct pci_resource *res;
 	struct pci_func *new_slot;
 	struct slot *slot;
 
-	if (offset > 0)	return 0; /* no partial requests */
-	len  = 0;
-	*eof = 1;
-
-	out += sprintf(out, "hot plug ctrl Info Page\n");
-	out += sprintf(out, "bus = %d, device = %d, function = %d\n",
-		       ctrl->bus, PCI_SLOT(ctrl->pci_dev->devfn),
-		       PCI_FUNC(ctrl->pci_dev->devfn));
+	pci_dev = container_of (dev, struct pci_dev, dev);
+	ctrl = pci_get_drvdata(pci_dev);
 
 	slot=ctrl->slot;
 
@@ -146,52 +132,12 @@
 		slot=slot->next;
 	}
 
-	*start = buf;
-	len = out-buf;
-
-	return len;
+	return out - buf;
 }
+static DEVICE_ATTR (dev, S_IRUGO, show_dev, NULL);
 
-int cpqhp_proc_create_ctrl (struct controller *ctrl)
+void cpqhp_create_ctrl_files (struct controller *ctrl)
 {
-	strcpy(ctrl->proc_name, "hpca");
-	ctrl->proc_name[3] = 'a' + ctrl->bus;
-
-	ctrl->proc_entry = create_proc_entry(ctrl->proc_name, S_IFREG | S_IRUGO, ctrl_proc_root);
-	ctrl->proc_entry->data = ctrl;
-	ctrl->proc_entry->read_proc = &read_ctrl;
-
-	strcpy(ctrl->proc_name2, "slot_a");
-	ctrl->proc_name2[5] = 'a' + ctrl->bus;
-	ctrl->proc_entry2 = create_proc_entry(ctrl->proc_name2, S_IFREG | S_IRUGO, ctrl_proc_root);
-	ctrl->proc_entry2->data = ctrl;
-	ctrl->proc_entry2->read_proc = &read_dev;
-
-	return 0;
+	device_create_file (&ctrl->pci_dev->dev, &dev_attr_ctrl);
+	device_create_file (&ctrl->pci_dev->dev, &dev_attr_dev);
 }
-
-int cpqhp_proc_remove_ctrl (struct controller *ctrl)
-{
-	if (ctrl->proc_entry)
-		remove_proc_entry(ctrl->proc_name, ctrl_proc_root);
-	if (ctrl->proc_entry2)
-		remove_proc_entry(ctrl->proc_name2, ctrl_proc_root);
-
-	return 0;
-}
-	
-int cpqhp_proc_init_ctrl (void)
-{
-	ctrl_proc_root = proc_mkdir("hpc", proc_root_driver);
-	if (!ctrl_proc_root)
-		return -ENOMEM;
-	ctrl_proc_root->owner = THIS_MODULE;
-	return 0;
-}
-
-int cpqhp_proc_destroy_ctrl (void)
-{
-	remove_proc_entry("hpc", proc_root_driver);
-	return 0;
-}
-

