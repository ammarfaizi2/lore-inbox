Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265091AbUGNRCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265091AbUGNRCs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 13:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265099AbUGNRCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 13:02:47 -0400
Received: from aibo.runbox.com ([193.71.199.94]:44269 "EHLO aibo.runbox.com")
	by vger.kernel.org with ESMTP id S265091AbUGNRAX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 13:00:23 -0400
Date: Wed, 14 Jul 2004 13:00:17 -0400
From: "Victor J. Orlikowski" <victor.j.orlikowski@alumni.duke.edu>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ipw2100 wireless driver
Message-ID: <20040714170017.GA31372@peregrin>
Mail-Followup-To: kernel list <linux-kernel@vger.kernel.org>
References: <20040714114135.GA25175@elf.ucw.cz> <20040714131523.GA498@ucw.cz> <20040714134227.GA8978@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040714134227.GA8978@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 03:42:27PM +0200, Pavel Machek wrote:
> Yep, that would certainly be better. I'll wait if I get some  reply
> from ipw2100 people. If so I'll update the patch.

Pavel,

Here's some work saved for you; I don't have crypto, so this patch
is only missing edits to those bits that cover WEP in ipw2100.
This ought to allow compilation w/ gcc 2.95.

diff -ru ipw2100-0.49/ieee80211.h ipw2100-0.49-mod/ieee80211.h
--- ipw2100-0.49/ieee80211.h	Fri Jul  9 00:32:17 2004
+++ ipw2100-0.49-mod/ieee80211.h	Wed Jul 14 11:06:24 2004
@@ -440,7 +440,7 @@
 	u16 reserved;
 	u16 frag_size;
 	u16 payload_size;
-	struct sk_buff *fragments[];
+	struct sk_buff *fragments[0];
 };
 
 extern struct ieee80211_txb *ieee80211_skb_to_txb(struct ieee80211_device *ieee, 
diff -ru ipw2100-0.49/ipw2100.h ipw2100-0.49-mod/ipw2100.h
--- ipw2100-0.49/ipw2100.h	Fri Jul  9 00:32:17 2004
+++ ipw2100-0.49-mod/ipw2100.h	Wed Jul 14 12:55:01 2004
@@ -48,7 +48,7 @@
 #define work_struct tq_struct
 #define schedule_work schedule_task
 #define INIT_WORK INIT_TQUEUE
-#define get_seconds(x) CURRENT_TIME
+#define get_seconds() CURRENT_TIME
 #endif
 
 #ifndef IRQ_NONE
@@ -238,9 +238,9 @@
 
 struct bd_status {
 	union {
-		struct { u8 nlf:1, txType:2, intEnabled:1, reserved:4; };
+		struct { u8 nlf:1, txType:2, intEnabled:1, reserved:4;} fields;
 		u8 field;
-	};
+	} info;
 } __attribute__ ((packed));
 
 #define	IPW_BUFDESC_LAST_FRAG 0
@@ -402,13 +402,13 @@
 		struct { /* COMMAND */
 			struct ipw2100_cmd_header* cmd;
 			dma_addr_t cmd_phys;
-		};
+		} c_struct;
 		struct { /* DATA */
 			struct ipw2100_data_header* data;
 			dma_addr_t data_phys;
 			struct ieee80211_txb *txb;
-		};
-	};
+		} d_struct;
+	} info;
 	int jiffy_start;
 
 	struct list_head list;
@@ -857,7 +857,7 @@
 		u32 status;
 		struct ipw2100_notification notification;
 		struct ipw2100_cmd_header command;
-	};
+	} rx_data;
 } __attribute__ ((packed));
 
 // Bit 0-7 are for 802.11b tx rates - .  Bit 5-7 are reserved  
diff -ru ipw2100-0.49/ipw2100_main.c ipw2100-0.49-mod/ipw2100_main.c
--- ipw2100-0.49/ipw2100_main.c	Fri Jul  9 00:32:17 2004
+++ ipw2100-0.49-mod/ipw2100_main.c	Wed Jul 14 12:49:56 2004
@@ -402,7 +402,7 @@
 	if (IS_ORDINAL_TABLE_ONE(ordinals, ord)) {
 		if (*len != IPW_ORD_TAB_1_ENTRY_SIZE) {
 			*len = IPW_ORD_TAB_1_ENTRY_SIZE;
-			IPW2100_DEBUG_INFO("wrong size\n");
+			IPW2100_DEBUG_INFO("%s", "wrong size\n");
 			return -EINVAL;
 		}
 
@@ -416,7 +416,7 @@
 		return 0;
 	} 
 
-	IPW2100_DEBUG_INFO("wrong table\n");
+	IPW2100_DEBUG_INFO("%s", "wrong table\n");
 	if (IS_ORDINAL_TABLE_TWO(ordinals, ord)) 
 		return -EINVAL;
 
@@ -443,28 +443,25 @@
 	spin_lock_irqsave(&priv->low_lock, flags);
 
 	if (priv->fatal_error) {
-		IPW2100_DEBUG_INFO("Attempt to send command while hardware "
-				   "in fatal error condition.");
+		IPW2100_DEBUG_INFO("%s", "Attempt to send command while hardware in fatal error condition.");
 		err = -EIO;
 		goto fail_unlock;
 	}
 
 	if (priv->stopped) {
-		IPW2100_DEBUG_INFO("Attempt to send command while hardware "
-				   "is not running.");
+		IPW2100_DEBUG_INFO("%s", "Attempt to send command while hardware is not running.");
 		err = -EIO;
 		goto fail_unlock;
 	}
 
 	if (priv->message_sending) {
-		IPW2100_DEBUG_INFO("Attempt to send command while hardware "
-				   "another command is pending.");
+		IPW2100_DEBUG_INFO("%s", "Attempt to send command while hardware another command is pending.");
 		err = -EBUSY;
 		goto fail_unlock;
 	}
 
 	if (list_empty(&priv->msg_free_list)) {
-		IPW2100_DEBUG_INFO("no available msg buffers\n");
+		IPW2100_DEBUG_INFO("%s", "no available msg buffers\n");
 		goto fail_unlock;
 	}
 
@@ -477,14 +474,14 @@
 	packet->jiffy_start = jiffies;
 
 	/* initialize the firmware command packet */
-	packet->cmd->host_command_reg = cmd->host_command;
-	packet->cmd->host_command_reg1 = cmd->host_command1;
-	packet->cmd->host_command_len_reg = cmd->host_command_length;
-	packet->cmd->sequence = cmd->host_command_sequence;
+	packet->info.c_struct.cmd->host_command_reg = cmd->host_command;
+	packet->info.c_struct.cmd->host_command_reg1 = cmd->host_command1;
+	packet->info.c_struct.cmd->host_command_len_reg = cmd->host_command_length;
+	packet->info.c_struct.cmd->sequence = cmd->host_command_sequence;
 
-	memcpy(packet->cmd->host_command_params_reg,
+	memcpy(packet->info.c_struct.cmd->host_command_params_reg,
 	       cmd->host_command_parameters,
-	       sizeof(packet->cmd->host_command_params_reg));
+	       sizeof(packet->info.c_struct.cmd->host_command_params_reg));
 
 	list_del(element);
 	DEC_STAT(&priv->msg_free_stat);
@@ -603,7 +600,7 @@
 		err = ipw2100_get_ordinal(priv, IPW_ORD_CARD_DISABLED, 
 					  &card_disabled, &len);
 		if (err) {
-			IPW2100_DEBUG_INFO("query failed.\n");
+			IPW2100_DEBUG_INFO("%s", "query failed.\n");
 			break;
 		}
 
@@ -820,7 +817,7 @@
 {
 	struct ipw2100_ordinals *ord = &priv->ordinals;
 
-	IPW2100_DEBUG_INFO("enter\n");
+	IPW2100_DEBUG_INFO("%s", "enter\n");
 
 	read_register(priv->ndev, IPW_MEM_HOST_SHARED_ORDINALS_TABLE_1,
 		      &ord->table1_addr);
@@ -835,7 +832,7 @@
 
 	IPW2100_DEBUG_INFO("table 1 size: %d\n", ord->table1_size);
 	IPW2100_DEBUG_INFO("table 2 size: %d\n", ord->table2_size);
-	IPW2100_DEBUG_INFO("exit\n");
+	IPW2100_DEBUG_INFO("%s", "exit\n");
 }
 
 static inline void ipw2100_hw_set_gpio(struct ipw2100_priv *priv)
@@ -969,7 +966,7 @@
 	int i;
 	u32 r;
 
-	IPW2100_DEBUG_INFO("enter\n");
+	IPW2100_DEBUG_INFO("%s", "enter\n");
 
 	if (!priv->stopped)
 		return 0;
@@ -996,7 +993,7 @@
 	write_register(priv->ndev, IPW_REG_RESET_REG, 0);
 
 	/* wait for f/w intialization complete */
-	IPW2100_DEBUG_FW("Waiting for f/w initialization to complete...\n");
+	IPW2100_DEBUG_FW("%s", "Waiting for f/w initialization to complete...\n");
 	i = 5000;
 	do {
   		set_current_state(TASK_UNINTERRUPTIBLE);
@@ -1049,7 +1046,7 @@
 
 	priv->stopped = 0;
 
-	IPW2100_DEBUG_INFO("exit\n");
+	IPW2100_DEBUG_INFO("%s", "exit\n");
 
 	return 0;
 }
