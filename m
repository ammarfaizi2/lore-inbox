Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265219AbTFZAfX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 20:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265258AbTFZAfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 20:35:22 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:27627 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S265219AbTFZAfA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 20:35:00 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10565884951291@kroah.com>
Subject: Re: [PATCH] More PCI fixes for 2.5.73
In-Reply-To: <10565884952122@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 25 Jun 2003 17:48:15 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1429.2.7, 2003/06/25 17:16:12-07:00, greg@kroah.com

[PATCH] IBM PCI Hotplug: fixes found by sparse


 drivers/pci/hotplug/ibmphp_hpc.c |   61 +++++++++++++++++++--------------------
 drivers/pci/hotplug/ibmphp_res.c |    4 +-
 2 files changed, 32 insertions(+), 33 deletions(-)


diff -Nru a/drivers/pci/hotplug/ibmphp_hpc.c b/drivers/pci/hotplug/ibmphp_hpc.c
--- a/drivers/pci/hotplug/ibmphp_hpc.c	Wed Jun 25 17:37:49 2003
+++ b/drivers/pci/hotplug/ibmphp_hpc.c	Wed Jun 25 17:37:49 2003
@@ -152,11 +152,11 @@
 	u8 status;
 	int i;
 	void *wpg_addr;		// base addr + offset
-	ulong wpg_data,		// data to/from WPG LOHI format
-	ultemp, data;		// actual data HILO format
+	unsigned long wpg_data;	// data to/from WPG LOHI format
+	unsigned long ultemp;
+	unsigned long data;	// actual data HILO format
 
-
-	debug_polling ("%s - Entry WPGBbar[%lx] index[%x] \n", __FUNCTION__, (ulong) WPGBbar, index);
+	debug_polling ("%s - Entry WPGBbar[%p] index[%x] \n", __FUNCTION__, WPGBbar, index);
 
 	//--------------------------------------------------------------------
 	// READ - step 1
@@ -165,17 +165,17 @@
 	if (ctlr_ptr->ctlr_type == 0x02) {
 		data = WPG_READATADDR_MASK;
 		// fill in I2C address
-		ultemp = (ulong) ctlr_ptr->u.wpeg_ctlr.i2c_addr;
+		ultemp = (unsigned long)ctlr_ptr->u.wpeg_ctlr.i2c_addr;
 		ultemp = ultemp >> 1;
 		data |= (ultemp << 8);
 
 		// fill in index
-		data |= (ulong) index;
+		data |= (unsigned long)index;
 	} else if (ctlr_ptr->ctlr_type == 0x04) {
 		data = WPG_READDIRECT_MASK;
 
 		// fill in index
-		ultemp = (ulong) index;
+		ultemp = (unsigned long)index;
 		ultemp = ultemp << 8;
 		data |= ultemp;
 	} else {
@@ -184,14 +184,14 @@
 	}
 
 	wpg_data = swab32 (data);	// swap data before writing
-	(ulong) wpg_addr = (ulong) WPGBbar + (ulong) WPG_I2CMOSUP_OFFSET;
+	wpg_addr = WPGBbar + WPG_I2CMOSUP_OFFSET;
 	writel (wpg_data, wpg_addr);
 
 	//--------------------------------------------------------------------
 	// READ - step 2 : clear the message buffer
 	data = 0x00000000;
 	wpg_data = swab32 (data);
-	(ulong) wpg_addr = (ulong) WPGBbar + (ulong) WPG_I2CMBUFL_OFFSET;
+	wpg_addr = WPGBbar + WPG_I2CMBUFL_OFFSET;
 	writel (wpg_data, wpg_addr);
 
 	//--------------------------------------------------------------------
@@ -199,7 +199,7 @@
 	//                 2020 : [20] OR operation at [20] offset 0x20
 	data = WPG_I2CMCNTL_STARTOP_MASK;
 	wpg_data = swab32 (data);
-	(ulong) wpg_addr = (ulong) WPGBbar + (ulong) WPG_I2CMCNTL_OFFSET + (ulong) WPG_I2C_OR;
+	wpg_addr = WPGBbar + WPG_I2CMCNTL_OFFSET + WPG_I2C_OR;
 	writel (wpg_data, wpg_addr);
 
 	//--------------------------------------------------------------------
