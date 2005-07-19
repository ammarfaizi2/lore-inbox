Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261621AbVGSR75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbVGSR75 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 13:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbVGSR75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 13:59:57 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:48344 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261621AbVGSR74
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 13:59:56 -0400
Subject: [PATCH] jsm driver - Linux-2.6.12.3
From: "V. ANANDA KRISHNAN" <mansarov@us.ibm.com>
To: linux-kernel@vger.kernel.org, "gregkh@suse.de" <rmk+lkml@arm.linux.org.uk>
Cc: gregkh@suse.de, rmk+lkml@arm.linux.org.uk
Content-Type: multipart/mixed; boundary="=-Ue0Nb9VQWLRGwt0i76Mx"
Date: Tue, 19 Jul 2005 12:53:20 -0500
Message-Id: <1121795600.3756.25.camel@siliver.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-16) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Ue0Nb9VQWLRGwt0i76Mx
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi All,

 Here is a patch to the jsm driver in the Linux (drivers/serial/jsm).
This patch takes care of (1) compiler warnings which displays the mixing
of declarations and code (2) dynamic allocation of major device number
instead of the static number 253 (3) the version update to reflect the
changes in the patch.

 Please CC me your comments.  Thanks.
Signed-off-by: V. Ananda Krishnan <mansarov-at-us-dot-ibm-dot-com>






--=-Ue0Nb9VQWLRGwt0i76Mx
Content-Disposition: attachment; filename=patch_jsm_korg-2.6.12.3
Content-Type: text/x-patch; name=patch_jsm_korg-2.6.12.3; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Nuar linux-2.6.12.3.orig/drivers/serial/jsm/jsm_driver.c linux-2.6.12.3.new/drivers/serial/jsm/jsm_driver.c
--- linux-2.6.12.3.orig/drivers/serial/jsm/jsm_driver.c	2005-07-19 15:16:20.000000000 -0500
+++ linux-2.6.12.3.new/drivers/serial/jsm/jsm_driver.c	2005-07-19 15:18:57.000000000 -0500
@@ -22,6 +22,10 @@
  * Scott H Kilau <Scott_Kilau@digi.com>
  * Wendy Xiong   <wendyx@us.ltcfwd.linux.ibm.com>
  *
+ * CHANGE LOG:
+ * Jul 18, 2005: Changed the major number changed to 0 to use the dynamic
+ *	allocation of major number by OS.
+ *
  ***********************************************************************/
 #include <linux/moduleparam.h>
 #include <linux/pci.h>
@@ -42,7 +46,7 @@
 	.owner		= THIS_MODULE,
 	.driver_name	= JSM_DRIVER_NAME,
 	.dev_name	= "ttyn",
-	.major		= 253,
+	.major		= 0,
 	.minor		= JSM_MINOR_START,
 	.nr		= NR_PORTS,
 };
diff -Nuar linux-2.6.12.3.orig/drivers/serial/jsm/jsm.h linux-2.6.12.3.new/drivers/serial/jsm/jsm.h
--- linux-2.6.12.3.orig/drivers/serial/jsm/jsm.h	2005-07-19 15:16:21.000000000 -0500
+++ linux-2.6.12.3.new/drivers/serial/jsm/jsm.h	2005-07-19 15:18:58.000000000 -0500
@@ -22,6 +22,9 @@
  * Scott H Kilau <Scott_Kilau@digi.com>
  * Wendy Xiong   <wendyx@us.ltcfwd.linux.ibm.com>
  *
+ * CHANGE LOG:
+ * Jul 18, 2005: Changed the JSM_VERSION to "jsm: 1.2-1-INKERNEL"
+ *
  ***********************************************************************/
 
 #ifndef __JSM_DRIVER_H
@@ -90,7 +93,7 @@
 #define WRITEBUFLEN	((4096) + 4)
 #define MYFLIPLEN	N_TTY_BUF_SIZE
 
-#define JSM_VERSION	"jsm: 1.1-1-INKERNEL"
+#define JSM_VERSION	"jsm: 1.2-1-INKERNEL"
 #define JSM_PARTNUM	"40002438_A-INKERNEL"
 
 struct jsm_board;
