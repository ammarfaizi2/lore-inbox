Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbTELGoj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 02:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbTELGoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 02:44:39 -0400
Received: from dp.samba.org ([66.70.73.150]:61856 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261960AbTELGnp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 02:43:45 -0400
Date: Mon, 12 May 2003 16:56:18 +1000
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org,
       Orinoco Development List <orinoco-devel@lists.sourceforge.net>
Subject: [PATCH] Update orinoco driver to 0.13e
Message-ID: <20030512065618.GA985@zax>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org,
	Orinoco Development List <orinoco-devel@lists.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply the patch below, which updates the orinoco driver
to 0.13e.  This fixes a whole slew of bugs, big and small, and addss a
few minor features, such as support for TMD7160 based PCI/PCMCIA
bridges.  The patch is against 2.5.69.

diff -uNr linux-2.5-pristine/drivers/net/wireless/Kconfig linux-orinoco/drivers/net/wireless/Kconfig
--- linux-2.5-pristine/drivers/net/wireless/Kconfig	2003-05-05 11:12:55.000000000 +1000
+++ linux-orinoco/drivers/net/wireless/Kconfig	2003-05-12 16:51:11.000000000 +1000
@@ -212,6 +212,19 @@
 	  Support for these adaptors is so far still incomplete and buggy.
 	  You have been warned.
 
+config TMD_HERMES
+	tristate "Hermes in TMD7160 based PCI adaptor support (EXPERIMENTAL)"
+	depends on PCI && HERMES && EXPERIMENTAL
+	help
+	  Enable support for PCMCIA cards supported by the "Hermes" (aka
+	  orinoco_cs) driver when used in TMD7160 based PCI adaptors.  These
+	  adaptors are not a full PCMCIA controller but act as a more limited
+	  PCI <-> PCMCIA bridge.  Several vendors sell such adaptors so that
+	  802.11b PCMCIA cards can be used in desktop machines.
+
+	  Support for these adaptors is so far still incomplete and buggy.
+	  You have been warned.
+
 config PCI_HERMES
 	tristate "Prism 2.5 PCI 802.11b adaptor support (EXPERIMENTAL)"
 	depends on PCI && HERMES && EXPERIMENTAL
diff -uNr linux-2.5-pristine/drivers/net/wireless/Makefile linux-orinoco/drivers/net/wireless/Makefile
--- linux-2.5-pristine/drivers/net/wireless/Makefile	2003-02-25 07:12:30.000000000 +1100
+++ linux-orinoco/drivers/net/wireless/Makefile	2003-05-12 16:51:41.000000000 +1000
@@ -14,6 +14,7 @@
 obj-$(CONFIG_PCMCIA_HERMES)	+= orinoco_cs.o
 obj-$(CONFIG_APPLE_AIRPORT)	+= airport.o
 obj-$(CONFIG_PLX_HERMES)	+= orinoco_plx.o
+obj-$(CONFIG_TMD_HERMES)	+= orinoco_tmd.o
 obj-$(CONFIG_PCI_HERMES)	+= orinoco_pci.o
 
 obj-$(CONFIG_AIRO)		+= airo.o
diff -uNr linux-2.5-pristine/drivers/net/wireless/airport.c linux-orinoco/drivers/net/wireless/airport.c
--- linux-2.5-pristine/drivers/net/wireless/airport.c	2003-02-25 07:12:30.000000000 +1100
+++ linux-orinoco/drivers/net/wireless/airport.c	2003-05-12 16:39:18.000000000 +1000
@@ -1,4 +1,4 @@
-/* airport.c 0.13a
+/* airport.c 0.13e
  *
  * A driver for "Hermes" chipset based Apple Airport wireless
  * card.
@@ -12,6 +12,7 @@
  */
 
 #include <linux/config.h>
+
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -20,7 +21,6 @@
 #include <linux/string.h>
 #include <linux/timer.h>
 #include <linux/ioport.h>
-#include <linux/proc_fs.h>
 #include <linux/netdevice.h>
 #include <linux/if_arp.h>
 #include <linux/etherdevice.h>
@@ -28,14 +28,13 @@
 #include <linux/adb.h>
 #include <linux/pmu.h>
 
+#include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/system.h>
-#include <asm/current.h>
 #include <asm/prom.h>
 #include <asm/machdep.h>
 #include <asm/pmac_feature.h>
 #include <asm/irq.h>
-#include <asm/uaccess.h>
 
 #include "orinoco.h"
 
@@ -95,7 +94,7 @@
 
 		netif_device_detach(dev);
 
-		priv->hw_unavailable = 1;
+		priv->hw_unavailable++;
 
 		orinoco_unlock(priv, &flags);
 
@@ -121,14 +120,15 @@
 
 		netif_device_attach(dev);
 
-		if (priv->open) {
+		priv->hw_unavailable--;
+
+		if (priv->open && (! priv->hw_unavailable)) {
 			err = __orinoco_up(dev);
 			if (err)
 				printk(KERN_ERR "%s: Error %d restarting card on PBOOK_WAKE\n",
 				       dev->name, err);
 		}
 
-		priv->hw_unavailable = 0;
 
 		spin_unlock_irqrestore(&priv->lock, flags);
 
@@ -138,6 +138,37 @@
 }
 #endif /* CONFIG_PMAC_PBOOK */
 
+static int airport_hard_reset(struct orinoco_private *priv)
+{
+	/* It would be nice to power cycle the Airport for a real hard
+	 * reset, but for some reason although it appears to
+	 * re-initialize properly, it falls in a screaming heap
+	 * shortly afterwards. */
+#if 0
+	struct net_device *dev = priv->ndev;
+	struct airport *card = priv->card;
+
+	/* Vitally important.  If we don't do this it seems we get an
+	 * interrupt somewhere during the power cycle, since
+	 * hw_unavailable is already set it doesn't get ACKed, we get
+	 * into an interrupt loop and the the PMU decides to turn us
+	 * off. */
+	disable_irq(dev->irq);
+
+	pmac_call_feature(PMAC_FTR_AIRPORT_ENABLE, card->node, 0, 0);
+	current->state = TASK_UNINTERRUPTIBLE;
+	schedule_timeout(HZ);
+	pmac_call_feature(PMAC_FTR_AIRPORT_ENABLE, card->node, 0, 1);
+	current->state = TASK_UNINTERRUPTIBLE;
+	schedule_timeout(HZ);
+
+	enable_irq(dev->irq);
+	schedule_timeout(HZ);
+#endif
+
+	return 0;
+}
+
 static struct net_device *
 airport_attach(struct device_node *of_node)
 {
@@ -153,7 +184,7 @@
 	}
 
 	/* Allocate space for private device-specific data */
-	dev = alloc_orinocodev(sizeof(*card), NULL);
+	dev = alloc_orinocodev(sizeof(*card), airport_hard_reset);
 	if (! dev) {
 		printk(KERN_ERR "airport: can't allocate device datas\n");
 		return NULL;
@@ -195,7 +226,7 @@
 	/* Reset it before we get the interrupt */
 	hermes_init(hw);
 
-	if (request_irq(dev->irq, orinoco_interrupt, 0, "Airport", (void *)priv)) {
+	if (request_irq(dev->irq, orinoco_interrupt, 0, "Airport", dev)) {
 		printk(KERN_ERR "airport: Couldn't get IRQ %d\n", dev->irq);
 		goto failed;
 	}
@@ -209,11 +240,6 @@
 	printk(KERN_DEBUG "airport: card registered for interface %s\n", dev->name);
 	card->ndev_registered = 1;
 
-	/* And give us the proc nodes for debugging */
-	if (orinoco_proc_dev_init(dev) != 0)
-		printk(KERN_ERR "airport: Failed to create /proc node for %s\n",
-		       dev->name);
-
 #ifdef CONFIG_PMAC_PBOOK
 	pmu_register_sleep_notifier(&airport_sleep_notifier);
 #endif
@@ -234,9 +260,6 @@
 	struct orinoco_private *priv = dev->priv;
 	struct airport *card = priv->card;
 
-	/* Unregister proc entry */
-	orinoco_proc_dev_cleanup(dev);
-
 #ifdef CONFIG_PMAC_PBOOK
 	pmu_unregister_sleep_notifier(&airport_sleep_notifier);
 #endif
@@ -245,7 +268,7 @@
 	card->ndev_registered = 0;
 
 	if (card->irq_requested)
-		free_irq(dev->irq, priv);
+		free_irq(dev->irq, dev);
 	card->irq_requested = 0;
 
 	if (card->vaddr)
@@ -263,7 +286,7 @@
 	kfree(dev);
 }				/* airport_detach */
 
-static char version[] __initdata = "airport.c 0.13a (Benjamin Herrenschmidt <benh@kernel.crashing.org>)";
+static char version[] __initdata = "airport.c 0.13e (Benjamin Herrenschmidt <benh@kernel.crashing.org>)";
 MODULE_AUTHOR("Benjamin Herrenschmidt <benh@kernel.crashing.org>");
 MODULE_DESCRIPTION("Driver for the Apple Airport wireless card.");
 MODULE_LICENSE("Dual MPL/GPL");
@@ -275,15 +298,11 @@
 
 	printk(KERN_DEBUG "%s\n", version);
 
-	MOD_INC_USE_COUNT;
-
 	/* Lookup card in device tree */
 	airport_node = find_devices("radio");
 	if (airport_node && !strcmp(airport_node->parent->name, "mac-io"))
 		airport_dev = airport_attach(airport_node);
 
-	MOD_DEC_USE_COUNT;
-
 	return airport_dev ? 0 : -ENODEV;
 }
 
diff -uNr linux-2.5-pristine/drivers/net/wireless/hermes.c linux-orinoco/drivers/net/wireless/hermes.c
--- linux-2.5-pristine/drivers/net/wireless/hermes.c	2002-11-05 16:59:51.000000000 +1100
+++ linux-orinoco/drivers/net/wireless/hermes.c	2003-05-12 16:39:18.000000000 +1000
@@ -52,7 +52,6 @@
 
 #include "hermes.h"
 
-static char version[] __initdata = "hermes.c: 4 Jul 2002 David Gibson <hermes@gibson.dropbear.id.au>";
 MODULE_DESCRIPTION("Low-level driver helper for Lucent Hermes chipset and Prism II HFA384x wireless MAC controller");
 MODULE_AUTHOR("David Gibson <hermes@gibson.dropbear.id.au>");
 #ifdef MODULE_LICENSE
@@ -226,7 +225,8 @@
  * Returns: < 0 on internal error, 0 on success, > 0 on error returned by the firmware
  *
  * Callable from any context, but locking is your problem. */
-int hermes_docmd_wait(hermes_t *hw, u16 cmd, u16 parm0, hermes_response_t *resp)
+int hermes_docmd_wait(hermes_t *hw, u16 cmd, u16 parm0,
+		      hermes_response_t *resp)
 {
 	int err;
 	int k;
@@ -402,7 +402,7 @@
  *
  * Returns: < 0 on internal failure (errno), 0 on success, > 0 on error from firmware
  */
-int hermes_bap_pread(hermes_t *hw, int bap, void *buf, int len,
+int hermes_bap_pread(hermes_t *hw, int bap, void *buf, unsigned len,
 		     u16 id, u16 offset)
 {
 	int dreg = bap ? HERMES_DATA1 : HERMES_DATA0;
@@ -428,7 +428,7 @@
  *
  * Returns: < 0 on internal failure (errno), 0 on success, > 0 on error from firmware
  */
-int hermes_bap_pwrite(hermes_t *hw, int bap, const void *buf, int len,
+int hermes_bap_pwrite(hermes_t *hw, int bap, const void *buf, unsigned len,
 		      u16 id, u16 offset)
 {
 	int dreg = bap ? HERMES_DATA1 : HERMES_DATA0;
@@ -456,26 +456,30 @@
  * practice.
  *
  * Callable from user or bh context.  */
-int hermes_read_ltv(hermes_t *hw, int bap, u16 rid, int bufsize,
+int hermes_read_ltv(hermes_t *hw, int bap, u16 rid, unsigned bufsize,
 		    u16 *length, void *buf)
 {
 	int err = 0;
 	int dreg = bap ? HERMES_DATA1 : HERMES_DATA0;
 	u16 rlength, rtype;
-	int nwords;
+	unsigned nwords;
 
 	if ( (bufsize < 0) || (bufsize % 2) )
 		return -EINVAL;
 
 	err = hermes_docmd_wait(hw, HERMES_CMD_ACCESS, rid, NULL);
 	if (err)
-		goto out;
+		return err;
 
 	err = hermes_bap_seek(hw, bap, rid, 0);
 	if (err)
-		goto out;
+		return err;
 
 	rlength = hermes_read_reg(hw, dreg);
+
+	if (! rlength)
+		return -ENOENT;
+
 	rtype = hermes_read_reg(hw, dreg);
 
 	if (length)
@@ -492,11 +496,10 @@
 		       IO_TYPE(hw), hw->iobase,
 		       HERMES_RECLEN_TO_BYTES(rlength), bufsize, rid, rlength);
 
-	nwords = min_t(int, rlength - 1, bufsize / 2);
+	nwords = min((unsigned)rlength - 1, bufsize / 2);
 	hermes_read_words(hw, dreg, buf, nwords);
 
- out:
-	return err;
+	return 0;
 }
 
 int hermes_write_ltv(hermes_t *hw, int bap, u16 rid, 
@@ -504,11 +507,14 @@
 {
 	int dreg = bap ? HERMES_DATA1 : HERMES_DATA0;
 	int err = 0;
-	int count;
-	
+	unsigned count;
+
+	if (length == 0)
+		return -EINVAL;
+
 	err = hermes_bap_seek(hw, bap, rid, 0);
 	if (err)
-		goto out;
+		return err;
 
 	hermes_write_reg(hw, dreg, length);
 	hermes_write_reg(hw, dreg, rid);
@@ -520,7 +526,6 @@
 	err = hermes_docmd_wait(hw, HERMES_CMD_ACCESS | HERMES_CMD_WRITE, 
 				rid, NULL);
 
- out:
 	return err;
 }
 
@@ -536,9 +541,12 @@
 
 static int __init init_hermes(void)
 {
-	printk(KERN_DEBUG "%s\n", version);
-
 	return 0;
 }
 
+static void __exit exit_hermes(void)
+{
+}
+
 module_init(init_hermes);
+module_exit(exit_hermes);
diff -uNr linux-2.5-pristine/drivers/net/wireless/hermes.h linux-orinoco/drivers/net/wireless/hermes.h
--- linux-2.5-pristine/drivers/net/wireless/hermes.h	2002-11-05 16:59:55.000000000 +1100
+++ linux-orinoco/drivers/net/wireless/hermes.h	2003-05-12 16:39:18.000000000 +1000
@@ -250,7 +250,6 @@
 	u16 scanreason;             /* ??? */
 	struct hermes_scan_apinfo aps[35];        /* Scan result */
 } __attribute__ ((packed));
-
 #define HERMES_LINKSTATUS_NOT_CONNECTED   (0x0000)  
 #define HERMES_LINKSTATUS_CONNECTED       (0x0001)
 #define HERMES_LINKSTATUS_DISCONNECTED    (0x0002)
@@ -278,7 +277,7 @@
 
 /* Basic control structure */
 typedef struct hermes {
-	ulong iobase;
+	unsigned long iobase;
 	int io_space; /* 1 if we IO-mapped IO, 0 for memory-mapped IO? */
 #define HERMES_IO	1
 #define HERMES_MEM	0
@@ -316,11 +315,11 @@
 int hermes_docmd_wait(hermes_t *hw, u16 cmd, u16 parm0, hermes_response_t *resp);
 int hermes_allocate(hermes_t *hw, u16 size, u16 *fid);
 
-int hermes_bap_pread(hermes_t *hw, int bap, void *buf, int len,
+int hermes_bap_pread(hermes_t *hw, int bap, void *buf, unsigned len,
 		       u16 id, u16 offset);
-int hermes_bap_pwrite(hermes_t *hw, int bap, const void *buf, int len,
+int hermes_bap_pwrite(hermes_t *hw, int bap, const void *buf, unsigned len,
 			u16 id, u16 offset);
-int hermes_read_ltv(hermes_t *hw, int bap, u16 rid, int buflen,
+int hermes_read_ltv(hermes_t *hw, int bap, u16 rid, unsigned buflen,
 		    u16 *length, void *buf);
 int hermes_write_ltv(hermes_t *hw, int bap, u16 rid,
 		      u16 length, const void *value);
@@ -361,42 +360,61 @@
 #define HERMES_RECLEN_TO_BYTES(n) ( ((n)-1) * 2 )
 
 /* Note that for the next two, the count is in 16-bit words, not bytes */
-static inline void hermes_read_words(struct hermes *hw, int off, void *buf, int count)
+static inline void hermes_read_words(struct hermes *hw, int off, void *buf, unsigned count)
 {
 	off = off << hw->reg_spacing;;
 
 	if (hw->io_space) {
 		insw(hw->iobase + off, buf, count);
 	} else {
-		int i;
+		unsigned i;
 		u16 *p;
 
-		/* This need to *not* byteswap (like insw()) but
-		 * readw() does byteswap hence the conversion */
+		/* This needs to *not* byteswap (like insw()) but
+		 * readw() does byteswap hence the conversion.  I hope
+		 * gcc is smart enough to fold away the two swaps on
+		 * big-endian platforms. */
 		for (i = 0, p = buf; i < count; i++) {
 			*p++ = cpu_to_le16(readw(hw->iobase + off));
 		}
 	}
 }
 
-static inline void hermes_write_words(struct hermes *hw, int off, const void *buf, int count)
+static inline void hermes_write_words(struct hermes *hw, int off, const void *buf, unsigned count)
 {
 	off = off << hw->reg_spacing;;
 
 	if (hw->io_space) {
 		outsw(hw->iobase + off, buf, count);
 	} else {
-		int i;
+		unsigned i;
 		const u16 *p;
 
-		/* This need to *not* byteswap (like outsw()) but
-		 * writew() does byteswap hence the conversion */
+		/* This needs to *not* byteswap (like outsw()) but
+		 * writew() does byteswap hence the conversion.  I
+		 * hope gcc is smart enough to fold away the two swaps
+		 * on big-endian platforms. */
 		for (i = 0, p = buf; i < count; i++) {
 			writew(le16_to_cpu(*p++), hw->iobase + off);
 		}
 	}
 }
 
+static inline void hermes_clear_words(struct hermes *hw, int off, unsigned count)
+{
+	unsigned i;
+
+	off = off << hw->reg_spacing;;
+
+	if (hw->io_space) {
+		for (i = 0; i < count; i++)
+			outw(0, hw->iobase + off);
+	} else {
+		for (i = 0; i < count; i++)
+			writew(0, hw->iobase + off);
+	}
+}
+
 #define HERMES_READ_RECORD(hw, bap, rid, buf) \
 	(hermes_read_ltv((hw),(bap),(rid), sizeof(*buf), NULL, (buf)))
 #define HERMES_WRITE_RECORD(hw, bap, rid, buf) \
diff -uNr linux-2.5-pristine/drivers/net/wireless/ieee802_11.h linux-orinoco/drivers/net/wireless/ieee802_11.h
--- linux-2.5-pristine/drivers/net/wireless/ieee802_11.h	2002-11-05 16:59:51.000000000 +1100
+++ linux-orinoco/drivers/net/wireless/ieee802_11.h	2003-05-12 16:39:18.000000000 +1000
@@ -2,9 +2,15 @@
 #define _IEEE802_11_H
 
 #define IEEE802_11_DATA_LEN		2304
-/* Actually, the standard seems to be inconsistent about what the
-   maximum frame size really is.  Section 6.2.1.1.2 says 2304 octets,
-   but the figure in Section 7.1.2 says 2312 octects. */
+/* Maximum size for the MA-UNITDATA primitive, 802.11 standard section
+   6.2.1.1.2.
+
+   The figure in section 7.1.2 suggests a body size of up to 2312
+   bytes is allowed, which is a bit confusing, I suspect this
+   represents the 2304 bytes of real data, plus a possible 8 bytes of
+   WEP IV and ICV. (this interpretation suggested by Ramiro Barreiro) */
+
+
 #define IEEE802_11_HLEN			30
 #define IEEE802_11_FRAME_LEN		(IEEE802_11_DATA_LEN + IEEE802_11_HLEN)
 
diff -uNr linux-2.5-pristine/drivers/net/wireless/orinoco.c linux-orinoco/drivers/net/wireless/orinoco.c
--- linux-2.5-pristine/drivers/net/wireless/orinoco.c	2003-05-05 11:12:55.000000000 +1000
+++ linux-orinoco/drivers/net/wireless/orinoco.c	2003-05-12 16:39:18.000000000 +1000
@@ -1,4 +1,4 @@
-/* orinoco.c 0.13a	- (formerly known as dldwd_cs.c and orinoco_cs.c)
+/* orinoco.c 0.13e	- (formerly known as dldwd_cs.c and orinoco_cs.c)
  *
  * A driver for Hermes or Prism 2 chipset based PCMCIA wireless
  * adaptors, with Lucent/Agere, Intersil or Symbol firmware.
@@ -323,7 +323,7 @@
  *	  the card from hard sleep.
  *
  * v0.13beta1 -> v0.13 - 27 Sep 2002 - David Gibson
- *	o Re-introduced full resets (via schedule_work()) on Tx
+ *	o Re-introduced full resets (via schedule_task()) on Tx
  *	  timeout.
  *
  * v0.13 -> v0.13a - 30 Sep 2002 - David Gibson
@@ -332,15 +332,70 @@
  *	o Include required kernel headers in orinoco.h, to avoid
  *	  compile problems.
  *
+ * v0.13a -> v0.13b - 10 Feb 2003 - David Gibson
+ *	o Implemented hard reset for Airport cards
+ *	o Experimental suspend/resume implementation for orinoco_pci
+ *	o Abolished /proc debugging support, replaced with a debugging
+ *	  iwpriv.  Now it's ugly and simple instead of ugly and complex.
+ *	o Bugfix in hermes.c if the firmware returned a record length
+ *	  of 0, we could go clobbering memory.
+ *	o Bugfix in orinoco_stop() - it used to fail if hw_unavailable
+ *	  was set, which was usually true on PCMCIA hot removes.
+ * 	o Track LINKSTATUS messages, silently drop Tx packets before
+ * 	  we are connected (avoids cofusing the firmware), and only
+ * 	  give LINKSTATUS printk()s if the status has changed.
+ *
+ * v0.13b -> v0.13c - 11 Mar 2003 - David Gibson
+ *	o Cleanup: use dev instead of priv in various places.
+ *	o Bug fix: Don't ReleaseConfiguration on RESET_PHYSICAL event
+ *	  if we're in the middle of a (driver initiated) hard reset.
+ *	o Bug fix: ETH_ZLEN is supposed to include the header
+ *	  (Dionysus Blazakis & Manish Karir)
+ *	o Convert to using workqueues instead of taskqueues (and
+ *	  backwards compatibility macros for pre 2.5.41 kernels).
+ *	o Drop redundant (I think...) MOD_{INC,DEC}_USE_COUNT in
+ *	  airport.c
+ *	o New orinoco_tmd.c init module from Joerg Dorchain for
+ *	  TMD7160 based PCI to PCMCIA bridges (similar to
+ *	  orinoco_plx.c).
+ *
+ * v0.13c -> v0.13d - 22 Apr 2003 - David Gibson
+ *	o Make hw_unavailable a counter, rather than just a flag, this
+ *	  is necessary to avoid some races (such as a card being
+ *	  removed in the middle of orinoco_reset().
+ *	o Restore Release/RequestConfiguration in the PCMCIA event handler
+ *	  when dealing with a driver initiated hard reset.  This is
+ *	  necessary to prevent hangs due to a spurious interrupt while
+ *	  the reset is in progress.
+ *	o Clear the 802.11 header when transmitting, even though we
+ *	  don't use it.  This fixes a long standing bug on some
+ *	  firmwares, which seem to get confused if that isn't done.
+ *	o Be less eager to de-encapsulate SNAP frames, only do so if
+ *	  the OUI is 00:00:00 or 00:00:f8, leave others alone.  The old
+ *	  behaviour broke CDP (Cisco Discovery Protocol).
+ *	o Use dev instead of priv for free_irq() as well as
+ *	  request_irq() (oops).
+ *	o Attempt to reset rather than giving up if we get too many
+ *	  IRQs.
+ *	o Changed semantics of __orinoco_down() so it can be called
+ *	  safely with hw_unavailable set.  It also now clears the
+ *	  linkstatus (since we're going to have to reassociate).
+ *
+ * v0.13d -> v0.13e - 12 May 2003 - David Gibson
+ *	o Support for post-2.5.68 return values from irq handler.
+ *	o Fixed bug where underlength packets would be double counted
+ *	  in the rx_dropped statistics.
+ *	o Provided a module parameter to suppress linkstatus messages.
+ *
  * TODO
- *	o New wireless extensions API (patch forthcoming from Moustafa
- *	  Youssef).
+ *	o New wireless extensions API (patch from Moustafa
+ *	  Youssef, updated by Jim Carter and Pavel Roskin).
  *	o Handle de-encapsulation within network layer, provide 802.11
  *	  headers (patch from Thomas 'Dent' Mirlacher)
+ *	o RF monitor mode support
  *	o Fix possible races in SPY handling.
  *	o Disconnect wireless extensions from fundamental configuration.
  *	o (maybe) Software WEP support (patch from Stano Meduna).
- *	o (maybe) Convert /proc debugging stuff to seqfile
  *	o (maybe) Use multiple Tx buffers - driver handling queue
  *	  rather than firmware. */
 
@@ -357,7 +412,9 @@
  * the middle of a hard reset).  This flag is protected by the
  * spinlock.  All code which touches the hardware should check the
  * flag after taking the lock, and if it is set, give up on whatever
- * they are doing and drop the lock again. */
+ * they are doing and drop the lock again.  The orinoco_lock()
+ * function handles this (it unlocks and returns -EBUSY if
+ * hw_unavailable is non-zero). */
 
 #include <linux/config.h>
 
@@ -369,12 +426,10 @@
 #include <linux/string.h>
 #include <linux/timer.h>
 #include <linux/ioport.h>
-#include <linux/proc_fs.h>
 #include <linux/netdevice.h>
 #include <linux/if_arp.h>
 #include <linux/etherdevice.h>
 #include <linux/wireless.h>
-#include <linux/workqueue.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -402,6 +457,9 @@
 EXPORT_SYMBOL(orinoco_debug);
 #endif
 
+static int suppress_linkstatus; /* = 0 */
+MODULE_PARM(suppress_linkstatus, "i");
+
 /********************************************************************/
 /* Compile time configuration and compatibility stuff               */
 /********************************************************************/
@@ -429,8 +487,10 @@
 #define USER_BAP		0
 #define IRQ_BAP			1
 #define MAX_IRQLOOPS_PER_IRQ	10
-#define MAX_IRQLOOPS_PER_JIFFY	(20000/HZ)	/* Based on a guestimate of how many events the
-						   device can legitimately generate */
+#define MAX_IRQLOOPS_PER_JIFFY	(20000/HZ) /* Based on a guestimate of
+					    * how many events the
+					    * device could
+					    * legitimately generate */
 #define SMALL_KEY_SIZE		5
 #define LARGE_KEY_SIZE		13
 #define TX_NICBUF_SIZE_BUG	1585		/* Bug in Symbol firmware */
@@ -456,7 +516,7 @@
 
 /* This tables gives the actual meanings of the bitrate IDs returned by the firmware. */
 struct {
-	int bitrate; /* in 100s of kilbits */
+	int bitrate; /* in 100s of kilobits */
 	int automatic;
 	u16 agere_txratectrl;
 	u16 intersil_txratectrl;
@@ -466,8 +526,8 @@
 	{10,  1,  1,  1},
 	{20,  0,  2,  2},
 	{20,  1,  6,  3},
-	{55, 0,  4,  4},
-	{55, 1,  7,  7},
+	{55,  0,  4,  4},
+	{55,  1,  7,  7},
 	{110, 0,  5,  8},
 };
 #define BITRATE_TABLE_SIZE (sizeof(bitrate_table) / sizeof(bitrate_table[0]))
@@ -508,7 +568,7 @@
 
 /* Hardware control routines */
 
-static int __orinoco_program_rids(struct orinoco_private *priv);
+static int __orinoco_program_rids(struct net_device *dev);
 
 static int __orinoco_hw_set_bitrate(struct orinoco_private *priv);
 static int __orinoco_hw_setup_wep(struct orinoco_private *priv);
@@ -521,39 +581,21 @@
 static void __orinoco_set_multicast_list(struct net_device *dev);
 
 /* Interrupt handling routines */
-static void __orinoco_ev_tick(struct orinoco_private *priv, hermes_t *hw);
-static void __orinoco_ev_wterr(struct orinoco_private *priv, hermes_t *hw);
-static void __orinoco_ev_infdrop(struct orinoco_private *priv, hermes_t *hw);
-static void __orinoco_ev_info(struct orinoco_private *priv, hermes_t *hw);
-static void __orinoco_ev_rx(struct orinoco_private *priv, hermes_t *hw);
-static void __orinoco_ev_txexc(struct orinoco_private *priv, hermes_t *hw);
-static void __orinoco_ev_tx(struct orinoco_private *priv, hermes_t *hw);
-static void __orinoco_ev_alloc(struct orinoco_private *priv, hermes_t *hw);
+static void __orinoco_ev_tick(struct net_device *dev, hermes_t *hw);
+static void __orinoco_ev_wterr(struct net_device *dev, hermes_t *hw);
+static void __orinoco_ev_infdrop(struct net_device *dev, hermes_t *hw);
+static void __orinoco_ev_info(struct net_device *dev, hermes_t *hw);
+static void __orinoco_ev_rx(struct net_device *dev, hermes_t *hw);
+static void __orinoco_ev_txexc(struct net_device *dev, hermes_t *hw);
+static void __orinoco_ev_tx(struct net_device *dev, hermes_t *hw);
+static void __orinoco_ev_alloc(struct net_device *dev, hermes_t *hw);
 
 /* ioctl() routines */
-static int orinoco_ioctl_getiwrange(struct net_device *dev, struct iw_point *rrq);
-static int orinoco_ioctl_setiwencode(struct net_device *dev, struct iw_point *erq);
-static int orinoco_ioctl_getiwencode(struct net_device *dev, struct iw_point *erq);
-static int orinoco_ioctl_setessid(struct net_device *dev, struct iw_point *erq);
-static int orinoco_ioctl_getessid(struct net_device *dev, struct iw_point *erq);
-static int orinoco_ioctl_setnick(struct net_device *dev, struct iw_point *nrq);
-static int orinoco_ioctl_getnick(struct net_device *dev, struct iw_point *nrq);
-static int orinoco_ioctl_setfreq(struct net_device *dev, struct iw_freq *frq);
-static int orinoco_ioctl_getsens(struct net_device *dev, struct iw_param *srq);
-static int orinoco_ioctl_setsens(struct net_device *dev, struct iw_param *srq);
-static int orinoco_ioctl_setrts(struct net_device *dev, struct iw_param *rrq);
-static int orinoco_ioctl_setfrag(struct net_device *dev, struct iw_param *frq);
-static int orinoco_ioctl_getfrag(struct net_device *dev, struct iw_param *frq);
-static int orinoco_ioctl_setrate(struct net_device *dev, struct iw_param *frq);
-static int orinoco_ioctl_getrate(struct net_device *dev, struct iw_param *frq);
-static int orinoco_ioctl_setpower(struct net_device *dev, struct iw_param *prq);
-static int orinoco_ioctl_getpower(struct net_device *dev, struct iw_param *prq);
-static int orinoco_ioctl_setport3(struct net_device *dev, struct iwreq *wrq);
-static int orinoco_ioctl_getport3(struct net_device *dev, struct iwreq *wrq);
-
-/* /proc debugging stuff */
-static int orinoco_proc_init(void);
-static void orinoco_proc_cleanup(void);
+static int orinoco_debug_dump_recs(struct net_device *dev);
+
+/********************************************************************/
+/* Function prototypes                                              */
+/********************************************************************/
 
 int __orinoco_up(struct net_device *dev)
 {
@@ -561,7 +603,7 @@
 	struct hermes *hw = &priv->hw;
 	int err;
 
-	err = __orinoco_program_rids(priv);
+	err = __orinoco_program_rids(dev);
 	if (err) {
 		printk(KERN_ERR "%s: Error %d configuring card\n",
 		       dev->name, err);
@@ -590,14 +632,25 @@
 
 	netif_stop_queue(dev);
 
-	err = hermes_disable_port(hw, 0);
-	if (err) {
-		printk(KERN_ERR "%s: Error %d disabling MAC port\n",
-		       dev->name, err);
-		return err;
+	if (! priv->hw_unavailable) {
+		if (! priv->broken_disableport) {
+			err = hermes_disable_port(hw, 0);
+			if (err) {
+				/* Some firmwares (e.g. Intersil 1.3.x) seem
+				 * to have problems disabling the port, oh
+				 * well, too bad. */
+				printk(KERN_WARNING "%s: Error %d disabling MAC port\n",
+				       dev->name, err);
+				priv->broken_disableport = 1;
+			}
+		}
+		hermes_set_irqmask(hw, 0);
+		hermes_write_regn(hw, EVACK, 0xffff);
 	}
-	hermes_set_irqmask(hw, 0);
-	hermes_write_regn(hw, EVACK, 0xffff);
+	
+	/* firmware will have to reassociate */
+	priv->last_linkstatus = 0xffff;
+	priv->connected = 0;
 
 	return 0;
 }
@@ -640,37 +693,38 @@
 	if (err)
 		return err;
 
-        priv->open = 1;
-
 	err = __orinoco_up(dev);
 
+	if (! err)
+		priv->open = 1;
+
 	orinoco_unlock(priv, &flags);
 
 	return err;
 }
 
-static int orinoco_stop(struct net_device *dev)
+int orinoco_stop(struct net_device *dev)
 {
 	struct orinoco_private *priv = dev->priv;
-	unsigned long flags;
-	int err;
+	int err = 0;
 
-	err = orinoco_lock(priv, &flags);
-	if (err)
-		return err;
+	/* We mustn't use orinoco_lock() here, because we need to be
+	   able to close the interface even if hw_unavailable is set
+	   (e.g. as we're released after a PC Card removal) */
+	spin_lock_irq(&priv->lock);
 
 	priv->open = 0;
 
 	err = __orinoco_down(dev);
 
-	orinoco_unlock(priv, &flags);
+	spin_unlock_irq(&priv->lock);
 
 	return err;
 }
 
-static int __orinoco_program_rids(struct orinoco_private *priv)
+static int __orinoco_program_rids(struct net_device *dev)
 {
-	struct net_device *dev = priv->ndev;
+	struct orinoco_private *priv = dev->priv;
 	hermes_t *hw = &priv->hw;
 	int err;
 	struct hermes_idstring idbuf;
@@ -856,33 +910,52 @@
 }
 
 /* xyzzy */
-static int orinoco_reconfigure(struct orinoco_private *priv)
+static int orinoco_reconfigure(struct net_device *dev)
 {
+	struct orinoco_private *priv = dev->priv;
 	struct hermes *hw = &priv->hw;
 	unsigned long flags;
 	int err = 0;
 
-	orinoco_lock(priv, &flags);
+	if (priv->broken_disableport) {
+		schedule_work(&priv->reset_work);
+		return 0;
+	}
+
+	err = orinoco_lock(priv, &flags);
+	if (err)
+		return err;
 
+		
 	err = hermes_disable_port(hw, 0);
 	if (err) {
-		printk(KERN_ERR "%s: Unable to disable port in orinco_reconfigure()\n",
-		       priv->ndev->name);
+		printk(KERN_WARNING "%s: Unable to disable port while reconfiguring card\n",
+		       dev->name);
+		priv->broken_disableport = 1;
 		goto out;
 	}
 
-	err = __orinoco_program_rids(priv);
-	if (err)
+	err = __orinoco_program_rids(dev);
+	if (err) {
+		printk(KERN_WARNING "%s: Unable to reconfigure card\n",
+		       dev->name);
 		goto out;
+	}
 
 	err = hermes_enable_port(hw, 0);
 	if (err) {
-		printk(KERN_ERR "%s: Unable to enable port in orinco_reconfigure()\n",
-		       priv->ndev->name);
+		printk(KERN_WARNING "%s: Unable to enable port while reconfiguring card\n",
+		       dev->name);
 		goto out;
 	}
 
  out:
+	if (err) {
+		printk(KERN_WARNING "%s: Resetting instead...\n", dev->name);
+		schedule_work(&priv->reset_work);
+		err = 0;
+	}
+
 	orinoco_unlock(priv, &flags);
 	return err;
 
@@ -893,16 +966,28 @@
 static void orinoco_reset(struct net_device *dev)
 {
 	struct orinoco_private *priv = dev->priv;
+	struct hermes *hw = &priv->hw;
 	int err;
 	unsigned long flags;
 
-	printk(KERN_INFO "%s: orinoco_reset()\n", dev->name);
-
 	err = orinoco_lock(priv, &flags);
 	if (err)
+		/* When the hardware becomes available again, whatever
+		 * detects that is responsible for re-initializing
+		 * it. So no need for anything further*/
 		return;
 
-	priv->hw_unavailable = 1;
+	netif_stop_queue(dev);
+
+	/* Shut off interrupts.  Depending on what state the hardware
+	 * is in, this might not work, but we'll try anyway */
+	hermes_set_irqmask(hw, 0);
+	hermes_write_regn(hw, EVACK, 0xffff);
+
+	priv->hw_unavailable++;
+	priv->last_linkstatus = 0xffff; /* firmware will have to reassociate */
+	priv->connected = 0;
+
 	orinoco_unlock(priv, &flags);
 
 	if (priv->hard_reset)
@@ -921,18 +1006,22 @@
 		return;
 	}
 
-	spin_lock_irqsave(&priv->lock, flags);
+	spin_lock_irq(&priv->lock); /* This has to be called from user context */
 
-	priv->hw_unavailable = 0;
+	priv->hw_unavailable--;
 
-	err = __orinoco_up(dev);
-	if (err) {
-		printk(KERN_ERR "%s: orinoco_reset: Error %d reenabling card\n",
-		       dev->name, err);
-	} else
-		dev->trans_start = jiffies;
+	/* priv->open or priv->hw_unavailable might have changed while
+	 * we dropped the lock */
+	if (priv->open && (! priv->hw_unavailable)) {
+		err = __orinoco_up(dev);
+		if (err) {
+			printk(KERN_ERR "%s: orinoco_reset: Error %d reenabling card\n",
+			       dev->name, err);
+		} else
+			dev->trans_start = jiffies;
+	}
 
-	orinoco_unlock(priv, &flags);
+	spin_unlock_irq(&priv->lock);
 
 	return;
 }
@@ -964,10 +1053,18 @@
 	}
 }
 
+/* Does the frame have a SNAP header indicating it should be
+ * de-encapsulated to Ethernet-II? */
 static inline int
-is_snap(struct header_struct *hdr)
+is_ethersnap(struct header_struct *hdr)
 {
-	return (hdr->dsap == 0xAA) && (hdr->ssap == 0xAA) && (hdr->ctrl == 0x3);
+	/* We de-encapsulate all packets which, a) have SNAP headers
+	 * (i.e. SSAP=DSAP=0xaa and CTRL=0x3 in the 802.2 LLC header
+	 * and where b) the OUI of the SNAP header is 00:00:00 or
+	 * 00:00:f8 - we need both because different APs appear to use
+	 * different OUIs for some reason */
+	return (memcmp(&hdr->dsap, &encaps_hdr, 5) == 0)
+		&& ( (hdr->oui[2] == 0x00) || (hdr->oui[2] == 0xf8) );
 }
 
 static void
@@ -1125,7 +1222,8 @@
 	return 0;
 }
 
-static int orinoco_hw_get_bssid(struct orinoco_private *priv, char buf[ETH_ALEN])
+static int orinoco_hw_get_bssid(struct orinoco_private *priv,
+				char buf[ETH_ALEN])
 {
 	hermes_t *hw = &priv->hw;
 	int err = 0;
@@ -1144,7 +1242,7 @@
 }
 
 static int orinoco_hw_get_essid(struct orinoco_private *priv, int *active,
-			      char buf[IW_ESSID_MAX_SIZE+1])
+				char buf[IW_ESSID_MAX_SIZE+1])
 {
 	hermes_t *hw = &priv->hw;
 	int err = 0;
@@ -1221,9 +1319,8 @@
 	}
 
 	if ( (channel < 1) || (channel > NUM_CHANNELS) ) {
-		struct net_device *dev = priv->ndev;
-
-		printk(KERN_WARNING "%s: Channel out of range (%d)!\n", dev->name, channel);
+		printk(KERN_WARNING "%s: Channel out of range (%d)!\n",
+		       priv->ndev->name, channel);
 		err = -EBUSY;
 		goto out;
 
@@ -1238,8 +1335,8 @@
 	return err ? err : freq;
 }
 
-static int orinoco_hw_get_bitratelist(struct orinoco_private *priv, int *numrates,
-				    s32 *rates, int max)
+static int orinoco_hw_get_bitratelist(struct orinoco_private *priv,
+				      int *numrates, s32 *rates, int max)
 {
 	hermes_t *hw = &priv->hw;
 	struct hermes_idstring list;
@@ -1272,9 +1369,6 @@
 }
 
 #if 0
-#ifndef ORINOCO_DEBUG
-static inline void show_rx_frame(struct orinoco_rxframe_hdr *frame) {}
-#else
 static void show_rx_frame(struct orinoco_rxframe_hdr *frame)
 {
 	printk(KERN_DEBUG "RX descriptor:\n");
@@ -1331,17 +1425,16 @@
 	       frame->p8022.oui[0], frame->p8022.oui[1], frame->p8022.oui[2]);
 	printk(KERN_DEBUG "  ethertype  = 0x%04x\n", frame->ethertype);
 }
-#endif
-#endif
+#endif /* 0 */
 
 /*
  * Interrupt handler
  */
 irqreturn_t orinoco_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
-	struct orinoco_private *priv = (struct orinoco_private *) dev_id;
+	struct net_device *dev = (struct net_device *)dev_id;
+	struct orinoco_private *priv = dev->priv;
 	hermes_t *hw = &priv->hw;
-	struct net_device *dev = priv->ndev;
 	int count = MAX_IRQLOOPS_PER_IRQ;
 	u16 evstat, events;
 	/* These are used to detect a runaway interrupt situation */
@@ -1352,12 +1445,17 @@
 	unsigned long flags;
 
 	if (orinoco_lock(priv, &flags) != 0) {
-		/* If hw is unavailable */
-		return IRQ_NONE;
+		/* If hw is unavailable - we don't know if the irq was
+		 * for us or not */
+		return IRQ_HANDLED;
 	}
 
 	evstat = hermes_read_regn(hw, EVSTAT);
 	events = evstat & hw->inten;
+	if (! events) {
+		orinoco_unlock(priv, &flags);
+		return IRQ_NONE;
+	}
 	
 	if (jiffies != last_irq_jiffy)
 		loops_this_jiffy = 0;
@@ -1365,11 +1463,11 @@
 
 	while (events && count--) {
 		if (++loops_this_jiffy > MAX_IRQLOOPS_PER_JIFFY) {
-			printk(KERN_CRIT "%s: IRQ handler is looping too \
-much! Shutting down.\n",
-			       dev->name);
-			/* Perform an emergency shutdown */
+			printk(KERN_WARNING "%s: IRQ handler is looping too "
+			       "much! Resetting.\n", dev->name);
+			/* Disable interrupts for now */
 			hermes_set_irqmask(hw, 0);
+			schedule_work(&priv->reset_work);
 			break;
 		}
 
@@ -1380,21 +1478,21 @@
 		}
 
 		if (events & HERMES_EV_TICK)
-			__orinoco_ev_tick(priv, hw);
+			__orinoco_ev_tick(dev, hw);
 		if (events & HERMES_EV_WTERR)
-			__orinoco_ev_wterr(priv, hw);
+			__orinoco_ev_wterr(dev, hw);
 		if (events & HERMES_EV_INFDROP)
-			__orinoco_ev_infdrop(priv, hw);
+			__orinoco_ev_infdrop(dev, hw);
 		if (events & HERMES_EV_INFO)
-			__orinoco_ev_info(priv, hw);
+			__orinoco_ev_info(dev, hw);
 		if (events & HERMES_EV_RX)
-			__orinoco_ev_rx(priv, hw);
+			__orinoco_ev_rx(dev, hw);
 		if (events & HERMES_EV_TXEXC)
-			__orinoco_ev_txexc(priv, hw);
+			__orinoco_ev_txexc(dev, hw);
 		if (events & HERMES_EV_TX)
-			__orinoco_ev_tx(priv, hw);
+			__orinoco_ev_tx(dev, hw);
 		if (events & HERMES_EV_ALLOC)
-			__orinoco_ev_alloc(priv, hw);
+			__orinoco_ev_alloc(dev, hw);
 		
 		hermes_write_regn(hw, EVACK, events);
 
@@ -1403,31 +1501,67 @@
 	};
 
 	orinoco_unlock(priv, &flags);
-
 	return IRQ_HANDLED;
 }
 
-static void __orinoco_ev_tick(struct orinoco_private *priv, hermes_t *hw)
+static void __orinoco_ev_tick(struct net_device *dev, hermes_t *hw)
 {
-	printk(KERN_DEBUG "%s: TICK\n", priv->ndev->name);
+	printk(KERN_DEBUG "%s: TICK\n", dev->name);
 }
 
-static void __orinoco_ev_wterr(struct orinoco_private *priv, hermes_t *hw)
+static void __orinoco_ev_wterr(struct net_device *dev, hermes_t *hw)
 {
 	/* This seems to happen a fair bit under load, but ignoring it
 	   seems to work fine...*/
 	printk(KERN_DEBUG "%s: MAC controller error (WTERR). Ignoring.\n",
-	       priv->ndev->name);
+	       dev->name);
 }
 
-static void __orinoco_ev_infdrop(struct orinoco_private *priv, hermes_t *hw)
+static void __orinoco_ev_infdrop(struct net_device *dev, hermes_t *hw)
 {
-	printk(KERN_WARNING "%s: Information frame lost.\n", priv->ndev->name);
+	printk(KERN_WARNING "%s: Information frame lost.\n", dev->name);
+}
+
+static void print_linkstatus(struct net_device *dev, u16 status)
+{
+	char * s;
+
+	if (suppress_linkstatus)
+		return;
+
+	switch (status) {
+	case HERMES_LINKSTATUS_NOT_CONNECTED:
+		s = "Not Connected";
+		break;
+	case HERMES_LINKSTATUS_CONNECTED:
+		s = "Connected";
+		break;
+	case HERMES_LINKSTATUS_DISCONNECTED:
+		s = "Disconnected";
+		break;
+	case HERMES_LINKSTATUS_AP_CHANGE:
+		s = "AP Changed";
+		break;
+	case HERMES_LINKSTATUS_AP_OUT_OF_RANGE:
+		s = "AP Out of Range";
+		break;
+	case HERMES_LINKSTATUS_AP_IN_RANGE:
+		s = "AP In Range";
+		break;
+	case HERMES_LINKSTATUS_ASSOC_FAILED:
+		s = "Association Failed";
+		break;
+	default:
+		s = "UNKNOWN";
+	}
+	
+	printk(KERN_INFO "%s: New link status: %s (%04x)\n",
+	       dev->name, s, status);
 }
 
-static void __orinoco_ev_info(struct orinoco_private *priv, hermes_t *hw)
+static void __orinoco_ev_info(struct net_device *dev, hermes_t *hw)
 {
-	struct net_device *dev = priv->ndev;
+	struct orinoco_private *priv = dev->priv;
 	u16 infofid;
 	struct {
 		u16 len;
@@ -1491,7 +1625,6 @@
 	case HERMES_INQ_LINKSTATUS: {
 		struct hermes_linkstatus linkstatus;
 		u16 newstatus;
-		const char *s;
 		
 		if (len != sizeof(linkstatus)) {
 			printk(KERN_WARNING "%s: Unexpected size for linkstatus frame (%d bytes)\n",
@@ -1503,34 +1636,20 @@
 				  len / 2);
 		newstatus = le16_to_cpu(linkstatus.linkstatus);
 
-		switch (newstatus) {
-		case HERMES_LINKSTATUS_NOT_CONNECTED:
-			s = "Not Connected";
-                       break;
-               case HERMES_LINKSTATUS_CONNECTED:
-		       s = "Connected";
-                       break;
-               case HERMES_LINKSTATUS_DISCONNECTED:
-		       s = "Disconnected";
-                       break;
-               case HERMES_LINKSTATUS_AP_CHANGE:
-		       s = "AP Changed";
-                       break;
-               case HERMES_LINKSTATUS_AP_OUT_OF_RANGE:
-		       s = "AP Out of Range";
-                       break;
-               case HERMES_LINKSTATUS_AP_IN_RANGE:
-		       s = "AP In Range";
-                       break;
-               case HERMES_LINKSTATUS_ASSOC_FAILED:
-		       s = "Association Failed";
-		       break;
-		default:
-			s = "UNKNOWN";
-		}
+		if ( (newstatus == HERMES_LINKSTATUS_CONNECTED)
+		     || (newstatus == HERMES_LINKSTATUS_AP_CHANGE)
+		     || (newstatus == HERMES_LINKSTATUS_AP_IN_RANGE) )
+			priv->connected = 1;
+		else if ( (newstatus == HERMES_LINKSTATUS_NOT_CONNECTED)
+			  || (newstatus == HERMES_LINKSTATUS_DISCONNECTED)
+			  || (newstatus == HERMES_LINKSTATUS_AP_OUT_OF_RANGE)
+			  || (newstatus == HERMES_LINKSTATUS_ASSOC_FAILED) )
+			priv->connected = 0;
+
+		if (newstatus != priv->last_linkstatus)
+			print_linkstatus(dev, newstatus);
 
-		printk(KERN_INFO "%s: New link status: %s (%04x)\n",
-		       dev->name, s, newstatus);
+		priv->last_linkstatus = newstatus;
 	}
 	break;
 	default:
@@ -1541,9 +1660,9 @@
 	}
 }
 
-static void __orinoco_ev_rx(struct orinoco_private *priv, hermes_t *hw)
+static void __orinoco_ev_rx(struct net_device *dev, hermes_t *hw)
 {
-	struct net_device *dev = priv->ndev;
+	struct orinoco_private *priv = dev->priv;
 	struct net_device_stats *stats = &priv->stats;
 	struct iw_statistics *wstats = &priv->wstats;
 	struct sk_buff *skb = NULL;
@@ -1632,14 +1751,13 @@
 	 * So, check ourselves */
 	if(((status & HERMES_RXSTAT_MSGTYPE) == HERMES_RXSTAT_1042) ||
 	   ((status & HERMES_RXSTAT_MSGTYPE) == HERMES_RXSTAT_TUNNEL) ||
-	   is_snap(&hdr)) {
+	   is_ethersnap(&hdr)) {
 		/* These indicate a SNAP within 802.2 LLC within
 		   802.11 frame which we'll need to de-encapsulate to
 		   the original EthernetII frame. */
 
 		if (length < ENCAPS_OVERHEAD) { /* No room for full LLC+SNAP */
 			stats->rx_length_errors++;
-			stats->rx_dropped++;
 			goto drop;
 		}
 
@@ -1694,9 +1812,9 @@
 	return;
 }
 
-static void __orinoco_ev_txexc(struct orinoco_private *priv, hermes_t *hw)
+static void __orinoco_ev_txexc(struct net_device *dev, hermes_t *hw)
 {
-	struct net_device *dev = priv->ndev;
+	struct orinoco_private *priv = dev->priv;
 	struct net_device_stats *stats = &priv->stats;
 	u16 fid = hermes_read_regn(hw, TXCOMPLFID);
 	struct hermes_tx_descriptor desc;
@@ -1720,8 +1838,9 @@
 	hermes_write_regn(hw, TXCOMPLFID, DUMMY_FID);
 }
 
-static void __orinoco_ev_tx(struct orinoco_private *priv, hermes_t *hw)
+static void __orinoco_ev_tx(struct net_device *dev, hermes_t *hw)
 {
+	struct orinoco_private *priv = dev->priv;
 	struct net_device_stats *stats = &priv->stats;
 
 	stats->tx_packets++;
@@ -1729,9 +1848,10 @@
 	hermes_write_regn(hw, TXCOMPLFID, DUMMY_FID);
 }
 
-static void __orinoco_ev_alloc(struct orinoco_private *priv, hermes_t *hw)
+static void __orinoco_ev_alloc(struct net_device *dev, hermes_t *hw)
 {
-	struct net_device *dev = priv->ndev;
+	struct orinoco_private *priv = dev->priv;
+
 	u16 fid = hermes_read_regn(hw, ALLOCFID);
 
 	if (fid != priv->txfid) {
@@ -1913,7 +2033,7 @@
 
 	TRACE_ENTER(dev->name);
 
-	/* No need to lock, the resetting flag is already set in
+	/* No need to lock, the hw_unavailable flag is already set in
 	 * alloc_orinocodev() */
 	priv->nicbuf_size = IEEE802_11_FRAME_LEN + ETH_HLEN;
 
@@ -2049,8 +2169,6 @@
 	priv->wep_on = 0;
 	priv->tx_key = 0;
 
-	priv->hw_unavailable = 0;
-
 	err = hermes_allocate(hw, priv->nicbuf_size, &priv->txfid);
 	if (err == -EIO) {
 		/* Try workaround for old Symbol firmware bug */
@@ -2070,6 +2188,12 @@
 		goto out;
 	}
 
+	/* Make the hardware available, as long as it hasn't been
+	 * removed elsewhere (e.g. by PCMCIA hot unplug) */
+	spin_lock_irq(&priv->lock);
+	priv->hw_unavailable--;
+	spin_unlock_irq(&priv->lock);
+
 	printk(KERN_DEBUG "%s: ready\n", dev->name);
 
  out:
@@ -2222,9 +2346,20 @@
 		return 1;
 	}
 
+	if (! priv->connected) {
+		/* Oops, the firmware hasn't established a connection,
+                   silently drop the packet (this seems to be the
+                   safest approach). */
+		stats->tx_errors++;
+		orinoco_unlock(priv, &flags);
+		dev_kfree_skb(skb);
+		TRACE_EXIT(dev->name);
+		return 0;
+	}
+
 	/* Length of the packet body */
 	/* FIXME: what if the skb is smaller than this? */
-	len = max_t(int,skb->len - ETH_HLEN, ETH_ZLEN);
+	len = max_t(int,skb->len - ETH_HLEN, ETH_ZLEN - ETH_HLEN);
 
 	eh = (struct ethhdr *)skb->data;
 
@@ -2238,6 +2373,12 @@
 		goto fail;
 	}
 
+	/* Clear the 802.11 header and data length fields - some
+	 * firmwares (e.g. Lucent/Agere 8.xx) appear to get confused
+	 * if this isn't done. */
+	hermes_clear_words(hw, HERMES_DATA0,
+			   HERMES_802_3_OFFSET - HERMES_802_11_OFFSET);
+
 	/* Encapsulate Ethernet-II frames */
 	if (ntohs(eh->h_proto) > 1500) { /* Ethernet-II frame */
 		struct header_struct hdr;
@@ -2319,7 +2460,7 @@
 
 	stats->tx_errors++;
 
-	schedule_work(&priv->timeout_task);
+	schedule_work(&priv->reset_work);
 }
 
 static int
@@ -2489,7 +2630,7 @@
 	}
 
 	err = orinoco_hw_get_bitratelist(priv, &numrates,
-				       range.bitrate, IW_MAX_BITRATES);
+					 range.bitrate, IW_MAX_BITRATES);
 	if (err)
 		return err;
 	range.num_bitrates = numrates;
@@ -2756,7 +2897,7 @@
 	erq->flags = 1;
 	erq->length = strlen(essidbuf) + 1;
 	if (erq->pointer)
-		if ( copy_to_user(erq->pointer, essidbuf, erq->length) )
+		if (copy_to_user(erq->pointer, essidbuf, erq->length))
 			return -EFAULT;
 
 	TRACE_EXIT(dev->name);
@@ -3085,7 +3226,7 @@
 				rrq->value = 5500000;
 			else
 				rrq->value = val * 1000000;
-                        break;
+			break;
 		case FIRMWARE_TYPE_INTERSIL: /* Intersil style rate */
 		case FIRMWARE_TYPE_SYMBOL: /* Symbol style rate */
 			for (i = 0; i < BITRATE_TABLE_SIZE; i++)
@@ -3688,7 +3829,8 @@
 				  0, "set_ibssport" },
 				{ SIOCIWFIRSTPRIV + 0x7, 0,
 				  IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1,
-				  "get_ibssport" }
+				  "get_ibssport" },
+				{ SIOCIWLASTPRIV, 0, 0, "dump_recs" },
 			};
 
 			err = verify_area(VERIFY_WRITE, wrq->u.data.pointer, sizeof(privtab));
