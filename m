Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261644AbVEMVrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbVEMVrE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 17:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262552AbVEMVrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 17:47:03 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:34255 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261644AbVEMVmF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 17:42:05 -0400
Date: Fri, 13 May 2005 23:40:25 +0200
From: Pavel Machek <pavel@ucw.cz>
To: jketreno@linux.intel.com, netdev@oss.sgi.com,
       kernel list <linux-kernel@vger.kernel.org>
Cc: jbohac@suse.cz, jbenc@suse.cz
Subject: ipw2100: more cleanups
Message-ID: <20050513214025.GA1863@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

More cleanups (relative to ipw2100-1.1.0 version). Highlights include
removing of two printk wrappers.

								Pavel

--- clean-mm/drivers/net/wireless/ipw2100.c	2005-05-11 22:00:02.000000000 +0200
+++ linux-mm/drivers/net/wireless/ipw2100.c	2005-05-13 23:30:47.000000000 +0200
@@ -106,7 +106,7 @@
 
   tx_pend_list : Holds used Tx buffers waiting to go into the TBD ring
     TAIL modified ipw2100_tx()
-    HEAD modified by X__ipw2100_tx_send_data()
+    HEAD modified by ipw2100_tx_send_data()
 
   msg_free_list : Holds pre-allocated Msg (Command) buffers
     TAIL modified in __ipw2100_tx_process()
@@ -114,7 +114,7 @@
 
   msg_pend_list : Holds used Msg buffers waiting to go into the TBD ring
     TAIL modified in ipw2100_hw_send_command()
-    HEAD modified in X__ipw2100_tx_send_commands()
+    HEAD modified in ipw2100_tx_send_commands()
 
   The flow of data on the TX side is as follows:
 
@@ -150,7 +150,6 @@
 #include <linux/skbuff.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
-#define __KERNEL_SYSCALLS__
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
@@ -171,14 +170,9 @@
 #define DRV_NAME	"ipw2100"
 #define DRV_VERSION	IPW2100_VERSION
 #define DRV_DESCRIPTION	"Intel(R) PRO/Wireless 2100 Network Driver"
-#define DRV_COPYRIGHT	"Copyright(c) 2003-2004 Intel Corporation"
+#define DRV_COPYRIGHT	"Copyright(c) 2003-2005 Intel Corporation"
 
 
-/* Debugging stuff */
-#ifdef CONFIG_IPW_DEBUG
-#define CONFIG_IPW2100_RX_DEBUG   /* Reception debugging */
-#endif
-
 MODULE_DESCRIPTION(DRV_DESCRIPTION);
 MODULE_VERSION(DRV_VERSION);
 MODULE_AUTHOR(DRV_COPYRIGHT);
@@ -189,9 +183,7 @@
 static int channel = 0;
 static int associate = 1;
 static int disable = 0;
-#ifdef CONFIG_PM
 static struct ipw2100_fw ipw2100_firmware;
-#endif
 
 #include <linux/moduleparam.h>
 module_param(debug, int, 0444);
@@ -286,8 +278,8 @@
 
 
 /* Pre-decl until we get the code solid and then we can clean it up */
-static void X__ipw2100_tx_send_commands(struct ipw2100_priv *priv);
-static void X__ipw2100_tx_send_data(struct ipw2100_priv *priv);
+static void ipw2100_tx_send_commands(struct ipw2100_priv *priv);
+static void ipw2100_tx_send_data(struct ipw2100_priv *priv);
 static int ipw2100_adapter_setup(struct ipw2100_priv *priv);
 
 static void ipw2100_queues_initialize(struct ipw2100_priv *priv);
