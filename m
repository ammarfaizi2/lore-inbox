Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264095AbTFZWmF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 18:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264075AbTFZWk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 18:40:26 -0400
Received: from dclient217-162-108-200.hispeed.ch ([217.162.108.200]:17924 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S264047AbTFZWgJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 18:36:09 -0400
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH 2.5 1/3] strip.c: don't allocate net_device as part of private struct
Date: Fri, 27 Jun 2003 00:42:57 +0200
User-Agent: KMail/1.5.2
Cc: "linux-net" <linux-net@vger.kernel.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <20030626225012.D7FFF4FEFD@ritz.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi jeff

cleans up strip.c not to allocate struct net_device as part of the private
structure. use a separate kmalloc (and kfree). compile tested only.
against 2.5.73-bk

-daniel
 

--- 1.12/drivers/net/wireless/strip.c	Thu Apr 24 14:25:35 2003
+++ edited/strip.c	Thu Jun 26 22:52:32 2003
@@ -284,7 +284,7 @@
 	 */
 
 	struct tty_struct *tty;		/* ptr to TTY structure         */
-	struct net_device dev;		/* Our device structure         */
+	struct net_device *dev;		/* Our device structure         */
 
 	/*
 	 * Neighbour radio records
@@ -509,7 +509,7 @@
 		*p++ = '\"';
 	*p++ = 0;
 
-	printk(KERN_INFO "%s: %-13s%s\n", strip_info->dev.name, msg, pkt_text);
+	printk(KERN_INFO "%s: %-13s%s\n", strip_info->dev->name, msg, pkt_text);
 }
 
 
@@ -846,7 +846,7 @@
 
 static int allocate_buffers(struct strip *strip_info)
 {
-	struct net_device *dev = &strip_info->dev;
+	struct net_device *dev = strip_info->dev;
 	int sx_size = MAX(STRIP_ENCAP_SIZE(MAX_RECV_MTU), 4096);
 	int tx_size = STRIP_ENCAP_SIZE(dev->mtu) + MaxCommandStringLength;
 	__u8 *r = kmalloc(MAX_RECV_MTU, GFP_ATOMIC);
@@ -881,7 +881,7 @@
 static void strip_changedmtu(struct strip *strip_info)
 {
 	int old_mtu = strip_info->mtu;
-	struct net_device *dev = &strip_info->dev;
+	struct net_device *dev = strip_info->dev;
 	unsigned char *orbuff = strip_info->rx_buff;
 	unsigned char *osbuff = strip_info->sx_buff;
 	unsigned char *otbuff = strip_info->tx_buff;
@@ -889,14 +889,14 @@
 	if (dev->mtu > MAX_SEND_MTU) {
 		printk(KERN_ERR
 		       "%s: MTU exceeds maximum allowable (%d), MTU change cancelled.\n",
-		       strip_info->dev.name, MAX_SEND_MTU);
+		       strip_info->dev->name, MAX_SEND_MTU);
 		dev->mtu = old_mtu;
 		return;
 	}
 
 	if (!allocate_buffers(strip_info)) {
 		printk(KERN_ERR "%s: unable to grow strip buffers, MTU change cancelled.\n",
-		       strip_info->dev.name);
+		       strip_info->dev->name);
 		dev->mtu = old_mtu;
 		return;
 	}
@@ -923,7 +923,7 @@
 	strip_info->tx_head = strip_info->tx_buff;
 
 	printk(KERN_NOTICE "%s: strip MTU changed fom %d to %d.\n",
-	       strip_info->dev.name, old_mtu, strip_info->mtu);
+	       strip_info->dev->name, old_mtu, strip_info->mtu);
 
 	if (orbuff)
 		kfree(orbuff);
@@ -940,7 +940,7 @@
 	 */
 	strip_info->idle_timer.expires = jiffies + 1 * HZ;
 	add_timer(&strip_info->idle_timer);
-	netif_wake_queue(&strip_info->dev);
+	netif_wake_queue(strip_info->dev);
 }
 
 