@@ -3710,7 +3852,7 @@
 		
 		printk(KERN_DEBUG "%s: Force scheduling reset!\n", dev->name);
 
-		schedule_work(&priv->timeout_task);
+		schedule_work(&priv->reset_work);
 		break;
 
 	case SIOCIWFIRSTPRIV + 0x2: /* set_port3 */
@@ -3782,13 +3924,20 @@
 		err = orinoco_ioctl_getibssport(dev, wrq);
 		break;
 
+	case SIOCIWLASTPRIV:
+		err = orinoco_debug_dump_recs(dev);
+		if (err)
+			printk(KERN_ERR "%s: Unable to dump records (%d)\n",
+			       dev->name, err);
+		break;
+
 
 	default:
 		err = -EOPNOTSUPP;
 	}
 	
 	if (! err && changed && netif_running(dev)) {
-		err = orinoco_reconfigure(priv);
+		err = orinoco_reconfigure(dev);
 	}		
 
 	TRACE_EXIT(dev->name);
@@ -3796,81 +3945,6 @@
 	return err;
 }
 
-/********************************************************************/
-/* procfs stuff                                                     */
-/********************************************************************/
-
-static struct proc_dir_entry *dir_base = NULL;
-
-#define PROC_LTV_SIZE		128
-
-/*
- * This function updates the total amount of data printed so far. It then
- * determines if the amount of data printed into a buffer  has reached the
- * offset requested. If it hasn't, then the buffer is shifted over so that
- * the next bit of data can be printed over the old bit. If the total
- * amount printed so far exceeds the total amount requested, then this
- * function returns 1, otherwise 0.
- */
-static int 
-shift_buffer(char *buffer, int requested_offset, int requested_len,
-	     int *total, int *slop, char **buf)
-{
-	int printed;
-	
-	printed = *buf - buffer;
-	if (*total + printed <= requested_offset) {
-		*total += printed;
-		*buf = buffer;
-	}
-	else {
-		if (*total < requested_offset) {
-			*slop = requested_offset - *total;
-		}
-		*total = requested_offset + printed - *slop;
-	}
-	if (*total > requested_offset + requested_len) {
-		return 1;
-	}
-	else {
-		return 0;
-	}
-}
-
-/*
- * This function calculates the actual start of the requested data
- * in the buffer. It also calculates actual length of data returned,
- * which could be less that the amount of data requested.
- */
-#define PROC_BUFFER_SIZE 4096
-#define PROC_SAFE_SIZE 3072
-
-static int
-calc_start_len(char *buffer, char **start, int requested_offset,
-	       int requested_len, int total, char *buf)
-{
-	int return_len, buffer_len;
-	
-	buffer_len = buf - buffer;
-	if (buffer_len >= PROC_BUFFER_SIZE - 1) {
-		printk(KERN_ERR "calc_start_len: exceeded /proc buffer size\n");
-	}
-	
-	/*
-	 * There may be bytes before and after the
-	 * chunk that was actually requested.
-	 */
-	return_len = total - requested_offset;
-	if (return_len < 0) {
-		return_len = 0;
-	}
-	*start = buf - return_len;
-	if (return_len > requested_len) {
-		return_len = requested_len;
-	}
-	return return_len;
-}
-
 struct {
 	u16 rid;
 	char *name;
@@ -3880,140 +3954,135 @@
 #define DISPLAY_STRING	2
 #define DISPLAY_XSTRING	3
 } record_table[] = {
-#define PROC_REC(name,type) { HERMES_RID_##name, #name, DISPLAY_##type }
-	PROC_REC(CNFPORTTYPE,WORDS),
-	PROC_REC(CNFOWNMACADDR,BYTES),
-	PROC_REC(CNFDESIREDSSID,STRING),
-	PROC_REC(CNFOWNCHANNEL,WORDS),
-	PROC_REC(CNFOWNSSID,STRING),
-	PROC_REC(CNFOWNATIMWINDOW,WORDS),
-	PROC_REC(CNFSYSTEMSCALE,WORDS),
-	PROC_REC(CNFMAXDATALEN,WORDS),
-	PROC_REC(CNFPMENABLED,WORDS),
-	PROC_REC(CNFPMEPS,WORDS),
-	PROC_REC(CNFMULTICASTRECEIVE,WORDS),
-	PROC_REC(CNFMAXSLEEPDURATION,WORDS),
-	PROC_REC(CNFPMHOLDOVERDURATION,WORDS),
-	PROC_REC(CNFOWNNAME,STRING),
-	PROC_REC(CNFOWNDTIMPERIOD,WORDS),
-	PROC_REC(CNFMULTICASTPMBUFFERING,WORDS),
-	PROC_REC(CNFWEPENABLED_AGERE,WORDS),
-	PROC_REC(CNFMANDATORYBSSID_SYMBOL,WORDS),
-	PROC_REC(CNFWEPDEFAULTKEYID,WORDS),
-	PROC_REC(CNFDEFAULTKEY0,BYTES),
-	PROC_REC(CNFDEFAULTKEY1,BYTES),
-	PROC_REC(CNFMWOROBUST_AGERE,WORDS),
-	PROC_REC(CNFDEFAULTKEY2,BYTES),
-	PROC_REC(CNFDEFAULTKEY3,BYTES),
-	PROC_REC(CNFWEPFLAGS_INTERSIL,WORDS),
-	PROC_REC(CNFWEPKEYMAPPINGTABLE,WORDS),
-	PROC_REC(CNFAUTHENTICATION,WORDS),
-	PROC_REC(CNFMAXASSOCSTA,WORDS),
-	PROC_REC(CNFKEYLENGTH_SYMBOL,WORDS),
-	PROC_REC(CNFTXCONTROL,WORDS),
-	PROC_REC(CNFROAMINGMODE,WORDS),
-	PROC_REC(CNFHOSTAUTHENTICATION,WORDS),
-	PROC_REC(CNFRCVCRCERROR,WORDS),
-	PROC_REC(CNFMMLIFE,WORDS),
-	PROC_REC(CNFALTRETRYCOUNT,WORDS),
-	PROC_REC(CNFBEACONINT,WORDS),
-	PROC_REC(CNFAPPCFINFO,WORDS),
-	PROC_REC(CNFSTAPCFINFO,WORDS),
-	PROC_REC(CNFPRIORITYQUSAGE,WORDS),
-	PROC_REC(CNFTIMCTRL,WORDS),
-	PROC_REC(CNFTHIRTY2TALLY,WORDS),
-	PROC_REC(CNFENHSECURITY,WORDS),
-	PROC_REC(CNFGROUPADDRESSES,BYTES),
-	PROC_REC(CNFCREATEIBSS,WORDS),
-	PROC_REC(CNFFRAGMENTATIONTHRESHOLD,WORDS),
-	PROC_REC(CNFRTSTHRESHOLD,WORDS),
-	PROC_REC(CNFTXRATECONTROL,WORDS),
-	PROC_REC(CNFPROMISCUOUSMODE,WORDS),
-	PROC_REC(CNFBASICRATES_SYMBOL,WORDS),
-	PROC_REC(CNFPREAMBLE_SYMBOL,WORDS),
-	PROC_REC(CNFSHORTPREAMBLE,WORDS),
-	PROC_REC(CNFWEPKEYS_AGERE,BYTES),
-	PROC_REC(CNFEXCLUDELONGPREAMBLE,WORDS),
-	PROC_REC(CNFTXKEY_AGERE,WORDS),
-	PROC_REC(CNFAUTHENTICATIONRSPTO,WORDS),
-	PROC_REC(CNFBASICRATES,WORDS),
-	PROC_REC(CNFSUPPORTEDRATES,WORDS),
-	PROC_REC(CNFTICKTIME,WORDS),
-	PROC_REC(CNFSCANREQUEST,WORDS),
-	PROC_REC(CNFJOINREQUEST,WORDS),
-	PROC_REC(CNFAUTHENTICATESTATION,WORDS),
-	PROC_REC(CNFCHANNELINFOREQUEST,WORDS),
-	PROC_REC(MAXLOADTIME,WORDS),
-	PROC_REC(DOWNLOADBUFFER,WORDS),
-	PROC_REC(PRIID,WORDS),
-	PROC_REC(PRISUPRANGE,WORDS),
-	PROC_REC(CFIACTRANGES,WORDS),
-	PROC_REC(NICSERNUM,WORDS),
-	PROC_REC(NICID,WORDS),
-	PROC_REC(MFISUPRANGE,WORDS),
-	PROC_REC(CFISUPRANGE,WORDS),
-	PROC_REC(CHANNELLIST,WORDS),
-	PROC_REC(REGULATORYDOMAINS,WORDS),
-	PROC_REC(TEMPTYPE,WORDS),
-/*  	PROC_REC(CIS,BYTES), */
-	PROC_REC(STAID,WORDS),
-	PROC_REC(CURRENTSSID,STRING),
-	PROC_REC(CURRENTBSSID,BYTES),
-	PROC_REC(COMMSQUALITY,WORDS),
-	PROC_REC(CURRENTTXRATE,WORDS),
-	PROC_REC(CURRENTBEACONINTERVAL,WORDS),
-	PROC_REC(CURRENTSCALETHRESHOLDS,WORDS),
-	PROC_REC(PROTOCOLRSPTIME,WORDS),
-	PROC_REC(SHORTRETRYLIMIT,WORDS),
-	PROC_REC(LONGRETRYLIMIT,WORDS),
-	PROC_REC(MAXTRANSMITLIFETIME,WORDS),
-	PROC_REC(MAXRECEIVELIFETIME,WORDS),
-	PROC_REC(CFPOLLABLE,WORDS),
-	PROC_REC(AUTHENTICATIONALGORITHMS,WORDS),
-	PROC_REC(PRIVACYOPTIONIMPLEMENTED,WORDS),
-	PROC_REC(OWNMACADDR,BYTES),
-	PROC_REC(SCANRESULTSTABLE,WORDS),
-	PROC_REC(PHYTYPE,WORDS),
-	PROC_REC(CURRENTCHANNEL,WORDS),
-	PROC_REC(CURRENTPOWERSTATE,WORDS),
-	PROC_REC(CCAMODE,WORDS),
-	PROC_REC(SUPPORTEDDATARATES,WORDS),
-	PROC_REC(BUILDSEQ,BYTES),
-	PROC_REC(FWID,XSTRING)
-#undef PROC_REC
+#define DEBUG_REC(name,type) { HERMES_RID_##name, #name, DISPLAY_##type }
+	DEBUG_REC(CNFPORTTYPE,WORDS),
+	DEBUG_REC(CNFOWNMACADDR,BYTES),
+	DEBUG_REC(CNFDESIREDSSID,STRING),
+	DEBUG_REC(CNFOWNCHANNEL,WORDS),
+	DEBUG_REC(CNFOWNSSID,STRING),
+	DEBUG_REC(CNFOWNATIMWINDOW,WORDS),
+	DEBUG_REC(CNFSYSTEMSCALE,WORDS),
+	DEBUG_REC(CNFMAXDATALEN,WORDS),
+	DEBUG_REC(CNFPMENABLED,WORDS),
+	DEBUG_REC(CNFPMEPS,WORDS),
+	DEBUG_REC(CNFMULTICASTRECEIVE,WORDS),
+	DEBUG_REC(CNFMAXSLEEPDURATION,WORDS),
+	DEBUG_REC(CNFPMHOLDOVERDURATION,WORDS),
+	DEBUG_REC(CNFOWNNAME,STRING),
+	DEBUG_REC(CNFOWNDTIMPERIOD,WORDS),
+	DEBUG_REC(CNFMULTICASTPMBUFFERING,WORDS),
+	DEBUG_REC(CNFWEPENABLED_AGERE,WORDS),
+	DEBUG_REC(CNFMANDATORYBSSID_SYMBOL,WORDS),
+	DEBUG_REC(CNFWEPDEFAULTKEYID,WORDS),
+	DEBUG_REC(CNFDEFAULTKEY0,BYTES),
+	DEBUG_REC(CNFDEFAULTKEY1,BYTES),
+	DEBUG_REC(CNFMWOROBUST_AGERE,WORDS),
+	DEBUG_REC(CNFDEFAULTKEY2,BYTES),
+	DEBUG_REC(CNFDEFAULTKEY3,BYTES),
+	DEBUG_REC(CNFWEPFLAGS_INTERSIL,WORDS),
+	DEBUG_REC(CNFWEPKEYMAPPINGTABLE,WORDS),
+	DEBUG_REC(CNFAUTHENTICATION,WORDS),
+	DEBUG_REC(CNFMAXASSOCSTA,WORDS),
+	DEBUG_REC(CNFKEYLENGTH_SYMBOL,WORDS),
+	DEBUG_REC(CNFTXCONTROL,WORDS),
+	DEBUG_REC(CNFROAMINGMODE,WORDS),
+	DEBUG_REC(CNFHOSTAUTHENTICATION,WORDS),
+	DEBUG_REC(CNFRCVCRCERROR,WORDS),
+	DEBUG_REC(CNFMMLIFE,WORDS),
+	DEBUG_REC(CNFALTRETRYCOUNT,WORDS),
+	DEBUG_REC(CNFBEACONINT,WORDS),
+	DEBUG_REC(CNFAPPCFINFO,WORDS),
+	DEBUG_REC(CNFSTAPCFINFO,WORDS),
+	DEBUG_REC(CNFPRIORITYQUSAGE,WORDS),
+	DEBUG_REC(CNFTIMCTRL,WORDS),
+	DEBUG_REC(CNFTHIRTY2TALLY,WORDS),
+	DEBUG_REC(CNFENHSECURITY,WORDS),
+	DEBUG_REC(CNFGROUPADDRESSES,BYTES),
+	DEBUG_REC(CNFCREATEIBSS,WORDS),
+	DEBUG_REC(CNFFRAGMENTATIONTHRESHOLD,WORDS),
+	DEBUG_REC(CNFRTSTHRESHOLD,WORDS),
+	DEBUG_REC(CNFTXRATECONTROL,WORDS),
+	DEBUG_REC(CNFPROMISCUOUSMODE,WORDS),
+	DEBUG_REC(CNFBASICRATES_SYMBOL,WORDS),
+	DEBUG_REC(CNFPREAMBLE_SYMBOL,WORDS),
+	DEBUG_REC(CNFSHORTPREAMBLE,WORDS),
+	DEBUG_REC(CNFWEPKEYS_AGERE,BYTES),
+	DEBUG_REC(CNFEXCLUDELONGPREAMBLE,WORDS),
+	DEBUG_REC(CNFTXKEY_AGERE,WORDS),
+	DEBUG_REC(CNFAUTHENTICATIONRSPTO,WORDS),
+	DEBUG_REC(CNFBASICRATES,WORDS),
+	DEBUG_REC(CNFSUPPORTEDRATES,WORDS),
+	DEBUG_REC(CNFTICKTIME,WORDS),
+	DEBUG_REC(CNFSCANREQUEST,WORDS),
+	DEBUG_REC(CNFJOINREQUEST,WORDS),
+	DEBUG_REC(CNFAUTHENTICATESTATION,WORDS),
+	DEBUG_REC(CNFCHANNELINFOREQUEST,WORDS),
+	DEBUG_REC(MAXLOADTIME,WORDS),
+	DEBUG_REC(DOWNLOADBUFFER,WORDS),
+	DEBUG_REC(PRIID,WORDS),
+	DEBUG_REC(PRISUPRANGE,WORDS),
+	DEBUG_REC(CFIACTRANGES,WORDS),
+	DEBUG_REC(NICSERNUM,XSTRING),
+	DEBUG_REC(NICID,WORDS),
+	DEBUG_REC(MFISUPRANGE,WORDS),
+	DEBUG_REC(CFISUPRANGE,WORDS),
+	DEBUG_REC(CHANNELLIST,WORDS),
+	DEBUG_REC(REGULATORYDOMAINS,WORDS),
+	DEBUG_REC(TEMPTYPE,WORDS),
+/*  	DEBUG_REC(CIS,BYTES), */
+	DEBUG_REC(STAID,WORDS),
+	DEBUG_REC(CURRENTSSID,STRING),
+	DEBUG_REC(CURRENTBSSID,BYTES),
+	DEBUG_REC(COMMSQUALITY,WORDS),
+	DEBUG_REC(CURRENTTXRATE,WORDS),
+	DEBUG_REC(CURRENTBEACONINTERVAL,WORDS),
+	DEBUG_REC(CURRENTSCALETHRESHOLDS,WORDS),
+	DEBUG_REC(PROTOCOLRSPTIME,WORDS),
+	DEBUG_REC(SHORTRETRYLIMIT,WORDS),
+	DEBUG_REC(LONGRETRYLIMIT,WORDS),
+	DEBUG_REC(MAXTRANSMITLIFETIME,WORDS),
+	DEBUG_REC(MAXRECEIVELIFETIME,WORDS),
+	DEBUG_REC(CFPOLLABLE,WORDS),
+	DEBUG_REC(AUTHENTICATIONALGORITHMS,WORDS),
+	DEBUG_REC(PRIVACYOPTIONIMPLEMENTED,WORDS),
+	DEBUG_REC(OWNMACADDR,BYTES),
+	DEBUG_REC(SCANRESULTSTABLE,WORDS),
+	DEBUG_REC(PHYTYPE,WORDS),
+	DEBUG_REC(CURRENTCHANNEL,WORDS),
+	DEBUG_REC(CURRENTPOWERSTATE,WORDS),
+	DEBUG_REC(CCAMODE,WORDS),
+	DEBUG_REC(SUPPORTEDDATARATES,WORDS),
+	DEBUG_REC(BUILDSEQ,BYTES),
+	DEBUG_REC(FWID,XSTRING)
+#undef DEBUG_REC
 };
