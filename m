Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263962AbTDWFxu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 01:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263966AbTDWFxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 01:53:50 -0400
Received: from dp.samba.org ([66.70.73.150]:64384 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263962AbTDWFxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 01:53:19 -0400
Date: Wed, 23 Apr 2003 16:05:20 +1000
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, Jean Tourrilhes <jt@hpl.hp.com>,
       David Hinds <dhinds@sonic.net>
Subject: Re: Update to orinoco driver (2.4)
Message-ID: <20030423060520.GI25455@zax>
Mail-Followup-To: David Gibson <hermes@gibson.dropbear.id.au>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org, Jean Tourrilhes <jt@hpl.hp.com>,
	David Hinds <dhinds@sonic.net>
References: <20030423054636.GG25455@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030423054636.GG25455@zax>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 03:46:36PM +1000, David Gibson wrote:
> Hi Marcelo,
> 
> The patch below updates the orinoco driver in 2.4 to 0.13d, the patch
> is against 2.4.21-rc1.  You may want to postpone this update till
> after 2.4.21, but I'd consider it, since it fixes a fair slew of bugs.

Duh, sorry.  And now with the actual patch:

diff -uNr linux-2.4-pristine/drivers/net/wireless/airport.c linux-orinoco/drivers/net/wireless/airport.c
--- linux-2.4-pristine/drivers/net/wireless/airport.c	2003-04-23 14:55:29.000000000 +1000
+++ linux-orinoco/drivers/net/wireless/airport.c	2003-04-23 14:59:19.000000000 +1000
@@ -1,4 +1,4 @@
-/* airport.c 0.13b
+/* airport.c 0.13d
  *
  * A driver for "Hermes" chipset based Apple Airport wireless
  * card.
@@ -95,7 +95,7 @@
 
 		netif_device_detach(dev);
 
-		priv->hw_unavailable = 1;
+		priv->hw_unavailable++;
 
 		orinoco_unlock(priv, &flags);
 
@@ -121,14 +121,15 @@
 
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
 
@@ -140,8 +141,21 @@
 
 static int airport_hard_reset(struct orinoco_private *priv)
 {
+	/* It would be nice to power cycle the Airport for a real hard
+	 * reset, but for some reason although it appears to
+	 * re-initialize properly, it falls in a screaming heap
+	 * shortly afterwards. */
+#if 0
+	struct net_device *dev = priv->ndev;
 	struct airport *card = priv->card;
 
+	/* Vitally important.  If we don't do this it seems we get an
+	 * interrupt somewhere during the power cycle, since
+	 * hw_unavailable is already set it doesn't get ACKed, we get
+	 * into an interrupt loop and the the PMU decides to turn us
+	 * off. */
+	disable_irq(dev->irq);
+
 	pmac_call_feature(PMAC_FTR_AIRPORT_ENABLE, card->node, 0, 0);
 	current->state = TASK_UNINTERRUPTIBLE;
 	schedule_timeout(HZ);
@@ -149,6 +163,10 @@
 	current->state = TASK_UNINTERRUPTIBLE;
 	schedule_timeout(HZ);
 
+	enable_irq(dev->irq);
+	schedule_timeout(HZ);
+#endif
+
 	return 0;
 }
 
@@ -209,7 +227,7 @@
 	/* Reset it before we get the interrupt */
 	hermes_init(hw);
 
-	if (request_irq(dev->irq, orinoco_interrupt, 0, "Airport", (void *)priv)) {
+	if (request_irq(dev->irq, orinoco_interrupt, 0, "Airport", dev)) {
 		printk(KERN_ERR "airport: Couldn't get IRQ %d\n", dev->irq);
 		goto failed;
 	}
@@ -251,7 +269,7 @@
 	card->ndev_registered = 0;
 
 	if (card->irq_requested)
-		free_irq(dev->irq, priv);
+		free_irq(dev->irq, dev);
 	card->irq_requested = 0;
 
 	if (card->vaddr)
@@ -269,11 +287,10 @@
 	kfree(dev);
 }				/* airport_detach */
 