@@ -1087,10 +1087,10 @@
 	FirmwareVersion firmware_version = strip_info->firmware_version;
 	SerialNumber serial_number = strip_info->serial_number;
 	BatteryVoltage battery_voltage = strip_info->battery_voltage;
-	char *if_name = strip_info->dev.name;
+	char *if_name = strip_info->dev->name;
 	MetricomAddress true_dev_addr = strip_info->true_dev_addr;
 	MetricomAddress dev_dev_addr =
-	    *(MetricomAddress *) strip_info->dev.dev_addr;
+	    *(MetricomAddress *) strip_info->dev->dev_addr;
 	int manual_dev_addr = strip_info->manual_dev_addr;
 #ifdef EXT_COUNTERS
 	unsigned long rx_bytes = strip_info->rx_bytes;
@@ -1133,7 +1133,7 @@
 	p += sprintf(p, " Next gratuitous ARP:\t");
 
 	if (!memcmp
-	    (strip_info->dev.dev_addr, zero_address.c,
+	    (strip_info->dev->dev_addr, zero_address.c,
 	     sizeof(zero_address)))
 		p += sprintf(p, "Disabled\n");
 	else {
@@ -1210,7 +1210,7 @@
 	 */
 	if (strip_info->working) {
 		printk(KERN_INFO "%s: No response: Resetting radio.\n",
-		       strip_info->dev.name);
+		       strip_info->dev->name);
 		strip_info->firmware_version.c[0] = '\0';
 		strip_info->serial_number.c[0] = '\0';
 		strip_info->battery_voltage.c[0] = '\0';
@@ -1231,7 +1231,7 @@
 	/* Mark radio address as unknown */
 	*(MetricomAddress *) & strip_info->true_dev_addr = zero_address;
 	if (!strip_info->manual_dev_addr)
-		*(MetricomAddress *) strip_info->dev.dev_addr =
+		*(MetricomAddress *) strip_info->dev->dev_addr =
 		    zero_address;
 	strip_info->working = FALSE;
 	strip_info->firmware_level = NoStructure;
@@ -1285,7 +1285,7 @@
 
 	/* First make sure we're connected. */
 	if (!strip_info || strip_info->magic != STRIP_MAGIC ||
-	    !netif_running(&strip_info->dev))
+	    !netif_running(strip_info->dev))
 		return;
 
 	if (strip_info->tx_left > 0) {
@@ -1340,14 +1340,14 @@
 	else {
 		printk(KERN_ERR
 		       "%s: strip_make_packet: Unknown packet type 0x%04X\n",
-		       strip_info->dev.name, ntohs(header->protocol));
+		       strip_info->dev->name, ntohs(header->protocol));
 		return (NULL);
 	}
 
 	if (len > strip_info->mtu) {
 		printk(KERN_ERR
 		       "%s: Dropping oversized transmit packet: %d bytes\n",
-		       strip_info->dev.name, len);
+		       strip_info->dev->name, len);
 		return (NULL);
 	}
 
@@ -1357,7 +1357,7 @@
 	 */
 	if (!memcmp(haddr.c, strip_info->true_dev_addr.c, sizeof(haddr))) {
 		printk(KERN_ERR "%s: Dropping packet addressed to self\n",
-		       strip_info->dev.name);
+		       strip_info->dev->name);
 		return (NULL);
 	}
 
