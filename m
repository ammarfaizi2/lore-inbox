Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274219AbSITAvO>; Thu, 19 Sep 2002 20:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274209AbSITAuw>; Thu, 19 Sep 2002 20:50:52 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:39434 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S274205AbSITAuJ>;
	Thu, 19 Sep 2002 20:50:09 -0400
Date: Thu, 19 Sep 2002 17:55:01 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [BK PATCH] PCI hotplug changes for 2.5.36
Message-ID: <20020920005500.GD18583@kroah.com>
References: <20020920005408.GA18583@kroah.com> <20020920005428.GB18583@kroah.com> <20020920005444.GC18583@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020920005444.GC18583@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.559   -> 1.560  
#	drivers/hotplug/pci_hotplug_core.c	1.21    -> 1.22   
#	drivers/hotplug/pci_hotplug.h	1.2     -> 1.3    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/19	greg@kroah.com	1.560
# PCI Hotplug: added max bus speed and current bus speed files to the pci hotplug core.
#       
# Patch based on work done by Irene Zubarev <zubarev@us.ibm.com>
# --------------------------------------------
#
diff -Nru a/drivers/hotplug/pci_hotplug.h b/drivers/hotplug/pci_hotplug.h
--- a/drivers/hotplug/pci_hotplug.h	Thu Sep 19 17:50:46 2002
+++ b/drivers/hotplug/pci_hotplug.h	Thu Sep 19 17:50:46 2002
@@ -29,6 +29,22 @@
 #define _PCI_HOTPLUG_H
 
 
+/* These values come from the PCI Hotplug Spec */
+enum pci_bus_speed {
+	PCI_SPEED_33MHz			= 0x00,
+	PCI_SPEED_66MHz			= 0x01,
+	PCI_SPEED_66MHz_PCIX		= 0x02,
+	PCI_SPEED_100MHz_PCIX		= 0x03,
+	PCI_SPEED_133MHz_PCIX		= 0x04,
+	PCI_SPEED_66MHz_PCIX_266	= 0x09,
+	PCI_SPEED_100MHz_PCIX_266	= 0x0a,
+	PCI_SPEED_133MHz_PCIX_266	= 0x0b,
+	PCI_SPEED_66MHz_PCIX_533	= 0x11,
+	PCI_SPEED_100MHz_PCIX_533	= 0X12,
+	PCI_SPEED_133MHz_PCIX_533	= 0x13,
+	PCI_SPEED_UNKNOWN		= 0xff,
+};
+
 struct hotplug_slot;
 struct hotplug_slot_core;
 
@@ -50,7 +66,13 @@
  * @get_latch_status: Called to get the current latch status of a slot.
  *	If this field is NULL, the value passed in the struct hotplug_slot_info
  *	will be used when this value is requested by a user.
- * @get_adapter_present: Called to get see if an adapter is present in the slot or not.
+ * @get_adapter_status: Called to get see if an adapter is present in the slot or not.
+ *	If this field is NULL, the value passed in the struct hotplug_slot_info
+ *	will be used when this value is requested by a user.
+ * @get_max_bus_speed: Called to get the max bus speed for a slot.
+ *	If this field is NULL, the value passed in the struct hotplug_slot_info
+ *	will be used when this value is requested by a user.
+ * @get_cur_bus_speed: Called to get the current bus speed for a slot.
  *	If this field is NULL, the value passed in the struct hotplug_slot_info
  *	will be used when this value is requested by a user.
  *
@@ -69,6 +91,8 @@
 	int (*get_attention_status)	(struct hotplug_slot *slot, u8 *value);
 	int (*get_latch_status)		(struct hotplug_slot *slot, u8 *value);
 	int (*get_adapter_status)	(struct hotplug_slot *slot, u8 *value);
