Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263100AbUDORcF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 13:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263041AbUDOR3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 13:29:47 -0400
Received: from mail.kroah.org ([65.200.24.183]:17838 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263007AbUDORYI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 13:24:08 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and PCI Hotplug update for 2.6.6-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <1082049824159@kroah.com>
Date: Thu, 15 Apr 2004 10:23:44 -0700
Message-Id: <10820498243742@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1692.3.1, 2004/03/26 16:11:41-08:00, greg@kroah.com

PCI: add ability to access pci extended config space for PCI Express devices

Patch originally written by Intel, cleaned up and made sane by 
Matthew Wilcox <willy@debian.org> and then tweaked a bit more by me.

>From Matt's original email:
 - Add cfg_size to struct pci_dev.
 - Use it in sysfs and procfs.
 - Introduce pci_find_ext_capability() for finding extended capabilities.
 - Change the PCI_X_STATUS defines to match the spec (mea culpa there).
 - Add defines for the extended capabilities.


 drivers/pci/pci-sysfs.c |   29 ++++++++++----
 drivers/pci/pci.c       |   58 ++++++++++++++++++++++++----
 drivers/pci/probe.c     |   40 +++++++++++++++++++
 drivers/pci/proc.c      |   26 ++++++------
 include/linux/pci.h     |   99 ++++++++++++++++++++++++++++++++++++++++++------
 5 files changed, 212 insertions(+), 40 deletions(-)


diff -Nru a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
--- a/drivers/pci/pci-sysfs.c	Thu Apr 15 10:06:45 2004
+++ b/drivers/pci/pci-sysfs.c	Thu Apr 15 10:06:45 2004
@@ -1,8 +1,8 @@
 /*
  * drivers/pci/pci-sysfs.c
  *
- * (C) Copyright 2002 Greg Kroah-Hartman
- * (C) Copyright 2002 IBM Corp.
+ * (C) Copyright 2002-2004 Greg Kroah-Hartman <greg@kroah.com>
+ * (C) Copyright 2002-2004 IBM Corp.
  * (C) Copyright 2003 Matthew Wilcox
  * (C) Copyright 2003 Hewlett-Packard
  *
@@ -71,7 +71,7 @@
 
 	/* Several chips lock up trying to read undefined config space */
 	if (capable(CAP_SYS_ADMIN)) {
-		size = 256;
+		size = dev->cfg_size;
 	} else if (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS) {
 		size = 128;
 	}
@@ -123,10 +123,10 @@
 	unsigned int size = count;
 	loff_t init_off = off;
 
-	if (off > 256)
+	if (off > dev->cfg_size)
 		return 0;
-	if (off + count > 256) {
-		size = 256 - off;
+	if (off + count > dev->cfg_size) {
+		size = dev->cfg_size - off;
 		count = size;
 	}
 
@@ -167,6 +167,17 @@
 	.write = pci_write_config,
 };
 
+static struct bin_attribute pcie_config_attr = {
+	.attr =	{
+		.name = "config",
+		.mode = S_IRUGO | S_IWUSR,
+		.owner = THIS_MODULE,
+	},
+	.size = 4096,
+	.read = pci_read_config,
+	.write = pci_write_config,
+};
+
 void pci_create_sysfs_dev_files (struct pci_dev *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -179,7 +190,11 @@
 	device_create_file (dev, &dev_attr_class);
 	device_create_file (dev, &dev_attr_irq);
 	device_create_file (dev, &dev_attr_resource);
-	sysfs_create_bin_file(&dev->kobj, &pci_config_attr);
+
+	if (pdev->cfg_size < 4096)
+		sysfs_create_bin_file(&dev->kobj, &pci_config_attr);
+	else
+		sysfs_create_bin_file(&dev->kobj, &pcie_config_attr);
 
 	/* add platform-specific attributes */
 	pcibios_add_platform_entries(pdev);
diff -Nru a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c	Thu Apr 15 10:06:45 2004
+++ b/drivers/pci/pci.c	Thu Apr 15 10:06:45 2004
@@ -111,21 +111,15 @@
  * support it.  Possible values for @cap:
  *
  *  %PCI_CAP_ID_PM           Power Management 
- *
  *  %PCI_CAP_ID_AGP          Accelerated Graphics Port 
- *
  *  %PCI_CAP_ID_VPD          Vital Product Data 
- *
  *  %PCI_CAP_ID_SLOTID       Slot Identification 
- *
  *  %PCI_CAP_ID_MSI          Message Signalled Interrupts
- *
  *  %PCI_CAP_ID_CHSWP        CompactPCI HotSwap 
- *
  *  %PCI_CAP_ID_PCIX         PCI-X
+ *  %PCI_CAP_ID_EXP          PCI Express
  */
-int
-pci_find_capability(struct pci_dev *dev, int cap)
+int pci_find_capability(struct pci_dev *dev, int cap)
 {
 	return __pci_bus_find_cap(dev->bus, dev->devfn, dev->hdr_type, cap);
 }
@@ -150,6 +144,54 @@
 	pci_bus_read_config_byte(bus, devfn, PCI_HEADER_TYPE, &hdr_type);
 
 	return __pci_bus_find_cap(bus, devfn, hdr_type & 0x7f, cap);
+}
+
+/**
+ * pci_find_ext_capability - Find an extended capability
+ * @dev: PCI device to query
+ * @cap: capability code
+ *
+ * Returns the address of the requested extended capability structure
+ * within the device's PCI configuration space or 0 if the device does
+ * not support it.  Possible values for @cap:
+ *
+ *  %PCI_EXT_CAP_ID_ERR		Advanced Error Reporting
+ *  %PCI_EXT_CAP_ID_VC		Virtual Channel
+ *  %PCI_EXT_CAP_ID_DSN		Device Serial Number
+ *  %PCI_EXT_CAP_ID_PWR		Power Budgeting
+ */
+int pci_find_ext_capability(struct pci_dev *dev, int cap)
+{
+	u32 header;
+	int ttl = 480; /* 3840 bytes, minimum 8 bytes per capability */
+	int pos = 0x100;
+
+	if (dev->cfg_size <= 256)
+		return 0;
+
+	if (pci_read_config_dword(dev, pos, &header) != PCIBIOS_SUCCESSFUL)
+		return 0;
+
+	/*
+	 * If we have no capabilities, this is indicated by cap ID,
+	 * cap version and next pointer all being 0.
+	 */
+	if (header == 0)
+		return 0;
+
+	while (ttl-- > 0) {
+		if (PCI_EXT_CAP_ID(header) == cap)
+			return pos;
+
+		pos = PCI_EXT_CAP_NEXT(header);
+		if (pos < 0x100)
+			break;
+
+		if (pci_read_config_dword(dev, pos, &header) != PCIBIOS_SUCCESSFUL)
+			break;
+	}
+
+	return 0;
 }
 
 /**
diff -Nru a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	Thu Apr 15 10:06:45 2004
+++ b/drivers/pci/probe.c	Thu Apr 15 10:06:45 2004
@@ -18,6 +18,8 @@
 
 #define CARDBUS_LATENCY_TIMER	176	/* secondary latency timer */
 #define CARDBUS_RESERVE_BUSNR	3
+#define PCI_CFG_SPACE_SIZE	256
+#define PCI_CFG_SPACE_EXP_SIZE	4096
 
 /* Ugh.  Need to stop exporting this to modules. */
 LIST_HEAD(pci_root_buses);
@@ -530,6 +532,43 @@
 	kfree(pci_dev);
 }
 
