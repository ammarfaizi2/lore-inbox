Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262172AbVELWwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262172AbVELWwq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 18:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbVELWwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 18:52:43 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:57255 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262168AbVELWvV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 18:51:21 -0400
Date: Fri, 13 May 2005 00:50:26 +0200
From: Pavel Machek <pavel@ucw.cz>
To: jketreno@linux.intel.com, netdev@oss.sgi.com,
       kernel list <linux-kernel@vger.kernel.org>
Cc: jbohac@suse.cz, jbenc@suse.cz
Subject: ipw2100: intrusive cleanups, working this time ;-)
Message-ID: <20050512225026.GA2822@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

There's a lot to clean up in header file, too... And this time it
actually works.

Now, I'd like to clean it a bit more and then submit it to akpm for
-mm series. Will someone hate me for doing that?
								Pavel

--- clean-mm/drivers/net/wireless/ipw2100.c	2005-05-11 22:00:02.000000000 +0200
+++ linux-mm/drivers/net/wireless/ipw2100.c	2005-05-13 00:42:27.000000000 +0200
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
@@ -941,11 +931,6 @@
 	u32 address;
 	int err;
 
-#ifndef CONFIG_PM
-	/* Fetch the firmware and microcode */
-	struct ipw2100_fw ipw2100_firmware;
-#endif
-
 	if (priv->fatal_error) {
 		IPW_DEBUG_ERROR("%s: ipw2100_download_firmware called after "
 		       "fatal error %d.  Interface must be brought down.\n",
@@ -953,7 +938,6 @@
 		return -EINVAL;
 	}
 
-#ifdef CONFIG_PM
 	if (!ipw2100_firmware.version) {
 		err = ipw2100_get_firmware(priv, &ipw2100_firmware);
 		if (err) {
@@ -963,15 +947,6 @@
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
@@ -1026,18 +1001,6 @@
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
@@ -1083,8 +1046,6 @@
 {
 	struct ipw2100_ordinals *ord = &priv->ordinals;
 
-	IPW_DEBUG_INFO("enter\n");
-
 	read_register(priv->net_dev, IPW_MEM_HOST_SHARED_ORDINALS_TABLE_1,
 		      &ord->table1_addr);
 
@@ -1095,10 +1056,6 @@
 	read_nic_dword(priv->net_dev, ord->table2_addr, &ord->table2_size);
 
 	ord->table2_size &= 0x0000FFFF;
-
-	IPW_DEBUG_INFO("table 1 size: %d\n", ord->table1_size);
-	IPW_DEBUG_INFO("table 2 size: %d\n", ord->table2_size);
-	IPW_DEBUG_INFO("exit\n");
 }
 
 static inline void ipw2100_hw_set_gpio(struct ipw2100_priv *priv)
@@ -1117,7 +1074,6 @@
 {
 #define MAX_RF_KILL_CHECKS 5
 #define RF_KILL_CHECK_DELAY 40
-#define RF_KILL_CHECK_THRESHOLD 3
 
 	unsigned short value = 0;
 	u32 reg = 0;
@@ -1198,8 +1154,6 @@
 	int i;
 	u32 inta, inta_mask, gpio;
 
-	IPW_DEBUG_INFO("enter\n");
-
 	if (priv->status & STATUS_RUNNING)
 		return 0;
 
@@ -1286,9 +1240,6 @@
 
 	/* The adapter has been reset; we are not associated */
 	priv->status &= ~(STATUS_ASSOCIATING | STATUS_ASSOCIATED);
-
-	IPW_DEBUG_INFO("exit\n");
-
 	return 0;
 }
 
@@ -1598,8 +1549,6 @@
 	};
 	int err;
 
-	IPW_DEBUG_INFO("enter\n");
-
 	IPW_DEBUG_SCAN("setting scan options\n");
 
 	cmd.host_command_parameters[0] = 0;
@@ -1643,8 +1592,6 @@
 		return 0;
 	}
 
-	IPW_DEBUG_INFO("enter\n");
-
 	/* Not clearing here; doing so makes iwlist always return nothing...
 	 *
 	 * We should modify the table logic to use aging tables vs. clearing
@@ -1657,8 +1604,6 @@
 	if (err)
 		priv->status &= ~STATUS_SCANNING;
 
-	IPW_DEBUG_INFO("exit\n");
-
 	return err;
 }
 
@@ -2285,18 +2230,10 @@
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
@@ -2314,35 +2251,6 @@
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
@@ -2394,19 +2302,7 @@
 
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
@@ -2847,7 +2743,7 @@
 }
 
 
-static void X__ipw2100_tx_send_commands(struct ipw2100_priv *priv)
+static void ipw2100_tx_send_commands(struct ipw2100_priv *priv)
 {
 	struct list_head *element;
 	struct ipw2100_tx_packet *packet;
@@ -2915,10 +2811,10 @@
 
 
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
@@ -3133,8 +3029,8 @@
 			       IPW2100_INTA_TX_TRANSFER);
 
 		__ipw2100_tx_complete(priv);
-		X__ipw2100_tx_send_commands(priv);
-		X__ipw2100_tx_send_data(priv);
+		ipw2100_tx_send_commands(priv);
+		ipw2100_tx_send_data(priv);
 	}
 
 	if (inta & IPW2100_INTA_TX_COMPLETE) {
@@ -3192,8 +3088,6 @@
 	ipw2100_enable_interrupts(priv);
 
 	spin_unlock_irqrestore(&priv->low_lock, flags);
-
-	IPW_DEBUG_ISR("exit\n");
 }
 
 
@@ -3285,7 +3179,7 @@
 	list_add_tail(element, &priv->tx_pend_list);
 	INC_STAT(&priv->tx_pend_stat);
 
-	X__ipw2100_tx_send_data(priv);
+	ipw2100_tx_send_data(priv);
 
 	spin_unlock_irqrestore(&priv->low_lock, flags);
 	return 0;
@@ -3662,96 +3556,6 @@
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
@@ -3837,11 +3641,9 @@
 
 	priv->ieee->iw_mode = mode;
 
-#ifdef CONFIG_PM
         /* Indicate ipw2100_download_firmware download firmware
 	 * from disk instead of memory. */
 	ipw2100_firmware.version = 0;
-#endif
 
 	printk(KERN_INFO "%s: Reseting on mode change.\n",
 		priv->net_dev->name);
@@ -4030,8 +3832,6 @@
 	unsigned long val;
 	char *p = buffer;
 
-	IPW_DEBUG_INFO("enter\n");
-
 	strncpy(buffer, buf, len);
 	buffer[len] = 0;
 
@@ -4049,8 +3849,6 @@
 		priv->ieee->scan_age = val;
 		IPW_DEBUG_INFO("set scan_age = %u\n", priv->ieee->scan_age);
 	}