-#define NUM_RIDS ( sizeof(record_table) / sizeof(record_table[0]) )
 
-static int
-orinoco_proc_get_hermes_recs(char *page, char **start, off_t requested_offset,
-			   int requested_len, int *eof, void *data)
+#define DEBUG_LTV_SIZE		128
+
+static int orinoco_debug_dump_recs(struct net_device *dev)
 {
-	struct orinoco_private *priv = (struct orinoco_private *)data;
-	struct net_device *dev = priv->ndev;
+	struct orinoco_private *priv = dev->priv;
 	hermes_t *hw = &priv->hw;
-	char *buf = page;
-	int total = 0, slop = 0;
 	u8 *val8;
 	u16 *val16;
 	int i,j;
 	u16 length;
 	int err;
 
-	if (! netif_device_present(dev))
-		return -ENODEV;
-
-	val8 = kmalloc(PROC_LTV_SIZE + 2, GFP_KERNEL);
+	/* I'm not sure: we might have a lock here, so we'd better go
+           atomic, just in case. */
+	val8 = kmalloc(DEBUG_LTV_SIZE + 2, GFP_ATOMIC);
 	if (! val8)
 		return -ENOMEM;
 	val16 = (u16 *)val8;
 
-	for (i = 0; i < NUM_RIDS; i++) {
+	for (i = 0; i < ARRAY_SIZE(record_table); i++) {
 		u16 rid = record_table[i].rid;
 		int len;
 
-		memset(val8, 0, PROC_LTV_SIZE + 2);
+		memset(val8, 0, DEBUG_LTV_SIZE + 2);
 
-		err = hermes_read_ltv(hw, USER_BAP, rid, PROC_LTV_SIZE,
+		err = hermes_read_ltv(hw, USER_BAP, rid, DEBUG_LTV_SIZE,
 				      &length, val8);
 		if (err) {
 			DEBUG(0, "Error %d reading RID 0x%04x\n", err, rid);
@@ -4023,190 +4092,39 @@
 		if (length == 0)
 			continue;
 
-		buf += sprintf(buf, "%-15s (0x%04x): length=%d (%d bytes)\tvalue=", record_table[i].name,
-			       rid, length, (length-1)*2);
-		len = min(((int)length-1)*2, PROC_LTV_SIZE);
+		printk(KERN_DEBUG "%-15s (0x%04x): length=%d (%d bytes)\tvalue=",
+		       record_table[i].name,
+		       rid, length, (length-1)*2);
+		len = min(((int)length-1)*2, DEBUG_LTV_SIZE);
 
 		switch (record_table[i].displaytype) {
 		case DISPLAY_WORDS:
-			for (j = 0; j < len / 2; j++) {
-				buf += sprintf(buf, "%04X-", le16_to_cpu(val16[j]));
-			}
-			buf--;
+			for (j = 0; j < len / 2; j++)
+				printk("%04X-", le16_to_cpu(val16[j]));
 			break;
 
 		case DISPLAY_BYTES:
 		default:
-			for (j = 0; j < len; j++) {
-				buf += sprintf(buf, "%02X:", val8[j]);
-			}
-			buf--;
+			for (j = 0; j < len; j++)
+				printk("%02X:", val8[j]);
 			break;
 
 		case DISPLAY_STRING:
 			len = min(len, le16_to_cpu(val16[0])+2);
 			val8[len] = '\0';
-			buf += sprintf(buf, "\"%s\"", (char *)&val16[1]);
+			printk("\"%s\"", (char *)&val16[1]);
 			break;
 
 		case DISPLAY_XSTRING:
-			buf += sprintf(buf, "'%s'", (char *)val8);
+			printk("'%s'", (char *)val8);
 		}
 
-		buf += sprintf(buf, "\n");
-
-		if (shift_buffer(page, requested_offset, requested_len,
-				 &total, &slop, &buf))
-			break;
-
-		if ( (buf - page) > PROC_SAFE_SIZE )
-			break;
+		printk("\n");
 	}
 
 	kfree(val8);
 
-	return calc_start_len(page, start, requested_offset, requested_len,
-			      total, buf);
-}
-
-#ifdef HERMES_DEBUG_BUFFER
-static int
-orinoco_proc_get_hermes_buf(char *page, char **start, off_t requested_offset,
-			    int requested_len, int *eof, void *data)
-{
-	struct orinoco_private *priv = (struct orinoco_private *)data;
-	hermes_t *hw = &priv->hw;
-	char *buf = page;
-	int total = 0, slop = 0;
-	int i;
-
-	for (i = 0; i < min_t(int,hw->dbufp, HERMES_DEBUG_BUFSIZE); i++) {
-		memcpy(buf, &hw->dbuf[i], sizeof(hw->dbuf[i]));
-		buf += sizeof(hw->dbuf[i]);
-
-		if (shift_buffer(page, requested_offset, requested_len,
-				 &total, &slop, &buf))
-			break;
-
-		if ( (buf - page) > PROC_SAFE_SIZE )
-			break;
-	}
-
-	return calc_start_len(page, start, requested_offset, requested_len,
-			      total, buf);
-}
-
-static int
-orinoco_proc_get_hermes_prof(char *page, char **start, off_t requested_offset,
-			    int requested_len, int *eof, void *data)
-{
-	struct orinoco_private *priv = (struct orinoco_private *)data;
-	hermes_t *hw = &priv->hw;
-	char *buf = page;
-	int total = 0, slop = 0;
-	int i;
-
-	for (i = 0; i < (HERMES_BAP_BUSY_TIMEOUT+1); i++) {
-		memcpy(buf, &hw->profile[i], sizeof(hw->profile[i]));
-		buf += sizeof(hw->profile[i]);
-
-		if (shift_buffer(page, requested_offset, requested_len,
-				 &total, &slop, &buf))
-			break;
-
-		if ( (buf - page) > PROC_SAFE_SIZE )
-			break;
-	}
-
-	return calc_start_len(page, start, requested_offset, requested_len,
-			      total, buf);
-}
-#endif /* HERMES_DEBUG_BUFFER */
-
-/* initialise the /proc subsystem for the hermes driver, creating the
- * separate entries */
-static int
-orinoco_proc_init(void)
-{
-	int err = 0;
-
-	/* create the directory for it to sit in */
-	dir_base = create_proc_entry("hermes", S_IFDIR, &proc_root);
-	if (dir_base == NULL) {
-		printk(KERN_ERR "Unable to initialise /proc/hermes.\n");
-		orinoco_proc_cleanup();
-		err = -ENOMEM;
-	}
-
-	return err;
-}
-
-int
-orinoco_proc_dev_init(struct net_device *dev)
-{
-	struct orinoco_private *priv = dev->priv;
-	struct proc_dir_entry *e;
-
-	priv->dir_dev = NULL;
-
-	/* create the directory for it to sit in */
-	priv->dir_dev = create_proc_entry(dev->name, S_IFDIR | S_IRUGO | S_IXUGO,
-					  dir_base);
-	if (! priv->dir_dev) {
-		printk(KERN_ERR "Unable to initialize /proc/hermes/%s\n",  dev->name);
-		goto fail;
-	}
-
-	e = create_proc_read_entry("recs", S_IFREG | S_IRUGO,
-			       priv->dir_dev, orinoco_proc_get_hermes_recs, priv);
-	if (! e) {
-		printk(KERN_ERR "Unable to initialize /proc/hermes/%s/recs\n",  dev->name);
-		goto fail;
-	}
-
-#ifdef HERMES_DEBUG_BUFFER
-	e = create_proc_read_entry("buf", S_IFREG | S_IRUGO,
-					       priv->dir_dev, orinoco_proc_get_hermes_buf, priv);
-	if (! e) {
-		printk(KERN_ERR "Unable to initialize /proc/hermes/%s/buf\n", dev->name);
-		goto fail;
-	}
-
-	e = create_proc_read_entry("prof", S_IFREG | S_IRUGO,
-					       priv->dir_dev, orinoco_proc_get_hermes_prof, priv);
-	if (! e) {
-		printk(KERN_ERR "Unable to intialize /proc/hermes/%s/prof\n", dev->name);
-		goto fail;
-	}
-#endif /* HERMES_DEBUG_BUFFER */
-
 	return 0;
- fail:
-	orinoco_proc_dev_cleanup(dev);
-	return -ENOMEM;
-}
-
-void
-orinoco_proc_dev_cleanup(struct net_device *dev)
-{
-	struct orinoco_private *priv = dev->priv;
-
-	if (priv->dir_dev) {
-		remove_proc_entry("prof", priv->dir_dev);
-		remove_proc_entry("buf", priv->dir_dev);
-		remove_proc_entry("recs", priv->dir_dev);
-		remove_proc_entry(dev->name, dir_base);
-		priv->dir_dev = NULL;
-	}
-}
-
-static void
-orinoco_proc_cleanup(void)
-{
-	if (dir_base) {
-		remove_proc_entry("hermes", &proc_root);
-		dir_base = NULL;
-	}
 }
 
 struct net_device *alloc_orinocodev(int sizeof_card, int (*hard_reset)(struct orinoco_private *))
@@ -4232,6 +4150,7 @@
 	dev->do_ioctl = orinoco_ioctl;
 	dev->change_mtu = orinoco_change_mtu;
 	dev->set_multicast_list = orinoco_set_multicast_list;
+	/* we use the default eth_mac_addr for setting the MAC addr */
 
 	/* Set up default callbacks */
 	dev->open = orinoco_open;
@@ -4243,7 +4162,10 @@
 	priv->hw_unavailable = 1; /* orinoco_init() must clear this
 				   * before anything else touches the
 				   * hardware */
-	INIT_WORK(&priv->timeout_task, (void (*)(void *))orinoco_reset, dev);
+	INIT_WORK(&priv->reset_work, (void (*)(void *))orinoco_reset, dev);
+
+	priv->last_linkstatus = 0xffff;
+	priv->connected = 0;
 
 	return dev;
 
@@ -4257,25 +4179,23 @@
 
 EXPORT_SYMBOL(__orinoco_up);
 EXPORT_SYMBOL(__orinoco_down);
+EXPORT_SYMBOL(orinoco_stop);
 EXPORT_SYMBOL(orinoco_reinit_firmware);
 
-EXPORT_SYMBOL(orinoco_proc_dev_init);
-EXPORT_SYMBOL(orinoco_proc_dev_cleanup);
 EXPORT_SYMBOL(orinoco_interrupt);
 
 /* Can't be declared "const" or the whole __initdata section will
  * become const */
-static char version[] __initdata = "orinoco.c 0.13a (David Gibson <hermes@gibson.dropbear.id.au> and others)";
+static char version[] __initdata = "orinoco.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)";
 
 static int __init init_orinoco(void)
 {
 	printk(KERN_DEBUG "%s\n", version);
-	return orinoco_proc_init();
+	return 0;
 }
 
 static void __exit exit_orinoco(void)
 {
-	orinoco_proc_cleanup();
 }
 
 module_init(init_orinoco);
diff -uNr linux-2.5-pristine/drivers/net/wireless/orinoco.h linux-orinoco/drivers/net/wireless/orinoco.h
--- linux-2.5-pristine/drivers/net/wireless/orinoco.h	2003-05-05 11:12:55.000000000 +1000
+++ linux-orinoco/drivers/net/wireless/orinoco.h	2003-05-12 16:39:18.000000000 +1000
@@ -11,9 +11,29 @@
 #include <linux/spinlock.h>
 #include <linux/netdevice.h>
 #include <linux/wireless.h>
-#include <linux/workqueue.h>
+#include <linux/version.h>
 #include "hermes.h"
 
+/* Workqueue / task queue backwards compatibility stuff */
+
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2,5,41)
+#include <linux/workqueue.h>
+#else
+#include <linux/tqueue.h>
+#define work_struct tq_struct
+#define INIT_WORK INIT_TQUEUE
+#define schedule_work schedule_task
+#endif
+
+/* Interrupt handler backwards compatibility stuff */
+#ifndef IRQ_NONE
+
+#define IRQ_NONE
+#define IRQ_HANDLED
+typedef void irqreturn_t;
+
+#endif
+
 /* To enable debug messages */
 //#define ORINOCO_DEBUG		3
 
@@ -42,9 +62,12 @@
 	/* Synchronisation stuff */
 	spinlock_t lock;
 	int hw_unavailable;
-	struct work_struct timeout_task;
+	struct work_struct reset_work;
 
+	/* driver state */
 	int open;
+	u16 last_linkstatus;
+	int connected;
 
 	/* Net device stuff */
 	struct net_device *ndev;
@@ -55,6 +78,7 @@
 	hermes_t hw;
 	u16 txfid;
 
+
 	/* Capabilities of the hardware/firmware */
 	int firmware_type;
 #define FIRMWARE_TYPE_AGERE 1
@@ -68,6 +92,7 @@
 	int has_sensitivity;
 	int nicbuf_size;
 	u16 channel_mask;
+	int broken_disableport;
 
 	/* Configuration paramaters */
 	u32 iw_mode;
@@ -91,9 +116,6 @@
 	/* Configuration dependent variables */
 	int port_type, createibss;
 	int promiscuous, mc_count;
-
-	/* /proc based debugging stuff */
-	struct proc_dir_entry *dir_dev;
 };
 
 #ifdef ORINOCO_DEBUG
@@ -110,10 +132,8 @@
 					   int (*hard_reset)(struct orinoco_private *));
 extern int __orinoco_up(struct net_device *dev);
 extern int __orinoco_down(struct net_device *dev);
