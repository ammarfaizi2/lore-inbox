Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283723AbRL1Ak5>; Thu, 27 Dec 2001 19:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283757AbRL1Akz>; Thu, 27 Dec 2001 19:40:55 -0500
Received: from nfs1.infosys.tuwien.ac.at ([128.131.172.16]:21225 "EHLO
	infosys.tuwien.ac.at") by vger.kernel.org with ESMTP
	id <S283723AbRL1Akg>; Thu, 27 Dec 2001 19:40:36 -0500
Date: Fri, 28 Dec 2001 01:35:22 +0100
From: Thomas Gschwind <tom@infosys.tuwien.ac.at>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@redhat.com>
Subject: [patch] SiS7012 audio driver
Message-ID: <20011228013522.A10716@infosys.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello *!

I have added support for the SiS7012 audio driver to the i810 audio
driver.  Playback works perfectly fine for me on an ECS K7S5A
mainboard.  In some situations, recording causes my system to crash
but I am still working on it.

BTW, does anybody have a datasheet?  Currently, this driver is based
on the fact that OSS uses the same driver for the i810 and SiS7012
chipsets and some experimentations.

If you have questions, recommendations, etc. please mail me directly I
am not regularly reading the kernel mailing list.

Thomas
-- 
Thomas Gschwind                      Email: tom@infosys.tuwien.ac.at
Technische Universit‰t Wien
Argentinierstraﬂe 8/E1841            Tel: +43 (1) 58801 ext. 18412
A-1040 Wien, Austria, Europe         Fax: +43 (1) 58801 ext. 18491

--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sis7012.patch"

--- i810_audio.c.orig	Fri Dec 28 01:41:26 2001
+++ i810_audio.c	Fri Dec 28 01:40:13 2001
@@ -2,6 +2,9 @@
  *	Intel i810 and friends ICH driver for Linux
  *	Alan Cox <alan@redhat.com>
  *
+ *      SiS7012 code by
+ *      Thomas Gschwind <tom@infosys.tuwien.ac.at>
+ *
  *  Built from:
  *	Low level code:  Zach Brown (original nonworking i810 OSS driver)
  *			 Jaroslav Kysela <perex@suse.cz> (working ALSA driver)
@@ -102,6 +105,9 @@
 #ifndef PCI_DEVICE_ID_INTEL_440MX
 #define PCI_DEVICE_ID_INTEL_440MX	0x7195
 #endif
+#ifndef PCI_DEVICE_ID_SI_7012
+#define PCI_DEVICE_ID_SI_7012	0x7012
+#endif
 
 static int ftsodell=0;
 static int strict_clocking=0;
@@ -197,7 +203,7 @@
 #define INT_MASK (INT_SEC|INT_PRI|INT_MC|INT_PO|INT_PI|INT_MO|INT_NI|INT_GPI)
 
 
-#define DRIVER_VERSION "0.04"
+#define DRIVER_VERSION "0.05"
 
 /* magic numbers to protect our data structures */
 #define I810_CARD_MAGIC		0x5072696E /* "Prin" */
@@ -220,7 +226,8 @@
 	ICH82901AB,
 	INTEL440MX,
 	INTELICH2,
-	INTELICH3
+	INTELICH3,
+	SI7012
 };
 
 static char * card_names[] = {
@@ -228,7 +235,8 @@
 	"Intel ICH 82901AB",
 	"Intel 440MX",
 	"Intel ICH2",
-	"Intel ICH3"
+	"Intel ICH3",
+	"SiS 7012"
 };
 
 static struct pci_device_id i810_pci_tbl [] __initdata = {
@@ -242,6 +250,8 @@
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, INTELICH2},
 	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH3,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, INTELICH3},
+	{PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_7012,
+	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, SI7012},
 	{0,}
 };
 