-static char version[] __initdata = "airport.c 0.13b (Benjamin Herrenschmidt <benh@kernel.crashing.org>)";
+static char version[] __initdata = "airport.c 0.13d (Benjamin Herrenschmidt <benh@kernel.crashing.org>)";
 MODULE_AUTHOR("Benjamin Herrenschmidt <benh@kernel.crashing.org>");
 MODULE_DESCRIPTION("Driver for the Apple Airport wireless card.");
 MODULE_LICENSE("Dual MPL/GPL");
-EXPORT_NO_SYMBOLS;
 
 static int __init
 init_airport(void)
@@ -282,15 +299,11 @@
 
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
 
diff -uNr linux-2.4-pristine/drivers/net/wireless/hermes.c linux-orinoco/drivers/net/wireless/hermes.c
--- linux-2.4-pristine/drivers/net/wireless/hermes.c	2003-04-23 14:55:29.000000000 +1000
+++ linux-orinoco/drivers/net/wireless/hermes.c	2003-04-23 14:59:19.000000000 +1000
@@ -544,4 +544,9 @@
 	return 0;
 }
 
+static void __exit exit_hermes(void)
+{
+}
+
 module_init(init_hermes);
+module_exit(exit_hermes);
diff -uNr linux-2.4-pristine/drivers/net/wireless/hermes.h linux-orinoco/drivers/net/wireless/hermes.h
--- linux-2.4-pristine/drivers/net/wireless/hermes.h	2003-04-23 14:55:29.000000000 +1000
+++ linux-orinoco/drivers/net/wireless/hermes.h	2003-04-23 14:59:19.000000000 +1000
@@ -250,7 +250,6 @@
 	u16 scanreason;             /* ??? */
 	struct hermes_scan_apinfo aps[35];        /* Scan result */
 } __attribute__ ((packed));
-
 #define HERMES_LINKSTATUS_NOT_CONNECTED   (0x0000)  
 #define HERMES_LINKSTATUS_CONNECTED       (0x0001)
 #define HERMES_LINKSTATUS_DISCONNECTED    (0x0002)
@@ -368,7 +367,7 @@
 	if (hw->io_space) {
 		insw(hw->iobase + off, buf, count);
 	} else {
-		int i;
+		unsigned i;
 		u16 *p;
 
 		/* This needs to *not* byteswap (like insw()) but
@@ -388,7 +387,7 @@
 	if (hw->io_space) {
 		outsw(hw->iobase + off, buf, count);
 	} else {
-		int i;
+		unsigned i;
 		const u16 *p;
 
 		/* This needs to *not* byteswap (like outsw()) but
@@ -401,6 +400,21 @@
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
diff -uNr linux-2.4-pristine/drivers/net/wireless/orinoco.c linux-orinoco/drivers/net/wireless/orinoco.c
--- linux-2.4-pristine/drivers/net/wireless/orinoco.c	2003-04-23 14:55:29.000000000 +1000
+++ linux-orinoco/drivers/net/wireless/orinoco.c	2003-04-23 14:59:19.000000000 +1000
@@ -1,4 +1,4 @@
-/* orinoco.c 0.13b	- (formerly known as dldwd_cs.c and orinoco_cs.c)
+/* orinoco.c 0.13d	- (formerly known as dldwd_cs.c and orinoco_cs.c)
  *
  * A driver for Hermes or Prism 2 chipset based PCMCIA wireless
  * adaptors, with Lucent/Agere, Intersil or Symbol firmware.
@@ -345,11 +345,45 @@
  * 	  we are connected (avoids cofusing the firmware), and only
  * 	  give LINKSTATUS printk()s if the status has changed.
  *
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
  * TODO
-
  *	o New wireless extensions API (patch from Moustafa
  *	  Youssef, updated by Jim Carter).
- *	o Fix PCMCIA hard resets with pcmcia-cs.
  *	o Handle de-encapsulation within network layer, provide 802.11
  *	  headers (patch from Thomas 'Dent' Mirlacher)
  *	o Fix possible races in SPY handling.
@@ -373,7 +407,7 @@
  * flag after taking the lock, and if it is set, give up on whatever
  * they are doing and drop the lock again.  The orinoco_lock()
  * function handles this (it unlocks and returns -EBUSY if
- * hw_unavailable is true). */
+ * hw_unavailable is non-zero). */
 
 #include <linux/config.h>
 