@@ -1083,7 +1080,7 @@
 	u32 reg;
 	int i;
 
-	IPW2100_DEBUG_INFO("Power cycling the hardware.\n");
+	IPW2100_DEBUG_INFO("%s", "Power cycling the hardware.\n");
 
 	ipw2100_hw_set_gpio(priv);
 
@@ -1105,8 +1102,7 @@
 	priv->reset_pending = 0;
 
 	if (!i) {
-		IPW2100_DEBUG_INFO("exit - waited too long for master assert "
-		       "stop\n");
+		IPW2100_DEBUG_INFO("%s", "exit - waited too long for master assert stop\n");
 		return -EIO;
 	}
 
@@ -1148,7 +1144,7 @@
 	if (priv->phy_off == 1)
 		return 0;
 
-	IPW2100_DEBUG_FW_COMMAND("CARD_DISABLE_PHY_OFF\n");
+	IPW2100_DEBUG_FW_COMMAND("%s", "CARD_DISABLE_PHY_OFF\n");
 
 	/* Turn off the radio */
 	err = ipw2100_hw_send_command(priv, &cmd);
@@ -1182,14 +1178,14 @@
 	};
 	int err;
 
-	IPW2100_DEBUG_FW_COMMAND("HOST_COMPLETE\n");
+	IPW2100_DEBUG_FW_COMMAND("%s", "HOST_COMPLETE\n");
 	
 	if (!priv->disabled) 
 		return 0;
 
 	err = ipw2100_hw_send_command(priv, &cmd);
 	if (err) {
-		IPW2100_DEBUG_INFO("Failed to send HOST_COMPLETE command\n");
+		IPW2100_DEBUG_INFO("%s", "Failed to send HOST_COMPLETE command\n");
 		return err;
 	}
 
@@ -1201,7 +1197,7 @@
 		return err;
 	}
 
-	IPW2100_DEBUG_INFO("TODO: implement scan state machine\n");
+	IPW2100_DEBUG_INFO("%s", "TODO: implement scan state machine\n");
 
 	return 0;
 }
@@ -1253,7 +1249,7 @@
 		 * event. Therefore, skip waiting for it.  Just wait a fixed 
 		 * 100ms
 		 */
-		IPW2100_DEBUG_FW_COMMAND("HOST_PRE_POWER_DOWN\n");
+		IPW2100_DEBUG_FW_COMMAND("%s", "HOST_PRE_POWER_DOWN\n");
 		
 		err = ipw2100_hw_send_command(priv, &cmd);
 		if (err) 
@@ -1321,26 +1317,24 @@
 	};
 	int err;
 
-	IPW2100_DEBUG_FW_COMMAND("CARD_DISABLE\n");
+	IPW2100_DEBUG_FW_COMMAND("%s", "CARD_DISABLE\n");
 
 	if (priv->disabled) 
 		return 0;
 
 	err = ipw2100_hw_send_command(priv, &cmd);
 	if (err) {
-		IPW2100_DEBUG_WARNING("exit - failed to send CARD_DISABLE "
-				      "command\n");
+		IPW2100_DEBUG_WARNING("%s", "exit - failed to send CARD_DISABLE command\n");
 		return err;
 	}
 
 	err = ipw2100_wait_for_card_state(priv, STATE_DISABLED);
 	if (err) {
-		IPW2100_DEBUG_WARNING("exit - card failed to change to "
-				      "DISABLED\n");
+		IPW2100_DEBUG_WARNING("%s", "exit - card failed to change to DISABLED\n");
 		return err;
 	}
 
-	IPW2100_DEBUG_INFO("TODO: implement scan state machine\n");
+	IPW2100_DEBUG_INFO("%s", "TODO: implement scan state machine\n");
 
 
 	return 0;
@@ -1545,7 +1539,7 @@
 	u32 chan;
 	char *txratename;
 
-	IPW2100_DEBUG_INFO("enter\n");
+	IPW2100_DEBUG_INFO("%s", "enter\n");
 
 	/*
 	 * TBD: BSSID is usually 00:00:00:00:00:00 here and not
@@ -1639,11 +1633,9 @@
 
 	printk(KERN_DEBUG "%s: Association lost.\n", priv->ndev->name);
 
-	IPW2100_DEBUG_INFO("TODO: only scan if scanning enabled and "
-	       "radio is on\n");
+	IPW2100_DEBUG_INFO("%s", "TODO: only scan if scanning enabled and radio is on\n");
 
-	IPW2100_DEBUG_INFO("TODO: Move broadcast_scan initiation to scheduled "
-	       "work\n");
+	IPW2100_DEBUG_INFO("%s", "TODO: Move broadcast_scan initiation to scheduled work\n");
 
 #if 0
 	ipw2100_hw_send_command(priv, &cmd);
@@ -1680,7 +1672,7 @@
 
 static void isr_scan_complete(struct ipw2100_priv *priv, u32 status)
 {
-	IPW2100_DEBUG_SCAN("scan complete\n");
+	IPW2100_DEBUG_SCAN("%s", "scan complete\n");
 	/* Age the scan results... */
 	priv->scans++;
 	priv->in_scan = 0;
@@ -1762,7 +1754,7 @@
 	wake_up_interruptible(&priv->wait_command_queue);
 
 #ifdef CONFIG_IPW2100_DEBUG
-	IPW2100_DEBUG_INFO("received command status:\n");
+	IPW2100_DEBUG_INFO("%s", "received command status:\n");
 	IPW2100_DEBUG_INFO("    CMD    = %d\n", cmd->host_command_reg);
 	IPW2100_DEBUG_INFO("    CMD1   = %08x\n", cmd->host_command_reg1);
 	IPW2100_DEBUG_INFO("    SEQ    = %d\n", cmd->sequence);
@@ -1776,7 +1768,7 @@
 	struct ieee80211_hdr *header,
 	struct ipw2100_status *status)
 {
-	IPW2100_DEBUG_RX("Ignoring control frame.\n");
+	IPW2100_DEBUG_RX("%s", "Ignoring control frame.\n");
 }
 
 static inline void isr_beacon_add(
@@ -1924,12 +1916,12 @@
 	}
 
 	if (list_empty(&priv->beacon_free_list)) {
-		IPW2100_DEBUG_SCAN("TODO: Expire oldest beacon to add new.\n");
+		IPW2100_DEBUG_SCAN("%s", "TODO: Expire oldest beacon to add new.\n");
 		printk(KERN_WARNING DRV_NAME ": Beacon free list is empty.\n");
 	} else 
 		isr_beacon_add(priv, new_beacon, rssi);
 
-	IPW2100_DEBUG_SCAN("exit\n");
+	IPW2100_DEBUG_SCAN("%s", "exit\n");
 }
 	
 static void isr_handle_mgt_packet(
@@ -1950,7 +1942,7 @@
 
 	case IEEE802_11_STYPE_PROBE_RESP:
 		msg = "PROBE RESPONSE";
-		IPW2100_DEBUG_SCAN("Probe response\n");
+		IPW2100_DEBUG_SCAN("%s", "Probe response\n");
 		isr_process_probe_response(
 			priv, (struct ieee80211_probe_response *)header,
 			status->rssi);
@@ -1958,7 +1950,7 @@
 
 	case IEEE802_11_STYPE_BEACON:
 		msg = "BEACON";
-		IPW2100_DEBUG_SCAN("Beacon\n");
+		IPW2100_DEBUG_SCAN("%s","Beacon\n");
 		isr_process_probe_response(
 			priv, (struct ieee80211_probe_response *)header,
 			status->rssi);
@@ -2201,7 +2193,7 @@
 		.mac_time = jiffies,
 	};
 
-	IPW2100_DEBUG_RX("Handler...\n");
+	IPW2100_DEBUG_RX("%s", "Handler...\n");
 
 	if (unlikely(status->frame_size > skb_tailroom(packet->skb))) {
 		printk(KERN_INFO "%s: frame_size (%u) > skb_tailroom (%u)!"
@@ -2245,7 +2237,7 @@
 		       "%s: Unable to allocate SKB onto RBD ring - disabling "
 		       "adapter.\n", priv->ndev->name);
 		/* TODO: schedule adapter shutdown */
-		IPW2100_DEBUG_INFO("TODO: Shutdown adapter...\n");
+		IPW2100_DEBUG_INFO("%s", "TODO: Shutdown adapter...\n");
 	}
 
 	/* Update the RDB entry */