@@ -207,7 +207,7 @@
 	i = CMD_COMPLETE_TOUT_SEC;
 	while (i) {
 		long_delay (1 * HZ / 100);
-		(ulong) wpg_addr = (ulong) WPGBbar + (ulong) WPG_I2CMCNTL_OFFSET;
+		wpg_addr = WPGBbar + WPG_I2CMCNTL_OFFSET;
 		wpg_data = readl (wpg_addr);
 		data = swab32 (wpg_data);
 		if (!(data & WPG_I2CMCNTL_STARTOP_MASK))
@@ -223,7 +223,7 @@
 	i = CMD_COMPLETE_TOUT_SEC;
 	while (i) {
 		long_delay (1 * HZ / 100);
-		(ulong) wpg_addr = (ulong) WPGBbar + (ulong) WPG_I2CSTAT_OFFSET;
+		wpg_addr = WPGBbar + WPG_I2CSTAT_OFFSET;
 		wpg_data = readl (wpg_addr);
 		data = swab32 (wpg_data);
 		if (HPC_I2CSTATUS_CHECK (data))
@@ -237,7 +237,7 @@
 
 	//--------------------------------------------------------------------
 	// READ - step 6 : get DATA
-	(ulong) wpg_addr = (ulong) WPGBbar + (ulong) WPG_I2CMBUFL_OFFSET;
+	wpg_addr = WPGBbar + WPG_I2CMBUFL_OFFSET;
 	wpg_data = readl (wpg_addr);
 	data = swab32 (wpg_data);
 
@@ -259,12 +259,12 @@
 {
 	u8 rc;
 	void *wpg_addr;		// base addr + offset
-	ulong wpg_data,		// data to/from WPG LOHI format 
-	ultemp, data;		// actual data HILO format
+	unsigned long wpg_data;	// data to/from WPG LOHI format 
+	unsigned long ultemp;
+	unsigned long data;	// actual data HILO format
 	int i;
 
-
-	debug_polling ("%s - Entry WPGBbar[%lx] index[%x] cmd[%x]\n", __FUNCTION__, (ulong) WPGBbar, index, cmd);
+	debug_polling ("%s - Entry WPGBbar[%p] index[%x] cmd[%x]\n", __FUNCTION__, WPGBbar, index, cmd);
 
 	rc = 0;
 	//--------------------------------------------------------------------
@@ -276,17 +276,17 @@
 	if (ctlr_ptr->ctlr_type == 0x02) {
 		data = WPG_WRITEATADDR_MASK;
 		// fill in I2C address
-		ultemp = (ulong) ctlr_ptr->u.wpeg_ctlr.i2c_addr;
+		ultemp = (unsigned long)ctlr_ptr->u.wpeg_ctlr.i2c_addr;
 		ultemp = ultemp >> 1;
 		data |= (ultemp << 8);
 
 		// fill in index
-		data |= (ulong) index;
+		data |= (unsigned long)index;
 	} else if (ctlr_ptr->ctlr_type == 0x04) {
 		data = WPG_WRITEDIRECT_MASK;
 
 		// fill in index
-		ultemp = (ulong) index;
+		ultemp = (unsigned long)index;
 		ultemp = ultemp << 8;
 		data |= ultemp;
 	} else {
@@ -295,14 +295,14 @@
 	}
 
 	wpg_data = swab32 (data);	// swap data before writing
-	(ulong) wpg_addr = (ulong) WPGBbar + (ulong) WPG_I2CMOSUP_OFFSET;
+	wpg_addr = WPGBbar + WPG_I2CMOSUP_OFFSET;
 	writel (wpg_data, wpg_addr);
 
 	//--------------------------------------------------------------------
 	// WRITE - step 2 : clear the message buffer
-	data = 0x00000000 | (ulong) cmd;
+	data = 0x00000000 | (unsigned long)cmd;
 	wpg_data = swab32 (data);
-	(ulong) wpg_addr = (ulong) WPGBbar + (ulong) WPG_I2CMBUFL_OFFSET;
+	wpg_addr = WPGBbar + WPG_I2CMBUFL_OFFSET;
 	writel (wpg_data, wpg_addr);
 
 	//--------------------------------------------------------------------
@@ -310,7 +310,7 @@
 	//                 2020 : [20] OR operation at [20] offset 0x20
 	data = WPG_I2CMCNTL_STARTOP_MASK;
 	wpg_data = swab32 (data);
-	(ulong) wpg_addr = (ulong) WPGBbar + (ulong) WPG_I2CMCNTL_OFFSET + (ulong) WPG_I2C_OR;
+	wpg_addr = WPGBbar + WPG_I2CMCNTL_OFFSET + WPG_I2C_OR;
 	writel (wpg_data, wpg_addr);
 
 	//--------------------------------------------------------------------
@@ -318,7 +318,7 @@
 	i = CMD_COMPLETE_TOUT_SEC;
 	while (i) {
 		long_delay (1 * HZ / 100);
-		(ulong) wpg_addr = (ulong) WPGBbar + (ulong) WPG_I2CMCNTL_OFFSET;
+		wpg_addr = WPGBbar + WPG_I2CMCNTL_OFFSET;
 		wpg_data = readl (wpg_addr);
 		data = swab32 (wpg_data);
 		if (!(data & WPG_I2CMCNTL_STARTOP_MASK))
@@ -335,7 +335,7 @@
 	i = CMD_COMPLETE_TOUT_SEC;
 	while (i) {
 		long_delay (1 * HZ / 100);
-		(ulong) wpg_addr = (ulong) WPGBbar + (ulong) WPG_I2CSTAT_OFFSET;
+		wpg_addr = WPGBbar + WPG_I2CSTAT_OFFSET;
 		wpg_data = readl (wpg_addr);
 		data = swab32 (wpg_data);
 		if (HPC_I2CSTATUS_CHECK (data))
@@ -543,7 +543,7 @@
 	int rc = 0;
 	int busindex;
 
-	debug_polling ("%s - Entry pslot[%lx] cmd[%x] pstatus[%lx]\n", __FUNCTION__, (ulong) pslot, cmd, (ulong) pstatus);
+	debug_polling ("%s - Entry pslot[%p] cmd[%x] pstatus[%p]\n", __FUNCTION__, pslot, cmd, pstatus);
 
 	if ((pslot == NULL)
 	    || ((pstatus == NULL) && (cmd != READ_ALLSTAT) && (cmd != READ_BUSSTATUS))) {
@@ -683,7 +683,7 @@
 	int rc = 0;
 	int timeout;
 
-	debug_polling ("%s - Entry pslot[%lx] cmd[%x]\n", __FUNCTION__, (ulong) pslot, cmd);
+	debug_polling ("%s - Entry pslot[%p] cmd[%x]\n", __FUNCTION__, pslot, cmd);
 	if (pslot == NULL) {
 		rc = -EINVAL;
 		err ("%s - Error Exit rc[%d]\n", __FUNCTION__, rc);
@@ -976,7 +976,7 @@
 {
 	int rc = 0;
 
-	debug ("%s - Entry pslot[%lx]\n", __FUNCTION__, (ulong) pslot);
+	debug ("%s - Entry pslot[%p]\n", __FUNCTION__, pslot);
 	rc = ibmphp_hpc_readslot (pslot, READ_ALLSTAT, NULL);
 	debug ("%s - Exit rc[%d]\n", __FUNCTION__, rc);
 	return rc;
@@ -1004,8 +1004,7 @@
 	u8 disable = FALSE;
 	u8 update = FALSE;
 
-	debug ("process_changeinstatus - Entry pslot[%lx], poldslot[%lx]\n", (ulong) pslot,
-	       (ulong) poldslot);
+	debug ("process_changeinstatus - Entry pslot[%p], poldslot[%p]\n", pslot, poldslot);
 
 	// bit 0 - HPC_SLOT_POWER
 	if ((pslot->status & 0x01) != (poldslot->status & 0x01))
diff -Nru a/drivers/pci/hotplug/ibmphp_res.c b/drivers/pci/hotplug/ibmphp_res.c
--- a/drivers/pci/hotplug/ibmphp_res.c	Wed Jun 25 17:37:49 2003
+++ b/drivers/pci/hotplug/ibmphp_res.c	Wed Jun 25 17:37:49 2003
@@ -42,7 +42,7 @@
 static int update_bridge_ranges (struct bus_node **);
 static int add_range (int type, struct range_node *, struct bus_node *);
 static void fix_resources (struct bus_node *);
-static inline struct bus_node *find_bus_wprev (u8, struct bus_node **, u8);
+static struct bus_node *find_bus_wprev (u8, struct bus_node **, u8);
 
 static LIST_HEAD(gbuses);
 LIST_HEAD(ibmphp_res_head);
@@ -1757,7 +1757,7 @@
 	return find_bus_wprev (bus_number, NULL, 0);
 }
 
-static inline struct bus_node *find_bus_wprev (u8 bus_number, struct bus_node **prev, u8 flag)
+static struct bus_node *find_bus_wprev (u8 bus_number, struct bus_node **prev, u8 flag)
 {
 	struct bus_node *bus_cur;
 	struct list_head *tmp;

