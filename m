Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbTETWtd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 18:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbTETWtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 18:49:32 -0400
Received: from smtp8.wanadoo.fr ([193.252.22.30]:64322 "EHLO
	mwinf0102.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261454AbTETWtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 18:49:01 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: linux-usb-devel@lists.sourceforge.net
Subject: [PATCH 09/14] USB speedtouch: use optimally sized reconstruction buffers
Date: Wed, 21 May 2003 01:01:55 +0200
User-Agent: KMail/1.5.1
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200305210101.55319.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Calculate the maximum size needed for the SAR
reconstruction buffer from the supplied qos parameters.

 speedtch.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)


diff -Nru a/drivers/usb/misc/speedtch.c b/drivers/usb/misc/speedtch.c
--- a/drivers/usb/misc/speedtch.c	Wed May 21 00:40:46 2003
+++ b/drivers/usb/misc/speedtch.c	Wed May 21 00:40:46 2003
@@ -107,9 +107,6 @@
 #define UDSL_NUM_SND_BUFS		(2*UDSL_NUM_SND_URBS)
 #define UDSL_RCV_BUF_SIZE		64 /* ATM cells */
 #define UDSL_SND_BUF_SIZE		64 /* ATM cells */
-/* max should be (1500 IP mtu + 2 ppp bytes + 32 * 5 cellheader overhead) for
- * PPPoA and (1500 + 14 + 32*5 cellheader overhead) for PPPoE */
-#define UDSL_MAX_AAL5_MRU		2048
 
 #define UDSL_IOCTL_LINE_UP		1
 #define UDSL_IOCTL_LINE_DOWN		2
@@ -118,6 +115,7 @@
 #define UDSL_ENDPOINT_DATA_IN		0x87
 
 #define ATM_CELL_HEADER			(ATM_CELL_SIZE - ATM_CELL_PAYLOAD)
+#define UDSL_NUM_CELLS(x)		(((x) + ATM_AAL5_TRAILER + ATM_CELL_PAYLOAD - 1) / ATM_CELL_PAYLOAD)
 
 #define hex2int(c) ( (c >= '0') && (c <= '9') ? (c - '0') : ((c & 0xf) + 9) )
 
@@ -146,7 +144,7 @@
 
 	/* raw cell reassembly */
 	struct sk_buff *skb;
-	unsigned short max_pdu;
+	unsigned int max_pdu;
 };
 
 /* send */
@@ -416,7 +414,7 @@
 	ctrl->cell_header [3] = vcc->vci << 4;
 	ctrl->cell_header [4] = 0xec;
 
-	ctrl->num_cells = (skb->len + ATM_AAL5_TRAILER + ATM_CELL_PAYLOAD - 1) / ATM_CELL_PAYLOAD;
+	ctrl->num_cells = UDSL_NUM_CELLS (skb->len);
 	ctrl->num_entire = skb->len / ATM_CELL_PAYLOAD;
 
 	zero_padding = ctrl->num_cells * ATM_CELL_PAYLOAD - skb->len - ATM_AAL5_TRAILER;
@@ -921,7 +919,7 @@
 		return -EINVAL;
 
 	/* only support AAL5 */
-	if (vcc->qos.aal != ATM_AAL5)
+	if (vcc->qos.aal != ATM_AAL5 || vcc->qos.rxtp.max_sdu < 0 || vcc->qos.rxtp.max_sdu > ATM_MAX_AAL5_PDU)
 		return -EINVAL;
 
 	if (!instance->firmware_loaded) {
@@ -945,7 +943,7 @@
 	new->vcc = vcc;
 	new->vpi = vpi;
 	new->vci = vci;
-	new->max_pdu = UDSL_MAX_AAL5_MRU;
+	new->max_pdu = max (1, UDSL_NUM_CELLS (vcc->qos.rxtp.max_sdu)) * ATM_CELL_PAYLOAD;
 
 	vcc->dev_data = new;
 	vcc->vpi = vpi;