+	int (*get_max_bus_speed)	(struct hotplug_slot *slot, enum pci_bus_speed *value);
+	int (*get_cur_bus_speed)	(struct hotplug_slot *slot, enum pci_bus_speed *value);
 };
 
 /**
@@ -85,6 +109,8 @@
 	u8	attention_status;
 	u8	latch_status;
 	u8	adapter_status;
+	enum pci_bus_speed	max_bus_speed;
+	enum pci_bus_speed	cur_bus_speed;
 };
 
 /**
diff -Nru a/drivers/hotplug/pci_hotplug_core.c b/drivers/hotplug/pci_hotplug_core.c
--- a/drivers/hotplug/pci_hotplug_core.c	Thu Sep 19 17:50:46 2002
+++ b/drivers/hotplug/pci_hotplug_core.c	Thu Sep 19 17:50:46 2002
@@ -75,6 +75,8 @@
 	struct dentry	*latch_dentry;
 	struct dentry	*adapter_dentry;
 	struct dentry	*test_dentry;
+	struct dentry	*max_bus_speed_dentry;
+	struct dentry	*cur_bus_speed_dentry;
 };
 
 static struct super_operations pcihpfs_ops;
@@ -87,6 +89,29 @@
 
 LIST_HEAD(pci_hotplug_slot_list);
 
+/* these strings match up with the values in pci_bus_speed */
+static char *pci_bus_speed_strings[] = {
+	"33 MHz PCI",		/* 0x00 */
+	"66 MHz PCI",		/* 0x01 */
+	"66 MHz PCIX", 		/* 0x02 */
+	"100 MHz PCIX",		/* 0x03 */
+	"133 MHz PCIX",		/* 0x04 */
+	NULL,			/* 0x05 */
+	NULL,			/* 0x06 */
+	NULL,			/* 0x07 */
+	NULL,			/* 0x08 */
+	"66 MHz PCIX 266",	/* 0x09 */
+	"100 MHz PCIX 266",	/* 0x0a */
+	"133 MHz PCIX 266",	/* 0x0b */
+	NULL,			/* 0x0c */
+	NULL,			/* 0x0d */
+	NULL,			/* 0x0e */
+	NULL,			/* 0x0f */
+	NULL,			/* 0x10 */
+	"66 MHz PCIX 533",	/* 0x11 */
+	"100 MHz PCIX 533",	/* 0x12 */
+	"133 MHz PCIX 533",	/* 0x13 */
+};
 
 static struct inode *pcihpfs_get_inode (struct super_block *sb, int mode, int dev)
 {
@@ -275,6 +300,24 @@
 	.llseek =	default_file_lseek,
 };
 
+/* file ops for the "max bus speed" files */
+static ssize_t max_bus_speed_read_file (struct file *file, char *buf, size_t count, loff_t *offset);
+static struct file_operations max_bus_speed_file_operations = {
+	read:		max_bus_speed_read_file,
+	write:		default_write_file,
+	open:		default_open,
+	llseek:		default_file_lseek,
+};
+
+/* file ops for the "current bus speed" files */
+static ssize_t cur_bus_speed_read_file (struct file *file, char *buf, size_t count, loff_t *offset);
+static struct file_operations cur_bus_speed_file_operations = {
+	read:		cur_bus_speed_read_file,
+	write:		default_write_file,
+	open:		default_open,
+	llseek:		default_file_lseek,
+};
+
 /* file ops for the "test" files */
 static ssize_t test_write_file (struct file *file, const char *buf, size_t count, loff_t *ppos);
 static struct file_operations test_file_operations = {
@@ -502,26 +545,28 @@
 	up(&parent->d_inode->i_sem);
 }
 
