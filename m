Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933095AbWFZWRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933095AbWFZWRu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933092AbWFZWRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:17:49 -0400
Received: from web50103.mail.yahoo.com ([206.190.38.31]:24426 "HELO
	web50103.mail.yahoo.com") by vger.kernel.org with SMTP
	id S933095AbWFZWRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:17:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=OTtmolnX17+Je7Ux5/X2F2N9jheOcMwnUQTskahQAyLAlnRlsGrAvH3OCkxbRRWAsxzEbF+ov6XIBT8WOc1CHkJe391Wm8kc7mj11EBXcyPLyS1BAeVcvb6bHg5bP205LURjrHZJJcKrs0BHfqWONoKCPFPU2hqjy5Ch9mA3Kzg=  ;
Message-ID: <20060626221747.63613.qmail@web50103.mail.yahoo.com>
Date: Mon, 26 Jun 2006 15:17:47 -0700 (PDT)
From: Doug Thompson <norsk5@yahoo.com>
Subject: [PATCH 4/6]  EDAC probe1 cleanup 1-of-2
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Doug Thompson <norsk5@xmission.com>

This is part 1 of a 2-part patch set.  The code changes are split into two
parts to make the patches more readable.

Add lower-level functions that handle various parts of the initialization done
by the xxx_probe1() functions.  Some of the xxx_probe1() functions are much
too long and complicated (see "Chapter 5: Functions" in
Documentation/CodingStyle).

Signed-off-by: Doug Thompson <norsk5@xmission.com>
---
 amd76x_edac.c  |   32 +++++++++++
 e752x_edac.c   |  160 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 e7xxx_edac.c   |   74 ++++++++++++++++++++++++++
 i82860_edac.c  |   40 ++++++++++++++
 i82875p_edac.c |  117 +++++++++++++++++++++++++++++++++++++++++
 r82600_edac.c  |   54 +++++++++++++++++++
 6 files changed, 477 insertions(+)


Index: linux-2.6.17-rc4/drivers/edac/amd76x_edac.c
===================================================================
--- linux-2.6.17-rc4.orig/drivers/edac/amd76x_edac.c	2006-05-15 15:45:17.000000000
-0600
+++ linux-2.6.17-rc4/drivers/edac/amd76x_edac.c	2006-05-15 15:45:17.000000000 -0600
@@ -182,6 +182,38 @@
 	amd76x_process_error_info(mci, &info, 1);
 }
 
