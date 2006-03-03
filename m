Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752132AbWCCBsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132AbWCCBsb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 20:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752138AbWCCBsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 20:48:31 -0500
Received: from smtp-2.llnl.gov ([128.115.3.82]:29677 "EHLO smtp-2.llnl.gov")
	by vger.kernel.org with ESMTP id S1752132AbWCCBsT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 20:48:19 -0500
From: Dave Peterson <dsp@llnl.gov>
To: alan@lxorguk.ukuu.org.uk, akpm@osdl.org
Subject: [PATCH 9/15] EDAC: cleanup code for clearing initial errors
Date: Thu, 2 Mar 2006 17:48:05 -0800
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, bluesmoke-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603021748.05333.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix xxx_probe1() functions so they call xxx_get_error_info() functions
to clear initial errors.  This is simpler and cleaner than duplicating
the low-level code for accessing PCI config space.

Signed-Off-By: David S. Peterson <dsp@llnl.gov> <dave_peterson@pobox.com>
---

Index: linux-2.6.16-rc5-edac/drivers/edac/amd76x_edac.c
===================================================================
--- linux-2.6.16-rc5-edac.orig/drivers/edac/amd76x_edac.c	2006-02-27 17:00:39.000000000 -0800
+++ linux-2.6.16-rc5-edac/drivers/edac/amd76x_edac.c	2006-02-27 17:05:48.000000000 -0800
@@ -211,6 +211,7 @@ static int amd76x_probe1(struct pci_dev 
 	};
 	u32 ems;
 	u32 ems_mode;
+	struct amd76x_error_info discard;
 
 	debugf0("%s()\n", __func__);
 
@@ -270,9 +271,7 @@ static int amd76x_probe1(struct pci_dev 
 		csrow->edac_mode = ems_modes[ems_mode];
 	}
 
