Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271580AbTGQWBT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 18:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271571AbTGQWBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 18:01:19 -0400
Received: from dclient217-162-108-200.hispeed.ch ([217.162.108.200]:24325 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S271567AbTGQV7Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 17:59:24 -0400
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH 2.4] fixes for airo.c
Date: Fri, 18 Jul 2003 00:15:16 +0200
User-Agent: KMail/1.5.2
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
       "linux-net" <linux-net@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307180015.16687.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello

in 2.4.20+ airo.c is broken and can even kill keventd. this patch fixes it:
- sane locking with spinlocks and irqs disabled instead of the buggy locking
  with semaphores
- fix transmit code
- safer unload ordering of disable irq, unregister_netdev, kfree
- fix possible loop-forever bug
- fix a buffer overflow

a previous version of the patch is tested by some people with good results.
against 2.4.22-pre6-bk. please apply.


rgds
-daniel


ps: a 2.6 version will follow soon...




--- 1.25/drivers/net/wireless/airo.c	Wed Apr 23 19:43:55 2003
+++ edited/airo.c	Thu Jul 17 22:19:02 2003
@@ -933,9 +933,8 @@
 static void disable_MAC(struct airo_info *ai);
 static void enable_interrupts(struct airo_info*);
 static void disable_interrupts(struct airo_info*);
-static u16 issuecommand(struct airo_info*, Cmd *pCmd, Resp *pRsp);
-static u16 sendcommand(struct airo_info *ai, Cmd *pCmd);
-static void completecommand(struct airo_info *ai, Resp *pRsp);
+static int issuecommand(struct airo_info*, Cmd *pCmd, Resp *pRsp);
+static int issuecommand_nolock(struct airo_info*, Cmd *pCmd, Resp *pRsp);
 static int bap_setup(struct airo_info*, u16 rid, u16 offset, int whichbap);
 static int aux_bap_read(struct airo_info*, u16 *pu16Dst, int bytelen,
 			int whichbap);
@@ -945,13 +944,14 @@
 		     int whichbap);
 static int PC4500_accessrid(struct airo_info*, u16 rid, u16 accmd);
 static int PC4500_readrid(struct airo_info*, u16 rid, void *pBuf, int len);
+static int PC4500_readrid_nolock(struct airo_info*, u16 rid, void *pBuf, int len);
 static int PC4500_writerid(struct airo_info*, u16 rid, const void
 			   *pBuf, int len);
 static int do_writerid( struct airo_info*, u16 rid, const void *rid_data,
 			int len );
 static u16 transmit_allocate(struct airo_info*, int lenPayload, int raw);
-static int transmit_802_3_packet(struct airo_info*, int len, char *pPacket);
-static int transmit_802_11_packet(struct airo_info*, int len, char *pPacket);
+static int transmit_802_3_packet(struct airo_info*, u16 txFid, char *pPacket, int len);
+static int transmit_802_11_packet(struct airo_info*, u16 txFid, char *pPacket, int len);
 
 static void airo_interrupt( int irq, void* dev_id, struct pt_regs
 			    *regs);
@@ -987,12 +987,11 @@
 	struct timer_list timer;
 	struct proc_dir_entry *proc_entry;
 	struct airo_info *next;
-        spinlock_t aux_lock;
+	spinlock_t main_lock;
         unsigned long flags;
 #define FLAG_PROMISC   IFF_PROMISC	/* 0x100 - include/linux/if.h */
 #define FLAG_RADIO_OFF 0x02		/* User disabling of MAC */
 #define FLAG_RADIO_DOWN 0x08		/* ifup/ifdown disabling of MAC */
-#define FLAG_LOCKED    2		/* 0x04 - use as a bit offset */
 #define FLAG_FLASHING  0x10
 #define FLAG_ADHOC        0x01 /* Needed by MIC */
 #define FLAG_MIC_CAPABLE  0x20
@@ -1003,14 +1002,8 @@
 			int whichbap);
 	unsigned short *flash;
 	tdsRssiEntry *rssi;
-	struct semaphore sem;
 	struct task_struct *task;
 	struct tq_struct promisc_task;
-	struct {
-		struct sk_buff *skb;
-		int fid;
-		struct tq_struct task;
-	} xmit, xmit11;
 	struct net_device *wifidev;
 #ifdef WIRELESS_EXT
 	struct iw_statistics	wstats;		// wireless stats
@@ -1051,10 +1044,8 @@
 	if (first == 1) {
 			memset(&cmd, 0, sizeof(cmd));
 			cmd.cmd=CMD_LISTBSS;
-			if (down_interruptible(&ai->sem))
-				return -ERESTARTSYS;
 			issuecommand(ai, &cmd, &rsp);
-			up(&ai->sem);
+
 			/* Let the command take effect */
 			set_current_state (TASK_INTERRUPTIBLE);
 			ai->task = current;
@@ -1199,7 +1190,7 @@
 	statr->len = le16_to_cpu(statr->len);
 	for(s = &statr->mode; s <= &statr->SSIDlen; s++) *s = le16_to_cpu(*s);
 
-	for(s = &statr->beaconPeriod; s <= &statr->_reserved[9]; s++)
+	for(s = &statr->beaconPeriod; s <= &statr->_reserved1; s++)
 		*s = le16_to_cpu(*s);
 
 	return rc;
@@ -1312,44 +1303,15 @@
 	}
 }
 