-int orinoco_reinit_firmware(struct net_device *dev);
-
-extern int orinoco_proc_dev_init(struct net_device *dev);
-extern void orinoco_proc_dev_cleanup(struct net_device *dev);
+extern int orinoco_stop(struct net_device *dev);
+extern int orinoco_reinit_firmware(struct net_device *dev);
 extern irqreturn_t orinoco_interrupt(int irq, void * dev_id, struct pt_regs *regs);
 
 /********************************************************************/
diff -uNr linux-2.5-pristine/drivers/net/wireless/orinoco_cs.c linux-orinoco/drivers/net/wireless/orinoco_cs.c
--- linux-2.5-pristine/drivers/net/wireless/orinoco_cs.c	2003-05-05 11:12:55.000000000 +1000
+++ linux-orinoco/drivers/net/wireless/orinoco_cs.c	2003-05-12 16:39:18.000000000 +1000
@@ -1,4 +1,4 @@
-/* orinoco_cs.c 0.13a	- (formerly known as dldwd_cs.c)
+/* orinoco_cs.c 0.13e	- (formerly known as dldwd_cs.c)
  *
  * A driver for "Hermes" chipset based PCMCIA wireless adaptors, such
  * as the Lucent WavelanIEEE/Orinoco cards and their OEM (Cabletron/
@@ -14,6 +14,7 @@
 #ifdef  __IN_PCMCIA_PACKAGE__
 #include <pcmcia/k_compat.h>
 #endif /* __IN_PCMCIA_PACKAGE__ */
