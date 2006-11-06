Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423589AbWKFIQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423589AbWKFIQN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 03:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423594AbWKFIQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 03:16:13 -0500
Received: from havoc.gtf.org ([69.61.125.42]:21697 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1423589AbWKFIQL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 03:16:11 -0500
Date: Mon, 6 Nov 2006 03:16:09 -0500
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [git patches] net driver fixes
Message-ID: <20061106081609.GA14871@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git upstream-linus

to receive the following updates:

 drivers/net/Kconfig                         |    4 ++--
 drivers/net/ehea/ehea.h                     |    5 +----
 drivers/net/ehea/ehea_ethtool.c             |    2 +-
 drivers/net/ehea/ehea_main.c                |   26 +++++++++++++-------------
 drivers/net/ehea/ehea_phyp.c                |    2 +-
 drivers/net/ehea/ehea_phyp.h                |    6 ++++--
 drivers/net/ehea/ehea_qmr.c                 |   17 +++++++++--------
 drivers/net/wireless/bcm43xx/bcm43xx_leds.c |    7 ++++++-
 drivers/net/wireless/bcm43xx/bcm43xx_leds.h |    6 ++++++
 drivers/net/wireless/bcm43xx/bcm43xx_main.c |   16 +++++++++++++++-
 drivers/net/wireless/hostap/hostap_plx.c    |    4 ++--
 net/ieee80211/ieee80211_rx.c                |   12 ++++++------
 12 files changed, 66 insertions(+), 41 deletions(-)

Jiri Benc:
      ieee80211: don't flood log with errors

Larry Finger:
      bcm43xx: fix unexpected LED control values in BCM4303 sprom

Michael Buesch:
      bcm43xx: Fix low-traffic netdev watchdog TX timeouts

Pavel Roskin:
      hostap_plx: fix CIS verification

Randy Dunlap:
      Kconfig: remove redundant NETDEVICES depends

Thomas Klein:
      ehea: Nullpointer dereferencation fix
      ehea: Removed redundant define
      ehea: 64K page support fix

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 28c17d1..9cb3ca5 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -486,7 +486,7 @@ config SGI_IOC3_ETH_HW_TX_CSUM
 
 config MIPS_SIM_NET
 	tristate "MIPS simulator Network device (EXPERIMENTAL)"
-	depends on NETDEVICES && MIPS_SIM && EXPERIMENTAL
+	depends on MIPS_SIM && EXPERIMENTAL
 	help
 	  The MIPSNET device is a simple Ethernet network device which is
 	  emulated by the MIPS Simulator.
@@ -2467,7 +2467,7 @@ config ISERIES_VETH
 
 config RIONET
 	tristate "RapidIO Ethernet over messaging driver support"
-	depends on NETDEVICES && RAPIDIO
+	depends on RAPIDIO
 
 config RIONET_TX_SIZE
 	int "Number of outbound queue entries"
diff --git a/drivers/net/ehea/ehea.h b/drivers/net/ehea/ehea.h
index b40724f..39ad9f7 100644
--- a/drivers/net/ehea/ehea.h
+++ b/drivers/net/ehea/ehea.h
@@ -39,7 +39,7 @@ #include <asm/abs_addr.h>
 #include <asm/io.h>
 
 #define DRV_NAME	"ehea"
-#define DRV_VERSION	"EHEA_0034"
+#define DRV_VERSION	"EHEA_0043"
 
 #define EHEA_MSG_DEFAULT (NETIF_MSG_LINK | NETIF_MSG_TIMER \
 	| NETIF_MSG_RX_ERR | NETIF_MSG_TX_ERR)
@@ -105,9 +105,6 @@ #define EHEA_BCMC_TAGGED	0x00
 #define EHEA_BCMC_VLANID_ALL	0x01
 #define EHEA_BCMC_VLANID_SINGLE	0x00
 
-/* Use this define to kmallocate pHYP control blocks */
-#define H_CB_ALIGNMENT		4096
-
 #define EHEA_CACHE_LINE          128
 
 /* Memory Regions */
