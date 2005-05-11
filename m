Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbVEKW3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbVEKW3i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 18:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbVEKW3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 18:29:35 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:24730 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261278AbVEKW17 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 18:27:59 -0400
Date: Thu, 12 May 2005 00:05:22 +0200
From: Pavel Machek <pavel@ucw.cz>
To: jketreno@linux.intel.com, netdev@oss.sgi.com,
       kernel list <linux-kernel@vger.kernel.org>
Subject: ipw2100: invasive cleanups
Message-ID: <20050511220522.GA4357@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Here are some more invasive cleanups for ipw2100... I do not know what
X__ prefixes were meant for. I removed them. Along with some debugging
infrastructure and tests for obsolete kernels.

Maybe this makes it more acceptable at least for -mm tree?

Oh BTW DRV_COPYRIGHT probably needs an update, its 2005 now :-).
									Pavel

--- /data/l/clean-mm/drivers/net/wireless/ipw2100.c	2005-05-11 22:00:02.000000000 +0200
+++ linux-mm/drivers/net/wireless/ipw2100.c	2005-05-11 23:58:20.000000000 +0200
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
@@ -174,11 +173,6 @@
 #define DRV_COPYRIGHT	"Copyright(c) 2003-2004 Intel Corporation"
 
 
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
@@ -735,8 +727,8 @@
 	list_add_tail(element, &priv->msg_pend_list);
 	INC_STAT(&priv->msg_pend_stat);
 
-	X__ipw2100_tx_send_commands(priv);
-	X__ipw2100_tx_send_data(priv);
+	ipw2100_tx_send_commands(priv);
+	ipw2100_tx_send_data(priv);
 
 	spin_unlock_irqrestore(&priv->low_lock, flags);
 