@@ -1367,7 +1367,7 @@
 	 */
 	if (haddr.c[0] == 0xFF) {
 		u32 brd = 0;
-		struct in_device *in_dev = in_dev_get(&strip_info->dev);
+		struct in_device *in_dev = in_dev_get(strip_info->dev);
 		if (in_dev == NULL)
 			return NULL;
 		read_lock(&in_dev->lock);
@@ -1377,10 +1377,10 @@
 		in_dev_put(in_dev);
 
 		/* arp_query returns 1 if it succeeds in looking up the address, 0 if it fails */
-		if (!arp_query(haddr.c, brd, &strip_info->dev)) {
+		if (!arp_query(haddr.c, brd, strip_info->dev)) {
 			printk(KERN_ERR
 			       "%s: Unable to send packet (no broadcast hub configured)\n",
-			       strip_info->dev.name);
+			       strip_info->dev->name);
 			return (NULL);
 		}
 		/*
@@ -1491,7 +1491,7 @@
 #endif
 		strip_info->watchdog_doprobe = jiffies + 10 * HZ;
 		strip_info->watchdog_doreset = jiffies + 1 * HZ;
-		/*printk(KERN_INFO "%s: Routine radio test.\n", strip_info->dev.name); */
+		/*printk(KERN_INFO "%s: Routine radio test.\n", strip_info->dev->name); */
 	}
 
 	/*
@@ -1506,7 +1506,7 @@
 	 */
 	if (strip_info->tx_size - strip_info->tx_left < 20)
 		printk(KERN_ERR "%s: Sending%5d bytes;%5d bytes free.\n",
-		       strip_info->dev.name, strip_info->tx_left,
+		       strip_info->dev->name, strip_info->tx_left,
 		       strip_info->tx_size - strip_info->tx_left);
 
 	/*
@@ -1519,7 +1519,7 @@
 	}
 
 	if (1) {
-		struct in_device *in_dev = in_dev_get(&strip_info->dev);
+		struct in_device *in_dev = in_dev_get(strip_info->dev);
 		brd = addr = 0;
 		if (in_dev) {
 			read_lock(&in_dev->lock);
@@ -1549,11 +1549,11 @@
 	 */
 	if (strip_info->working
 	    && (long) jiffies - strip_info->gratuitous_arp >= 0
-	    && memcmp(strip_info->dev.dev_addr, zero_address.c,
+	    && memcmp(strip_info->dev->dev_addr, zero_address.c,
 		      sizeof(zero_address))
-	    && arp_query(haddr.c, brd, &strip_info->dev)) {
+	    && arp_query(haddr.c, brd, strip_info->dev)) {
 		/*printk(KERN_INFO "%s: Sending gratuitous ARP with interval %ld\n",
-		   strip_info->dev.name, strip_info->arp_interval / HZ); */
+		   strip_info->dev->name, strip_info->arp_interval / HZ); */
 		strip_info->gratuitous_arp =
 		    jiffies + strip_info->arp_interval;
 		strip_info->arp_interval *= 2;
@@ -1561,11 +1561,11 @@
 			strip_info->arp_interval = MaxARPInterval;
 		if (addr)
 			arp_send(ARPOP_REPLY, ETH_P_ARP, addr,	/* Target address of ARP packet is our address */
-				 &strip_info->dev,	/* Device to send packet on */
+				 strip_info->dev,	/* Device to send packet on */
 				 addr,	/* Source IP address this ARP packet comes from */
 				 NULL,	/* Destination HW address is NULL (broadcast it) */
-				 strip_info->dev.dev_addr,	/* Source HW address is our HW address */
-				 strip_info->dev.dev_addr);	/* Target HW address is our HW address (redundant) */
+				 strip_info->dev->dev_addr,	/* Source HW address is our HW address */
+				 strip_info->dev->dev_addr);	/* Target HW address is our HW address (redundant) */
 	}
 
 	/*
@@ -1608,18 +1608,18 @@
 
 		if (rx_pps_count / 8 >= 10)
 			printk(KERN_INFO "%s: WARNING: Receiving %ld packets per second.\n",
-			       strip_info->dev.name, rx_pps_count / 8);
+			       strip_info->dev->name, rx_pps_count / 8);
 		if (tx_pps_count / 8 >= 10)
 			printk(KERN_INFO "%s: WARNING: Tx        %ld packets per second.\n",
-			       strip_info->dev.name, tx_pps_count / 8);
+			       strip_info->dev->name, tx_pps_count / 8);
 		if (sx_pps_count / 8 >= 10)
 			printk(KERN_INFO "%s: WARNING: Sending   %ld packets per second.\n",
-			       strip_info->dev.name, sx_pps_count / 8);
+			       strip_info->dev->name, sx_pps_count / 8);
 	}
 
 	spin_lock_irqsave(&strip_lock, flags);
 	/* See if someone has been ifconfigging */