-
-	IPW_DEBUG_INFO("exit\n");
 	return len;
 }
 static DEVICE_ATTR(scan_age, S_IWUSR | S_IRUGO, show_scan_age, store_scan_age);
@@ -4117,7 +3915,6 @@
 	&dev_attr_stats.attr,
 	&dev_attr_internals.attr,
 	&dev_attr_bssinfo.attr,
-	&dev_attr_memory.attr,
 	&dev_attr_scan_age.attr,
 	&dev_attr_fatal_error.attr,
 	&dev_attr_rf_kill.attr,
@@ -4136,8 +3933,6 @@
 {
 	struct ipw2100_status_queue *q = &priv->status_queue;
 
-	IPW_DEBUG_INFO("enter\n");
-
 	q->size = entries * sizeof(struct ipw2100_status);
 	q->drv = (struct ipw2100_status *)pci_alloc_consistent(
 		priv->pci_dev, q->size, &q->nic);
@@ -4148,31 +3943,22 @@
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
@@ -4183,17 +3969,12 @@
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
 
@@ -4202,24 +3983,18 @@
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
@@ -4243,8 +4018,6 @@
 	void *v;
 	dma_addr_t p;
 
-	IPW_DEBUG_INFO("enter\n");
-
 	err = bd_queue_allocate(priv, &priv->tx_queue, TX_QUEUE_LENGTH);
 	if (err) {
 		IPW_DEBUG_ERROR("%s: failed bd_queue_allocate\n",
@@ -4299,8 +4072,6 @@
 {
 	int i;
 
-	IPW_DEBUG_INFO("enter\n");
-
 	/*
 	 * reinitialize packet info lists
 	 */
@@ -4339,17 +4110,12 @@
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
@@ -4370,8 +4136,6 @@
 
 	kfree(priv->tx_buffers);
 	priv->tx_buffers = NULL;
-
-	IPW_DEBUG_INFO("exit\n");
 }
 
 
@@ -4380,8 +4144,6 @@
 {
 	int i, j, err = -EINVAL;
 
-	IPW_DEBUG_INFO("enter\n");
-
 	err = bd_queue_allocate(priv, &priv->rx_queue, RX_QUEUE_LENGTH);
 	if (err) {
 		IPW_DEBUG_INFO("failed bd_queue_allocate\n");
@@ -4448,8 +4210,6 @@
 
 static void ipw2100_rx_initialize(struct ipw2100_priv *priv)
 {
-	IPW_DEBUG_INFO("enter\n");
-
 	priv->rx_queue.oldest = 0;
 	priv->rx_queue.available = priv->rx_queue.entries - 1;
 	priv->rx_queue.next = priv->rx_queue.entries - 1;
@@ -4466,16 +4226,12 @@
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
 
@@ -4494,8 +4250,6 @@
 
 	kfree(priv->rx_buffers);
 	priv->rx_buffers = NULL;
-
-	IPW_DEBUG_INFO("exit\n");
 }
 
 static int ipw2100_read_mac_address(struct ipw2100_priv *priv)
@@ -4536,8 +4290,6 @@
 
 	IPW_DEBUG_HC("SET_MAC_ADDRESS\n");
 
-	IPW_DEBUG_INFO("enter\n");
-
 	if (priv->config & CFG_CUSTOM_MAC) {
 		memcpy(cmd.host_command_parameters, priv->mac_addr,
 		       ETH_ALEN);
@@ -4547,8 +4299,6 @@
 		       ETH_ALEN);
 
 	err = ipw2100_hw_send_command(priv, &cmd);
-
-	IPW_DEBUG_INFO("exit\n");
 	return err;
 }
 
@@ -4805,47 +4555,6 @@
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
@@ -4935,8 +4644,6 @@
 	int err;
 	int len;
 
-	IPW_DEBUG_HC("DISASSOCIATION_BSSID\n");
-
 	len = ETH_ALEN;
 	/* The Firmware currently ignores the BSSID and just disassociates from
 	 * the currently associated AP -- but in the off chance that a future
@@ -4950,37 +4657,6 @@
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
@@ -4996,8 +4672,6 @@
 	};
 	int err;
 
-	IPW_DEBUG_HC("SET_WPA_IE\n");
-
 	if (!batch_mode) {
 		err = ipw2100_disable_adapter(priv);
 		if (err)
@@ -5123,8 +4797,6 @@
 
 	cmd.host_command_parameters[0] = interval;
 
-	IPW_DEBUG_INFO("enter\n");
-
 	if (priv->ieee->iw_mode == IW_MODE_ADHOC) {
 		if (!batch_mode) {
 			err = ipw2100_disable_adapter(priv);
@@ -5140,9 +4812,6 @@
 				return err;
 		}
 	}
-
-	IPW_DEBUG_INFO("exit\n");
-
 	return 0;
 }
 
@@ -5502,8 +5171,6 @@
 	int batch_mode = 1;
 	u8 *bssid;
 
-	IPW_DEBUG_INFO("enter\n");
-
 	err = ipw2100_disable_adapter(priv);
 	if (err)
 		return err;
@@ -5512,9 +5179,6 @@
 		err = ipw2100_set_channel(priv, priv->channel, batch_mode);
 		if (err)
 			return err;
-
-		IPW_DEBUG_INFO("exit\n");
-
 		return 0;
 	}
 #endif /* CONFIG_IPW2100_MONITOR */
@@ -5591,9 +5255,6 @@
 	  if (err)
 	  return err;
 	*/
-
-	IPW_DEBUG_INFO("exit\n");
-
 	return 0;
 }
 
@@ -5656,8 +5317,6 @@
 	struct list_head *element;
 	struct ipw2100_tx_packet *packet;
 
-	IPW_DEBUG_INFO("enter\n");
-
 	spin_lock_irqsave(&priv->low_lock, flags);
 
 	if (priv->status & STATUS_ASSOCIATED)
@@ -5679,9 +5338,6 @@
 		INC_STAT(&priv->tx_free_stat);
 	}
 	spin_unlock_irqrestore(&priv->low_lock, flags);
-
-	IPW_DEBUG_INFO("exit\n");
-
 	return 0;
 }
 
@@ -6440,8 +6096,6 @@
 	int registered = 0;
 	u32 val;
 
-	IPW_DEBUG_INFO("enter\n");
-
 	mem_start = pci_resource_start(pci_dev, 0);
 	mem_len = pci_resource_len(pci_dev, 0);
 	mem_flags = pci_resource_flags(pci_dev, 0);
@@ -6589,8 +6243,6 @@
 		ipw2100_start_scan(priv);
 	}
 
