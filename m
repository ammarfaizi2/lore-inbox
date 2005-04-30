Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261324AbVD3SQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbVD3SQJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 14:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbVD3SQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 14:16:09 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:33805 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261324AbVD3SPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 14:15:40 -0400
Date: Sat, 30 Apr 2005 20:15:30 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: sailer@ife.ee.ethz.ch, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       netdev@oss.sgi.com
Subject: [2.6 patch] drivers/net/hamradio/baycom_epp.c: cleanups
Message-ID: <20050430181529.GF3571@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The times when tricky goto's produced better codes are long gone.

This patch should express the same in a better way, please check whether 
I made any mistake.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 20 Apr 2005

 drivers/net/hamradio/baycom_epp.c |  126 ++++++++----------------------
 1 files changed, 36 insertions(+), 90 deletions(-)

--- linux-2.6.12-rc2-mm3/drivers/net/hamradio/baycom_epp.c.old	2005-04-20 16:18:47.000000000 +0200
+++ linux-2.6.12-rc2-mm3/drivers/net/hamradio/baycom_epp.c	2005-04-20 17:14:36.000000000 +0200
@@ -374,29 +374,6 @@
 }
 
 /* --------------------------------------------------------------------- */
-/*
- * high performance HDLC encoder
- * yes, it's ugly, but generates pretty good code
- */
-
-#define ENCODEITERA(j)                         \
-({                                             \
-        if (!(notbitstream & (0x1f0 << j)))    \
-                goto stuff##j;                 \
-  encodeend##j:    	;                      \
-})
-
-#define ENCODEITERB(j)                                          \
-({                                                              \
-  stuff##j:                                                     \
-        bitstream &= ~(0x100 << j);                             \
-        bitbuf = (bitbuf & (((2 << j) << numbit) - 1)) |        \
-                ((bitbuf & ~(((2 << j) << numbit) - 1)) << 1);  \
-        numbit++;                                               \
-        notbitstream = ~bitstream;                              \
-        goto encodeend##j;                                      \
-})
-
 
 static void encode_hdlc(struct baycom_state *bc)
 {
@@ -405,6 +382,7 @@
 	int pkt_len;
         unsigned bitstream, notbitstream, bitbuf, numbit, crc;
 	unsigned char crcarr[2];
+	int j;
 	
 	if (bc->hdlctx.bufcnt > 0)
 		return;
@@ -429,24 +407,14 @@
 		pkt_len--;
 		if (!pkt_len)
 			bp = crcarr;
-		ENCODEITERA(0);
-		ENCODEITERA(1);
-		ENCODEITERA(2);
-		ENCODEITERA(3);
-		ENCODEITERA(4);
-		ENCODEITERA(5);
-		ENCODEITERA(6);
-		ENCODEITERA(7);
-		goto enditer;
-		ENCODEITERB(0);
-		ENCODEITERB(1);
-		ENCODEITERB(2);
-		ENCODEITERB(3);
-		ENCODEITERB(4);
-		ENCODEITERB(5);
-		ENCODEITERB(6);
-		ENCODEITERB(7);
-	enditer:
+		for (j = 0; j < 8; j++)
+			if (unlikely(!(notbitstream & (0x1f0 << j)))) {
+				bitstream &= ~(0x100 << j);
+ 				bitbuf = (bitbuf & (((2 << j) << numbit) - 1)) |
+					((bitbuf & ~(((2 << j) << numbit) - 1)) << 1);
+				numbit++;
+				notbitstream = ~bitstream;
+			}
 		numbit += 8;
 		while (numbit >= 8) {
 			*wp++ = bitbuf;
@@ -612,37 +580,6 @@
 	bc->stats.rx_packets++;
 }
 
-#define DECODEITERA(j)                                                        \
-({                                                                            \
-        if (!(notbitstream & (0x0fc << j)))              /* flag or abort */  \
-                goto flgabrt##j;                                              \
-        if ((bitstream & (0x1f8 << j)) == (0xf8 << j))   /* stuffed bit */    \
-                goto stuff##j;                                                \
-  enditer##j:      ;                                                           \
-})
-
-#define DECODEITERB(j)                                                                 \
-({                                                                                     \
-  flgabrt##j:                                                                          \
-        if (!(notbitstream & (0x1fc << j))) {              /* abort received */        \
-                state = 0;                                                             \
-                goto enditer##j;                                                       \
-        }                                                                              \
-        if ((bitstream & (0x1fe << j)) != (0x0fc << j))   /* flag received */          \
-                goto enditer##j;                                                       \
-        if (state)                                                                     \
-                do_rxpacket(dev);                                                      \
-        bc->hdlcrx.bufcnt = 0;                                                         \
-        bc->hdlcrx.bufptr = bc->hdlcrx.buf;                                            \
-        state = 1;                                                                     \
-        numbits = 7-j;                                                                 \
-        goto enditer##j;                                                               \
-  stuff##j:                                                                            \
-        numbits--;                                                                     \
-        bitbuf = (bitbuf & ((~0xff) << j)) | ((bitbuf & ~((~0xff) << j)) << 1);        \
-        goto enditer##j;                                                               \
-})
-        
 static int receive(struct net_device *dev, int cnt)
 {
 	struct baycom_state *bc = netdev_priv(dev);
@@ -651,6 +588,7 @@
 	unsigned char tmp[128];
         unsigned char *cp;
 	int cnt2, ret = 0;
+	int j;
         
         numbits = bc->hdlcrx.numbits;
 	state = bc->hdlcrx.state;
@@ -671,24 +609,32 @@
 			bitbuf |= (*cp) << 8;
 			numbits += 8;
 			notbitstream = ~bitstream;
-			DECODEITERA(0);
-			DECODEITERA(1);
-			DECODEITERA(2);
-			DECODEITERA(3);
-			DECODEITERA(4);
-			DECODEITERA(5);
-			DECODEITERA(6);
-			DECODEITERA(7);
-			goto enddec;
-			DECODEITERB(0);
-			DECODEITERB(1);
-			DECODEITERB(2);
-			DECODEITERB(3);
-			DECODEITERB(4);
-			DECODEITERB(5);
-			DECODEITERB(6);
-			DECODEITERB(7);
-		enddec:
+			for (j = 0; j < 8; j++) {
+
+				/* flag or abort */
+			        if (unlikely(!(notbitstream & (0x0fc << j)))) {
+
+					/* abort received */
+					if (!(notbitstream & (0x1fc << j)))
+						state = 0;
+
+					/* not flag received */
+					else if (!(bitstream & (0x1fe << j)) != (0x0fc << j)) {
+						if (state)
+							do_rxpacket(dev);
+						bc->hdlcrx.bufcnt = 0;
+						bc->hdlcrx.bufptr = bc->hdlcrx.buf;
+						state = 1;
+						numbits = 7-j;
+						}
+					}
+
+				/* stuffed bit */
+				else if (unlikely((bitstream & (0x1f8 << j)) == (0xf8 << j))) {
+					numbits--;
+					bitbuf = (bitbuf & ((~0xff) << j)) | ((bitbuf & ~((~0xff) << j)) << 1);
+					}
+				}
 			while (state && numbits >= 8) {
 				if (bc->hdlcrx.bufcnt >= TXBUFFER_SIZE) {
 					state = 0;