@@ -2260,17 +2252,17 @@
 
 	switch (frame_type) {
 	case COMMAND_STATUS_VAL:
-		return (status->frame_size != sizeof(u->command));
+		return (status->frame_size != sizeof(u->rx_data.command));
 	case STATUS_CHANGE_VAL:
-		return (status->frame_size != sizeof(u->status));
+		return (status->frame_size != sizeof(u->rx_data.status));
 	case HOST_NOTIFICATION_VAL:
-		return (status->frame_size < sizeof(u->notification));
+		return (status->frame_size < sizeof(u->rx_data.notification));
 	case P80211_DATA_VAL:
 	case P8023_DATA_VAL:
 #ifdef CONFIG_IPW2100_PROMISC
 		return 0;
 #else
-		switch (WLAN_FC_GET_TYPE(u->header.frame_control)) {
+		switch (WLAN_FC_GET_TYPE(u->rx_data.header.frame_control)) {
 		case IEEE802_11_FTYPE_MGMT:
 		case IEEE802_11_FTYPE_CTL:
 			return 0;
@@ -2322,7 +2314,7 @@
 	read_register(priv->ndev, IPW_MEM_HOST_SHARED_RX_WRITE_INDEX, &w);
 	
 	if (r >= rxq->entries) {
-		IPW2100_DEBUG_RX("exit - bad read index\n");
+		IPW2100_DEBUG_RX("%s", "exit - bad read index\n");
 		return;
 	}
 
@@ -2364,11 +2356,11 @@
 		
 			switch (frame_type) {
 			case COMMAND_STATUS_VAL:
-				isr_rx_complete_command(priv, &u->command);
+				isr_rx_complete_command(priv, &u->rx_data.command);
 				break;
 				
 			case STATUS_CHANGE_VAL:
-				isr_status_change(priv, u->status);
+				isr_status_change(priv, u->rx_data.status);
 				break;
 				
 			case P80211_DATA_VAL:
@@ -2379,16 +2371,16 @@
 					break;
 				}
 #endif
-				if (frame_size < sizeof(u->header))
+				if (frame_size < sizeof(u->rx_data.header))
 					break;
-				switch (WLAN_FC_GET_TYPE(u->header.frame_control)) {
+				switch (WLAN_FC_GET_TYPE(u->rx_data.header.frame_control)) {
 				case IEEE802_11_FTYPE_MGMT:
-					isr_handle_mgt_packet(priv, &u->header,
+					isr_handle_mgt_packet(priv, &u->rx_data.header,
 							      &sq->drv[i]);
 					break;
 					
 				case IEEE802_11_FTYPE_CTL:
-					isr_handle_ctl_packet(priv, &u->header,
+					isr_handle_ctl_packet(priv, &u->rx_data.header,
 							      &sq->drv[i]);
 					break;
 					
@@ -2397,9 +2389,8 @@
 					 * interface is open */
 					if (!priv->open) {
 						priv->wstats.discard.misc++;
-						IPW2100_DEBUG_DROP(
-							"Dropping packet while "
-							"interface is not up.\n");
+						IPW2100_DEBUG_DROP("%s",
+							"Dropping packet while interface is not up.\n");
 						break;
 					}
 					
@@ -2412,7 +2403,7 @@
 		}
 
 		/* clear status field associated with this RBD */
-		rxq->drv[i].status.field = 0;
+		rxq->drv[i].status.info.field = 0;
 		
 		i = (i + 1) % rxq->entries;
 	}
@@ -2543,8 +2534,7 @@
 	 *
 	 */
 	if (!((r <= w && (e < r || e >= w)) || (e < r && e >= w))) { 
-		IPW2100_DEBUG_TX("exit - no processed packets ready to "
-				 "release.\n");
+		IPW2100_DEBUG_TX("%s", "exit - no processed packets ready to release.\n");
 		return 0;
 	}
 
@@ -2577,7 +2567,7 @@
  
 	switch (packet->type) {
 	case DATA:
-		if (txq->drv[txq->oldest].status.txType != 0) 
+		if (txq->drv[txq->oldest].status.info.fields.txType != 0) 
 			printk(KERN_WARNING "%s: Queue mismatch.  "
 			       "Expecting DATA TBD but pulled "
 			       "something else: ids %d=%d.\n", 
@@ -2600,9 +2590,9 @@
 					 PCI_DMA_TODEVICE);
 		}
 
-		priv->ieee->stats.tx_bytes += packet->txb->payload_size;
-		ieee80211_txb_free(packet->txb);
-		packet->txb = NULL;
+		priv->ieee->stats.tx_bytes += packet->info.d_struct.txb->payload_size;
+		ieee80211_txb_free(packet->info.d_struct.txb);
+		packet->info.d_struct.txb = NULL;
 
 		list_add_tail(element, &priv->tx_free_list);
 		INC_STAT(&priv->tx_free_stat);
@@ -2624,20 +2614,20 @@
 		break;
 
 	case COMMAND:
-		if (txq->drv[txq->oldest].status.txType != 1) 
+		if (txq->drv[txq->oldest].status.info.fields.txType != 1) 
 			printk(KERN_WARNING "%s: Queue mismatch.  "
 			       "Expecting COMMAND TBD but pulled "
 			       "something else: ids %d=%d.\n", 
 			       priv->ndev->name, txq->oldest, packet->index);
 
 #ifdef CONFIG_IPW2100_DEBUG
-		if (packet->cmd->host_command_reg <
+		if (packet->info.c_struct.cmd->host_command_reg <
 		    sizeof(command_types) / sizeof(*command_types)) 
 			IPW2100_DEBUG_TX(
 				"Command '%s (%d)' processed: %d.\n",
-				command_types[packet->cmd->host_command_reg],
-				packet->cmd->host_command_reg,
-				packet->cmd->cmd_status_reg);
+				command_types[packet->info.c_struct.cmd->host_command_reg],
+				packet->info.c_struct.cmd->host_command_reg,
+				packet->info.c_struct.cmd->cmd_status_reg);
 #endif
 
 		list_add_tail(element, &priv->msg_free_list);
@@ -2688,7 +2678,7 @@
 		 *       maintained between the r and w indexes
 		 */
 		if (txq->available <= 3) {
-			IPW2100_DEBUG_TX("no room in tx_queue\n");
+			IPW2100_DEBUG_TX("%s", "no room in tx_queue\n");
 			break;
 		}
 
@@ -2709,12 +2699,12 @@
 		tbd = &txq->drv[txq->next];
 
 		/* initialize TBD */
-		tbd->host_addr = packet->cmd_phys;
+		tbd->host_addr = packet->info.c_struct.cmd_phys;
 		tbd->buf_length = sizeof(struct ipw2100_cmd_header);
 		/* not marking number of fragments causes problems 
 		 * with f/w debug version */
 		tbd->num_fragments = 1;
-		tbd->status.field =
+		tbd->status.info.field =
 			IPW_BD_STATUS_TX_FRAME_COMMAND |
 			IPW_BD_STATUS_TX_INTERRUPT_ENABLE;
 
@@ -2762,7 +2752,7 @@
 		element = priv->tx_pend_list.next;
                 packet = list_entry(element, struct ipw2100_tx_packet, list);
 
-		if (unlikely(1 + packet->txb->nr_frags > IPW_MAX_BDS)) {
+		if (unlikely(1 + packet->info.d_struct.txb->nr_frags > IPW_MAX_BDS)) {
 			/* TODO: Support merging buffers if more than 
 			 * IPW_MAX_BDS are used */
 			printk(KERN_DEBUG 
@@ -2771,8 +2761,8 @@
 			       priv->ndev->name);
 		}
 
-		if (txq->available <= 3 + packet->txb->nr_frags) {
-			IPW2100_DEBUG_TX("no room in tx_queue\n");
+		if (txq->available <= 3 + packet->info.d_struct.txb->nr_frags) {
+			IPW2100_DEBUG_TX("%s", "no room in tx_queue\n");
 			break;
 		}
 
@@ -2783,10 +2773,10 @@
 
 		packet->index = txq->next;
 
-		tbd->host_addr = packet->data_phys;
+		tbd->host_addr = packet->info.d_struct.data_phys;
 		tbd->buf_length = sizeof(struct ipw2100_data_header);
-		tbd->num_fragments = 1 + packet->txb->nr_frags;
-		tbd->status.field =
+		tbd->num_fragments = 1 + packet->info.d_struct.txb->nr_frags;
+		tbd->status.info.field =
 			IPW_BD_STATUS_TX_FRAME_802_3 |
 			IPW_BD_STATUS_TX_FRAME_NOT_LAST_FRAGMENT;
 		txq->next++;
@@ -2797,27 +2787,27 @@
 			packet->index, tbd->host_addr, 
 			tbd->buf_length);
 #ifdef CONFIG_IPW2100_DEBUG
-		if (packet->txb->nr_frags > 1) 
+		if (packet->info.d_struct.txb->nr_frags > 1) 
 			IPW2100_DEBUG_FRAG("fragment Tx: %d frames\n", 
-					   packet->txb->nr_frags);
+					   packet->info.d_struct.txb->nr_frags);
 #endif
 
-                for (i = 0; i < packet->txb->nr_frags; i++) {
+                for (i = 0; i < packet->info.d_struct.txb->nr_frags; i++) {
 		        tbd = &txq->drv[txq->next];
-			if (i == packet->txb->nr_frags - 1) 
-				tbd->status.field = 
+			if (i == packet->info.d_struct.txb->nr_frags - 1) 
+				tbd->status.info.field = 
 					IPW_BD_STATUS_TX_FRAME_802_3 |
 					IPW_BD_STATUS_TX_INTERRUPT_ENABLE;
 			 else 
-				tbd->status.field =
+				tbd->status.info.field =
 					IPW_BD_STATUS_TX_FRAME_802_3 |
 					IPW_BD_STATUS_TX_FRAME_NOT_LAST_FRAGMENT;
 				
-			tbd->buf_length = packet->txb->fragments[i]->len;
+			tbd->buf_length = packet->info.d_struct.txb->fragments[i]->len;
  
                         tbd->host_addr = pci_map_single(
 				priv->pdev, 
-				packet->txb->fragments[i]->data,
+				packet->info.d_struct.txb->fragments[i]->data,
 				tbd->buf_length, 
 				PCI_DMA_TODEVICE);
 
@@ -2834,7 +2824,7 @@
 			txq->next %= txq->entries;
                 }
 		
-		txq->available -= 1 + packet->txb->nr_frags;
+		txq->available -= 1 + packet->info.d_struct.txb->nr_frags;
 		SET_STAT(&priv->txq_stat, txq->available);
 
 		list_add_tail(element, &priv->fw_pend_list);
@@ -2895,7 +2885,7 @@
 	}
 	
 	if (inta & IPW2100_INTA_PARITY_ERROR) {
-		IPW2100_DEBUG_ERROR("***** PARITY ERROR INTERRUPT !!!! \n");
+		IPW2100_DEBUG_ERROR("%s", "***** PARITY ERROR INTERRUPT !!!! \n");
 		priv->inta_other++;
 		write_register(
 			dev, IPW_REG_INTA, 
@@ -2903,7 +2893,7 @@
 	}
 
 	if (inta & IPW2100_INTA_RX_TRANSFER) {
-		IPW2100_DEBUG_ISR("RX interrupt\n");
+		IPW2100_DEBUG_ISR("%s", "RX interrupt\n");
 
 		priv->rx_interrupts++;
 
@@ -2916,7 +2906,7 @@
 	}
 	
 	if (inta & IPW2100_INTA_TX_TRANSFER) {
-		IPW2100_DEBUG_ISR("TX interrupt\n");
+		IPW2100_DEBUG_ISR("%s", "TX interrupt\n");
 
 		priv->tx_interrupts++;
 		
@@ -2929,7 +2919,7 @@
 	}
 	
 	if (inta & IPW2100_INTA_TX_COMPLETE) {
-		IPW2100_DEBUG_ISR("TX complete\n");
+		IPW2100_DEBUG_ISR("%s", "TX complete\n");
 		priv->inta_other++;
 		write_register(
 			dev, IPW_REG_INTA,
@@ -2947,7 +2937,7 @@
 	}
 	
 	if (inta & IPW2100_INTA_FW_INIT_DONE) {
-		IPW2100_DEBUG_ISR("FW init done interrupt\n");
+		IPW2100_DEBUG_ISR("%s", "FW init done interrupt\n");
 		priv->inta_other++;
 		
 		read_register(dev, IPW_REG_INTA, &tmp);
@@ -2964,7 +2954,7 @@
 	}
 	
 	if (inta & IPW2100_INTA_STATUS_CHANGE) {
-		IPW2100_DEBUG_ISR("Status change interrupt\n");
+		IPW2100_DEBUG_ISR("%s", "Status change interrupt\n");
 		priv->inta_other++;
 		write_register(
 			dev, IPW_REG_INTA,
@@ -2972,7 +2962,7 @@
 	}
 	
 	if (inta & IPW2100_INTA_SLAVE_MODE_HOST_COMMAND_DONE) {
-		IPW2100_DEBUG_ISR("slave host mode interrupt\n");
+		IPW2100_DEBUG_ISR("%s", "slave host mode interrupt\n");
 		priv->inta_other++;
 		write_register(
 			dev, IPW_REG_INTA,
@@ -2984,7 +2974,7 @@
 
 	spin_unlock_irqrestore(&priv->low_lock, flags);
 
-	IPW2100_DEBUG_ISR("exit\n");
+	IPW2100_DEBUG_ISR("%s", "exit\n");
 }
 
 
@@ -3003,7 +2993,7 @@
  	spin_lock_irqsave(&priv->low_lock, flags);
 
 	if (priv->irq_ignore) {
-		IPW2100_DEBUG_WARNING("IRQ ignored\n");
+		IPW2100_DEBUG_WARNING("%s", "IRQ ignored\n");
 		spin_unlock_irqrestore(&priv->low_lock, flags);
 		return IRQ_NONE;
 	}
@@ -3013,7 +3003,7 @@
 
 	if (inta == 0xFFFFFFFF) {
 		/* Hardware disappeared */
-		IPW2100_DEBUG_WARNING("IRQ INTA == 0xFFFFFFFF\n");
+		IPW2100_DEBUG_WARNING("%s", "IRQ INTA == 0xFFFFFFFF\n");
 		spin_unlock_irqrestore(&priv->low_lock, flags);
 		return IRQ_HANDLED;
 	}
@@ -3042,7 +3032,7 @@
 {
 	struct ipw2100_priv *priv = ipw2100_netdev(dev);
 	struct list_head *element;
-	struct ipw2100_data_header *header;
+	struct ipw2100_data_header *header = NULL;
 	struct ipw2100_tx_packet *packet;
 	unsigned long flags;
 	
@@ -3051,7 +3041,7 @@
 	if (!priv->connected) { 
 		/* TODO: check code to ensure that xmit disabled during
 		 * any call that results in priv->connected == false */
-		IPW2100_DEBUG_INFO("Can not transmit when not connected.\n");
+		IPW2100_DEBUG_INFO("%s", "Can not transmit when not connected.\n");
 		priv->ieee->stats.tx_carrier_errors++;
 		netif_stop_queue(dev);
 		goto fail_unlock;
@@ -3063,13 +3053,13 @@
 	element = priv->tx_free_list.next;
 	packet = list_entry(element, struct ipw2100_tx_packet, list);
 
-	header = packet->data;
+	header = packet->info.d_struct.data;
 	memcpy(header->dst_addr, skb->data, ETH_ALEN);
 	memcpy(header->src_addr, skb->data + ETH_ALEN, ETH_ALEN);
 
-	packet->txb = ieee80211_skb_to_txb(priv->ieee, skb);
-	if (packet->txb == NULL) {
-		IPW2100_DEBUG_DROP("Failed to Tx packet\n");
+	packet->info.d_struct.txb = ieee80211_skb_to_txb(priv->ieee, skb);
+	if (packet->info.d_struct.txb == NULL) {
+		IPW2100_DEBUG_DROP("%s", "Failed to Tx packet\n");
 		priv->ieee->stats.tx_errors++;
 		goto fail_unlock;
 	} 
@@ -3079,9 +3069,9 @@
 
 	/* For now we only support host based encryption */
 	header->needs_encryption = 0;
-	header->encrypted = packet->txb->encrypted;
-	if (packet->txb->nr_frags > 1)
-		header->fragment_size = packet->txb->frag_size;
+	header->encrypted = packet->info.d_struct.txb->encrypted;
+	if (packet->info.d_struct.txb->nr_frags > 1)
+		header->fragment_size = packet->info.d_struct.txb->frag_size;
 	else
 		header->fragment_size = 0;
 
@@ -3096,12 +3086,12 @@
 	X__ipw2100_tx_send_data(priv);
 	
 	spin_unlock_irqrestore(&priv->low_lock, flags);
-	IPW2100_DEBUG_INFO("exit\n");
+	IPW2100_DEBUG_INFO("%s", "exit\n");
 	return 0;
 
  fail_unlock:
 	netif_stop_queue(dev);
-	IPW2100_DEBUG_INFO("exit - failed\n");
+	IPW2100_DEBUG_INFO("%s", "exit - failed\n");
 	spin_unlock_irqrestore(&priv->low_lock, flags);
 	return 1;
 }
@@ -3139,9 +3129,9 @@
 		memset(v, 0, sizeof(struct ipw2100_cmd_header));
 		
 		priv->msg_buffers[i].type = COMMAND;
-		priv->msg_buffers[i].cmd = 
+		priv->msg_buffers[i].info.c_struct.cmd = 
 			(struct ipw2100_cmd_header*)v;
-		priv->msg_buffers[i].cmd_phys = p;
+		priv->msg_buffers[i].info.c_struct.cmd_phys = p;
 	}
 
 	if (i == IPW_COMMAND_POOL_SIZE)
@@ -3151,8 +3141,8 @@
 		pci_free_consistent(
 			priv->pdev,
 			sizeof(struct ipw2100_cmd_header), 
-			priv->msg_buffers[j].cmd,
-			priv->msg_buffers[j].cmd_phys);
+			priv->msg_buffers[j].info.c_struct.cmd,
+			priv->msg_buffers[j].info.c_struct.cmd_phys);
 	}
 	
 	kfree(priv->msg_buffers);
@@ -3185,8 +3175,8 @@
 	for (i = 0; i < IPW_COMMAND_POOL_SIZE; i++) {
 		pci_free_consistent(priv->pdev,
 				    sizeof(struct ipw2100_cmd_header),
-				    priv->msg_buffers[i].cmd,
-				    priv->msg_buffers[i].cmd_phys);
+				    priv->msg_buffers[i].info.c_struct.cmd,
+				    priv->msg_buffers[i].info.c_struct.cmd_phys);
 	}
 	
 	kfree(priv->msg_buffers);
@@ -3487,7 +3477,7 @@
 	char *p = buf;
 
 	if (copy_from_user(buf, buffer, len)) {
-		IPW2100_DEBUG_INFO("can't copy data from userspace\n");
+		IPW2100_DEBUG_INFO("%s", "can't copy data from userspace\n");
                 /* stupid? yes, but how do I signal an error here? */
 		return count;	
 	} else
@@ -3917,14 +3907,14 @@
 	struct net_device *dev = data;
 	struct ipw2100_priv *priv = ipw2100_netdev(dev);
 
-	IPW2100_DEBUG_INFO("enter\n");
+	IPW2100_DEBUG_INFO("%s", "enter\n");
 
 	read_register(dev, IPW_MEM_HOST_SHARED_TX_QUEUE_READ_INDEX(0),
 		      &tbdr_r);
 	read_register(dev, IPW_MEM_HOST_SHARED_TX_QUEUE_WRITE_INDEX(0),
 		      &tbdr_w);
 
-	IPW2100_DEBUG_INFO("after register read\n");
+	IPW2100_DEBUG_INFO("%s", "after register read\n");
 
 	len += snprintf(page, count,
 			"Tx Queue\nnic:\n\tread  index=%d\n\twrite index=%d\n",
@@ -3935,7 +3925,7 @@
 			priv->tx_queue.next);
 	*eof = 1;
 
-	IPW2100_DEBUG_INFO("exit\n");
+	IPW2100_DEBUG_INFO("%s", "exit\n");
 
 	return len;
 }
@@ -3950,12 +3940,12 @@
 	struct net_device *dev = data;
 	struct ipw2100_priv *priv = ipw2100_netdev(dev);
 
-	IPW2100_DEBUG_INFO("enter\n");
+	IPW2100_DEBUG_INFO("%s", "enter\n");
 
 	read_register(dev, IPW_MEM_HOST_SHARED_RX_READ_INDEX, &rbdr_r);
 	read_register(dev, IPW_MEM_HOST_SHARED_RX_WRITE_INDEX, &rbdr_w);
 
-	IPW2100_DEBUG_INFO("after register read\n");
+	IPW2100_DEBUG_INFO("%s", "after register read\n");
 
 	len += snprintf(page, count,
 			"Rx Queue\nnic:\n\tread  index=%d\n\twrite index=%d\n",
@@ -3966,7 +3956,7 @@
 
 	*eof = 1;
 
-	IPW2100_DEBUG_INFO("exit\n");
+	IPW2100_DEBUG_INFO("%s", "exit\n");
 
 	return len;
 }
@@ -4011,7 +4001,7 @@
 	int i;
 
 	if (copy_from_user(buf, buffer, len)) {
-		IPW2100_DEBUG_INFO("can't copy data from userspace\n");
+		IPW2100_DEBUG_INFO("%s", "can't copy data from userspace\n");
 		return count;	
 	} else
 		buf[len] = 0;
@@ -4141,10 +4131,10 @@
 	u32 val;
 	char *p = buf;
 
-	IPW2100_DEBUG_INFO("enter\n");
+	IPW2100_DEBUG_INFO("%s", "enter\n");
 
 	if (copy_from_user(buf, buffer, len)) {
-		IPW2100_DEBUG_INFO("can't copy data from userspace\n");
+		IPW2100_DEBUG_INFO("%s", "can't copy data from userspace\n");
                 /* stupid? yes, but how do I signal an error here? */
 		return count;	
 	} else
@@ -4165,7 +4155,7 @@
 		IPW2100_DEBUG_INFO("set mem addr = 0x%08x\n", val);
 	}
 	
-	IPW2100_DEBUG_INFO("exit\n");
+	IPW2100_DEBUG_INFO("%s", "exit\n");
 	return count;
 }
 
@@ -4198,10 +4188,10 @@
 	unsigned long val;
 	char *p = buf;
 
-	IPW2100_DEBUG_INFO("enter\n");
+	IPW2100_DEBUG_INFO("%s", "enter\n");
 
 	if (copy_from_user(buf, buffer, len)) {
-		IPW2100_DEBUG_INFO("can't copy data from userspace\n");
+		IPW2100_DEBUG_INFO("%s", "can't copy data from userspace\n");
                 /* stupid? yes, but how do I signal an error here? */
 		return count;	
 	} else
@@ -4222,7 +4212,7 @@
 		IPW2100_DEBUG_INFO("set scan_age = %lu\n", priv->scan_age);
 	}
 	
-	IPW2100_DEBUG_INFO("exit\n");
+	IPW2100_DEBUG_INFO("%s", "exit\n");
 	return count;
 }
 
@@ -4470,7 +4460,7 @@
 
 int ipw2100_proc_init(void)
 {
-	IPW2100_DEBUG_INFO("enter\n");
+	IPW2100_DEBUG_INFO("%s", "enter\n");
 
 	ipw2100_proc = create_proc_entry(DRV_NAME, S_IFDIR, proc_net);
 	if (ipw2100_proc == NULL) {
@@ -4497,20 +4487,20 @@
 	}
 #endif /* CONFIG_IPW2100_DEBUG */
 
-	IPW2100_DEBUG_INFO("exit\n");
+	IPW2100_DEBUG_INFO("%s", "exit\n");
 
 	return 0;
 
  fail:
 	ipw2100_proc_cleanup();
-	IPW2100_DEBUG_INFO("exit on fail\n");
+	IPW2100_DEBUG_INFO("%s", "exit on fail\n");
 	
 	return -ENOMEM;
 }
 
 void ipw2100_proc_cleanup(void)
 {
-	IPW2100_DEBUG_INFO("enter\n");
+	IPW2100_DEBUG_INFO("%s", "enter\n");
 
 	if (ipw2100_proc) {
 #ifdef CONFIG_IPW2100_DEBUG
@@ -4520,7 +4510,7 @@
 		ipw2100_proc = NULL;
 	}
 
-	IPW2100_DEBUG_INFO("exit\n");
+	IPW2100_DEBUG_INFO("%s", "exit\n");
 }
 
 
@@ -4528,7 +4518,7 @@
 {
 	struct ipw2100_status_queue *q = &priv->status_queue;
 
-	IPW2100_DEBUG_INFO("enter\n");
+	IPW2100_DEBUG_INFO("%s", "enter\n");
 
 	q->size = entries * sizeof(struct ipw2100_status);
 	q->drv = (struct ipw2100_status *)pci_alloc_consistent(
@@ -4541,14 +4531,14 @@
 
 	memset(q->drv, 0, q->size);
 
-	IPW2100_DEBUG_INFO("exit\n");
+	IPW2100_DEBUG_INFO("%s", "exit\n");
 
 	return 0;
 }
 
 static void status_queue_free(struct ipw2100_priv *priv)
 {
-	IPW2100_DEBUG_INFO("enter\n");
+	IPW2100_DEBUG_INFO("%s", "enter\n");
 
 	if (priv->status_queue.drv) {
 		pci_free_consistent(
@@ -4557,13 +4547,13 @@
 		priv->status_queue.drv = NULL;
 	}
 
-	IPW2100_DEBUG_INFO("exit\n");
+	IPW2100_DEBUG_INFO("%s", "exit\n");
 }
 
 static int bd_queue_allocate(struct ipw2100_priv *priv,
 			     struct ipw2100_bd_queue *q, int entries)
 {
-	IPW2100_DEBUG_INFO("enter\n");
+	IPW2100_DEBUG_INFO("%s", "enter\n");
 
 	memset(q, 0, sizeof(struct ipw2100_bd_queue));
 
@@ -4571,13 +4561,12 @@
 	q->size = entries * sizeof(struct ipw2100_bd);
 	q->drv = pci_alloc_consistent(priv->pdev, q->size, &q->nic);
 	if (!q->drv) {
-		IPW2100_DEBUG_INFO("can't allocate shared memory for "
-		       "buffer descriptors\n");
+		IPW2100_DEBUG_INFO("%s", "can't allocate shared memory for buffer descriptors\n");
 		return -ENOMEM;
 	}
 	memset(q->drv, 0, q->size);
 
-	IPW2100_DEBUG_INFO("exit\n");
+	IPW2100_DEBUG_INFO("%s", "exit\n");
 
 	return 0;
 }
@@ -4585,7 +4574,7 @@
 static void bd_queue_free(struct ipw2100_priv *priv,
 			  struct ipw2100_bd_queue *q)
 {
-	IPW2100_DEBUG_INFO("enter\n");
+	IPW2100_DEBUG_INFO("%s", "enter\n");
 
 	if (!q)
 		return;
@@ -4596,14 +4585,14 @@
 		q->drv = NULL;
 	}
 
-	IPW2100_DEBUG_INFO("exit\n");
+	IPW2100_DEBUG_INFO("%s", "exit\n");
 }
 
 static void bd_queue_initialize(
 	struct ipw2100_priv *priv, struct ipw2100_bd_queue * q,
 	u32 base, u32 size, u32 r, u32 w)
 {
-	IPW2100_DEBUG_INFO("enter\n");
+	IPW2100_DEBUG_INFO("%s", "enter\n");
 
 	IPW2100_DEBUG_INFO("initializing bd queue at virt=%p, phys=%08x\n", q->drv, q->nic);
 
@@ -4612,7 +4601,7 @@
 	write_register(priv->ndev, r, q->oldest);
 	write_register(priv->ndev, w, q->next);
 
-	IPW2100_DEBUG_INFO("exit\n");
+	IPW2100_DEBUG_INFO("%s", "exit\n");
 }
 
 static int ipw2100_tx_allocate(struct ipw2100_priv *priv)
@@ -4621,7 +4610,7 @@
 	void *v;
 	dma_addr_t p;
 
-	IPW2100_DEBUG_INFO("enter\n");
+	IPW2100_DEBUG_INFO("%s", "enter\n");
 
 	err = bd_queue_allocate(priv, &priv->tx_queue, TX_QUEUE_LENGTH);
 	if (err) {
@@ -4651,9 +4640,9 @@
 		}
 
 		priv->tx_buffers[i].type = DATA;
-		priv->tx_buffers[i].data = (struct ipw2100_data_header*)v;
-		priv->tx_buffers[i].data_phys = p;
-		priv->tx_buffers[i].txb = NULL;
+		priv->tx_buffers[i].info.d_struct.data = (struct ipw2100_data_header*)v;
+		priv->tx_buffers[i].info.d_struct.data_phys = p;
+		priv->tx_buffers[i].info.d_struct.txb = NULL;
 	}
 	
 	if (i == TX_PENDED_QUEUE_LENGTH)
@@ -4663,8 +4652,8 @@
 		pci_free_consistent(
 			priv->pdev,
 			sizeof(struct ipw2100_data_header), 
-			priv->tx_buffers[j].data,
-			priv->tx_buffers[j].data_phys);
+			priv->tx_buffers[j].info.d_struct.data,
+			priv->tx_buffers[j].info.d_struct.data_phys);
 	}
 	
 	kfree(priv->tx_buffers);
