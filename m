Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261451AbTAYRS2>; Sat, 25 Jan 2003 12:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261518AbTAYRS2>; Sat, 25 Jan 2003 12:18:28 -0500
Received: from [195.208.223.236] ([195.208.223.236]:17280 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S261451AbTAYRSY>; Sat, 25 Jan 2003 12:18:24 -0500
Date: Sat, 25 Jan 2003 20:25:13 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Matthew Wilcox <willy@debian.org>,
       "Wiedemeier, Jeff" <Jeff.Wiedemeier@hp.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: [patch 2.5] pci_{save,restore}_extended_state, corrected
Message-ID: <20030125202513.A1283@localhost.park.msu.ru>
References: <20030124212403.A25285@jurassic.park.msu.ru> <20030125085248.A4882@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030125085248.A4882@parcelfarce.linux.theplanet.co.uk>; from willy@debian.org on Sat, Jan 25, 2003 at 08:52:48AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2003 at 08:52:48AM +0000, Matthew Wilcox wrote:
> PCI-X is 8 bytes -- ID, Next capability, 2-byte `Command', 4-byte `Status'

Thanks, corrected.
 
> Except PCI-X bridges, which are 16-bytes long.  And I didn't write down the
> definition for those.

We can ignore them for now as a special case. I've yet to see the ppb
spec update.

> Hotswap uses only 3 bytes, but the 4th byte is `reserved' so better save
> 4 bytes rather than 3.

Fine.

Here's the corrected patch:
- fixed PCI_X_SIZEOF;
- Jeff's "pci_using_msi" patch is included, with some additions:
  - check whether the dev->irq is configured;
  - add "broken_msi" bit to struct pci_dev, for quirks.
    I believe the MSI hardware will become quite popular even on
    desktop PCs in a year or two, because it's *very* simple and
    elegant way to awoid "4 pins per slot" limitation and to get
    rid of those ugly IRQ routers. On the other hand, MSI is just
    peer-to-peer DMA, which is horribly broken on a lot of PCs.
    So let's be prepared.

Ivan.

--- 2.5.59/drivers/pci/pci.c	Tue Dec 10 09:07:10 2002
+++ linux/drivers/pci/pci.c	Sat Jan 25 19:19:41 2003
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
@@ -679,6 +798,27 @@ pci_clear_mwi(struct pci_dev *dev)
 	}
 }
 
+/**
+ * pci_using_msi - is this PCI device configured to use MSI?
+ * @dev: PCI device structure of device being queried
+ *
+ * Tells whether or not a PCI device is configured to use Message Signalled
+ * Interrupts. Returns non-zero if configured for MSI, else 0.
+ */
+int
+pci_using_msi(struct pci_dev *dev)
+{
+	int msi = pci_find_capability(dev, PCI_CAP_ID_MSI);
+	u8 flags;
+
+	if (!msi || !dev->irq || dev->broken_msi)
+		return 0;
+
+	pci_read_config_byte(dev, msi + PCI_MSI_FLAGS, &flags);
+
+	return (flags & PCI_MSI_FLAGS_ENABLE);
+}
+
 int
 pci_set_dma_mask(struct pci_dev *dev, u64 mask)
 {
@@ -749,6 +889,7 @@ EXPORT_SYMBOL(pci_request_region);
 EXPORT_SYMBOL(pci_set_master);
 EXPORT_SYMBOL(pci_set_mwi);
 EXPORT_SYMBOL(pci_clear_mwi);
+EXPORT_SYMBOL(pci_using_msi);
 EXPORT_SYMBOL(pci_set_dma_mask);
 EXPORT_SYMBOL(pci_dac_set_dma_mask);
 EXPORT_SYMBOL(pci_assign_resource);
@@ -757,6 +898,9 @@ EXPORT_SYMBOL(pci_find_parent_resource);
 EXPORT_SYMBOL(pci_set_power_state);
 EXPORT_SYMBOL(pci_save_state);
 EXPORT_SYMBOL(pci_restore_state);
+EXPORT_SYMBOL(pci_alloc_extended_state);
+EXPORT_SYMBOL(pci_save_extended_state);
+EXPORT_SYMBOL(pci_restore_extended_state);
 EXPORT_SYMBOL(pci_enable_wake);
 
 /* Quirk info */
--- 2.5.59/include/linux/pci.h	Fri Jan  3 14:53:32 2003
+++ linux/include/linux/pci.h	Sat Jan 25 19:13:50 2003
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
+#define PCI_X_SIZEOF		8
 
 /* Include the ID list */
 
@@ -412,7 +418,10 @@ struct pci_dev {
 	char		slot_name[8];	/* slot name */
 
 	/* These fields are used by common fixups */
-	unsigned int	transparent:1;	/* Transparent PCI bridge */
+	unsigned int	transparent:1,	/* Transparent PCI bridge */
+			broken_msi:1;	/* The device claims MSI capabability,
+					   but MSI doesn't work for whatever
+					   reason */
 };
 
 #define pci_dev_g(n) list_entry(n, struct pci_dev, global_list)
@@ -622,6 +631,7 @@ void pci_set_master(struct pci_dev *dev)
 #define HAVE_PCI_SET_MWI
 int pci_set_mwi(struct pci_dev *dev);
 void pci_clear_mwi(struct pci_dev *dev);
+int pci_using_msi(struct pci_dev *dev);
 int pci_set_dma_mask(struct pci_dev *dev, u64 mask);
 int pci_dac_set_dma_mask(struct pci_dev *dev, u64 mask);
 int pci_assign_resource(struct pci_dev *dev, int i);
@@ -629,6 +639,9 @@ int pci_assign_resource(struct pci_dev *
 /* Power management related routines */
 int pci_save_state(struct pci_dev *dev, u32 *buffer);
 int pci_restore_state(struct pci_dev *dev, u32 *buffer);
+u32 *pci_alloc_extended_state(struct pci_dev *dev);
+int pci_save_extended_state(struct pci_dev *dev, u32 *buffer);
+int pci_restore_extended_state(struct pci_dev *dev, u32 *buffer);
 int pci_set_power_state(struct pci_dev *dev, int state);
 int pci_enable_wake(struct pci_dev *dev, u32 state, int enable);
 
