Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276755AbRJHBxL>; Sun, 7 Oct 2001 21:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276753AbRJHBxB>; Sun, 7 Oct 2001 21:53:01 -0400
Received: from sushi.toad.net ([162.33.130.105]:60370 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S276751AbRJHBwo>;
	Sun, 7 Oct 2001 21:52:44 -0400
Subject: [PATCH] 2.4.10-ac8 PnP BIOS fix #2
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14 (Preview Release)
Date: 07 Oct 2001 21:52:43 -0400
Message-Id: <1002505965.829.92.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a second patch to 2.4.10-ac8 PnP BIOS driver.
It adds error reporting to the dev_node_info, get_dev_node,
and set_dev_node functions. It applies on top of patch #1.

// Thomas
--- linux-2.4.10-ac8-fix/drivers/pnp/pnp_bios.c	Sun Oct  7 15:37:29 2001
+++ linux-2.4.10-ac7-fix/drivers/pnp/pnp_bios.c	Sun Oct  7 12:44:02 2001
@@ -236,7 +236,7 @@
 /*
  * Call PnP BIOS with function 0x00, "get number of system device nodes"
  */
-int pnp_bios_dev_node_info(struct pnp_dev_node_info *data)
+static int pnp_bios_dev_node_info_silently(struct pnp_dev_node_info *data)
 {
 	u16 status;
 	if (!pnp_bios_present ())
@@ -247,6 +247,14 @@
 	return status;
 }
 
+int pnp_bios_dev_node_info(struct pnp_dev_node_info *data)
+{
+	u16 status = pnp_bios_dev_node_info_silently( data );
+	if ( status )
+		printk(KERN_WARNING "PnPBIOS: PnP BIOS dev_node_info function returned error status 0x%x\n", status);
+	return status;
+}
+
 /*
  * Note that some PnP BIOSes (on Sony Vaio laptops) die a horrible
  * death if they are asked to access the "current" configuration
@@ -261,7 +269,7 @@
  *               or volatile current (0) config
  * Output: *nodenum=next node or 0xff if no more nodes
  */
-int pnp_bios_get_dev_node(u8 *nodenum, char boot, struct pnp_bios_node *data)
+static int pnp_bios_get_dev_node_silently(u8 *nodenum, char boot, struct pnp_bios_node *data)
 {
 	u16 status;
 	if (!pnp_bios_present ())
@@ -272,19 +280,35 @@
 	return status;
 }
 
+int pnp_bios_get_dev_node(u8 *nodenum, char boot, struct pnp_bios_node *data)
+{
+	u16 status =  pnp_bios_get_dev_node_silently( nodenum, boot, data );
+	if ( status )
+		printk(KERN_WARNING "PnPBIOS: PnP BIOS get_dev_node function returned error status 0x%x\n", status);
+	return status;
+}
+
 /*
  * Call PnP BIOS with function 0x02, "set system device node"
  * Input: *nodenum = desired node, 
  *        boot = whether to set nonvolatile boot (!=0)
  *               or volatile current (0) config
  */
-int pnp_bios_set_dev_node(u8 nodenum, char boot, struct pnp_bios_node *data)
+static int pnp_bios_set_dev_node_silently(u8 nodenum, char boot, struct pnp_bios_node *data)
 {
 	u16 status;
 	if (!pnp_bios_present ())
 		return PNP_FUNCTION_NOT_SUPPORTED;
 	Q2_SET_SEL(PNP_TS1, data, /* *((u16 *) data)*/ 65536);
 	status = call_pnp_bios(PNP_SET_SYS_DEV_NODE, nodenum, 0, PNP_TS1, boot ? 2 : 1, PNP_DS, 0, 0);
+	return status;
+}
+
+int pnp_bios_set_dev_node(u8 nodenum, char boot, struct pnp_bios_node *data)
+{
+	u16 status =  pnp_bios_set_dev_node_silently( nodenum, boot, data );
+	if ( status )
+		printk(KERN_WARNING "PnPBIOS: PnP BIOS set_dev_node function returned error status 0x%x\n", status);
 	return status;
 }
 