-	IPW_DEBUG_INFO("exit\n");
-
 	priv->status |= STATUS_INITIALIZED;
 
 	up(&priv->action_sem);
@@ -6644,10 +6296,9 @@
 		dev = priv->net_dev;
 		sysfs_remove_group(&pci_dev->dev.kobj, &ipw2100_attribute_group);
 
-#ifdef CONFIG_PM
 		if (ipw2100_firmware.version)
 			ipw2100_release_firmware(priv, &ipw2100_firmware);
-#endif
+
 		/* Take down the hardware */
 		ipw2100_down(priv);
 
@@ -6680,17 +6331,11 @@
 
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
@@ -6707,17 +6352,9 @@
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
 
@@ -6738,17 +6375,9 @@
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
@@ -8295,8 +7924,6 @@
 
 	down(&priv->action_sem);
 
-	IPW_DEBUG_WX("enter\n");
-
 	up(&priv->action_sem);
 
 	wrqu.ap_addr.sa_family = ARPHRD_ETHER;
Only in linux-mm/drivers/net/wireless: ipw2100.c.bad
Only in linux-mm/drivers/net/wireless: ipw2100.c.good
--- clean-mm/drivers/net/wireless/ipw2100.h	2005-05-11 22:00:02.000000000 +0200
+++ linux-mm/drivers/net/wireless/ipw2100.h	2005-05-13 00:44:39.000000000 +0200
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
@@ -167,15 +143,6 @@
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
@@ -210,8 +177,6 @@
 	} info;
 } __attribute__ ((packed));
 