+static void amd76x_init_csrows(struct mem_ctl_info *mci, struct pci_dev *pdev,
+		enum edac_type edac_mode)
+{
+	struct csrow_info *csrow;
+	u32 mba, mba_base, mba_mask, dms;
+	int index;
+
+	for (index = 0; index < mci->nr_csrows; index++) {
+		csrow = &mci->csrows[index];
+
+		/* find the DRAM Chip Select Base address and mask */
+		pci_read_config_dword(pdev,
+				      AMD76X_MEM_BASE_ADDR + (index * 4),
+				      &mba);
+
+		if (!(mba & BIT(0)))
+			continue;
+
+		mba_base = mba & 0xff800000UL;
+		mba_mask = ((mba & 0xff80) << 16) | 0x7fffffUL;
+		pci_read_config_dword(pdev, AMD76X_DRAM_MODE_STATUS, &dms);
+		csrow->first_page = mba_base >> PAGE_SHIFT;
+		csrow->nr_pages = (mba_mask + 1) >> PAGE_SHIFT;
+		csrow->last_page = csrow->first_page + csrow->nr_pages - 1;
+		csrow->page_mask = mba_mask >> PAGE_SHIFT;
+		csrow->grain = csrow->nr_pages << PAGE_SHIFT;
+		csrow->mtype = MEM_RDDR;
+		csrow->dtype = ((dms >> index) & 0x1) ? DEV_X4 : DEV_UNKNOWN;
+		csrow->edac_mode = edac_mode;
+	}
+}
+
 /**
  *	amd76x_probe1	-	Perform set up for detected device
  *	@pdev; PCI device detected
Index: linux-2.6.17-rc4/drivers/edac/e752x_edac.c
===================================================================
--- linux-2.6.17-rc4.orig/drivers/edac/e752x_edac.c	2006-05-15 15:45:17.000000000
-0600
+++ linux-2.6.17-rc4/drivers/edac/e752x_edac.c	2006-05-15 15:45:17.000000000 -0600
@@ -765,6 +765,166 @@
 	e752x_process_error_info(mci, &info, 1);
 }
 
+/* Return 1 if dual channel mode is active.  Else return 0. */
+static inline int dual_channel_active(u16 ddrcsr)
+{
+	return (((ddrcsr >> 12) & 3) == 3);
+}
+
+static void e752x_init_csrows(struct mem_ctl_info *mci, struct pci_dev *pdev,
+		u16 ddrcsr)
+{
+	struct csrow_info *csrow;
+	unsigned long last_cumul_size;
+	int index, mem_dev, drc_chan;
+	int drc_drbg;  /* DRB granularity 0=64mb, 1=128mb */
+	int drc_ddim;  /* DRAM Data Integrity Mode 0=none, 2=edac */
+	u8 value;
+	u32 dra, drc, cumul_size;
+
+	pci_read_config_dword(pdev, E752X_DRA, &dra);
+	pci_read_config_dword(pdev, E752X_DRC, &drc);
+	drc_chan = dual_channel_active(ddrcsr);
+	drc_drbg = drc_chan + 1;  /* 128 in dual mode, 64 in single */
+	drc_ddim = (drc >> 20) & 0x3;
+
+	/* The dram row boundary (DRB) reg values are boundary address for
+	 * each DRAM row with a granularity of 64 or 128MB (single/dual
+	 * channel operation).  DRB regs are cumulative; therefore DRB7 will
+	 * contain the total memory contained in all eight rows.
+	 */
+	for (last_cumul_size = index = 0; index < mci->nr_csrows; index++) {
+		/* mem_dev 0=x8, 1=x4 */
+		mem_dev = (dra >> (index * 4 + 2)) & 0x3;
+		csrow = &mci->csrows[index];
+
+		mem_dev = (mem_dev == 2);
+		pci_read_config_byte(pdev, E752X_DRB + index, &value);
+		/* convert a 128 or 64 MiB DRB to a page size. */
+		cumul_size = value << (25 + drc_drbg - PAGE_SHIFT);
+		debugf3("%s(): (%d) cumul_size 0x%x\n", __func__, index,
+			cumul_size);
+		if (cumul_size == last_cumul_size)
+			continue;	/* not populated */
+
+		csrow->first_page = last_cumul_size;
+		csrow->last_page = cumul_size - 1;
+		csrow->nr_pages = cumul_size - last_cumul_size;
+		last_cumul_size = cumul_size;
+		csrow->grain = 1 << 12;	/* 4KiB - resolution of CELOG */
+		csrow->mtype = MEM_RDDR;	/* only one type supported */
+		csrow->dtype = mem_dev ? DEV_X4 : DEV_X8;
+
+		/*
+		 * if single channel or x8 devices then SECDED
+		 * if dual channel and x4 then S4ECD4ED
+		 */
+		if (drc_ddim) {
+			if (drc_chan && mem_dev) {
+				csrow->edac_mode = EDAC_S4ECD4ED;
+				mci->edac_cap |= EDAC_FLAG_S4ECD4ED;
+			} else {
+				csrow->edac_mode = EDAC_SECDED;
+				mci->edac_cap |= EDAC_FLAG_SECDED;
+			}
+		} else
+			csrow->edac_mode = EDAC_NONE;
+	}
+}
+
+static void e752x_init_mem_map_table(struct pci_dev *pdev,
+		struct e752x_pvt *pvt)
+{
+	int index;
+	u8 value, last, row, stat8;
+
+	last = 0;
+	row = 0;
+
+	for (index = 0; index < 8; index += 2) {
+		pci_read_config_byte(pdev, E752X_DRB + index, &value);
+		/* test if there is a dimm in this slot */
+		if (value == last) {
+			/* no dimm in the slot, so flag it as empty */
+			pvt->map[index] = 0xff;
+			pvt->map[index + 1] = 0xff;
+		} else {        /* there is a dimm in the slot */
+			pvt->map[index] = row;
+			row++;
+			last = value;
+			/* test the next value to see if the dimm is double
+			 * sided
+			 */
+			pci_read_config_byte(pdev, E752X_DRB + index + 1,
+					     &value);
+			pvt->map[index + 1] = (value == last) ?
+			    0xff :      /* the dimm is single sided,
+					   so flag as empty */
+			    row;        /* this is a double sided dimm
+					   to save the next row # */
+			row++;
+			last = value;
+		}
+	}
+
+	/* set the map type.  1 = normal, 0 = reversed */
+	pci_read_config_byte(pdev, E752X_DRM, &stat8);
+	pvt->map_type = ((stat8 & 0x0f) > ((stat8 >> 4) & 0x0f));
+}
+
+/* Return 0 on success or 1 on failure. */
+static int e752x_get_devs(struct pci_dev *pdev, int dev_idx,
+		struct e752x_pvt *pvt)
+{
+	struct pci_dev *dev;
+
+	pvt->bridge_ck = pci_get_device(PCI_VENDOR_ID_INTEL,
+					pvt->dev_info->err_dev,
+					pvt->bridge_ck);
+
+	if (pvt->bridge_ck == NULL)
+		pvt->bridge_ck = pci_scan_single_device(pdev->bus,
+							PCI_DEVFN(0, 1));
+
+	if (pvt->bridge_ck == NULL) {
+		e752x_printk(KERN_ERR, "error reporting device not found:"
+		       "vendor %x device 0x%x (broken BIOS?)\n",
+		       PCI_VENDOR_ID_INTEL, e752x_devs[dev_idx].err_dev);
+		return 1;
+	}
+
+	dev = pci_get_device(PCI_VENDOR_ID_INTEL, e752x_devs[dev_idx].ctl_dev,
+			     NULL);
+
+	if (dev == NULL)
+		goto fail;
+
+	pvt->dev_d0f0 = dev;
+	pvt->dev_d0f1 = pci_dev_get(pvt->bridge_ck);
+
+	return 0;
+
+fail:
+	pci_dev_put(pvt->bridge_ck);
+	return 1;
+}
+
+static void e752x_init_error_reporting_regs(struct e752x_pvt *pvt)
+{
+	struct pci_dev *dev;
+
+	dev = pvt->dev_d0f1;
+	/* Turn off error disable & SMI in case the BIOS turned it on */
+	pci_write_config_byte(dev, E752X_HI_ERRMASK, 0x00);
+	pci_write_config_byte(dev, E752X_HI_SMICMD, 0x00);
+	pci_write_config_word(dev, E752X_SYSBUS_ERRMASK, 0x00);
+	pci_write_config_word(dev, E752X_SYSBUS_SMICMD, 0x00);
+	pci_write_config_byte(dev, E752X_BUF_ERRMASK, 0x00);
+	pci_write_config_byte(dev, E752X_BUF_SMICMD, 0x00);
+	pci_write_config_byte(dev, E752X_DRAM_ERRMASK, 0x00);
+	pci_write_config_byte(dev, E752X_DRAM_SMICMD, 0x00);
+}
+
 static int e752x_probe1(struct pci_dev *pdev, int dev_idx)
 {
 	int rc = -ENODEV;
Index: linux-2.6.17-rc4/drivers/edac/e7xxx_edac.c
===================================================================
--- linux-2.6.17-rc4.orig/drivers/edac/e7xxx_edac.c	2006-05-15 15:45:17.000000000
-0600
+++ linux-2.6.17-rc4/drivers/edac/e7xxx_edac.c	2006-05-15 15:45:17.000000000 -0600
@@ -335,6 +335,80 @@
 	e7xxx_process_error_info(mci, &info, 1);
 }
 