+/**
+ * pci_cfg_space_size - get the configuration space size of the PCI device.
+ *
+ * Regular PCI devices have 256 bytes, but PCI-X 2 and PCI Express devices
+ * have 4096 bytes.  Even if the device is capable, that doesn't mean we can
+ * access it.  Maybe we don't have a way to generate extended config space
+ * accesses, or the device is behind a reverse Express bridge.  So we try
+ * reading the dword at 0x100 which must either be 0 or a valid extended
+ * capability header.
+ */
+static int pci_cfg_space_size(struct pci_dev *dev)
+{
+	int pos;
+	u32 status;
+
+	pos = pci_find_capability(dev, PCI_CAP_ID_EXP);
+	if (!pos) {
+		pos = pci_find_capability(dev, PCI_CAP_ID_PCIX);
+		if (!pos)
+			goto fail;
+
+		pci_read_config_dword(dev, pos + PCI_X_STATUS, &status);
+		if (!(status & (PCI_X_STATUS_266MHZ | PCI_X_STATUS_533MHZ)))
+			goto fail;
+	}
+
+	if (pci_read_config_dword(dev, 256, &status) != PCIBIOS_SUCCESSFUL)
+		goto fail;
+	if (status == 0xffffffff)
+		goto fail;
+
+	return PCI_CFG_SPACE_EXP_SIZE;
+
+ fail:
+	return PCI_CFG_SPACE_SIZE;
+}
+
 /*
  * Read the config data for a PCI device, sanity-check it
  * and fill in the dev structure...
@@ -566,6 +605,7 @@
 	dev->multifunction = !!(hdr_type & 0x80);
 	dev->vendor = l & 0xffff;
 	dev->device = (l >> 16) & 0xffff;
+	dev->cfg_size = pci_cfg_space_size(dev);
 
 	/* Assume 32-bit PCI; let 64-bit PCI cards (which are far rarer)
 	   set this higher, assuming the system even supports it.  */