+
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -21,9 +22,7 @@
 #include <linux/ptrace.h>
 #include <linux/slab.h>
 #include <linux/string.h>
-#include <linux/timer.h>
 #include <linux/ioport.h>
-#include <linux/proc_fs.h>
 #include <linux/netdevice.h>
 #include <linux/if_arp.h>
 #include <linux/etherdevice.h>
@@ -90,8 +89,9 @@
 	dev_node_t node;
 
 	/* Used to handle hard reset */
-	wait_queue_head_t hard_reset_queue;
-	int hard_reset_flag;
+	/* yuck, we need this hack to work around the insanity of the
+         * PCMCIA layer */
+	unsigned long hard_reset_in_progress; 
 };
 
 /*
@@ -128,14 +128,14 @@
 	dev_link_t *link = &card->link;
 	int err;
 
-	card->hard_reset_flag = 0;
+	/* We need atomic ops here, because we're not holding the lock */
+	set_bit(0, &card->hard_reset_in_progress);
 
 	err = CardServices(ResetCard, link->handle, NULL);
 	if (err)
 		return err;
 
-	wait_event_interruptible(card->hard_reset_queue,
-				 card->hard_reset_flag);
+	clear_bit(0, &card->hard_reset_in_progress);
 
 	return 0;
 }