+/* Return 1 if dual channel mode is active.  Else return 0. */
+static inline int dual_channel_active(u32 drc, int dev_idx)
+{
+	return (dev_idx == E7501) ? ((drc >> 22) & 0x1) : 1;
+}
+
+
+/* Return DRB granularity (0=32mb, 1=64mb). */
+static inline int drb_granularity(u32 drc, int dev_idx)
+{
+	/* only e7501 can be single channel */
+	return (dev_idx == E7501) ? ((drc >> 18) & 0x3) : 1;
+}
+
+
+static void e7xxx_init_csrows(struct mem_ctl_info *mci, struct pci_dev *pdev,
+		int dev_idx, u32 drc)
+{
+	unsigned long last_cumul_size;
+	int index;
+	u8 value;
+	u32 dra, cumul_size;
+	int drc_chan, drc_drbg, drc_ddim, mem_dev;
+	struct csrow_info *csrow;
+
+	pci_read_config_dword(pdev, E7XXX_DRA, &dra);
+	drc_chan = dual_channel_active(drc, dev_idx);
+	drc_drbg = drb_granularity(drc, dev_idx);
+	drc_ddim = (drc >> 20) & 0x3;
+	last_cumul_size = 0;
+
+	/* The dram row boundary (DRB) reg values are boundary address
+	 * for each DRAM row with a granularity of 32 or 64MB (single/dual
+	 * channel operation).  DRB regs are cumulative; therefore DRB7 will
+	 * contain the total memory contained in all eight rows.
+	 */
+	for (index = 0; index < mci->nr_csrows; index++) {
+		/* mem_dev 0=x8, 1=x4 */
+		mem_dev = (dra >> (index * 4 + 3)) & 0x1;
+		csrow = &mci->csrows[index];
+
+		pci_read_config_byte(pdev, E7XXX_DRB + index, &value);
+		/* convert a 64 or 32 MiB DRB to a page size. */
+		cumul_size = value << (25 + drc_drbg - PAGE_SHIFT);
+		debugf3("%s(): (%d) cumul_size 0x%x\n", __func__, index,
+			cumul_size);
+		if (cumul_size == last_cumul_size)
+			continue;	/* not populated */
+
+		csrow->first_page = last_cumul_size;
+		csrow->last_page = cumul_size - 1;
+		csrow->nr_pages = cumul_size - last_cumul_size;
+		last_cumul_size = cumul_size;
+		csrow->grain = 1 << 12;	/* 4KiB - resolution of CELOG */
+		csrow->mtype = MEM_RDDR;	/* only one type supported */
+		csrow->dtype = mem_dev ? DEV_X4 : DEV_X8;
+
+		/*
+		 * if single channel or x8 devices then SECDED
+		 * if dual channel and x4 then S4ECD4ED
+		 */
+		if (drc_ddim) {
+			if (drc_chan && mem_dev) {
+				csrow->edac_mode = EDAC_S4ECD4ED;
+				mci->edac_cap |= EDAC_FLAG_S4ECD4ED;
+			} else {
+				csrow->edac_mode = EDAC_SECDED;
+				mci->edac_cap |= EDAC_FLAG_SECDED;
+			}
+		} else
+			csrow->edac_mode = EDAC_NONE;
+	}
+}
+
 static int e7xxx_probe1(struct pci_dev *pdev, int dev_idx)
 {
 	int rc = -ENODEV;
Index: linux-2.6.17-rc4/drivers/edac/i82860_edac.c
===================================================================
--- linux-2.6.17-rc4.orig/drivers/edac/i82860_edac.c	2006-05-15 15:45:17.000000000
-0600
+++ linux-2.6.17-rc4/drivers/edac/i82860_edac.c	2006-05-15 15:45:17.000000000 -0600
@@ -133,6 +133,46 @@
 	i82860_process_error_info(mci, &info, 1);
 }
 
