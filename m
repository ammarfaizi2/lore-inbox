Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286336AbSAAWtS>; Tue, 1 Jan 2002 17:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286331AbSAAWtK>; Tue, 1 Jan 2002 17:49:10 -0500
Received: from nfs1.infosys.tuwien.ac.at ([128.131.172.16]:28600 "EHLO
	infosys.tuwien.ac.at") by vger.kernel.org with ESMTP
	id <S286322AbSAAWtC>; Tue, 1 Jan 2002 17:49:02 -0500
Date: Tue, 1 Jan 2002 23:43:10 +0100
From: Thomas Gschwind <tom@infosys.tuwien.ac.at>
To: linux-kernel@vger.kernel.org
Cc: Doug Ledford <dledford@redhat.com>
Subject: [patch] i810 audio driver bugfix and SiS7012 support
Message-ID: <20020101234310.A26818@infosys.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UHN/qo2QbUvPLonB"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello *!

I have found a serious bug and a couple of smaller ones in the i810
audio driver (kernel version 2.4.17).  However, I found the bugs by
reading the source code and doing some experimentations with my
SiS7012 (an i810 clone) mainboard.  Hopefully, somebody using the i810
audio driver can confirm or deny the bugs below (especially the first
bug!).

I have also attached a patch that corrects these problems and adds
support for the SiS7012 (now, playback and recording!).  It applies to
linux/drivers/sound/i810_audio.c of a 2.4.17 kernel.  Any i810 or
SiS7012 owners, please tell me whether the patch works on your system
or whether it adds a different problem.  Please mail me directly since
I am not on the kernel mailing list.  THANKS!

The bugs:

* The first bug is that i810_read does not set the current state of
  the task to running and does not remove the wait queue if a signal
  occurs.  As a side effect the system _crashes_ at the next read.
  This is more serious since it allows any user with read access to
  /dev/dsp to crash the system.  Just try 
  $ sox -t ossdsp /dev/dsp x.wav 
  and press Ctrl-C (I used sox-12.17.1-4 on a RedHat-7.2 system).
  FIX: Replace return ret with goto done in a couple of places.

* A signed/unsigned comparison in i810_read
  (cnt>(dmabuf->dmasize-swptr)) that results in true if cnt<0.  This
  bug is everything but serious since it only prepends about 2/3s of
  silence to the recording.
  FIX: Reordering of cnt computation.

* Sometimes a DMA buffer overrun can occur in drain_dac.  This one
  only seems to be a spurious one.  Probably, the timing on a i810
  system is more perfect than on my K7S5A.  Anyway, it is cleaner to
  use interruptible_sleep_on_timeout than schedule_timeout to be less
  dependent on a perfect time.  Especially since the wait queue was
  already declared but never used.
  FIX: interruptible_sleep_on_timeout instead of schedule_timeout

* SNDCTL_DSP_GETISPACE returns the size of the DMA buffer minus
  the number of bytes in the buffer.  i810_read, however, only allows 
  the ring buffer to grow up to dmabuf->dmasize-dmabuf->fragsize.
  Hence, this IOCTL returns to many bytes.  [This was likely a mixup
  with SNDCTL_DSP_GETOSPACE]
  FIX: Subtract dmabuf->fragsize from the available bytes.

* SNDCTL_DSP_GETOSPACE returns dmabuf->fragsize to little bytes
  available since i810_write used the full DMA buffer.  Fortunately,
  this is not a real problem.  
  FIX: The SiS7012 chipset does not like the full DMA buffer to be
  used.  Hence, I changed i810_write to use only
  dmabuf->dmasize-dmabuf->fragsize bytes of the ring buffer.

Changes for SiS7012 support:

* SR and PICB registers are swapped.
  FIX: Added some ifs at various places.

* DMA transfer is counted in bytes and not in 16bit-words.
  FIX: Conditional * 2 in prog_dmabuf, Conditional / 2 in get_dma_address

Thomas

PS: The patch can also be found at
    http://www.infosys.tuwien.ac.at/Staff/tom/SiS7012/
-- 
Thomas Gschwind                      Email: tom@infosys.tuwien.ac.at
Technische Universit‰t Wien
Argentinierstraﬂe 8/E1841            Tel: +43 (1) 58801 ext. 18412
A-1040 Wien, Austria, Europe         Fax: +43 (1) 58801 ext. 18491

--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sis7012.patch-2"

--- i810_audio.c.orig	Fri Dec 28 01:41:26 2001
+++ i810_audio.c	Tue Jan  1 20:51:45 2002
@@ -2,6 +2,9 @@
  *	Intel i810 and friends ICH driver for Linux
  *	Alan Cox <alan@redhat.com>
  *
+ *	SiS7012 code by
+ *	Thomas Gschwind <tom@infosys.tuwien.ac.at>
+ *
  *  Built from:
  *	Low level code:  Zach Brown (original nonworking i810 OSS driver)
  *			 Jaroslav Kysela <perex@suse.cz> (working ALSA driver)
@@ -14,7 +17,7 @@
  *	Analog Devices (A major AC97 codec maker)
  *	Intel Corp  (you've probably heard of them already)
  *
- * AC97 clues and assistance provided by
+ *  AC97 clues and assistance provided by
  *	Analog Devices
  *	Zach 'Fufu' Brown
  *	Jeff Garzik
@@ -84,6 +87,7 @@
 #include <linux/smp_lock.h>
 #include <linux/ac97_codec.h>
 #include <linux/wrapper.h>
+#include <linux/compiler.h>
 #include <asm/uaccess.h>
 #include <asm/hardirq.h>
 
@@ -102,6 +106,9 @@
 #ifndef PCI_DEVICE_ID_INTEL_440MX
 #define PCI_DEVICE_ID_INTEL_440MX	0x7195
 #endif
+#ifndef PCI_DEVICE_ID_SI_7012
+#define PCI_DEVICE_ID_SI_7012	0x7012
+#endif
 
 static int ftsodell=0;
 static int strict_clocking=0;
@@ -197,7 +204,7 @@
 #define INT_MASK (INT_SEC|INT_PRI|INT_MC|INT_PO|INT_PI|INT_MO|INT_NI|INT_GPI)
 
 
-#define DRIVER_VERSION "0.04"
+#define DRIVER_VERSION "0.05"
 
 /* magic numbers to protect our data structures */
 #define I810_CARD_MAGIC		0x5072696E /* "Prin" */
@@ -220,7 +227,8 @@
 	ICH82901AB,
 	INTEL440MX,
 	INTELICH2,
-	INTELICH3
+	INTELICH3,
+	SI7012
 };
 
 static char * card_names[] = {
@@ -228,7 +236,8 @@
 	"Intel ICH 82901AB",
 	"Intel 440MX",
 	"Intel ICH2",
-	"Intel ICH3"
+	"Intel ICH3",
+	"SiS 7012"
 };
 
 static struct pci_device_id i810_pci_tbl [] __initdata = {
@@ -242,6 +251,8 @@
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, INTELICH2},
 	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH3,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, INTELICH3},