-static void airo_do_xmit(struct net_device *dev) {
-	u16 status;
-	int i;
-	struct airo_info *priv = dev->priv;
-	struct sk_buff *skb = priv->xmit.skb;
-	int fid = priv->xmit.fid;
-	u32 *fids = priv->fids;
-
-	if (down_trylock(&priv->sem) != 0) {
-		netif_stop_queue(dev);
-		priv->xmit.task.routine = (void (*)(void *))airo_do_xmit;
-		priv->xmit.task.data = (void *)dev;
-		schedule_task(&priv->xmit.task);
-		return;
-	}
-	status = transmit_802_3_packet (priv, fids[fid], skb->data);
-	up(&priv->sem);
-
-	i = 0;
-	if ( status == SUCCESS ) {
-		dev->trans_start = jiffies;
-		for (; i < MAX_FIDS / 2 && (priv->fids[i] & 0xffff0000); i++);
-	} else {
-		priv->fids[fid] &= 0xffff;
-		priv->stats.tx_window_errors++;
-	}
-	if (i < MAX_FIDS / 2)
-		netif_wake_queue(dev);
-	else
-		netif_stop_queue(dev);
-	dev_kfree_skb(skb);
-}
-
-static int airo_start_xmit(struct sk_buff *skb, struct net_device *dev) {
-	s16 len;
+static int airo_start_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	int len;
 	int i;
+	int ret = 0;
+	int status;
+	unsigned long flags;
 	struct airo_info *priv = dev->priv;
-	u32 *fids = priv->fids;
+	int *fids = priv->fids;
 
 	if ( skb == NULL ) {
 		printk( KERN_ERR "airo:  skb == NULL!!!\n" );
@@ -1357,61 +1319,50 @@
 	}
 
 	/* Find a vacant FID */
-	for( i = 0; i < MAX_FIDS / 2 && (fids[i] & 0xffff0000); i++ );
+	spin_lock_irqsave(&priv->main_lock, flags);
+	for (i = 0; i < MAX_FIDS / 2 && (fids[i] & 0xffff0000); i++);
 
-	if ( i == MAX_FIDS / 2 ) {
-		priv->stats.tx_fifo_errors++;
-		dev_kfree_skb(skb);
-	} else {
-		/* check min length*/
-		len = ETH_ZLEN < skb->len ? skb->len : ETH_ZLEN;
-	        /* Mark fid as used & save length for later */
-		fids[i] |= (len << 16);
-		priv->xmit.skb = skb;
-		priv->xmit.fid = i;
-		airo_do_xmit(dev);
-	}
-	return 0;
-}
-
-static void airo_do_xmit11(struct net_device *dev) {
-	u16 status;
-	int i;
-	struct airo_info *priv = dev->priv;
-	struct sk_buff *skb = priv->xmit11.skb;
-	int fid = priv->xmit11.fid;
-	u32 *fids = priv->fids;
-
-	if (down_trylock(&priv->sem) != 0) {
+	if (i + 1 >= MAX_FIDS / 2) {
 		netif_stop_queue(dev);
-		priv->xmit11.task.routine = (void (*)(void *))airo_do_xmit11;
-		priv->xmit11.task.data = (void *)dev;
-		schedule_task(&priv->xmit11.task);
-		return;
+
+		/* we cannot transmit */
+		if (i == MAX_FIDS / 2) {
+			priv->stats.tx_fifo_errors++;
+			ret = 1;
+			goto tx_done;
+		}
 	}
-	status = transmit_802_11_packet (priv, fids[fid], skb->data);
-	up(&priv->sem);
+	
+	/* check min length*/
+	len = ETH_ZLEN < skb->len ? skb->len : ETH_ZLEN;
+	status = transmit_802_3_packet (priv, fids[i], skb->data, len);
 
-	i = MAX_FIDS / 2;
-	if ( status == SUCCESS ) {
+	if (status == SUCCESS) {
+		/* Mark fid as used & save length for later */
+		fids[i] |= (len << 16);
 		dev->trans_start = jiffies;
-		for (; i < MAX_FIDS && (priv->fids[i] & 0xffff0000); i++);
-	} else {
-		priv->fids[fid] &= 0xffff;
+	}
+	else {
 		priv->stats.tx_window_errors++;
+		ret = 1;
 	}
-	if (i < MAX_FIDS)
-		netif_wake_queue(dev);
-	else
-		netif_stop_queue(dev);
-	dev_kfree_skb(skb);
+
+tx_done:
+	spin_unlock_irqrestore(&priv->main_lock, flags);
+	if (!ret)
+		dev_kfree_skb(skb);
+	return ret;
 }
 
-static int airo_start_xmit11(struct sk_buff *skb, struct net_device *dev) {
-	s16 len;
+static int airo_start_xmit11(struct sk_buff *skb, struct net_device *dev)
+{
+	int len;
 	int i;
+	int ret = 0;
+	int status;
+	unsigned long flags;
 	struct airo_info *priv = dev->priv;
-	u32 *fids = priv->fids;
+	int *fids = priv->fids;
 
 	if ( skb == NULL ) {
 		printk( KERN_ERR "airo:  skb == NULL!!!\n" );
@@ -1419,21 +1370,39 @@
 	}
 
 	/* Find a vacant FID */
+	spin_lock_irqsave(&priv->main_lock, flags);
 	for( i = MAX_FIDS / 2; i < MAX_FIDS && (fids[i] & 0xffff0000); i++ );
 
-	if ( i == MAX_FIDS ) {
-		priv->stats.tx_fifo_errors++;
-		dev_kfree_skb(skb);
-	} else {
-		/* check min length*/
-		len = ETH_ZLEN < skb->len ? skb->len : ETH_ZLEN;
-	        /* Mark fid as used & save length for later */
+	if (i + 1 >= MAX_FIDS) {
+		netif_stop_queue(dev);
+
+		/* we cannot transmit */
+		if (i == MAX_FIDS) {
+			priv->stats.tx_fifo_errors++;
+			ret = 1;
+			goto tx_done;
+		}
+	}
+	
+	/* check min length*/
+	len = ETH_ZLEN < skb->len ? skb->len : ETH_ZLEN;
+	status = transmit_802_11_packet (priv, fids[i], skb->data, len);
+
+	if (status == SUCCESS) {
+		/* Mark fid as used & save length for later */
 		fids[i] |= (len << 16);
-		priv->xmit11.skb = skb;
-		priv->xmit11.fid = i;
-		airo_do_xmit11(dev);
+		dev->trans_start = jiffies;
 	}
-	return 0;
+	else {
+		priv->stats.tx_window_errors++;
+		ret = 1;
+	}
+
+tx_done:
+	spin_unlock_irqrestore(&priv->main_lock, flags);
+	if (!ret)
+		dev_kfree_skb(skb);
+	return ret;
 }
 
 struct net_device_stats *airo_get_stats(struct net_device *dev)
@@ -1463,36 +1432,19 @@
 	return &local->stats;
 }
 
-static void airo_end_promisc(struct airo_info *ai) {
-	Resp rsp;
-
-	if ((IN4500(ai, EVSTAT) & EV_CMD) != 0) {
-		completecommand(ai, &rsp);
-		up(&ai->sem);
-	} else {
-		ai->promisc_task.routine = (void (*)(void *))airo_end_promisc;
-		ai->promisc_task.data = (void *)ai;
-		schedule_task(&ai->promisc_task);
-	}
-}
-
-static void airo_set_promisc(struct airo_info *ai) {
+static void airo_set_promisc(struct airo_info *ai)
+{
 	Cmd cmd;
+	Resp rsp;
 
-	if (down_trylock(&ai->sem) == 0) {
-		memset(&cmd, 0, sizeof(cmd));
-		cmd.cmd=CMD_SETMODE;
-		cmd.parm0=(ai->flags&IFF_PROMISC) ? PROMISC : NOPROMISC;
-		sendcommand(ai, &cmd);
-		airo_end_promisc(ai);
-	} else {
-		ai->promisc_task.routine = (void (*)(void *))airo_set_promisc;
-		ai->promisc_task.data = (void *)ai;
-		schedule_task(&ai->promisc_task);
-	}
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.cmd = CMD_SETMODE;
+	cmd.parm0 = (ai->flags & IFF_PROMISC) ? PROMISC : NOPROMISC;
+	issuecommand(ai, &cmd, &rsp);
 }
 
-static void airo_set_multicast_list(struct net_device *dev) {
+static void airo_set_multicast_list(struct net_device *dev)
+{
 	struct airo_info *ai = dev->priv;
 
 	if ((dev->flags ^ ai->flags) & IFF_PROMISC) {
@@ -1557,11 +1509,10 @@
 {
 	struct airo_info *ai = dev->priv;
 	flush_scheduled_tasks();
-	if (ai->flash)
-		kfree(ai->flash);
-	if (ai->rssi)
-		kfree(ai->rssi);
-	takedown_proc_entry( dev, ai );
+
+	disable_interrupts(ai);
+	free_irq(dev->irq, dev);
+
 	if (ai->registered) {
 		unregister_netdev( dev );
 		if (ai->wifidev) {
@@ -1571,9 +1522,15 @@
 		}
 		ai->registered = 0;
 	}
-	disable_interrupts(ai);
-	free_irq( dev->irq, dev );
-	if (auto_wep) del_timer_sync(&ai->timer);
+
+	if (ai->flash)
+		kfree(ai->flash);
+	if (ai->rssi)
+		kfree(ai->rssi);
+	takedown_proc_entry( dev, ai );
+
+	if (auto_wep)
+	       	del_timer_sync(&ai->timer);
 	if (freeres) {
 		/* PCMCIA frees this stuff, so only for PCI and ISA */
 	        release_region( dev->base_addr, 64 );
@@ -1670,8 +1627,7 @@
 	ai->wifidev = 0;
 	ai->registered = 0;
         ai->dev = dev;
-	ai->aux_lock = SPIN_LOCK_UNLOCKED;
-	sema_init(&ai->sem, 1);
+	ai->main_lock = SPIN_LOCK_UNLOCKED;
 	ai->need_commit = 0;
 	ai->config.len = 0;
 	rc = add_airo_dev( dev );
@@ -1736,7 +1692,6 @@
 			ai->fids[i] = transmit_allocate(ai,2312,i>=MAX_FIDS/2);
 
 	setup_proc_entry( dev, dev->priv ); /* XXX check for failure */
-	netif_start_queue(dev);
 	SET_MODULE_OWNER(dev);
 	return dev;
 
@@ -1800,47 +1755,31 @@
 EXPORT_SYMBOL(reset_airo_card);
 
 #if WIRELESS_EXT > 13
+/* must be called with lock held */
 static void airo_send_event(struct net_device *dev) {
 	struct airo_info *ai = dev->priv;
 	union iwreq_data wrqu;
 	StatusRid status_rid;
 
-	if (down_trylock(&ai->sem) == 0) {
-		__set_bit(FLAG_LOCKED, &ai->flags);
-		PC4500_readrid(ai, RID_STATUS, &status_rid, sizeof(status_rid));
-		clear_bit(FLAG_LOCKED, &ai->flags);
-		up(&ai->sem);
-		wrqu.data.length = 0;
-		wrqu.data.flags = 0;
-		memcpy(wrqu.ap_addr.sa_data, status_rid.bssid[0], ETH_ALEN);
-		wrqu.ap_addr.sa_family = ARPHRD_ETHER;
+	PC4500_readrid_nolock(ai, RID_STATUS, &status_rid, sizeof(status_rid));
 
-		/* Send event to user space */
-		wireless_send_event(dev, SIOCGIWAP, &wrqu, NULL);
-	} else {
-		ai->event_task.routine = (void (*)(void *))airo_send_event;
-		ai->event_task.data = (void *)dev;
-		schedule_task(&ai->event_task);
-	}
+	wrqu.data.length = 0;
+	wrqu.data.flags = 0;
+	memcpy(wrqu.ap_addr.sa_data, status_rid.bssid[0], ETH_ALEN);
+	wrqu.ap_addr.sa_family = ARPHRD_ETHER;
+
+	/* Send event to user space */
+	wireless_send_event(dev, SIOCGIWAP, &wrqu, NULL);
 }
 #endif
 
 static void airo_read_mic(struct airo_info *ai) {
+#ifdef MICSUPPORT
 	MICRid mic_rid;
 
-	if (down_trylock(&ai->sem) == 0) {
-		__set_bit(FLAG_LOCKED, &ai->flags);
-		PC4500_readrid(ai, RID_MIC, &mic_rid, sizeof(mic_rid));
-		clear_bit(FLAG_LOCKED, &ai->flags);
-		up(&ai->sem);
-#ifdef MICSUPPORT
-		micinit (ai, &mic_rid);
+	PC4500_readrid(ai, RID_MIC, &mic_rid, sizeof(mic_rid));
+	micinit (ai, &mic_rid);
 #endif
-	} else {
-		ai->mic_task.routine = (void (*)(void *))airo_read_mic;
-		ai->mic_task.data = (void *)ai;
-		schedule_task(&ai->mic_task);
-	}
 }
 
 static void airo_interrupt ( int irq, void* dev_id, struct pt_regs *regs) {
@@ -1853,6 +1792,7 @@
 	if (!netif_device_present(dev))
 		return;
 
+	spin_lock(&apriv->main_lock);
 	for (;;) {
 		status = IN4500( apriv, EVSTAT );
 		if ( !(status & STATUS_INTS) || status == 0xffff ) break;
@@ -1869,7 +1809,8 @@
 
 		if ( status & EV_MIC ) {
 			OUT4500( apriv, EVACK, EV_MIC );
-			airo_read_mic( apriv );
+			if (apriv->flags & FLAG_MIC_CAPABLE)
+				airo_read_mic( apriv );
 		}
 		if ( status & EV_LINK ) {
 #if WIRELESS_EXT > 13
@@ -2118,10 +2059,14 @@
 					index = i;
 					/* Set up to be used again */
 					apriv->fids[i] &= 0xffff;
+
+					if (i < MAX_FIDS / 2)
+						netif_wake_queue(dev);
+					else
+						netif_wake_queue(apriv->wifidev);
 				}
 			}
 			if (index != -1) {
-				netif_wake_queue(dev);
 				if (status & EV_TXEXC)
 					get_tx_error(apriv, index);
 			}
@@ -2137,6 +2082,7 @@
 
 	if (savedInterrupts)
 		OUT4500( apriv, EVINTEN, savedInterrupts );
+	spin_unlock(&apriv->main_lock);
 
 	/* done.. */
 	return;
@@ -2172,8 +2118,8 @@
 	return rc;
 }
 
-static int enable_MAC( struct airo_info *ai, Resp *rsp ) {
-	int rc;
+static int enable_MAC( struct airo_info *ai, Resp *rsp )
+{
         Cmd cmd;
 
 	/* FLAG_RADIO_OFF : Radio disabled via /proc or Wireless Extensions
@@ -2185,45 +2131,41 @@
 	if (ai->flags & (FLAG_RADIO_OFF|FLAG_RADIO_DOWN)) return SUCCESS;
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.cmd = MAC_ENABLE;
-	if (test_bit(FLAG_LOCKED, &ai->flags) != 0)
-		return issuecommand(ai, &cmd, rsp);
-
-	if (down_interruptible(&ai->sem))
-		return -ERESTARTSYS;
-	rc = issuecommand(ai, &cmd, rsp);
-	up(&ai->sem);
-	return rc;
+	return issuecommand(ai, &cmd, rsp);
 }
 
-static void disable_MAC( struct airo_info *ai ) {
+static void disable_MAC(struct airo_info *ai)
+{
         Cmd cmd;
 	Resp rsp;
 
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.cmd = MAC_DISABLE; // disable in case already enabled
-	if (test_bit(FLAG_LOCKED, &ai->flags) != 0) {
-		issuecommand(ai, &cmd, &rsp);
-		return;
-	}
-
-	if (down_interruptible(&ai->sem))
-		return;
 	issuecommand(ai, &cmd, &rsp);
-	up(&ai->sem);
 }
 
-static void enable_interrupts( struct airo_info *ai ) {
+static void enable_interrupts(struct airo_info *ai)
+{
+	unsigned long flags;
+	u16 status;
+	spin_lock_irqsave(&ai->main_lock, flags);
+	
 	/* Reset the status register */
-	u16 status = IN4500( ai, EVSTAT );
+	status = IN4500( ai, EVSTAT );
 	OUT4500( ai, EVACK, status );
+
 	/* Enable the interrupts */
 	OUT4500( ai, EVINTEN, STATUS_INTS );
-	/* Note there is a race condition between the last two lines that
-	   I dont know how to get rid of right now... */
+
+	spin_unlock_irqrestore(&ai->main_lock, flags);
 }
 
-static void disable_interrupts( struct airo_info *ai ) {
+static void disable_interrupts(struct airo_info *ai)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&ai->main_lock, flags);
 	OUT4500( ai, EVINTEN, 0 );
+	spin_unlock_irqrestore(&ai->main_lock, flags);
 }
 
 static u16 setup_card(struct airo_info *ai, u8 *mac)
@@ -2246,23 +2188,20 @@
 	/* The NOP is the first step in getting the card going */
 	cmd.cmd = NOP;
 	cmd.parm0 = cmd.parm1 = cmd.parm2 = 0;
-	if (down_interruptible(&ai->sem))
+	if (spin_is_locked(&ai->main_lock))
 		return ERROR;
-	if ( issuecommand( ai, &cmd, &rsp ) != SUCCESS ) {
-		up(&ai->sem);
+	if (issuecommand(ai, &cmd, &rsp) != SUCCESS)
 		return ERROR;
-	}
+
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.cmd = MAC_DISABLE; // disable in case already enabled
-	if ( issuecommand( ai, &cmd, &rsp ) != SUCCESS ) {
-		up(&ai->sem);
+	if (issuecommand( ai, &cmd, &rsp) != SUCCESS )
 		return ERROR;
-	}
+
 
 	// Let's figure out if we need to use the AUX port
 	cmd.cmd = CMD_ENABLEAUX;
 	if (issuecommand(ai, &cmd, &rsp) != SUCCESS) {
-		up(&ai->sem);
 		printk(KERN_ERR "airo: Error checking for AUX port\n");
 		return ERROR;
 	}
@@ -2273,7 +2212,7 @@
 		ai->bap_read = aux_bap_read;
 		printk(KERN_DEBUG "airo: Doing AUX bap_reads\n");
 	}
-	up(&ai->sem);
+
 	if (ai->config.len == 0) {
 		tdsRssiRid rssi_rid;
 		CapabilityRid cap_rid;
@@ -2378,50 +2317,35 @@
 	}
 	return SUCCESS;
 }
+static int issuecommand(struct airo_info *ai, Cmd *pCmd, Resp *pRsp) {
+	int rc;
+	unsigned long flags;
 
-static u16 issuecommand(struct airo_info *ai, Cmd *pCmd, Resp *pRsp) {
-        // Im really paranoid about letting it run forever!
-	int max_tries = 600000;
-
-	if (sendcommand(ai, pCmd) == (u16)ERROR)
-		return ERROR;
-
-	while (max_tries-- && (IN4500(ai, EVSTAT) & EV_CMD) == 0) {
-		if (!in_interrupt() && (max_tries & 255) == 0)
-			schedule();
-	}
-	if ( max_tries == -1 ) {
-		printk( KERN_ERR
-			"airo: Max tries exceeded waiting for command\n" );
-                return ERROR;
-	}
-	completecommand(ai, pRsp);
-	return SUCCESS;
+	spin_lock_irqsave(&ai->main_lock, flags);
+	rc = issuecommand_nolock(ai, pCmd, pRsp);
+	spin_unlock_irqrestore(&ai->main_lock, flags);
+	return rc;
 }
 
-static u16 sendcommand(struct airo_info *ai, Cmd *pCmd) {
-        // Im really paranoid about letting it run forever!
+static int issuecommand_nolock(struct airo_info *ai, Cmd *pCmd, Resp *pRsp) {
+	// Im really paranoid about letting it run forever!
 	int max_tries = 600000;
-	u16 cmd;
 
 	OUT4500(ai, PARAM0, pCmd->parm0);
 	OUT4500(ai, PARAM1, pCmd->parm1);
 	OUT4500(ai, PARAM2, pCmd->parm2);
 	OUT4500(ai, COMMAND, pCmd->cmd);
-	while ( max_tries-- && (IN4500(ai, EVSTAT) & EV_CMD) == 0 &&
-		(cmd = IN4500(ai, COMMAND)) != 0 )
-			if (cmd == pCmd->cmd)
-				// PC4500 didn't notice command, try again
-				OUT4500(ai, COMMAND, pCmd->cmd);
-	if ( max_tries == -1 ) {
+	while (max_tries-- && (IN4500(ai, EVSTAT) & EV_CMD) == 0) {
+		if (IN4500(ai, COMMAND) == pCmd->cmd) {
+			// PC4500 didn't notice command, try again
+			OUT4500(ai, COMMAND, pCmd->cmd);
+		}
+	}
+	if (max_tries == -1) {
 		printk( KERN_ERR
 			"airo: Max tries exceeded when issueing command\n" );
                 return ERROR;
 	}
-	return SUCCESS;
-}
-
-static void completecommand(struct airo_info *ai, Resp *pRsp) {
 	// command completed
 	pRsp->status = IN4500(ai, STATUS);
 	pRsp->rsp0 = IN4500(ai, RESP0);
@@ -2434,8 +2358,10 @@
 	}
 	// acknowledge processing the status/response
 	OUT4500(ai, EVACK, EV_CMD);
+	return SUCCESS;
 }
 
+
 /* Sets up the bap to start exchange data.  whichbap should
  * be one of the BAP0 or BAP1 defines.  Locks should be held before
  * calling! */
@@ -2500,9 +2426,7 @@
 	u16 next;
 	int words;
 	int i;
-	long flags;
 
-	spin_lock_irqsave(&ai->aux_lock, flags);
 	page = IN4500(ai, SWS0+whichbap);
 	offset = IN4500(ai, SWS2+whichbap);
 	next = aux_setup(ai, page, offset, &len);
@@ -2522,7 +2446,6 @@
 			next = aux_setup(ai, next, 4, &len);
 		}
 	}
-	spin_unlock_irqrestore(&ai->aux_lock, flags);
 	return SUCCESS;
 }
 
@@ -2561,7 +2484,7 @@
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.cmd = accmd;
 	cmd.parm0 = rid;
-	status = issuecommand(ai, &cmd, &rsp);
+	status = issuecommand_nolock(ai, &cmd, &rsp);
 	if (status != 0) return status;
 	if ( (rsp.status & 0x7F00) != 0) {
 		return (accmd << 8) + (rsp.rsp0 & 0xFF);
@@ -2570,25 +2493,16 @@
 }
 
 /*  Note, that we are using BAP1 which is also used by transmit, so
- *  we must get a lock. */
-static int PC4500_readrid(struct airo_info *ai, u16 rid, void *pBuf, int len)
+ *  it must be called with main_lock held. */
+static int PC4500_readrid_nolock(struct airo_info *ai, u16 rid, void *pBuf, int len)
 {
-	u16 status, dolock = 0;
-        int rc = SUCCESS;
+	u16 status;
+
+	if ((status = PC4500_accessrid(ai, rid, CMD_ACCESS)) != SUCCESS)
+                return status;
+	if (bap_setup(ai, rid, 0, BAP1) != SUCCESS)
+                return ERROR;
 
-	if (test_bit(FLAG_LOCKED, &ai->flags) == 0) {
-		dolock = 1;
-		if (down_interruptible(&ai->sem))
-			return ERROR;
-	}
-	if ( (status = PC4500_accessrid(ai, rid, CMD_ACCESS)) != SUCCESS) {
-                rc = status;
-                goto done;
-        }
-	if (bap_setup(ai, rid, 0, BAP1) != SUCCESS) {
-		rc = ERROR;
-                goto done;
-        }
 	// read the rid length field
 	bap_read(ai, pBuf, 2, BAP1);
 	// length for remaining part of rid
@@ -2599,30 +2513,34 @@
 			"airo: Rid %x has a length of %d which is too short\n",
 			(int)rid,
 			(int)len );
-		rc = ERROR;
-                goto done;
+		return ERROR;
 	}
 	// read remainder of the rid
-	rc = bap_read(ai, ((u16*)pBuf)+1, len, BAP1);
-done:
-	if (dolock)
-		up(&ai->sem);
-	return rc;
+	return bap_read(ai, ((u16*)pBuf)+1, len, BAP1);
 }
 
+static int PC4500_readrid(struct airo_info *ai, u16 rid, void *pBuf, int len)
+{
+	unsigned long flags;
+	int rc;
+	
+	spin_lock_irqsave(&ai->main_lock, flags);
+	rc = PC4500_readrid_nolock(ai, rid, pBuf, len);
+	spin_unlock_irqrestore(&ai->main_lock, flags);
+	return rc;
+}
 /*  Note, that we are using BAP1 which is also used by transmit, so
  *  make sure this isnt called when a transmit is happening */
 static int PC4500_writerid(struct airo_info *ai, u16 rid,
 			   const void *pBuf, int len)
 {
-	u16 status, dolock = 0;
+	u16 status;
+	unsigned long flags;
 	int rc = SUCCESS;
 
-	if (test_bit(FLAG_LOCKED, &ai->flags) == 0) {
-		dolock = 1;
-		if (down_interruptible(&ai->sem))
-			return ERROR;
-	}
+	*(u16*)pBuf = cpu_to_le16((u16)len);
+
+	spin_lock_irqsave(&ai->main_lock, flags);
 	// --- first access so that we can write the rid data
 	if ( (status = PC4500_accessrid(ai, rid, CMD_ACCESS)) != 0) {
                 rc = status;
@@ -2636,9 +2554,8 @@
 	bap_write(ai, pBuf, len, BAP1);
 	// ---now commit the rid data
 	rc = PC4500_accessrid(ai, rid, 0x100|CMD_ACCESS);
- done:
-	if (dolock)
-		up(&ai->sem);
+done:
+	spin_unlock_irqrestore(&ai->main_lock, flags);
         return rc;
 }
 
@@ -2646,6 +2563,8 @@
    one for now. */
 static u16 transmit_allocate(struct airo_info *ai, int lenPayload, int raw)
 {
+	unsigned long flags;
+	unsigned int loop = 3000;
 	Cmd cmd;
 	Resp rsp;
 	u16 txFid;
@@ -2653,20 +2572,25 @@
 
 	cmd.cmd = CMD_ALLOCATETX;
 	cmd.parm0 = lenPayload;
-	if (down_interruptible(&ai->sem))
-		return ERROR;
-	if (issuecommand(ai, &cmd, &rsp) != SUCCESS) {
-		txFid = 0;
+	spin_lock_irqsave(&ai->main_lock, flags);
+	if (issuecommand_nolock(ai, &cmd, &rsp) != SUCCESS) {
+		txFid = ERROR;
 		goto done;
 	}
 	if ( (rsp.status & 0xFF00) != 0) {
-		txFid = 0;
+		txFid = ERROR;
 		goto done;
 	}
+
 	/* wait for the allocate event/indication
-	 * It makes me kind of nervous that this can just sit here and spin,
-	 * but in practice it only loops like four times. */
-	while ( (IN4500(ai, EVSTAT) & EV_ALLOC) == 0) ;
+	 * in practice it only loops like four times. */
+	while (((IN4500(ai, EVSTAT) & EV_ALLOC) == 0) && --loop)
+	       ; /* nada */
+	if (!loop) {
+		txFid = ERROR;
+		goto done;
+	}
+
 	// get the allocated fid and acknowledge
 	txFid = IN4500(ai, TXALLOCFID);
 	OUT4500(ai, EVACK, EV_ALLOC);
@@ -2688,7 +2612,7 @@
 		bap_write(ai, &txControl, sizeof(txControl), BAP1);
 
 done:
-	up(&ai->sem);
+	spin_unlock_irqrestore(&ai->main_lock, flags);
 
 	return txFid;
 }
@@ -2696,17 +2620,14 @@
 /* In general BAP1 is dedicated to transmiting packets.  However,
    since we need a BAP when accessing RIDs, we also use BAP1 for that.
    Make sure the BAP1 spinlock is held when this is called. */
-static int transmit_802_3_packet(struct airo_info *ai, int len, char *pPacket)
+static int transmit_802_3_packet(struct airo_info *ai, u16 txFid, char *pPacket, int len)
 {
 	u16 payloadLen;
 	Cmd cmd;
 	Resp rsp;
 	int miclen = 0;
-	u16 txFid = len;
 	MICBuffer pMic;
 
-	len >>= 16;
-
 	if (len < ETH_ALEN * 2) {
 		printk( KERN_WARNING "Short packet %d\n", len );
 		return ERROR;
@@ -2737,12 +2658,12 @@
 	memset( &cmd, 0, sizeof( cmd ) );
 	cmd.cmd = CMD_TRANSMIT;
 	cmd.parm0 = txFid;
-	if (issuecommand(ai, &cmd, &rsp) != SUCCESS) return ERROR;
+	if (issuecommand_nolock(ai, &cmd, &rsp) != SUCCESS) return ERROR;
 	if ( (rsp.status & 0xFF00) != 0) return ERROR;
 	return SUCCESS;
 }
 
-static int transmit_802_11_packet(struct airo_info *ai, int len, char *pPacket)
+static int transmit_802_11_packet(struct airo_info *ai, u16 txFid, char *pPacket, int len)
 {
 	u16 fc, payloadLen;
 	Cmd cmd;
@@ -2753,8 +2674,6 @@
 		u16 gaplen;
 		u8 gap[6];
 	} gap;
-	u16 txFid = len;
-	len >>= 16;
 	gap.gaplen = 6;
 
 	fc = le16_to_cpu(*(const u16*)pPacket);
@@ -2796,7 +2715,7 @@
 	memset( &cmd, 0, sizeof( cmd ) );
 	cmd.cmd = CMD_TRANSMIT;
 	cmd.parm0 = txFid;
-	if (issuecommand(ai, &cmd, &rsp) != SUCCESS) return ERROR;
+	if (issuecommand_nolock(ai, &cmd, &rsp) != SUCCESS) return ERROR;
 	if ( (rsp.status & 0xFF00) != 0) return ERROR;
 	return SUCCESS;
 }
@@ -3865,10 +3784,7 @@
 
 			memset(&cmd, 0, sizeof(cmd));
 			cmd.cmd=CMD_LISTBSS;
-			if (down_interruptible(&ai->sem))
-				return -ERESTARTSYS;
 			issuecommand(ai, &cmd, &rsp);
-			up(&ai->sem);
 			data->readlen = 0;
 			return 0;
 		}
@@ -3932,13 +3848,6 @@
 
 	if (!(apriv->flags & FLAG_FLASHING) && (linkstat != 0x400)) {
 /* We don't have a link so try changing the authtype */
-		if (down_trylock(&apriv->sem) != 0) {
-			apriv->timer.expires = RUN_AT(1);
-			add_timer(&apriv->timer);
-			return;
-		}
-		__set_bit(FLAG_LOCKED, &apriv->flags);
-
 		readConfigRid(apriv);
 		disable_MAC(apriv);
 		switch(apriv->config.authType) {
@@ -3964,8 +3873,6 @@
 		apriv->need_commit = 1;
 		writeConfigRid(apriv);
 		enable_MAC(apriv, &rsp);
-		clear_bit(FLAG_LOCKED, &apriv->flags);
-		up(&apriv->sem);
 
 /* Schedule check to see if the change worked */
 		apriv->timer.expires = RUN_AT(HZ*3);
@@ -4144,7 +4051,11 @@
 	struct airo_info *local = dev->priv;
 	StatusRid status_rid;		/* Card status info */
 
-	readStatusRid(local, &status_rid);
+	if (local->config.opmode & MODE_STA_ESS) 
+		status_rid.channel = local->config.channelSet; 
+	else 
+		readStatusRid(local, &status_rid);
+
 
 	/* Will return zero in infrastructure mode */
 #ifdef WEXT_USECHANNELS
@@ -4255,11 +4166,8 @@
 		return -EINVAL;
 	else if (!memcmp(bcast, awrq->sa_data, ETH_ALEN)) {
 		memset(&cmd, 0, sizeof(cmd));
-		cmd.cmd=CMD_LOSE_SYNC;
-		if (down_interruptible(&local->sem))
-			return -ERESTARTSYS;
+		cmd.cmd = CMD_LOSE_SYNC;
 		issuecommand(local, &cmd, &rsp);
-		up(&local->sem);
 	} else {
 		memset(&APList_rid, 0, sizeof(APList_rid));
 		APList_rid.len = sizeof(APList_rid);
@@ -5141,11 +5049,8 @@
 	/* Initiate a scan command */
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.cmd=CMD_LISTBSS;
-	if (down_interruptible(&ai->sem))
-		return -ERESTARTSYS;
 	issuecommand(ai, &cmd, &rsp);
 	ai->scan_timestamp = jiffies;
-	up(&ai->sem);
 
 	/* At this point, just return to the user. */
 