@@ -915,12 +907,10 @@
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
@@ -940,11 +930,8 @@
 {
 	u32 address;
 	int err;
-
-#ifndef CONFIG_PM
 	/* Fetch the firmware and microcode */
 	struct ipw2100_fw ipw2100_firmware;
-#endif
 
 	if (priv->fatal_error) {
 		IPW_DEBUG_ERROR("%s: ipw2100_download_firmware called after "
@@ -953,7 +940,6 @@
 		return -EINVAL;
 	}
 
-#ifdef CONFIG_PM
 	if (!ipw2100_firmware.version) {
 		err = ipw2100_get_firmware(priv, &ipw2100_firmware);
 		if (err) {
@@ -963,15 +949,6 @@
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
@@ -1026,7 +1003,6 @@
 		goto fail;
 	}
 
-#ifndef CONFIG_PM
 	/*
 	 * When the .resume method of the driver is called, the other
 	 * part of the system, i.e. the ide driver could still stay in
@@ -1036,7 +1012,6 @@
 
 	/* free any storage allocated for firmware image */
 	ipw2100_release_firmware(priv, &ipw2100_firmware);
-#endif
 
 	/* zero out Domain 1 area indirectly (Si requirement) */
 	for (address = IPW_HOST_FW_SHARED_AREA0;
@@ -1083,8 +1058,6 @@
 {
 	struct ipw2100_ordinals *ord = &priv->ordinals;
 
-	IPW_DEBUG_INFO("enter\n");
-
 	read_register(priv->net_dev, IPW_MEM_HOST_SHARED_ORDINALS_TABLE_1,
 		      &ord->table1_addr);
 
@@ -1095,10 +1068,6 @@
 	read_nic_dword(priv->net_dev, ord->table2_addr, &ord->table2_size);
 
 	ord->table2_size &= 0x0000FFFF;
-
-	IPW_DEBUG_INFO("table 1 size: %d\n", ord->table1_size);
-	IPW_DEBUG_INFO("table 2 size: %d\n", ord->table2_size);
-	IPW_DEBUG_INFO("exit\n");
 }
 
 static inline void ipw2100_hw_set_gpio(struct ipw2100_priv *priv)
@@ -1117,7 +1086,6 @@
 {
 #define MAX_RF_KILL_CHECKS 5
 #define RF_KILL_CHECK_DELAY 40
-#define RF_KILL_CHECK_THRESHOLD 3
 
 	unsigned short value = 0;
 	u32 reg = 0;
@@ -1198,8 +1166,6 @@
 	int i;
 	u32 inta, inta_mask, gpio;
 
-	IPW_DEBUG_INFO("enter\n");
-
 	if (priv->status & STATUS_RUNNING)
 		return 0;
 
@@ -1286,9 +1252,6 @@
 
 	/* The adapter has been reset; we are not associated */
 	priv->status &= ~(STATUS_ASSOCIATING | STATUS_ASSOCIATED);
-
-	IPW_DEBUG_INFO("exit\n");
-
 	return 0;
 }
 
@@ -1598,8 +1561,6 @@
 	};
 	int err;
 
-	IPW_DEBUG_INFO("enter\n");
-
 	IPW_DEBUG_SCAN("setting scan options\n");
 
 	cmd.host_command_parameters[0] = 0;
@@ -1643,8 +1604,6 @@
 		return 0;
 	}
 
-	IPW_DEBUG_INFO("enter\n");
-
 	/* Not clearing here; doing so makes iwlist always return nothing...
 	 *
 	 * We should modify the table logic to use aging tables vs. clearing
@@ -1657,8 +1616,6 @@
 	if (err)
 		priv->status &= ~STATUS_SCANNING;
 
-	IPW_DEBUG_INFO("exit\n");
-
 	return err;
 }
 
@@ -2285,18 +2242,10 @@
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
@@ -2314,35 +2263,6 @@
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
@@ -2394,19 +2314,7 @@
 
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
@@ -2847,7 +2755,7 @@
 }
 
 
-static void X__ipw2100_tx_send_commands(struct ipw2100_priv *priv)
+static void ipw2100_tx_send_commands(struct ipw2100_priv *priv)
 {
 	struct list_head *element;
 	struct ipw2100_tx_packet *packet;
@@ -2915,10 +2823,10 @@
 
 
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
@@ -3133,8 +3041,8 @@
 			       IPW2100_INTA_TX_TRANSFER);
 
 		__ipw2100_tx_complete(priv);
-		X__ipw2100_tx_send_commands(priv);
-		X__ipw2100_tx_send_data(priv);
+		ipw2100_tx_send_commands(priv);
+		ipw2100_tx_send_data(priv);
 	}
 
 	if (inta & IPW2100_INTA_TX_COMPLETE) {
@@ -3192,8 +3100,6 @@
 	ipw2100_enable_interrupts(priv);
 
 	spin_unlock_irqrestore(&priv->low_lock, flags);
-
-	IPW_DEBUG_ISR("exit\n");
 }
 
 
@@ -3285,7 +3191,7 @@
 	list_add_tail(element, &priv->tx_pend_list);
 	INC_STAT(&priv->tx_pend_stat);
 
-	X__ipw2100_tx_send_data(priv);
+	ipw2100_tx_send_data(priv);
 
 	spin_unlock_irqrestore(&priv->low_lock, flags);
 	return 0;
@@ -3662,96 +3568,6 @@
 }
 static DEVICE_ATTR(hardware, S_IRUGO, show_hardware, NULL);
 
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
 static ssize_t show_ordinals(struct device *d, char *buf)
 {
 	struct ipw2100_priv *priv = dev_get_drvdata(d);
@@ -3837,11 +3653,9 @@
 
 	priv->ieee->iw_mode = mode;
 
-#ifdef CONFIG_PM
         /* Indicate ipw2100_download_firmware download firmware
 	 * from disk instead of memory. */
 	ipw2100_firmware.version = 0;
-#endif
 
 	printk(KERN_INFO "%s: Reseting on mode change.\n",
 		priv->net_dev->name);
@@ -4030,8 +3844,6 @@
 	unsigned long val;
 	char *p = buffer;
 
-	IPW_DEBUG_INFO("enter\n");
-
 	strncpy(buffer, buf, len);
 	buffer[len] = 0;
 
@@ -4049,8 +3861,6 @@
 		priv->ieee->scan_age = val;
 		IPW_DEBUG_INFO("set scan_age = %u\n", priv->ieee->scan_age);
 	}
-
-	IPW_DEBUG_INFO("exit\n");
 	return len;
 }
 static DEVICE_ATTR(scan_age, S_IWUSR | S_IRUGO, show_scan_age, store_scan_age);