-	if (strip_info->mtu != strip_info->dev.mtu)
+	if (strip_info->mtu != strip_info->dev->mtu)
 		strip_changedmtu(strip_info);
 
 	strip_send(strip_info, skb);
@@ -1735,7 +1735,7 @@
 	len = MIN(len, sizeof(FirmwareVersion) - 1);
 	if (strip_info->firmware_version.c[0] == 0)
 		printk(KERN_INFO "%s: Radio Firmware: %.*s\n",
-		       strip_info->dev.name, len, value_begin);
+		       strip_info->dev->name, len, value_begin);
 	sprintf(strip_info->firmware_version.c, "%.*s", len, value_begin);
 
 	/* Look for the first colon */
@@ -1806,10 +1806,10 @@
 		MetricomAddressString addr_string;
 		radio_address_to_string(&addr, &addr_string);
 		printk(KERN_INFO "%s: Radio address = %s\n",
-		       strip_info->dev.name, addr_string.c);
+		       strip_info->dev->name, addr_string.c);
 		strip_info->true_dev_addr = addr;
 		if (!strip_info->manual_dev_addr)
-			*(MetricomAddress *) strip_info->dev.dev_addr =
+			*(MetricomAddress *) strip_info->dev->dev_addr =
 			    addr;
 		/* Give the radio a few seconds to get its head straight, then send an arp */
 		strip_info->gratuitous_arp = jiffies + 15 * HZ;
@@ -1830,7 +1830,7 @@
 	if (sum == 0 && strip_info->firmware_level == StructuredMessages) {
 		strip_info->firmware_level = ChecksummedMessages;
 		printk(KERN_INFO "%s: Radio provides message checksums\n",
-		       strip_info->dev.name);
+		       strip_info->dev->name);
 	}
 	return (sum == 0);
 }
@@ -1849,7 +1849,7 @@
 	if (has_prefix(msg, len, "001")) {	/* Not in StarMode! */
 		RecvErr("Error Msg:", strip_info);
 		printk(KERN_INFO "%s: Radio %s is not in StarMode\n",
-		       strip_info->dev.name, sendername);
+		       strip_info->dev->name, sendername);
 	}
 
 	else if (has_prefix(msg, len, "002")) {	/* Remap handle */
@@ -1859,7 +1859,7 @@
 	else if (has_prefix(msg, len, "003")) {	/* Can't resolve name */
 		RecvErr("Error Msg:", strip_info);
 		printk(KERN_INFO "%s: Destination radio name is unknown\n",
-		       strip_info->dev.name);
+		       strip_info->dev->name);
 	}
 
 	else if (has_prefix(msg, len, "004")) {	/* Name too small or missing */
@@ -1876,7 +1876,7 @@
 		if (!strip_info->working) {
 			strip_info->working = TRUE;
 			printk(KERN_INFO "%s: Radio now in starmode\n",
-			       strip_info->dev.name);
+			       strip_info->dev->name);
 			/*
 			 * If the radio has just entered a working state, we should do our first
 			 * probe ASAP, so that we find out our radio address etc. without delay.
@@ -1888,7 +1888,7 @@
 			strip_info->next_command = 0;	/* Try to enable checksums ASAP */
 			printk(KERN_INFO
 			       "%s: Radio provides structured messages\n",
-			       strip_info->dev.name);
+			       strip_info->dev->name);
 		}
 		if (strip_info->firmware_level >= StructuredMessages) {
 			/*
@@ -1916,14 +1916,14 @@
 		RecvErr("Error Msg:", strip_info);
 		printk(KERN_ERR
 		       "%s: Error! Packet size too big for radio.\n",
-		       strip_info->dev.name);
+		       strip_info->dev->name);
 	}
 
 	else if (has_prefix(msg, len, "008")) {	/* Bad character in name */
 		RecvErr("Error Msg:", strip_info);
 		printk(KERN_ERR
 		       "%s: Radio name contains illegal character\n",
-		       strip_info->dev.name);
+		       strip_info->dev->name);
 	}
 
 	else if (has_prefix(msg, len, "009"))	/* No count or line terminator */