@@ -144,6 +144,16 @@
 /* PCMCIA stuff     						    */
 /********************************************************************/
 
+/* In 2.5 (as of 2.5.69 at least) there is a cs_error exported which
+ * does this, but it's not in 2.4 so we do our own for now. */
+static void
+orinoco_cs_error(client_handle_t handle, int func, int ret)
+{
+	error_info_t err = { func, ret };
+	CardServices(ReportError, handle, &err);
+}
+
+
 /* Remove zombie instances (card removed, detach pending) */
 static void
 flush_stale_links(void)
@@ -187,7 +197,6 @@
 		return NULL;
 	priv = dev->priv;
 	card = priv->card;
-	init_waitqueue_head(&card->hard_reset_queue);
 
 	/* Link both structures together */
 	link = &card->link;
@@ -233,7 +242,7 @@
 
 	ret = CardServices(RegisterClient, &link->handle, &client_reg);
 	if (ret != CS_SUCCESS) {
-		cs_error(link->handle, RegisterClient, ret);
+		orinoco_cs_error(link->handle, RegisterClient, ret);
 		orinoco_cs_detach(link);
 		return NULL;
 	}
@@ -262,19 +271,12 @@
 		return;
 	}
 
-	/*
-	   If the device is currently configured and active, we won't
-	   actually delete it yet.  Instead, it is marked so that when
-	   the release() function is called, that will trigger a proper
-	   detach().
-	 */
 	if (link->state & DEV_CONFIG) {
-#ifdef PCMCIA_DEBUG
-		printk(KERN_DEBUG "orinoco_cs: detach postponed, '%s' "
-		       "still locked\n", link->dev->dev_name);
-#endif
-		link->state |= DEV_STALE_LINK;
-		return;
+		orinoco_cs_release((u_long)link);
+		if (link->state & DEV_CONFIG) {
+			link->state |= DEV_STALE_LINK;
+			return;
+		}
 	}
 
 	/* Break the link with Card Services */