diff -Nru a/drivers/pci/proc.c b/drivers/pci/proc.c
--- a/drivers/pci/proc.c	Thu Apr 15 10:06:45 2004
+++ b/drivers/pci/proc.c	Thu Apr 15 10:06:45 2004
@@ -16,16 +16,15 @@
 #include <asm/uaccess.h>
 #include <asm/byteorder.h>
 
-#define PCI_CFG_SPACE_SIZE 256
-
 static int proc_initialized;	/* = 0 */
 
 static loff_t
 proc_bus_pci_lseek(struct file *file, loff_t off, int whence)
 {
 	loff_t new = -1;
+	struct inode *inode = file->f_dentry->d_inode;
 
-	down(&file->f_dentry->d_inode->i_sem);
+	down(&inode->i_sem);
 	switch (whence) {
 	case 0:
 		new = off;
@@ -34,14 +33,14 @@
 		new = file->f_pos + off;
 		break;
 	case 2:
-		new = PCI_CFG_SPACE_SIZE + off;
+		new = inode->i_size + off;
 		break;
 	}
-	if (new < 0 || new > PCI_CFG_SPACE_SIZE)
+	if (new < 0 || new > inode->i_size)
 		new = -EINVAL;
 	else
 		file->f_pos = new;
-	up(&file->f_dentry->d_inode->i_sem);
+	up(&inode->i_sem);
 	return new;
 }
 
@@ -61,7 +60,7 @@
 	 */
 
 	if (capable(CAP_SYS_ADMIN))
-		size = PCI_CFG_SPACE_SIZE;
+		size = dev->cfg_size;
 	else if (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS)
 		size = 128;
 	else
@@ -134,14 +133,15 @@
 	const struct proc_dir_entry *dp = PDE(ino);
 	struct pci_dev *dev = dp->data;
 	int pos = *ppos;
+	int size = dev->cfg_size;
 	int cnt;
 
-	if (pos >= PCI_CFG_SPACE_SIZE)
+	if (pos >= size)
 		return 0;
-	if (nbytes >= PCI_CFG_SPACE_SIZE)
-		nbytes = PCI_CFG_SPACE_SIZE;
-	if (pos + nbytes > PCI_CFG_SPACE_SIZE)
-		nbytes = PCI_CFG_SPACE_SIZE - pos;
+	if (nbytes >= size)
+		nbytes = size;
+	if (pos + nbytes > size)
+		nbytes = size - pos;
 	cnt = nbytes;
 
 	if (!access_ok(VERIFY_READ, buf, cnt))
@@ -403,7 +403,7 @@
 		return -ENOMEM;
 	e->proc_fops = &proc_bus_pci_operations;
 	e->data = dev;
-	e->size = PCI_CFG_SPACE_SIZE;
+	e->size = dev->cfg_size;
 
 	return 0;
 }
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Thu Apr 15 10:06:45 2004
+++ b/include/linux/pci.h	Thu Apr 15 10:06:45 2004
@@ -305,18 +305,89 @@
 #define  PCI_X_CMD_ERO		0x0002	/* Enable Relaxed Ordering */
 #define  PCI_X_CMD_MAX_READ	0x000c	/* Max Memory Read Byte Count */
 #define  PCI_X_CMD_MAX_SPLIT	0x0070	/* Max Outstanding Split Transactions */
