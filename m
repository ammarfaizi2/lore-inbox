Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263991AbTAXSPt>; Fri, 24 Jan 2003 13:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264620AbTAXSPt>; Fri, 24 Jan 2003 13:15:49 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:24330 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S263991AbTAXSPn>; Fri, 24 Jan 2003 13:15:43 -0500
Date: Fri, 24 Jan 2003 21:24:03 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@redhat.com>,
       willy@debian.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch 2.5] pci_{save,restore}_extended_state
Message-ID: <20030124212403.A25285@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Existing pci_{save,restore}_state() functions take care only
of first 64 bytes of the PCI config space. It's not sufficient
for modern (especially PCI-X) hardware, which usually have extra
config registers (defined by Capabilities List) located above
64-byte boundary.

The patch adds 3 new functions:
- pci_alloc_extended_state - allocates buffer large enough to hold
  standard PCI 2.1 configuration registers (first 64 bytes of configuration
  header) plus space for extended configuration registers defined by
  Capabilities List (if present);
- pci_save_extended_state - save the PCI configuration space of a device
  before suspending or reset, including extended configuration registers;
- pci_restore_extended_state - restore the saved state of a PCI device,
  including extended configuration. Note that it doesn't restore Power
  Management registers - in conjunction with pci_set_power_state() it
  could produce nasty effects.

pci.h: added missing SIZEOFs for each capability as per PCI specs.
I'm not 100% sure about PCI_CHSWP_SIZEOF and PCI_X_SIZEOF - somebody
with respective specs in hands (Matthew?) ought to verify this...

Ivan.

--- 2.5.59/drivers/pci/pci.c	Fri Jan 17 05:21:48 2003
+++ linux/drivers/pci/pci.c	Tue Jan 21 15:32:25 2003
@@ -67,6 +67,29 @@ pci_max_busnr(void)
 	return max;
 }
 