@@ -4677,7 +4666,7 @@
 {
 	int i;
 
-	IPW2100_DEBUG_INFO("enter\n");
+	IPW2100_DEBUG_INFO("%s", "enter\n");
 
 	/*
 	 * reinitialize packet info lists
@@ -4696,9 +4685,9 @@
 	for (i = 0; i < TX_PENDED_QUEUE_LENGTH; i++) {
 		/* We simply drop any SKBs that have been queued for
 		 * transmit */
-		if (priv->tx_buffers[i].txb) {
-			ieee80211_txb_free(priv->tx_buffers[i].txb);
-			priv->tx_buffers[i].txb = NULL;
+		if (priv->tx_buffers[i].info.d_struct.txb) {
+			ieee80211_txb_free(priv->tx_buffers[i].info.d_struct.txb);
+			priv->tx_buffers[i].info.d_struct.txb = NULL;
 		}
 		
 		list_add_tail(&priv->tx_buffers[i].list, &priv->tx_free_list);
@@ -4718,7 +4707,7 @@
 			    IPW_MEM_HOST_SHARED_TX_QUEUE_READ_INDEX(0),
 			    IPW_MEM_HOST_SHARED_TX_QUEUE_WRITE_INDEX(0));
 
-	IPW2100_DEBUG_INFO("exit\n");
+	IPW2100_DEBUG_INFO("%s", "exit\n");
 
 }
 