-#define PCI_X_DEVFN		4	/* A copy of devfn. */
-#define PCI_X_BUSNR		5	/* Bus segment number */
-#define PCI_X_STATUS		6	/* PCI-X capabilities */
-#define  PCI_X_STATUS_64BIT	0x0001	/* 64-bit device */
-#define  PCI_X_STATUS_133MHZ	0x0002	/* 133 MHz capable */
-#define  PCI_X_STATUS_SPL_DISC	0x0004	/* Split Completion Discarded */
-#define  PCI_X_STATUS_UNX_SPL	0x0008	/* Unexpected Split Completion */
-#define  PCI_X_STATUS_COMPLEX	0x0010	/* Device Complexity */
-#define  PCI_X_STATUS_MAX_READ	0x0060	/* Designed Maximum Memory Read Count */
-#define  PCI_X_STATUS_MAX_SPLIT	0x0380	/* Design Max Outstanding Split Trans */
-#define  PCI_X_STATUS_MAX_CUM	0x1c00	/* Designed Max Cumulative Read Size */
-#define  PCI_X_STATUS_SPL_ERR	0x2000	/* Rcvd Split Completion Error Msg */
+#define  PCI_X_CMD_VERSION(x) 	(((x) >> 12) & 3) /* Version */
+#define PCI_X_STATUS		4	/* PCI-X capabilities */
+#define  PCI_X_STATUS_DEVFN	0x000000ff	/* A copy of devfn */
+#define  PCI_X_STATUS_BUS	0x0000ff00	/* A copy of bus nr */
+#define  PCI_X_STATUS_64BIT	0x00010000	/* 64-bit device */
+#define  PCI_X_STATUS_133MHZ	0x00020000	/* 133 MHz capable */
+#define  PCI_X_STATUS_SPL_DISC	0x00040000	/* Split Completion Discarded */
+#define  PCI_X_STATUS_UNX_SPL	0x00080000	/* Unexpected Split Completion */
+#define  PCI_X_STATUS_COMPLEX	0x00100000	/* Device Complexity */
+#define  PCI_X_STATUS_MAX_READ	0x00600000	/* Designed Max Memory Read Count */
+#define  PCI_X_STATUS_MAX_SPLIT	0x03800000	/* Designed Max Outstanding Split Transactions */
+#define  PCI_X_STATUS_MAX_CUM	0x1c000000	/* Designed Max Cumulative Read Size */
+#define  PCI_X_STATUS_SPL_ERR	0x20000000	/* Rcvd Split Completion Error Msg */
+#define  PCI_X_STATUS_266MHZ	0x40000000	/* 266 MHz capable */
+#define  PCI_X_STATUS_533MHZ	0x80000000	/* 533 MHz capable */
+
+/* Extended Capabilities (PCI-X 2.0 and Express) */
+#define PCI_EXT_CAP_ID(header)		(header & 0x0000ffff)
+#define PCI_EXT_CAP_VER(header)		((header >> 16) & 0xf)
+#define PCI_EXT_CAP_NEXT(header)	((header >> 20) & 0xffc)
+
+#define PCI_EXT_CAP_ID_ERR	1
+#define PCI_EXT_CAP_ID_VC	2
+#define PCI_EXT_CAP_ID_DSN	3
+#define PCI_EXT_CAP_ID_PWR	4
+
+/* Advanced Error Reporting */
+#define PCI_ERR_UNCOR_STATUS	4	/* Uncorrectable Error Status */
+#define  PCI_ERR_UNC_TRAIN	0x00000001	/* Training */
+#define  PCI_ERR_UNC_DLP	0x00000010	/* Data Link Protocol */
+#define  PCI_ERR_UNC_POISON_TLP	0x00001000	/* Poisoned TLP */
+#define  PCI_ERR_UNC_FCP	0x00002000	/* Flow Control Protocol */
+#define  PCI_ERR_UNC_COMP_TIME	0x00004000	/* Completion Timeout */
+#define  PCI_ERR_UNC_COMP_ABORT	0x00008000	/* Completer Abort */
+#define  PCI_ERR_UNC_UNX_COMP	0x00010000	/* Unexpected Completion */
+#define  PCI_ERR_UNC_RX_OVER	0x00020000	/* Receiver Overflow */
+#define  PCI_ERR_UNC_MALF_TLP	0x00040000	/* Malformed TLP */
+#define  PCI_ERR_UNC_ECRC	0x00080000	/* ECRC Error Status */
+#define  PCI_ERR_UNC_UNSUP	0x00100000	/* Unsupported Request */
+#define PCI_ERR_UNCOR_MASK	8	/* Uncorrectable Error Mask */
+	/* Same bits as above */
+#define PCI_ERR_UNCOR_SEVER	12	/* Uncorrectable Error Severity */
+	/* Same bits as above */
+#define PCI_ERR_COR_STATUS	16	/* Correctable Error Status */
+#define  PCI_ERR_COR_RCVR	0x00000001	/* Receiver Error Status */
+#define  PCI_ERR_COR_BAD_TLP	0x00000040	/* Bad TLP Status */
+#define  PCI_ERR_COR_BAD_DLLP	0x00000080	/* Bad DLLP Status */
+#define  PCI_ERR_COR_REP_ROLL	0x00000100	/* REPLAY_NUM Rollover */
+#define  PCI_ERR_COR_REP_TIMER	0x00001000	/* Replay Timer Timeout */
+#define PCI_ERR_COR_MASK	20	/* Correctable Error Mask */
+	/* Same bits as above */
+#define PCI_ERR_CAP		24	/* Advanced Error Capabilities */
+#define  PCI_ERR_CAP_FEP(x)	((x) & 31)	/* First Error Pointer */
+#define  PCI_ERR_CAP_ECRC_GENC	0x00000020	/* ECRC Generation Capable */
+#define  PCI_ERR_CAP_ECRC_GENE	0x00000040	/* ECRC Generation Enable */
+#define  PCI_ERR_CAP_ECRC_CHKC	0x00000080	/* ECRC Check Capable */
+#define  PCI_ERR_CAP_ECRC_CHKE	0x00000100	/* ECRC Check Enable */
+#define PCI_ERR_HEADER_LOG	28	/* Header Log Register (16 bytes) */
+#define PCI_ERR_ROOT_COMMAND	44	/* Root Error Command */
+#define PCI_ERR_ROOT_STATUS	48
+#define PCI_ERR_ROOT_COR_SRC	52
+#define PCI_ERR_ROOT_SRC	54
+
+/* Virtual Channel */
+#define PCI_VC_PORT_REG1	4
+#define PCI_VC_PORT_REG2	8
+#define PCI_VC_PORT_CTRL	12
+#define PCI_VC_PORT_STATUS	14
+#define PCI_VC_RES_CAP		16
+#define PCI_VC_RES_CTRL		20
+#define PCI_VC_RES_STATUS	26
+
+/* Power Budgeting */
+#define PCI_PWR_DSR		4	/* Data Select Register */
+#define PCI_PWR_DATA		8	/* Data Register */
+#define  PCI_PWR_DATA_BASE(x)	((x) & 0xff)	    /* Base Power */
+#define  PCI_PWR_DATA_SCALE(x)	(((x) >> 8) & 3)    /* Data Scale */
+#define  PCI_PWR_DATA_PM_SUB(x)	(((x) >> 10) & 7)   /* PM Sub State */
+#define  PCI_PWR_DATA_PM_STATE(x) (((x) >> 13) & 3) /* PM State */
+#define  PCI_PWR_DATA_TYPE(x)	(((x) >> 15) & 7)   /* Type */
+#define  PCI_PWR_DATA_RAIL(x)	(((x) >> 18) & 7)   /* Power Rail */
+#define PCI_PWR_CAP		12	/* Capability */
+#define  PCI_PWR_CAP_BUDGET(x)	((x) & 1)	/* Included in system budget */
 
 /* Include the ID list */
 