diff --git a/drivers/net/ehea/ehea_ethtool.c b/drivers/net/ehea/ehea_ethtool.c
index 82eb2fb..9f57c2e 100644
--- a/drivers/net/ehea/ehea_ethtool.c
+++ b/drivers/net/ehea/ehea_ethtool.c
@@ -238,7 +238,7 @@ static void ehea_get_ethtool_stats(struc
 	data[i++] = port->port_res[0].swqe_refill_th;
 	data[i++] = port->resets;
 
-	cb6 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	cb6 = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!cb6) {
 		ehea_error("no mem for cb6");
 		return;
diff --git a/drivers/net/ehea/ehea_main.c b/drivers/net/ehea/ehea_main.c
index 4538c99..6ad6961 100644
--- a/drivers/net/ehea/ehea_main.c
+++ b/drivers/net/ehea/ehea_main.c
@@ -92,7 +92,7 @@ static struct net_device_stats *ehea_get
 
 	memset(stats, 0, sizeof(*stats));
 
-	cb2 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	cb2 = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!cb2) {
 		ehea_error("no mem for cb2");
 		goto out;
@@ -586,8 +586,8 @@ int ehea_sense_port_attr(struct ehea_por
 	u64 hret;
 	struct hcp_ehea_port_cb0 *cb0;
 
-	cb0 = kzalloc(H_CB_ALIGNMENT, GFP_ATOMIC);   /* May be called via */
-	if (!cb0) {                                  /* ehea_neq_tasklet() */
+	cb0 = kzalloc(PAGE_SIZE, GFP_ATOMIC);   /* May be called via */
+	if (!cb0) {                             /* ehea_neq_tasklet() */
 		ehea_error("no mem for cb0");
 		ret = -ENOMEM;
 		goto out;
@@ -670,7 +670,7 @@ int ehea_set_portspeed(struct ehea_port 
 	u64 hret;
 	int ret = 0;
 
-	cb4 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	cb4 = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!cb4) {
 		ehea_error("no mem for cb4");
 		ret = -ENOMEM;
@@ -985,7 +985,7 @@ static int ehea_configure_port(struct eh
 	struct hcp_ehea_port_cb0 *cb0;
 
 	ret = -ENOMEM;
-	cb0 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	cb0 = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!cb0)
 		goto out;
 
@@ -1443,7 +1443,7 @@ static int ehea_set_mac_addr(struct net_
 		goto out;
 	}
 
-	cb0 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	cb0 = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!cb0) {
 		ehea_error("no mem for cb0");
 		ret = -ENOMEM;
@@ -1501,7 +1501,7 @@ static void ehea_promiscuous(struct net_
 	if ((enable && port->promisc) || (!enable && !port->promisc))
 		return;
 
-	cb7 = kzalloc(H_CB_ALIGNMENT, GFP_ATOMIC);
+	cb7 = kzalloc(PAGE_SIZE, GFP_ATOMIC);
 	if (!cb7) {
 		ehea_error("no mem for cb7");
 		goto out;
@@ -1870,7 +1870,7 @@ static void ehea_vlan_rx_register(struct
 
 	port->vgrp = grp;
 
-	cb1 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	cb1 = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!cb1) {
 		ehea_error("no mem for cb1");
 		goto out;
@@ -1899,7 +1899,7 @@ static void ehea_vlan_rx_add_vid(struct 
 	int index;
 	u64 hret;
 
-	cb1 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	cb1 = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!cb1) {
 		ehea_error("no mem for cb1");
 		goto out;
@@ -1935,7 +1935,7 @@ static void ehea_vlan_rx_kill_vid(struct
 	if (port->vgrp)
 		port->vgrp->vlan_devices[vid] = NULL;
 
-	cb1 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	cb1 = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!cb1) {
 		ehea_error("no mem for cb1");
 		goto out;
@@ -1968,7 +1968,7 @@ int ehea_activate_qp(struct ehea_adapter
 	u64 dummy64 = 0;
 	struct hcp_modify_qp_cb0* cb0;
 
-	cb0 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	cb0 = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!cb0) {
 		ret = -ENOMEM;
 		goto out;
@@ -2269,7 +2269,7 @@ int ehea_sense_adapter_attr(struct ehea_
 	u64 hret;
 	int ret;
 
-	cb = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	cb = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!cb) {
 		ret = -ENOMEM;
 		goto out;
@@ -2340,7 +2340,7 @@ static int ehea_setup_single_port(struct
 		goto out;
 
 	/* Enable Jumbo frames */
-	cb4 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	cb4 = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!cb4) {
 		ehea_error("no mem for cb4");
 	} else {
diff --git a/drivers/net/ehea/ehea_phyp.c b/drivers/net/ehea/ehea_phyp.c
index 0b51a8c..0cfc2bc 100644
--- a/drivers/net/ehea/ehea_phyp.c
+++ b/drivers/net/ehea/ehea_phyp.c
@@ -506,7 +506,7 @@ u64 ehea_h_register_rpage_mr(const u64 a
 			     const u8 pagesize, const u8 queue_type,
 			     const u64 log_pageaddr, const u64 count)
 {
-	if ((count > 1) && (log_pageaddr & 0xfff)) {
+	if ((count > 1) && (log_pageaddr & ~PAGE_MASK)) {
 		ehea_error("not on pageboundary");
 		return H_PARAMETER;
 	}
diff --git a/drivers/net/ehea/ehea_phyp.h b/drivers/net/ehea/ehea_phyp.h
index fa51e3b..919f94b 100644
--- a/drivers/net/ehea/ehea_phyp.h
+++ b/drivers/net/ehea/ehea_phyp.h
@@ -81,14 +81,16 @@ #define NELR_PORTSTATE_CHG	EHEA_BMASK_IB
 static inline void hcp_epas_ctor(struct h_epas *epas, u64 paddr_kernel,
 				 u64 paddr_user)
 {
-	epas->kernel.addr = ioremap(paddr_kernel, PAGE_SIZE);
+	/* To support 64k pages we must round to 64k page boundary */
+	epas->kernel.addr = ioremap((paddr_kernel & PAGE_MASK), PAGE_SIZE) +
+			    (paddr_kernel & ~PAGE_MASK);
 	epas->user.addr = paddr_user;
 }
 
 static inline void hcp_epas_dtor(struct h_epas *epas)
 {
 	if (epas->kernel.addr)
-		iounmap(epas->kernel.addr);
+		iounmap((void __iomem*)((u64)epas->kernel.addr & PAGE_MASK));
 
 	epas->user.addr = 0;
 	epas->kernel.addr = 0;
diff --git a/drivers/net/ehea/ehea_qmr.c b/drivers/net/ehea/ehea_qmr.c
index 3e18623..72ef7bd 100644
--- a/drivers/net/ehea/ehea_qmr.c
+++ b/drivers/net/ehea/ehea_qmr.c
@@ -209,11 +209,11 @@ int ehea_destroy_cq(struct ehea_cq *cq)
 {
 	u64 adapter_handle, hret;
 
-	adapter_handle = cq->adapter->handle;
-
 	if (!cq)
 		return 0;
 
+	adapter_handle = cq->adapter->handle;
+
 	/* deregister all previous registered pages */
 	hret = ehea_h_free_resource(adapter_handle, cq->fw_handle);
 	if (hret != H_SUCCESS) {
@@ -512,7 +512,7 @@ int ehea_reg_mr_adapter(struct ehea_adap
 
 	start = KERNELBASE;
 	end = (u64)high_memory;
-	nr_pages = (end - start) / PAGE_SIZE;
+	nr_pages = (end - start) / EHEA_PAGESIZE;
 
 	pt =  kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!pt) {
@@ -538,9 +538,9 @@ int ehea_reg_mr_adapter(struct ehea_adap
 		if (nr_pages > 1) {
 			u64 num_pages = min(nr_pages, (u64)512);
 			for (i = 0; i < num_pages; i++)
-				pt[i] = virt_to_abs((void*)(((u64)start)
-							     + ((k++) *
-								PAGE_SIZE)));
+				pt[i] = virt_to_abs((void*)(((u64)start) +
+							    ((k++) *
+							     EHEA_PAGESIZE)));
 
 			hret = ehea_h_register_rpage_mr(adapter->handle,
 							adapter->mr.handle, 0,
@@ -548,8 +548,9 @@ int ehea_reg_mr_adapter(struct ehea_adap
 							num_pages);
 			nr_pages -= num_pages;
 		} else {
-			u64 abs_adr = virt_to_abs((void*)(((u64)start)
-							   + (k * PAGE_SIZE)));
+			u64 abs_adr = virt_to_abs((void*)(((u64)start) +
+							  (k * EHEA_PAGESIZE)));
+
 			hret = ehea_h_register_rpage_mr(adapter->handle,
 							adapter->mr.handle, 0,
 							0, abs_adr,1);
diff --git a/drivers/net/wireless/bcm43xx/bcm43xx_leds.c b/drivers/net/wireless/bcm43xx/bcm43xx_leds.c
index 2ddbec6..7d383a2 100644
--- a/drivers/net/wireless/bcm43xx/bcm43xx_leds.c
+++ b/drivers/net/wireless/bcm43xx/bcm43xx_leds.c
@@ -189,20 +189,24 @@ void bcm43xx_leds_update(struct bcm43xx_
 		case BCM43xx_LED_INACTIVE:
 			continue;
 		case BCM43xx_LED_OFF:
+		case BCM43xx_LED_BCM4303_3:
 			break;
 		case BCM43xx_LED_ON:
 			turn_on = 1;
 			break;
 		case BCM43xx_LED_ACTIVITY:
+		case BCM43xx_LED_BCM4303_0:
 			turn_on = activity;
 			break;
 		case BCM43xx_LED_RADIO_ALL:
 			turn_on = radio->enabled;
 			break;
 		case BCM43xx_LED_RADIO_A:
+		case BCM43xx_LED_BCM4303_2:
 			turn_on = (radio->enabled && phy->type == BCM43xx_PHYTYPE_A);
 			break;
 		case BCM43xx_LED_RADIO_B:
+		case BCM43xx_LED_BCM4303_1:
 			turn_on = (radio->enabled &&
 				   (phy->type == BCM43xx_PHYTYPE_B ||
 				    phy->type == BCM43xx_PHYTYPE_G));
@@ -257,7 +261,8 @@ #ifdef CONFIG_BCM43XX_DEBUG
 			continue;
 #endif /* CONFIG_BCM43XX_DEBUG */
 		default:
-			assert(0);
+			dprintkl(KERN_INFO PFX "Bad value in leds_update,"
+				" led->behaviour: 0x%x\n", led->behaviour);
 		};
 
 		if (led->activelow)
diff --git a/drivers/net/wireless/bcm43xx/bcm43xx_leds.h b/drivers/net/wireless/bcm43xx/bcm43xx_leds.h
index d3716cf..811e14a 100644
--- a/drivers/net/wireless/bcm43xx/bcm43xx_leds.h
+++ b/drivers/net/wireless/bcm43xx/bcm43xx_leds.h
@@ -46,6 +46,12 @@ enum { /* LED behaviour values */
 	BCM43xx_LED_TEST_BLINKSLOW,
 	BCM43xx_LED_TEST_BLINKMEDIUM,
 	BCM43xx_LED_TEST_BLINKFAST,
+
+	/* Misc values for BCM4303 */
+	BCM43xx_LED_BCM4303_0 = 0x2B,
+	BCM43xx_LED_BCM4303_1 = 0x78,
+	BCM43xx_LED_BCM4303_2 = 0x2E,
+	BCM43xx_LED_BCM4303_3 = 0x19,
 };
 
 int bcm43xx_leds_init(struct bcm43xx_private *bcm);
diff --git a/drivers/net/wireless/bcm43xx/bcm43xx_main.c b/drivers/net/wireless/bcm43xx/bcm43xx_main.c
index a94c6d8..65edb56 100644
--- a/drivers/net/wireless/bcm43xx/bcm43xx_main.c
+++ b/drivers/net/wireless/bcm43xx/bcm43xx_main.c
@@ -3163,9 +3163,11 @@ #define BADNESS_LIMIT	4
 static void bcm43xx_periodic_work_handler(void *d)
 {
 	struct bcm43xx_private *bcm = d;
+	struct net_device *net_dev = bcm->net_dev;
 	unsigned long flags;
 	u32 savedirqs = 0;
 	int badness;
+	unsigned long orig_trans_start = 0;
 
 	mutex_lock(&bcm->mutex);
 	badness = estimate_periodic_work_badness(bcm->periodic_state);
@@ -3173,7 +3175,18 @@ static void bcm43xx_periodic_work_handle
 		/* Periodic work will take a long time, so we want it to
 		 * be preemtible.
 		 */
-		netif_tx_disable(bcm->net_dev);
+
+		netif_tx_lock_bh(net_dev);
+		/* We must fake a started transmission here, as we are going to
+		 * disable TX. If we wouldn't fake a TX, it would be possible to
+		 * trigger the netdev watchdog, if the last real TX is already
+		 * some time on the past (slightly less than 5secs)
+		 */
+		orig_trans_start = net_dev->trans_start;
+		net_dev->trans_start = jiffies;
+		netif_stop_queue(net_dev);
+		netif_tx_unlock_bh(net_dev);
+
 		spin_lock_irqsave(&bcm->irq_lock, flags);
 		bcm43xx_mac_suspend(bcm);
 		if (bcm43xx_using_pio(bcm))
@@ -3198,6 +3211,7 @@ static void bcm43xx_periodic_work_handle
 			bcm43xx_pio_thaw_txqueues(bcm);
 		bcm43xx_mac_enable(bcm);
 		netif_wake_queue(bcm->net_dev);
+		net_dev->trans_start = orig_trans_start;
 	}
 	mmiowb();
 	spin_unlock_irqrestore(&bcm->irq_lock, flags);
diff --git a/drivers/net/wireless/hostap/hostap_plx.c b/drivers/net/wireless/hostap/hostap_plx.c
index 6dfa041..bc81b13 100644
--- a/drivers/net/wireless/hostap/hostap_plx.c
+++ b/drivers/net/wireless/hostap/hostap_plx.c
@@ -364,7 +364,7 @@ #define CIS_MAX_LEN 256
 
 	pos = 0;
 	while (pos < CIS_MAX_LEN - 1 && cis[pos] != CISTPL_END) {
-		if (pos + cis[pos + 1] >= CIS_MAX_LEN)
+		if (pos + 2 + cis[pos + 1] > CIS_MAX_LEN)
 			goto cis_error;
 
 		switch (cis[pos]) {
@@ -391,7 +391,7 @@ #define CIS_MAX_LEN 256
 			break;
 
 		case CISTPL_MANFID:
-			if (cis[pos + 1] < 5)
+			if (cis[pos + 1] < 4)
 				goto cis_error;
 			manfid1 = cis[pos + 2] + (cis[pos + 3] << 8);
 			manfid2 = cis[pos + 4] + (cis[pos + 5] << 8);
diff --git a/net/ieee80211/ieee80211_rx.c b/net/ieee80211/ieee80211_rx.c
index 7707041..2759312 100644
--- a/net/ieee80211/ieee80211_rx.c
+++ b/net/ieee80211/ieee80211_rx.c
@@ -1078,12 +1078,12 @@ #endif
 
 	while (length >= sizeof(*info_element)) {
 		if (sizeof(*info_element) + info_element->len > length) {
-			IEEE80211_ERROR("Info elem: parse failed: "
-					"info_element->len + 2 > left : "
-					"info_element->len+2=%zd left=%d, id=%d.\n",
-					info_element->len +
-					sizeof(*info_element),
-					length, info_element->id);
+			IEEE80211_DEBUG_MGMT("Info elem: parse failed: "
+					     "info_element->len + 2 > left : "
+					     "info_element->len+2=%zd left=%d, id=%d.\n",
+					     info_element->len +
+					     sizeof(*info_element),
+					     length, info_element->id);
 			/* We stop processing but don't return an error here
 			 * because some misbehaviour APs break this rule. ie.
 			 * Orinoco AP1000. */