@@ -522,7 +556,7 @@
 
 /* Hardware control routines */
 
-static int __orinoco_program_rids(struct orinoco_private *priv);
+static int __orinoco_program_rids(struct net_device *dev);
 
 static int __orinoco_hw_set_bitrate(struct orinoco_private *priv);
 static int __orinoco_hw_setup_wep(struct orinoco_private *priv);
@@ -535,14 +569,14 @@
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
 static int orinoco_ioctl_getiwrange(struct net_device *dev, struct iw_point *rrq);
@@ -577,7 +611,7 @@
 	struct hermes *hw = &priv->hw;
 	int err;
 
-	err = __orinoco_program_rids(priv);
+	err = __orinoco_program_rids(dev);
 	if (err) {
 		printk(KERN_ERR "%s: Error %d configuring card\n",
 		       dev->name, err);
@@ -606,14 +640,25 @@
 
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
@@ -656,38 +701,38 @@
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
 	int err = 0;
 
 	/* We mustn't use orinoco_lock() here, because we need to be
-	   able to close the interface, even if hw_unavailable is set
+	   able to close the interface even if hw_unavailable is set
 	   (e.g. as we're released after a PC Card removal) */
 	spin_lock_irq(&priv->lock);
 
 	priv->open = 0;
 
-	if (! priv->hw_unavailable)
-		err = __orinoco_down(dev);
+	err = __orinoco_down(dev);
 
 	spin_unlock_irq(&priv->lock);
 
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
@@ -873,51 +918,84 @@
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
 
+	err = orinoco_lock(priv, &flags);
+	if (err)
+		return err;
+
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
 
 }
 
 /* This must be called from user context, without locks held - use
- * schedule_task() */
+ * schedule_work() */
 static void orinoco_reset(struct net_device *dev)
 {
 	struct orinoco_private *priv = dev->priv;
+	struct hermes *hw = &priv->hw;
 	int err;
 	unsigned long flags;
 
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
@@ -936,18 +1014,22 @@
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
@@ -979,10 +1061,18 @@
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
@@ -1140,7 +1230,8 @@
 	return 0;
 }
 
-static int orinoco_hw_get_bssid(struct orinoco_private *priv, char buf[ETH_ALEN])
+static int orinoco_hw_get_bssid(struct orinoco_private *priv,
+				char buf[ETH_ALEN])
 {
 	hermes_t *hw = &priv->hw;
 	int err = 0;
@@ -1159,7 +1250,7 @@
 }
 
 static int orinoco_hw_get_essid(struct orinoco_private *priv, int *active,
-			      char buf[IW_ESSID_MAX_SIZE+1])
+				char buf[IW_ESSID_MAX_SIZE+1])
 {
 	hermes_t *hw = &priv->hw;
 	int err = 0;
@@ -1236,9 +1327,8 @@
 	}
 
 	if ( (channel < 1) || (channel > NUM_CHANNELS) ) {
-		struct net_device *dev = priv->ndev;
-
-		printk(KERN_WARNING "%s: Channel out of range (%d)!\n", dev->name, channel);
+		printk(KERN_WARNING "%s: Channel out of range (%d)!\n",
+		       priv->ndev->name, channel);
 		err = -EBUSY;
 		goto out;
 
@@ -1253,8 +1343,8 @@
 	return err ? err : freq;
 }
 
-static int orinoco_hw_get_bitratelist(struct orinoco_private *priv, int *numrates,
-				    s32 *rates, int max)
+static int orinoco_hw_get_bitratelist(struct orinoco_private *priv,
+				      int *numrates, s32 *rates, int max)
 {
 	hermes_t *hw = &priv->hw;
 	struct hermes_idstring list;
@@ -1354,9 +1444,9 @@
  */
 void orinoco_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
-	struct orinoco_private *priv = (struct orinoco_private *) dev_id;
+	struct net_device *dev = (struct net_device *)dev_id;
+	struct orinoco_private *priv = dev->priv;
 	hermes_t *hw = &priv->hw;
-	struct net_device *dev = priv->ndev;
 	int count = MAX_IRQLOOPS_PER_IRQ;
 	u16 evstat, events;
 	/* These are used to detect a runaway interrupt situation */
@@ -1380,11 +1470,11 @@
 
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
 
@@ -1395,21 +1485,21 @@
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
 
@@ -1420,22 +1510,22 @@
 	orinoco_unlock(priv, &flags);
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
 }
 
 static void print_linkstatus(struct net_device *dev, u16 status)
