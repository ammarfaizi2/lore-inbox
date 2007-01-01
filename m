Return-Path: <linux-kernel-owner+w=401wt.eu-S1752734AbXAAVox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752734AbXAAVox (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 16:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754323AbXAAVox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 16:44:53 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:32443 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665AbXAAVov (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 16:44:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=gwZBPZrg3z0bOENdGjjGIn6gXRhiGkdm5wC0OkldvaTWvBKG5yXpkeuM4jP3yAg599WM/JzP+r7ZHTiIF7lPdrkgzExVqofM02K/jq0+69PuA7hT+k6knKifDryKAHp4jD5A4Rt3RwTIWuRWEPctsO+XJD2RssyIIdH9+NF9mt8=
Date: Mon, 1 Jan 2007 22:44:42 +0100
From: Luca Tettamanti <kronos.it@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, Solomon Peachy <pizza@shaftnet.org>,
       linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [PATCH] radeonfb: add support for newer cards
Message-ID: <20070101214442.GA21950@dreamland.darkstar.lan>
References: <20070101212551.GA19598@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070101212551.GA19598@dreamland.darkstar.lan>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Mon, Jan 01, 2007 at 10:25:51PM +0100, Luca Tettamanti ha scritto: 
> Hi Ben, Andrew,
> I've rebased 'ATOM BIOS patch' from Solomon Peachy to apply to 2.6.20.
> The patch adds support for newer Radeon cards and is mainly based on
> X.Org code.

And - for an easier review - this is the diff between
radeonfb-atom-2.6.19-v6a.diff from Solomon and my patch (whitespace-only
changes not included).

---
 drivers/video/aty/radeon_base.c    |   26 +-
 drivers/video/aty/radeon_i2c.c     |    8 
 drivers/video/aty/radeon_monitor.c |  347 ++++++++++++++++++-----------------
 3 files changed, 198 insertions(+), 183 deletions(-)

diff -wu linux-2.6/drivers/video/aty/radeon_base.c linux-2.6.git/drivers/video/aty/radeon_base.c
--- linux-2.6/drivers/video/aty/radeon_base.c	2007-01-01 22:31:14.000000000 +0100
+++ linux-2.6.git/drivers/video/aty/radeon_base.c	2007-01-01 19:38:54.000000000 +0100
@@ -287,7 +287,6 @@
 /*
  * globals
  */
-        
 static char *mode_option;
 static char *monitor_layout;
 static int noaccel = 0;
@@ -663,21 +662,20 @@
 {
 #ifdef CONFIG_PPC_OF
 	  rinfo->is_atom_bios = 0;
-	  rinfo->get_pll_info = radeon_get_pll_info_openfirmware;
-	  rinfo->get_lvds_info = radeon_get_lvds_info_openfirmware;
+	rinfo->radeon_get_pll_info = radeon_get_pll_info_openfirmware;
+	rinfo->radeon_get_lvds_info = radeon_get_lvds_info_openfirmware;
 	  rinfo->radeon_get_tmds_info = NULL;
-	  rinfo->get_conn_info = radeon_get_conn_info_openfirmware;
+	rinfo->radeon_get_conn_info = radeon_get_conn_info_openfirmware;
 #else
 	  int tmp = rinfo->fp_bios_start + 4;
+	unsigned char sign[4];
+
+	sign[0] = BIOS_IN8(tmp);
+	sign[1] = BIOS_IN8(tmp + 1);
+	sign[2] = BIOS_IN8(tmp + 2);
+	sign[3] = BIOS_IN8(tmp + 3);
 
-	  if ((BIOS_IN8(tmp) == 'A' &&
-	       BIOS_IN8(tmp+1) == 'T' &&
-	       BIOS_IN8(tmp+2) == 'O' &&
-	       BIOS_IN8(tmp+3) == 'M') ||
-	      (BIOS_IN8(tmp) == 'M' &&
-	       BIOS_IN8(tmp+1) == 'O' &&
-	       BIOS_IN8(tmp+2) == 'T' &&
-	       BIOS_IN8(tmp+3) == 'A')) {
+	if (!memcmp(sign, "ATOM", 4) || !memcmp(sign, "MOTA", 4)) {
 		  rinfo->is_atom_bios = 1;
 
 		  rinfo->atom_data_start = BIOS_IN16(rinfo->fp_bios_start + 32);
@@ -1075,7 +1073,8 @@
 	OUTREG(CRTC_EXT_CNTL, val);
 
 	for (i = 0 ; i < RADEON_MAX_CONNECTORS ; i++) {
-		if (i == -1) continue;
+		if (rinfo->heads[i] == -1)
+			continue;
 
 		switch (rinfo->connectors[rinfo->heads[i]].mon_type) {
 		case MT_DFP:
@@ -2571,7 +2570,6 @@
 {
         struct fb_info *info = pci_get_drvdata(pdev);
         struct radeonfb_info *rinfo = info->par;
-
 	int i;
 
         if (!rinfo)
diff -wu linux-2.6/drivers/video/aty/radeon_i2c.c linux-2.6.git/drivers/video/aty/radeon_i2c.c
--- linux-2.6/drivers/video/aty/radeon_i2c.c	2007-01-01 22:31:14.000000000 +0100
+++ linux-2.6.git/drivers/video/aty/radeon_i2c.c	2007-01-01 19:16:03.000000000 +0100
@@ -149,14 +149,18 @@
 	    (INREG(LVDS_GEN_CNTL) & (LVDS_ON|LVDS_EN))) {
 			RTRACE("radeonfb: I2C (port %d) ... found LVDS panel\n", conn->ddc_type);
 			mon_type = MT_LCD;
+			edid = NULL;
 			goto done;
 	}
 
+	if (conn->ddc_type == ddc_none)
+		return 1;
 	edid = fb_ddc_read(&rinfo->i2c[conn->ddc_type].adapter);
 
 	if (!edid) {
-	  // what about the special case where we are a DFP/LVDS, but have a DDC connection..
-	  // but no EDID? We should fall back to MT_LCD...?  XXXX
+		/* what about the special case where we are a DFP/LVDS, but have a DDC connection
+		 * but no EDID? We should fall back to MT_LCD...?  XXXX
+		 */
 		RTRACE("radeonfb: I2C (port %d) ... not found\n", conn->ddc_type);
 		mon_type = MT_NONE;
 		goto done;
diff -wu linux-2.6/drivers/video/aty/radeon_monitor.c linux-2.6.git/drivers/video/aty/radeon_monitor.c
--- linux-2.6/drivers/video/aty/radeon_monitor.c	2007-01-01 22:31:14.000000000 +0100
+++ linux-2.6.git/drivers/video/aty/radeon_monitor.c	2007-01-01 19:36:51.000000000 +0100
@@ -16,7 +16,7 @@
     {{15000, 0xa1b}, {0xffffffff, 0xa3f}, {0, 0}, {0, 0}},	/*CHIP_FAMILY_R200*/
     {{15500, 0x81b}, {0xffffffff, 0x83f}, {0, 0}, {0, 0}},	/*CHIP_FAMILY_RV250*/
     {{0, 0}, {0, 0}, {0, 0}, {0, 0}},				/*CHIP_FAMILY_RS300*/
-    {{13000, 0x400f4}, {15000, 0x400f7}, {0xffffffff, 0x400f7/*0x40111*/}, {0, 0}},	/*CHIP_FAMILY_RV280*/
+	{{13000, 0x400f4}, {15000, 0x400f7}, {0xffffffff, 0x400f7}, {0, 0}},	/*CHIP_FAMILY_RV280*/
     {{0xffffffff, 0xb01cb}, {0, 0}, {0, 0}, {0, 0}},		/*CHIP_FAMILY_R300*/
     {{0xffffffff, 0xb01cb}, {0, 0}, {0, 0}, {0, 0}},		/*CHIP_FAMILY_R350*/
     {{15000, 0xb0155}, {0xffffffff, 0xb01cb}, {0, 0}, {0, 0}},	/*CHIP_FAMILY_RV350*/
@@ -46,132 +46,6 @@
 	.vmode		= FB_VMODE_NONINTERLACED
 };
 
-#ifdef CONFIG_PPC_OF
-/*
- * Try to find monitor informations & EDID data out of the Open Firmware
- * device-tree. This also contains some "hacks" to work around a few machine
- * models with broken OF probing by hard-coding known EDIDs for some Mac
- * laptops internal LVDS panel. (XXX: not done yet)
- */
-static int __devinit radeon_parse_montype_prop(struct device_node *dp,
-					       struct radeon_connector *conn, 
-					       int hdno)
-{
-        static char *propnames[] = { "DFP,EDID", "LCD,EDID", "EDID",
-				     "EDID1", "EDID2",  NULL };
-	const u8 *pedid = NULL;
-	const u8 *pmt = NULL;
-	u8 *tmp;
-        int i;  
-	
-	RTRACE("analyzing OF properties...\n");
-	pmt = get_property(dp, "display-type", NULL);
-	if (!pmt)
-		return 1;
-	RTRACE("display-type: %s\n", pmt);
-	if (!strcmp(pmt, "LCD") || !strcmp(pmt, "DFP")) {
-		/* OF says "LCD" for DFP as well.*/
-		if (rinfo->is_mobility) {
-			conn->mon_type = MT_LCD;
-			/* Maybe check for LVDS_GEN_CNTL here ? I need to check out
-			 * what OF does when booting with lid closed
-			 */
-		} else{
-			conn->mon_type = MT_DFP;
-		}
-	} else if (!strcmp(pmt, "CRT")) {
-		conn->mon_type = MT_CRT;
-	} else {
-		if (strcmp(pmt, "NONE") != 0)
-			printk(KERN_WARNING "radeonfb: Unknown OF display-type: %s\n",
-			       pmt);
-		return 1;
-	}
-
-	for (i = 0; propnames[i] != NULL; ++i) {
-		pedid = get_property(dp, propnames[i], NULL);
-		if (pedid != NULL)
-			break;
-	}
-	/* We didn't find the EDID in the leaf node, some cards will actually
-	 * put EDID1/EDID2 in the parent, look for these (typically M6 tipb).
-	 * single-head cards have hdno == -1 and skip this step
-	 */
-	if (pedid == NULL && dp->parent && (hdno != -1))
-		pedid = get_property(dp->parent, (hdno == 0) ? "EDID1" : "EDID2", NULL);
-	if (pedid == NULL && dp->parent && (hdno == 0))
-		pedid = get_property(dp->parent, "EDID", NULL);
-	if (pedid == NULL)
-		return 1;
-
-	tmp = (u8 *)kmalloc(EDID_LENGTH, GFP_KERNEL);
-	if (tmp) {
-		memcpy(tmp, pedid, EDID_LENGTH);
-	}
-
-	conn->edid = tmp;
-
-	{
-		int found_tmds = 0;
-		int found_crt = 0;
-		int ddc_type = ddc_none;
-		// XXX what about reversed DAC/TMDS??
-		radeon_fill_conn(conn, conn->mon_type, ddc_type, &found_crt, &found_tmds);
-	}
-
-	return 0;
-}
-
-/* return a 1 on error */
-static int __devinit radeon_probe_OF_head(struct radeonfb_info *rinfo, int head_no)
-
-{
-	struct radeon_connector *conn;
-        struct device_node *dp;
-	u8 *out_EDID;
-
-	RTRACE("radeon_probe_OF_head\n");
-
-	conn = rinfo->connectors[head_no];
-
-        dp = rinfo->of_node;
-        if (dp == NULL) 
-		return 1;
-
-	if (rinfo->has_CRTC2) {
-		const char *pname;
-		int len, second = 0;
-
-		dp = dp->child;
-		do {
-			if (!dp) 
-				return 1;
-
-			pname = get_property(dp, "name", NULL);
-			if (!pname) 
-				return 1;
-
-			len = strlen(pname);
-			RTRACE("head: %s (letter: %c, head_no: %d)\n",
-			       pname, pname[len-1], head_no);
-			if (pname[len-1] == 'A' && head_no == 0) {
-				return radeon_parse_montype_prop(dp, conn, 0);
-			} else if (pname[len-1] == 'B' && head_no == 1) {
-				return radeon_parse_montype_prop(dp, conn, 1);
-			}
-			second = 1;
-			dp = dp->sibling;
-		} while(!second);
-	} else {
-		if (head_no > 0) {
-			return 1;
-		}
-		return radeon_parse_montype_prop(dp, conn, -1);
-	}
-	return 1;
-}
-#endif /* CONFIG_PPC_OF */
-
 
 int __devinit radeon_get_lvds_info_atom(struct radeonfb_info *rinfo)
 {
@@ -310,13 +184,12 @@
 void __devinit radeon_get_tmds_info(struct radeonfb_info *rinfo)
 {
 	int i;
+	int family = rinfo->family;
 
 	/* Get default TMDS infos for this chip */
 	for (i=0; i<4; i++) {
-		rinfo->tmds_pll[i].value =
-			default_tmds_pll[rinfo->family][i].value;
-		rinfo->tmds_pll[i].freq =
-			default_tmds_pll[rinfo->family][i].freq;
+		rinfo->tmds_pll[i].value = default_tmds_pll[family][i].value;
+		rinfo->tmds_pll[i].freq = default_tmds_pll[family][i].freq;
 	}
 
 	/* Get whatever the firmware provides */
@@ -431,33 +304,38 @@
 		conn->conn_type = conn_vga;
 		conn->tmds_type = tmds_unknown;
 		conn->dac_type = (*found_crt) ? dac_tvdac: dac_primary;
-		if (ddc_type == ddc_none) conn->ddc_type = (*found_crt) ? ddc_crt2 : ddc_vga;
+		if (ddc_type == ddc_none)
+			conn->ddc_type = (*found_crt) ? ddc_crt2 : ddc_vga;
 		*found_crt = 1;
 		break;
 	case MT_DFP:
 		conn->conn_type = conn_dvi_i;
 		conn->tmds_type = (*found_tmds) ? tmds_external: tmds_internal;
 		conn->dac_type = dac_unknown;
-		if (ddc_type == ddc_none) conn->ddc_type = ddc_dvi;
+		if (ddc_type == ddc_none)
+			conn->ddc_type = ddc_dvi;
 		*found_tmds = 1;
 		break;
 	case MT_LCD:
 		conn->conn_type = conn_lvds;
 		conn->tmds_type = tmds_unknown;
 		conn->dac_type = dac_unknown;
-		if (ddc_type == ddc_none) conn->ddc_type = ddc_none; //heh
+		if (ddc_type == ddc_none)
+			conn->ddc_type = ddc_none; //heh
 		break;
 	case MT_CTV:
 		conn->conn_type = conn_ctv;
 		conn->tmds_type = tmds_unknown;
 		conn->dac_type = dac_tvdac;
-		if (ddc_type == ddc_none) conn->ddc_type = ddc_vga; // XXX ddc_crt2?
+		if (ddc_type == ddc_none)
+			conn->ddc_type = ddc_vga; // XXX ddc_crt2?
 		break;
 	case MT_STV:
 		conn->conn_type = conn_stv;
 		conn->tmds_type = tmds_unknown;
 		conn->dac_type = dac_tvdac;
-		if (ddc_type == ddc_none) conn->ddc_type = ddc_vga; // XXX ddc_crt2?
+		if (ddc_type == ddc_none)
+			conn->ddc_type = ddc_vga; // XXX ddc_crt2?
 		break;
 	case MT_UNKNOWN:
 	case MT_NONE:
@@ -473,6 +351,127 @@
 	// leaves conn_digital, conn_unsupported, conn_propritetary
 }
 
+#ifdef CONFIG_PPC_OF
+/*
+ * Try to find monitor informations & EDID data out of the Open Firmware
+ * device-tree. This also contains some "hacks" to work around a few machine
+ * models with broken OF probing by hard-coding known EDIDs for some Mac
+ * laptops internal LVDS panel. (XXX: not done yet)
+ */
+static int __devinit radeon_parse_montype_prop(struct radeonfb_info *rinfo,
+					       struct device_node *dp,
+					       struct radeon_connector *conn,
+					       int hdno)
+{
+	static char *propnames[] = { "DFP,EDID", "LCD,EDID", "EDID",
+				     "EDID1", "EDID2",  NULL };
+	const u8 *pedid = NULL;
+	const u8 *pmt = NULL;
+	u8 *tmp;
+	int i;
+
+	RTRACE("analyzing OF properties...\n");
+	pmt = get_property(dp, "display-type", NULL);
+	if (!pmt)
+		return -1;
+	RTRACE("display-type: %s\n", pmt);
+	if (!strcmp(pmt, "LCD") || !strcmp(pmt, "DFP")) {
+		/* OF says "LCD" for DFP as well.*/
+		if (rinfo->is_mobility) {
+			conn->mon_type = MT_LCD;
+			/* Maybe check for LVDS_GEN_CNTL here ? I need to check out
+			 * what OF does when booting with lid closed
+			 */
+		} else{
+			conn->mon_type = MT_DFP;
+		}
+	} else if (!strcmp(pmt, "CRT")) {
+		conn->mon_type = MT_CRT;
+	} else {
+		if (strcmp(pmt, "NONE") != 0)
+			printk(KERN_WARNING "radeonfb: Unknown OF display-type: %s\n",
+			       pmt);
+		return -1;
+	}
+
+	for (i = 0; propnames[i] != NULL; ++i) {
+		pedid = get_property(dp, propnames[i], NULL);
+		if (pedid != NULL)
+			break;
+	}
+	/* We didn't find the EDID in the leaf node, some cards will actually
+	 * put EDID1/EDID2 in the parent, look for these (typically M6 tipb).
+	 * single-head cards have hdno == -1 and skip this step
+	 */
+	if (pedid == NULL && dp->parent && (hdno != -1))
+		pedid = get_property(dp->parent, (hdno == 0) ? "EDID1" : "EDID2", NULL);
+	if (pedid == NULL && dp->parent && (hdno == 0))
+		pedid = get_property(dp->parent, "EDID", NULL);
+	if (pedid == NULL)
+		return -1;
+
+	tmp = kmemdup(pedid, EDID_LENGTH, GFP_KERNEL);
+	conn->edid = tmp;
+
+	{
+		int found_tmds = 0;
+		int found_crt = 0;
+		int ddc_type = ddc_none;
+		// XXX what about reversed DAC/TMDS??
+		radeon_fill_conn(conn, conn->mon_type, ddc_type, &found_crt, &found_tmds);
+	}
+
+	return 0;
+}
+
+/* return a -1 on error */
+static int __devinit radeon_probe_OF_head(struct radeonfb_info *rinfo, int head_no)
+
+{
+	struct radeon_connector *conn;
+	struct device_node *dp;
+
+	RTRACE("radeon_probe_OF_head\n");
+
+	conn = &rinfo->connectors[head_no];
+
+	dp = rinfo->of_node;
+	if (dp == NULL)
+		return -1;
+
+	if (rinfo->has_CRTC2) {
+		const char *pname;
+		int len, second = 0;
+
+		dp = dp->child;
+		do {
+			if (!dp)
+				return -1;
+
+			pname = get_property(dp, "name", NULL);
+			if (!pname) 
+				return -1;
+
+			len = strlen(pname);
+			RTRACE("head: %s (letter: %c, head_no: %d)\n",
+			       pname, pname[len-1], head_no);
+			if (pname[len-1] == 'A' && head_no == 0) {
+				return radeon_parse_montype_prop(rinfo, dp, conn, 0);
+			} else if (pname[len-1] == 'B' && head_no == 1) {
+				return radeon_parse_montype_prop(rinfo, dp, conn, 1);
+			}
+			second = 1;
+			dp = dp->sibling;
+		} while(!second);
+	} else {
+		if (head_no > 0)
+			return -1;
+		return radeon_parse_montype_prop(rinfo, dp, conn, -1);
+	}
+	return -1;
+}
+#endif /* CONFIG_PPC_OF */
+
 /*
  * Get informations about the various connectors on this card. This is
  * the most prone to fail function as various firmwares tend to say
@@ -513,8 +512,8 @@
 		for (i = 0; i < 4; i++) {
 			conn.ddc_type = i;
 			if (!radeon_probe_i2c_connector(rinfo, &conn)) {
-
-				radeon_fill_conn(&rinfo->connectors[idx++], conn.mon_type, conn.ddc_type, &found_tmds, &found_crt); 
+				radeon_fill_conn(&rinfo->connectors[idx++], conn.mon_type, conn.ddc_type,
+						 &found_tmds, &found_crt);
 			}
 		}
 
@@ -600,10 +599,12 @@
 int __devinit radeon_get_conn_info_openfirmware(struct radeonfb_info *rinfo)
 {
 	int i;
-	int not_found = 1;
+	int found = 0;
 
-	for(i = 0 ; < 2 ; i++) {  /* Only two heads for OF! */
-		if (!radeon_probe_OF_head(rinfo, i)) found = 0;
+	/* Only two heads for OF! */
+	for(i = 0 ; i < 2 ; i++) {
+		if (!radeon_probe_OF_head(rinfo, i))
+			found = 0;
 	}
 	return found;
 }
@@ -619,6 +620,7 @@
 	int idx = 0;
 	int ddc_type, dac_type, conn_type, tmds_type, port_id;
 	int connector_found = 0;
+	int shared;
 	
 	offset = BIOS_IN16(rinfo->atom_data_start + 22);
 	if (offset == 0)
@@ -635,6 +637,7 @@
 
 	valids = BIOS_IN16(offset + 4);
 	for (i = 0; i < 8; i++) {
+		shared = 0;
 		if (!(valids & (1 << i)))
 			continue;
 		portinfo = BIOS_IN16(offset + 6 + i*2);
@@ -679,15 +682,22 @@
 		for (j = 0; j < RADEON_MAX_CONNECTORS; j++) {
 			if (port_id != ids[j])
 				continue;
-			/* Gotcha, just "update" values */
+
+			/* This port is shared. Update the values (if needed)
+			 * and probe next connector without creating a new
+			 * connector entry.
+			 */
 			if (tmds_type != tmds_unknown)
 				rinfo->connectors[j].tmds_type = tmds_type;
 			if (rinfo->connectors[j].dac_type == dac_unknown)
 				rinfo->connectors[j].dac_type = dac_type;
-			if (rinfo->connectors[j].ddc_type == dac_unknown)
-				rinfo->connectors[j].ddc_type = dac_type;
-			continue;
+			if (rinfo->connectors[j].ddc_type == ddc_none)
+				rinfo->connectors[j].ddc_type = ddc_type;
+
+			shared = 1;
 		}
+		if (shared)
+			continue;
 
 		conn_index = (ddc_type == ddc_dvi || conn_index == 1) ? 0 : 1;
 
@@ -696,7 +706,7 @@
 		 */
 		if (conn_type == conn_ctv || conn_type == conn_stv ||
 		    (rinfo->connectors[0].conn_type != conn_none &&
-		     rinfo->connectors[1].conn_type))
+		     rinfo->connectors[1].conn_type != conn_none))
 			idx = conn_add++;
 		else
 			idx = conn_index;
@@ -705,6 +715,7 @@
 		rinfo->connectors[idx].dac_type = dac_type;
 		rinfo->connectors[idx].ddc_type = ddc_type;
 		rinfo->connectors[idx].conn_type = conn_type;
+		ids[idx] = port_id;
 
 		/* increment connector_found for primary connectors only */
 		if (idx < 2)
@@ -839,10 +850,10 @@
 	    if ((connector_found < 3) &&
 		(rinfo->connectors[idx].conn_type == conn_vga)) {
 		    if (connector_found == 1) {
-			    memcpy(&rinfo->connectors[1],
-				   &rinfo->connectors[0],
+				memcpy(&rinfo->connectors[1], &rinfo->connectors[0],
 				   sizeof(struct radeon_connector));
 		    }
+
 		    /* Fixme: TV DAC is probably elsewhere ... */
 		    rinfo->connectors[0].dac_type = dac_tvdac;
 		    rinfo->connectors[0].tmds_type = tmds_unknown;
@@ -985,7 +996,8 @@
 {
 	int i;
 	
-	if (mon_type <= MT_NONE) return 0;
+	if (mon_type <= MT_NONE)
+		return 0;
 	
 	for (i = 0; i < RADEON_MAX_CONNECTORS ; i++) {
 		if (radeon_conn_monitor_compatible(mon_type, rinfo->connectors[i].conn_type) && 
@@ -1100,12 +1112,11 @@
 			if (SECONDARY_HEAD_PRESENT(rinfo)) {
 				mon_type = SECONDARY_MONITOR(rinfo);
 				if (SECONDARY_MONITOR(rinfo) > MT_NONE) {
-					if (radeon_probe_i2c_connector(rinfo, &SECONDARY_HEAD(rinfo))) {
+					if (radeon_probe_i2c_connector(rinfo, &SECONDARY_HEAD(rinfo)))
 						rinfo->connectors[rinfo->heads[1]].mon_type = mon_type;
 					}
 				}
 			}
-		}
 #endif /* CONFIG_FB_RADEON_I2C */
 		
 		/* If the user specified a bogus monitor layout... */
@@ -1127,7 +1138,9 @@
 #ifdef CONFIG_FB_RADEON_I2C
 			/* Probe each connector */
 			for(i = 0 ; i < RADEON_MAX_CONNECTORS ; i++) {
-				if (PRIMARY_MONITOR(rinfo) > MT_NONE) break;  /* only one head */
+				if (PRIMARY_MONITOR(rinfo) > MT_NONE)
+					/* only one head */
+					break;
 				if (!radeon_probe_i2c_connector(rinfo, &rinfo->connectors[i])) {
 					rinfo->heads[rinfo->num_heads] = i;
 					rinfo->connectors[i].head = rinfo->num_heads++;
@@ -1144,7 +1157,9 @@
 #ifdef CONFIG_FB_RADEON_I2C
 		/* Probe each connector in turn. */
 		for(i = 0 ; i < RADEON_MAX_CONNECTORS ; i++) {
-			if (rinfo->connectors[i].mon_type > MT_NONE) continue; /* Don't probe "detected" stuff again */
+			if (rinfo->connectors[i].mon_type > MT_NONE)
+				/* Don't probe "detected" stuff again */
+				continue;
 			if (!radeon_probe_i2c_connector(rinfo, &rinfo->connectors[i])) {
 				rinfo->heads[rinfo->num_heads] = i;
 				rinfo->connectors[i].head = rinfo->num_heads++;
@@ -1166,17 +1181,17 @@
 		}
 
 		/* Probe for monitors on the primary and secondary crtc heads */
-		if (PRIMARY_MONITOR(rinfo) <= MT_NONE) {
+		if (PRIMARY_MONITOR(rinfo) <= MT_NONE)
 			radeon_find_connector_for_mon(rinfo, radeon_crt_is_connected(rinfo, 1));
-		}
 
 		/* If we still haven't found anything, just force it to be on the CRT.. */
-		if (PRIMARY_MONITOR(rinfo) <= MT_NONE) {
+		if (PRIMARY_MONITOR(rinfo) <= MT_NONE)
 			radeon_find_connector_for_mon(rinfo, MT_CRT);
-		}
 
 		/* Always keep internal TMDS as primary head */
-		if (SECONDARY_HEAD_PRESENT(rinfo) && (SECONDARY_HEAD(rinfo).tmds_type == tmds_internal) && (SECONDARY_MONITOR(rinfo) == MT_DFP)) {
+		if (SECONDARY_HEAD_PRESENT(rinfo) &&
+		    (SECONDARY_HEAD(rinfo).tmds_type == tmds_internal) &&
+		    (SECONDARY_MONITOR(rinfo) == MT_DFP)) {
 			int head = rinfo->heads[0];
 			rinfo->heads[0] = rinfo->heads[1];
 			rinfo->heads[1] = head;
@@ -1186,7 +1201,6 @@
 
 	/* Dump out the heads we've found so far */
 	for (i = 0; i < RADEON_MAX_CONNECTORS; i++) {
-		
 		if (rinfo->connectors[i].conn_type == conn_none)
 			continue;
 		printk(KERN_INFO " * Connector %d is %s. Head %d, Monitor: %s ", i+1,
@@ -1195,11 +1209,12 @@
 		       rinfo->connectors[i].mon_type == MT_UNKNOWN  ?
 		         "Not Probed Yet" : 
 		         mon_type_name[rinfo->connectors[i].mon_type]);
-		if (rinfo->connectors[i].edid) {
+
+		if (rinfo->connectors[i].edid)
 			printk("(EDID probed)\n");
-		} else {
+		else
 			printk("\n");
-		}
+
 		printk(KERN_INFO "   ddc port: %d, dac: %d, tmds: %d\n",
 		       rinfo->connectors[i].ddc_type,
 		       rinfo->connectors[i].dac_type,
@@ -1216,7 +1231,7 @@
 	 * LCD Flat panels should use fixed dividers, we enfore that on
 	 * PPC only for now...
 	 */
-	If (!rinfo->panel_info.use_bios_dividers && (PRIMARY_MONITOR(rinfo) == MT_LCD) &&
+	if (!rinfo->panel_info.use_bios_dividers && (PRIMARY_MONITOR(rinfo) == MT_LCD) &&
 	    rinfo->is_mobility) {
 		int ppll_div_sel;
 		u32 ppll_divn;
@@ -1235,7 +1250,7 @@
 		       ppll_div_sel);
 		return 0;
 	}
-	return 1;
+	return -ENODEV;
 }
 #endif /* CONFIG_PPC_OF */
 
@@ -1316,10 +1331,9 @@
 	if ((PRIMARY_MONITOR(rinfo) <= MT_NONE) &&
 	    rinfo->is_mobility && 
 	    rinfo->radeon_get_lvds_info) {
-		if (! rinfo->radeon_get_lvds_info(rinfo)) {
+		if (!rinfo->radeon_get_lvds_info(rinfo))
 			radeon_find_connector_for_mon(rinfo, MT_LCD);
 		}
-	}
 #endif
 
 	/*
@@ -1383,7 +1397,6 @@
 		PRIMARY_HEAD(rinfo).modedb_size = info->monspecs.modedb_len;
 	}
 
-	
 	/*
 	 * Finally, if we don't have panel infos we need to figure some (or
 	 * we try to read it from card), we try to pick a default mode


Luca
-- 
"L'ottimista pensa che questo sia il migliore dei mondi possibili. 
 Il pessimista sa che e` vero" -- J. Robert Oppenheimer