+	{PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_7012,
+	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, SI7012},
 	{0,}
 };
 
@@ -666,24 +677,37 @@
 static inline unsigned i810_get_dma_addr(struct i810_state *state, int rec)
 {
 	struct dmabuf *dmabuf = &state->dmabuf;
-	unsigned int civ, offset;
-	struct i810_channel *c;
+	struct i810_card *card = state->card;
+	unsigned int civ, picb, tries=2;
+	int port, port_picb;
 	
 	if (!dmabuf->enable)
 		return 0;
+
 	if (rec)
-		c = dmabuf->read_channel;
+		port = card->iobase + dmabuf->read_channel->port;
 	else
-		c = dmabuf->write_channel;
+		port = card->iobase + dmabuf->write_channel->port;
+
+	/* picb and sr are swapped on SiS7012 */
+	if (card->pci_id == PCI_DEVICE_ID_SI_7012)
+		port_picb = port + OFF_SR;
+	else
+		port_picb = port + OFF_PICB;
+
 	do {
-		civ = inb(state->card->iobase+c->port+OFF_CIV);
-		offset = (civ + 1) * dmabuf->fragsize -
-			      2 * inw(state->card->iobase+c->port+OFF_PICB);
+		civ = inb(port+OFF_CIV);
+		picb = inw(port_picb);
 		/* CIV changed before we read PICB (very seldom) ?
 		 * then PICB was rubbish, so try again */
-	} while (civ != inb(state->card->iobase+c->port+OFF_CIV));
-		 
-	return offset;
+	} while (unlikely(civ != inb(port+OFF_CIV) && --tries));
+	if (!tries) picb=0;
+
+	/* SiS7012 counts bytes, not samples */
+	if (card->pci_id == PCI_DEVICE_ID_SI_7012)
+		return (civ + 1) * dmabuf->fragsize - picb;
+	else
+		return (civ + 1) * dmabuf->fragsize - 2 * picb;
 }
 
 //static void resync_dma_ptrs(struct i810_state *state, int rec)