@@ -1472,9 +1562,9 @@
 	       dev->name, s, status);
 }
 
-static void __orinoco_ev_info(struct orinoco_private *priv, hermes_t *hw)
+static void __orinoco_ev_info(struct net_device *dev, hermes_t *hw)
 {
-	struct net_device *dev = priv->ndev;
+	struct orinoco_private *priv = dev->priv;
 	u16 infofid;
 	struct {
 		u16 len;
@@ -1573,9 +1663,9 @@
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
@@ -1664,7 +1754,7 @@
 	 * So, check ourselves */
 	if(((status & HERMES_RXSTAT_MSGTYPE) == HERMES_RXSTAT_1042) ||
 	   ((status & HERMES_RXSTAT_MSGTYPE) == HERMES_RXSTAT_TUNNEL) ||
-	   is_snap(&hdr)) {
+	   is_ethersnap(&hdr)) {
 		/* These indicate a SNAP within 802.2 LLC within
 		   802.11 frame which we'll need to de-encapsulate to
 		   the original EthernetII frame. */
@@ -1726,9 +1816,9 @@
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
@@ -1752,8 +1842,9 @@
 	hermes_write_regn(hw, TXCOMPLFID, DUMMY_FID);
 }
 
-static void __orinoco_ev_tx(struct orinoco_private *priv, hermes_t *hw)
+static void __orinoco_ev_tx(struct net_device *dev, hermes_t *hw)
 {
+	struct orinoco_private *priv = dev->priv;
 	struct net_device_stats *stats = &priv->stats;
 
 	stats->tx_packets++;
@@ -1761,9 +1852,10 @@
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
@@ -1945,7 +2037,7 @@
 
 	TRACE_ENTER(dev->name);
 
-	/* No need to lock, the resetting flag is already set in
+	/* No need to lock, the hw_unavailable flag is already set in
 	 * alloc_orinocodev() */
 	priv->nicbuf_size = IEEE802_11_FRAME_LEN + ETH_HLEN;
 
@@ -2081,8 +2173,6 @@
 	priv->wep_on = 0;
 	priv->tx_key = 0;
 
-	priv->hw_unavailable = 0;
-
 	err = hermes_allocate(hw, priv->nicbuf_size, &priv->txfid);
 	if (err == -EIO) {
 		/* Try workaround for old Symbol firmware bug */
@@ -2102,6 +2192,12 @@
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
@@ -2267,7 +2363,7 @@
 
 	/* Length of the packet body */
 	/* FIXME: what if the skb is smaller than this? */
-	len = max_t(int,skb->len - ETH_HLEN, ETH_ZLEN);
+	len = max_t(int,skb->len - ETH_HLEN, ETH_ZLEN - ETH_HLEN);
 
 	eh = (struct ethhdr *)skb->data;
 
@@ -2281,6 +2377,12 @@
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
@@ -2362,7 +2464,7 @@
 
 	stats->tx_errors++;
 
-	schedule_task(&priv->timeout_task);
+	schedule_work(&priv->reset_work);
 }
 
 static int
@@ -2532,7 +2634,7 @@
 	}
 
 	err = orinoco_hw_get_bitratelist(priv, &numrates,
-				       range.bitrate, IW_MAX_BITRATES);
+					 range.bitrate, IW_MAX_BITRATES);
 	if (err)
 		return err;
 	range.num_bitrates = numrates;
@@ -3128,7 +3230,7 @@
 				rrq->value = 5500000;
 			else
 				rrq->value = val * 1000000;
-                        break;
+			break;
 		case FIRMWARE_TYPE_INTERSIL: /* Intersil style rate */
 		case FIRMWARE_TYPE_SYMBOL: /* Symbol style rate */
 			for (i = 0; i < BITRATE_TABLE_SIZE; i++)
@@ -3754,7 +3856,7 @@
 		
 		printk(KERN_DEBUG "%s: Force scheduling reset!\n", dev->name);
 
-		schedule_task(&priv->timeout_task);
+		schedule_work(&priv->reset_work);
 		break;
 
 	case SIOCIWFIRSTPRIV + 0x2: /* set_port3 */
@@ -3839,7 +3941,7 @@
 	}
 	
 	if (! err && changed && netif_running(dev)) {
-		err = orinoco_reconfigure(priv);
+		err = orinoco_reconfigure(dev);
 	}		
 
 	TRACE_EXIT(dev->name);