@@ -4726,7 +4715,7 @@
 {
 	int i;
 
-	IPW2100_DEBUG_INFO("enter\n");
+	IPW2100_DEBUG_INFO("%s", "enter\n");
 
 	bd_queue_free(priv, &priv->tx_queue);
 
@@ -4734,22 +4723,22 @@
 		return;
 
 	for (i = 0; i < TX_PENDED_QUEUE_LENGTH; i++) {
-		if (priv->tx_buffers[i].txb) {
-			ieee80211_txb_free(priv->tx_buffers[i].txb);
-			priv->tx_buffers[i].txb = NULL;
+		if (priv->tx_buffers[i].info.d_struct.txb) {
+			ieee80211_txb_free(priv->tx_buffers[i].info.d_struct.txb);
+			priv->tx_buffers[i].info.d_struct.txb = NULL;
 		}
-		if (priv->tx_buffers[i].data)
+		if (priv->tx_buffers[i].info.d_struct.data)
 			pci_free_consistent(
 				priv->pdev,
 				sizeof(struct ipw2100_data_header),
-				priv->tx_buffers[i].data,
-				priv->tx_buffers[i].data_phys);
+				priv->tx_buffers[i].info.d_struct.data,
+				priv->tx_buffers[i].info.d_struct.data_phys);
 	}
 	
 	kfree(priv->tx_buffers);
 	priv->tx_buffers = NULL;
 
-	IPW2100_DEBUG_INFO("exit\n");
+	IPW2100_DEBUG_INFO("%s", "exit\n");
 }
 
 
