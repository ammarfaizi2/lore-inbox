Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbWFZWSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWFZWSb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933096AbWFZWSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:18:31 -0400
Received: from web50102.mail.yahoo.com ([206.190.38.30]:9375 "HELO
	web50102.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932099AbWFZWS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:18:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=F/UKd8V7AaHvpcH7fc3DaVLDSg3hf7+8cuUeDHWGJ34De5p3VxoWTAcv6270z7hGiz0OXQeFRzE15HKBwjVuZMoAfJkFxL22/rzhRUE0MqECN+mwe3qMMGc2A/ipViSi6m4B6GYEvRza/327nk3FXzJJ7rxZtrljCV360T/Gm8Y=  ;
Message-ID: <20060626221829.51203.qmail@web50102.mail.yahoo.com>
Date: Mon, 26 Jun 2006 15:18:28 -0700 (PDT)
From: Doug Thompson <norsk5@yahoo.com>
Subject: [PATCH 5/6]  EDAC probe1 cleanup 2-of-2
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Doug Thompson <norsk5@xmission.com>

Part 2 of a cleanup of probe1() functions in EDAC

Signed-off-by: Doug Thompson <norsk5@xmission.com>
---

 amd76x_edac.c  |   42 ++------------
 e752x_edac.c   |  164 ++++++---------------------------------------------------
 e7xxx_edac.c   |   94 ++++----------------------------
 i82860_edac.c  |   62 +++------------------
 i82875p_edac.c |  107 +++----------------------------------
 r82600_edac.c  |   64 ++--------------------
 6 files changed, 65 insertions(+), 468 deletions(-)


Index: linux-2.6.17-rc5/drivers/edac/amd76x_edac.c
===================================================================
--- linux-2.6.17-rc5.orig/drivers/edac/amd76x_edac.c	2006-05-25 11:41:54.000000000
-0600
+++ linux-2.6.17-rc5/drivers/edac/amd76x_edac.c	2006-05-25 11:42:07.000000000 -0600
@@ -225,15 +225,13 @@
  */
 static int amd76x_probe1(struct pci_dev *pdev, int dev_idx)
 {
-	int rc = -ENODEV;
-	int index;
-	struct mem_ctl_info *mci = NULL;
-	enum edac_type ems_modes[] = {
+	static const enum edac_type ems_modes[] = {
 		EDAC_NONE,
 		EDAC_EC,
 		EDAC_SECDED,
 		EDAC_SECDED
 	};
+	struct mem_ctl_info *mci = NULL;
 	u32 ems;
 	u32 ems_mode;
 	struct amd76x_error_info discard;
@@ -244,8 +242,7 @@
 	mci = edac_mc_alloc(0, AMD76X_NR_CSROWS, AMD76X_NR_CHANS);
 
 	if (mci == NULL) {
-		rc = -ENOMEM;
-		goto fail;
+		return -ENOMEM;
 	}
 
 	debugf0("%s(): mci = %p\n", __func__, mci);
@@ -260,33 +257,7 @@
 	mci->edac_check = amd76x_check;
 	mci->ctl_page_to_phys = NULL;
 
-	for (index = 0; index < mci->nr_csrows; index++) {
-		struct csrow_info *csrow = &mci->csrows[index];
-		u32 mba;
-		u32 mba_base;
-		u32 mba_mask;
-		u32 dms;
-
-		/* find the DRAM Chip Select Base address and mask */
-		pci_read_config_dword(pdev,
-				AMD76X_MEM_BASE_ADDR + (index * 4), &mba);
-
-		if (!(mba & BIT(0)))
-			continue;
-
-		mba_base = mba & 0xff800000UL;
-		mba_mask = ((mba & 0xff80) << 16) | 0x7fffffUL;
-		pci_read_config_dword(pdev, AMD76X_DRAM_MODE_STATUS, &dms);
-		csrow->first_page = mba_base >> PAGE_SHIFT;
-		csrow->nr_pages = (mba_mask + 1) >> PAGE_SHIFT;
-		csrow->last_page = csrow->first_page + csrow->nr_pages - 1;
-		csrow->page_mask = mba_mask >> PAGE_SHIFT;
-		csrow->grain = csrow->nr_pages << PAGE_SHIFT;
-		csrow->mtype = MEM_RDDR;
-		csrow->dtype = ((dms >> index) & 0x1) ? DEV_X4 : DEV_UNKNOWN;
-		csrow->edac_mode = ems_modes[ems_mode];
-	}
-
+	amd76x_init_csrows(mci, pdev, ems_modes[ems_mode]);
 	amd76x_get_error_info(mci, &discard);  /* clear counters */
 
 	/* Here we assume that we will never see multiple instances of this
@@ -302,9 +273,8 @@
 	return 0;
 
 fail:
-	if (mci != NULL)
-		edac_mc_free(mci);
-	return rc;
+	edac_mc_free(mci);
+	return -ENODEV;
 }
 
 /* returns count (>= 0), or negative on error */
Index: linux-2.6.17-rc5/drivers/edac/e752x_edac.c
===================================================================
--- linux-2.6.17-rc5.orig/drivers/edac/e752x_edac.c	2006-05-25 11:41:54.000000000
-0600
+++ linux-2.6.17-rc5/drivers/edac/e752x_edac.c	2006-05-25 11:45:25.000000000 -0600
@@ -927,20 +927,12 @@
 
 static int e752x_probe1(struct pci_dev *pdev, int dev_idx)
 {
-	int rc = -ENODEV;
-	int index;
 	u16 pci_data;
 	u8 stat8;
-	struct mem_ctl_info *mci = NULL;
-	struct e752x_pvt *pvt = NULL;
+	struct mem_ctl_info *mci;
+	struct e752x_pvt *pvt;
 	u16 ddrcsr;
-	u32 drc;
 	int drc_chan;	/* Number of channels 0=1chan,1=2chan */
-	int drc_drbg;	/* DRB granularity 0=64mb, 1=128mb */
-	int drc_ddim;	/* DRAM Data Integrity Mode 0=none,2=edac */
-	u32 dra;
-	unsigned long last_cumul_size;
-	struct pci_dev *dev = NULL;
 	struct e752x_error_info discard;
 
 	debugf0("%s(): mci\n", __func__);
@@ -954,25 +946,20 @@
 	if (!force_function_unhide && !(stat8 & (1 << 5))) {
 		printk(KERN_INFO "Contact your BIOS vendor to see if the "
 			"E752x error registers can be safely un-hidden\n");
-		goto fail;
+		return -ENOMEM;
 	}
 	stat8 |= (1 << 5);
 	pci_write_config_byte(pdev, E752X_DEVPRES1, stat8);
 
-	/* need to find out the number of channels */
-	pci_read_config_dword(pdev, E752X_DRC, &drc);
 	pci_read_config_word(pdev, E752X_DDRCSR, &ddrcsr);
 	/* FIXME: should check >>12 or 0xf, true for all? */
 	/* Dual channel = 1, Single channel = 0 */
-	drc_chan = (((ddrcsr >> 12) & 3) == 3);
-	drc_drbg = drc_chan + 1;	/* 128 in dual mode, 64 in single */
-	drc_ddim = (drc >> 20) & 0x3;
+	drc_chan = dual_channel_active(ddrcsr);
 
 	mci = edac_mc_alloc(sizeof(*pvt), E752X_NR_CSROWS, drc_chan + 1);
 
 	if (mci == NULL) {
-		rc = -ENOMEM;
-		goto fail;
+		return -ENOMEM;
 	}
 
 	debugf3("%s(): init mci\n", __func__);
@@ -987,113 +974,20 @@
 	debugf3("%s(): init pvt\n", __func__);
 	pvt = (struct e752x_pvt *) mci->pvt_info;
 	pvt->dev_info = &e752x_devs[dev_idx];
-	pvt->bridge_ck = pci_get_device(PCI_VENDOR_ID_INTEL,
-					pvt->dev_info->err_dev,
-					pvt->bridge_ck);
-
-	if (pvt->bridge_ck == NULL)
-		pvt->bridge_ck = pci_scan_single_device(pdev->bus,
-					PCI_DEVFN(0, 1));
-
-	if (pvt->bridge_ck == NULL) {
-		e752x_printk(KERN_ERR, "error reporting device not found:"
-			"vendor %x device 0x%x (broken BIOS?)\n",
-			PCI_VENDOR_ID_INTEL, e752x_devs[dev_idx].err_dev);
-		goto fail;
+	pvt->mc_symmetric = ((ddrcsr & 0x10) != 0);
+
+	if (e752x_get_devs(pdev, dev_idx, pvt)) {
+		edac_mc_free(mci);
+		return -ENODEV;
 	}
 
-	pvt->mc_symmetric = ((ddrcsr & 0x10) != 0);
 	debugf3("%s(): more mci init\n", __func__);
 	mci->ctl_name = pvt->dev_info->ctl_name;
 	mci->edac_check = e752x_check;
 	mci->ctl_page_to_phys = ctl_page_to_phys;
 
-	/* find out the device types */
-	pci_read_config_dword(pdev, E752X_DRA, &dra);
-
-	/*
-	 * The dram row boundary (DRB) reg values are boundary address for
-	 * each DRAM row with a granularity of 64 or 128MB (single/dual
-	 * channel operation).  DRB regs are cumulative; therefore DRB7 will
-	 * contain the total memory contained in all eight rows.
-	 */
-	for (last_cumul_size = index = 0; index < mci->nr_csrows; index++) {
-		u8 value;
-		u32 cumul_size;
-
-		/* mem_dev 0=x8, 1=x4 */
-		int mem_dev = (dra >> (index * 4 + 2)) & 0x3;
-		struct csrow_info *csrow = &mci->csrows[index];
-
-		mem_dev = (mem_dev == 2);
-		pci_read_config_byte(pdev, E752X_DRB + index, &value);
-		/* convert a 128 or 64 MiB DRB to a page size. */
-		cumul_size = value << (25 + drc_drbg - PAGE_SHIFT);
-		debugf3("%s(): (%d) cumul_size 0x%x\n", __func__, index,
-			cumul_size);
-
-		if (cumul_size == last_cumul_size)
-			continue; /* not populated */
-
-		csrow->first_page = last_cumul_size;
-		csrow->last_page = cumul_size - 1;
-		csrow->nr_pages = cumul_size - last_cumul_size;
-		last_cumul_size = cumul_size;
-		csrow->grain = 1 << 12;  /* 4KiB - resolution of CELOG */
-		csrow->mtype = MEM_RDDR;  /* only one type supported */
-		csrow->dtype = mem_dev ? DEV_X4 : DEV_X8;
-
-		/*
-		 * if single channel or x8 devices then SECDED
-		 * if dual channel and x4 then S4ECD4ED
-		 */
-		if (drc_ddim) {
-			if (drc_chan && mem_dev) {
-				csrow->edac_mode = EDAC_S4ECD4ED;
-				mci->edac_cap |= EDAC_FLAG_S4ECD4ED;
-			} else {
-				csrow->edac_mode = EDAC_SECDED;
-				mci->edac_cap |= EDAC_FLAG_SECDED;
-			}
-		} else
-			csrow->edac_mode = EDAC_NONE;
-	}
-
-	/* Fill in the memory map table */
-	{
-		u8 value;
-		u8 last = 0;
-		u8 row = 0;
-
-		for (index = 0; index < 8; index += 2) {
-			pci_read_config_byte(pdev, E752X_DRB + index, &value);
-
-			/* test if there is a dimm in this slot */
-			if (value == last) {
-				/* no dimm in the slot, so flag it as empty */
-				pvt->map[index] = 0xff;
-				pvt->map[index + 1] = 0xff;
-			} else { /* there is a dimm in the slot */
-				pvt->map[index] = row;
-				row++;
-				last = value;
-				/* test the next value to see if the dimm is
-				   double sided */
-				pci_read_config_byte(pdev,
-						E752X_DRB + index + 1,
-						&value);
-				pvt->map[index + 1] = (value == last) ?
-					0xff :	/* the dimm is single sided,
-						 * so flag as empty
-						 */
-					row;	/* this is a double sided dimm
-						 * to save the next row #
-						 */
-				row++;
-				last = value;
-			}
-		}
-	}
+	e752x_init_csrows(mci, pdev, ddrcsr);
+	e752x_init_mem_map_table(pdev, pvt);
 
 	/* set the map type.  1 = normal, 0 = reversed */
 	pci_read_config_byte(pdev, E752X_DRM, &stat8);
@@ -1121,21 +1015,7 @@
 		goto fail;
 	}
 
-	dev = pci_get_device(PCI_VENDOR_ID_INTEL, e752x_devs[dev_idx].ctl_dev,
-			NULL);
-	pvt->dev_d0f0 = dev;
-	/* find the error reporting device and clear errors */
-	dev = pvt->dev_d0f1 = pci_dev_get(pvt->bridge_ck);
-	/* Turn off error disable & SMI in case the BIOS turned it on */
-	pci_write_config_byte(dev, E752X_HI_ERRMASK, 0x00);
-	pci_write_config_byte(dev, E752X_HI_SMICMD, 0x00);
-	pci_write_config_word(dev, E752X_SYSBUS_ERRMASK, 0x00);
-	pci_write_config_word(dev, E752X_SYSBUS_SMICMD, 0x00);
-	pci_write_config_byte(dev, E752X_BUF_ERRMASK, 0x00);
-	pci_write_config_byte(dev, E752X_BUF_SMICMD, 0x00);
-	pci_write_config_byte(dev, E752X_DRAM_ERRMASK, 0x00);
-	pci_write_config_byte(dev, E752X_DRAM_SMICMD, 0x00);
-
+	e752x_init_error_reporting_regs(pvt);
 	e752x_get_error_info(mci, &discard); /* clear other MCH errors */
 
 	/* get this far and it's successful */
@@ -1143,20 +1023,12 @@
 	return 0;
 
 fail:
-	if (mci) {
-		if (pvt->dev_d0f0)
-			pci_dev_put(pvt->dev_d0f0);
-
-		if (pvt->dev_d0f1)
-			pci_dev_put(pvt->dev_d0f1);
-
-		if (pvt->bridge_ck)
-			pci_dev_put(pvt->bridge_ck);
-
-		edac_mc_free(mci);
-	}
+	pci_dev_put(pvt->dev_d0f0);
+	pci_dev_put(pvt->dev_d0f1);
+	pci_dev_put(pvt->bridge_ck);
+	edac_mc_free(mci);
 
-	return rc;
+	return -ENODEV;
 }
 
 /* returns count (>= 0), or negative on error */
Index: linux-2.6.17-rc5/drivers/edac/e7xxx_edac.c
===================================================================
--- linux-2.6.17-rc5.orig/drivers/edac/e7xxx_edac.c	2006-05-25 11:41:54.000000000
-0600
+++ linux-2.6.17-rc5/drivers/edac/e7xxx_edac.c	2006-05-25 11:42:07.000000000 -0600
@@ -411,37 +411,21 @@
 
 static int e7xxx_probe1(struct pci_dev *pdev, int dev_idx)
 {
-	int rc = -ENODEV;
-	int index;
 	u16 pci_data;
 	struct mem_ctl_info *mci = NULL;
 	struct e7xxx_pvt *pvt = NULL;
 	u32 drc;
-	int drc_chan = 1;	/* Number of channels 0=1chan,1=2chan */
-	int drc_drbg = 1;	/* DRB granularity 0=32mb,1=64mb */
-	int drc_ddim;		/* DRAM Data Integrity Mode 0=none,2=edac */
-	u32 dra;
-	unsigned long last_cumul_size;
+	int drc_chan;
 	struct e7xxx_error_info discard;
 
 	debugf0("%s(): mci\n", __func__);
-
-	/* need to find out the number of channels */
 	pci_read_config_dword(pdev, E7XXX_DRC, &drc);
 
-	/* only e7501 can be single channel */
-	if (dev_idx == E7501) {
-		drc_chan = ((drc >> 22) & 0x1);
-		drc_drbg = (drc >> 18) & 0x3;
-	}
-
-	drc_ddim = (drc >> 20) & 0x3;
+	drc_chan = dual_channel_active(drc, dev_idx);
 	mci = edac_mc_alloc(sizeof(*pvt), E7XXX_NR_CSROWS, drc_chan + 1);
 
-	if (mci == NULL) {
-		rc = -ENOMEM;
-		goto fail;
-	}
+	if (mci == NULL)
+		return -ENOMEM;
 
 	debugf3("%s(): init mci\n", __func__);
 	mci->mtype_cap = MEM_FLAG_RDDR;
@@ -451,7 +435,6 @@
 	mci->mod_name = EDAC_MOD_STR;
 	mci->mod_ver = E7XXX_REVISION;
 	mci->dev = &pdev->dev;
-
 	debugf3("%s(): init pvt\n", __func__);
 	pvt = (struct e7xxx_pvt *) mci->pvt_info;
 	pvt->dev_info = &e7xxx_devs[dev_idx];
@@ -463,65 +446,15 @@
 		e7xxx_printk(KERN_ERR, "error reporting device not found:"
 			"vendor %x device 0x%x (broken BIOS?)\n",
 			PCI_VENDOR_ID_INTEL, e7xxx_devs[dev_idx].err_dev);
-		goto fail;
+		goto fail0;
 	}
 
 	debugf3("%s(): more mci init\n", __func__);
 	mci->ctl_name = pvt->dev_info->ctl_name;
 	mci->edac_check = e7xxx_check;
 	mci->ctl_page_to_phys = ctl_page_to_phys;
-
-	/* find out the device types */
-	pci_read_config_dword(pdev, E7XXX_DRA, &dra);
-
-	/*
-	 * The dram row boundary (DRB) reg values are boundary address
-	 * for each DRAM row with a granularity of 32 or 64MB (single/dual
-	 * channel operation).  DRB regs are cumulative; therefore DRB7 will
-	 * contain the total memory contained in all eight rows.
-	 */
-	for (last_cumul_size = index = 0; index < mci->nr_csrows; index++) {
-		u8 value;
-		u32 cumul_size;
-		/* mem_dev 0=x8, 1=x4 */
-		int mem_dev = (dra >> (index * 4 + 3)) & 0x1;
-		struct csrow_info *csrow = &mci->csrows[index];
-
-		pci_read_config_byte(pdev, E7XXX_DRB + index, &value);
-		/* convert a 64 or 32 MiB DRB to a page size. */
-		cumul_size = value << (25 + drc_drbg - PAGE_SHIFT);
-		debugf3("%s(): (%d) cumul_size 0x%x\n", __func__, index,
-			cumul_size);
-
-		if (cumul_size == last_cumul_size)
-			continue;  /* not populated */
-
-		csrow->first_page = last_cumul_size;
-		csrow->last_page = cumul_size - 1;
-		csrow->nr_pages = cumul_size - last_cumul_size;
-		last_cumul_size = cumul_size;
-		csrow->grain = 1 << 12;  /* 4KiB - resolution of CELOG */
-		csrow->mtype = MEM_RDDR;  /* only one type supported */
-		csrow->dtype = mem_dev ? DEV_X4 : DEV_X8;
-
-		/*
-		 * if single channel or x8 devices then SECDED
-		 * if dual channel and x4 then S4ECD4ED
-		 */
-		if (drc_ddim) {
-			if (drc_chan && mem_dev) {
-				csrow->edac_mode = EDAC_S4ECD4ED;
-				mci->edac_cap |= EDAC_FLAG_S4ECD4ED;
-			} else {
-				csrow->edac_mode = EDAC_SECDED;
-				mci->edac_cap |= EDAC_FLAG_SECDED;
-			}
-		} else
-			csrow->edac_mode = EDAC_NONE;
-	}
-
+	e7xxx_init_csrows(mci, pdev, dev_idx, drc);
 	mci->edac_cap |= EDAC_FLAG_NONE;
-
 	debugf3("%s(): tolm, remapbase, remaplimit\n", __func__);
 	/* load the top of low memory, remap base, and remap limit vars */
 	pci_read_config_word(pdev, E7XXX_TOLM, &pci_data);
@@ -542,21 +475,20 @@
 	 */
 	if (edac_mc_add_mc(mci,0)) {
 		debugf3("%s(): failed edac_mc_add_mc()\n", __func__);
-		goto fail;
+		goto fail1;
 	}
 
 	/* get this far and it's successful */
 	debugf3("%s(): success\n", __func__);
 	return 0;
 
-fail:
-	if (mci != NULL) {
-		if(pvt != NULL && pvt->bridge_ck)
-			pci_dev_put(pvt->bridge_ck);
-		edac_mc_free(mci);
-	}
+fail1:
+	pci_dev_put(pvt->bridge_ck);
+
+fail0:
+	edac_mc_free(mci);
 
-	return rc;
+	return -ENODEV;
 }
 
 /* returns count (>= 0), or negative on error */
Index: linux-2.6.17-rc5/drivers/edac/i82860_edac.c
===================================================================
--- linux-2.6.17-rc5.orig/drivers/edac/i82860_edac.c	2006-05-25 11:41:54.000000000
-0600
+++ linux-2.6.17-rc5/drivers/edac/i82860_edac.c	2006-05-25 11:42:07.000000000 -0600
@@ -175,14 +175,9 @@
 
 static int i82860_probe1(struct pci_dev *pdev, int dev_idx)
 {
-	int rc = -ENODEV;
-	int index;
-	struct mem_ctl_info *mci = NULL;
-	unsigned long last_cumul_size;
+	struct mem_ctl_info *mci;
 	struct i82860_error_info discard;
 
-	u16 mchcfg_ddim;	/* DRAM Data Integrity Mode 0=none,2=edac */
-
 	/* RDRAM has channels but these don't map onto the abstractions that
 	   edac uses.
 	   The device groups from the GRA registers seem to map reasonably
@@ -199,53 +194,15 @@
 	debugf3("%s(): init mci\n", __func__);
 	mci->dev = &pdev->dev;
 	mci->mtype_cap = MEM_FLAG_DDR;
-
 	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED;
 	/* I"m not sure about this but I think that all RDRAM is SECDED */
 	mci->edac_cap = EDAC_FLAG_SECDED;
-	/* adjust FLAGS */
-
 	mci->mod_name = EDAC_MOD_STR;
 	mci->mod_ver = I82860_REVISION;
 	mci->ctl_name = i82860_devs[dev_idx].ctl_name;
 	mci->edac_check = i82860_check;
 	mci->ctl_page_to_phys = NULL;
-
-	pci_read_config_word(pdev, I82860_MCHCFG, &mchcfg_ddim);
-	mchcfg_ddim = mchcfg_ddim & 0x180;
-
-	/*
-	 * The group row boundary (GRA) reg values are boundary address
-	 * for each DRAM row with a granularity of 16MB.  GRA regs are
-	 * cumulative; therefore GRA15 will contain the total memory contained
-	 * in all eight rows.
-	 */
-	for (last_cumul_size = index = 0; index < mci->nr_csrows; index++) {
-		u16 value;
-		u32 cumul_size;
-		struct csrow_info *csrow = &mci->csrows[index];
-
-		pci_read_config_word(pdev, I82860_GBA + index * 2,
-				&value);
-
-		cumul_size = (value & I82860_GBA_MASK) <<
-		    (I82860_GBA_SHIFT - PAGE_SHIFT);
-		debugf3("%s(): (%d) cumul_size 0x%x\n", __func__, index,
-			cumul_size);
-
-		if (cumul_size == last_cumul_size)
-			continue;	/* not populated */
-
-		csrow->first_page = last_cumul_size;
-		csrow->last_page = cumul_size - 1;
-		csrow->nr_pages = cumul_size - last_cumul_size;
-		last_cumul_size = cumul_size;
-		csrow->grain = 1 << 12;  /* I82860_EAP has 4KiB reolution */
-		csrow->mtype = MEM_RMBS;
-		csrow->dtype = DEV_UNKNOWN;
-		csrow->edac_mode = mchcfg_ddim ? EDAC_SECDED : EDAC_NONE;
-	}
-
+	i82860_init_csrows(mci, pdev);
 	i82860_get_error_info(mci, &discard);  /* clear counters */
 
 	/* Here we assume that we will never see multiple instances of this
@@ -253,14 +210,17 @@
 	 */
 	if (edac_mc_add_mc(mci,0)) {
 		debugf3("%s(): failed edac_mc_add_mc()\n", __func__);
-		edac_mc_free(mci);
-	} else {
-		/* get this far and it's successful */
-		debugf3("%s(): success\n", __func__);
-		rc = 0;
+		goto fail;
 	}
 
-	return rc;
+	/* get this far and it's successful */
+	debugf3("%s(): success\n", __func__);
+
+	return 0;
+
+fail:
+	edac_mc_free(mci);
+	return -ENODEV;
 }
 
 /* returns count (>= 0), or negative on error */
Index: linux-2.6.17-rc5/drivers/edac/i82875p_edac.c
===================================================================
--- linux-2.6.17-rc5.orig/drivers/edac/i82875p_edac.c	2006-05-25 11:41:54.000000000
-0600
+++ linux-2.6.17-rc5/drivers/edac/i82875p_edac.c	2006-05-25 11:42:07.000000000 -0600
@@ -385,78 +385,27 @@
 static int i82875p_probe1(struct pci_dev *pdev, int dev_idx)
 {
 	int rc = -ENODEV;
-	int index;
-	struct mem_ctl_info *mci = NULL;
-	struct i82875p_pvt *pvt = NULL;
-	unsigned long last_cumul_size;
+	struct mem_ctl_info *mci;
+	struct i82875p_pvt *pvt;
 	struct pci_dev *ovrfl_pdev;
-	void __iomem *ovrfl_window = NULL;
+	void __iomem *ovrfl_window;
 	u32 drc;
-	u32 drc_chan;		/* Number of channels 0=1chan,1=2chan */
 	u32 nr_chans;
-	u32 drc_ddim;		/* DRAM Data Integrity Mode 0=none,2=edac */
 	struct i82875p_error_info discard;
 
 	debugf0("%s()\n", __func__);
 	ovrfl_pdev = pci_get_device(PCI_VEND_DEV(INTEL, 82875_6), NULL);
 
-	if (!ovrfl_pdev) {
-		/*
-		 * Intel tells BIOS developers to hide device 6 which
-		 * configures the overflow device access containing
-		 * the DRBs - this is where we expose device 6.
-		 * http://www.x86-secret.com/articles/tweak/pat/patsecrets-2.htm
-		 */
-		pci_write_bits8(pdev, 0xf4, 0x2, 0x2);
-		ovrfl_pdev =
-			pci_scan_single_device(pdev->bus, PCI_DEVFN(6, 0));
-
-		if (!ovrfl_pdev)
-			return -ENODEV;
-	}
-
-#ifdef CONFIG_PROC_FS
-	if (!ovrfl_pdev->procent && pci_proc_attach_device(ovrfl_pdev)) {
-		i82875p_printk(KERN_ERR,
-			"%s(): Failed to attach overflow device\n", __func__);
-		return -ENODEV;
-	}
-#endif
-				/* CONFIG_PROC_FS */
-	if (pci_enable_device(ovrfl_pdev)) {
-		i82875p_printk(KERN_ERR,
-			"%s(): Failed to enable overflow device\n", __func__);
+	if (i82875p_setup_overfl_dev(pdev, &ovrfl_pdev, &ovrfl_window))
 		return -ENODEV;
-	}
-
-	if (pci_request_regions(ovrfl_pdev, pci_name(ovrfl_pdev))) {
-#ifdef CORRECT_BIOS
-		goto fail0;
-#endif
-	}
-
-	/* cache is irrelevant for PCI bus reads/writes */
-	ovrfl_window = ioremap_nocache(pci_resource_start(ovrfl_pdev, 0),
-				pci_resource_len(ovrfl_pdev, 0));
-
-	if (!ovrfl_window) {
-		i82875p_printk(KERN_ERR, "%s(): Failed to ioremap bar6\n",
-			__func__);
-		goto fail1;
-	}
-
-	/* need to find out the number of channels */
 	drc = readl(ovrfl_window + I82875P_DRC);
-	drc_chan = ((drc >> 21) & 0x1);
-	nr_chans = drc_chan + 1;
-
-	drc_ddim = (drc >> 18) & 0x1;
+	nr_chans = dual_channel_active(drc) + 1;
 	mci = edac_mc_alloc(sizeof(*pvt), I82875P_NR_CSROWS(nr_chans),
 				nr_chans);
 
 	if (!mci) {
 		rc = -ENOMEM;
-		goto fail2;
+		goto fail0;
 	}
 
 	debugf3("%s(): init mci\n", __func__);
@@ -464,8 +413,6 @@
 	mci->mtype_cap = MEM_FLAG_DDR;
 	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED;
 	mci->edac_cap = EDAC_FLAG_UNKNOWN;
-	/* adjust FLAGS */
-
 	mci->mod_name = EDAC_MOD_STR;
 	mci->mod_ver = I82875P_REVISION;
 	mci->ctl_name = i82875p_devs[dev_idx].ctl_name;
@@ -475,36 +422,7 @@
 	pvt = (struct i82875p_pvt *) mci->pvt_info;
 	pvt->ovrfl_pdev = ovrfl_pdev;
 	pvt->ovrfl_window = ovrfl_window;
-
-	/*
-	 * The dram row boundary (DRB) reg values are boundary address
-	 * for each DRAM row with a granularity of 32 or 64MB (single/dual
-	 * channel operation).  DRB regs are cumulative; therefore DRB7 will
-	 * contain the total memory contained in all eight rows.
-	 */
-	for (last_cumul_size = index = 0; index < mci->nr_csrows; index++) {
-		u8 value;
-		u32 cumul_size;
-		struct csrow_info *csrow = &mci->csrows[index];
-
-		value = readb(ovrfl_window + I82875P_DRB + index);
-		cumul_size = value << (I82875P_DRB_SHIFT - PAGE_SHIFT);
-		debugf3("%s(): (%d) cumul_size 0x%x\n", __func__, index,
-			cumul_size);
-
-		if (cumul_size == last_cumul_size)
-			continue;	/* not populated */
-
-		csrow->first_page = last_cumul_size;
-		csrow->last_page = cumul_size - 1;
-		csrow->nr_pages = cumul_size - last_cumul_size;
-		last_cumul_size = cumul_size;
-		csrow->grain = 1 << 12;  /* I82875P_EAP has 4KiB reolution */
-		csrow->mtype = MEM_DDR;
-		csrow->dtype = DEV_UNKNOWN;
-		csrow->edac_mode = drc_ddim ? EDAC_SECDED : EDAC_NONE;
-	}
-
+	i82875p_init_csrows(mci, pdev, ovrfl_window, drc);
 	i82875p_get_error_info(mci, &discard);  /* clear counters */
 
 	/* Here we assume that we will never see multiple instances of this
@@ -512,25 +430,20 @@
 	 */
 	if (edac_mc_add_mc(mci,0)) {
 		debugf3("%s(): failed edac_mc_add_mc()\n", __func__);
-		goto fail3;
+		goto fail1;
 	}
 
 	/* get this far and it's successful */
 	debugf3("%s(): success\n", __func__);
 	return 0;
 
-fail3:
+fail1:
 	edac_mc_free(mci);
 
-fail2:
+fail0:
 	iounmap(ovrfl_window);
-
-fail1:
 	pci_release_regions(ovrfl_pdev);
 
-#ifdef CORRECT_BIOS
-fail0:
-#endif
 	pci_disable_device(ovrfl_pdev);
 	/* NOTE: the ovrfl proc entry and pci_dev are intentionally left */
 	return rc;
Index: linux-2.6.17-rc5/drivers/edac/r82600_edac.c
===================================================================
--- linux-2.6.17-rc5.orig/drivers/edac/r82600_edac.c	2006-05-25 11:41:54.000000000
-0600
+++ linux-2.6.17-rc5/drivers/edac/r82600_edac.c	2006-05-25 11:42:07.000000000 -0600
@@ -261,23 +261,16 @@
 
 static int r82600_probe1(struct pci_dev *pdev, int dev_idx)
 {
-	int rc = -ENODEV;
-	int index;
-	struct mem_ctl_info *mci = NULL;
+	struct mem_ctl_info *mci;
 	u8 dramcr;
-	u32 ecc_on;
-	u32 reg_sdram;
 	u32 eapr;
 	u32 scrub_disabled;
 	u32 sdram_refresh_rate;
-	u32 row_high_limit_last = 0;
 	struct r82600_error_info discard;
 
 	debugf0("%s()\n", __func__);
 	pci_read_config_byte(pdev, R82600_DRAMC, &dramcr);
 	pci_read_config_dword(pdev, R82600_EAP, &eapr);
-	ecc_on = dramcr & BIT(5);
-	reg_sdram = dramcr & BIT(4);
 	scrub_disabled = eapr & BIT(31);
 	sdram_refresh_rate = dramcr & (BIT(0) | BIT(1));
 	debugf2("%s(): sdram refresh rate = %#0x\n", __func__,
@@ -285,10 +278,8 @@
 	debugf2("%s(): DRAMC register = %#0x\n", __func__, dramcr);
 	mci = edac_mc_alloc(0, R82600_NR_CSROWS, R82600_NR_CHANS);
 
-	if (mci == NULL) {
-		rc = -ENOMEM;
-		goto fail;
-	}
+	if (mci == NULL)
+		return -ENOMEM;
 
 	debugf0("%s(): mci = %p\n", __func__, mci);
 	mci->dev = &pdev->dev;
@@ -304,7 +295,7 @@
 	 * is possible.                                               */
 	mci->edac_cap = EDAC_FLAG_NONE | EDAC_FLAG_EC | EDAC_FLAG_SECDED;
 
-	if (ecc_on) {
+	if (ecc_enabled(dramcr)) {
 		if (scrub_disabled)
 			debugf3("%s(): mci = %p - Scrubbing disabled! EAP: "
 				"%#0x\n", __func__, mci, eapr);
@@ -316,46 +307,7 @@
 	mci->ctl_name = "R82600";
 	mci->edac_check = r82600_check;
 	mci->ctl_page_to_phys = NULL;
-
-	for (index = 0; index < mci->nr_csrows; index++) {
-		struct csrow_info *csrow = &mci->csrows[index];
-		u8 drbar;	/* sDram Row Boundry Address Register */
-		u32 row_high_limit;
-		u32 row_base;
-
-		/* find the DRAM Chip Select Base address and mask */
-		pci_read_config_byte(pdev, R82600_DRBA + index, &drbar);
-
-		debugf1("MC%d: %s() Row=%d DRBA = %#0x\n", mci->mc_idx,
-			__func__, index, drbar);
-
-		row_high_limit = ((u32) drbar << 24);
-/*		row_high_limit = ((u32)drbar << 24) | 0xffffffUL; */
-
-		debugf1("MC%d: %s() Row=%d, Boundry Address=%#0x, Last = "
-			"%#0x \n", mci->mc_idx, __func__, index,
-			row_high_limit, row_high_limit_last);
-
-		/* Empty row [p.57] */
-		if (row_high_limit == row_high_limit_last)
-			continue;
-
-		row_base = row_high_limit_last;
-		csrow->first_page = row_base >> PAGE_SHIFT;
-		csrow->last_page = (row_high_limit >> PAGE_SHIFT) - 1;
-		csrow->nr_pages = csrow->last_page - csrow->first_page + 1;
-		/* Error address is top 19 bits - so granularity is      *
-		 * 14 bits                                               */
-		csrow->grain = 1 << 14;
-		csrow->mtype = reg_sdram ? MEM_RDDR : MEM_DDR;
-		/* FIXME - check that this is unknowable with this chipset */
-		csrow->dtype = DEV_UNKNOWN;
-
-		/* Mode is global on 82600 */
-		csrow->edac_mode = ecc_on ? EDAC_SECDED : EDAC_NONE;
-		row_high_limit_last = row_high_limit;
-	}
-
+	r82600_init_csrows(mci, pdev, dramcr);
 	r82600_get_error_info(mci, &discard);  /* clear counters */
 
 	/* Here we assume that we will never see multiple instances of this
@@ -378,10 +330,8 @@
 	return 0;
 
 fail:
-	if (mci)
-		edac_mc_free(mci);
-
-	return rc;
+	edac_mc_free(mci);
+	return -ENODEV;
 }
 
 /* returns count (>= 0), or negative on error */