diff -Nuar linux-2.6.12.3.orig/drivers/serial/jsm/jsm_neo.c linux-2.6.12.3.new/drivers/serial/jsm/jsm_neo.c
--- linux-2.6.12.3.orig/drivers/serial/jsm/jsm_neo.c	2005-07-19 15:16:22.000000000 -0500
+++ linux-2.6.12.3.new/drivers/serial/jsm/jsm_neo.c	2005-07-19 15:19:00.000000000 -0500
@@ -22,6 +22,9 @@
  * Scott H Kilau <Scott_Kilau@digi.com>
  * Wendy Xiong   <wendyx@us.ltcfwd.linux.ibm.com>
  *
+ * CHANGE LOG:
+ * Jul 18, 2005: separated the mixed declarations and code.
+ *
  ***********************************************************************/
 #include <linux/delay.h>	/* For udelay */
 #include <linux/serial_reg.h>	/* For the various UART offsets */
@@ -48,8 +51,9 @@
 
 static void neo_set_cts_flow_control(struct jsm_channel *ch)
 {
-	u8 ier = readb(&ch->ch_neo_uart->ier);
-	u8 efr = readb(&ch->ch_neo_uart->efr);
+	u8 ier, efr;
+	ier = readb(&ch->ch_neo_uart->ier);
+	efr = readb(&ch->ch_neo_uart->efr);
 
 	jsm_printk(PARAM, INFO, &ch->ch_bd->pci_dev, "Setting CTSFLOW\n");
 
@@ -78,8 +82,9 @@
 
 static void neo_set_rts_flow_control(struct jsm_channel *ch)
 {
-	u8 ier = readb(&ch->ch_neo_uart->ier);
-	u8 efr = readb(&ch->ch_neo_uart->efr);
+	u8 ier, efr;
+	ier = readb(&ch->ch_neo_uart->ier);
+	efr = readb(&ch->ch_neo_uart->efr);
 
 	jsm_printk(PARAM, INFO, &ch->ch_bd->pci_dev, "Setting RTSFLOW\n");
 
@@ -117,8 +122,9 @@
 
 static void neo_set_ixon_flow_control(struct jsm_channel *ch)
 {
-	u8 ier = readb(&ch->ch_neo_uart->ier);
-	u8 efr = readb(&ch->ch_neo_uart->efr);
+	u8 ier, efr;
+	ier = readb(&ch->ch_neo_uart->ier);
+	efr = readb(&ch->ch_neo_uart->efr);
 
 	jsm_printk(PARAM, INFO, &ch->ch_bd->pci_dev, "Setting IXON FLOW\n");
 
@@ -153,8 +159,9 @@
 
 static void neo_set_ixoff_flow_control(struct jsm_channel *ch)
 {
-	u8 ier = readb(&ch->ch_neo_uart->ier);
-	u8 efr = readb(&ch->ch_neo_uart->efr);
+	u8 ier, efr;
+	ier = readb(&ch->ch_neo_uart->ier);
+	efr = readb(&ch->ch_neo_uart->efr);
 
 	jsm_printk(PARAM, INFO, &ch->ch_bd->pci_dev, "Setting IXOFF FLOW\n");
 
@@ -190,8 +197,9 @@
 
 static void neo_set_no_input_flow_control(struct jsm_channel *ch)
 {
-	u8 ier = readb(&ch->ch_neo_uart->ier);
-	u8 efr = readb(&ch->ch_neo_uart->efr);
+	u8 ier, efr;
+	ier = readb(&ch->ch_neo_uart->ier);
+	efr = readb(&ch->ch_neo_uart->efr);
 
 	jsm_printk(PARAM, INFO, &ch->ch_bd->pci_dev, "Unsetting Input FLOW\n");
 
@@ -228,8 +236,9 @@
 
 static void neo_set_no_output_flow_control(struct jsm_channel *ch)
 {
-	u8 ier = readb(&ch->ch_neo_uart->ier);
-	u8 efr = readb(&ch->ch_neo_uart->efr);
+	u8 ier, efr;
+	ier = readb(&ch->ch_neo_uart->ier);
+	efr = readb(&ch->ch_neo_uart->efr);
 
 	jsm_printk(PARAM, INFO, &ch->ch_bd->pci_dev, "Unsetting Output FLOW\n");
 

--=-Ue0Nb9VQWLRGwt0i76Mx--

