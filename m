Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314057AbSDQEms>; Wed, 17 Apr 2002 00:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314058AbSDQEmr>; Wed, 17 Apr 2002 00:42:47 -0400
Received: from pandora.cantech.net.au ([203.26.6.29]:42247 "EHLO
	pandora.cantech.net.au") by vger.kernel.org with ESMTP
	id <S314057AbSDQEmq>; Wed, 17 Apr 2002 00:42:46 -0400
Date: Wed, 17 Apr 2002 12:42:23 +0800 (WST)
From: "Anthony J. Breeds-Taurima" <tony@cantech.net.au>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] Change "return EBLAH" to "return -EBLAH in drivers/*
Message-ID: <Pine.LNX.4.33.0204171223370.14274-100000@thor.cantech.net.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,
	This is a simple patch that changes several "return EBLAH"'s in drivers/*
for "return -EBLAH".  I have done my best to check the call stack to ensure
that the change in sign of the return values wont break anything.

The patch supplied is agaist linux-2.4.19-pre6


Yours Tony.

/*
 * "The significant problems we face cannot be solved at the 
 * same level of thinking we were at when we created them."
 * --Albert Einstein
 */

--------------------------------------------------------------------------------
diff -urN -X /usr/src/dontdiff linux-2.4.19-pre6.clean/drivers/acorn/net/etherh.c linux-2.4.19-pre6/drivers/acorn/net/etherh.c
--- linux-2.4.19-pre6.clean/drivers/acorn/net/etherh.c	Mon Oct 22 16:04:29 2001
+++ linux-2.4.19-pre6/drivers/acorn/net/etherh.c	Wed Apr 17 10:42:41 2002
@@ -475,7 +475,7 @@
 		if (i == 6)
 			return 0;
 	}
-	return ENODEV;
+	return -ENODEV;
 }
 
 /*
@@ -486,7 +486,7 @@
 	unsigned int serial;
 
 	if (system_serial_low == 0 && system_serial_high == 0)
-		return ENODEV;
+		return -ENODEV;
 
 	serial = system_serial_low | system_serial_high;
 
diff -urN -X /usr/src/dontdiff linux-2.4.19-pre6.clean/drivers/block/ps2esdi.c linux-2.4.19-pre6/drivers/block/ps2esdi.c
--- linux-2.4.19-pre6.clean/drivers/block/ps2esdi.c	Thu Dec 13 11:00:43 2001
+++ linux-2.4.19-pre6/drivers/block/ps2esdi.c	Wed Apr 17 11:01:26 2002
@@ -630,7 +630,7 @@
 	/* if device is still busy - then just time out */
 	if (inb(ESDI_STATUS) & STATUS_BUSY) {
 		printk("%s: ps2esdi_out_cmd timed out (1)\n", DEVICE_NAME);
-		return ERROR;
+		return -ERROR;
 	}			/* timeout ??? */
 	/* Set up the attention register in the controller */
 	outb(((*cmd_blk) & 0xE0) | 1, ESDI_ATTN);
@@ -653,7 +653,7 @@
 		} else {
 			printk("%s: ps2esdi_out_cmd timed out while sending command (status=%02X)\n",
 			       DEVICE_NAME, status);
-			return ERROR;
+			return -ERROR;
 		}
 	}			/* send all words out */
 	return OK;
diff -urN -X /usr/src/dontdiff linux-2.4.19-pre6.clean/drivers/mtd/mtdblock_ro.c linux-2.4.19-pre6/drivers/mtd/mtdblock_ro.c
--- linux-2.4.19-pre6.clean/drivers/mtd/mtdblock_ro.c	Tue Apr 16 16:33:28 2002
+++ linux-2.4.19-pre6/drivers/mtd/mtdblock_ro.c	Wed Apr 17 10:41:57 2002
@@ -268,7 +268,7 @@
 	if (register_blkdev(MAJOR_NR,DEVICE_NAME,&mtd_fops)) {
 		printk(KERN_NOTICE "Can't allocate major number %d for Memory Technology Devices.\n",
 		       MTD_BLOCK_MAJOR);
-		return EAGAIN;
+		return -EAGAIN;
 	}
 	
 	/* We fill it in at open() time. */
