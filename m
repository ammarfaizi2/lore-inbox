Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269611AbUJTHGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269611AbUJTHGn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 03:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270081AbUJSXKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:10:04 -0400
Received: from mail.kroah.org ([69.55.234.183]:5770 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270108AbUJSWq0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:26 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <1098225736788@kroah.com>
Date: Tue, 19 Oct 2004 15:42:16 -0700
Message-Id: <10982257363619@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.33, 2004/10/06 12:55:13-07:00, greg@kroah.com

[PATCH] PCI Hotplug: fix __iomem warnings in the ibm pci hotplug driver

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/ibmphp_ebda.c |    2 +-
 drivers/pci/hotplug/ibmphp_hpc.c  |   28 ++++++++++++++--------------
 2 files changed, 15 insertions(+), 15 deletions(-)


diff -Nru a/drivers/pci/hotplug/ibmphp_ebda.c b/drivers/pci/hotplug/ibmphp_ebda.c
--- a/drivers/pci/hotplug/ibmphp_ebda.c	2004-10-19 15:24:47 -07:00
+++ b/drivers/pci/hotplug/ibmphp_ebda.c	2004-10-19 15:24:47 -07:00
@@ -63,7 +63,7 @@
 static LIST_HEAD (rio_lo_head);
 static LIST_HEAD (opt_vg_head);
 static LIST_HEAD (opt_lo_head);
-static void *io_mem;
+static void __iomem *io_mem;
 
 /* Local functions */
 static int ebda_rsrc_controller (void);
diff -Nru a/drivers/pci/hotplug/ibmphp_hpc.c b/drivers/pci/hotplug/ibmphp_hpc.c
--- a/drivers/pci/hotplug/ibmphp_hpc.c	2004-10-19 15:24:47 -07:00
+++ b/drivers/pci/hotplug/ibmphp_hpc.c	2004-10-19 15:24:47 -07:00
@@ -108,8 +108,8 @@
 //----------------------------------------------------------------------------
 // local function prototypes
 //----------------------------------------------------------------------------
-static u8 i2c_ctrl_read (struct controller *, void *, u8);
-static u8 i2c_ctrl_write (struct controller *, void *, u8, u8);
+static u8 i2c_ctrl_read (struct controller *, void __iomem *, u8);
+static u8 i2c_ctrl_write (struct controller *, void __iomem *, u8, u8);
 static u8 hpc_writecmdtoindex (u8, u8);
 static u8 hpc_readcmdtoindex (u8, u8);
 static void get_hpc_access (void);
@@ -118,7 +118,7 @@
 static int process_changeinstatus (struct slot *, struct slot *);
 static int process_changeinlatch (u8, u8, struct controller *);
 static int hpc_poll_thread (void *);
-static int hpc_wait_ctlr_notworking (int, struct controller *, void *, u8 *);
+static int hpc_wait_ctlr_notworking (int, struct controller *, void __iomem *, u8 *);
 //----------------------------------------------------------------------------
 
 
@@ -147,11 +147,11 @@
 * Action:  read from HPC over I2C
 *
 *---------------------------------------------------------------------*/
-static u8 i2c_ctrl_read (struct controller *ctlr_ptr, void *WPGBbar, u8 index)
+static u8 i2c_ctrl_read (struct controller *ctlr_ptr, void __iomem *WPGBbar, u8 index)
 {
 	u8 status;
 	int i;
-	void *wpg_addr;		// base addr + offset
+	void __iomem *wpg_addr;	// base addr + offset
 	unsigned long wpg_data;	// data to/from WPG LOHI format
 	unsigned long ultemp;
 	unsigned long data;	// actual data HILO format
@@ -255,10 +255,10 @@
 *
 * Return   0 or error codes
 *---------------------------------------------------------------------*/
-static u8 i2c_ctrl_write (struct controller *ctlr_ptr, void *WPGBbar, u8 index, u8 cmd)
+static u8 i2c_ctrl_write (struct controller *ctlr_ptr, void __iomem *WPGBbar, u8 index, u8 cmd)
 {
 	u8 rc;
-	void *wpg_addr;		// base addr + offset
+	void __iomem *wpg_addr;	// base addr + offset
 	unsigned long wpg_data;	// data to/from WPG LOHI format 
 	unsigned long ultemp;
 	unsigned long data;	// actual data HILO format
@@ -399,7 +399,7 @@
 	return rc;
 }
 
-static u8 ctrl_read (struct controller *ctlr, void *base, u8 offset)
+static u8 ctrl_read (struct controller *ctlr, void __iomem *base, u8 offset)
 {
 	u8 rc;
 	switch (ctlr->ctlr_type) {
@@ -419,7 +419,7 @@
 	return rc;
 }
 
-static u8 ctrl_write (struct controller *ctlr, void *base, u8 offset, u8 data)
+static u8 ctrl_write (struct controller *ctlr, void __iomem *base, u8 offset, u8 data)
 {
 	u8 rc = 0;
 	switch (ctlr->ctlr_type) {
@@ -536,7 +536,7 @@
 *---------------------------------------------------------------------*/
 int ibmphp_hpc_readslot (struct slot * pslot, u8 cmd, u8 * pstatus)
 {
-	void *wpg_bbar = NULL;
+	void __iomem *wpg_bbar = NULL;
 	struct controller *ctlr_ptr;
 	struct list_head *pslotlist;
 	u8 index, status;
@@ -660,7 +660,7 @@
 	
 	// remove physical to logical address mapping
 	if ((ctlr_ptr->ctlr_type == 2) || (ctlr_ptr->ctlr_type == 4))
-		iounmap (wpg_bbar);	
+		iounmap (wpg_bbar);
 	
 	free_hpc_access ();
 
@@ -675,7 +675,7 @@
 *---------------------------------------------------------------------*/
 int ibmphp_hpc_writeslot (struct slot * pslot, u8 cmd)
 {
-	void *wpg_bbar = NULL;
+	void __iomem *wpg_bbar = NULL;
 	struct controller *ctlr_ptr;
 	u8 index, status;
 	int busindex;
@@ -764,7 +764,7 @@
 
 	// remove physical to logical address mapping
 	if ((ctlr_ptr->ctlr_type == 2) || (ctlr_ptr->ctlr_type == 4))
-		iounmap (wpg_bbar);	
+		iounmap (wpg_bbar);
 	free_hpc_access ();
 
 	debug_polling ("%s - Exit rc[%d]\n", __FUNCTION__, rc);
@@ -1130,7 +1130,7 @@
 * Return   0, HPC_ERROR
 * Value:
 *---------------------------------------------------------------------*/
-static int hpc_wait_ctlr_notworking (int timeout, struct controller *ctlr_ptr, void *wpg_bbar,
+static int hpc_wait_ctlr_notworking (int timeout, struct controller *ctlr_ptr, void __iomem *wpg_bbar,
 				    u8 * pstatus)
 {
 	int rc = 0;

