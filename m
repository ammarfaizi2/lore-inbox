Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263692AbTDTU3K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 16:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263693AbTDTU3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 16:29:09 -0400
Received: from siaag1ac.compuserve.com ([149.174.40.5]:60121 "EHLO
	siaag1ac.compuserve.com") by vger.kernel.org with ESMTP
	id S263692AbTDTU3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 16:29:05 -0400
Date: Sun, 20 Apr 2003 16:37:32 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [ANNOUNCE] Linux 2.4.68-ce1
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304201640_MC3-1-3532-D35@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Just a quick collection of fixes, and so small it's enclosed...


extraversion.1.patch					(me)
	change extraversion to -ce1
 Makefile                        |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

checker.1.patch						(Muli Ben-Yehuda)
	6 checker fixes from lkml
 drivers/isdn/tpam/tpam_queues.c |    1 +
 drivers/net/wan/sdla_ppp.c      |    3 +--
 net/ax25/af_ax25.c              |    2 ++
 net/ipv4/netfilter/ip_queue.c   |    8 ++++++--
 net/ipv6/netfilter/ip6_queue.c  |    6 +++++-
 net/irda/irttp.c                |    2 +-
 6 files changed, 16 insertions(+), 6 deletions(-)

irq_align.2.patch
	16-byte align interrupt entry points		(me)
 arch/i386/kernel/entry.S        |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

pci_probe.1.patch					(?, from 2.5.68-mm1)
	1-line fix from mm1
 drivers/pci/probe.c             |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

pci_bus.1.patch						(me, from 2.5.68-mm1)
	fix global pci device list order
 drivers/pci/bus.c               |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletion(-)

kbd.1.patch						(Chris Heath)
	fix SAK in raw mode
 drivers/char/keyboard.c         |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

ide_probe.1.patch					(Manfred Spraul)
	fix ide probe return codes
 drivers/ide/ide-probe.c         |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

+-------------------------------------------------------------------------
--- a/drivers/isdn/tpam/tpam_queues.c
+++ b/drivers/isdn/tpam/tpam_queues.c
@ -144,6 +144,7 @
 		do {
 			hpic = readl(card->bar0 + TPAM_HPIC_REGISTER);
 			if (waiting_too_long++ > 0xfffffff) {
+				kfree_skb(skb); 
 				spin_unlock(&card->lock);
 				printk(KERN_ERR "TurboPAM(tpam_irq): "
 						"waiting too long...\n");
--- a/drivers/net/wan/sdla_ppp.c
+++ b/drivers/net/wan/sdla_ppp.c
@ -1747,11 +1747,10 @
 					if (!test_bit(SEND_CRIT, &card->wandev.critical)){
 					 	ppp_send(card, skb->data, skb->len, htons(ETH_P_IPX));
 					}
-					dev_kfree_skb_any(skb);
-
 				} else {
 					++card->wandev.stats.rx_dropped;
 				}
+				dev_kfree_skb_any(skb);
 			} else {
 				/* Pass data up the protocol stack */
 	    			skb->dev = dev;
--- a/net/ax25/af_ax25.c
+++ b/net/ax25/af_ax25.c
@ -1202,6 +1202,8 @
 		ax25_insert_socket(ax25);
 	} else {
 		if (ax25->ax25_dev == NULL) {
+			if (digi != NULL)
+				kfree(digi);
 			err = -EHOSTUNREACH;
 			goto out;
 		}
--- a/net/ipv4/netfilter/ip_queue.c
+++ a/net/ipv4/netfilter/ip_queue.c
@ -298,10 +298,11 @
 		goto err_out_free;
 		
 	write_lock_bh(&queue_lock);
-	
+
 	if (!peer_pid)
-		goto err_out_unlock;
+		goto err_out_free_nskb; 
 
+	/* netlink_unicast will either free the nskb or attach it to a socket */ 
 	status = netlink_unicast(ipqnl, nskb, peer_pid, MSG_DONTWAIT);
 	if (status < 0)
 		goto err_out_unlock;
@ -312,6 +313,9 @
 
 	write_unlock_bh(&queue_lock);
 	return status;
+
+err_out_free_nskb:
+	kfree_skb(nskb); 
 	
 err_out_unlock:
 	write_unlock_bh(&queue_lock);
--- a/net/irda/irttp.c
+++ b/net/irda/irttp.c
@ -263,7 +263,7 @
 
 	IRDA_DEBUG(2, "%s(), rx_sdu_size=%d\n",  __FUNCTION__,
 		   self->rx_sdu_size);
-	ASSERT(n <= self->rx_sdu_size, return NULL;);
+	ASSERT(n <= self->rx_sdu_size, {dev_kfree_skb(skb); return NULL;});
 
 	/* Set the new length */
 	skb_trim(skb, n);
--- a/net/ipv6/netfilter/ip6_queue.c
+++ b/net/ipv6/netfilter/ip6_queue.c
@ -304,8 +304,9 @
 	write_lock_bh(&queue_lock);
 	
 	if (!peer_pid)
-		goto err_out_unlock;
+		goto err_out_free_nskb; 
 
+ 	/* netlink_unicast will either free the nskb or attach it to a socket */ 
 	status = netlink_unicast(ipqnl, nskb, peer_pid, MSG_DONTWAIT);
 	if (status < 0)
 		goto err_out_unlock;
@ -316,6 +317,9 @
 
 	write_unlock_bh(&queue_lock);
 	return status;
+	
+err_out_free_nskb:
+	kfree_skb(nskb); 
 	
 err_out_unlock:
 	write_unlock_bh(&queue_lock);

--- linux-2.5.68-sss/Makefile
+++ linux-2.5.68-ce1/Makefile
@ -1,7 +1,7 @
 VERSION = 2
 PATCHLEVEL = 5
 SUBLEVEL = 68
-EXTRAVERSION =
+EXTRAVERSION = -ce1
 
 # *DOCUMENTATION*
 # To see a list of typical targets execute "make help"
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@ -1214,7 +1214,7 @
 	spin_unlock_irq(&ide_lock);
 out_up:
 	up(&ide_cfg_sem);
-	return 0;
+	return 1;
 }
 
 static int ata_lock(dev_t dev, void *data)
--- a/arch/i386/kernel/entry.S
+++ b/arch/i386/kernel/entry.S
@ -382,10 +382,11 @
 ENTRY(interrupt)
 .text
 
+	.align 16,0x90			# make ENTRY have correct address
 vector=0
 ENTRY(irq_entries_start)
 .rept NR_IRQS
-	ALIGN
+	.align 16,0x90			# should be cacheline-aligned?
 1:	pushl $vector-256
 	jmp common_interrupt
 .data
@ -394,17 +395,18 @
 vector=vector+1
 .endr
 
-	ALIGN
+	.align 16,0x90
 common_interrupt:
 	SAVE_ALL
 	call do_IRQ
 	jmp ret_from_intr
 
 #define BUILD_INTERRUPT(name, nr)	\
+	.align 16,0x90;			\
 ENTRY(name)				\
 	pushl $nr-256;			\
 	SAVE_ALL			\
-	call smp_/**/name;	\
+	call smp_/**/name;		\
 	jmp ret_from_intr;
 
 /* The include is where all of the SMP etc. interrupts come from */
--- a/drivers/char/keyboard.c
+++ b/drivers/char/keyboard.c
@ -601,7 +601,7 @
 		return;
 	if ((kbd->kbdmode == VC_RAW || 
 	     kbd->kbdmode == VC_MEDIUMRAW) && 
-	     value != K_SAK)
+	     value != KVAL(K_SAK))
 		return;		/* SAK is allowed even in raw mode */
 	fn_handler[value](vc, regs);
 }
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@ -75,7 +75,8 @
  * Add newly discovered PCI devices (which are on the bus->devices
  * list) to the global PCI device list, add the sysfs and procfs
  * entries.  Where a bridge is found, add the discovered bus to
- * the parents list of child buses, and recurse.
+ * the parents list of child buses, and recurse (breadth-first
+ * to be compatible with 2.4)
  *
  * Call hotplug for each new devices.
  */
@ -98,6 +99,12 @
 #endif
 		pci_create_sysfs_dev_files(dev);
 
+	}
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+
+		BUG_ON(list_empty(&dev->global_list));
+
 		/*
 		 * If there is an unattached subordinate bus, attach
 		 * it and then scan for unattached PCI devices.
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@ -173,7 +173,7 @
 		limit |= (io_limit_hi << 16);
 	}
 
-	if (base && base <= limit) {
+	if (base <= limit) {
 		res->flags = (io_base_lo & PCI_IO_RANGE_TYPE_MASK) | IORESOURCE_IO;
 		res->start = base;
 		res->end = limit + 0xfff;


------
 Chuck