+static u8
+get_cap_pos(struct pci_dev *dev)
+{
+	u8 pos;
+	u16 status;
+
+	pci_read_config_word(dev, PCI_STATUS, &status);
+	if (!(status & PCI_STATUS_CAP_LIST))
+		return 0;
+	switch (dev->hdr_type) {
+	case PCI_HEADER_TYPE_NORMAL:
+	case PCI_HEADER_TYPE_BRIDGE:
+		pci_read_config_byte(dev, PCI_CAPABILITY_LIST, &pos);
+		break;
+	case PCI_HEADER_TYPE_CARDBUS:
+		pci_read_config_byte(dev, PCI_CB_CAPABILITY_LIST, &pos);
+		break;
+	default:
+		return 0;
+	}
+	return pos;
+}
+
 /**
  * pci_find_capability - query for devices' capabilities 
  * @dev: PCI device to query
@@ -94,24 +117,10 @@ pci_max_busnr(void)
 int
 pci_find_capability(struct pci_dev *dev, int cap)
 {
-	u16 status;
 	u8 pos, id;
 	int ttl = 48;
 
-	pci_read_config_word(dev, PCI_STATUS, &status);
-	if (!(status & PCI_STATUS_CAP_LIST))
-		return 0;
-	switch (dev->hdr_type) {
-	case PCI_HEADER_TYPE_NORMAL:
-	case PCI_HEADER_TYPE_BRIDGE:
-		pci_read_config_byte(dev, PCI_CAPABILITY_LIST, &pos);
-		break;
-	case PCI_HEADER_TYPE_CARDBUS:
-		pci_read_config_byte(dev, PCI_CB_CAPABILITY_LIST, &pos);
-		break;
-	default:
-		return 0;
-	}
+	pos = get_cap_pos(dev);
 	while (ttl-- && pos >= 0x40) {
 		pos &= ~3;
 		pci_read_config_byte(dev, pos + PCI_CAP_LIST_ID, &id);
@@ -327,6 +336,116 @@ pci_restore_state(struct pci_dev *dev, u
 	return 0;
 }
 
+static int
+get_cap_size(u32 cap)
+{
+	switch (cap & 0xff) {
+	case PCI_CAP_ID_PM:
+		return PCI_PM_SIZEOF;
+	case PCI_CAP_ID_AGP:
+		return PCI_AGP_SIZEOF;
+	case PCI_CAP_ID_VPD:
+		return PCI_VPD_SIZEOF;
+	case PCI_CAP_ID_SLOTID:
+		return PCI_SID_SIZEOF;
+	case PCI_CAP_ID_MSI:
+		return cap & (PCI_MSI_FLAGS_64BIT << 16) ? PCI_MSI64_SIZEOF :
+							   PCI_MSI32_SIZEOF;
+	case PCI_CAP_ID_CHSWP:
+		return PCI_CHSWP_SIZEOF;
+	case PCI_CAP_ID_PCIX:
+		return PCI_X_SIZEOF;
+	default:
+		return PCI_CAP_SIZEOF;
+	}
+}
+
+/**
+ * pci_alloc_extended_state - allocates buffer large enough to hold
+ * standard PCI 2.1 configuration registers (first 64 bytes of configuration
+ * header) plus space for extended configuration registers defined by
+ * Capabilities List (if present)
+ * @dev: - PCI device that we're dealing with
+ */
+u32 *
+pci_alloc_extended_state(struct pci_dev *dev)
+{
+	u8 pos;
+	u32 cap;
+	int ttl = 48, size = 64;
+
+	pos = get_cap_pos(dev) & ~3;
+	while (ttl-- && pos >= 0x40) {
+		pci_read_config_dword(dev, pos, &cap);
+		size += (get_cap_size(cap) + 3) & ~3;	/* round up to dword */
+		pos = (cap >> 8) & 0xfc;
+	}
+	return kmalloc(size, GFP_KERNEL);
+}
+
+/**
+ * pci_save_extended_state - save the PCI configuration space of a device
+ * before suspending, including extended configuration registers defined by
+ * Capabilities List
+ * @dev: - PCI device that we're dealing with
+ * @buffer: - buffer to hold config space context
+ *
+ * @buffer must be allocated by pci_alloc_extended_state
+ * (>= 64 bytes).
+ */
+int
+pci_save_extended_state(struct pci_dev *dev, u32 *buf)
+{
+	u32 *ptr = buf + 16;
+	u8 pos, next_pos;
+	int ttl = 48, i, cap_size;
+
+	if (!buf)
+		return 0;
+	pci_save_state(dev, buf);
+	pos = get_cap_pos(dev) & ~3;
+	while (ttl-- && pos >= 0x40) {
+		pci_read_config_dword(dev, pos, ptr);
+		next_pos = (*ptr >> 8) & 0xfc;
+		cap_size = get_cap_size(*ptr++);
+		for (i = 4; i < cap_size; i += 4, ptr++)
+			pci_read_config_dword(dev, pos + i, ptr);
+		pos = next_pos;
+	}
+	return 0;
+}
+
+/** 
+ * pci_restore_extended_state - restore the saved state of a PCI device,
+ * including extended configuration registers defined by Capabilities List
+ * @dev: - PCI device that we're dealing with
+ * @buffer: - saved PCI config space
+ */
+int
+pci_restore_extended_state(struct pci_dev *dev, u32 *buf)
+{
+	u32 *ptr = buf + 16;
+	u8 pos, next_pos;
+	int i, cap_size;
+
+	pci_restore_state(dev, buf);
+	if (!buf)
+		return 0;
+	pos = get_cap_pos(dev) & ~3;
+	while (pos >= 0x40) {
+		u8 cap_id = *ptr & 0xff;
+
+		cap_size = get_cap_size(*ptr);
+		next_pos = (*ptr >> 8) & 0xfc;
+		for (i = 0; i < cap_size; i += 4, ptr++)
+			/* Don't restore PM state! */
+			if (cap_id != PCI_CAP_ID_PM)
+				pci_write_config_dword(dev, pos + i, *ptr);
+		pos = next_pos;
+	}
+	return 0;
+}
+
 /**
  * pci_enable_device_bars - Initialize some of a device for use
  * @dev: PCI device to be initialized
@@ -757,6 +876,9 @@ EXPORT_SYMBOL(pci_find_parent_resource);
 EXPORT_SYMBOL(pci_set_power_state);
 EXPORT_SYMBOL(pci_save_state);
 EXPORT_SYMBOL(pci_restore_state);
+EXPORT_SYMBOL(pci_alloc_extended_state);
+EXPORT_SYMBOL(pci_save_extended_state);
+EXPORT_SYMBOL(pci_restore_extended_state);
 EXPORT_SYMBOL(pci_enable_wake);
 
 /* Quirk info */