@@ -1994,7 +1994,7 @@
 	/* real radio hardware address, try to find another strip device that has been */
 	/* manually set to that address that we can 'transfer ownership' of this packet to  */
 	if (strip_info->manual_dev_addr &&
-	    !memcmp(strip_info->dev.dev_addr, zero_address.c,
+	    !memcmp(strip_info->dev->dev_addr, zero_address.c,
 		    sizeof(zero_address))
 	    && memcmp(&strip_info->true_dev_addr, zero_address.c,
 		      sizeof(zero_address))) {
@@ -2002,13 +2002,13 @@
 		read_lock_bh(&dev_base_lock);
 		dev = dev_base;
 		while (dev) {
-			if (dev->type == strip_info->dev.type &&
+			if (dev->type == strip_info->dev->type &&
 			    !memcmp(dev->dev_addr,
 				    &strip_info->true_dev_addr,
 				    sizeof(MetricomAddress))) {
 				printk(KERN_INFO
 				       "%s: Transferred packet ownership to %s.\n",
-				       strip_info->dev.name, dev->name);
+				       strip_info->dev->name, dev->name);
 				read_unlock_bh(&dev_base_lock);
 				return (dev);
 			}
@@ -2016,7 +2016,7 @@
 		}
 		read_unlock_bh(&dev_base_lock);
 	}
-	return (&strip_info->dev);
+	return (strip_info->dev);
 }
 
 /*
@@ -2029,7 +2029,7 @@
 	struct sk_buff *skb = dev_alloc_skb(sizeof(STRIP_Header) + packetlen);
 	if (!skb) {
 		printk(KERN_ERR "%s: memory squeeze, dropping packet.\n",
-		       strip_info->dev.name);
+		       strip_info->dev->name);
 		strip_info->rx_dropped++;
 	} else {
 		memcpy(skb_put(skb, sizeof(STRIP_Header)), header,
@@ -2073,12 +2073,12 @@
 
 	if (packetlen > MAX_RECV_MTU) {
 		printk(KERN_INFO "%s: Dropping oversized received IP packet: %d bytes\n",
-		       strip_info->dev.name, packetlen);
+		       strip_info->dev->name, packetlen);
 		strip_info->rx_dropped++;
 		return;
 	}
 
-	/*printk(KERN_INFO "%s: Got %d byte IP packet\n", strip_info->dev.name, packetlen); */
+	/*printk(KERN_INFO "%s: Got %d byte IP packet\n", strip_info->dev->name, packetlen); */
 
 	/* Decode remainder of the IP packet */
 	ptr =
@@ -2117,13 +2117,13 @@
 	if (packetlen > MAX_RECV_MTU) {
 		printk(KERN_INFO
 		       "%s: Dropping oversized received ARP packet: %d bytes\n",
-		       strip_info->dev.name, packetlen);
+		       strip_info->dev->name, packetlen);
 		strip_info->rx_dropped++;
 		return;
 	}
 
 	/*printk(KERN_INFO "%s: Got %d byte ARP %s\n",
-	   strip_info->dev.name, packetlen,
+	   strip_info->dev->name, packetlen,
 	   ntohs(arphdr->ar_op) == ARPOP_REQUEST ? "request" : "reply"); */
 
 	/* Decode remainder of the ARP packet */
@@ -2251,7 +2251,7 @@
 		}
 	}
 
-	/*printk(KERN_INFO "%s: Got packet from \"%s\".\n", strip_info->dev.name, sendername); */
+	/*printk(KERN_INFO "%s: Got packet from \"%s\".\n", strip_info->dev->name, sendername); */
 
 	/*
 	 * Fill in (pseudo) source and destination addresses in the packet.
@@ -2320,13 +2320,13 @@
 	unsigned long flags;
 
 	if (!strip_info || strip_info->magic != STRIP_MAGIC
-	    || !netif_running(&strip_info->dev))
+	    || !netif_running(strip_info->dev))
 		return;
 
 	spin_lock_irqsave(&strip_lock, flags);
 
 	/* Argh! mtu change time! - costs us the packet part received at the change */