-	/* clear counters */
-	pci_write_bits32(mci->pdev, AMD76X_ECC_MODE_STATUS, (u32) (0x3 << 8),
-			 (u32) (0x3 << 8));
+	amd76x_get_error_info(mci, &discard);  /* clear counters */
 
 	if (edac_mc_add_mc(mci)) {
 		debugf3("%s(): failed edac_mc_add_mc()\n", __func__);
Index: linux-2.6.16-rc5-edac/drivers/edac/e752x_edac.c
===================================================================
--- linux-2.6.16-rc5-edac.orig/drivers/edac/e752x_edac.c	2006-02-27 17:03:40.000000000 -0800
+++ linux-2.6.16-rc5-edac/drivers/edac/e752x_edac.c	2006-02-27 17:05:48.000000000 -0800
@@ -747,8 +747,6 @@ static int e752x_probe1(struct pci_dev *
 	int rc = -ENODEV;
 	int index;
 	u16 pci_data;
-	u32 stat32;
-	u16 stat16;
 	u8 stat8;
 	struct mem_ctl_info *mci = NULL;
 	struct e752x_pvt *pvt = NULL;
@@ -760,6 +758,7 @@ static int e752x_probe1(struct pci_dev *
 	u32 dra;
 	unsigned long last_cumul_size;
 	struct pci_dev *dev = NULL;
+	struct e752x_error_info discard;
 
 	debugf0("%s(): mci\n", __func__);
 	debugf0("Starting Probe1\n");
@@ -938,24 +937,7 @@ static int e752x_probe1(struct pci_dev *
 	pci_write_config_byte(dev, E752X_DRAM_ERRMASK, 0x00);
 	pci_write_config_byte(dev, E752X_DRAM_SMICMD, 0x00);
 	/* clear other MCH errors */
-	pci_read_config_dword(dev, E752X_FERR_GLOBAL, &stat32);
-	pci_write_config_dword(dev, E752X_FERR_GLOBAL, stat32);
-	pci_read_config_dword(dev, E752X_NERR_GLOBAL, &stat32);
-	pci_write_config_dword(dev, E752X_NERR_GLOBAL, stat32);
-	pci_read_config_byte(dev, E752X_HI_FERR, &stat8);
-	pci_write_config_byte(dev, E752X_HI_FERR, stat8);
-	pci_read_config_byte(dev, E752X_HI_NERR, &stat8);
-	pci_write_config_byte(dev, E752X_HI_NERR, stat8);
-	pci_read_config_dword(dev, E752X_SYSBUS_FERR, &stat32);
-	pci_write_config_dword(dev, E752X_SYSBUS_FERR, stat32);
-	pci_read_config_byte(dev, E752X_BUF_FERR, &stat8);
-	pci_write_config_byte(dev, E752X_BUF_FERR, stat8);
-	pci_read_config_byte(dev, E752X_BUF_NERR, &stat8);
-	pci_write_config_byte(dev, E752X_BUF_NERR, stat8);
-	pci_read_config_word(dev, E752X_DRAM_FERR, &stat16);
-	pci_write_config_word(dev, E752X_DRAM_FERR, stat16);
-	pci_read_config_word(dev, E752X_DRAM_NERR, &stat16);
-	pci_write_config_word(dev, E752X_DRAM_NERR, stat16);
+	e752x_get_error_info(mci, &discard);
 
 	/* get this far and it's successful */
 	debugf3("%s(): success\n", __func__);
Index: linux-2.6.16-rc5-edac/drivers/edac/e7xxx_edac.c
===================================================================
--- linux-2.6.16-rc5-edac.orig/drivers/edac/e7xxx_edac.c	2006-02-27 17:05:19.000000000 -0800
+++ linux-2.6.16-rc5-edac/drivers/edac/e7xxx_edac.c	2006-02-27 17:05:48.000000000 -0800
@@ -357,7 +357,7 @@ static int e7xxx_probe1(struct pci_dev *
 	int drc_ddim;		/* DRAM Data Integrity Mode 0=none,2=edac */
 	u32 dra;
 	unsigned long last_cumul_size;
-
+	struct e7xxx_error_info discard;
 
 	debugf0("%s(): mci\n", __func__);
 
@@ -470,8 +470,7 @@ static int e7xxx_probe1(struct pci_dev *
 		     pvt->tolm, pvt->remapbase, pvt->remaplimit);
 
 	/* clear any pending errors, or initial state bits */
-	pci_write_bits8(pvt->bridge_ck, E7XXX_DRAM_FERR, 0x03, 0x03);
-	pci_write_bits8(pvt->bridge_ck, E7XXX_DRAM_NERR, 0x03, 0x03);
+	e7xxx_get_error_info(mci, &discard);
 
 	if (edac_mc_add_mc(mci) != 0) {
 		debugf3("%s(): failed edac_mc_add_mc()\n", __func__);
Index: linux-2.6.16-rc5-edac/drivers/edac/edac_mc.c
===================================================================
--- linux-2.6.16-rc5-edac.orig/drivers/edac/edac_mc.c	2006-02-27 16:58:41.000000000 -0800
+++ linux-2.6.16-rc5-edac/drivers/edac/edac_mc.c	2006-02-27 17:05:48.000000000 -0800
@@ -2055,9 +2055,6 @@ static int __init edac_mc_init(void)
 	 */
 	clear_pci_parity_errors();
 
-	/* perform check for first time to harvest boot leftovers */
-	do_edac_check();
-
 	/* Create the MC sysfs entires */
 	if (edac_sysfs_memctrl_setup()) {
 		edac_printk(KERN_ERR, EDAC_MC,
Index: linux-2.6.16-rc5-edac/drivers/edac/i82860_edac.c
===================================================================
--- linux-2.6.16-rc5-edac.orig/drivers/edac/i82860_edac.c	2006-02-27 17:04:14.000000000 -0800
+++ linux-2.6.16-rc5-edac/drivers/edac/i82860_edac.c	2006-02-27 17:05:48.000000000 -0800
@@ -134,6 +134,7 @@ static int i82860_probe1(struct pci_dev 
 	int index;
 	struct mem_ctl_info *mci = NULL;
 	unsigned long last_cumul_size;
+	struct i82860_error_info discard;
 
 	u16 mchcfg_ddim;	/* DRAM Data Integrity Mode 0=none,2=edac */
 
@@ -200,8 +201,7 @@ static int i82860_probe1(struct pci_dev 
 		csrow->edac_mode = mchcfg_ddim ? EDAC_SECDED : EDAC_NONE;
 	}
 
-	/* clear counters */
-	pci_write_bits16(mci->pdev, I82860_ERRSTS, 0x0003, 0x0003);
+	i82860_get_error_info(mci, &discard);  /* clear counters */
 
 	if (edac_mc_add_mc(mci)) {
 		debugf3("%s(): failed edac_mc_add_mc()\n", __func__);
Index: linux-2.6.16-rc5-edac/drivers/edac/i82875p_edac.c
===================================================================
--- linux-2.6.16-rc5-edac.orig/drivers/edac/i82875p_edac.c	2006-02-27 17:04:31.000000000 -0800
+++ linux-2.6.16-rc5-edac/drivers/edac/i82875p_edac.c	2006-02-27 17:05:48.000000000 -0800
@@ -286,6 +286,7 @@ static int i82875p_probe1(struct pci_dev
 	u32 drc_chan;		/* Number of channels 0=1chan,1=2chan */
 	u32 nr_chans;
 	u32 drc_ddim;		/* DRAM Data Integrity Mode 0=none,2=edac */
+	struct i82875p_error_info discard;
 
 	debugf0("%s()\n", __func__);
 
@@ -397,8 +398,7 @@ static int i82875p_probe1(struct pci_dev
 		csrow->edac_mode = drc_ddim ? EDAC_SECDED : EDAC_NONE;
 	}
 
-	/* clear counters */
-	pci_write_bits16(mci->pdev, I82875P_ERRSTS, 0x0081, 0x0081);
+	i82875p_get_error_info(mci, &discard);  /* clear counters */
 
 	if (edac_mc_add_mc(mci)) {
 		debugf3("%s(): failed edac_mc_add_mc()\n", __func__);
Index: linux-2.6.16-rc5-edac/drivers/edac/r82600_edac.c
===================================================================
--- linux-2.6.16-rc5-edac.orig/drivers/edac/r82600_edac.c	2006-02-27 16:58:41.000000000 -0800
+++ linux-2.6.16-rc5-edac/drivers/edac/r82600_edac.c	2006-02-27 17:05:48.000000000 -0800
@@ -219,7 +219,7 @@ static int r82600_probe1(struct pci_dev 
 	u32 scrub_disabled;
 	u32 sdram_refresh_rate;
 	u32 row_high_limit_last = 0;
-	u32 eap_init_bits;
+	struct r82600_error_info discard;
 
 	debugf0("%s()\n", __func__);
 
@@ -311,8 +311,7 @@ static int r82600_probe1(struct pci_dev 
 		row_high_limit_last = row_high_limit;
 	}
 
-	/* clear counters */
-	/* FIXME should we? */
+	r82600_get_error_info(mci, &discard);  /* clear counters */
 
 	if (edac_mc_add_mc(mci)) {
 		debugf3("%s(): failed edac_mc_add_mc()\n", __func__);
@@ -321,19 +320,12 @@ static int r82600_probe1(struct pci_dev 
 
 	/* get this far and it's successful */
 
-	/* Clear error flags to allow next error to be reported [p.62] */
-	/* Test systems seem to always have the UE flag raised on boot */
-
-	eap_init_bits = BIT(0) & BIT(1);
 	if (disable_hardware_scrub) {
-		eap_init_bits |= BIT(31);
 		debugf3("%s(): Disabling Hardware Scrub (scrub on error)\n",
 			__func__);
+		pci_write_bits32(mci->pdev, R82600_EAP, BIT(31), BIT(31));
 	}
 
-	pci_write_bits32(mci->pdev, R82600_EAP, eap_init_bits,
-			 eap_init_bits);
-
 	debugf3("%s(): success\n", __func__);
 	return 0;
 