-#define GET_STATUS(name)	\
-static int get_##name##_status (struct hotplug_slot *slot, u8 *value)	\
+#define GET_STATUS(name,type)	\
+static int get_##name (struct hotplug_slot *slot, type *value)		\
 {									\
 	struct hotplug_slot_ops *ops = slot->ops;			\
 	int retval = 0;							\
 	if (ops->owner)							\
 		__MOD_INC_USE_COUNT(ops->owner);			\
-	if (ops->get_##name##_status)					\
-		retval = ops->get_##name##_status (slot, value);	\
+	if (ops->get_##name)						\
+		retval = ops->get_##name (slot, value);			\
 	else								\
-		*value = slot->info->name##_status;			\
+		*value = slot->info->name;				\
 	if (ops->owner)							\
 		__MOD_DEC_USE_COUNT(ops->owner);			\
 	return retval;							\
 }
 
-GET_STATUS(power)
-GET_STATUS(attention)
-GET_STATUS(latch)
-GET_STATUS(adapter)
+GET_STATUS(power_status, u8)
+GET_STATUS(attention_status, u8)
+GET_STATUS(latch_status, u8)
+GET_STATUS(adapter_status, u8)
+GET_STATUS(max_bus_speed, enum pci_bus_speed)
+GET_STATUS(cur_bus_speed, enum pci_bus_speed)
 
 static ssize_t power_read_file (struct file *file, char *buf, size_t count, loff_t *offset)
 {
@@ -770,7 +815,6 @@
 	return retval;
 }
 
-
 static ssize_t presence_read_file (struct file *file, char *buf, size_t count, loff_t *offset)
 {
 	struct hotplug_slot *slot = file->private_data;
@@ -814,6 +858,108 @@
 	return retval;
 }
 
+static char *unknown_speed = "Unknown bus speed";
+
+static ssize_t max_bus_speed_read_file (struct file *file, char *buf, size_t count, loff_t *offset)
+{
+	struct hotplug_slot *slot = file->private_data;
+	unsigned char *page;
+	char *speed_string;
+	int retval;
+	int len = 0;
+	enum pci_bus_speed value;
+	
+	dbg ("count = %d, offset = %lld\n", count, *offset);
+
+	if (*offset < 0)
+		return -EINVAL;
+	if (count <= 0)
+		return 0;
+	if (*offset != 0)
+		return 0;
+
+	if (slot == NULL) {
+		dbg("slot == NULL???\n");
+		return -ENODEV;
+	}
+
+	page = (unsigned char *)__get_free_page(GFP_KERNEL);
+	if (!page)
+		return -ENOMEM;
+
+	retval = get_max_bus_speed (slot, &value);
+	if (retval)
+		goto exit;
+
+	if (value == PCI_SPEED_UNKNOWN)
+		speed_string = unknown_speed;
+	else
+		speed_string = pci_bus_speed_strings[value];
+	
+	len = sprintf (page, "%s\n", speed_string);
+
+	if (copy_to_user (buf, page, len)) {
+		retval = -EFAULT;
+		goto exit;
+	}
+	*offset += len;
+	retval = len;
+
+exit:
+	free_page((unsigned long)page);
+	return retval;
+}
+
+static ssize_t cur_bus_speed_read_file (struct file *file, char *buf, size_t count, loff_t *offset)
+{
+	struct hotplug_slot *slot = file->private_data;
+	unsigned char *page;
+	char *speed_string;
+	int retval;
+	int len = 0;
+	enum pci_bus_speed value;
+
+	dbg ("count = %d, offset = %lld\n", count, *offset);
+
+	if (*offset < 0)
+		return -EINVAL;
+	if (count <= 0)
+		return 0;
+	if (*offset != 0)
+		return 0;
+
+	if (slot == NULL) {
+		dbg("slot == NULL???\n");
+		return -ENODEV;
+	}
+
+	page = (unsigned char *)__get_free_page(GFP_KERNEL);
+	if (!page)
+		return -ENOMEM;
+
+	retval = get_cur_bus_speed (slot, &value);
+	if (retval)
+		goto exit;
+
+	if (value == PCI_SPEED_UNKNOWN)
+		speed_string = unknown_speed;
+	else
+		speed_string = pci_bus_speed_strings[value];
+	
+	len = sprintf (page, "%s\n", speed_string);
+
+	if (copy_to_user (buf, page, len)) {
+		retval = -EFAULT;
+		goto exit;
+	}
+	*offset += len;
+	retval = len;
+
+exit:
+	free_page((unsigned long)page);
+	return retval;
+}
+
 static ssize_t test_write_file (struct file *file, const char *ubuff, size_t count, loff_t *offset)
 {
 	struct hotplug_slot *slot = file->private_data;
@@ -877,30 +1023,57 @@
 					   S_IFDIR | S_IXUGO | S_IRUGO,
 					   NULL, NULL, NULL);
 	if (core->dir_dentry != NULL) {
-		core->power_dentry = fs_create_file ("power",
-						     S_IFREG | S_IRUGO | S_IWUSR,
-						     core->dir_dentry, slot,
-						     &power_file_operations);
-
-		core->attention_dentry = fs_create_file ("attention",
-							 S_IFREG | S_IRUGO | S_IWUSR,
-							 core->dir_dentry, slot,
-							 &attention_file_operations);
-
-		core->latch_dentry = fs_create_file ("latch",
-						     S_IFREG | S_IRUGO,
-						     core->dir_dentry, slot,
-						     &latch_file_operations);
-
-		core->adapter_dentry = fs_create_file ("adapter",
-						       S_IFREG | S_IRUGO,
-						       core->dir_dentry, slot,
-						       &presence_file_operations);
-
-		core->test_dentry = fs_create_file ("test",
-						    S_IFREG | S_IRUGO | S_IWUSR,
-						    core->dir_dentry, slot,
-						    &test_file_operations);
+		if ((slot->ops->enable_slot) ||
+		    (slot->ops->disable_slot) ||
+		    (slot->ops->get_power_status))
+			core->power_dentry = 
+				fs_create_file ("power",
+						S_IFREG | S_IRUGO | S_IWUSR,
+						core->dir_dentry, slot,
+						&power_file_operations);
+
+		if ((slot->ops->set_attention_status) ||
+		    (slot->ops->get_attention_status))
+			core->attention_dentry =
+				fs_create_file ("attention",
+						S_IFREG | S_IRUGO | S_IWUSR,
+						core->dir_dentry, slot,
+						&attention_file_operations);
+
+		if (slot->ops->get_latch_status)
+			core->latch_dentry = 
+				fs_create_file ("latch",
+						S_IFREG | S_IRUGO,
+						core->dir_dentry, slot,
+						&latch_file_operations);
+
+		if (slot->ops->get_adapter_status)
+			core->adapter_dentry = 
+				fs_create_file ("adapter",
+						S_IFREG | S_IRUGO,
+						core->dir_dentry, slot,
+						&presence_file_operations);
+
+		if (slot->ops->get_max_bus_speed)
+			core->max_bus_speed_dentry = 
+				fs_create_file ("max_bus_speed",
+						S_IFREG | S_IRUGO,
+						core->dir_dentry, slot,
+						&max_bus_speed_file_operations);
+
+		if (slot->ops->get_cur_bus_speed)
+			core->cur_bus_speed_dentry =
+				fs_create_file ("cur_bus_speed",
+						S_IFREG | S_IRUGO,
+						core->dir_dentry, slot,
+						&cur_bus_speed_file_operations);
+
+		if (slot->ops->hardware_test)
+			core->test_dentry =
+				fs_create_file ("test",
+						S_IFREG | S_IRUGO | S_IWUSR,
+						core->dir_dentry, slot,
+						&test_file_operations);
 	}
 	return 0;
 }
@@ -918,6 +1091,10 @@
 			fs_remove_file (core->latch_dentry);
 		if (core->adapter_dentry)
 			fs_remove_file (core->adapter_dentry);
+		if (core->max_bus_speed_dentry)
+			fs_remove_file (core->max_bus_speed_dentry);
+		if (core->cur_bus_speed_dentry)
+			fs_remove_file (core->cur_bus_speed_dentry);
 		if (core->test_dentry)
 			fs_remove_file (core->test_dentry);
 		fs_remove_file (core->dir_dentry);
@@ -970,6 +1147,7 @@
 		return -EINVAL;
 	}
 
+	memset (core, 0, sizeof (struct hotplug_slot_core));
 	slot->core_priv = core;
 
 	list_add (&slot->slot_list, &pci_hotplug_slot_list);
@@ -1064,6 +1242,9 @@
 	if ((core->adapter_dentry) &&
 	    (temp->info->adapter_status != info->adapter_status))
 		update_dentry_inode_time (core->adapter_dentry);
+	if ((core->cur_bus_speed_dentry) &&
+	    (temp->info->cur_bus_speed != info->cur_bus_speed))
+		update_dentry_inode_time (core->cur_bus_speed_dentry);
 
 	memcpy (temp->info, info, sizeof (struct hotplug_slot_info));
 	spin_unlock (&list_lock);