-#define	IPW_BUFDESC_LAST_FRAG 0
-
 struct ipw2100_bd {
 	u32 host_addr;
 	u32 buf_length;
@@ -355,7 +320,7 @@
 	u16 fragment_size;
 } __attribute__ ((packed));
 
-// Host command data structure
+/* Host command data structure */
 struct host_command {
 	u32 host_command;		// COMMAND ID
 	u32 host_command1;		// COMMAND ID
@@ -473,13 +438,8 @@
 
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
@@ -648,9 +608,6 @@
 	struct semaphore adapter_sem;
 
 	wait_queue_head_t wait_command_queue;
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,10)
-	u32 pm_state[PM_STATE_SIZE];
-#endif
 };
 
 
@@ -701,7 +658,7 @@
 #define MSDU_TX_RATES          62
 
 
-// Rogue AP Detection
+/* Rogue AP Detection */
 #define SET_STATION_STAT_BITS      64
 #define CLEAR_STATIONS_STAT_BITS   65
 #define LEAP_ROGUE_MODE            66	//TODO tbw replaced by CFG_LEAP_ROGUE_AP
@@ -711,25 +668,16 @@
 
 
 
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
@@ -761,41 +709,6 @@
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
 
@@ -913,7 +826,7 @@
 	} rx_data;
 } __attribute__ ((packed));
 
-// Bit 0-7 are for 802.11b tx rates - .  Bit 5-7 are reserved
+/* Bit 0-7 are for 802.11b tx rates - .  Bit 5-7 are reserved */
 #define TX_RATE_1_MBIT              0x0001
 #define TX_RATE_2_MBIT              0x0002
 #define TX_RATE_5_5_MBIT            0x0004
@@ -1193,7 +1106,6 @@
 	IPW_ORD_UCODE_VERSION,	// Ucode Version
 	IPW_ORD_HW_RF_SWITCH_STATE = 214,	// HW RF Kill Switch State
 } ORDINALTABLE1;
-//ENDOF TABLE1
 
 // ordinal table 2
 // Variable length data:

-- 
Boycott Kodak -- for their patent abuse against Java.