-	if (strip_info->mtu != strip_info->dev.mtu)
+	if (strip_info->mtu != strip_info->dev->mtu)
 		strip_changedmtu(strip_info);
 
 #if 0
@@ -2347,7 +2347,7 @@
 	while (cp < end) {
 		if (fp && *fp)
 			printk(KERN_INFO "%s: %s on serial port\n",
-			       strip_info->dev.name, TTYERROR(*fp));
+			       strip_info->dev->name, TTYERROR(*fp));
 		if (fp && *fp++ && !strip_info->discard) {	/* If there's a serial error, record it */
 			/* If we have some characters in the buffer, discard them */
 			strip_info->discard = strip_info->sx_count;
@@ -2360,7 +2360,7 @@
 				if (strip_info->sx_count > 3000)
 					printk(KERN_INFO
 					       "%s: Cut a %d byte packet (%d bytes remaining)%s\n",
-					       strip_info->dev.name,
+					       strip_info->dev->name,
 					       strip_info->sx_count,
 					       end - cp - 1,
 					       strip_info->
@@ -2371,12 +2371,12 @@
 					strip_info->rx_over_errors++;
 					printk(KERN_INFO
 					       "%s: sx_buff overflow (%d bytes total)\n",
-					       strip_info->dev.name,
+					       strip_info->dev->name,
 					       strip_info->sx_count);
 				} else if (strip_info->discard)
 					printk(KERN_INFO
 					       "%s: Discarding bad packet (%d/%d)\n",
-					       strip_info->dev.name,
+					       strip_info->dev->name,
 					       strip_info->discard,
 					       strip_info->sx_count);
 				else
@@ -2415,9 +2415,9 @@
 	    memcmp(addr->c, broadcast_address.c,
 		   sizeof(broadcast_address));
 	if (strip_info->manual_dev_addr)
-		*(MetricomAddress *) strip_info->dev.dev_addr = *addr;
+		*(MetricomAddress *) strip_info->dev->dev_addr = *addr;
 	else
-		*(MetricomAddress *) strip_info->dev.dev_addr =
+		*(MetricomAddress *) strip_info->dev->dev_addr =
 		    strip_info->true_dev_addr;
 	return 0;
 }
@@ -2496,7 +2496,7 @@
 	strip_info->user_baud = get_baud(strip_info->tty);
 
 	printk(KERN_INFO "%s: Initializing Radio.\n",
-	       strip_info->dev.name);
+	       strip_info->dev->name);
 	ResetRadio(strip_info);
 	strip_info->idle_timer.expires = jiffies + 1 * HZ;
 	add_timer(&strip_info->idle_timer);
@@ -2589,6 +2589,8 @@
 	if (strip_info->next)
 		strip_info->next->referrer = strip_info->referrer;
 	strip_info->magic = 0;
+	if (strip_info->dev)
+		kfree(strip_info->dev);
 	kfree(strip_info);
 }
 