+static void i82860_init_csrows(struct mem_ctl_info *mci, struct pci_dev *pdev)
+{
+	unsigned long last_cumul_size;
+	u16 mchcfg_ddim;  /* DRAM Data Integrity Mode 0=none, 2=edac */
+	u16 value;
+	u32 cumul_size;
+	struct csrow_info *csrow;
+	int index;
+
+	pci_read_config_word(pdev, I82860_MCHCFG, &mchcfg_ddim);
+	mchcfg_ddim = mchcfg_ddim & 0x180;
+	last_cumul_size = 0;
+
+	/* The group row boundary (GRA) reg values are boundary address
+	 * for each DRAM row with a granularity of 16MB.  GRA regs are
+	 * cumulative; therefore GRA15 will contain the total memory contained
+	 * in all eight rows.
+	 */
+	for (index = 0; index < mci->nr_csrows; index++) {
+		csrow = &mci->csrows[index];
+		pci_read_config_word(pdev, I82860_GBA + index * 2, &value);
+		cumul_size = (value & I82860_GBA_MASK) <<
+		    (I82860_GBA_SHIFT - PAGE_SHIFT);
+		debugf3("%s(): (%d) cumul_size 0x%x\n", __func__, index,
+			cumul_size);
+
+		if (cumul_size == last_cumul_size)
+			continue;	/* not populated */
+
+		csrow->first_page = last_cumul_size;
+		csrow->last_page = cumul_size - 1;
+		csrow->nr_pages = cumul_size - last_cumul_size;
+		last_cumul_size = cumul_size;
+		csrow->grain = 1 << 12;	/* I82860_EAP has 4KiB reolution */
+		csrow->mtype = MEM_RMBS;
+		csrow->dtype = DEV_UNKNOWN;
+		csrow->edac_mode = mchcfg_ddim ? EDAC_SECDED : EDAC_NONE;
+	}
+}
+
 static int i82860_probe1(struct pci_dev *pdev, int dev_idx)
 {
 	int rc = -ENODEV;
Index: linux-2.6.17-rc4/drivers/edac/i82875p_edac.c
===================================================================
--- linux-2.6.17-rc4.orig/drivers/edac/i82875p_edac.c	2006-05-15 15:45:17.000000000
-0600
+++ linux-2.6.17-rc4/drivers/edac/i82875p_edac.c	2006-05-15 15:45:17.000000000 -0600
@@ -265,6 +265,123 @@
 extern int pci_proc_attach_device(struct pci_dev *);
 #endif
 
+/* Return 0 on success or 1 on failure. */
+static int i82875p_setup_overfl_dev(struct pci_dev *pdev,
+		struct pci_dev **ovrfl_pdev, void __iomem **ovrfl_window)
+{
+	struct pci_dev *dev;
+	void __iomem *window;
+
+	*ovrfl_pdev = NULL;
+	*ovrfl_window = NULL;
+	dev = pci_get_device(PCI_VEND_DEV(INTEL, 82875_6), NULL);
+
+	if (dev == NULL) {
+		/* Intel tells BIOS developers to hide device 6 which
+		 * configures the overflow device access containing
+		 * the DRBs - this is where we expose device 6.
+		 * http://www.x86-secret.com/articles/tweak/pat/patsecrets-2.htm
+		 */
+		pci_write_bits8(pdev, 0xf4, 0x2, 0x2);
+		dev = pci_scan_single_device(pdev->bus, PCI_DEVFN(6, 0));
+
+		if (dev == NULL)
+			return 1;
+	}
+
+	*ovrfl_pdev = dev;
+
+#ifdef CONFIG_PROC_FS
+	if ((dev->procent == NULL) && pci_proc_attach_device(dev)) {
+		i82875p_printk(KERN_ERR, "%s(): Failed to attach overflow "
+			       "device\n", __func__);
+		return 1;
+	}
+#endif  /* CONFIG_PROC_FS */
+	if (pci_enable_device(dev)) {
+		i82875p_printk(KERN_ERR, "%s(): Failed to enable overflow "
+			       "device\n", __func__);
+		return 1;
+	}
+
+	if (pci_request_regions(dev, pci_name(dev))) {
+#ifdef CORRECT_BIOS
+		goto fail0;
+#endif
+	}
+
+	/* cache is irrelevant for PCI bus reads/writes */
+	window = ioremap_nocache(pci_resource_start(dev, 0),
+				 pci_resource_len(dev, 0));
+
+	if (window == NULL) {
+		i82875p_printk(KERN_ERR, "%s(): Failed to ioremap bar6\n",
+			       __func__);
+		goto fail1;
+	}
+
+	*ovrfl_window = window;
+	return 0;
+
+fail1:
+	pci_release_regions(dev);
+
+#ifdef CORRECT_BIOS
+fail0:
+	pci_disable_device(dev);
+#endif
+	/* NOTE: the ovrfl proc entry and pci_dev are intentionally left */
+	return 1;
+}
+
+
+/* Return 1 if dual channel mode is active.  Else return 0. */
+static inline int dual_channel_active(u32 drc)
+{
+	return (drc >> 21) & 0x1;
+}
+
+
+static void i82875p_init_csrows(struct mem_ctl_info *mci,
+		struct pci_dev *pdev, void __iomem *ovrfl_window, u32 drc)
+{
+	struct csrow_info *csrow;
+	unsigned long last_cumul_size;
+	u8 value;
+	u32 drc_ddim;  /* DRAM Data Integrity Mode 0=none,2=edac */
+	u32 cumul_size;
+	int index;
+
+	drc_ddim = (drc >> 18) & 0x1;
+	last_cumul_size = 0;
+
+	/* The dram row boundary (DRB) reg values are boundary address
+	 * for each DRAM row with a granularity of 32 or 64MB (single/dual
+	 * channel operation).  DRB regs are cumulative; therefore DRB7 will
+	 * contain the total memory contained in all eight rows.
+	 */
+
+	for (index = 0; index < mci->nr_csrows; index++) {
+		csrow = &mci->csrows[index];
+
+		value = readb(ovrfl_window + I82875P_DRB + index);
+		cumul_size = value << (I82875P_DRB_SHIFT - PAGE_SHIFT);
+		debugf3("%s(): (%d) cumul_size 0x%x\n", __func__, index,
+			cumul_size);
+		if (cumul_size == last_cumul_size)
+			continue;	/* not populated */
+
+		csrow->first_page = last_cumul_size;
+		csrow->last_page = cumul_size - 1;
+		csrow->nr_pages = cumul_size - last_cumul_size;
+		last_cumul_size = cumul_size;
+		csrow->grain = 1 << 12;	/* I82875P_EAP has 4KiB reolution */
+		csrow->mtype = MEM_DDR;
+		csrow->dtype = DEV_UNKNOWN;
+		csrow->edac_mode = drc_ddim ? EDAC_SECDED : EDAC_NONE;
+	}
+}
+
 static int i82875p_probe1(struct pci_dev *pdev, int dev_idx)
 {
 	int rc = -ENODEV;
Index: linux-2.6.17-rc4/drivers/edac/r82600_edac.c
===================================================================
--- linux-2.6.17-rc4.orig/drivers/edac/r82600_edac.c	2006-05-15 15:45:17.000000000
-0600
+++ linux-2.6.17-rc4/drivers/edac/r82600_edac.c	2006-05-15 15:45:17.000000000 -0600
@@ -205,6 +205,60 @@
 	r82600_process_error_info(mci, &info, 1);
 }
 
+static inline int ecc_enabled(u8 dramcr)
+{
+	return dramcr & BIT(5);
+}
+
+static void r82600_init_csrows(struct mem_ctl_info *mci, struct pci_dev *pdev,
+		u8 dramcr)
+{
+	struct csrow_info *csrow;
+	int index;
+	u8 drbar;  /* SDRAM Row Boundry Address Register */
+	u32 row_high_limit, row_high_limit_last;
+	u32 reg_sdram, ecc_on, row_base;
+
+	ecc_on = ecc_enabled(dramcr);
+	reg_sdram = dramcr & BIT(4);
+	row_high_limit_last = 0;
+
+	for (index = 0; index < mci->nr_csrows; index++) {
+		csrow = &mci->csrows[index];
+
+		/* find the DRAM Chip Select Base address and mask */
+		pci_read_config_byte(pdev, R82600_DRBA + index, &drbar);
+
+		debugf1("%s() Row=%d DRBA = %#0x\n", __func__, index, drbar);
+
+		row_high_limit = ((u32) drbar << 24);
+/*		row_high_limit = ((u32)drbar << 24) | 0xffffffUL; */
+
+		debugf1("%s() Row=%d, Boundry Address=%#0x, Last = %#0x\n",
+			__func__, index, row_high_limit, row_high_limit_last);
+
+		/* Empty row [p.57] */
+		if (row_high_limit == row_high_limit_last)
+			continue;
+
+		row_base = row_high_limit_last;
+
+		csrow->first_page = row_base >> PAGE_SHIFT;
+		csrow->last_page = (row_high_limit >> PAGE_SHIFT) - 1;
+		csrow->nr_pages = csrow->last_page - csrow->first_page + 1;
+		/* Error address is top 19 bits - so granularity is      *
+		 * 14 bits                                               */
+		csrow->grain = 1 << 14;
+		csrow->mtype = reg_sdram ? MEM_RDDR : MEM_DDR;
+		/* FIXME - check that this is unknowable with this chipset */
+		csrow->dtype = DEV_UNKNOWN;
+
+		/* Mode is global on 82600 */
+		csrow->edac_mode = ecc_on ? EDAC_SECDED : EDAC_NONE;
+		row_high_limit_last = row_high_limit;
+	}
+}
+
 static int r82600_probe1(struct pci_dev *pdev, int dev_idx)
 {
 	int rc = -ENODEV;

