Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132823AbRDDNsX>; Wed, 4 Apr 2001 09:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132821AbRDDNsO>; Wed, 4 Apr 2001 09:48:14 -0400
Received: from 13dyn214.delft.casema.net ([212.64.76.214]:25866 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S132819AbRDDNr5>; Wed, 4 Apr 2001 09:47:57 -0400
Date: Wed, 4 Apr 2001 15:46:23 +0200 (CEST)
From: Patrick van de Lageweg <patrick@bitwizard.nl>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Rogier Wolff <R.E.Wolff@bitwizard.nl>
Subject: [PATCH] Fujitsu ATM FireStream
Message-ID: <Pine.LNX.4.31.0104041537120.16269-100000@panoramix.bitwizard.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch fixes a problem the the firestream card and adds support for
atm aal2 mode. This is a patch against the 2.4.0 tree and not agains 2.4.3
because we're having trouble whith the ixj driver in 2.4.3.

	Patrick


diff -u linux-2.4.0.clean/drivers/atm/firestream.c /usr/src/linux/drivers/atm/firestream.c
--- linux-2.4.0.clean/drivers/atm/firestream.c	Fri Dec 29 23:35:47 2000
+++ /usr/src/linux/drivers/atm/firestream.c	Wed Apr  4 15:31:48 2001
@@ -294,6 +294,8 @@
 #endif


+static int fs_keystream = 0;
+
 #ifdef DEBUG
 /* I didn't forget to set this to zero before shipping. Hit me with a stick
    if you get this with the debug default not set to zero again. -- REW */
@@ -308,6 +310,7 @@
 #endif
 MODULE_PARM(loopback, "i");
 MODULE_PARM(num, "i");
+MODULE_PARM(fs_keystream, "i");
 /* XXX Add rx_buf_sizes, and rx_pool_sizes As per request Amar. -- REW */
 #endif

@@ -716,6 +719,8 @@


 		switch (STATUS_CODE (qe)) {
+		case 0x01: /* This is for AAL0 where we put the chip in streaming mode */
+			/* Fall through */
 		case 0x02:
 			/* Process a real txdone entry. */
 			tmp = qe->p0;
@@ -796,6 +801,8 @@

 		/* Single buffer packet */
 		switch (STATUS_CODE (qe)) {
+		case 0x1:
+			/* Fall through for streaming mode */
 		case 0x2:/* Packet received OK.... */
 			if (atm_vcc) {
 				skb = pe->skb;
@@ -877,7 +884,9 @@
 	if (vci != ATM_VPI_UNSPEC && vpi != ATM_VCI_UNSPEC)
 		set_bit(ATM_VF_ADDR, &atm_vcc->flags);

-	if (atm_vcc->qos.aal != ATM_AAL5) return -EINVAL; /* XXX AAL0 */
+	if ((atm_vcc->qos.aal != ATM_AAL5) &&
+	    (atm_vcc->qos.aal != ATM_AAL2))
+	  return -EINVAL; /* XXX AAL0 */

 	fs_dprintk (FS_DEBUG_OPEN, "fs: (itf %d): open %d.%d\n",
 		    atm_vcc->dev->number, atm_vcc->vpi, atm_vcc->vci);
@@ -946,12 +955,27 @@
 		   need to wait for completion anyway, to see if it completed
 		   succesfully. */

-		tc->flags = 0
+		switch (atm_vcc->qos.aal) {
+		case ATM_AAL2:
+		case ATM_AAL0:
+		  tc->flags = 0
+		    | TC_FLAGS_TRANSPARENT_PAYLOAD
+		    | TC_FLAGS_PACKET
+		    | (1 << 28)
+		    | TC_FLAGS_TYPE_UBR /* XXX Change to VBR -- PVDL */
+		    | TC_FLAGS_CAL0;
+		  break;
+		case ATM_AAL5:
+		  tc->flags = 0
 			| TC_FLAGS_AAL5
 			| TC_FLAGS_PACKET  /* ??? */
 			| TC_FLAGS_TYPE_CBR
 			| TC_FLAGS_CAL0;
-
+		  break;
+		default:
+			printk ("Unknown aal: %d\n", atm_vcc->qos.aal);
+			tc->flags = 0;
+		}
 		/* Docs are vague about this atm_hdr field. By the way, the FS
 		 * chip makes odd errors if lower bits are set.... -- REW */
 		tc->atm_hdr =  (vpi << 20) | (vci << 4);
@@ -1025,7 +1049,6 @@

 		for (bfp = 0;bfp < FS_NR_FREE_POOLS; bfp++)
 			if (atm_vcc->qos.rxtp.max_sdu <= dev->rx_fp[bfp].bufsize) break;
-
 		if (bfp >= FS_NR_FREE_POOLS) {
 			fs_dprintk (FS_DEBUG_OPEN, "No free pool fits sdu: %d.\n",
 				    atm_vcc->qos.rxtp.max_sdu);
@@ -1037,12 +1060,23 @@
 			return -EINVAL;
 		}

-		submit_command (dev, &dev->hp_txq,
-				QE_CMD_CONFIG_RX | QE_CMD_IMM_INQ | vcc->channo,
-				RC_FLAGS_AAL5 |
-				RC_FLAGS_BFPS_BFP * bfp |
-				RC_FLAGS_RXBM_PSB, 0, 0);
-
+		switch (atm_vcc->qos.aal) {
+		case ATM_AAL0:
+		case ATM_AAL2:
+			submit_command (dev, &dev->hp_txq,
+					QE_CMD_CONFIG_RX | QE_CMD_IMM_INQ | vcc->channo,
+					RC_FLAGS_TRANSP |
+					RC_FLAGS_BFPS_BFP * bfp |
+					RC_FLAGS_RXBM_PSB, 0, 0);
+			break;
+		case ATM_AAL5:
+			submit_command (dev, &dev->hp_txq,
+					QE_CMD_CONFIG_RX | QE_CMD_IMM_INQ | vcc->channo,
+					RC_FLAGS_AAL5 |
+					RC_FLAGS_BFPS_BFP * bfp |
+					RC_FLAGS_RXBM_PSB, 0, 0);
+			break;
+		};
 		if (IS_FS50 (dev)) {
 			submit_command (dev, &dev->hp_txq,
 					QE_CMD_REG_WR | QE_CMD_IMM_INQ,
@@ -1697,7 +1731,7 @@

 	/* AN3: 10 */
 	write_fs (dev, SARMODE1, 0
-		  | (0 * SARMODE1_DEFHEC) /* XXX PHY */
+		  | (fs_keystream * SARMODE1_DEFHEC) /* XXX PHY */
 		  | ((loopback == 1) * SARMODE1_TSTLP) /* XXX Loopback mode enable... */
 		  | (1 * SARMODE1_DCRM)
 		  | (1 * SARMODE1_DCOAM)
diff -u linux-2.4.0.clean/drivers/atm/firestream.h /usr/src/linux/drivers/atm/firestream.h
--- linux-2.4.0.clean/drivers/atm/firestream.h	Fri Dec 29 23:35:47 2000
+++ /usr/src/linux/drivers/atm/firestream.h	Wed Feb 28 15:59:42 2001
@@ -369,6 +369,9 @@
 };

 #define TC_FLAGS_AAL5      (0x0 << 29)
+#define TC_FLAGS_TRANSPARENT_PAYLOAD (0x1 << 29)
+#define TC_FLAGS_TRANSPARENT_CELL    (0x2 << 29)
+#define TC_FLAGS_STREAMING (0x1 << 28)
 #define TC_FLAGS_PACKET    (0x0)
 #define TC_FLAGS_TYPE_ABR  (0x0 << 22)
 #define TC_FLAGS_TYPE_CBR  (0x1 << 22)
@@ -498,8 +501,8 @@

 /* Within limits this is user-configurable. */
 /* Note: Currently the sum (10 -> 1k channels) is hardcoded in the driver. */
-#define FS155_VPI_BITS 5
-#define FS155_VCI_BITS 5
+#define FS155_VPI_BITS 4
+#define FS155_VCI_BITS 6

 #define FS155_CHANNEL_BITS  (FS155_VPI_BITS + FS155_VCI_BITS)
 #define FS155_NR_CHANNELS   (1 << FS155_CHANNEL_BITS)