@@ -3924,7 +4026,7 @@
 	DEBUG_REC(PRIID,WORDS),
 	DEBUG_REC(PRISUPRANGE,WORDS),
 	DEBUG_REC(CFIACTRANGES,WORDS),
-	DEBUG_REC(NICSERNUM,WORDS),
+	DEBUG_REC(NICSERNUM,XSTRING),
 	DEBUG_REC(NICID,WORDS),
 	DEBUG_REC(MFISUPRANGE,WORDS),
 	DEBUG_REC(CFISUPRANGE,WORDS),
@@ -4062,7 +4164,7 @@
 	priv->hw_unavailable = 1; /* orinoco_init() must clear this
 				   * before anything else touches the
 				   * hardware */
-	INIT_TQUEUE(&priv->timeout_task, (void (*)(void *))orinoco_reset, dev);
+	INIT_WORK(&priv->reset_work, (void (*)(void *))orinoco_reset, dev);
 
 	priv->last_linkstatus = 0xffff;
 	priv->connected = 0;
@@ -4079,13 +4181,14 @@
 
 EXPORT_SYMBOL(__orinoco_up);
 EXPORT_SYMBOL(__orinoco_down);
+EXPORT_SYMBOL(orinoco_stop);
 EXPORT_SYMBOL(orinoco_reinit_firmware);
 
 EXPORT_SYMBOL(orinoco_interrupt);
 
 /* Can't be declared "const" or the whole __initdata section will
  * become const */
-static char version[] __initdata = "orinoco.c 0.13b (David Gibson <hermes@gibson.dropbear.id.au> and others)";
+static char version[] __initdata = "orinoco.c 0.13d (David Gibson <hermes@gibson.dropbear.id.au> and others)";
 
 static int __init init_orinoco(void)
 {
diff -uNr linux-2.4-pristine/drivers/net/wireless/orinoco.h linux-orinoco/drivers/net/wireless/orinoco.h
--- linux-2.4-pristine/drivers/net/wireless/orinoco.h	2003-04-23 14:55:29.000000000 +1000
+++ linux-orinoco/drivers/net/wireless/orinoco.h	2003-04-23 14:59:19.000000000 +1000
@@ -11,9 +11,20 @@
 #include <linux/spinlock.h>
 #include <linux/netdevice.h>
 #include <linux/wireless.h>
-#include <linux/tqueue.h>
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
 /* To enable debug messages */
 //#define ORINOCO_DEBUG		3
 
@@ -42,7 +53,7 @@
 	/* Synchronisation stuff */
 	spinlock_t lock;
 	int hw_unavailable;
-	struct tq_struct timeout_task;
+	struct work_struct reset_work;
 
 	/* driver state */
 	int open;
@@ -72,6 +83,7 @@
 	int has_sensitivity;
 	int nicbuf_size;
 	u16 channel_mask;
+	int broken_disableport;
 
 	/* Configuration paramaters */
 	u32 iw_mode;
@@ -111,8 +123,8 @@
 					   int (*hard_reset)(struct orinoco_private *));
 extern int __orinoco_up(struct net_device *dev);
 extern int __orinoco_down(struct net_device *dev);
-int orinoco_reinit_firmware(struct net_device *dev);
-
+extern int orinoco_stop(struct net_device *dev);
+extern int orinoco_reinit_firmware(struct net_device *dev);
 extern void orinoco_interrupt(int irq, void * dev_id, struct pt_regs *regs);
 
 /********************************************************************/
