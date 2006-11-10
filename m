Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946738AbWKJQOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946738AbWKJQOo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 11:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946746AbWKJQOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 11:14:44 -0500
Received: from havoc.gtf.org ([69.61.125.42]:18363 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1946738AbWKJQOn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 11:14:43 -0500
Date: Fri, 10 Nov 2006 11:14:33 -0500
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [git patches] net driver fixes
Message-ID: <20061110161433.GA12708@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git upstream-linus

to receive the following updates:

 drivers/net/arcnet/com20020.c               |    7 +++++--
 drivers/net/bonding/bond_main.c             |    5 +++++
 drivers/net/cris/eth_v10.c                  |    2 ++
 drivers/net/wireless/bcm43xx/bcm43xx_main.c |   22 ++++++++++++++++++++--
 4 files changed, 32 insertions(+), 4 deletions(-)

Adrian Bunk:
      bcm43xx: Add error checking in bcm43xx_sprom_write()

David Rientjes:
      drivers cris: return on NULL dev_alloc_skb()

Michael Buesch:
      bcm43xx: Drain TX status before starting IRQs

Peter Zijlstra:
      bonding: lockdep annotation

Randy Dunlap:
      com20020 build fix

diff --git a/drivers/net/arcnet/com20020.c b/drivers/net/arcnet/com20020.c
index 0dc70c7..aa9dd8f 100644
--- a/drivers/net/arcnet/com20020.c
+++ b/drivers/net/arcnet/com20020.c
@@ -337,13 +337,16 @@ static void com20020_set_mc_list(struct 
 	}
 }
 
-#ifdef MODULE
-
+#if defined(CONFIG_ARCNET_COM20020_PCI_MODULE) || \
+    defined(CONFIG_ARCNET_COM20020_ISA_MODULE)
 EXPORT_SYMBOL(com20020_check);
 EXPORT_SYMBOL(com20020_found);
+#endif
 
 MODULE_LICENSE("GPL");
 
+#ifdef MODULE
+
 int init_module(void)
 {
 	BUGLVL(D_NORMAL) printk(VERSION);
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index c0bbdda..17a4611 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -4692,6 +4692,8 @@ static int bond_check_params(struct bond
 	return 0;
 }
 
+static struct lock_class_key bonding_netdev_xmit_lock_key;
+
 /* Create a new bond based on the specified name and bonding parameters.
  * Caller must NOT hold rtnl_lock; we need to release it here before we
  * set up our sysfs entries.
@@ -4727,6 +4729,9 @@ int bond_create(char *name, struct bond_
 	if (res < 0) {
 		goto out_bond;
 	}
+
+	lockdep_set_class(&bond_dev->_xmit_lock, &bonding_netdev_xmit_lock_key);
+
 	if (newbond)
 		*newbond = bond_dev->priv;
 
diff --git a/drivers/net/cris/eth_v10.c b/drivers/net/cris/eth_v10.c
index 966b563..a03d781 100644
--- a/drivers/net/cris/eth_v10.c
+++ b/drivers/net/cris/eth_v10.c
@@ -509,6 +509,8 @@ etrax_ethernet_init(void)
 		 * does not share cacheline with any other data (to avoid cache bug)
 		 */
 		RxDescList[i].skb = dev_alloc_skb(MAX_MEDIA_DATA_SIZE + 2 * L1_CACHE_BYTES);
+		if (!RxDescList[i].skb)
+			return -ENOMEM;
 		RxDescList[i].descr.ctrl   = 0;
 		RxDescList[i].descr.sw_len = MAX_MEDIA_DATA_SIZE;
 		RxDescList[i].descr.next   = virt_to_phys(&RxDescList[i + 1]);
diff --git a/drivers/net/wireless/bcm43xx/bcm43xx_main.c b/drivers/net/wireless/bcm43xx/bcm43xx_main.c
index 65edb56..a1b7838 100644
--- a/drivers/net/wireless/bcm43xx/bcm43xx_main.c
+++ b/drivers/net/wireless/bcm43xx/bcm43xx_main.c
@@ -746,7 +746,7 @@ int bcm43xx_sprom_write(struct bcm43xx_p
 	if (err)
 		goto err_ctlreg;
 	spromctl |= 0x10; /* SPROM WRITE enable. */
-	bcm43xx_pci_write_config32(bcm, BCM43xx_PCICFG_SPROMCTL, spromctl);
+	err = bcm43xx_pci_write_config32(bcm, BCM43xx_PCICFG_SPROMCTL, spromctl);
 	if (err)
 		goto err_ctlreg;
 	/* We must burn lots of CPU cycles here, but that does not
@@ -768,7 +768,7 @@ int bcm43xx_sprom_write(struct bcm43xx_p
 		mdelay(20);
 	}
 	spromctl &= ~0x10; /* SPROM WRITE enable. */
-	bcm43xx_pci_write_config32(bcm, BCM43xx_PCICFG_SPROMCTL, spromctl);
+	err = bcm43xx_pci_write_config32(bcm, BCM43xx_PCICFG_SPROMCTL, spromctl);
 	if (err)
 		goto err_ctlreg;
 	mdelay(500);
@@ -1463,6 +1463,23 @@ static void handle_irq_transmit_status(s
 	}
 }
 
+static void drain_txstatus_queue(struct bcm43xx_private *bcm)
+{
+	u32 dummy;
+
+	if (bcm->current_core->rev < 5)
+		return;
+	/* Read all entries from the microcode TXstatus FIFO
+	 * and throw them away.
+	 */
+	while (1) {
+		dummy = bcm43xx_read32(bcm, BCM43xx_MMIO_XMITSTAT_0);
+		if (!dummy)
+			break;
+		dummy = bcm43xx_read32(bcm, BCM43xx_MMIO_XMITSTAT_1);
+	}
+}
+
 static void bcm43xx_generate_noise_sample(struct bcm43xx_private *bcm)
 {
 	bcm43xx_shm_write16(bcm, BCM43xx_SHM_SHARED, 0x408, 0x7F7F);
@@ -3532,6 +3549,7 @@ int bcm43xx_select_wireless_core(struct 
 	bcm43xx_macfilter_clear(bcm, BCM43xx_MACFILTER_ASSOC);
 	bcm43xx_macfilter_set(bcm, BCM43xx_MACFILTER_SELF, (u8 *)(bcm->net_dev->dev_addr));
 	bcm43xx_security_init(bcm);
+	drain_txstatus_queue(bcm);
 	ieee80211softmac_start(bcm->net_dev);
 
 	/* Let's go! Be careful after enabling the IRQs.