@@ -4117,7 +3927,6 @@
 	&dev_attr_stats.attr,
 	&dev_attr_internals.attr,
 	&dev_attr_bssinfo.attr,
-	&dev_attr_memory.attr,
 	&dev_attr_scan_age.attr,
 	&dev_attr_fatal_error.attr,
 	&dev_attr_rf_kill.attr,
@@ -4136,8 +3945,6 @@
 {
 	struct ipw2100_status_queue *q = &priv->status_queue;
 
-	IPW_DEBUG_INFO("enter\n");
-
 	q->size = entries * sizeof(struct ipw2100_status);
 	q->drv = (struct ipw2100_status *)pci_alloc_consistent(
 		priv->pci_dev, q->size, &q->nic);
@@ -4148,31 +3955,22 @@
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
@@ -4183,17 +3981,12 @@
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
 
@@ -4202,24 +3995,18 @@
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
@@ -4243,8 +4030,6 @@
 	void *v;
 	dma_addr_t p;
 
-	IPW_DEBUG_INFO("enter\n");
-
 	err = bd_queue_allocate(priv, &priv->tx_queue, TX_QUEUE_LENGTH);
 	if (err) {
 		IPW_DEBUG_ERROR("%s: failed bd_queue_allocate\n",
@@ -4299,8 +4084,6 @@
 {
 	int i;
 
-	IPW_DEBUG_INFO("enter\n");
-
 	/*
 	 * reinitialize packet info lists
 	 */
@@ -4339,17 +4122,12 @@
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
@@ -4370,8 +4148,6 @@
 
 	kfree(priv->tx_buffers);
 	priv->tx_buffers = NULL;
-
-	IPW_DEBUG_INFO("exit\n");
 }
 
 
@@ -4380,8 +4156,6 @@
 {
 	int i, j, err = -EINVAL;
 
-	IPW_DEBUG_INFO("enter\n");
-
 	err = bd_queue_allocate(priv, &priv->rx_queue, RX_QUEUE_LENGTH);
 	if (err) {
 		IPW_DEBUG_INFO("failed bd_queue_allocate\n");
@@ -4448,8 +4222,6 @@
 
 static void ipw2100_rx_initialize(struct ipw2100_priv *priv)
 {
-	IPW_DEBUG_INFO("enter\n");
-
 	priv->rx_queue.oldest = 0;
 	priv->rx_queue.available = priv->rx_queue.entries - 1;
 	priv->rx_queue.next = priv->rx_queue.entries - 1;
@@ -4466,16 +4238,12 @@
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
 
@@ -4494,8 +4262,6 @@
 
 	kfree(priv->rx_buffers);
 	priv->rx_buffers = NULL;
-
-	IPW_DEBUG_INFO("exit\n");
 }
 
 static int ipw2100_read_mac_address(struct ipw2100_priv *priv)
@@ -4536,8 +4302,6 @@
 
 	IPW_DEBUG_HC("SET_MAC_ADDRESS\n");
 
-	IPW_DEBUG_INFO("enter\n");
-
 	if (priv->config & CFG_CUSTOM_MAC) {
 		memcpy(cmd.host_command_parameters, priv->mac_addr,
 		       ETH_ALEN);
@@ -4547,8 +4311,6 @@
 		       ETH_ALEN);
 
 	err = ipw2100_hw_send_command(priv, &cmd);
-
-	IPW_DEBUG_INFO("exit\n");
 	return err;
 }
 
@@ -4805,47 +4567,6 @@
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
@@ -4935,8 +4656,6 @@
 	int err;
 	int len;
 
-	IPW_DEBUG_HC("DISASSOCIATION_BSSID\n");
-
 	len = ETH_ALEN;
 	/* The Firmware currently ignores the BSSID and just disassociates from
 	 * the currently associated AP -- but in the off chance that a future
@@ -4950,37 +4669,6 @@
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
@@ -4996,8 +4684,6 @@
 	};
 	int err;
 
-	IPW_DEBUG_HC("SET_WPA_IE\n");
-
 	if (!batch_mode) {
 		err = ipw2100_disable_adapter(priv);
 		if (err)
@@ -5123,8 +4809,6 @@
 
 	cmd.host_command_parameters[0] = interval;
 
-	IPW_DEBUG_INFO("enter\n");
-
 	if (priv->ieee->iw_mode == IW_MODE_ADHOC) {
 		if (!batch_mode) {
 			err = ipw2100_disable_adapter(priv);
@@ -5140,9 +4824,6 @@
 				return err;
 		}
 	}
-
-	IPW_DEBUG_INFO("exit\n");
-
 	return 0;
 }
 
@@ -5502,8 +5183,6 @@
 	int batch_mode = 1;
 	u8 *bssid;
 
-	IPW_DEBUG_INFO("enter\n");
-
 	err = ipw2100_disable_adapter(priv);
 	if (err)
 		return err;
@@ -5512,9 +5191,6 @@
 		err = ipw2100_set_channel(priv, priv->channel, batch_mode);
 		if (err)
 			return err;
-
-		IPW_DEBUG_INFO("exit\n");
-
 		return 0;
 	}
 #endif /* CONFIG_IPW2100_MONITOR */
@@ -5591,9 +5267,6 @@
 	  if (err)
 	  return err;
 	*/
-
-	IPW_DEBUG_INFO("exit\n");
-
 	return 0;
 }
 
@@ -5656,8 +5329,6 @@
 	struct list_head *element;
 	struct ipw2100_tx_packet *packet;
 
-	IPW_DEBUG_INFO("enter\n");
-
 	spin_lock_irqsave(&priv->low_lock, flags);
 
 	if (priv->status & STATUS_ASSOCIATED)
@@ -5679,9 +5350,6 @@
 		INC_STAT(&priv->tx_free_stat);
 	}
 	spin_unlock_irqrestore(&priv->low_lock, flags);
-
-	IPW_DEBUG_INFO("exit\n");
-
 	return 0;
 }
 
@@ -6440,8 +6108,6 @@
 	int registered = 0;
 	u32 val;
 
-	IPW_DEBUG_INFO("enter\n");
-
 	mem_start = pci_resource_start(pci_dev, 0);
 	mem_len = pci_resource_len(pci_dev, 0);
 	mem_flags = pci_resource_flags(pci_dev, 0);
@@ -6589,8 +6255,6 @@
 		ipw2100_start_scan(priv);
 	}
 
-	IPW_DEBUG_INFO("exit\n");
-
 	priv->status |= STATUS_INITIALIZED;
 
 	up(&priv->action_sem);
@@ -6644,10 +6308,9 @@
 		dev = priv->net_dev;
 		sysfs_remove_group(&pci_dev->dev.kobj, &ipw2100_attribute_group);
 
-#ifdef CONFIG_PM
 		if (ipw2100_firmware.version)
 			ipw2100_release_firmware(priv, &ipw2100_firmware);
-#endif
+
 		/* Take down the hardware */
 		ipw2100_down(priv);
 
@@ -6680,17 +6343,11 @@
 
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
@@ -6707,17 +6364,9 @@
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
 
@@ -6738,17 +6387,9 @@
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
@@ -8295,8 +7936,6 @@
 
 	down(&priv->action_sem);
 
-	IPW_DEBUG_WX("enter\n");
-
 	up(&priv->action_sem);
 
 	wrqu.ap_addr.sa_family = ARPHRD_ETHER;


-- 
Boycott Kodak -- for their patent abuse against Java.
