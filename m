Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289667AbSAWElX>; Tue, 22 Jan 2002 23:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289670AbSAWElN>; Tue, 22 Jan 2002 23:41:13 -0500
Received: from magic.adaptec.com ([208.236.45.80]:57589 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S289668AbSAWElF>; Tue, 22 Jan 2002 23:41:05 -0500
Date: Tue, 22 Jan 2002 21:38:04 -0700
From: Scott Long <scott_long@btc.adaptec.com>
To: linux-kernel@vger.kernel.org, linux@transmeta.com
Subject: CMD640 patch
Message-ID: <20020123043803.GB32417@hollin.btc.adaptec.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

Attached is a patch to the CMD640 driver that converts it to use the
standard PCI layer for config and register access.  The changes are
conditionalized on 2.4.0 and above, though I'm not too concerned about
it getting into 2.2.x.  The old method blindly gropes through the PCI
config space.  This is bad because on some chipsets these accesses
leak onto the PCI bus as IO port accesses.  Please send me your
comments on this, and I hope to have it accepted into the tree.

Thanks,

Scott Long

--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cmd640.diff"

--- /usr/src/linux-2.4-17/drivers/ide/cmd640.c.orig	Tue Jan 22 21:14:49 2002
+++ /usr/src/linux-2.4-17/drivers/ide/cmd640.c		Tue Jan 22 21:16:39 2002
@@ -112,6 +112,9 @@
 #include <linux/hdreg.h>
 #include <linux/ide.h>
 #include <linux/init.h>
+#include <linux/version.h>
+#include <linux/pci.h>
+#include <linux/module.h>
 
 #include <asm/io.h>
 
@@ -205,6 +208,35 @@
  */
 static unsigned int cmd640_chip_version;
 
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
+
+/*
+ * XXX Assumes only one of these devices is present.  The original code
+ * assumes this too, so this shouldn't be a problem.
+ */
+static struct pci_dev *cmd640_pdev;
+
+/*
+ * The CMD640x chip does not support DWORD config write cycles, but some
+ * of the BIOSes use them to implement the config services.
+ * Fortunately, in 2.4.x, the pci layer prefers the 'direct' access method,
+ * which does only byte access.
+ */
+static void put_cmd640_reg_pci (unsigned short reg, byte val)
+{
+	pci_write_config_byte(cmd640_pdev, reg, val);
+}
+
+static byte get_cmd640_reg_pci (unsigned short reg)
+{
+	byte val;
+
+	pci_read_config_byte(cmd640_pdev, reg, &val);
+
+	return val;
+}
+
+#else /* !KERNEL_VERSION(2,4,0) */
 /*
  * The CMD640x chip does not support DWORD config write cycles, but some
  * of the BIOSes use them to implement the config services.
@@ -264,6 +296,7 @@
 	restore_flags(flags);
 	return b;
 }
+#endif /* !KERNEL_VERSION(2,4,0) */
 
 /* VLB access */
 
@@ -291,6 +324,38 @@
 	return b;
 }
 
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
+static struct pci_device_id cmd640_pci_id_table[] = {
+	{
+		0x1095, 0x0640, PCI_ANY_ID, PCI_ANY_ID,
+		PCI_CLASS_STORAGE_IDE << 8, 0xffff00, 0
+	}
+};
+
+MODULE_DEVICE_TABLE(pci, cmd640_pci_id_table);
+
+static int __init
+cmd640_pci_dev_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	/*
+	 * PCI device and vendor where already matched by pci code, no
+	 * need to do it again.
+	 */
+	get_cmd640_reg = get_cmd640_reg_pci;
+	put_cmd640_reg = put_cmd640_reg_pci;
+	cmd640_pdev = pdev;
+
+	return 0;
+}
+
+struct pci_driver cmd640_pci_driver = {
+	name:		"cmd640",
+	probe:		cmd640_pci_dev_probe,
+	remove:		NULL,
+	id_table:	cmd640_pci_id_table
+};
+
+#else /* !KERNEL_VERSION(2,4,0) */ 
 static int __init match_pci_cmd640_device (void)
 {
 	const byte ven_dev[4] = {0x95, 0x10, 0x40, 0x06};
@@ -335,6 +400,7 @@
 	}
 	return 0;
 }
+#endif /* !KERNEL_VERSION(2,4,0) */
 
 /*
  * Probe for CMD640x -- vlb
@@ -709,12 +775,23 @@
 		bus_type = "VLB";
 	} else {
 		cmd640_vlb = 0;
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
+		if (pci_module_init(&cmd640_pci_driver) != 0)
+			return 0;
+
+/* XXX Assumes only one of these devices is present. */
+		if (cmd640_pdev == NULL)
+			return 0;
+
+		bus_type = "PCI";
+#else /* !KERNEL_VERSION(2,4,0) */
 		if (probe_for_cmd640_pci1())
 			bus_type = "PCI (type1)";
 		else if (probe_for_cmd640_pci2())
 			bus_type = "PCI (type2)";
 		else
 			return 0;
+#endif /* !KERNEL_VERSION(2,4,0) */
 	}
 	/*
 	 * Undocumented magic (there is no 0x5b reg in specs)

--6c2NcOVqGQ03X4Wi--