diff -uNr linux-2.4-pristine/drivers/net/wireless/orinoco_cs.c linux-orinoco/drivers/net/wireless/orinoco_cs.c
--- linux-2.4-pristine/drivers/net/wireless/orinoco_cs.c	2003-04-23 14:55:29.000000000 +1000
+++ linux-orinoco/drivers/net/wireless/orinoco_cs.c	2003-04-23 14:59:19.000000000 +1000
@@ -1,4 +1,4 @@
-/* orinoco_cs.c 0.13b	- (formerly known as dldwd_cs.c)
+/* orinoco_cs.c 0.13d	- (formerly known as dldwd_cs.c)
  *
  * A driver for "Hermes" chipset based PCMCIA wireless adaptors, such
  * as the Lucent WavelanIEEE/Orinoco cards and their OEM (Cabletron/
@@ -22,7 +22,6 @@
 #include <linux/ptrace.h>
 #include <linux/slab.h>
 #include <linux/string.h>
-#include <linux/timer.h>
 #include <linux/ioport.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -38,7 +37,6 @@
 #include <pcmcia/cistpl.h>
 #include <pcmcia/cisreg.h>
 #include <pcmcia/ds.h>
-#include <pcmcia/bus_ops.h>
 
 #include "orinoco.h"
 
@@ -269,19 +267,12 @@
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
@@ -472,7 +463,7 @@
 				link->irq.IRQInfo2 |= 1 << irq_list[i];
 		
   		link->irq.Handler = orinoco_interrupt; 
-  		link->irq.Instance = priv; 
+  		link->irq.Instance = dev; 
 		
 		CS_CHECK(RequestIRQ, link->handle, &link->irq);
 	}
@@ -549,18 +540,13 @@
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
+	/* We're committed to taking the device away now, so mark the
+	 * hardware as unavailable */
+	spin_lock_irqsave(&priv->lock, flags);
+	priv->hw_unavailable++;
+	spin_unlock_irqrestore(&priv->lock, flags);
 
 	/* Don't bother checking to see if these succeed or not */
 	CardServices(ReleaseConfiguration, link->handle);
@@ -593,14 +579,9 @@
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
 