@@ -465,7 +467,7 @@
 				link->irq.IRQInfo2 |= 1 << irq_list[i];
 		
   		link->irq.Handler = orinoco_interrupt; 
-  		link->irq.Instance = priv; 
+  		link->irq.Instance = dev; 
 		
 		CS_CHECK(RequestIRQ, link->handle, &link->irq);
 	}
@@ -522,18 +524,10 @@
 		       link->io.BasePort2 + link->io.NumPorts2 - 1);
 	printk("\n");
 
-	/* And give us the proc nodes for debugging */
-	if (orinoco_proc_dev_init(dev) != 0) {
-		printk(KERN_ERR "orinoco_cs: Failed to create /proc node for %s\n",
-		       dev->name);
-		goto failed;
-	}
-	
-
 	return;
 
  cs_failed:
-	cs_error(link->handle, last_fn, last_ret);
+	orinoco_cs_error(link->handle, last_fn, last_ret);
 
  failed:
 	orinoco_cs_release((u_long) link);
@@ -550,21 +544,13 @@
 	dev_link_t *link = (dev_link_t *) arg;
 	struct net_device *dev = link->priv;
 	struct orinoco_private *priv = dev->priv;
+	unsigned long flags;
 
-	/*
-	   If the device is currently in use, we won't release until it
-	   is actually closed, because until then, we can't be sure that
-	   no one will try to access the device or its data structures.
-	 */
-	if (priv->open) {
-		DEBUG(0, "orinoco_cs: release postponed, '%s' still open\n",
-		      link->dev->dev_name);
-		link->state |= DEV_STALE_CONFIG;
-		return;
-	}
-
-	/* Unregister proc entry */
-	orinoco_proc_dev_cleanup(dev);
+	/* We're committed to taking the device away now, so mark the
+	 * hardware as unavailable */
+	spin_lock_irqsave(&priv->lock, flags);
+	priv->hw_unavailable++;
+	spin_unlock_irqrestore(&priv->lock, flags);
 
 	/* Don't bother checking to see if these succeed or not */
 	CardServices(ReleaseConfiguration, link->handle);
@@ -586,6 +572,7 @@
 	dev_link_t *link = args->client_data;
 	struct net_device *dev = link->priv;
 	struct orinoco_private *priv = dev->priv;
+	struct orinoco_pccard *card = priv->card;
 	int err = 0;
 	unsigned long flags;
 
@@ -596,14 +583,9 @@
 			orinoco_lock(priv, &flags);
 
 			netif_device_detach(dev);
-			priv->hw_unavailable = 1;
+			priv->hw_unavailable++;
 
 			orinoco_unlock(priv, &flags);
-
-/*  			if (link->open) */
-/*  				orinoco_cs_stop(dev); */
-
-			mod_timer(&link->release, jiffies + HZ / 20);
 		}
 		break;
 
@@ -618,24 +600,24 @@
 	case CS_EVENT_RESET_PHYSICAL:
 		/* Mark the device as stopped, to block IO until later */
 		if (link->state & DEV_CONFIG) {
-			err = orinoco_lock(priv, &flags);
-			if (err) {
-				printk(KERN_ERR "%s: hw_unavailable on SUSPEND/RESET_PHYSICAL\n",
-				       dev->name);
-				break;
-			}
-
-			err = __orinoco_down(dev);
-			if (err)
-				printk(KERN_WARNING "%s: %s: Error %d downing interface\n",
-				       dev->name,
-				       event == CS_EVENT_PM_SUSPEND ? "SUSPEND" : "RESET_PHYSICAL",
-				       err);
+			/* This is probably racy, but I can't think of
+                           a better way, short of rewriting the PCMCIA
+                           layer to not suck :-( */
+			if (! test_bit(0, &card->hard_reset_in_progress)) {
+				spin_lock_irqsave(&priv->lock, flags);
 
-			netif_device_detach(dev);
-			priv->hw_unavailable = 1;
+				err = __orinoco_down(dev);
+				if (err)
+					printk(KERN_WARNING "%s: %s: Error %d downing interface\n",
+					       dev->name,
+					       event == CS_EVENT_PM_SUSPEND ? "SUSPEND" : "RESET_PHYSICAL",
+					       err);
+				
+				netif_device_detach(dev);
+				priv->hw_unavailable++;
 
-			orinoco_unlock(priv, &flags);
+				spin_unlock_irqrestore(&priv->lock, flags);
+			}
 
 			CardServices(ReleaseConfiguration, link->handle);
 		}
@@ -646,32 +628,34 @@
 		/* Fall through... */
 	case CS_EVENT_CARD_RESET:
 		if (link->state & DEV_CONFIG) {
-			CardServices(RequestConfiguration, link->handle,
-				     &link->conf);
-
 			/* FIXME: should we double check that this is
 			 * the same card as we had before */
-			err = orinoco_reinit_firmware(dev);
-			if (err) {
-				printk(KERN_ERR "%s: Error %d re-initializing firmware\n",
-				       dev->name, err);
-				break;
-			}
-
-			spin_lock_irqsave(&priv->lock, flags);
-
-			netif_device_attach(dev);
-			priv->hw_unavailable = 0;
+			CardServices(RequestConfiguration, link->handle,
+				     &link->conf);
 
-			if (priv->open) {
-				err = __orinoco_up(dev);
-				if (err)
-					printk(KERN_ERR "%s: Error %d restarting card\n",
+			if (! test_bit(0, &card->hard_reset_in_progress)) {
+				err = orinoco_reinit_firmware(dev);
+				if (err) {
+					printk(KERN_ERR "%s: Error %d re-initializing firmware\n",
 					       dev->name, err);
+					break;
+				}
+				
+				spin_lock_irqsave(&priv->lock, flags);
+				
+				netif_device_attach(dev);
+				priv->hw_unavailable--;
+				
+				if (priv->open && ! priv->hw_unavailable) {
+					err = __orinoco_up(dev);
+					if (err)
+						printk(KERN_ERR "%s: Error %d restarting card\n",
+						       dev->name, err);
+					
+				}
 
+				spin_unlock_irqrestore(&priv->lock, flags);
 			}
-
-			orinoco_unlock(priv, &flags);
 		}
 		break;
 	}
@@ -685,7 +669,7 @@
 
 /* Can't be declared "const" or the whole __initdata section will
  * become const */
-static char version[] __initdata = "orinoco_cs.c 0.13a (David Gibson <hermes@gibson.dropbear.id.au> and others)";
+static char version[] __initdata = "orinoco_cs.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)";
 
 static int __init
 init_orinoco_cs(void)
@@ -714,7 +698,6 @@
 	if (dev_list)
 		DEBUG(0, "orinoco_cs: Removing leftover devices.\n");
 	while (dev_list != NULL) {
-		del_timer(&dev_list->release);
 		if (dev_list->state & DEV_CONFIG)
 			orinoco_cs_release((u_long) dev_list);
 		orinoco_cs_detach(dev_list);
diff -uNr linux-2.5-pristine/drivers/net/wireless/orinoco_pci.c linux-orinoco/drivers/net/wireless/orinoco_pci.c
--- linux-2.5-pristine/drivers/net/wireless/orinoco_pci.c	2002-11-23 13:12:15.000000000 +1100
+++ linux-orinoco/drivers/net/wireless/orinoco_pci.c	2003-05-12 16:39:18.000000000 +1000
@@ -1,4 +1,4 @@
-/* orinoco_pci.c 0.13a
+/* orinoco_pci.c 0.13e
  * 
  * Driver for Prism II devices that have a direct PCI interface
  * (i.e., not in a Pcmcia or PLX bridge)
@@ -10,8 +10,10 @@
  * Some of this code is "inspired" by linux-wlan-ng-0.1.10, but nothing
  * has been copied from it. linux-wlan-ng-0.1.10 is originally :
  *	Copyright (C) 1999 AbsoluteValue Systems, Inc.  All Rights Reserved.
- * The rest is :
+ * This file originally written by:
  *	Copyright (C) 2001 Jean Tourrilhes <jt@hpl.hp.com>
+ * And is now maintained by:
+ *	Copyright (C) 2002 David Gibson, IBM Corporation <herme@gibson.dropbear.id.au>
  *
  * The contents of this file are subject to the Mozilla Public License
  * Version 1.1 (the "License"); you may not use this file except in
@@ -84,6 +86,7 @@
  */
 
 #include <linux/config.h>
+
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -93,7 +96,6 @@
 #include <linux/string.h>
 #include <linux/timer.h>
 #include <linux/ioport.h>
-#include <linux/proc_fs.h>
 #include <linux/netdevice.h>
 #include <linux/if_arp.h>
 #include <linux/etherdevice.h>
@@ -142,8 +144,6 @@
 	unsigned long	timeout;
 	u16	reg;
 
-	TRACE_ENTER(priv->ndev->name);
-
 	/* Assert the reset until the card notice */
 	hermes_write_regn(hw, PCI_COR, HERMES_PCI_COR_MASK);
 	printk(KERN_NOTICE "Reset done");
@@ -180,8 +180,6 @@
 	}
 	printk(KERN_NOTICE "pci_cor : reg = 0x%X - %lX - %lX\n", reg, timeout, jiffies);
 
-	TRACE_EXIT(priv->ndev->name);
-
 	return 0;
 }
 
@@ -197,7 +195,6 @@
 	unsigned long pci_iolen;
 	struct orinoco_private *priv = NULL;
 	struct net_device *dev = NULL;
-	int netdev_registered = 0;
 
 	err = pci_enable_device(pdev);
 	if (err)
@@ -218,9 +215,9 @@
 	}
 	priv = dev->priv;
 
-	dev->base_addr = (int) pci_ioaddr;
-        dev->mem_start = (unsigned long) pci_iorange;
-        dev->mem_end = ((unsigned long) pci_iorange) + pci_iolen - 1;
+	dev->base_addr = (unsigned long) pci_ioaddr;
+	dev->mem_start = pci_iorange;
+	dev->mem_end = pci_iorange + pci_iolen - 1;
 
 	SET_MODULE_OWNER(dev);
 
@@ -228,12 +225,15 @@
 	       "Detected Orinoco/Prism2 PCI device at %s, mem:0x%lX to 0x%lX -> 0x%p, irq:%d\n",
 	       pdev->slot_name, dev->mem_start, dev->mem_end, pci_ioaddr, pdev->irq);
 
-	hermes_struct_init(&(priv->hw), dev->base_addr, HERMES_MEM, HERMES_32BIT_REGSPACING);
+	hermes_struct_init(&priv->hw, dev->base_addr,
+			   HERMES_MEM, HERMES_32BIT_REGSPACING);
 	pci_set_drvdata(pdev, dev);
 
-	err = request_irq(pdev->irq, orinoco_interrupt, SA_SHIRQ, dev->name, priv);
+	err = request_irq(pdev->irq, orinoco_interrupt, SA_SHIRQ,
+			  dev->name, dev);
 	if (err) {
-		printk(KERN_ERR "orinoco_pci: Error allocating IRQ %d.\n", pdev->irq);
+		printk(KERN_ERR "orinoco_pci: Error allocating IRQ %d.\n",
+		       pdev->irq);
 		err = -EBUSY;
 		goto fail;
 	}
@@ -254,24 +254,12 @@
 		printk(KERN_ERR "%s: Failed to register net device\n", dev->name);
 		goto fail;
 	}
-	netdev_registered = 1;
-
-	err = orinoco_proc_dev_init(dev);
-	if (err) {
-		printk(KERN_ERR "%s: Failed to create /proc node\n", dev->name);
-		err = -EIO;
-		goto fail;
-	}
 
         return 0;               /* succeeded */
  fail:
 	if (dev) {
-		orinoco_proc_dev_cleanup(dev);
-		if (netdev_registered)
-			unregister_netdev(dev);
-
 		if (dev->irq)
-			free_irq(dev->irq, priv);
+			free_irq(dev->irq, dev);
 
 		kfree(dev);
 	}
@@ -279,6 +267,8 @@
 	if (pci_ioaddr)
 		iounmap(pci_ioaddr);
 
+	pci_disable_device(pdev);
+
 	return err;
 }
 
@@ -290,21 +280,85 @@
 	if (! dev)
 		BUG();
 
-	orinoco_proc_dev_cleanup(dev);
-
 	unregister_netdev(dev);
 
         if (dev->irq)
-		free_irq(dev->irq, priv);
+		free_irq(dev->irq, dev);
 
 	if (priv->hw.iobase)
 		iounmap((unsigned char *) priv->hw.iobase);
 
+	pci_set_drvdata(pdev, NULL);
 	kfree(dev);
 
 	pci_disable_device(pdev);
 }
 