@@ -4758,17 +4747,17 @@
 {
 	int i, j, err = -EINVAL;
 
-	IPW2100_DEBUG_INFO("enter\n");
+	IPW2100_DEBUG_INFO("%s", "enter\n");
 
 	err = bd_queue_allocate(priv, &priv->rx_queue, RX_QUEUE_LENGTH);
 	if (err) {
-		IPW2100_DEBUG_INFO("failed bd_queue_allocate\n");
+		IPW2100_DEBUG_INFO("%s", "failed bd_queue_allocate\n");
 		return err;
 	}
 
 	err = status_queue_allocate(priv, RX_QUEUE_LENGTH);
 	if (err) {
-		IPW2100_DEBUG_INFO("failed status_queue_allocate\n");
+		IPW2100_DEBUG_INFO("%s", "failed status_queue_allocate\n");
 		bd_queue_free(priv, &priv->rx_queue);
 		return err;
 	}
@@ -4780,7 +4769,7 @@
 	    kmalloc(RX_QUEUE_LENGTH * sizeof(struct ipw2100_rx_packet), 
 		    GFP_KERNEL);
 	if (!priv->rx_buffers) {
-		IPW2100_DEBUG_INFO("can't allocate rx packet buffer table\n");
+		IPW2100_DEBUG_INFO("%s", "can't allocate rx packet buffer table\n");
 
 		bd_queue_free(priv, &priv->rx_queue);
 
@@ -4826,7 +4815,7 @@
 
 static void ipw2100_rx_initialize(struct ipw2100_priv *priv)
 {
-	IPW2100_DEBUG_INFO("enter\n");
+	IPW2100_DEBUG_INFO("%s", "enter\n");
 
 	priv->rx_queue.oldest = 0;
 	priv->rx_queue.available = priv->rx_queue.entries - 1;
@@ -4845,14 +4834,14 @@
 	write_register(priv->ndev, IPW_MEM_HOST_SHARED_RX_STATUS_BASE,
 		       priv->status_queue.nic);
 
-	IPW2100_DEBUG_INFO("exit\n");
+	IPW2100_DEBUG_INFO("%s", "exit\n");
 }
 
 static void ipw2100_rx_free(struct ipw2100_priv *priv)
 {
 	int i;
 
-	IPW2100_DEBUG_INFO("enter\n");
+	IPW2100_DEBUG_INFO("%s", "enter\n");
 
 	bd_queue_free(priv, &priv->rx_queue);
 	status_queue_free(priv);
@@ -4873,7 +4862,7 @@
 	kfree(priv->rx_buffers);
 	priv->rx_buffers = NULL;
 
-	IPW2100_DEBUG_INFO("exit\n");
+	IPW2100_DEBUG_INFO("%s", "exit\n");
 }
 
 static int ipw2100_read_mac_address(struct ipw2100_priv *priv)
@@ -4886,7 +4875,7 @@
 	err = ipw2100_get_ordinal(priv, IPW_ORD_STAT_ADAPTER_MAC, 
 				  mac, &length);
 	if (err) {
-		IPW2100_DEBUG_INFO("MAC address read failed\n");
+		IPW2100_DEBUG_INFO("%s", "MAC address read failed\n");
 		return -EIO;
 	}
 	IPW2100_DEBUG_INFO("card MAC is %02X:%02X:%02X:%02X:%02X:%02X\n",
@@ -4907,31 +4896,32 @@
 	struct host_command cmd = {
 		.host_command = BROADCAST_SCAN,
 		.host_command_sequence = 0,
-		.host_command_length = 4,
-		.host_command_parameters[0] = 0
+		.host_command_length = 4
 	};
 	int err;
 
+    cmd.host_command_parameters[0] = 0;
+
 	/* No scanning if in monitor mode */
 	if (priv->ctx->port_type == MONITOR)
 		return 1;
 
 	if (priv->in_scan) {
-		IPW2100_DEBUG_SCAN("Scan requested while already in scan...\n");
+		IPW2100_DEBUG_SCAN("%s", "Scan requested while already in scan...\n");
 		return 0;
 	}
 
-	IPW2100_DEBUG_INFO("enter\n");
+	IPW2100_DEBUG_INFO("%s", "enter\n");
 
 	/* Not clearing here; doing so makes iwlist always return nothing... 
 	 *
 	 * We should modify the table logic to use aging tables vs. clearing 
 	 * the table on each scan start.
 	 */
-	IPW2100_DEBUG_SCAN("starting scan\n");
+	IPW2100_DEBUG_SCAN("%s", "starting scan\n");
 	err =  ipw2100_hw_send_command(priv, &cmd);
 
-	IPW2100_DEBUG_INFO("exit\n");
+	IPW2100_DEBUG_INFO("%s", "exit\n");
 
 	return err;
 }
@@ -4945,7 +4935,7 @@
 	};
 	int err;
 
-	IPW2100_DEBUG_INFO("enter\n");
+	IPW2100_DEBUG_INFO("%s", "enter\n");
 
 	if (priv->custom_addr) {
 		memcpy(cmd.host_command_parameters, priv->mac_addr,
@@ -4957,7 +4947,7 @@
 
 	err = ipw2100_hw_send_command(priv, &cmd);
 
-	IPW2100_DEBUG_INFO("exit\n");
+	IPW2100_DEBUG_INFO("%s", "exit\n");
 	return err;
 }
 
@@ -4967,11 +4957,12 @@
 	struct host_command cmd = {
 		.host_command = PORT_TYPE,
 		.host_command_sequence = 0,
-		.host_command_length = sizeof(u32),
-		.host_command_parameters[0] = port_type
+		.host_command_length = sizeof(u32)
 	};
 	int err;
 
+	cmd.host_command_parameters[0] = port_type;
+
 	IPW2100_DEBUG_FW_COMMAND("PORT_TYPE: %s\n",
 				 port_type == IBSS ? "IBSS" : "BSS");
 	if (!batch_mode) {
@@ -5002,11 +4993,12 @@
 	struct host_command cmd = {
 		.host_command = CHANNEL,
 		.host_command_sequence = 0,
-		.host_command_length = sizeof(u32),
-		.host_command_parameters[0] = channel
+		.host_command_length = sizeof(u32)
 	};
 	int err;
 
+	cmd.host_command_parameters[0] = channel;
+
 	IPW2100_DEBUG_FW_COMMAND("CHANNEL: %d\n", channel);
 
 	/* If not BSS then we don't support channel selection */
@@ -5107,11 +5099,12 @@
 	struct host_command cmd = {
 		.host_command = BASIC_TX_RATES,
 		.host_command_sequence = 0,
-		.host_command_length = 4,
-		.host_command_parameters[0] = rate & TX_RATE_MASK
+		.host_command_length = 4
 	};
 	int err;
 
+	cmd.host_command_parameters[0] = rate & TX_RATE_MASK;
+
 	if (!batch_mode) {
 		err = ipw2100_disable_adapter(priv);
 		if (err) 
@@ -5146,11 +5139,12 @@
 	struct host_command cmd = {
 		.host_command = POWER_MODE,
 		.host_command_sequence = 0,
-		.host_command_length = 4,
-		.host_command_parameters[0] = power_level
+		.host_command_length = 4
 	};
 	int err;
 
+	cmd.host_command_parameters[0] = power_level;
+
 	err = ipw2100_hw_send_command(priv, &cmd);
 	if (err)
 		return err;
@@ -5177,11 +5171,12 @@
 	struct host_command cmd = {
 		.host_command = RTS_THRESHOLD,
 		.host_command_sequence = 0,
-		.host_command_length = 4,
-		.host_command_parameters[0] = threshold
+		.host_command_length = 4
 	};
 	int err;
 
+	cmd.host_command_parameters[0] = threshold;
+
 	err = ipw2100_hw_send_command(priv, &cmd);
 	if (err) 
 		return err;
@@ -5237,10 +5232,11 @@
 	struct host_command cmd = {
 		.host_command = SHORT_RETRY_LIMIT,
 		.host_command_sequence = 0,
-		.host_command_length = 4,
-		.host_command_parameters[0] = retry
+		.host_command_length = 4
 	};
 	int err;
+
+	cmd.host_command_parameters[0] = retry;
 	
 	err = ipw2100_hw_send_command(priv, &cmd);
 	if (err)
@@ -5256,11 +5252,12 @@
 	struct host_command cmd = {
 		.host_command = LONG_RETRY_LIMIT,
 		.host_command_sequence = 0,
-		.host_command_length = 4,
-		.host_command_parameters[0] = retry
+		.host_command_length = 4
 	};
 	int err;
 
+	cmd.host_command_parameters[0] = retry;
+
 	err = ipw2100_hw_send_command(priv, &cmd);
 	if (err) 
 		return err;
@@ -5288,7 +5285,7 @@
 			bssid[0], bssid[1], bssid[2], bssid[3], bssid[4], 
 			bssid[5]);
 	else
-		IPW2100_DEBUG_FW_COMMAND("MANDATORY_BSSID: <clear>\n");
+		IPW2100_DEBUG_FW_COMMAND("%s", "MANDATORY_BSSID: <clear>\n");
 #endif
 	/* if BSSID is empty then we disable mandatory bssid mode */
 	if (bssid != NULL)
@@ -5434,19 +5431,20 @@
 	struct host_command cmd = {
 	  .host_command = TX_POWER_INDEX,
 		.host_command_sequence = 0,
-		.host_command_length = 4,
-		.host_command_parameters[0] = tx_power
+		.host_command_length = 4
 	};
 	int err = 0;
 
-	IPW2100_DEBUG_INFO("enter\n");
+	cmd.host_command_parameters[0] = tx_power;
+
+	IPW2100_DEBUG_INFO("%s", "enter\n");
 	
 	if (priv->port_type == IBSS) 
 		err = ipw2100_hw_send_command(priv, &cmd);
 	if (!err)
 		priv->tx_power = tx_power;
 	
-	IPW2100_DEBUG_INFO("exit\n");
+	IPW2100_DEBUG_INFO("%s", "exit\n");
 	
 	return 0;
 }
@@ -5457,12 +5455,13 @@
 	struct host_command cmd = {
 		.host_command = BEACON_INTERVAL,
 		.host_command_sequence = 0,
-		.host_command_length = 4,
-		.host_command_parameters[0] = interval
+		.host_command_length = 4
 	};
 	int err;
 
-	IPW2100_DEBUG_INFO("enter\n");
+	cmd.host_command_parameters[0] = interval;
+
+	IPW2100_DEBUG_INFO("%s", "enter\n");
 
 	if (priv->port_type == IBSS) {
 		if (!batch_mode) {
@@ -5480,7 +5479,7 @@
 		}
 	}
 
-	IPW2100_DEBUG_INFO("exit\n");
+	IPW2100_DEBUG_INFO("%s", "exit\n");
 
 	return 0;
 }
@@ -5490,19 +5489,20 @@
 	struct host_command cmd = {
 		.host_command = SET_SCAN_OPTIONS,
 		.host_command_sequence = 0,
-		.host_command_length = 8,
-		.host_command_parameters[0] = priv->sec.enabled ? 0x2 : 0x0,
-		.host_command_parameters[1] = 0
+		.host_command_length = 8
 	};
 	int err;
 
-	IPW2100_DEBUG_INFO("enter\n");
+	cmd.host_command_parameters[0] = priv->sec.enabled ? 0x2 : 0x0;
+	cmd.host_command_parameters[1] = 0;
+
+	IPW2100_DEBUG_INFO("%s", "enter\n");
 
-	IPW2100_DEBUG_SCAN("setting scan options\n");
+	IPW2100_DEBUG_SCAN("%s", "setting scan options\n");
 
 	err = ipw2100_hw_send_command(priv, &cmd);
 
-	IPW2100_DEBUG_INFO("exit\n");
+	IPW2100_DEBUG_INFO("%s", "exit\n");
 
 	return err;
 }