@@ -758,7 +782,10 @@
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
 
@@ -922,6 +949,8 @@
 			sg->busaddr=virt_to_bus(dmabuf->rawbuf+dmabuf->fragsize*i);
 			// the card will always be doing 16bit stereo
 			sg->control=dmabuf->fragsamples;
+			if (state->card->pci_id == PCI_DEVICE_ID_SI_7012)
+				sg->control *= 2;
 			sg->control|=CON_BUFPAD;
 			// set us up to get IOC interrupts as often as needed to
 			// satisfy numfrag requirements, no more
@@ -961,9 +990,10 @@
 static void __i810_update_lvi(struct i810_state *state, int rec)
 {
 	struct dmabuf *dmabuf = &state->dmabuf;
+	struct i810_card *card = state->card;
 	int x, port;
 	
-	port = state->card->iobase;
+	port = card->iobase;
 	if(rec)
 		port += dmabuf->read_channel->port;
 	else
@@ -1055,7 +1085,7 @@
 			if(inb(state->card->iobase + PO_CIV) !=
 			   inb(state->card->iobase + PO_LVI)) {
 				printk(KERN_WARNING "i810_audio: DMA overrun on write\n");
-				printk("i810_audio: CIV %d, LVI %d, hwptr %x, "
+				printk("i810_audio: CIV %d, LVI %d, hwptr %d, "
 					"count %d\n",
 					inb(state->card->iobase + PO_CIV),
 					inb(state->card->iobase + PO_LVI),
@@ -1106,9 +1136,8 @@
 			return -EBUSY;
 		}
 
-		tmo = (dmabuf->dmasize * HZ) / dmabuf->rate;
-		tmo >>= 1;
-		if (!schedule_timeout(tmo ? tmo : 1) && tmo){
+		tmo = (dmabuf->dmasize * HZ) / (dmabuf->rate * 4);
+		if (!interruptible_sleep_on_timeout(&dmabuf->wait, tmo)) {
 			printk(KERN_ERR "i810_audio: drain_dac, dma timeout?\n");
 			break;
 		}
@@ -1152,7 +1181,10 @@
 		
 		port+=c->port;
 		
-		status = inw(port + OFF_SR);
+		if(card->pci_id == PCI_DEVICE_ID_SI_7012)
+			status = inw(port + OFF_PICB);
+		else
+			status = inw(port + OFF_SR);
 #ifdef DEBUG_INTERRUPTS
 		printk("NUM %d PORT %X IRQ ( ST%d ", c->num, c->port, status);
 #endif
@@ -1188,7 +1220,10 @@
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
@@ -1270,18 +1305,18 @@
                         }
                         continue;
                 }
+
 		swptr = dmabuf->swptr;
 		if (dmabuf->count > dmabuf->dmasize) {
 			dmabuf->count = dmabuf->dmasize;
 		}
-		cnt = dmabuf->count - dmabuf->fragsize;
 		// this is to make the copy_to_user simpler below
-		if(cnt > (dmabuf->dmasize - swptr))
-			cnt = dmabuf->dmasize - swptr;
+		cnt = dmabuf->dmasize - swptr;
+		if(cnt > (dmabuf->count - dmabuf->fragsize))
+			cnt = dmabuf->count - dmabuf->fragsize;
+
 		spin_unlock_irqrestore(&card->lock, flags);
 
-		if (cnt > count)
-			cnt = count;
 		if (cnt <= 0) {
 			unsigned long tmo;
 			if(!dmabuf->enable) {
@@ -1291,11 +1326,10 @@
 			i810_update_lvi(state,1);
 			if (file->f_flags & O_NONBLOCK) {
 				if (!ret) ret = -EAGAIN;
-				return ret;
+				goto done;
 			}
 			/* This isnt strictly right for the 810  but it'll do */
-			tmo = (dmabuf->dmasize * HZ) / (dmabuf->rate * 2);
-			tmo >>= 1;
+			tmo = (dmabuf->dmasize * HZ) / (dmabuf->rate * 4);
 			/* There are two situations when sleep_on_timeout returns, one is when
 			   the interrupt is serviced correctly and the process is waked up by
 			   ISR ON TIME. Another is when timeout is expired, which means that
@@ -1315,11 +1349,13 @@
 			}
 			if (signal_pending(current)) {
 				ret = ret ? ret : -ERESTARTSYS;
-				return ret;
+				goto done;
 			}
 			continue;
 		}
 
+		if (cnt > count)
+			cnt = count;
 		if (copy_to_user(buffer, dmabuf->rawbuf + swptr, cnt)) {
 			if (!ret) ret = -EFAULT;
 			goto done;
@@ -1406,15 +1442,13 @@
 			dmabuf->count = 0;
 		}
 		cnt = dmabuf->dmasize - swptr;
-		if(cnt > (dmabuf->dmasize - dmabuf->count))
-			cnt = dmabuf->dmasize - dmabuf->count;
+		if(cnt > (dmabuf->dmasize - dmabuf->count - dmabuf->fragsize))
+			cnt = dmabuf->dmasize - dmabuf->count - dmabuf->fragsize;
 		spin_unlock_irqrestore(&state->card->lock, flags);
 
 #ifdef DEBUG2
 		printk(KERN_INFO "i810_audio: i810_write: %d bytes available space\n", cnt);
 #endif
-		if (cnt > count)
-			cnt = count;
 		if (cnt <= 0) {
 			unsigned long tmo;
 			// There is data waiting to be played
@@ -1455,6 +1489,9 @@
 			}
 			continue;
 		}
+
+		if (cnt > count)
+			cnt = count;
 		if (copy_from_user(dmabuf->rawbuf+swptr,buffer,cnt)) {
 			if (!ret) ret = -EFAULT;
 			goto ret;
@@ -1896,7 +1933,7 @@
 		i810_update_ptr(state);
 		abinfo.fragsize = dmabuf->userfragsize;
 		abinfo.fragstotal = dmabuf->userfrags;
-		abinfo.bytes = dmabuf->dmasize - dmabuf->count;
+		abinfo.bytes = dmabuf->dmasize - dmabuf->count - dmabuf->fragsize;
 		abinfo.fragments = abinfo.bytes / dmabuf->userfragsize;
 		spin_unlock_irqrestore(&state->card->lock, flags);
 #ifdef DEBUG

--UHN/qo2QbUvPLonB--