@@ -483,7 +475,7 @@
 	u32 total_length;
 
 	if (ordinals->table1_addr == 0) {
-		IPW_DEBUG_WARNING(DRV_NAME ": attempt to use fw ordinals "
+		printk(KERN_WARNING DRV_NAME ": attempt to use fw ordinals "
 		       "before they have been loaded.\n");
 		return -EINVAL;
 	}
@@ -492,8 +484,7 @@
 		if (*len < IPW_ORD_TAB_1_ENTRY_SIZE) {
 			*len = IPW_ORD_TAB_1_ENTRY_SIZE;
 
-			IPW_DEBUG_WARNING(DRV_NAME
-			       ": ordinal buffer length too small, need %d\n",
+			printk(KERN_WARNING DRV_NAME ": ordinal buffer length too small, need %d\n",
 			       IPW_ORD_TAB_1_ENTRY_SIZE);
 
 			return -EINVAL;
@@ -545,7 +536,7 @@
 		return 0;
 	}
 
-	IPW_DEBUG_WARNING(DRV_NAME ": ordinal %d neither in table 1 nor "
+	printk(KERN_WARNING DRV_NAME ": ordinal %d neither in table 1 nor "
 	       "in table 2\n", ord);
 
 	return -EINVAL;
@@ -735,8 +726,8 @@
 	list_add_tail(element, &priv->msg_pend_list);
 	INC_STAT(&priv->msg_pend_stat);
 
-	X__ipw2100_tx_send_commands(priv);
-	X__ipw2100_tx_send_data(priv);
+	ipw2100_tx_send_commands(priv);
+	ipw2100_tx_send_data(priv);
 
 	spin_unlock_irqrestore(&priv->low_lock, flags);
 
@@ -760,7 +751,7 @@
 	}
 
 	if (priv->fatal_error) {
-		IPW_DEBUG_WARNING("%s: firmware fatal error\n",
+		printk(KERN_WARNING DRV_NAME ": %s: firmware fatal error\n",
 		       priv->net_dev->name);
 		return -EIO;
 	}
@@ -915,12 +906,10 @@
 	if (i == 10000)
 		return -EIO;	/* TODO: better error value */
 
-//#if CONFIG_IPW2100_D0ENABLED
 	/* set D0 standby bit */
 	read_register(priv->net_dev, IPW_REG_GP_CNTRL, &r);
 	write_register(priv->net_dev, IPW_REG_GP_CNTRL,
 		       r | IPW_AUX_HOST_GP_CNTRL_BIT_HOST_ALLOWS_STANDBY);
-//#endif
 
 	return 0;
 }
@@ -941,50 +930,35 @@
 	u32 address;
 	int err;
 
-#ifndef CONFIG_PM
-	/* Fetch the firmware and microcode */
-	struct ipw2100_fw ipw2100_firmware;
-#endif
-
 	if (priv->fatal_error) {
-		IPW_DEBUG_ERROR("%s: ipw2100_download_firmware called after "
+		printk(KERN_ERR DRV_NAME ": %s: ipw2100_download_firmware called after "
 		       "fatal error %d.  Interface must be brought down.\n",
 		       priv->net_dev->name, priv->fatal_error);
 		return -EINVAL;
 	}
 
-#ifdef CONFIG_PM
 	if (!ipw2100_firmware.version) {
 		err = ipw2100_get_firmware(priv, &ipw2100_firmware);
 		if (err) {
-			IPW_DEBUG_ERROR("%s: ipw2100_get_firmware failed: %d\n",
+			printk(KERN_ERR DRV_NAME ": %s: ipw2100_get_firmware failed: %d\n",
 			       priv->net_dev->name, err);
 			priv->fatal_error = IPW2100_ERR_FW_LOAD;
 			goto fail;
 		}
 	}
-#else
-	err = ipw2100_get_firmware(priv, &ipw2100_firmware);
-	if (err) {
-		IPW_DEBUG_ERROR("%s: ipw2100_get_firmware failed: %d\n",
-		       priv->net_dev->name, err);
-		priv->fatal_error = IPW2100_ERR_FW_LOAD;
-		goto fail;
-	}
-#endif
 	priv->firmware_version = ipw2100_firmware.version;
 
 	/* s/w reset and clock stabilization */
 	err = sw_reset_and_clock(priv);
 	if (err) {
-		IPW_DEBUG_ERROR("%s: sw_reset_and_clock failed: %d\n",
+		printk(KERN_ERR DRV_NAME ": %s: sw_reset_and_clock failed: %d\n",
 		       priv->net_dev->name, err);
 		goto fail;
 	}
 
 	err = ipw2100_verify(priv);
 	if (err) {
-		IPW_DEBUG_ERROR("%s: ipw2100_verify failed: %d\n",
+		printk(KERN_ERR DRV_NAME ": %s: ipw2100_verify failed: %d\n",
 		       priv->net_dev->name, err);
 		goto fail;
 	}
@@ -1000,7 +974,7 @@
 	/* load microcode */
 	err = ipw2100_ucode_download(priv, &ipw2100_firmware);
 	if (err) {
-		IPW_DEBUG_ERROR("%s: Error loading microcode: %d\n",
+		printk(KERN_ERR DRV_NAME ": %s: Error loading microcode: %d\n",
 		       priv->net_dev->name, err);
 		goto fail;
 	}
@@ -1013,7 +987,7 @@
 	/* s/w reset and clock stabilization (again!!!) */
 	err = sw_reset_and_clock(priv);
 	if (err) {
-		IPW_DEBUG_ERROR("%s: sw_reset_and_clock failed: %d\n",
+		printk(KERN_ERR DRV_NAME ": %s: sw_reset_and_clock failed: %d\n",
 		       priv->net_dev->name, err);
 		goto fail;
 	}
@@ -1021,23 +995,11 @@
 	/* load f/w */
 	err = ipw2100_fw_download(priv, &ipw2100_firmware);
 	if (err) {
-		IPW_DEBUG_ERROR("%s: Error loading firmware: %d\n",
+		printk(KERN_ERR DRV_NAME ": %s: Error loading firmware: %d\n",
 		       priv->net_dev->name, err);
 		goto fail;
 	}
 
-#ifndef CONFIG_PM
-	/*
-	 * When the .resume method of the driver is called, the other
-	 * part of the system, i.e. the ide driver could still stay in
-	 * the suspend stage. This prevents us from loading the firmware
-	 * from the disk.  --YZ
-	 */
-
-	/* free any storage allocated for firmware image */
-	ipw2100_release_firmware(priv, &ipw2100_firmware);
-#endif
-
 	/* zero out Domain 1 area indirectly (Si requirement) */
 	for (address = IPW_HOST_FW_SHARED_AREA0;
 	     address < IPW_HOST_FW_SHARED_AREA0_END; address += 4)
@@ -1083,8 +1045,6 @@
 {
 	struct ipw2100_ordinals *ord = &priv->ordinals;
 
-	IPW_DEBUG_INFO("enter\n");
-
 	read_register(priv->net_dev, IPW_MEM_HOST_SHARED_ORDINALS_TABLE_1,
 		      &ord->table1_addr);
 
@@ -1095,10 +1055,6 @@
 	read_nic_dword(priv->net_dev, ord->table2_addr, &ord->table2_size);
 
 	ord->table2_size &= 0x0000FFFF;
-
-	IPW_DEBUG_INFO("table 1 size: %d\n", ord->table1_size);
-	IPW_DEBUG_INFO("table 2 size: %d\n", ord->table2_size);
-	IPW_DEBUG_INFO("exit\n");
 }
 
 static inline void ipw2100_hw_set_gpio(struct ipw2100_priv *priv)
@@ -1117,7 +1073,6 @@
 {
 #define MAX_RF_KILL_CHECKS 5
 #define RF_KILL_CHECK_DELAY 40
-#define RF_KILL_CHECK_THRESHOLD 3
 
 	unsigned short value = 0;
 	u32 reg = 0;
@@ -1198,8 +1153,6 @@
 	int i;
 	u32 inta, inta_mask, gpio;
 
-	IPW_DEBUG_INFO("enter\n");
-
 	if (priv->status & STATUS_RUNNING)
 		return 0;
 
@@ -1209,7 +1162,7 @@
 	 * fw & dino ucode
 	 */
 	if (ipw2100_download_firmware(priv)) {
-		IPW_DEBUG_ERROR("%s: Failed to power on the adapter.\n",
+		printk(KERN_ERR DRV_NAME ": %s: Failed to power on the adapter.\n",
 		       priv->net_dev->name);
 		return -EIO;
 	}
@@ -1269,7 +1222,7 @@
 		     i ? "SUCCESS" : "FAILED");
 
 	if (!i) {
-		IPW_DEBUG_WARNING("%s: Firmware did not initialize.\n",
+		printk(KERN_WARNING DRV_NAME ": %s: Firmware did not initialize.\n",
 		       priv->net_dev->name);
 		return -EIO;
 	}
@@ -1286,9 +1239,6 @@
 
 	/* The adapter has been reset; we are not associated */
 	priv->status &= ~(STATUS_ASSOCIATING | STATUS_ASSOCIATED);
-
-	IPW_DEBUG_INFO("exit\n");
-
 	return 0;
 }
 
@@ -1465,7 +1415,7 @@
 
 		err = ipw2100_hw_phy_off(priv);
 		if (err)
-			IPW_DEBUG_WARNING("Error disabling radio %d\n", err);
+			printk(KERN_WARNING DRV_NAME ": Error disabling radio %d\n", err);
 
 		/*
 		 * If in D0-standby mode going directly to D3 may cause a
@@ -1491,7 +1441,7 @@
 
 		err = ipw2100_hw_send_command(priv, &cmd);
 		if (err)
-			IPW_DEBUG_WARNING(
+			printk(KERN_WARNING DRV_NAME ": "
 			       "%s: Power down command failed: Error %d\n",
 			       priv->net_dev->name, err);
 		else {
@@ -1532,7 +1482,7 @@
 	}
 
 	if (i == 0)
-		IPW_DEBUG_WARNING(DRV_NAME
+		printk(KERN_WARNING DRV_NAME 
 		       ": %s: Could now power down adapter.\n",
 		       priv->net_dev->name);
 
@@ -1572,13 +1522,13 @@
 
 	err = ipw2100_hw_send_command(priv, &cmd);
 	if (err) {
-		IPW_DEBUG_WARNING("exit - failed to send CARD_DISABLE command\n");
+		printk(KERN_WARNING DRV_NAME ": exit - failed to send CARD_DISABLE command\n");
 		goto fail_up;
 	}
 
 	err = ipw2100_wait_for_card_state(priv, IPW_HW_STATE_DISABLED);
 	if (err) {
-		IPW_DEBUG_WARNING("exit - card failed to change to DISABLED\n");
+		printk(KERN_WARNING DRV_NAME ": exit - card failed to change to DISABLED\n");
 		goto fail_up;
 	}
 
@@ -1598,8 +1548,6 @@
 	};
 	int err;
 
-	IPW_DEBUG_INFO("enter\n");
-
 	IPW_DEBUG_SCAN("setting scan options\n");
 
 	cmd.host_command_parameters[0] = 0;
@@ -1643,8 +1591,6 @@
 		return 0;
 	}
 
-	IPW_DEBUG_INFO("enter\n");
-
 	/* Not clearing here; doing so makes iwlist always return nothing...
 	 *
 	 * We should modify the table logic to use aging tables vs. clearing
@@ -1657,8 +1603,6 @@
 	if (err)
 		priv->status &= ~STATUS_SCANNING;
 
-	IPW_DEBUG_INFO("exit\n");
-
 	return err;
 }
 
@@ -1688,7 +1632,7 @@
 	    (priv->status & STATUS_RESET_PENDING)) {
 		/* Power cycle the card ... */
 		if (ipw2100_power_cycle_adapter(priv)) {
-			IPW_DEBUG_WARNING("%s: Could not cycle adapter.\n",
+			printk(KERN_WARNING DRV_NAME ": %s: Could not cycle adapter.\n",
 					  priv->net_dev->name);
 			rc = 1;
 			goto exit;
@@ -1698,7 +1642,7 @@
 
 	/* Load the firmeware, start the clocks, etc. */
 	if (ipw2100_start_adapter(priv)) {
-	       	IPW_DEBUG_ERROR("%s: Failed to start the firmware.\n",
+	       	printk(KERN_ERR DRV_NAME ": %s: Failed to start the firmware.\n",
 				priv->net_dev->name);
 		rc = 1;
 		goto exit;
@@ -1708,7 +1652,7 @@
 
 	/* Determine capabilities of this particular HW configuration */
 	if (ipw2100_get_hw_features(priv)) {
-		IPW_DEBUG_ERROR("%s: Failed to determine HW features.\n",
+		printk(KERN_ERR DRV_NAME ": %s: Failed to determine HW features.\n",
 				priv->net_dev->name);
 		rc = 1;
 		goto exit;
@@ -1716,7 +1660,7 @@
 
 	lock = LOCK_NONE;
 	if (ipw2100_set_ordinal(priv, IPW_ORD_PERS_DB_LOCK, &lock, &ord_len)) {
-		IPW_DEBUG_ERROR("%s: Failed to clear ordinal lock.\n",
+		printk(KERN_ERR DRV_NAME ": %s: Failed to clear ordinal lock.\n",
 				priv->net_dev->name);
 		rc = 1;
 		goto exit;
@@ -1742,7 +1686,7 @@
 	/* Send all of the commands that must be sent prior to
 	 * HOST_COMPLETE */
 	if (ipw2100_adapter_setup(priv)) {
-		IPW_DEBUG_ERROR("%s: Failed to start the card.\n",
+		printk(KERN_ERR DRV_NAME ": %s: Failed to start the card.\n",
 				priv->net_dev->name);
 		rc = 1;
 		goto exit;
@@ -1751,7 +1695,7 @@
 	if (!deferred) {
 		/* Enable the adapter - sends HOST_COMPLETE */
 		if (ipw2100_enable_adapter(priv)) {
-			IPW_DEBUG_ERROR(
+			printk(KERN_ERR DRV_NAME ": "
 				"%s: failed in call to enable adapter.\n",
 				priv->net_dev->name);
 			ipw2100_hw_stop_adapter(priv);
@@ -1809,7 +1753,7 @@
 	spin_unlock_irqrestore(&priv->low_lock, flags);
 
 	if (ipw2100_hw_stop_adapter(priv))
-		IPW_DEBUG_ERROR("%s: Error stopping adapter.\n",
+		printk(KERN_ERR DRV_NAME ": %s: Error stopping adapter.\n",
 		       priv->net_dev->name);
 
 	/* Do not disable the interrupt until _after_ we disable
@@ -2285,18 +2229,10 @@
  * The size of the constructed ethernet
  *
  */
-#ifdef CONFIG_IPW2100_RX_DEBUG
-u8 packet_data[IPW_RX_NIC_BUFFER_LENGTH];
-#endif
 
 static inline void ipw2100_corruption_detected(struct ipw2100_priv *priv,
 					       int i)
 {
-#ifdef CONFIG_IPW_DEBUG_C3
-	struct ipw2100_status *status = &priv->status_queue.drv[i];
-	u32 match, reg;
-	int j;
-#endif
 #ifdef ACPI_CSTATE_LIMIT_DEFINED
 	int limit;
 #endif
@@ -2314,35 +2250,6 @@
 	}
 #endif
 
-#ifdef CONFIG_IPW_DEBUG_C3
-	/* Halt the fimrware so we can get a good image */
-	write_register(priv->net_dev, IPW_REG_RESET_REG,
-		       IPW_AUX_HOST_RESET_REG_STOP_MASTER);
-	j = 5;
-	do {
-		udelay(IPW_WAIT_RESET_MASTER_ASSERT_COMPLETE_DELAY);
-		read_register(priv->net_dev, IPW_REG_RESET_REG, &reg);
-
-		if (reg & IPW_AUX_HOST_RESET_REG_MASTER_DISABLED)
-			break;
-	}  while (j--);
-
-	match = ipw2100_match_buf(priv, (u8*)status,
-				  sizeof(struct ipw2100_status),
-				  SEARCH_SNAPSHOT);
-	if (match < SEARCH_SUCCESS)
-		IPW_DEBUG_INFO("%s: DMA status match in Firmware at "
-			       "offset 0x%06X, length %d:\n",
-			       priv->net_dev->name, match,
-			       sizeof(struct ipw2100_status));
-	else
-		IPW_DEBUG_INFO("%s: No DMA status match in "
-			       "Firmware.\n", priv->net_dev->name);
-
-	printk_buf((u8*)priv->status_queue.drv,
-		   sizeof(struct ipw2100_status) * RX_QUEUE_LENGTH);
-#endif
-
 	priv->fatal_error = IPW2100_ERR_C3_CORRUPTION;
 	priv->ieee->stats.rx_errors++;
 	schedule_reset(priv);
@@ -2394,19 +2301,7 @@
 
 	skb_put(packet->skb, status->frame_size);
 
-#ifdef CONFIG_IPW2100_RX_DEBUG
-	/* Make a copy of the frame so we can dump it to the logs if
-	 * ieee80211_rx fails */
-	memcpy(packet_data, packet->skb->data,
-	       min(status->frame_size, IPW_RX_NIC_BUFFER_LENGTH));
-#endif
-
 	if (!ieee80211_rx(priv->ieee, packet->skb, stats)) {
-#ifdef CONFIG_IPW2100_RX_DEBUG
-		IPW_DEBUG_DROP("%s: Non consumed packet:\n",
-			       priv->net_dev->name);
-		printk_buf(IPW_DL_DROP, packet_data, status->frame_size);
-#endif
 		priv->ieee->stats.rx_errors++;
 
 		/* ieee80211_rx failed, so it didn't free the SKB */
@@ -2416,7 +2311,7 @@
 
 	/* We need to allocate a new SKB and attach it to the RDB. */
 	if (unlikely(ipw2100_alloc_skb(priv, packet))) {
-		IPW_DEBUG_WARNING(
+		printk(KERN_WARNING DRV_NAME ": "
 			"%s: Unable to allocate SKB onto RBD ring - disabling "
 			"adapter.\n", priv->net_dev->name);
 		/* TODO: schedule adapter shutdown */
@@ -2678,7 +2573,7 @@
 		break;
 
 	default:
-		IPW_DEBUG_WARNING("%s: Bad fw_pend_list entry!\n",
+		printk(KERN_WARNING DRV_NAME ": %s: Bad fw_pend_list entry!\n",
 				   priv->net_dev->name);
 		return 0;
 	}
@@ -2692,7 +2587,7 @@
 	read_register(priv->net_dev, IPW_MEM_HOST_SHARED_TX_QUEUE_WRITE_INDEX,
 		      &w);
 	if (w != txq->next)
-		IPW_DEBUG_WARNING("%s: write index mismatch\n",
+		printk(KERN_WARNING DRV_NAME ": %s: write index mismatch\n",
 		       priv->net_dev->name);
 
         /*
@@ -2753,7 +2648,7 @@
 	switch (packet->type) {
 	case DATA:
 		if (txq->drv[txq->oldest].status.info.fields.txType != 0)
-			IPW_DEBUG_WARNING("%s: Queue mismatch.  "
+			printk(KERN_WARNING DRV_NAME ": %s: Queue mismatch.  "
 			       "Expecting DATA TBD but pulled "
 			       "something else: ids %d=%d.\n",
 			       priv->net_dev->name, txq->oldest, packet->index);
@@ -2800,7 +2695,7 @@
 
 	case COMMAND:
 		if (txq->drv[txq->oldest].status.info.fields.txType != 1)
-			IPW_DEBUG_WARNING("%s: Queue mismatch.  "
+			printk(KERN_WARNING DRV_NAME ": %s: Queue mismatch.  "
 			       "Expecting COMMAND TBD but pulled "
 			       "something else: ids %d=%d.\n",
 			       priv->net_dev->name, txq->oldest, packet->index);
@@ -2840,14 +2735,14 @@
 	while (__ipw2100_tx_process(priv) && i < 200) i++;
 
 	if (i == 200) {
-		IPW_DEBUG_WARNING(
+		printk(KERN_WARNING DRV_NAME ": "
 		       "%s: Driver is running slow (%d iters).\n",
 		       priv->net_dev->name, i);
 	}
 }
 
 
-static void X__ipw2100_tx_send_commands(struct ipw2100_priv *priv)
+static void ipw2100_tx_send_commands(struct ipw2100_priv *priv)
 {
 	struct list_head *element;
 	struct ipw2100_tx_packet *packet;
@@ -2915,10 +2810,10 @@
 
 
 /*
- * X__ipw2100_tx_send_data
+ * ipw2100_tx_send_data
  *
  */
-static void X__ipw2100_tx_send_data(struct ipw2100_priv *priv)
+static void ipw2100_tx_send_data(struct ipw2100_priv *priv)
 {
 	struct list_head *element;
 	struct ipw2100_tx_packet *packet;
@@ -3084,7 +2979,7 @@
 		      (unsigned long)inta & IPW_INTERRUPT_MASK);
 
 	if (inta & IPW2100_INTA_FATAL_ERROR) {
-		IPW_DEBUG_WARNING(DRV_NAME
+		printk(KERN_WARNING DRV_NAME
 				  ": Fatal interrupt. Scheduling firmware restart.\n");
 		priv->inta_other++;
 		write_register(
@@ -3104,7 +2999,7 @@
 	}
 
 	if (inta & IPW2100_INTA_PARITY_ERROR) {
-		IPW_DEBUG_ERROR("***** PARITY ERROR INTERRUPT !!!! \n");
+		printk(KERN_ERR DRV_NAME ": ***** PARITY ERROR INTERRUPT !!!! \n");
 		priv->inta_other++;
 		write_register(
 			dev, IPW_REG_INTA,
@@ -3133,8 +3028,8 @@
 			       IPW2100_INTA_TX_TRANSFER);
 
 		__ipw2100_tx_complete(priv);
-		X__ipw2100_tx_send_commands(priv);
-		X__ipw2100_tx_send_data(priv);
+		ipw2100_tx_send_commands(priv);
+		ipw2100_tx_send_data(priv);
 	}
 
 	if (inta & IPW2100_INTA_TX_COMPLETE) {
@@ -3192,8 +3087,6 @@
 	ipw2100_enable_interrupts(priv);
 
 	spin_unlock_irqrestore(&priv->low_lock, flags);
-
-	IPW_DEBUG_ISR("exit\n");
 }
 
 
@@ -3222,7 +3115,7 @@
 
 	if (inta == 0xFFFFFFFF) {
 		/* Hardware disappeared */
-		IPW_DEBUG_WARNING("IRQ INTA == 0xFFFFFFFF\n");
+		printk(KERN_WARNING DRV_NAME ": IRQ INTA == 0xFFFFFFFF\n");
 		goto none;
 	}
 
@@ -3285,7 +3178,7 @@
 	list_add_tail(element, &priv->tx_pend_list);
 	INC_STAT(&priv->tx_pend_stat);
 
-	X__ipw2100_tx_send_data(priv);
+	ipw2100_tx_send_data(priv);
 
 	spin_unlock_irqrestore(&priv->low_lock, flags);
 	return 0;
@@ -3307,7 +3200,7 @@
 		IPW_COMMAND_POOL_SIZE * sizeof(struct ipw2100_tx_packet),
 		GFP_KERNEL);
 	if (!priv->msg_buffers) {
-		IPW_DEBUG_ERROR("%s: PCI alloc failed for msg "
+		printk(KERN_ERR DRV_NAME ": %s: PCI alloc failed for msg "
 		       "buffers.\n", priv->net_dev->name);
 		return -ENOMEM;
 	}
@@ -3318,7 +3211,7 @@
 			sizeof(struct ipw2100_cmd_header),
 			&p);
 		if (!v) {
-			IPW_DEBUG_ERROR(
+			printk(KERN_ERR DRV_NAME ": "
 			       "%s: PCI alloc failed for msg "
 			       "buffers.\n",
 			       priv->net_dev->name);
@@ -3383,429 +3276,6 @@
 	priv->msg_buffers = NULL;
 }
 
-static ssize_t show_pci(struct device *d, char *buf)
-{
-	struct pci_dev *pci_dev = container_of(d, struct pci_dev, dev);
-	char *out = buf;
-	int i, j;
-	u32 val;
-
-	for (i = 0; i < 16; i++) {
-		out += sprintf(out, "[%08X] ", i * 16);
-		for (j = 0; j < 16; j += 4) {
-			pci_read_config_dword(pci_dev, i * 16 + j, &val);
-			out += sprintf(out, "%08X ", val);
-		}
-		out += sprintf(out, "\n");
-	}
-
-	return out - buf;
-}
-static DEVICE_ATTR(pci, S_IRUGO, show_pci, NULL);
-
-static ssize_t show_cfg(struct device *d, char *buf)
-{
-	struct ipw2100_priv *p = (struct ipw2100_priv *)d->driver_data;
-	return sprintf(buf, "0x%08x\n", (int)p->config);
-}
-static DEVICE_ATTR(cfg, S_IRUGO, show_cfg, NULL);
-
-static ssize_t show_status(struct device *d, char *buf)
-{
-	struct ipw2100_priv *p = (struct ipw2100_priv *)d->driver_data;
-	return sprintf(buf, "0x%08x\n", (int)p->status);
-}
-static DEVICE_ATTR(status, S_IRUGO, show_status, NULL);
-
-static ssize_t show_capability(struct device *d, char *buf)
-{
-	struct ipw2100_priv *p = (struct ipw2100_priv *)d->driver_data;
-	return sprintf(buf, "0x%08x\n", (int)p->capability);
-}
-static DEVICE_ATTR(capability, S_IRUGO, show_capability, NULL);
-
-
-#define IPW2100_REG(x) { IPW_ ##x, #x }
-const struct {
-	u32 addr;
-	const char *name;
-} hw_data[] = {
-	IPW2100_REG(REG_GP_CNTRL),
-	IPW2100_REG(REG_GPIO),
-	IPW2100_REG(REG_INTA),
-	IPW2100_REG(REG_INTA_MASK),
-	IPW2100_REG(REG_RESET_REG),
-};
-#define IPW2100_NIC(x, s) { x, #x, s }
-const struct {
-	u32 addr;
-	const char *name;
-	size_t size;
-} nic_data[] = {
-	IPW2100_NIC(IPW2100_CONTROL_REG, 2),
-	IPW2100_NIC(0x210014, 1),
-	IPW2100_NIC(0x210000, 1),
-};
-#define IPW2100_ORD(x, d) { IPW_ORD_ ##x, #x, d }
-const struct {
-	u8 index;
-	const char *name;
-	const char *desc;
-} ord_data[] = {
-	IPW2100_ORD(STAT_TX_HOST_REQUESTS, "requested Host Tx's (MSDU)"),
-	IPW2100_ORD(STAT_TX_HOST_COMPLETE, "successful Host Tx's (MSDU)"),
-	IPW2100_ORD(STAT_TX_DIR_DATA,	   "successful Directed Tx's (MSDU)"),
-	IPW2100_ORD(STAT_TX_DIR_DATA1,	   "successful Directed Tx's (MSDU) @ 1MB"),
-	IPW2100_ORD(STAT_TX_DIR_DATA2,	   "successful Directed Tx's (MSDU) @ 2MB"),
-	IPW2100_ORD(STAT_TX_DIR_DATA5_5,   "successful Directed Tx's (MSDU) @ 5_5MB"),
-	IPW2100_ORD(STAT_TX_DIR_DATA11,	   "successful Directed Tx's (MSDU) @ 11MB"),
-	IPW2100_ORD(STAT_TX_NODIR_DATA1,   "successful Non_Directed Tx's (MSDU) @ 1MB"),
-	IPW2100_ORD(STAT_TX_NODIR_DATA2,   "successful Non_Directed Tx's (MSDU) @ 2MB"),
-	IPW2100_ORD(STAT_TX_NODIR_DATA5_5, "successful Non_Directed Tx's (MSDU) @ 5.5MB"),
-	IPW2100_ORD(STAT_TX_NODIR_DATA11,  "successful Non_Directed Tx's (MSDU) @ 11MB"),
-	IPW2100_ORD(STAT_NULL_DATA,	   "successful NULL data Tx's"),
-	IPW2100_ORD(STAT_TX_RTS,	   "successful Tx RTS"),
-	IPW2100_ORD(STAT_TX_CTS,	   "successful Tx CTS"),
-	IPW2100_ORD(STAT_TX_ACK,	   "successful Tx ACK"),
-	IPW2100_ORD(STAT_TX_ASSN,	   "successful Association Tx's"),
-	IPW2100_ORD(STAT_TX_ASSN_RESP,	   "successful Association response Tx's"),
-	IPW2100_ORD(STAT_TX_REASSN,	   "successful Reassociation Tx's"),
-	IPW2100_ORD(STAT_TX_REASSN_RESP,   "successful Reassociation response Tx's"),
-	IPW2100_ORD(STAT_TX_PROBE,	   "probes successfully transmitted"),
-	IPW2100_ORD(STAT_TX_PROBE_RESP,	   "probe responses successfully transmitted"),
-	IPW2100_ORD(STAT_TX_BEACON,	   "tx beacon"),
-	IPW2100_ORD(STAT_TX_ATIM,	   "Tx ATIM"),
-	IPW2100_ORD(STAT_TX_DISASSN,	   "successful Disassociation TX"),
-	IPW2100_ORD(STAT_TX_AUTH,	   "successful Authentication Tx"),
-	IPW2100_ORD(STAT_TX_DEAUTH,	   "successful Deauthentication TX"),
-	IPW2100_ORD(STAT_TX_TOTAL_BYTES,   "Total successful Tx data bytes"),
-	IPW2100_ORD(STAT_TX_RETRIES,       "Tx retries"),
-	IPW2100_ORD(STAT_TX_RETRY1,        "Tx retries at 1MBPS"),
-	IPW2100_ORD(STAT_TX_RETRY2,        "Tx retries at 2MBPS"),
-	IPW2100_ORD(STAT_TX_RETRY5_5,	   "Tx retries at 5.5MBPS"),
-	IPW2100_ORD(STAT_TX_RETRY11,	   "Tx retries at 11MBPS"),
-	IPW2100_ORD(STAT_TX_FAILURES,	   "Tx Failures"),
-	IPW2100_ORD(STAT_TX_MAX_TRIES_IN_HOP,"times max tries in a hop failed"),
-	IPW2100_ORD(STAT_TX_DISASSN_FAIL,	"times disassociation failed"),
-	IPW2100_ORD(STAT_TX_ERR_CTS,         "missed/bad CTS frames"),
-	IPW2100_ORD(STAT_TX_ERR_ACK,	"tx err due to acks"),
-	IPW2100_ORD(STAT_RX_HOST,	"packets passed to host"),
-	IPW2100_ORD(STAT_RX_DIR_DATA,	"directed packets"),
-	IPW2100_ORD(STAT_RX_DIR_DATA1,	"directed packets at 1MB"),
-	IPW2100_ORD(STAT_RX_DIR_DATA2,	"directed packets at 2MB"),
-	IPW2100_ORD(STAT_RX_DIR_DATA5_5,	"directed packets at 5.5MB"),
-	IPW2100_ORD(STAT_RX_DIR_DATA11,	"directed packets at 11MB"),
-	IPW2100_ORD(STAT_RX_NODIR_DATA,"nondirected packets"),
-	IPW2100_ORD(STAT_RX_NODIR_DATA1,	"nondirected packets at 1MB"),
-	IPW2100_ORD(STAT_RX_NODIR_DATA2,	"nondirected packets at 2MB"),
-	IPW2100_ORD(STAT_RX_NODIR_DATA5_5,	"nondirected packets at 5.5MB"),
-	IPW2100_ORD(STAT_RX_NODIR_DATA11,	"nondirected packets at 11MB"),
-	IPW2100_ORD(STAT_RX_NULL_DATA,	"null data rx's"),
-	IPW2100_ORD(STAT_RX_RTS,	"Rx RTS"),
-	IPW2100_ORD(STAT_RX_CTS,	"Rx CTS"),
-	IPW2100_ORD(STAT_RX_ACK,	"Rx ACK"),
-	IPW2100_ORD(STAT_RX_CFEND,	"Rx CF End"),
-	IPW2100_ORD(STAT_RX_CFEND_ACK,	"Rx CF End + CF Ack"),
-	IPW2100_ORD(STAT_RX_ASSN,	"Association Rx's"),
-	IPW2100_ORD(STAT_RX_ASSN_RESP,	"Association response Rx's"),
-	IPW2100_ORD(STAT_RX_REASSN,	"Reassociation Rx's"),
-	IPW2100_ORD(STAT_RX_REASSN_RESP,	"Reassociation response Rx's"),
-	IPW2100_ORD(STAT_RX_PROBE,	"probe Rx's"),
-	IPW2100_ORD(STAT_RX_PROBE_RESP,	"probe response Rx's"),
-	IPW2100_ORD(STAT_RX_BEACON,	"Rx beacon"),
-	IPW2100_ORD(STAT_RX_ATIM,	"Rx ATIM"),
-	IPW2100_ORD(STAT_RX_DISASSN,	"disassociation Rx"),
-	IPW2100_ORD(STAT_RX_AUTH,	"authentication Rx"),
-	IPW2100_ORD(STAT_RX_DEAUTH,	"deauthentication Rx"),
-	IPW2100_ORD(STAT_RX_TOTAL_BYTES,"Total rx data bytes received"),
-	IPW2100_ORD(STAT_RX_ERR_CRC,	 "packets with Rx CRC error"),
-	IPW2100_ORD(STAT_RX_ERR_CRC1,	 "Rx CRC errors at 1MB"),
-	IPW2100_ORD(STAT_RX_ERR_CRC2,	 "Rx CRC errors at 2MB"),
-	IPW2100_ORD(STAT_RX_ERR_CRC5_5,	 "Rx CRC errors at 5.5MB"),
-	IPW2100_ORD(STAT_RX_ERR_CRC11,	 "Rx CRC errors at 11MB"),
-	IPW2100_ORD(STAT_RX_DUPLICATE1, "duplicate rx packets at 1MB"),
-	IPW2100_ORD(STAT_RX_DUPLICATE2,	 "duplicate rx packets at 2MB"),
-	IPW2100_ORD(STAT_RX_DUPLICATE5_5,	 "duplicate rx packets at 5.5MB"),
-	IPW2100_ORD(STAT_RX_DUPLICATE11,	 "duplicate rx packets at 11MB"),
-	IPW2100_ORD(STAT_RX_DUPLICATE, "duplicate rx packets"),
-	IPW2100_ORD(PERS_DB_LOCK,	"locking fw permanent  db"),
-	IPW2100_ORD(PERS_DB_SIZE,	"size of fw permanent  db"),
-	IPW2100_ORD(PERS_DB_ADDR,	"address of fw permanent  db"),
-	IPW2100_ORD(STAT_RX_INVALID_PROTOCOL,	"rx frames with invalid protocol"),
-	IPW2100_ORD(SYS_BOOT_TIME,	"Boot time"),
-	IPW2100_ORD(STAT_RX_NO_BUFFER,	"rx frames rejected due to no buffer"),
-	IPW2100_ORD(STAT_RX_MISSING_FRAG,	"rx frames dropped due to missing fragment"),
-	IPW2100_ORD(STAT_RX_ORPHAN_FRAG,	"rx frames dropped due to non-sequential fragment"),
-	IPW2100_ORD(STAT_RX_ORPHAN_FRAME,	"rx frames dropped due to unmatched 1st frame"),
-	IPW2100_ORD(STAT_RX_FRAG_AGEOUT,	"rx frames dropped due to uncompleted frame"),
-	IPW2100_ORD(STAT_RX_ICV_ERRORS,	"ICV errors during decryption"),
-	IPW2100_ORD(STAT_PSP_SUSPENSION,"times adapter suspended"),
-	IPW2100_ORD(STAT_PSP_BCN_TIMEOUT,	"beacon timeout"),
-	IPW2100_ORD(STAT_PSP_POLL_TIMEOUT,	"poll response timeouts"),
-	IPW2100_ORD(STAT_PSP_NONDIR_TIMEOUT, "timeouts waiting for last {broad,multi}cast pkt"),
-	IPW2100_ORD(STAT_PSP_RX_DTIMS,	"PSP DTIMs received"),
-	IPW2100_ORD(STAT_PSP_RX_TIMS,	"PSP TIMs received"),
-	IPW2100_ORD(STAT_PSP_STATION_ID,"PSP Station ID"),
-	IPW2100_ORD(LAST_ASSN_TIME,	"RTC time of last association"),
-	IPW2100_ORD(STAT_PERCENT_MISSED_BCNS,"current calculation of % missed beacons"),
-	IPW2100_ORD(STAT_PERCENT_RETRIES,"current calculation of % missed tx retries"),
-	IPW2100_ORD(ASSOCIATED_AP_PTR,	"0 if not associated, else pointer to AP table entry"),
-	IPW2100_ORD(AVAILABLE_AP_CNT,	"AP's decsribed in the AP table"),
-	IPW2100_ORD(AP_LIST_PTR,	"Ptr to list of available APs"),
-	IPW2100_ORD(STAT_AP_ASSNS,	"associations"),
-	IPW2100_ORD(STAT_ASSN_FAIL,	"association failures"),
-	IPW2100_ORD(STAT_ASSN_RESP_FAIL,"failures due to response fail"),
-	IPW2100_ORD(STAT_FULL_SCANS,	"full scans"),
-	IPW2100_ORD(CARD_DISABLED,	"Card Disabled"),
-	IPW2100_ORD(STAT_ROAM_INHIBIT,	"times roaming was inhibited due to activity"),
-	IPW2100_ORD(RSSI_AT_ASSN,	"RSSI of associated AP at time of association"),
-	IPW2100_ORD(STAT_ASSN_CAUSE1,	"reassociation: no probe response or TX on hop"),
-	IPW2100_ORD(STAT_ASSN_CAUSE2,	"reassociation: poor tx/rx quality"),
-	IPW2100_ORD(STAT_ASSN_CAUSE3,	"reassociation: tx/rx quality (excessive AP load"),
-	IPW2100_ORD(STAT_ASSN_CAUSE4,	"reassociation: AP RSSI level"),
-	IPW2100_ORD(STAT_ASSN_CAUSE5,	"reassociations due to load leveling"),
-	IPW2100_ORD(STAT_AUTH_FAIL,	"times authentication failed"),
-	IPW2100_ORD(STAT_AUTH_RESP_FAIL,"times authentication response failed"),
-	IPW2100_ORD(STATION_TABLE_CNT,	"entries in association table"),
-	IPW2100_ORD(RSSI_AVG_CURR,	"Current avg RSSI"),
-	IPW2100_ORD(POWER_MGMT_MODE,	"Power mode - 0=CAM, 1=PSP"),
-	IPW2100_ORD(COUNTRY_CODE,	"IEEE country code as recv'd from beacon"),
-	IPW2100_ORD(COUNTRY_CHANNELS,	"channels suported by country"),
-	IPW2100_ORD(RESET_CNT,	"adapter resets (warm)"),
-	IPW2100_ORD(BEACON_INTERVAL,	"Beacon interval"),
-	IPW2100_ORD(ANTENNA_DIVERSITY,	"TRUE if antenna diversity is disabled"),
-	IPW2100_ORD(DTIM_PERIOD,	"beacon intervals between DTIMs"),
-	IPW2100_ORD(OUR_FREQ,	"current radio freq lower digits - channel ID"),
-	IPW2100_ORD(RTC_TIME,	"current RTC time"),
-	IPW2100_ORD(PORT_TYPE,	"operating mode"),
-	IPW2100_ORD(CURRENT_TX_RATE,	"current tx rate"),
-	IPW2100_ORD(SUPPORTED_RATES,	"supported tx rates"),
-	IPW2100_ORD(ATIM_WINDOW,	"current ATIM Window"),
-	IPW2100_ORD(BASIC_RATES,	"basic tx rates"),
-	IPW2100_ORD(NIC_HIGHEST_RATE,	"NIC highest tx rate"),
-	IPW2100_ORD(AP_HIGHEST_RATE,	"AP highest tx rate"),
-	IPW2100_ORD(CAPABILITIES,	"Management frame capability field"),
-	IPW2100_ORD(AUTH_TYPE,	"Type of authentication"),
-	IPW2100_ORD(RADIO_TYPE,	"Adapter card platform type"),
-	IPW2100_ORD(RTS_THRESHOLD,	"Min packet length for RTS handshaking"),
-	IPW2100_ORD(INT_MODE,	"International mode"),
-	IPW2100_ORD(FRAGMENTATION_THRESHOLD,	"protocol frag threshold"),
-	IPW2100_ORD(EEPROM_SRAM_DB_BLOCK_START_ADDRESS,	"EEPROM offset in SRAM"),
-	IPW2100_ORD(EEPROM_SRAM_DB_BLOCK_SIZE,	"EEPROM size in SRAM"),
-	IPW2100_ORD(EEPROM_SKU_CAPABILITY,	"EEPROM SKU Capability"),
-	IPW2100_ORD(EEPROM_IBSS_11B_CHANNELS,	"EEPROM IBSS 11b channel set"),
-	IPW2100_ORD(MAC_VERSION,	"MAC Version"),
-	IPW2100_ORD(MAC_REVISION,	"MAC Revision"),
-	IPW2100_ORD(RADIO_VERSION,	"Radio Version"),
-	IPW2100_ORD(NIC_MANF_DATE_TIME,	"MANF Date/Time STAMP"),
-	IPW2100_ORD(UCODE_VERSION,	"Ucode Version"),
-};
-
-
-static ssize_t show_registers(struct device *d, char *buf)
-{
-	int i;
-	struct ipw2100_priv *priv = dev_get_drvdata(d);
-	struct net_device *dev = priv->net_dev;
-	char * out = buf;
-	u32 val = 0;
-
-	out += sprintf(out, "%30s [Address ] : Hex\n", "Register");
-
-	for (i = 0; i < (sizeof(hw_data) / sizeof(*hw_data)); i++) {
-		read_register(dev, hw_data[i].addr, &val);
-		out += sprintf(out, "%30s [%08X] : %08X\n",
-			       hw_data[i].name, hw_data[i].addr, val);
-	}
-
-	return out - buf;
-}
-static DEVICE_ATTR(registers, S_IRUGO, show_registers, NULL);
-
-
-static ssize_t show_hardware(struct device *d, char *buf)
-{
-	struct ipw2100_priv *priv = dev_get_drvdata(d);
-	struct net_device *dev = priv->net_dev;
-	char * out = buf;
-	int i;
-
-	out += sprintf(out, "%30s [Address ] : Hex\n", "NIC entry");
-
-	for (i = 0; i < (sizeof(nic_data) / sizeof(*nic_data)); i++) {
-		u8 tmp8;
-		u16 tmp16;
-		u32 tmp32;
-
-		switch (nic_data[i].size) {
-		case 1:
-			read_nic_byte(dev, nic_data[i].addr, &tmp8);
-			out += sprintf(out, "%30s [%08X] : %02X\n",
-				       nic_data[i].name, nic_data[i].addr,
-				       tmp8);
-			break;
-		case 2:
-			read_nic_word(dev, nic_data[i].addr, &tmp16);
-			out += sprintf(out, "%30s [%08X] : %04X\n",
-				       nic_data[i].name, nic_data[i].addr,
-				       tmp16);
-			break;
-		case 4:
-			read_nic_dword(dev, nic_data[i].addr, &tmp32);
-			out += sprintf(out, "%30s [%08X] : %08X\n",
-				       nic_data[i].name, nic_data[i].addr,
-				       tmp32);
-			break;
-		}
-	}
-	return out - buf;
-}
-static DEVICE_ATTR(hardware, S_IRUGO, show_hardware, NULL);
-
-
-static ssize_t show_memory(struct device *d, char *buf)
-{
-	struct ipw2100_priv *priv = dev_get_drvdata(d);
-	struct net_device *dev = priv->net_dev;
-	static unsigned long loop = 0;
-	int len = 0;
-	u32 buffer[4];
-	int i;
-	char line[81];
-
-	if (loop >= 0x30000)
-		loop = 0;
-
-	/* sysfs provides us PAGE_SIZE buffer */
-	while (len < PAGE_SIZE - 128 && loop < 0x30000) {
-
-		if (priv->snapshot[0]) for (i = 0; i < 4; i++)
-			buffer[i] = *(u32 *)SNAPSHOT_ADDR(loop + i * 4);
-		else for (i = 0; i < 4; i++)
-			read_nic_dword(dev, loop + i * 4, &buffer[i]);
-
-		if (priv->dump_raw)
-			len += sprintf(buf + len,
-				       "%c%c%c%c"
-				       "%c%c%c%c"
-				       "%c%c%c%c"
-				       "%c%c%c%c",
-				       ((u8*)buffer)[0x0],
-				       ((u8*)buffer)[0x1],
-				       ((u8*)buffer)[0x2],
-				       ((u8*)buffer)[0x3],
-				       ((u8*)buffer)[0x4],
-				       ((u8*)buffer)[0x5],
-				       ((u8*)buffer)[0x6],
-				       ((u8*)buffer)[0x7],
-				       ((u8*)buffer)[0x8],
-				       ((u8*)buffer)[0x9],
-				       ((u8*)buffer)[0xa],
-				       ((u8*)buffer)[0xb],
-				       ((u8*)buffer)[0xc],
-				       ((u8*)buffer)[0xd],
-				       ((u8*)buffer)[0xe],
-				       ((u8*)buffer)[0xf]);
-		else
-			len += sprintf(buf + len, "%s\n",
-				       snprint_line(line, sizeof(line),
-						    (u8*)buffer, 16, loop));
-		loop += 16;
-	}
-
-	return len;
-}
-
-static ssize_t store_memory(struct device *d, const char *buf, size_t count)
-{
-	struct ipw2100_priv *priv = dev_get_drvdata(d);
-	struct net_device *dev = priv->net_dev;
-	const char *p = buf;
-
-	if (count < 1)
-		return count;
-
-	if (p[0] == '1' ||
-	    (count >= 2 && tolower(p[0]) == 'o' && tolower(p[1]) == 'n')) {
-		IPW_DEBUG_INFO("%s: Setting memory dump to RAW mode.\n",
-		       dev->name);
-		priv->dump_raw = 1;
-
-	} else if (p[0] == '0' || (count >= 2 && tolower(p[0]) == 'o' &&
-				  tolower(p[1]) == 'f')) {
-		IPW_DEBUG_INFO("%s: Setting memory dump to HEX mode.\n",
-		       dev->name);
-		priv->dump_raw = 0;
-
-	} else if (tolower(p[0]) == 'r') {
-		IPW_DEBUG_INFO("%s: Resetting firmware snapshot.\n",
-		       dev->name);
-		ipw2100_snapshot_free(priv);
-
-	} else
-		IPW_DEBUG_INFO("%s: Usage: 0|on = HEX, 1|off = RAW, "
-		       "reset = clear memory snapshot\n",
-		       dev->name);
-
-	return count;
-}
-static DEVICE_ATTR(memory, S_IWUSR|S_IRUGO, show_memory, store_memory);
-
-
-static ssize_t show_ordinals(struct device *d, char *buf)
-{
-	struct ipw2100_priv *priv = dev_get_drvdata(d);
-	u32 val = 0;
-	int len = 0;
-	u32 val_len;
-	static int loop = 0;
-
-	if (loop >= sizeof(ord_data) / sizeof(*ord_data))
-		loop = 0;
-
-	/* sysfs provides us PAGE_SIZE buffer */
-	while (len < PAGE_SIZE - 128 &&
-	       loop < (sizeof(ord_data) / sizeof(*ord_data))) {
-
-		val_len = sizeof(u32);
-
-		if (ipw2100_get_ordinal(priv, ord_data[loop].index, &val,
-					&val_len))
-			len += sprintf(buf + len, "[0x%02X] = ERROR    %s\n",
-				       ord_data[loop].index,
-				       ord_data[loop].desc);
-		else
-			len += sprintf(buf + len, "[0x%02X] = 0x%08X %s\n",
-				       ord_data[loop].index, val,
-				       ord_data[loop].desc);
-		loop++;
-	}
-
-	return len;
-}
-static DEVICE_ATTR(ordinals, S_IRUGO, show_ordinals, NULL);
-
-
-static ssize_t show_stats(struct device *d, char *buf)
-{
-	struct ipw2100_priv *priv = dev_get_drvdata(d);
-	char * out = buf;
-
-	out += sprintf(out, "interrupts: %d {tx: %d, rx: %d, other: %d}\n",
-		       priv->interrupts, priv->tx_interrupts,
-		       priv->rx_interrupts, priv->inta_other);
-	out += sprintf(out, "firmware resets: %d\n", priv->resets);
-	out += sprintf(out, "firmware hangs: %d\n", priv->hangs);
-#ifdef CONFIG_IPW_DEBUG
-	out += sprintf(out, "packet mismatch image: %s\n",
-		       priv->snapshot[0] ? "YES" : "NO");
-#endif
-
-	return out - buf;
-}
-static DEVICE_ATTR(stats, S_IRUGO, show_stats, NULL);
-
-
 int ipw2100_switch_mode(struct ipw2100_priv *priv, u32 mode)
 {
 	int err;
@@ -3815,7 +3285,7 @@
 
 	err = ipw2100_disable_adapter(priv);
 	if (err) {
-		IPW_DEBUG_ERROR("%s: Could not disable adapter %d\n",
+		printk(KERN_ERR DRV_NAME ": %s: Could not disable adapter %d\n",
 		       priv->net_dev->name, err);
 		return err;
 	}
@@ -3837,11 +3307,9 @@
 
 	priv->ieee->iw_mode = mode;
 
-#ifdef CONFIG_PM
         /* Indicate ipw2100_download_firmware download firmware
 	 * from disk instead of memory. */
 	ipw2100_firmware.version = 0;
-#endif
 
 	printk(KERN_INFO "%s: Reseting on mode change.\n",
 		priv->net_dev->name);
@@ -3851,100 +3319,6 @@
 	return 0;
 }
 
-static ssize_t show_internals(struct device *d, char *buf)
-{
-	struct ipw2100_priv *priv = dev_get_drvdata(d);
-	int len = 0;
-
-#define DUMP_VAR(x,y) len += sprintf(buf + len, # x ": %" # y "\n", priv-> x)
-
-	if (priv->status & STATUS_ASSOCIATED)
-		len += sprintf(buf + len, "connected: %lu\n",
-			       get_seconds() - priv->connect_start);
-	else
-		len += sprintf(buf + len, "not connected\n");
-
-	DUMP_VAR(ieee->crypt[priv->ieee->tx_keyidx], p);
-	DUMP_VAR(status, 08lx);
-	DUMP_VAR(config, 08lx);
-	DUMP_VAR(capability, 08lx);
-
-	len += sprintf(buf + len, "last_rtc: %lu\n", (unsigned long)priv->last_rtc);
-
-	DUMP_VAR(fatal_error, d);
-	DUMP_VAR(stop_hang_check, d);
-	DUMP_VAR(stop_rf_kill, d);
-	DUMP_VAR(messages_sent, d);
-
-	DUMP_VAR(tx_pend_stat.value, d);
-	DUMP_VAR(tx_pend_stat.hi, d);
-
-	DUMP_VAR(tx_free_stat.value, d);
-	DUMP_VAR(tx_free_stat.lo, d);
-
-	DUMP_VAR(msg_free_stat.value, d);
-	DUMP_VAR(msg_free_stat.lo, d);
-
-	DUMP_VAR(msg_pend_stat.value, d);
-	DUMP_VAR(msg_pend_stat.hi, d);
-
-	DUMP_VAR(fw_pend_stat.value, d);
-	DUMP_VAR(fw_pend_stat.hi, d);
-
-	DUMP_VAR(txq_stat.value, d);
-	DUMP_VAR(txq_stat.lo, d);
-
-	DUMP_VAR(ieee->scans, d);
-	DUMP_VAR(reset_backoff, d);
-
-	return len;
-}
-static DEVICE_ATTR(internals, S_IRUGO, show_internals, NULL);
-
-
-static ssize_t show_bssinfo(struct device *d, char *buf)
-{
-	struct ipw2100_priv *priv = dev_get_drvdata(d);
-	char essid[IW_ESSID_MAX_SIZE + 1];
-	u8 bssid[ETH_ALEN];
-	u32 chan = 0;
-	char * out = buf;
-	int length;
-	int ret;
-
-	memset(essid, 0, sizeof(essid));
-	memset(bssid, 0, sizeof(bssid));
-
-	length = IW_ESSID_MAX_SIZE;
-	ret = ipw2100_get_ordinal(priv, IPW_ORD_STAT_ASSN_SSID, essid, &length);
-	if (ret)
-		IPW_DEBUG_INFO("failed querying ordinals at line %d\n",
-			       __LINE__);
-
-	length = sizeof(bssid);
-	ret = ipw2100_get_ordinal(priv, IPW_ORD_STAT_ASSN_AP_BSSID,
-				  bssid, &length);
-	if (ret)
-		IPW_DEBUG_INFO("failed querying ordinals at line %d\n",
-			       __LINE__);
-
-	length = sizeof(u32);
-	ret = ipw2100_get_ordinal(priv, IPW_ORD_OUR_FREQ, &chan, &length);
-	if (ret)
-		IPW_DEBUG_INFO("failed querying ordinals at line %d\n",
-			       __LINE__);
-
-	out += sprintf(out, "ESSID: %s\n", essid);
-	out += sprintf(out, "BSSID:   %02x:%02x:%02x:%02x:%02x:%02x\n",
-		       bssid[0], bssid[1], bssid[2],
-		       bssid[3], bssid[4], bssid[5]);
-	out += sprintf(out, "Channel: %d\n", chan);
-
-	return out - buf;
-}
-static DEVICE_ATTR(bssinfo, S_IRUGO, show_bssinfo, NULL);
-
-
 
 
 #ifdef CONFIG_IPW_DEBUG
@@ -4013,49 +3387,6 @@
 }
 static DEVICE_ATTR(fatal_error, S_IWUSR|S_IRUGO, show_fatal_error, store_fatal_error);
 
-
-static ssize_t show_scan_age(struct device *d, char *buf)
-{
-	struct ipw2100_priv *priv = dev_get_drvdata(d);
-	return sprintf(buf, "%d\n", priv->ieee->scan_age);
-}
-
-static ssize_t store_scan_age(struct device *d, const char *buf, size_t count)
-{
-	struct ipw2100_priv *priv = dev_get_drvdata(d);
-	struct net_device *dev = priv->net_dev;
-	char buffer[] = "00000000";
-	unsigned long len =
-	    (sizeof(buffer) - 1) > count ? count : sizeof(buffer) - 1;
-	unsigned long val;
-	char *p = buffer;
-
-	IPW_DEBUG_INFO("enter\n");
-
-	strncpy(buffer, buf, len);
-	buffer[len] = 0;
-
-	if (p[1] == 'x' || p[1] == 'X' || p[0] == 'x' || p[0] == 'X') {
-		p++;
-		if (p[0] == 'x' || p[0] == 'X')
-			p++;
-		val = simple_strtoul(p, &p, 16);
-	} else
-		val = simple_strtoul(p, &p, 10);
-	if (p == buffer) {
-		IPW_DEBUG_INFO("%s: user supplied invalid value.\n",
-		       dev->name);
-	} else {
-		priv->ieee->scan_age = val;
-		IPW_DEBUG_INFO("set scan_age = %u\n", priv->ieee->scan_age);
-	}
-
-	IPW_DEBUG_INFO("exit\n");
-	return len;
-}
-static DEVICE_ATTR(scan_age, S_IWUSR | S_IRUGO, show_scan_age, store_scan_age);
-
-
 static ssize_t show_rf_kill(struct device *d, char *buf)
 {
 	/* 0 - RF kill not enabled
@@ -4110,20 +3441,8 @@
 
 
 static struct attribute *ipw2100_sysfs_entries[] = {
-	&dev_attr_hardware.attr,
-	&dev_attr_registers.attr,
-	&dev_attr_ordinals.attr,
-	&dev_attr_pci.attr,
-	&dev_attr_stats.attr,
-	&dev_attr_internals.attr,
-	&dev_attr_bssinfo.attr,
-	&dev_attr_memory.attr,
-	&dev_attr_scan_age.attr,
 	&dev_attr_fatal_error.attr,
 	&dev_attr_rf_kill.attr,
-	&dev_attr_cfg.attr,
-	&dev_attr_status.attr,
-	&dev_attr_capability.attr,
 	NULL,
 };
 
@@ -4136,43 +3455,32 @@
 {
 	struct ipw2100_status_queue *q = &priv->status_queue;
 
-	IPW_DEBUG_INFO("enter\n");
-
 	q->size = entries * sizeof(struct ipw2100_status);
 	q->drv = (struct ipw2100_status *)pci_alloc_consistent(
 		priv->pci_dev, q->size, &q->nic);
 	if (!q->drv) {
-		IPW_DEBUG_WARNING(
+		printk(KERN_WARNING DRV_NAME ": "
 		       "Can not allocate status queue.\n");
 		return -ENOMEM;
 	}
 
 	memset(q->drv, 0, q->size);
-
-	IPW_DEBUG_INFO("exit\n");
-
 	return 0;
 }
 
 static void status_queue_free(struct ipw2100_priv *priv)
 {
-	IPW_DEBUG_INFO("enter\n");
-
 	if (priv->status_queue.drv) {
 		pci_free_consistent(
 			priv->pci_dev, priv->status_queue.size,
 			priv->status_queue.drv, priv->status_queue.nic);
 		priv->status_queue.drv = NULL;
 	}
-
-	IPW_DEBUG_INFO("exit\n");
 }
 
 static int bd_queue_allocate(struct ipw2100_priv *priv,
 			     struct ipw2100_bd_queue *q, int entries)
 {
-	IPW_DEBUG_INFO("enter\n");
-
 	memset(q, 0, sizeof(struct ipw2100_bd_queue));
 
 	q->entries = entries;
@@ -4183,17 +3491,12 @@
 		return -ENOMEM;
 	}
 	memset(q->drv, 0, q->size);
-
-	IPW_DEBUG_INFO("exit\n");
-
 	return 0;
 }
 
 static void bd_queue_free(struct ipw2100_priv *priv,
 			  struct ipw2100_bd_queue *q)
 {
-	IPW_DEBUG_INFO("enter\n");
-
 	if (!q)
 		return;
 
@@ -4202,24 +3505,18 @@
 				    q->size, q->drv, q->nic);
 		q->drv = NULL;
 	}
-
-	IPW_DEBUG_INFO("exit\n");
 }
 
 static void bd_queue_initialize(
 	struct ipw2100_priv *priv, struct ipw2100_bd_queue * q,
 	u32 base, u32 size, u32 r, u32 w)
 {
-	IPW_DEBUG_INFO("enter\n");
-
 	IPW_DEBUG_INFO("initializing bd queue at virt=%p, phys=%08x\n", q->drv, q->nic);
 
 	write_register(priv->net_dev, base, q->nic);
 	write_register(priv->net_dev, size, q->entries);
 	write_register(priv->net_dev, r, q->oldest);
 	write_register(priv->net_dev, w, q->next);
-
-	IPW_DEBUG_INFO("exit\n");
 }
 
 static void ipw2100_kill_workqueue(struct ipw2100_priv *priv)
@@ -4243,11 +3540,9 @@
 	void *v;
 	dma_addr_t p;
 
-	IPW_DEBUG_INFO("enter\n");
-
 	err = bd_queue_allocate(priv, &priv->tx_queue, TX_QUEUE_LENGTH);
 	if (err) {
-		IPW_DEBUG_ERROR("%s: failed bd_queue_allocate\n",
+		printk(KERN_ERR DRV_NAME ": %s: failed bd_queue_allocate\n",
 		       priv->net_dev->name);
 		return err;
 	}
@@ -4256,7 +3551,7 @@
 		TX_PENDED_QUEUE_LENGTH * sizeof(struct ipw2100_tx_packet),
 		GFP_ATOMIC);
 	if (!priv->tx_buffers) {
-		IPW_DEBUG_ERROR("%s: alloc failed form tx buffers.\n",
+		printk(KERN_ERR DRV_NAME ": %s: alloc failed form tx buffers.\n",
 		       priv->net_dev->name);
 		bd_queue_free(priv, &priv->tx_queue);
 		return -ENOMEM;
@@ -4266,7 +3561,7 @@
 		v = pci_alloc_consistent(
 			priv->pci_dev, sizeof(struct ipw2100_data_header), &p);
 		if (!v) {
-			IPW_DEBUG_ERROR("%s: PCI alloc failed for tx "
+			printk(KERN_ERR DRV_NAME ": %s: PCI alloc failed for tx "
 			       "buffers.\n", priv->net_dev->name);
 			err = -ENOMEM;
 			break;
@@ -4299,8 +3594,6 @@
 {
 	int i;
 
-	IPW_DEBUG_INFO("enter\n");
-
 	/*
 	 * reinitialize packet info lists
 	 */
@@ -4339,17 +3632,12 @@
 			    IPW_MEM_HOST_SHARED_TX_QUEUE_BD_SIZE,
 			    IPW_MEM_HOST_SHARED_TX_QUEUE_READ_INDEX,
 			    IPW_MEM_HOST_SHARED_TX_QUEUE_WRITE_INDEX);
-
-	IPW_DEBUG_INFO("exit\n");
-
 }
 
 static void ipw2100_tx_free(struct ipw2100_priv *priv)
 {
 	int i;
 
-	IPW_DEBUG_INFO("enter\n");
-
 	bd_queue_free(priv, &priv->tx_queue);
 
 	if (!priv->tx_buffers)
@@ -4370,8 +3658,6 @@
 
 	kfree(priv->tx_buffers);
 	priv->tx_buffers = NULL;
-
-	IPW_DEBUG_INFO("exit\n");
 }
 
 
@@ -4380,8 +3666,6 @@
 {
 	int i, j, err = -EINVAL;
 
-	IPW_DEBUG_INFO("enter\n");
-
 	err = bd_queue_allocate(priv, &priv->rx_queue, RX_QUEUE_LENGTH);
 	if (err) {
 		IPW_DEBUG_INFO("failed bd_queue_allocate\n");
@@ -4403,11 +3687,8 @@
 		    GFP_KERNEL);
 	if (!priv->rx_buffers) {
 		IPW_DEBUG_INFO("can't allocate rx packet buffer table\n");
-
 		bd_queue_free(priv, &priv->rx_queue);
-
 		status_queue_free(priv);
-
 		return -ENOMEM;
 	}
 
@@ -4448,8 +3729,6 @@
 
 static void ipw2100_rx_initialize(struct ipw2100_priv *priv)
 {
-	IPW_DEBUG_INFO("enter\n");
-
 	priv->rx_queue.oldest = 0;
 	priv->rx_queue.available = priv->rx_queue.entries - 1;
 	priv->rx_queue.next = priv->rx_queue.entries - 1;
@@ -4466,16 +3745,12 @@
 	/* set up the status queue */
 	write_register(priv->net_dev, IPW_MEM_HOST_SHARED_RX_STATUS_BASE,
 		       priv->status_queue.nic);
-
-	IPW_DEBUG_INFO("exit\n");
 }
 
 static void ipw2100_rx_free(struct ipw2100_priv *priv)
 {
 	int i;
 
-	IPW_DEBUG_INFO("enter\n");
-
 	bd_queue_free(priv, &priv->rx_queue);
 	status_queue_free(priv);
 
@@ -4494,8 +3769,6 @@
 
 	kfree(priv->rx_buffers);
 	priv->rx_buffers = NULL;
-
-	IPW_DEBUG_INFO("exit\n");
 }
 
 static int ipw2100_read_mac_address(struct ipw2100_priv *priv)
@@ -4536,8 +3809,6 @@
 
 	IPW_DEBUG_HC("SET_MAC_ADDRESS\n");
 
-	IPW_DEBUG_INFO("enter\n");
-
 	if (priv->config & CFG_CUSTOM_MAC) {
 		memcpy(cmd.host_command_parameters, priv->mac_addr,
 		       ETH_ALEN);
@@ -4547,8 +3818,6 @@
 		       ETH_ALEN);
 
 	err = ipw2100_hw_send_command(priv, &cmd);
-
-	IPW_DEBUG_INFO("exit\n");
 	return err;
 }
 
@@ -4577,7 +3846,7 @@
 	if (!batch_mode) {
 		err = ipw2100_disable_adapter(priv);
 		if (err) {
-			IPW_DEBUG_ERROR("%s: Could not disable adapter %d\n",
+			printk(KERN_ERR DRV_NAME ": %s: Could not disable adapter %d\n",
 			       priv->net_dev->name, err);
 			return err;
 		}
@@ -4805,47 +4074,6 @@
 	return 0;
 }
 
-#if 0
-int ipw2100_set_fragmentation_threshold(struct ipw2100_priv *priv,
-					u32 threshold, int batch_mode)
-{
-	struct host_command cmd = {
-		.host_command = FRAG_THRESHOLD,
-		.host_command_sequence = 0,
-		.host_command_length = 4,
-		.host_command_parameters[0] = 0,
-	};
-	int err;
-
-	if (!batch_mode) {
-		err = ipw2100_disable_adapter(priv);
-		if (err)
-			return err;
-	}
-
-	if (threshold == 0)
-		threshold = DEFAULT_FRAG_THRESHOLD;
-	else {
-		threshold = max(threshold, MIN_FRAG_THRESHOLD);
-		threshold = min(threshold, MAX_FRAG_THRESHOLD);
-	}
-
-	cmd.host_command_parameters[0] = threshold;
-
-	IPW_DEBUG_HC("FRAG_THRESHOLD: %u\n", threshold);
-
-	err = ipw2100_hw_send_command(priv, &cmd);
-
-	if (!batch_mode)
-		ipw2100_enable_adapter(priv);
-
-	if (!err)
-		priv->frag_threshold = threshold;
-
-	return err;
-}
-#endif
-
 int ipw2100_set_short_retry(struct ipw2100_priv *priv, u32 retry)
 {
 	struct host_command cmd = {
@@ -4935,8 +4163,6 @@
 	int err;
 	int len;
 
-	IPW_DEBUG_HC("DISASSOCIATION_BSSID\n");
-
 	len = ETH_ALEN;
 	/* The Firmware currently ignores the BSSID and just disassociates from
 	 * the currently associated AP -- but in the off chance that a future
@@ -4950,37 +4176,6 @@
 }
 #endif
 
-/*
- * Pseudo code for setting up wpa_frame:
- */
-#if 0
-void x(struct ieee80211_assoc_frame *wpa_assoc)
-{
-	struct ipw2100_wpa_assoc_frame frame;
-	frame->fixed_ie_mask = IPW_WPA_CAPABILTIES |
-		IPW_WPA_LISTENINTERVAL |
-		IPW_WPA_AP_ADDRESS;
-	frame->capab_info = wpa_assoc->capab_info;
-	frame->lisen_interval = wpa_assoc->listent_interval;
-	memcpy(frame->current_ap, wpa_assoc->current_ap, ETH_ALEN);
-
-	/* UNKNOWN -- I'm not postivive about this part; don't have any WPA
-	 * setup here to test it with.
-	 *
-	 * Walk the IEs in the wpa_assoc and figure out the total size of all
-	 * that data.  Stick that into frame->var_ie_len.  Then memcpy() all of
-	 * the IEs from wpa_frame into frame.
-	 */
-	frame->var_ie_len = calculate_ie_len(wpa_assoc);
-	memcpy(frame->var_ie,  wpa_assoc->variable, frame->var_ie_len);
-
-	ipw2100_set_wpa_ie(priv, &frame, 0);
-}
-#endif
-
-
-
-
 static int ipw2100_set_wpa_ie(struct ipw2100_priv *,
 			      struct ipw2100_wpa_assoc_frame *, int)
 __attribute__ ((unused));
@@ -4996,8 +4191,6 @@
 	};
 	int err;
 
-	IPW_DEBUG_HC("SET_WPA_IE\n");
-
 	if (!batch_mode) {
 		err = ipw2100_disable_adapter(priv);
 		if (err)
@@ -5123,8 +4316,6 @@
 
 	cmd.host_command_parameters[0] = interval;
 
-	IPW_DEBUG_INFO("enter\n");
-
 	if (priv->ieee->iw_mode == IW_MODE_ADHOC) {
 		if (!batch_mode) {
 			err = ipw2100_disable_adapter(priv);
@@ -5140,9 +4331,6 @@
 				return err;
 		}
 	}
-
-	IPW_DEBUG_INFO("exit\n");
-
 	return 0;
 }
 
@@ -5196,7 +4384,7 @@
 	if (!batch_mode) {
 		err = ipw2100_disable_adapter(priv);
 		if (err) {
-			IPW_DEBUG_ERROR("%s: Could not disable adapter %d\n",
+			printk(KERN_ERR DRV_NAME ": %s: Could not disable adapter %d\n",
 			       priv->net_dev->name, err);
 			return err;
 		}
@@ -5284,7 +4472,7 @@
 		err = ipw2100_disable_adapter(priv);
 		/* FIXME: IPG: shouldn't this prink be in _disable_adapter()? */
 		if (err) {
-			IPW_DEBUG_ERROR("%s: Could not disable adapter %d\n",
+			printk(KERN_ERR DRV_NAME ": %s: Could not disable adapter %d\n",
 			       priv->net_dev->name, err);
 			return err;
 		}
@@ -5320,7 +4508,7 @@
 	if (!batch_mode) {
 		err = ipw2100_disable_adapter(priv);
 		if (err) {
-			IPW_DEBUG_ERROR("%s: Could not disable adapter %d\n",
+			printk(KERN_ERR DRV_NAME ": %s: Could not disable adapter %d\n",
 			       priv->net_dev->name, err);
 			return err;
 		}
@@ -5502,8 +4690,6 @@
 	int batch_mode = 1;
 	u8 *bssid;
 
-	IPW_DEBUG_INFO("enter\n");
-
 	err = ipw2100_disable_adapter(priv);
 	if (err)
 		return err;
@@ -5512,9 +4698,6 @@
 		err = ipw2100_set_channel(priv, priv->channel, batch_mode);
 		if (err)
 			return err;
-
-		IPW_DEBUG_INFO("exit\n");
-
 		return 0;
 	}
 #endif /* CONFIG_IPW2100_MONITOR */
@@ -5591,9 +4774,6 @@
 	  if (err)
 	  return err;
 	*/
-
-	IPW_DEBUG_INFO("exit\n");
-
 	return 0;
 }
 
@@ -5656,8 +4836,6 @@
 	struct list_head *element;
 	struct ipw2100_tx_packet *packet;
 
-	IPW_DEBUG_INFO("enter\n");
-
 	spin_lock_irqsave(&priv->low_lock, flags);
 
 	if (priv->status & STATUS_ASSOCIATED)
@@ -5679,9 +4857,6 @@
 		INC_STAT(&priv->tx_free_stat);
 	}
 	spin_unlock_irqrestore(&priv->low_lock, flags);
-
-	IPW_DEBUG_INFO("exit\n");
-
 	return 0;
 }
 
@@ -5868,7 +5043,7 @@
 			break;
 
 		default:
-			IPW_DEBUG_ERROR("%s: Unknown WPA param: %d\n",
+			printk(KERN_ERR DRV_NAME ": %s: Unknown WPA param: %d\n",
 					    dev->name, name);
 			ret = -EOPNOTSUPP;
 	}
@@ -5891,7 +5066,7 @@
 			break;
 
 		default:
-			IPW_DEBUG_ERROR("%s: Unknown MLME request: %d\n",
+			printk(KERN_ERR DRV_NAME ": %s: Unknown MLME request: %d\n",
 					    dev->name, command);
 			ret = -EOPNOTSUPP;
 	}
@@ -6141,7 +5316,7 @@
 		break;
 
 	default:
-		IPW_DEBUG_ERROR("%s: Unknown WPA supplicant request: %d\n",
+		printk(KERN_ERR DRV_NAME ": %s: Unknown WPA supplicant request: %d\n",
 				dev->name, param->cmd);
 		ret = -EOPNOTSUPP;
 
@@ -6440,8 +5615,6 @@
 	int registered = 0;
 	u32 val;
 
-	IPW_DEBUG_INFO("enter\n");
-
 	mem_start = pci_resource_start(pci_dev, 0);
 	mem_len = pci_resource_len(pci_dev, 0);
 	mem_flags = pci_resource_flags(pci_dev, 0);
@@ -6589,8 +5762,6 @@
 		ipw2100_start_scan(priv);
 	}
 
-	IPW_DEBUG_INFO("exit\n");
-
 	priv->status |= STATUS_INITIALIZED;
 
 	up(&priv->action_sem);
@@ -6644,10 +5815,9 @@
 		dev = priv->net_dev;
 		sysfs_remove_group(&pci_dev->dev.kobj, &ipw2100_attribute_group);
 
-#ifdef CONFIG_PM
 		if (ipw2100_firmware.version)
 			ipw2100_release_firmware(priv, &ipw2100_firmware);
-#endif
+
 		/* Take down the hardware */
 		ipw2100_down(priv);
 
@@ -6680,17 +5850,11 @@
 
 	pci_release_regions(pci_dev);
 	pci_disable_device(pci_dev);
-
-	IPW_DEBUG_INFO("exit\n");
 }
 
 
 #ifdef CONFIG_PM
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,11)
-static int ipw2100_suspend(struct pci_dev *pci_dev, u32 state)
-#else
 static int ipw2100_suspend(struct pci_dev *pci_dev, pm_message_t state)
-#endif
 {
 	struct ipw2100_priv *priv = pci_get_drvdata(pci_dev);
 	struct net_device *dev = priv->net_dev;
@@ -6707,17 +5871,9 @@
 	/* Remove the PRESENT state of the device */
 	netif_device_detach(dev);
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,10)
-	pci_save_state(pci_dev, priv->pm_state);
-#else
 	pci_save_state(pci_dev);
-#endif
 	pci_disable_device (pci_dev);
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,11)
-	pci_set_power_state(pci_dev, state);
-#else
 	pci_set_power_state(pci_dev, PCI_D3hot);
-#endif
 
 	up(&priv->action_sem);
 
@@ -6738,17 +5894,9 @@
 	IPW_DEBUG_INFO("%s: Coming out of suspend...\n",
 	       dev->name);
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,11)
-	pci_set_power_state(pci_dev, 0);
-#else
 	pci_set_power_state(pci_dev, PCI_D0);
-#endif
 	pci_enable_device(pci_dev);
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,10)
-	pci_restore_state(pci_dev, priv->pm_state);
-#else
 	pci_restore_state(pci_dev);
-#endif
 
 	/*
 	 * Suspend/Resume resets the PCI configuration space, so we have to
@@ -8295,8 +7443,6 @@
 
 	down(&priv->action_sem);
 
-	IPW_DEBUG_WX("enter\n");
-
 	up(&priv->action_sem);
 
 	wrqu.ap_addr.sa_family = ARPHRD_ETHER;
@@ -8383,7 +7529,7 @@
 		(struct ipw2100_fw_header *)fw->fw_entry->data;
 
 	if (IPW2100_FW_MAJOR(h->version) != IPW2100_FW_MAJOR_VERSION) {
-		IPW_DEBUG_WARNING("Firmware image not compatible "
+		printk(KERN_WARNING DRV_NAME ": Firmware image not compatible "
 		       "(detected version id of %u). "
 		       "See Documentation/networking/README.ipw2100\n",
 		       h->version);
@@ -8426,7 +7572,7 @@
 	rc = request_firmware(&fw->fw_entry, fw_name, &priv->pci_dev->dev);
 
 	if (rc < 0) {
-		IPW_DEBUG_ERROR(
+		printk(KERN_ERR DRV_NAME ": "
 		       "%s: Firmware '%s' not available or load failed.\n",
 		       priv->net_dev->name, fw_name);
 		return rc;
@@ -8508,7 +7654,7 @@
 		firmware_data_left -= 2;
 
 		if (len > 32) {
-			IPW_DEBUG_ERROR(
+			printk(KERN_ERR DRV_NAME ": "
 			       "Invalid firmware run-length of %d bytes\n",
 			       len);
 			return -EINVAL;
@@ -8618,7 +7764,7 @@
 	}
 
 	if (i == 10) {
-		IPW_DEBUG_ERROR("%s: Error initializing Symbol\n",
+		printk(KERN_ERR DRV_NAME ": %s: Error initializing Symbol\n",
 		       dev->name);
 		return -EIO;
 	}
@@ -8639,7 +7785,7 @@
 	}
 
 	if (i == 30) {
-		IPW_DEBUG_ERROR("%s: No response from Symbol - hw not alive\n",
+		printk(KERN_ERR DRV_NAME ": %s: No response from Symbol - hw not alive\n",
 		       dev->name);
 		printk_buf(IPW_DL_ERROR, (u8*)&response, sizeof(response));
 		return -EIO;
--- clean-mm/drivers/net/wireless/ipw2100.h	2005-05-11 22:00:02.000000000 +0200
+++ linux-mm/drivers/net/wireless/ipw2100.h	2005-05-13 23:16:46.000000000 +0200
@@ -44,30 +44,6 @@
 
 #include <linux/workqueue.h>
 
-#ifndef IRQ_NONE
-typedef void irqreturn_t;
-#define IRQ_NONE
-#define IRQ_HANDLED
-#define IRQ_RETVAL(x)
-#endif
-
-#if WIRELESS_EXT < 17
-#define IW_QUAL_QUAL_INVALID  0x10
-#define IW_QUAL_LEVEL_INVALID 0x20
-#define IW_QUAL_NOISE_INVALID 0x40
-#endif
-
-#if ( LINUX_VERSION_CODE < KERNEL_VERSION(2,6,5) )
-#define pci_dma_sync_single_for_cpu	pci_dma_sync_single
-#define pci_dma_sync_single_for_device	pci_dma_sync_single
-#endif
-
-#ifndef HAVE_FREE_NETDEV
-#define free_netdev(x) kfree(x)
-#endif
-
-
-
 struct ipw2100_priv;
 struct ipw2100_tx_packet;
 struct ipw2100_rx_packet;
@@ -145,8 +121,6 @@
 #define IPW_DL_IO            (1<<26)
 #define IPW_DL_TRACE         (1<<28)
 
-#define IPW_DEBUG_ERROR(f, a...) printk(KERN_ERR DRV_NAME ": " f, ## a)
-#define IPW_DEBUG_WARNING(f, a...) printk(KERN_WARNING DRV_NAME ": " f, ## a)
 #define IPW_DEBUG_INFO(f...)    IPW_DEBUG(IPW_DL_INFO, ## f)
 #define IPW_DEBUG_WX(f...)     IPW_DEBUG(IPW_DL_WX, ## f)
 #define IPW_DEBUG_SCAN(f...)   IPW_DEBUG(IPW_DL_SCAN, ## f)
@@ -167,15 +141,6 @@
 #define IPW_DEBUG_STATE(f, a...) IPW_DEBUG(IPW_DL_STATE | IPW_DL_ASSOC | IPW_DL_INFO, f, ## a)
 #define IPW_DEBUG_ASSOC(f, a...) IPW_DEBUG(IPW_DL_ASSOC | IPW_DL_INFO, f, ## a)
 
-
-#define VERIFY(f) \
-{ \
-  int status = 0; \
-  status = f; \
-  if(status) \
-     return status; \
-}
-
 enum {
 	IPW_HW_STATE_DISABLED = 1,
 	IPW_HW_STATE_ENABLED = 0
@@ -210,8 +175,6 @@
 	} info;
 } __attribute__ ((packed));
 
-#define	IPW_BUFDESC_LAST_FRAG 0
-
 struct ipw2100_bd {
 	u32 host_addr;
 	u32 buf_length;
@@ -355,7 +318,7 @@
 	u16 fragment_size;
 } __attribute__ ((packed));
 
-// Host command data structure
+/* Host command data structure */
 struct host_command {
 	u32 host_command;		// COMMAND ID
 	u32 host_command1;		// COMMAND ID
@@ -473,13 +436,8 @@
 
 /* Power management code: enable or disable? */
 enum {
-#ifdef CONFIG_PM
 	IPW2100_PM_DISABLED = 0,
 	PM_STATE_SIZE = 16,
-#else
-	IPW2100_PM_DISABLED = 1,
-	PM_STATE_SIZE = 0,
-#endif
 };
 
 #define STATUS_POWERED          (1<<0)
@@ -648,9 +606,6 @@
 	struct semaphore adapter_sem;
 
 	wait_queue_head_t wait_command_queue;
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,10)
-	u32 pm_state[PM_STATE_SIZE];
-#endif
 };
 
 
@@ -701,7 +656,7 @@
 #define MSDU_TX_RATES          62
 
 
-// Rogue AP Detection
+/* Rogue AP Detection */
 #define SET_STATION_STAT_BITS      64
 #define CLEAR_STATIONS_STAT_BITS   65
 #define LEAP_ROGUE_MODE            66	//TODO tbw replaced by CFG_LEAP_ROGUE_AP
@@ -711,25 +666,16 @@
 
 
 
-// system configuration bit mask:
-//#define IPW_CFG_ANTENNA_SETTING           0x03
-//#define IPW_CFG_ANTENNA_A                 0x01
-//#define IPW_CFG_ANTENNA_B                 0x02
+/* system configuration bit mask: */
 #define IPW_CFG_MONITOR               0x00004
-//#define IPW_CFG_TX_STATUS_ENABLE    0x00008
 #define IPW_CFG_PREAMBLE_AUTO        0x00010
 #define IPW_CFG_IBSS_AUTO_START     0x00020
-//#define IPW_CFG_KERBEROS_ENABLE     0x00040
 #define IPW_CFG_LOOPBACK            0x00100
-//#define IPW_CFG_WNMP_PING_PASS      0x00200
-//#define IPW_CFG_DEBUG_ENABLE        0x00400
 #define IPW_CFG_ANSWER_BCSSID_PROBE 0x00800
-//#define IPW_CFG_BT_PRIORITY         0x01000
 #define IPW_CFG_BT_SIDEBAND_SIGNAL	0x02000
 #define IPW_CFG_802_1x_ENABLE       0x04000
 #define IPW_CFG_BSS_MASK		0x08000
 #define IPW_CFG_IBSS_MASK		0x10000
-//#define IPW_CFG_DYNAMIC_CW          0x10000
 
 #define IPW_SCAN_NOASSOCIATE (1<<0)
 #define IPW_SCAN_MIXED_CELL (1<<1)
@@ -761,41 +707,6 @@
 #define IPW_MEM_HOST_SHARED_TX_QUEUE_WRITE_INDEX \
     (IPW_MEM_SRAM_HOST_INTERRUPT_AREA_LOWER_BOUND)
 
-
-#if 0
-#define IPW_MEM_HOST_SHARED_TX_QUEUE_0_BD_BASE          (IPW_MEM_SRAM_HOST_SHARED_LOWER_BOUND + 0x00)
-#define IPW_MEM_HOST_SHARED_TX_QUEUE_0_BD_SIZE          (IPW_MEM_SRAM_HOST_SHARED_LOWER_BOUND + 0x04)
-#define IPW_MEM_HOST_SHARED_TX_QUEUE_1_BD_BASE          (IPW_MEM_SRAM_HOST_SHARED_LOWER_BOUND + 0x08)
-#define IPW_MEM_HOST_SHARED_TX_QUEUE_1_BD_SIZE          (IPW_MEM_SRAM_HOST_SHARED_LOWER_BOUND + 0x0c)
-#define IPW_MEM_HOST_SHARED_TX_QUEUE_2_BD_BASE          (IPW_MEM_SRAM_HOST_SHARED_LOWER_BOUND + 0x10)
-#define IPW_MEM_HOST_SHARED_TX_QUEUE_2_BD_SIZE          (IPW_MEM_SRAM_HOST_SHARED_LOWER_BOUND + 0x14)
-#define IPW_MEM_HOST_SHARED_TX_QUEUE_3_BD_BASE          (IPW_MEM_SRAM_HOST_SHARED_LOWER_BOUND + 0x18)
-#define IPW_MEM_HOST_SHARED_TX_QUEUE_3_BD_SIZE          (IPW_MEM_SRAM_HOST_SHARED_LOWER_BOUND + 0x1c)
-#define IPW_MEM_HOST_SHARED_TX_QUEUE_0_READ_INDEX       (IPW_MEM_SRAM_HOST_SHARED_LOWER_BOUND + 0x80)
-#define IPW_MEM_HOST_SHARED_TX_QUEUE_1_READ_INDEX       (IPW_MEM_SRAM_HOST_SHARED_LOWER_BOUND + 0x84)
-#define IPW_MEM_HOST_SHARED_TX_QUEUE_2_READ_INDEX       (IPW_MEM_SRAM_HOST_SHARED_LOWER_BOUND + 0x88)
-#define IPW_MEM_HOST_SHARED_TX_QUEUE_3_READ_INDEX       (IPW_MEM_SRAM_HOST_SHARED_LOWER_BOUND + 0x8c)
-
-#define IPW_MEM_HOST_SHARED_TX_QUEUE_BD_BASE(QueueNum) \
-    (IPW_MEM_SRAM_HOST_SHARED_LOWER_BOUND + (QueueNum<<3))
-#define IPW_MEM_HOST_SHARED_TX_QUEUE_BD_SIZE(QueueNum) \
-    (IPW_MEM_SRAM_HOST_SHARED_LOWER_BOUND + 0x0004+(QueueNum<<3))
-#define IPW_MEM_HOST_SHARED_TX_QUEUE_READ_INDEX(QueueNum) \
-    (IPW_MEM_SRAM_HOST_SHARED_LOWER_BOUND + 0x0080+(QueueNum<<2))
-
-#define IPW_MEM_HOST_SHARED_TX_QUEUE_0_WRITE_INDEX \
-    (IPW_MEM_SRAM_HOST_INTERRUPT_AREA_LOWER_BOUND + 0x00)
-#define IPW_MEM_HOST_SHARED_TX_QUEUE_1_WRITE_INDEX \
-    (IPW_MEM_SRAM_HOST_INTERRUPT_AREA_LOWER_BOUND + 0x04)
-#define IPW_MEM_HOST_SHARED_TX_QUEUE_2_WRITE_INDEX \
-    (IPW_MEM_SRAM_HOST_INTERRUPT_AREA_LOWER_BOUND + 0x08)
-#define IPW_MEM_HOST_SHARED_TX_QUEUE_3_WRITE_INDEX \
-    (IPW_MEM_SRAM_HOST_INTERRUPT_AREA_LOWER_BOUND + 0x0c)
-#define IPW_MEM_HOST_SHARED_SLAVE_MODE_INT_REGISTER \
-    (IPW_MEM_SRAM_HOST_INTERRUPT_AREA_LOWER_BOUND + 0x78)
-
-#endif
-
 #define IPW_MEM_HOST_SHARED_ORDINALS_TABLE_1   (IPW_MEM_SRAM_HOST_SHARED_LOWER_BOUND + 0x180)
 #define IPW_MEM_HOST_SHARED_ORDINALS_TABLE_2   (IPW_MEM_SRAM_HOST_SHARED_LOWER_BOUND + 0x184)
 
@@ -913,7 +824,7 @@
 	} rx_data;
 } __attribute__ ((packed));
 
-// Bit 0-7 are for 802.11b tx rates - .  Bit 5-7 are reserved
+/* Bit 0-7 are for 802.11b tx rates - .  Bit 5-7 are reserved */
 #define TX_RATE_1_MBIT              0x0001
 #define TX_RATE_2_MBIT              0x0002
 #define TX_RATE_5_5_MBIT            0x0004
@@ -1193,7 +1104,6 @@
 	IPW_ORD_UCODE_VERSION,	// Ucode Version
 	IPW_ORD_HW_RF_SWITCH_STATE = 214,	// HW RF Kill Switch State
 } ORDINALTABLE1;
-//ENDOF TABLE1
 
 // ordinal table 2
 // Variable length data:

-- 
Boycott Kodak -- for their patent abuse against Java.