@@ -403,6 +474,8 @@
 	unsigned short vendor_compatible[DEVICE_COUNT_COMPATIBLE];
 	unsigned short device_compatible[DEVICE_COUNT_COMPATIBLE];
 
+	int		cfg_size;	/* Size of configuration space */
+
 	/*
 	 * Instead of touching interrupt line and base address registers
 	 * directly, use the values stored here. They might be different!
@@ -602,6 +675,7 @@
 struct pci_dev *pci_find_class (unsigned int class, const struct pci_dev *from);
 struct pci_dev *pci_find_slot (unsigned int bus, unsigned int devfn);
 int pci_find_capability (struct pci_dev *dev, int cap);
+int pci_find_ext_capability (struct pci_dev *dev, int cap);
 struct pci_bus * pci_find_next_bus(const struct pci_bus *from);
 
 struct pci_dev *pci_get_device (unsigned int vendor, unsigned int device, struct pci_dev *from);
@@ -768,6 +842,7 @@
 static inline int pci_register_driver(struct pci_driver *drv) { return 0;}
 static inline void pci_unregister_driver(struct pci_driver *drv) { }
 static inline int pci_find_capability (struct pci_dev *dev, int cap) {return 0; }
+static inline int pci_find_ext_capability (struct pci_dev *dev, int cap) {return 0; }
 static inline const struct pci_device_id *pci_match_device(const struct pci_device_id *ids, const struct pci_dev *dev) { return NULL; }
 
 /* Power management related routines */