@@ -666,22 +676,31 @@
 static inline unsigned i810_get_dma_addr(struct i810_state *state, int rec)
 {
 	struct dmabuf *dmabuf = &state->dmabuf;
+	struct i810_card *card = state->card;
 	unsigned int civ, offset;
-	struct i810_channel *c;
+	int port;
 	
 	if (!dmabuf->enable)
 		return 0;
+
+	port = card->iobase;
 	if (rec)
-		c = dmabuf->read_channel;
+		port += dmabuf->read_channel->port;
 	else
-		c = dmabuf->write_channel;
+		port += dmabuf->write_channel->port;
 	do {
-		civ = inb(state->card->iobase+c->port+OFF_CIV);
-		offset = (civ + 1) * dmabuf->fragsize -
-			      2 * inw(state->card->iobase+c->port+OFF_PICB);
+		civ = inb(port+OFF_CIV);
+		
+		/* picb and sr are swapped on SiS7012 */
+		if (card->pci_id == PCI_DEVICE_ID_SI_7012)
+			offset = (civ + 1) * dmabuf->fragsize -
+				inw(port+OFF_SR);
+		else
+			offset = (civ + 1) * dmabuf->fragsize -
+				2 * inw(port+OFF_PICB);
 		/* CIV changed before we read PICB (very seldom) ?
 		 * then PICB was rubbish, so try again */
-	} while (civ != inb(state->card->iobase+c->port+OFF_CIV));
+	} while (civ != inb(port+OFF_CIV));
 		 
 	return offset;
 }
@@ -758,7 +777,10 @@
 	// wait for the card to acknowledge shutdown
 	while( inb(card->iobase + PO_CR) != 0 ) ;
 	// now clear any latent interrupt bits (like the halt bit)
-	outb( inb(card->iobase + PO_SR), card->iobase + PO_SR );
+	if (card->pci_id == PCI_DEVICE_ID_SI_7012)
+		outb( inb(card->iobase + PO_PICB), card->iobase + PO_PICB );
+	else
+		outb( inb(card->iobase + PO_SR), card->iobase + PO_SR );
 	outl( inl(card->iobase + GLOB_STA) & INT_PO, card->iobase + GLOB_STA);
 }
 
@@ -922,6 +944,8 @@
 			sg->busaddr=virt_to_bus(dmabuf->rawbuf+dmabuf->fragsize*i);
 			// the card will always be doing 16bit stereo
 			sg->control=dmabuf->fragsamples;
+			if (state->card->pci_id == PCI_DEVICE_ID_SI_7012)
+				sg->control *= 2;
 			sg->control|=CON_BUFPAD;
 			// set us up to get IOC interrupts as often as needed to
 			// satisfy numfrag requirements, no more
@@ -961,9 +985,10 @@
 static void __i810_update_lvi(struct i810_state *state, int rec)
 {
 	struct dmabuf *dmabuf = &state->dmabuf;
-	int x, port;
+	struct i810_card *card = state->card;
+	int x, y, port;
 	
-	port = state->card->iobase;
+	port = card->iobase;
 	if(rec)
 		port += dmabuf->read_channel->port;
 	else
@@ -993,6 +1018,18 @@
 	/* swptr - 1 is the tail of our transfer */
 	x = (dmabuf->dmasize + dmabuf->swptr - 1) % dmabuf->dmasize;
 	x /= dmabuf->fragsize;
+	
+	/* We must not set the LVI to the same value as CIV if the 
+	 * ring buffer is full.  Unlike the i810 chipset, the SiS7012
+	 * chipset immediately assumes that the buffer is empty and
+	 * stops playing.
+	 */
+	if (!rec && card->pci_id == PCI_DEVICE_ID_SI_7012) {
+		y = (dmabuf->dmasize + dmabuf->hwptr) % dmabuf->dmasize;
+		y /= dmabuf->fragsize;
+		if (x == y) --x;
+	}
+
 	outb(x&31, port+OFF_LVI);
 }
 
@@ -1152,7 +1189,10 @@
 		
 		port+=c->port;
 		
-		status = inw(port + OFF_SR);
+		if (card->pci_id == PCI_DEVICE_ID_SI_7012)
+			status = inw(port + OFF_PICB);
+		else
+			status = inw(port + OFF_SR);
 #ifdef DEBUG_INTERRUPTS
 		printk("NUM %d PORT %X IRQ ( ST%d ", c->num, c->port, status);
 #endif
@@ -1188,7 +1228,10 @@
 #endif
 			}
 		}
-		outw(status & DMA_INT_MASK, port + OFF_SR);
+		if (card->pci_id == PCI_DEVICE_ID_SI_7012)
+			outw(status & DMA_INT_MASK, port + OFF_PICB);
+		else
+			outw(status & DMA_INT_MASK, port + OFF_SR);
 	}
 #ifdef DEBUG_INTERRUPTS
 	printk(")\n");

--BXVAT5kNtrzKuDFl--