diff -urN -X /usr/src/dontdiff linux-2.4.19-pre6.clean/drivers/net/plip.c linux-2.4.19-pre6/drivers/net/plip.c
--- linux-2.4.19-pre6.clean/drivers/net/plip.c	Mon Oct 22 16:05:31 2001
+++ linux-2.4.19-pre6/drivers/net/plip.c	Wed Apr 17 11:08:35 2002
@@ -685,13 +685,13 @@
 		if (rcv->length.h > dev->mtu + dev->hard_header_len
 		    || rcv->length.h < 8) {
 			printk(KERN_WARNING "%s: bogus packet size %d.\n", dev->name, rcv->length.h);
-			return ERROR;
+			return -ERROR;
 		}
 		/* Malloc up new buffer. */
 		rcv->skb = dev_alloc_skb(rcv->length.h + 2);
 		if (rcv->skb == NULL) {
 			printk(KERN_ERR "%s: Memory squeeze.\n", dev->name);
-			return ERROR;
+			return -ERROR;
 		}
 		skb_reserve(rcv->skb, 2);	/* Align IP on 16 byte boundaries */
 		skb_put(rcv->skb,rcv->length.h);
@@ -720,7 +720,7 @@
 			nl->enet_stats.rx_crc_errors++;
 			if (net_debug)
 				printk(KERN_DEBUG "%s: checksum error\n", dev->name);
-			return ERROR;
+			return -ERROR;
 		}
 		rcv->state = PLIP_PK_DONE;
 
@@ -816,7 +816,7 @@
 		printk(KERN_DEBUG "%s: send skb lost\n", dev->name);
 		snd->state = PLIP_PK_DONE;
 		snd->skb = NULL;
-		return ERROR;
+		return -ERROR;
 	}
 
 	switch (snd->state) {
diff -urN -X /usr/src/dontdiff linux-2.4.19-pre6.clean/drivers/scsi/sym53c8xx_2/sym_hipd.c linux-2.4.19-pre6/drivers/scsi/sym53c8xx_2/sym_hipd.c
--- linux-2.4.19-pre6.clean/drivers/scsi/sym53c8xx_2/sym_hipd.c	Fri Feb  1 17:42:40 2002
+++ linux-2.4.19-pre6/drivers/scsi/sym53c8xx_2/sym_hipd.c	Wed Apr 17 10:50:04 2002
@@ -5947,7 +5947,7 @@
 	 */
 attach_failed:
 		sym_hcb_free(np);
-	return ENXIO;
+	return -ENXIO;
 }
 
 /*
diff -urN -X /usr/src/dontdiff linux-2.4.19-pre6.clean/drivers/sound/cs46xx.c linux-2.4.19-pre6/drivers/sound/cs46xx.c
--- linux-2.4.19-pre6.clean/drivers/sound/cs46xx.c	Tue Apr 16 16:33:36 2002
+++ linux-2.4.19-pre6/drivers/sound/cs46xx.c	Wed Apr 17 10:43:09 2002
@@ -2212,7 +2212,7 @@
 	if(!state)
 		return -ENODEV;
 	if (!access_ok(VERIFY_READ, buffer, count))
-		return EFAULT;
+		return -EFAULT;
 	dmabuf = &state->dmabuf;
 
 	if (ppos != &file->f_pos)
diff -urN -X /usr/src/dontdiff linux-2.4.19-pre6.clean/drivers/usb/se401.c linux-2.4.19-pre6/drivers/usb/se401.c
--- linux-2.4.19-pre6.clean/drivers/usb/se401.c	Mon Oct 22 16:04:55 2001
+++ linux-2.4.19-pre6/drivers/usb/se401.c	Wed Apr 17 10:42:17 2002
@@ -646,7 +646,7 @@
 	for (i=0; i<SE401_NUMSBUF; i++) {
 		urb=usb_alloc_urb(0);
 		if(!urb)
-			return ENOMEM;
+			return -ENOMEM;
 
 		FILL_BULK_URB(urb, se401->dev,
 			usb_rcvbulkpipe(se401->dev, SE401_VIDEO_ENDPOINT),
diff -urN -X /usr/src/dontdiff linux-2.4.19-pre6.clean/drivers/usb/stv680.c linux-2.4.19-pre6/drivers/usb/stv680.c
--- linux-2.4.19-pre6.clean/drivers/usb/stv680.c	Tue Apr 16 16:33:40 2002
+++ linux-2.4.19-pre6/drivers/usb/stv680.c	Wed Apr 17 10:42:30 2002
@@ -806,7 +806,7 @@
 	for (i = 0; i < STV680_NUMSBUF; i++) {
 		urb = usb_alloc_urb (0);
 		if (!urb)
-			return ENOMEM;
+			return -ENOMEM;
 
 		/* sbuf is urb->transfer_buffer, later gets memcpyed to scratch */
 		usb_fill_bulk_urb (urb, stv680->udev,

