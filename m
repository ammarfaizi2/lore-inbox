Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbTKVIWp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 03:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbTKVIWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 03:22:45 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:1555 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S262128AbTKVIWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 03:22:41 -0500
Date: Sat, 22 Nov 2003 19:22:27 +1100
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [I810_AUDIO] 4/x: Clean up with macros
Message-ID: <20031122082227.GA27692@gondor.apana.org.au>
References: <20031122070931.GA27231@gondor.apana.org.au> <20031122071345.GA27303@gondor.apana.org.au> <20031122071935.GA27371@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <20031122071935.GA27371@gondor.apana.org.au>
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch adds a number macros to clean up the code.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p4

Index: kernel-source-2.4/drivers/sound/i810_audio.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.4/drivers/sound/i810_audio.c,v
retrieving revision 1.11
diff -u -r1.11 i810_audio.c
--- kernel-source-2.4/drivers/sound/i810_audio.c	22 Nov 2003 07:20:03 -0000	1.11
+++ kernel-source-2.4/drivers/sound/i810_audio.c	22 Nov 2003 08:17:09 -0000
@@ -143,6 +143,9 @@
 #define PCI_DEVICE_ID_AMD_8111_AC97	0x746d
 #endif
 
+#define MODULOP2(a, b) ((a) & ((b) - 1))
+#define MASKP2(a, b) ((a) & ~((b) - 1))
+
 static int ftsodell=0;
 static int strict_clocking=0;
 static unsigned int clocking=0;
@@ -204,6 +207,7 @@
 
 #define ENUM_ENGINE(PRE,DIG) 									\
 enum {												\
+	PRE##_BASE =	0x##DIG##0,		/* Base Address */				\
 	PRE##_BDBAR =	0x##DIG##0,		/* Buffer Descriptor list Base Address */	\
 	PRE##_CIV =	0x##DIG##4,		/* Current Index Value */			\
 	PRE##_LVI =	0x##DIG##5,		/* Last Valid Index */				\
@@ -481,8 +485,12 @@
 /* extract register offset from codec struct */
 #define IO_REG_OFF(codec) (((struct i810_card *) codec->private_data)->ac97_id_map[codec->id])
 
+#define GET_CIV(port) MODULOP2(inb((port) + OFF_CIV), SG_LEN)
+#define GET_LVI(port) MODULOP2(inb((port) + OFF_LVI), SG_LEN)
+
 /* set LVI from CIV */
-#define CIV_TO_LVI(port, off) outb((inb(port+OFF_CIV)+off) & 31, port+OFF_LVI)
+#define CIV_TO_LVI(port, off) \
+	outb(MODULOP2(GET_CIV((port)) + (off), SG_LEN), (port) + OFF_LVI)
 
 static struct i810_card *devs = NULL;
 
@@ -752,7 +760,7 @@
 		port_picb = port + OFF_PICB;
 
 	do {
-		civ = inb(port+OFF_CIV) & 31;
+		civ = GET_CIV(port);
 		offset = inw(port_picb);
 		/* Must have a delay here! */ 
 		if(offset == 0)
@@ -772,7 +780,7 @@
 		 * that we won't have to worry about the chip still being
 		 * out of sync with reality ;-)
 		 */
-	} while (civ != (inb(port+OFF_CIV) & 31) || offset != inw(port_picb));
+	} while (civ != GET_CIV(port) || offset != inw(port_picb));
 		 
 	return (((civ + 1) * dmabuf->fragsize - (bytes * offset))
 		% dmabuf->dmasize);
@@ -1124,8 +1132,8 @@
 			/* this is normal for the end of a read */
 			/* only give an error if we went past the */
 			/* last valid sg entry */
-			if((inb(state->card->iobase + PI_CIV) & 31) !=
-			   (inb(state->card->iobase + PI_LVI) & 31)) {
+			if (GET_CIV(state->card->iobase + PI_BASE) !=
+			    GET_LVI(state->card->iobase + PI_BASE)) {
 				printk(KERN_WARNING "i810_audio: DMA overrun on read\n");
 				dmabuf->error++;
 			}
@@ -1149,13 +1157,13 @@
 			/* this is normal for the end of a write */
 			/* only give an error if we went past the */
 			/* last valid sg entry */
-			if((inb(state->card->iobase + PO_CIV) & 31) !=
-			   (inb(state->card->iobase + PO_LVI) & 31)) {
+			if (GET_CIV(state->card->iobase + PO_BASE) !=
+			    GET_LVI(state->card->iobase + PO_BASE)) {
 				printk(KERN_WARNING "i810_audio: DMA overrun on write\n");
 				printk("i810_audio: CIV %d, LVI %d, hwptr %x, "
 					"count %d\n",
-					inb(state->card->iobase + PO_CIV) & 31,
-					inb(state->card->iobase + PO_LVI) & 31,
+					GET_CIV(state->card->iobase + PO_BASE),
+					GET_LVI(state->card->iobase + PO_BASE),
 					dmabuf->hwptr, dmabuf->count);
 				dmabuf->error++;
 			}
@@ -3042,7 +3050,7 @@
 			goto config_out;
 		}
 		dmabuf->count = dmabuf->dmasize;
-		CIV_TO_LVI(card->iobase+dmabuf->write_channel->port, 31);
+		CIV_TO_LVI(card->iobase+dmabuf->write_channel->port, -1);
 		save_flags(flags);
 		cli();
 		start_dac(state);

--sm4nu43k4a2Rpi4c--