+static int orinoco_pci_suspend(struct pci_dev *pdev, u32 state)
+{
+	struct net_device *dev = pci_get_drvdata(pdev);
+	struct orinoco_private *priv = dev->priv;
+	unsigned long flags;
+	int err;
+	
+	printk(KERN_DEBUG "%s: Orinoco-PCI entering sleep mode (state=%d)\n",
+	       dev->name, state);
+
+	err = orinoco_lock(priv, &flags);
+	if (err) {
+		printk(KERN_ERR "%s: hw_unavailable on orinoco_pci_suspend\n",
+		       dev->name);
+		return err;
+	}
+
+	err = __orinoco_down(dev);
+	if (err)
+		printk(KERN_WARNING "%s: orinoco_pci_suspend(): Error %d downing interface\n",
+		       dev->name, err);
+	
+	netif_device_detach(dev);
+
+	priv->hw_unavailable++;
+	
+	orinoco_unlock(priv, &flags);
+
+	return 0;
+}
+
+static int orinoco_pci_resume(struct pci_dev *pdev)
+{
+	struct net_device *dev = pci_get_drvdata(pdev);
+	struct orinoco_private *priv = dev->priv;
+	unsigned long flags;
+	int err;
+
+	printk(KERN_DEBUG "%s: Orinoco-PCI waking up\n", dev->name);
+
+	err = orinoco_reinit_firmware(dev);
+	if (err) {
+		printk(KERN_ERR "%s: Error %d re-initializing firmware on orinoco_pci_resume()\n",
+		       dev->name, err);
+		return err;
+	}
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	netif_device_attach(dev);
+
+	priv->hw_unavailable--;
+
+	if (priv->open && (! priv->hw_unavailable)) {
+		err = __orinoco_up(dev);
+		if (err)
+			printk(KERN_ERR "%s: Error %d restarting card on orinoco_pci_resume()\n",
+			       dev->name, err);
+	}
+	
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
 static struct pci_device_id orinoco_pci_pci_id_table[] __devinitdata = {
 	{0x1260, 0x3873, PCI_ANY_ID, PCI_ANY_ID,},
 	{0,},
@@ -317,12 +371,12 @@
 	.id_table	= orinoco_pci_pci_id_table,
 	.probe		= orinoco_pci_init_one,
 	.remove		= __devexit_p(orinoco_pci_remove_one),
-	.suspend	= 0,
-	.resume		= 0
+	.suspend	= orinoco_pci_suspend,
+	.resume		= orinoco_pci_resume,
 };
 
-static char version[] __initdata = "orinoco_pci.c 0.13a (Jean Tourrilhes <jt@hpl.hp.com>)";
-MODULE_AUTHOR("Jean Tourrilhes <jt@hpl.hp.com>");
+static char version[] __initdata = "orinoco_pci.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> & Jean Tourrilhes <jt@hpl.hp.com>)";
+MODULE_AUTHOR("David Gibson <hermes@gibson.dropbear.id.au>");
 MODULE_DESCRIPTION("Driver for wireless LAN cards using direct PCI interface");
 MODULE_LICENSE("Dual MPL/GPL");
 
diff -uNr linux-2.5-pristine/drivers/net/wireless/orinoco_plx.c linux-orinoco/drivers/net/wireless/orinoco_plx.c
--- linux-2.5-pristine/drivers/net/wireless/orinoco_plx.c	2002-11-05 16:59:55.000000000 +1100
+++ linux-orinoco/drivers/net/wireless/orinoco_plx.c	2003-05-12 16:39:18.000000000 +1000
@@ -1,4 +1,4 @@
-/* orinoco_plx.c 0.13a
+/* orinoco_plx.c 0.13e
  * 
  * Driver for Prism II devices which would usually be driven by orinoco_cs,
  * but are connected to the PCI bus by a PLX9052. 
@@ -119,7 +119,6 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/system.h>
-#include <linux/proc_fs.h>
 #include <linux/netdevice.h>
 #include <linux/if_arp.h>
 #include <linux/etherdevice.h>
@@ -156,7 +155,6 @@
 	unsigned long pccard_ioaddr = 0;
 	unsigned long pccard_iolen = 0;
 	struct net_device *dev = NULL;
-	int netdev_registered = 0;
 	int i;
 
 	err = pci_enable_device(pdev);
@@ -201,7 +199,7 @@
 	addr = pci_resource_start(pdev, 1);
 	reg = 0;
 	reg = inl(addr+PLX_INTCSR);
-	if(reg & PLX_INTCSR_INTEN)
+	if (reg & PLX_INTCSR_INTEN)
 		printk(KERN_DEBUG "orinoco_plx: "
 		       "Local Interrupt already enabled\n");
 	else {
@@ -244,7 +242,7 @@
 			HERMES_IO, HERMES_16BIT_REGSPACING);
 	pci_set_drvdata(pdev, dev);
 
-	err = request_irq(pdev->irq, orinoco_interrupt, SA_SHIRQ, dev->name, priv);
+	err = request_irq(pdev->irq, orinoco_interrupt, SA_SHIRQ, dev->name, dev);
 	if (err) {
 		printk(KERN_ERR "orinoco_plx: Error allocating IRQ %d.\n", pdev->irq);
 		err = -EBUSY;
@@ -255,27 +253,17 @@
 	err = register_netdev(dev);
 	if (err)
 		goto fail;
-	netdev_registered = 1;
-
-	err = orinoco_proc_dev_init(dev);
-	if (err)
-		goto fail;
 
 	return 0;		/* succeeded */
 
  fail:	
 	printk(KERN_DEBUG "orinoco_plx: init_one(), FAIL!\n");
 
-	if (priv) {
-		orinoco_proc_dev_cleanup(dev);
-
-		if (netdev_registered)
-			unregister_netdev(dev);
-		
+	if (dev) {
 		if (dev->irq)
-			free_irq(dev->irq, priv);
+			free_irq(dev->irq, dev);
 		
-		kfree(priv);
+		kfree(dev);
 	}
 
 	if (pccard_ioaddr)
@@ -292,18 +280,17 @@
 static void __devexit orinoco_plx_remove_one(struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
-	struct orinoco_private *priv = dev->priv;
 
 	if (! dev)
 		BUG();
 
-	orinoco_proc_dev_cleanup(dev);
-
 	unregister_netdev(dev);
 		
 	if (dev->irq)
-		free_irq(dev->irq, priv);
+		free_irq(dev->irq, dev);
 		
+	pci_set_drvdata(pdev, NULL);
+
 	kfree(dev);
 
 	release_region(pci_resource_start(pdev, 3), pci_resource_len(pdev, 3));
@@ -341,7 +328,7 @@
 	.resume		= 0,
 };
 
-static char version[] __initdata = "orinoco_plx.c 0.13a (Daniel Barlow <dan@telent.net>, David Gibson <hermes@gibson.dropbear.id.au>)";
+static char version[] __initdata = "orinoco_plx.c 0.13e (Daniel Barlow <dan@telent.net>, David Gibson <hermes@gibson.dropbear.id.au>)";
 MODULE_AUTHOR("Daniel Barlow <dan@telent.net>");
 MODULE_DESCRIPTION("Driver for wireless LAN cards using the PLX9052 PCI bridge");
 #ifdef MODULE_LICENSE
diff -uNr linux-2.5-pristine/drivers/net/wireless/orinoco_tmd.c linux-orinoco/drivers/net/wireless/orinoco_tmd.c
--- linux-2.5-pristine/drivers/net/wireless/orinoco_tmd.c	1970-01-01 10:00:00.000000000 +1000
+++ linux-orinoco/drivers/net/wireless/orinoco_tmd.c	2003-05-12 16:39:18.000000000 +1000
@@ -0,0 +1,238 @@
+/* orinoco_tmd.c 0.01
+ * 
+ * Driver for Prism II devices which would usually be driven by orinoco_cs,
+ * but are connected to the PCI bus by a TMD7160. 
+ *
+ * Copyright (C) 2003 Joerg Dorchain <joerg@dorchain.net>
+ * based heavily upon orinoco_plx.c Copyright (C) 2001 Daniel Barlow <dan@telent.net>
+ *
+ * The contents of this file are subject to the Mozilla Public License
+ * Version 1.1 (the "License"); you may not use this file except in
+ * compliance with the License. You may obtain a copy of the License
+ * at http://www.mozilla.org/MPL/
+ *
+ * Software distributed under the License is distributed on an "AS IS"
+ * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See
+ * the License for the specific language governing rights and
+ * limitations under the License.
+ *
+ * Alternatively, the contents of this file may be used under the
+ * terms of the GNU General Public License version 2 (the "GPL"), in
+ * which case the provisions of the GPL are applicable instead of the
+ * above.  If you wish to allow the use of your version of this file
+ * only under the terms of the GPL and not to allow others to use your
+ * version of this file under the MPL, indicate your decision by
+ * deleting the provisions above and replace them with the notice and
+ * other provisions required by the GPL.  If you do not delete the
+ * provisions above, a recipient may use your version of this file
+ * under either the MPL or the GPL.
+
+ * Caution: this is experimental and probably buggy.  For success and
+ * failure reports for different cards and adaptors, see
+ * orinoco_tmd_pci_id_table near the end of the file.  If you have a
+ * card we don't have the PCI id for, and looks like it should work,
+ * drop me mail with the id and "it works"/"it doesn't work".
+ *
+ * Note: if everything gets detected fine but it doesn't actually send
+ * or receive packets, your first port of call should probably be to   
+ * try newer firmware in the card.  Especially if you're doing Ad-Hoc
+ * modes
+ *
+ * The actual driving is done by orinoco.c, this is just resource
+ * allocation stuff.
+ *
+ * This driver is modeled after the orinoco_plx driver. The main
+ * difference is that the TMD chip has only IO port ranges and no
+ * memory space, i.e.  no access to the CIS. Compared to the PLX chip,
+ * the io range functionalities are exchanged.
+ *
+ * Pheecom sells cards with the TMD chip as "ASIC version"
+ */
+
+#include <linux/config.h>
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/ptrace.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/timer.h>
+#include <linux/ioport.h>
+#include <asm/uaccess.h>
+#include <asm/io.h>
+#include <asm/system.h>
+#include <linux/netdevice.h>
+#include <linux/if_arp.h>
+#include <linux/etherdevice.h>
+#include <linux/wireless.h>
+#include <linux/list.h>
+#include <linux/pci.h>
+#include <linux/wireless.h>
+#include <linux/fcntl.h>
+
+#include <pcmcia/cisreg.h>
+
+#include "hermes.h"
+#include "orinoco.h"
+
+static char dev_info[] = "orinoco_tmd";
+
+#define COR_VALUE     (COR_LEVEL_REQ | COR_FUNC_ENA | COR_FUNC_ENA) /* Enable PC card with level triggered irqs and irq requests */
+
+
+static int orinoco_tmd_init_one(struct pci_dev *pdev,
+				const struct pci_device_id *ent)
+{
+	int err = 0;
+	u32 reg, addr;
+	struct orinoco_private *priv = NULL;
+	unsigned long pccard_ioaddr = 0;
+	unsigned long pccard_iolen = 0;
+	struct net_device *dev = NULL;
+
+	err = pci_enable_device(pdev);
+	if (err)
+		return -EIO;
+
+	printk(KERN_DEBUG "TMD setup\n");
+	pccard_ioaddr = pci_resource_start(pdev, 2);
+	pccard_iolen = pci_resource_len(pdev, 2);
+	if (! request_region(pccard_ioaddr, pccard_iolen, dev_info)) {
+		printk(KERN_ERR "orinoco_tmd: I/O resource at 0x%lx len 0x%lx busy\n",
+			pccard_ioaddr, pccard_iolen);
+		pccard_ioaddr = 0;
+		err = -EBUSY;
+		goto fail;
+	}
+	addr = pci_resource_start(pdev, 1);
+	outb(COR_VALUE, addr);
+	mdelay(1);
+	reg = inb(addr);
+	if (reg != COR_VALUE) {
+		printk(KERN_ERR "orinoco_tmd: Error setting TMD COR values %x should be %x\n", reg, COR_VALUE);
+		err = -EIO;
+		goto fail;
+	}
+
+	dev = alloc_orinocodev(0, NULL);
+	if (! dev) {
+		err = -ENOMEM;
+		goto fail;
+	}
+
+	priv = dev->priv;
+	dev->base_addr = pccard_ioaddr;
+	SET_MODULE_OWNER(dev);
+
+	printk(KERN_DEBUG
+	       "Detected Orinoco/Prism2 TMD device at %s irq:%d, io addr:0x%lx\n",
+	       pdev->slot_name, pdev->irq, pccard_ioaddr);
+
+	hermes_struct_init(&(priv->hw), dev->base_addr,
+			HERMES_IO, HERMES_16BIT_REGSPACING);
+	pci_set_drvdata(pdev, dev);
+
+	err = request_irq(pdev->irq, orinoco_interrupt, SA_SHIRQ, dev->name,
+			  dev);
+	if (err) {
+		printk(KERN_ERR "orinoco_tmd: Error allocating IRQ %d.\n",
+		       pdev->irq);
+		err = -EBUSY;
+		goto fail;
+	}
+	dev->irq = pdev->irq;
+
+	err = register_netdev(dev);
+	if (err)
+		goto fail;
+
+	return 0;		/* succeeded */
+
+ fail:	
+	printk(KERN_DEBUG "orinoco_tmd: init_one(), FAIL!\n");
+
+	if (dev) {
+		if (dev->irq)
+			free_irq(dev->irq, dev);
+		
+		kfree(dev);
+	}
+
+	if (pccard_ioaddr)
+		release_region(pccard_ioaddr, pccard_iolen);
+
+	pci_disable_device(pdev);
+
+	return err;
+}
+
+static void __devexit orinoco_tmd_remove_one(struct pci_dev *pdev)
+{
+	struct net_device *dev = pci_get_drvdata(pdev);
+
+	if (! dev)
+		BUG();
+
+	unregister_netdev(dev);
+		
+	if (dev->irq)
+		free_irq(dev->irq, dev);
+		
+	pci_set_drvdata(pdev, NULL);
+
+	kfree(dev);
+
+	release_region(pci_resource_start(pdev, 2), pci_resource_len(pdev, 2));
+
+	pci_disable_device(pdev);
+}
+
+
+static struct pci_device_id orinoco_tmd_pci_id_table[] __devinitdata = {
+	{0x15e8, 0x0131, PCI_ANY_ID, PCI_ANY_ID,},      /* NDC and OEMs, e.g. pheecom */
+	{0,},
+};
+
+MODULE_DEVICE_TABLE(pci, orinoco_tmd_pci_id_table);
+
+static struct pci_driver orinoco_tmd_driver = {
+	.name		= "orinoco_tmd",
+	.id_table	= orinoco_tmd_pci_id_table,
+	.probe		= orinoco_tmd_init_one,
+	.remove		= __devexit_p(orinoco_tmd_remove_one),
+	.suspend	= 0,
+	.resume		= 0,
+};
+
+static char version[] __initdata = "orinoco_tmd.c 0.01 (Joerg Dorchain <joerg@dorchain.net>)";
+MODULE_AUTHOR("Joerg Dorchain <joerg@dorchain.net>");
+MODULE_DESCRIPTION("Driver for wireless LAN cards using the TMD7160 PCI bridge");
+#ifdef MODULE_LICENSE
+MODULE_LICENSE("Dual MPL/GPL");
+#endif
+
+static int __init orinoco_tmd_init(void)
+{
+	printk(KERN_DEBUG "%s\n", version);
+	return pci_module_init(&orinoco_tmd_driver);
+}
+
+extern void __exit orinoco_tmd_exit(void)
+{
+	pci_unregister_driver(&orinoco_tmd_driver);
+	current->state = TASK_UNINTERRUPTIBLE;
+	schedule_timeout(HZ);
+}
+
+module_init(orinoco_tmd_init);
+module_exit(orinoco_tmd_exit);
+
+/*
+ * Local variables:
+ *  c-indent-level: 8
+ *  c-basic-offset: 8
+ *  tab-width: 8
+ * End:
+ */


-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