@@ -619,13 +600,8 @@
                            a better way, short of rewriting the PCMCIA
                            layer to not suck :-( */
 			if (! test_bit(0, &card->hard_reset_in_progress)) {
-				err = orinoco_lock(priv, &flags);
-				if (err) {
-					printk(KERN_ERR "%s: hw_unavailable on SUSPEND/RESET_PHYSICAL\n",
-					       dev->name);
-					break;
-				}
-				
+				spin_lock_irqsave(&priv->lock, flags);
+
 				err = __orinoco_down(dev);
 				if (err)
 					printk(KERN_WARNING "%s: %s: Error %d downing interface\n",
@@ -634,9 +610,9 @@
 					       err);
 				
 				netif_device_detach(dev);
-				priv->hw_unavailable = 1;
-				
-				orinoco_unlock(priv, &flags);
+				priv->hw_unavailable++;
+
+				spin_unlock_irqrestore(&priv->lock, flags);
 			}
 
 			CardServices(ReleaseConfiguration, link->handle);
@@ -653,10 +629,6 @@
 			CardServices(RequestConfiguration, link->handle,
 				     &link->conf);
 
-			/* If we're only getting these events because
-                           of the ResetCard in the hard reset, we
-                           don't need to do anything - orinoco_reset()
-                           will handle reinitialization. */
 			if (! test_bit(0, &card->hard_reset_in_progress)) {
 				err = orinoco_reinit_firmware(dev);
 				if (err) {
@@ -668,9 +640,9 @@
 				spin_lock_irqsave(&priv->lock, flags);
 				
 				netif_device_attach(dev);
-				priv->hw_unavailable = 0;
+				priv->hw_unavailable--;
 				
-				if (priv->open) {
+				if (priv->open && ! priv->hw_unavailable) {
 					err = __orinoco_up(dev);
 					if (err)
 						printk(KERN_ERR "%s: Error %d restarting card\n",
@@ -678,7 +650,7 @@
 					
 				}
 
-				orinoco_unlock(priv, &flags);
+				spin_unlock_irqrestore(&priv->lock, flags);
 			}
 		}
 		break;
@@ -693,7 +665,7 @@
 
 /* Can't be declared "const" or the whole __initdata section will
  * become const */
-static char version[] __initdata = "orinoco_cs.c 0.13b (David Gibson <hermes@gibson.dropbear.id.au> and others)";
+static char version[] __initdata = "orinoco_cs.c 0.13d (David Gibson <hermes@gibson.dropbear.id.au> and others)";
 
 static int __init
 init_orinoco_cs(void)
@@ -722,7 +694,6 @@
 	if (dev_list)
 		DEBUG(0, "orinoco_cs: Removing leftover devices.\n");
 	while (dev_list != NULL) {
-		del_timer(&dev_list->release);
 		if (dev_list->state & DEV_CONFIG)
 			orinoco_cs_release((u_long) dev_list);
 		orinoco_cs_detach(dev_list);
diff -uNr linux-2.4-pristine/drivers/net/wireless/orinoco_pci.c linux-orinoco/drivers/net/wireless/orinoco_pci.c
--- linux-2.4-pristine/drivers/net/wireless/orinoco_pci.c	2003-04-23 14:55:29.000000000 +1000
+++ linux-orinoco/drivers/net/wireless/orinoco_pci.c	2003-04-23 14:59:19.000000000 +1000
@@ -1,4 +1,4 @@
-/* orinoco_pci.c 0.13b
+/* orinoco_pci.c 0.13d
  * 
  * Driver for Prism II devices that have a direct PCI interface
  * (i.e., not in a Pcmcia or PLX bridge)
@@ -143,8 +143,6 @@
 	unsigned long	timeout;
 	u16	reg;
 
-	TRACE_ENTER(priv->ndev->name);
-
 	/* Assert the reset until the card notice */
 	hermes_write_regn(hw, PCI_COR, HERMES_PCI_COR_MASK);
 	printk(KERN_NOTICE "Reset done");
@@ -181,8 +179,6 @@
 	}
 	printk(KERN_NOTICE "pci_cor : reg = 0x%X - %lX - %lX\n", reg, timeout, jiffies);
 
-	TRACE_EXIT(priv->ndev->name);
-
 	return 0;
 }
 
@@ -232,7 +228,7 @@
 	hermes_struct_init(&(priv->hw), dev->base_addr, HERMES_MEM, HERMES_32BIT_REGSPACING);
 	pci_set_drvdata(pdev, dev);
 
-	err = request_irq(pdev->irq, orinoco_interrupt, SA_SHIRQ, dev->name, priv);
+	err = request_irq(pdev->irq, orinoco_interrupt, SA_SHIRQ, dev->name, dev);
 	if (err) {
 		printk(KERN_ERR "orinoco_pci: Error allocating IRQ %d.\n", pdev->irq);
 		err = -EBUSY;
@@ -264,7 +260,7 @@
 			unregister_netdev(dev);
 
 		if (dev->irq)
-			free_irq(dev->irq, priv);
+			free_irq(dev->irq, dev);
 
 		kfree(dev);
 	}
@@ -286,7 +282,7 @@
 	unregister_netdev(dev);
 
         if (dev->irq)
-		free_irq(dev->irq, priv);
+		free_irq(dev->irq, dev);
 
 	if (priv->hw.iobase)
 		iounmap((unsigned char *) priv->hw.iobase);
@@ -321,7 +317,7 @@
 	
 	netif_device_detach(dev);
 
-	priv->hw_unavailable = 1;
+	priv->hw_unavailable++;
 	
 	orinoco_unlock(priv, &flags);
 
@@ -348,15 +344,15 @@
 
 	netif_device_attach(dev);
 
-	if (priv->open) {
+	priv->hw_unavailable--;
+
+	if (priv->open && (! priv->hw_unavailable)) {
 		err = __orinoco_up(dev);
 		if (err)
 			printk(KERN_ERR "%s: Error %d restarting card on orinoco_pci_resume()\n",
 			       dev->name, err);
 	}
 	
-	priv->hw_unavailable = 0;
-	
 	spin_unlock_irqrestore(&priv->lock, flags);
 
 	return 0;
@@ -378,7 +374,7 @@
 	.resume		= orinoco_pci_resume,
 };
 
-static char version[] __initdata = "orinoco_pci.c 0.13b (David Gibson <hermes@gibson.dropbear.id.au> & Jean Tourrilhes <jt@hpl.hp.com>)";
+static char version[] __initdata = "orinoco_pci.c 0.13d (David Gibson <hermes@gibson.dropbear.id.au> & Jean Tourrilhes <jt@hpl.hp.com>)";
 MODULE_AUTHOR("David Gibson <hermes@gibson.dropbear.id.au>");
 MODULE_DESCRIPTION("Driver for wireless LAN cards using direct PCI interface");
 MODULE_LICENSE("Dual MPL/GPL");
diff -uNr linux-2.4-pristine/drivers/net/wireless/orinoco_plx.c linux-orinoco/drivers/net/wireless/orinoco_plx.c
--- linux-2.4-pristine/drivers/net/wireless/orinoco_plx.c	2003-04-23 14:55:29.000000000 +1000
+++ linux-orinoco/drivers/net/wireless/orinoco_plx.c	2003-04-23 14:59:19.000000000 +1000
@@ -1,4 +1,4 @@
-/* orinoco_plx.c 0.13b
+/* orinoco_plx.c 0.13d
  * 
  * Driver for Prism II devices which would usually be driven by orinoco_cs,
  * but are connected to the PCI bus by a PLX9052. 
@@ -243,7 +243,7 @@
 			HERMES_IO, HERMES_16BIT_REGSPACING);
 	pci_set_drvdata(pdev, dev);
 
-	err = request_irq(pdev->irq, orinoco_interrupt, SA_SHIRQ, dev->name, priv);
+	err = request_irq(pdev->irq, orinoco_interrupt, SA_SHIRQ, dev->name, dev);
 	if (err) {
 		printk(KERN_ERR "orinoco_plx: Error allocating IRQ %d.\n", pdev->irq);
 		err = -EBUSY;
@@ -266,7 +266,7 @@
 			unregister_netdev(dev);
 		
 		if (dev->irq)
-			free_irq(dev->irq, priv);
+			free_irq(dev->irq, dev);
 		
 		kfree(priv);
 	}
@@ -285,7 +285,6 @@
 static void __devexit orinoco_plx_remove_one(struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
-	struct orinoco_private *priv = dev->priv;
 
 	if (! dev)
 		BUG();
@@ -293,7 +292,7 @@
 	unregister_netdev(dev);
 		
 	if (dev->irq)
-		free_irq(dev->irq, priv);
+		free_irq(dev->irq, dev);
 		
 	pci_set_drvdata(pdev, NULL);
 
@@ -334,7 +333,7 @@
 	.resume		= 0,
 };
 
-static char version[] __initdata = "orinoco_plx.c 0.13b (Daniel Barlow <dan@telent.net>, David Gibson <hermes@gibson.dropbear.id.au>)";
+static char version[] __initdata = "orinoco_plx.c 0.13d (Daniel Barlow <dan@telent.net>, David Gibson <hermes@gibson.dropbear.id.au>)";
 MODULE_AUTHOR("Daniel Barlow <dan@telent.net>");
 MODULE_DESCRIPTION("Driver for wireless LAN cards using the PLX9052 PCI bridge");
 #ifdef MODULE_LICENSE
diff -uNr linux-2.4-pristine/drivers/net/wireless/orinoco_tmd.c linux-orinoco/drivers/net/wireless/orinoco_tmd.c
--- linux-2.4-pristine/drivers/net/wireless/orinoco_tmd.c	1970-01-01 10:00:00.000000000 +1000
+++ linux-orinoco/drivers/net/wireless/orinoco_tmd.c	2003-04-23 14:59:19.000000000 +1000
@@ -0,0 +1,240 @@
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
+	int netdev_registered = 0;
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
+	netdev_registered = 1;
+
+	return 0;		/* succeeded */
+
+ fail:	
+	printk(KERN_DEBUG "orinoco_tmd: init_one(), FAIL!\n");
+
+	if (priv) {
+		if (dev->irq)
+			free_irq(dev->irq, dev);
+		
+		kfree(priv);
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
