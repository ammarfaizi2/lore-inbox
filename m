Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751880AbWIHAAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880AbWIHAAM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 20:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751917AbWIHAAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 20:00:11 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:40854 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751880AbWIHAAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 20:00:06 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Fri, 8 Sep 2006 01:59:03 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2/2] ieee1394: ohci1394: more obvious endianess handling
To: linux1394-devel@lists.sourceforge.net
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Wolfgang Pfeiffer <roto@gmx.net>, Ben Collins <bcollins@ubuntu.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <tkrat.e9e9aee005df0fb6@s5r6.in-berlin.de>
Message-ID: <tkrat.6542432df5a04083@s5r6.in-berlin.de>
References: <tkrat.e9e9aee005df0fb6@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rename ohci1394's packet_swab to header_le32_to_cpu to better reflect
what it actually does.  Also, define a constant array as 'const' and
check the array index properly.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
Index: linux/drivers/ieee1394/ohci1394.c
===================================================================
--- linux.orig/drivers/ieee1394/ohci1394.c	2006-09-07 15:48:15.000000000 +0200
+++ linux/drivers/ieee1394/ohci1394.c	2006-09-07 20:33:29.000000000 +0200
@@ -181,36 +181,35 @@ static int alloc_dma_trm_ctx(struct ti_o
 static void ohci1394_pci_remove(struct pci_dev *pdev);
 
 #ifndef __LITTLE_ENDIAN
-static unsigned hdr_sizes[] =
-{
+const static size_t hdr_sizes[] = {
 	3,	/* TCODE_WRITEQ */
 	4,	/* TCODE_WRITEB */
 	3,	/* TCODE_WRITE_RESPONSE */
-	0,	/* ??? */
+	0,	/* reserved */
 	3,	/* TCODE_READQ */
 	4,	/* TCODE_READB */
 	3,	/* TCODE_READQ_RESPONSE */
 	4,	/* TCODE_READB_RESPONSE */
-	1,	/* TCODE_CYCLE_START (???) */
+	1,	/* TCODE_CYCLE_START */
 	4,	/* TCODE_LOCK_REQUEST */
 	2,	/* TCODE_ISO_DATA */
 	4,	/* TCODE_LOCK_RESPONSE */
+		/* rest is reserved or link-internal */
 };
 
-/* Swap headers */
-static inline void packet_swab(quadlet_t *data, int tcode)
+static inline void header_le32_to_cpu(quadlet_t *data, unsigned char tcode)
 {
-	size_t size = hdr_sizes[tcode];
+	size_t size;
 
-	if (tcode > TCODE_LOCK_RESPONSE || hdr_sizes[tcode] == 0)
+	if (unlikely(tcode >= ARRAY_SIZE(hdr_sizes)))
 		return;
 
+	size = hdr_sizes[tcode];
 	while (size--)
-		data[size] = swab32(data[size]);
+		data[size] = le32_to_cpu(data[size]);
 }
 #else
-/* Don't waste cycles on same sex byte swaps */
-#define packet_swab(w,x) do {} while (0)
+#define header_le32_to_cpu(w,x) do {} while (0)
 #endif /* !LITTLE_ENDIAN */
 
 /***********************************
@@ -705,7 +704,7 @@ static void insert_packet(struct ti_ohci
 				d->prg_cpu[idx]->data[2] = packet->header[2];
 				d->prg_cpu[idx]->data[3] = packet->header[3];
 			}
-			packet_swab(d->prg_cpu[idx]->data, packet->tcode);
+			header_le32_to_cpu(d->prg_cpu[idx]->data, packet->tcode);
                 }
 
                 if (packet->data_size) { /* block transmit */
@@ -781,7 +780,7 @@ static void insert_packet(struct ti_ohci
                 d->prg_cpu[idx]->data[0] = packet->speed_code<<16 |
                         (packet->header[0] & 0xFFFF);
                 d->prg_cpu[idx]->data[1] = packet->header[0] & 0xFFFF0000;
-		packet_swab(d->prg_cpu[idx]->data, packet->tcode);
+		header_le32_to_cpu(d->prg_cpu[idx]->data, packet->tcode);
 
                 d->prg_cpu[idx]->begin.control =
 			cpu_to_le32(DMA_CTL_OUTPUT_MORE |
@@ -2735,7 +2734,7 @@ static void dma_rcv_tasklet (unsigned lo
 		 * bus reset. We always ignore it.  */
 		if (tcode != OHCI1394_TCODE_PHY) {
 			if (!ohci->no_swap_incoming)
-				packet_swab(d->spb, tcode);
+				header_le32_to_cpu(d->spb, tcode);
 			DBGMSG("Packet received from node"
 				" %d ack=0x%02X spd=%d tcode=0x%X"
 				" length=%d ctx=%d tlabel=%d",


