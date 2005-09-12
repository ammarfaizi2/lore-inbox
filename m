Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbVILHJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbVILHJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 03:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbVILHJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 03:09:29 -0400
Received: from [211.20.77.211] ([211.20.77.211]:41651 "EHLO mail.redin.com.tw")
	by vger.kernel.org with ESMTP id S1750942AbVILHJ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 03:09:28 -0400
Message-ID: <4325298D.1010600@tw.ibm.com>
Date: Mon, 12 Sep 2005 15:09:01 +0800
From: Hubert WS Lin <wslin@tw.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc3 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: netdev@vger.kernel.org
CC: linux-kernel@vger.kernel.org, fubar@us.ibm.com, donf@us.ibm.com,
       jklewis@us.ibm.com
Subject: [PATCH 2.6.13] pcnet32: set min ring size to 4
Content-Type: multipart/mixed;
 boundary="------------000308090300090008090301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000308090300090008090301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Don Fry reminded me that the pcnet32_loopback_test() asssumes the ring 
size is no less than 4. The minimum ring size was changed to 4 in 
pcnet32_set_ringparam() to allow the loopback test to work unchanged.

Changelog:
- Set minimum ring size to 4 to allow loopback test to work unchanged
- Moved variable init_block to first field in struct pcnet32_private

Signed-off-by: Hubert WS Lin <wslin@tw.ibm.com>

--------------000308090300090008090301
Content-Type: text/x-patch;
 name="pcnet32-min-ring-size.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcnet32-min-ring-size.diff"

--- a/drivers/net/pcnet32.c	2005-09-12 14:24:40.000000000 +0800
+++ b/drivers/net/pcnet32.c	2005-09-12 14:39:11.000000000 +0800
@@ -22,8 +22,8 @@
  *************************************************************************/
 
 #define DRV_NAME	"pcnet32"
-#define DRV_VERSION	"1.31"
-#define DRV_RELDATE	"02.Sep.2005"
+#define DRV_VERSION	"1.31a"
+#define DRV_RELDATE	"12.Sep.2005"
 #define PFX		DRV_NAME ": "
 
 static const char *version =
@@ -258,6 +258,8 @@ static int homepna[MAX_UNITS];
  * v1.30i  28 Jun 2004 Don Fry change to use module_param.
  * v1.30j  29 Apr 2005 Don Fry fix skb/map leak with loopback test.
  * v1.31   02 Sep 2005 Hubert WS Lin <wslin@tw.ibm.c0m> added set_ringparam().
+ * v1.31a  12 Sep 2005 Hubert WS Lin <wslin@tw.ibm.c0m> set min ring size to 4
+ *	   to allow loopback test to work unchanged.
  */
 
 
@@ -335,14 +337,14 @@ struct pcnet32_access {
 };
 
 /*
- * The first three fields of pcnet32_private are read by the ethernet device
- * so we allocate the structure should be allocated by pci_alloc_consistent().
+ * The first field of pcnet32_private is read by the ethernet device
+ * so the structure should be allocated using pci_alloc_consistent().
  */
 struct pcnet32_private {
+    struct pcnet32_init_block init_block;
     /* The Tx and Rx ring entries must be aligned on 16-byte boundaries in 32bit mode. */
     struct pcnet32_rx_head    *rx_ring;
     struct pcnet32_tx_head    *tx_ring;
-    struct pcnet32_init_block init_block;
     dma_addr_t		dma_addr;	/* DMA address of beginning of this
 					   object, returned by
 					   pci_alloc_consistent */
@@ -648,7 +650,10 @@ static int pcnet32_set_ringparam(struct 
     lp->tx_ring_size = min(ering->tx_pending, (unsigned int) TX_MAX_RING_SIZE);
     lp->rx_ring_size = min(ering->rx_pending, (unsigned int) RX_MAX_RING_SIZE);
 
-    for (i = 0; i <= PCNET32_LOG_MAX_TX_BUFFERS; i++) {
+    /* set the minimum ring size to 4, to allow the loopback test to work
+     * unchanged.
+     */
+    for (i = 2; i <= PCNET32_LOG_MAX_TX_BUFFERS; i++) {
 	if (lp->tx_ring_size <= (1 << i))
 	    break;
     }
@@ -656,7 +661,7 @@ static int pcnet32_set_ringparam(struct 
     lp->tx_mod_mask = lp->tx_ring_size - 1;
     lp->tx_len_bits = (i << 12);
 
-    for (i = 0; i <= PCNET32_LOG_MAX_RX_BUFFERS; i++) {
+    for (i = 2; i <= PCNET32_LOG_MAX_RX_BUFFERS; i++) {
 	if (lp->rx_ring_size <= (1 << i))
 	    break;
     }

--------------000308090300090008090301--