@@ -5546,11 +5546,12 @@
 	struct host_command cmd = {
 		.host_command = WEP_FLAGS,
 		.host_command_sequence = 0,
-		.host_command_length = 4,
-		.host_command_parameters[0] = flags,
+		.host_command_length = 4
 	};
 	int err;
 
+	cmd.host_command_parameters[0] = flags;
+
 	IPW2100_DEBUG_FW_COMMAND("WEP_FLAGS: flags = 0x%08X\n", flags);
 	
 	if (!batch_mode) {
@@ -5818,7 +5819,7 @@
 	int err;
 	int batch_mode = 1;
 
-	IPW2100_DEBUG_INFO("enter\n");
+	IPW2100_DEBUG_INFO("%s", "enter\n");
 
 	err = ipw2100_disable_adapter(priv);
 	if (err)
@@ -5829,7 +5830,7 @@
 		if (err)
 			return err;
 
-		IPW2100_DEBUG_INFO("exit\n");
+		IPW2100_DEBUG_INFO("%s", "exit\n");
 
 		return 0;
 	}
@@ -5903,7 +5904,7 @@
 	  return err;
 	*/
 	
-	IPW2100_DEBUG_INFO("exit\n");
+	IPW2100_DEBUG_INFO("%s", "exit\n");
 
 	return 0;
 }
@@ -5945,7 +5946,7 @@
 	struct ipw2100_priv *priv = ipw2100_netdev(dev);
 	unsigned long flags;
 
-	IPW2100_DEBUG_INFO("enter\n");
+	IPW2100_DEBUG_INFO("%s", "enter\n");
 	
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
 	MOD_INC_USE_COUNT;
@@ -5955,7 +5956,7 @@
 	priv->open = 1;
 	spin_unlock_irqrestore(&priv->low_lock, flags);
 
-	IPW2100_DEBUG_INFO("exit\n");
+	IPW2100_DEBUG_INFO("%s", "exit\n");
 	return 0;
 }
 
@@ -5966,7 +5967,7 @@
 	struct list_head *element;
 	struct ipw2100_tx_packet *packet;
 
-	IPW2100_DEBUG_INFO("enter\n");
+	IPW2100_DEBUG_INFO("%s", "enter\n");
 
 	spin_lock_irqsave(&priv->low_lock, flags);
 
@@ -5983,8 +5984,8 @@
 		list_del(element);
 		DEC_STAT(&priv->tx_pend_stat);
 
-		ieee80211_txb_free(packet->txb);
-		packet->txb = NULL;
+		ieee80211_txb_free(packet->info.d_struct.txb);
+		packet->info.d_struct.txb = NULL;
 
 		list_add_tail(element, &priv->tx_free_list);
 		INC_STAT(&priv->tx_free_stat);
@@ -5995,7 +5996,7 @@
 	MOD_DEC_USE_COUNT;
 #endif
 
-	IPW2100_DEBUG_INFO("exit\n");
+	IPW2100_DEBUG_INFO("%s", "exit\n");
 
 	return 0;
 }
@@ -6016,7 +6017,7 @@
 #ifdef CONFIG_IPW2100_PROMISC
 	// we do nothing as we should not be transmitting anyway
 	if (priv->ctx->port_type == MONITOR) {
-		IPW2100_DEBUG_TX("exit - monitor mode\n");
+		IPW2100_DEBUG_TX("%s", "exit - monitor mode\n");
 		return;
 	}
 #endif