--- 2.5.59/include/linux/pci.h	Fri Jan 17 05:22:08 2003
+++ linux/include/linux/pci.h	Tue Jan 21 15:56:54 2003
@@ -258,6 +258,7 @@
 #define  PCI_VPD_ADDR_MASK	0x7fff	/* Address mask */
 #define  PCI_VPD_ADDR_F		0x8000	/* Write 0, 1 indicates completion */
 #define PCI_VPD_DATA		4	/* 32-bits of data returned here */
+#define PCI_VPD_SIZEOF		8
 
 /* Slot Identification */
 
@@ -265,6 +266,7 @@
 #define  PCI_SID_ESR_NSLOTS	0x1f	/* Number of expansion slots available */
 #define  PCI_SID_ESR_FIC	0x20	/* First In Chassis Flag */
 #define PCI_SID_CHASSIS_NR	3	/* Chassis Number */
+#define PCI_SID_SIZEOF		4
 
 /* Message Signalled Interrupts registers */
 
@@ -278,6 +280,8 @@
 #define PCI_MSI_ADDRESS_HI	8	/* Upper 32 bits (if PCI_MSI_FLAGS_64BIT set) */
 #define PCI_MSI_DATA_32		8	/* 16 bits of data for 32-bit devices */
 #define PCI_MSI_DATA_64		12	/* 16 bits of data for 64-bit devices */
+#define PCI_MSI32_SIZEOF	10
+#define PCI_MSI64_SIZEOF	14
 
 /* CompactPCI Hotswap Register */
 
@@ -289,6 +293,7 @@
 #define  PCI_CHSWP_PI		0x30	/* Programming Interface */
 #define  PCI_CHSWP_EXT		0x40	/* ENUM# status - extraction */
 #define  PCI_CHSWP_INS		0x80	/* ENUM# status - insertion */
+#define PCI_CHSWP_SIZEOF	4
 
 /* PCI-X registers */
 
@@ -309,6 +314,7 @@
 #define  PCI_X_STATUS_MAX_SPLIT	0x0380	/* Design Max Outstanding Split Trans */
 #define  PCI_X_STATUS_MAX_CUM	0x1c00	/* Designed Max Cumulative Read Size */
 #define  PCI_X_STATUS_SPL_ERR	0x2000	/* Rcvd Split Completion Error Msg */
+#define PCI_X_SIZEOF		9
 
 /* Include the ID list */
 
@@ -629,6 +635,9 @@ int pci_assign_resource(struct pci_dev *
 /* Power management related routines */
 int pci_save_state(struct pci_dev *dev, u32 *buffer);
 int pci_restore_state(struct pci_dev *dev, u32 *buffer);
+u32 *pci_alloc_extended_state(struct pci_dev *dev);
+int pci_save_extended_state(struct pci_dev *dev, u32 *buffer);
+int pci_restore_extended_state(struct pci_dev *dev, u32 *buffer);
 int pci_set_power_state(struct pci_dev *dev, int state);
 int pci_enable_wake(struct pci_dev *dev, u32 state, int enable);
 