@@ -2600,6 +2602,7 @@
 {
 	int channel_id = 0;
 	struct strip **s = &struct_strip_list;
+	struct net_device *dev;
 	struct strip *strip_info = (struct strip *)
 	    kmalloc(sizeof(struct strip), GFP_KERNEL);
 
@@ -2612,13 +2615,22 @@
 
 	memset(strip_info, 0, sizeof(struct strip));
 
+	/* allocate the net_device */
+	dev = kmalloc(sizeof(struct net_device), GFP_KERNEL);
+	if (!dev) {
+		kfree(strip_info);
+		return NULL;
+	}
+	strip_info->dev = dev;
+	SET_MODULE_OWNER(dev);
+
 	/*
 	 * Search the list to find where to put our new entry
 	 * (and in the process decide what channel number it is
 	 * going to be)
 	 */
 
-	while (*s && (*s)->dev.base_addr == channel_id) {
+	while (*s && (*s)->dev->base_addr == channel_id) {
 		channel_id++;
 		s = &(*s)->next;
 	}
@@ -2639,15 +2651,15 @@
 	strip_info->gratuitous_arp = jiffies + LongTime;
 	strip_info->arp_interval = 0;
 	init_timer(&strip_info->idle_timer);
-	strip_info->idle_timer.data = (long) &strip_info->dev;
+	strip_info->idle_timer.data = (long) dev;
 	strip_info->idle_timer.function = strip_IdleTask;
 
 	/* Note: strip_info->if_name is currently 8 characters long */
-	sprintf(strip_info->dev.name, "st%d", channel_id);
-	strip_info->dev.base_addr = channel_id;
-	strip_info->dev.priv = (void *) strip_info;
-	strip_info->dev.next = NULL;
-	strip_info->dev.init = strip_dev_init;
+	sprintf(dev->name, "st%d", channel_id);
+	dev->base_addr = channel_id;
+	dev->priv = (void *) strip_info;
+	dev->next = NULL;
+	dev->init = strip_dev_init;
 
 	return strip_info;
 }
@@ -2682,7 +2694,7 @@
 	 * strip_dev_init() will be called as a side-effect
 	 */
 
-	if (register_netdev(&strip_info->dev) != 0) {
+	if (register_netdev(strip_info->dev) != 0) {
 		printk(KERN_ERR "strip: register_netdev() failed.\n");
 		strip_free(strip_info);
 		return -ENFILE;
@@ -2699,7 +2711,7 @@
 	 * Restore default settings
 	 */
 
-	strip_info->dev.type = ARPHRD_METRICOM;	/* dtang */
+	strip_info->dev->type = ARPHRD_METRICOM;	/* dtang */
 
 	/*
 	 * Set tty options
@@ -2709,15 +2721,13 @@
 	tty->termios->c_cflag |= CLOCAL;	/* Ignore modem control signals. */
 	tty->termios->c_cflag &= ~HUPCL;	/* Don't close on hup */
 
-	MOD_INC_USE_COUNT;
-
 	printk(KERN_INFO "STRIP: device \"%s\" activated\n",
-	       strip_info->dev.name);
+	       strip_info->dev->name);
 
 	/*
 	 * Done.  We have linked the TTY line to a channel.
 	 */
-	return (strip_info->dev.base_addr);
+	return (strip_info->dev->base_addr);
 }
 
 /*
@@ -2738,15 +2748,14 @@
 	if (!strip_info || strip_info->magic != STRIP_MAGIC)
 		return;
 
-	unregister_netdev(&strip_info->dev);
+	unregister_netdev(strip_info->dev);
 
 	tty->disc_data = 0;
 	strip_info->tty = NULL;
 	printk(KERN_INFO "STRIP: device \"%s\" closed down\n",
-	       strip_info->dev.name);
+	       strip_info->dev->name);
 	strip_free(strip_info);
 	tty->disc_data = NULL;
-	MOD_DEC_USE_COUNT;
 }
 
 
@@ -2767,13 +2776,13 @@
 
 	switch (cmd) {
 	case SIOCGIFNAME:
-		if(copy_to_user((void *) arg, strip_info->dev.name, strlen(strip_info->dev.name) + 1))
+		if(copy_to_user((void *) arg, strip_info->dev->name, strlen(strip_info->dev->name) + 1))
 			return -EFAULT;
 		break;
 	case SIOCSIFHWADDR:
 	{
 		MetricomAddress addr;
-		//printk(KERN_INFO "%s: SIOCSIFHWADDR\n", strip_info->dev.name);
+		//printk(KERN_INFO "%s: SIOCSIFHWADDR\n", strip_info->dev->name);
 		if(copy_from_user(&addr, (void *) arg, sizeof(MetricomAddress)))
 			return -EFAULT;
 		return set_mac_address(strip_info, &addr);