@@ -6027,7 +6028,7 @@
 	       dev->name);
 	schedule_reset(priv);
 
-	IPW2100_DEBUG_TX("exit\n");
+	IPW2100_DEBUG_TX("%s", "exit\n");
 }
 
 
@@ -6056,9 +6057,9 @@
 
 static int ipw2100_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
-	IPW2100_DEBUG_IOCTL("enter\n");
+	IPW2100_DEBUG_IOCTL("%s", "enter\n");
 
-	IPW2100_DEBUG_IOCTL("exit\n");
+	IPW2100_DEBUG_IOCTL("%s", "exit\n");
 	return -EOPNOTSUPP;
 }
 
@@ -6328,7 +6329,7 @@
 	int registered = 0;
 	u32 val;
 
-	IPW2100_DEBUG_INFO("enter\n");
+	IPW2100_DEBUG_INFO("%s", "enter\n");
 
 	/* set up PCI mappings for device */
 	err = pci_enable_device(pdev);
@@ -6339,7 +6340,7 @@
 
 	err = pci_set_dma_mask(pdev, PCI_DMA_32BIT);
 	if (err) {
-		IPW2100_DEBUG_INFO("failed pci_set_dma_mask!\n");
+		IPW2100_DEBUG_INFO("%s", "failed pci_set_dma_mask!\n");
 		pci_disable_device(pdev);
 		return err;
 	}
@@ -6363,7 +6364,7 @@
 	mem_flags = pci_resource_flags(pdev, 0);
 
 	if ((mem_flags & IORESOURCE_MEM) != IORESOURCE_MEM) {
-		IPW2100_DEBUG_INFO("weird - resource type is not memory\n");
+		IPW2100_DEBUG_INFO("%s", "weird - resource type is not memory\n");
 		err = -ENODEV;
 		goto fail;
 	}
@@ -6426,7 +6427,7 @@
 	}
 	dev->irq = pdev->irq;
 
-	IPW2100_DEBUG_INFO("Attempting to register device...\n");
+	IPW2100_DEBUG_INFO("%s", "Attempting to register device...\n");
 
 	SET_MODULE_OWNER(dev);
 
@@ -6481,7 +6482,7 @@
 		ipw2100_start_scan(priv);
 	}
 
-	IPW2100_DEBUG_INFO("exit\n");
+	IPW2100_DEBUG_INFO("%s", "exit\n");
 
 	return 0;
 	
@@ -6565,7 +6566,7 @@
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 
-	IPW2100_DEBUG_INFO("exit\n");
+	IPW2100_DEBUG_INFO("%s", "exit\n");
 }
 
 #ifdef CONFIG_PM
diff -ru ipw2100-0.49/ipw2100_wx.c ipw2100-0.49-mod/ipw2100_wx.c
--- ipw2100-0.49/ipw2100_wx.c	Fri Jul  9 00:32:17 2004
+++ ipw2100-0.49-mod/ipw2100_wx.c	Wed Jul 14 12:51:49 2004
@@ -169,7 +169,7 @@
 
 	err = ipw2100_get_ordinal(priv, IPW_ORD_OUR_FREQ, &chan, &len);
 	if (err) {
-		IPW2100_DEBUG_WX("failed querying ordinals.\n");
+		IPW2100_DEBUG_WX("%s", "failed querying ordinals.\n");
 		return err;
 	}
 
@@ -385,7 +385,7 @@
 	}
 	range->num_frequency = val;
 
-	IPW2100_DEBUG_WX("GET Range\n");
+	IPW2100_DEBUG_WX("%s", "GET Range\n");
 
 	return 0;
 }
@@ -411,7 +411,7 @@
 	if (!memcmp(any, wrqu->ap_addr.sa_data, ETH_ALEN) ||
 	    !memcmp(off, wrqu->ap_addr.sa_data, ETH_ALEN)) {
 		/* we disable mandatory BSSID association */
-		IPW2100_DEBUG_WX("exit - disable mandatory BSSID\n");
+		IPW2100_DEBUG_WX("%s", "exit - disable mandatory BSSID\n");
 		return ipw2100_set_mandatory_bssid(priv, NULL, 0);
 	}
 
@@ -470,7 +470,7 @@
 	char *essid = ""; /* ANY */
 	int err;
   
-	IPW2100_DEBUG_WX("enter\n");
+	IPW2100_DEBUG_WX("%s", "enter\n");
 	if (wrqu->essid.flags && wrqu->essid.length)
 		essid = extra;
 	
@@ -482,11 +482,11 @@
 	
 	err = ipw2100_set_essid(priv, essid, 0);
 	if (err) {
-		IPW2100_DEBUG_WX("SET SSID failed\n");
+		IPW2100_DEBUG_WX("%s", "SET SSID failed\n");
 		return err;
 	}
 	
-	IPW2100_DEBUG_WX("exit\n");
+	IPW2100_DEBUG_WX("%s", "exit\n");
 	
 	return 0;
 }
@@ -566,7 +566,7 @@
 	
 	err = ipw2100_set_tx_rates(priv, rate, 0);
 	if (err) {
-		IPW2100_DEBUG_WX("failed setting tx rates.\n");
+		IPW2100_DEBUG_WX("%s", "failed setting tx rates.\n");
 		return err;
 	}
 	
@@ -591,7 +591,7 @@
 
 	err = ipw2100_get_ordinal(priv, IPW_ORD_CURRENT_TX_RATE, &val, &len);
 	if (err) {
-		IPW2100_DEBUG_WX("failed querying ordinals.\n");
+		IPW2100_DEBUG_WX("%s", "failed querying ordinals.\n");
 		return err;
 	}
 
@@ -651,7 +651,7 @@
 		err = ipw2100_get_ordinal(priv, IPW_ORD_RTS_THRESHOLD, 
 					  &wrqu->rts.value, &len);
 		if (err) {
-			IPW2100_DEBUG_WX("query ordinal failed.\n");
+			IPW2100_DEBUG_WX("%s", "query ordinal failed.\n");
 			return err;
 		}
 	}
@@ -668,7 +668,7 @@
 				struct iw_request_info *info, 
 				union iwreq_data *wrqu, char *extra)
 {
-	IPW2100_DEBUG_WX("TODO: Power management by wireless extension...\n");
+	IPW2100_DEBUG_WX("%s", "TODO: Power management by wireless extension...\n");
 
 	IPW2100_DEBUG_WX("SET TX Power -> %d \n", wrqu->rts.value);
 
@@ -811,9 +811,9 @@
 {
 	struct ipw2100_priv *priv = ipw2100_netdev(dev);
 
-	IPW2100_DEBUG_WX("Initiating scan...\n");
+	IPW2100_DEBUG_WX("%s", "Initiating scan...\n");
 	if (ipw2100_start_scan(priv)) {
-		IPW2100_DEBUG_WX("Start scan failed.\n");
+		IPW2100_DEBUG_WX("%s", "Start scan failed.\n");
 
 		/* TODO: Mark a scan as pending so when hardware initialized
 		 *       a scan starts */
@@ -913,7 +913,7 @@
 	char *stop = ev + IW_SCAN_MAX_DATA;
 	int i;
 
-	IPW2100_DEBUG_WX("enter\n");
+	IPW2100_DEBUG_WX("%s", "enter\n");
 	
 	spin_lock_irqsave(&priv->low_lock, flags);
 
@@ -967,11 +967,11 @@
 	if (wrqu->power.disabled) {
 		err = ipw2100_set_power_mode(priv, IPW_POWER_MODE_CAM);
 		if (err) {
-			IPW2100_DEBUG_WX("failed setting power mode.\n");
+			IPW2100_DEBUG_WX("%s", "failed setting power mode.\n");
 			return err;
 		}
 
-		IPW2100_DEBUG_WX("SET Power Management Mode -> off\n");
+		IPW2100_DEBUG_WX("%s", "SET Power Management Mode -> off\n");
 
 		return 0;
 	} 
@@ -1007,7 +1007,7 @@
 	
 	err = ipw2100_set_power_mode(priv, i);
 	if (err) {
-		IPW2100_DEBUG_WX("failed setting power mode.\n");
+		IPW2100_DEBUG_WX("%s", "failed setting power mode.\n");
 		return err;
 	}
 
@@ -1028,7 +1028,7 @@
 
 	err = ipw2100_get_ordinal(priv, IPW_ORD_POWER_MGMT_MODE, &val, &len);
 	if (err) {
-		IPW2100_DEBUG_WX("failed querying ordinals.\n");
+		IPW2100_DEBUG_WX("%s", "failed querying ordinals.\n");
 		return err;
 	}
 
@@ -1270,7 +1270,7 @@
 	return wstats;
 
  fail_get_ordinal:
-	IPW2100_DEBUG_WX("failed querying ordinals.\n");
+	IPW2100_DEBUG_WX("%s", "failed querying ordinals.\n");
 
 	return (struct iw_statistics *) NULL;
 }
@@ -1281,7 +1281,7 @@
       union iwreq_data wrqu;
       int len = ETH_ALEN;
 
-      IPW2100_DEBUG_WX("enter\n");
+      IPW2100_DEBUG_WX("%s", "enter\n");
       if (priv->wx_ap_event_pending) {
               priv->wx_ap_event_pending = 0;
 
Victor
-- 
Victor J. Orlikowski <> victor.j.orlikowski@alumni.duke.edu
