Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275127AbRIYRkt>; Tue, 25 Sep 2001 13:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275091AbRIYRkf>; Tue, 25 Sep 2001 13:40:35 -0400
Received: from datela-1-5-104.dialup.vol.cz ([212.20.99.26]:7041 "EHLO utx.cz")
	by vger.kernel.org with ESMTP id <S275127AbRIYRkT>;
	Tue, 25 Sep 2001 13:40:19 -0400
Date: Tue, 25 Sep 2001 18:40:17 +0200
From: Stanislav Brabec <utx@penguin.cz>
To: linux-kernel@vger.kernel.org
Subject: usbnet.c - patch to support GL620USB-A chip
Message-ID: <20010925184017.A401@utx.vol.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
X-Accept-Language: cs, sk, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,

there is a patch to support GeneSys Logic GL620USB-A chip, which can be
found in GeneLink cables. I have obtained the driver code from David
Brownell, the code comes from Jiun-Jie Huang (Genesys Logic Taiwan) and
I have merged it with linux-2.4.10.

I have author's agreement to include the code as GNU GPL.

I have succeeded in using it for two months (in past with -ac kernels,
now with 2.4.10).

The chip is present also on some mainboards with USB PC2PC support, for
example Microstar MSI K7T266 Pro.

Untested remains co-operation with Windows drivers. Unimplemented is
currently check_connect handshaking (it seems that is is recently
unsupported on all usbnet supported chips).

-- 
Stanislav Brabec

--- linux/drivers/usb/usbnet.c.orig	Sat Sep 15 00:04:07 2001
+++ linux/drivers/usb/usbnet.c	Tue Sep 25 10:04:24 2001
@@ -19,6 +19,8 @@
  *	- "Linux Devices" (like iPaq and similar SA-1100 based PDAs)
  *	- NetChip 1080 (interoperates with NetChip Win32 drivers)
  *	- Prolific PL-2301/2302 (replaces "plusb" driver)
+ *	- GeneSys GL620USB/GL620USB-A
+
  *
  * USB devices can implement their side of this protocol at the cost
  * of two bulk endpoints; it's not restricted to "cable" applications.
@@ -73,6 +75,9 @@
  *		Win32 Belkin driver; other cleanups (db).
  * 16-jul-2001	Bugfixes for uhci oops-on-unplug, Belkin support, various
  *		cleanups for problems not yet seen in the field. (db)
+ *  3-aug-2001	Merged GeneSys driver, using code from
+ *		Jiun-Jie Huang <huangjj@genesyslogic.com.tw>
+ *		by Stanislav Brabec <utx@penguin.cz>
  *
  *-------------------------------------------------------------------------*/
 
@@ -101,6 +106,7 @@
 #define	CONFIG_USB_LINUXDEV
 #define	CONFIG_USB_NET1080
 #define	CONFIG_USB_PL2301
+#define	CONFIG_USB_GENELINK
 
 
 /*-------------------------------------------------------------------------*/
@@ -162,6 +168,13 @@
 	struct sk_buff_head	done;
 	struct tasklet_struct	bh;
 	struct tq_struct ctrl_task;
+
+#ifdef CONFIG_USB_GENELINK
+
+	// various data structure may be needed
+	void *priv_data;
+
+#endif
 };
 
 // device-specific info used by the driver
@@ -170,6 +183,7 @@
 
 	int		flags;
 #define FLAG_FRAMING	0x0001		/* guard against device dropouts */ 
+#define FLAG_GENELINK	0x0002		/* genelink flag */
 
 	/* reset device ... can sleep */
 	int	(*reset)(struct usbnet *);
@@ -177,6 +191,18 @@
 	/* see if peer is connected ... can sleep */
 	int	(*check_connect)(struct usbnet *);
 
+#ifdef CONFIG_USB_GENELINK
+
+// 	if (dev->driver_info->flags & FLAG_GENELINK)
+
+	/* allocate and initialize the private resources per device */
+	int (*initialize_private)(struct usbnet *);
+
+	/* free the private resources per device */
+	int (*release_private)(struct usbnet *);
+
+#endif
+
 	// FIXME -- also an interrupt mechanism
 
 	/* framework currently "knows" bulk EPs talk packets */
@@ -719,6 +745,201 @@
 
 
 
+#ifdef CONFIG_USB_GENELINK
+/*-------------------------------------------------------------------------
+ *
+ * GeneSys GL620USB/GL620USB-A (www.genesyslogic.com.tw)
+ *
+ *-------------------------------------------------------------------------*/
+
+// control msg write command
+#define GENELINK_CONNECT_WRITE			0xF0
+// interrupt pipe index
+#define GENELINK_INTERRUPT_PIPE			0x03
+// interrupt read buffer size
+#define INTERRUPT_BUFSIZE				0x08
+// interrupt pipe interval value
+#define GENELINK_INTERRUPT_INTERVAL		0x10
+// max transmit packet number per transmit
+#define GL_MAX_TRANSMIT_PACKETS			32
+// max packet length
+#define GL_MAX_PACKET_LEN				1514
+// max receive buffer size 
+#define GL_RCV_BUF_SIZE					(((GL_MAX_PACKET_LEN + 4) * GL_MAX_TRANSMIT_PACKETS) + 4)
+
+struct gl_priv
+{ 
+	struct urb *irq_urb;
+	char irq_buf[INTERRUPT_BUFSIZE];
+};
+
+struct gl_packet 
+{
+	u32 packet_length;
+	char packet_data[1];
+};
+
+struct gl_header 
+{
+	u32 packet_count;
+
+	struct gl_packet packets;
+};
+
+static inline int gl_control_write(struct usbnet *dev, u8 request, u16 value)
+{
+	int retval;
+
+	retval = usb_control_msg (dev->udev,
+							  usb_sndctrlpipe (dev->udev, 0),
+							  request,
+							  USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
+							  value, 
+							  0,			// index
+							  0,			// data buffer
+							  0,			// size
+							  CONTROL_TIMEOUT_JIFFIES);
+
+	return retval;
+}
+
+static void gl_interrupt_complete (struct urb *urb)
+{
+	int status = urb->status;
+	
+	if (status)
+		dbg("gl_interrupt_complete fail - %X\n", status);
+	else
+		dbg("gl_interrupt_complete success...\n");
+}
+
+static inline int gl_interrupt_read(struct usbnet *dev)
+{
+	struct gl_priv *priv = dev->priv_data;
+	int	retval;
+
+	// issue usb interrupt read
+	if (priv && priv->irq_urb)
+	{
+		// submit urb
+		if ((retval = usb_submit_urb (priv->irq_urb)) != 0)
+			dbg("gl_interrupt_read : submit interrupt read urb fail - %X...\n", retval);
+		else
+			dbg("gl_interrupt_read : submit interrupt read urb success....\n");
+	}
+
+	return 0;
+}
+
+// check whether another side is connected
+static int genelink_check_connect (struct usbnet *dev)
+{
+	dbg ("%s: assuming peer is connected", dev->net.name);
+	return 0;
+
+	/*
+	// FIXME Uncomment this code after genelink_check_connect
+	// control hanshaking will be implemented
+
+	int			retval;
+
+	dbg("genelink_check_connect...\n");
+
+	// issue a usb control write command to detect whether another side is connected
+	if ((retval = gl_control_write(dev, GENELINK_CONNECT_WRITE, 0)) != 0) {
+		dbg ("%s: genelink_check_connect control write fail - %X\n", dev->net.name, retval);
+		return retval;
+	} else {
+		dbg("%s: genelink_check_conntect control write success\n",dev->net.name);
+
+		// issue a usb interrupt read command to ack another side 
+
+		if ((retval = gl_interrupt_read(dev)) != 0) {
+			dbg("%s: genelink_check_connect interrupt read fail - %X\n", dev->net.name, retval);
+			return retval;
+		} else {
+			dbg("%s: genelink_check_connect interrupt read success\n", dev->net.name);
+		}
+
+	}
+	*/
+
+	return 0;
+}
+
+// allocate and initialize the private data for genelink
+static int genelink_init_priv(struct usbnet *dev)
+{
+	struct gl_priv *priv;
+
+	// allocate the private data structure
+	if ((priv = kmalloc (sizeof *priv, GFP_KERNEL)) == 0)
+	{
+		dbg("%s: cannot allocate private data per device", dev->net.name);
+		return -ENOMEM;
+	}
+
+	// allocate irq urb
+	if ((priv->irq_urb = usb_alloc_urb(0)) == 0)
+	{
+		dbg("%s: cannot allocate private irq urb per device", dev->net.name);
+		kfree(priv);
+		return -ENOMEM;
+	}
+
+	// fill irq urb
+	FILL_INT_URB(priv->irq_urb, dev->udev, usb_rcvintpipe(dev->udev, GENELINK_INTERRUPT_PIPE),
+				 priv->irq_buf, INTERRUPT_BUFSIZE, gl_interrupt_complete, 0, GENELINK_INTERRUPT_INTERVAL);
+
+	// set private data pointer
+	dev->priv_data = priv;
+
+	return 0;
+}
+
+// release the private data
+static int genelink_release_priv(struct usbnet *dev)
+{
+	struct gl_priv *priv = dev->priv_data;
+
+	if (!priv) 
+		return 0;
+	
+	// cancel irq urb first
+	usb_unlink_urb(priv->irq_urb);
+
+	// free irq urb
+	usb_free_urb(priv->irq_urb);
+
+	// free the private data structure
+	kfree(priv);
+
+	return 0;
+}
+
+// reset the device status
+static int genelink_reset (struct usbnet *dev)
+{
+	// we don't need to reset, just return 0
+	return 0;
+}
+
+static const struct driver_info	genelink_info = {
+	description:	"Genesys GeneLink",
+	flags:		FLAG_GENELINK,
+	reset:		genelink_reset,
+	check_connect:	genelink_check_connect,
+	initialize_private: genelink_init_priv,
+	release_private: genelink_release_priv,
+
+	in: 1, out: 2,		// direction distinguishes these
+	epsize:	64,
+};
+
+#endif /* CONFIG_USB_GENELINK */
+
+
+
 /*-------------------------------------------------------------------------
  *
  * Network Device Driver (peer link to "Host Device", from USB host)
@@ -782,6 +1003,14 @@
 	size = (dev->driver_info->flags & FLAG_FRAMING)
 			? FRAMED_SIZE (dev->net.mtu)
 			: (sizeof (struct ethhdr) + dev->net.mtu);
+
+#ifdef CONFIG_USB_GENELINK
+
+	if (dev->driver_info->flags & FLAG_GENELINK)
+		size = GL_RCV_BUF_SIZE;
+
+#endif
+
 	if ((skb = alloc_skb (size, flags)) == 0) {
 		dbg ("no rx skb");
 		tasklet_schedule (&dev->bh);
@@ -894,9 +1123,123 @@
 		// the extra byte we may have appended
 	}
 
+#ifdef CONFIG_USB_GENELINK
+
+	if (dev->driver_info->flags & FLAG_GENELINK)
+	{
+		struct gl_header *header;
+		struct gl_packet *current_packet;
+		struct sk_buff *gl_skb;
+		int status;
+		u32 size;
+
+		header = (struct gl_header *)skb->data;
+
+		// get the packet count of the received skb
+		le32_to_cpus(&header->packet_count);
+
+//		dbg("receive packet count = %d", header->packet_count);
+
+		if ((header->packet_count > GL_MAX_TRANSMIT_PACKETS) || 
+			(header->packet_count < 0))
+		{
+			dbg("genelink : illegal received packet count %d", header->packet_count);
+			goto error;
+		}
+
+		// set the current packet pointer to the first packet
+		current_packet = &(header->packets);
+
+		// decrement the length for the packet count size 4 bytes
+		skb_pull(skb, 4);
+
+		while (header->packet_count > 1)
+		{
+			// get the packet length
+			size = current_packet->packet_length;
+
+			// this may be a broken packet
+			if (size > GL_MAX_PACKET_LEN)
+			{
+				dbg("genelink : illegal received packet length %d, maybe a broken packet", size);
+				goto error;
+			}
+
+			// allocate the skb for the individual packet
+			gl_skb = alloc_skb (size, in_interrupt () ? GFP_ATOMIC : GFP_KERNEL);
+
+			if (gl_skb == 0)
+				goto error;
+
+			// copy the packet data to the new skb
+			memcpy(gl_skb->data,current_packet->packet_data,size);
+
+			// set skb data size
+			gl_skb->len = size;
+/*
+			dbg("rx_process one gl_packet, size = %d....", size);
+
+			dbg("%02X %02X %02X %02X %02X %02X",
+				(u8)gl_skb->data[0],(u8)gl_skb->data[1],(u8)gl_skb->data[2],
+				(u8)gl_skb->data[3],(u8)gl_skb->data[4],(u8)gl_skb->data[5]);
+			dbg("%02X %02X %02X %02X %02X %02X\n",
+				(u8)gl_skb->data[6],(u8)gl_skb->data[7],(u8)gl_skb->data[8],
+				(u8)gl_skb->data[9],(u8)gl_skb->data[10],(u8)gl_skb->data[11]);
+*/
+			gl_skb->dev = &dev->net;
+
+			// determine the packet's protocol ID
+			gl_skb->protocol = eth_type_trans(gl_skb, &dev->net);
+
+			// update the status
+			dev->stats.rx_packets++;
+			dev->stats.rx_bytes += size;
+
+			// notify os of the received packet
+			status = netif_rx (gl_skb);
+
+//			dev_kfree_skb (gl_skb);	// just for debug purpose, delete this line for normal operation
+
+			// advance to the next packet
+			current_packet = (struct gl_packet *)(current_packet->packet_data + size);
+
+			header->packet_count --;
+
+			// shift the data pointer to the next gl_packet
+			skb_pull(skb, size + 4);
+		}	// while (header->packet_count > 1)
+
+		// skip the packet length field 4 bytes
+		skb_pull(skb, 4);
+	}
+
+#endif
+
 	if (skb->len) {
 		int	status;
 
+#ifdef CONFIG_USB_GENELINK
+
+/*
+		dbg("rx_process one packet, size = %d", skb->len);
+
+		dbg("%02X %02X %02X %02X %02X %02X",
+			(u8)skb->data[0],(u8)skb->data[1],(u8)skb->data[2],
+			(u8)skb->data[3],(u8)skb->data[4],(u8)skb->data[5]);
+		dbg("%02X %02X %02X %02X %02X %02X\n",
+			(u8)skb->data[6],(u8)skb->data[7],(u8)skb->data[8],
+			(u8)skb->data[9],(u8)skb->data[10],(u8)skb->data[11]);
+*/
+
+		if ((dev->driver_info->flags & FLAG_GENELINK) &&
+			(skb->len > GL_MAX_PACKET_LEN))
+		{
+			dbg("genelink : illegal received packet length %d, maybe a broken packet", skb->len);
+			goto error;
+		}
+
+#endif
+
 // FIXME: eth_copy_and_csum "small" packets to new SKB (small < ~200 bytes) ?
 
 		skb->dev = &dev->net;
@@ -1049,6 +1392,13 @@
 	dev->wait = 0;
 	remove_wait_queue (&unlink_wakeup, &wait); 
 
+#ifdef CONFIG_USB_GENELINK
+
+	if (dev->driver_info->release_private)
+		dev->driver_info->release_private(dev);
+
+#endif
+
 	mutex_unlock (&dev->mutex);
 	return 0;
 }
@@ -1076,6 +1426,19 @@
 		goto done;
 	}
 
+#ifdef CONFIG_USB_GENELINK
+
+	// initialize the private resources
+	if (info->initialize_private)
+	{
+		if ((retval = info->initialize_private(dev)) < 0)
+		{
+			dbg("%s: open initialize private fail", dev->net.name);
+			goto done;
+		}
+	}
+#endif
+
 	// insist peer be connected
 	if (info->check_connect && (retval = info->check_connect (dev)) < 0) {
 		devdbg (dev, "can't open; %d", retval);
@@ -1180,6 +1543,49 @@
 
 /*-------------------------------------------------------------------------*/
 
+#ifdef CONFIG_USB_GENELINK
+
+static struct sk_buff *gl_build_skb (struct sk_buff *skb)
+{
+	struct sk_buff *skb2;
+	int padlen;
+
+	int	headroom = skb_headroom (skb);
+	int	tailroom = skb_tailroom (skb);
+
+//	dbg("headroom = %d, tailroom = %d", headroom, tailroom);
+
+	padlen = ((skb->len + (4 + 4*1)) % 64) ? 0 : 1;
+
+	if ((!skb_cloned (skb)) && ((headroom + tailroom) >= (padlen + (4 + 4*1))))
+	{
+		if ((headroom < (4 + 4*1)) || (tailroom < padlen))
+		{
+			skb->data = memmove (skb->head + (4 + 4*1),
+								 skb->data, skb->len);
+			skb->tail = skb->data + skb->len;
+		}
+		skb2 = skb;
+	} else {
+		skb2 = skb_copy_expand (skb, (4 + 4*1) , padlen, in_interrupt () ? GFP_ATOMIC : GFP_KERNEL);
+
+		if (!skb2) 
+		{
+			dbg("genelink : skb_copy_expand fail");
+			return 0;
+		}
+
+		// free the original skb
+		dev_kfree_skb_any (skb);
+	}
+
+	return skb2;
+}
+
+#endif
+
+/*-------------------------------------------------------------------------*/
+
 static int usbnet_start_xmit (struct sk_buff *skb, struct net_device *net)
 {
 	struct usbnet		*dev = (struct usbnet *) net->priv;
@@ -1204,6 +1610,16 @@
 		skb = skb2;
 	}
 
+#ifdef CONFIG_USB_GENELINK
+
+	if ((info->flags & FLAG_GENELINK) && (skb = gl_build_skb(skb)) == 0)
+	{
+		dbg("can't build skb for genelink transmit");
+		goto drop;
+	}
+
+#endif
+
 	if (!(urb = usb_alloc_urb (0))) {
 		dbg ("no urb");
 		goto drop;
@@ -1222,7 +1638,31 @@
 		if (!((skb->len + sizeof *trailer) & 0x01))
 			*skb_put (skb, 1) = PAD_BYTE;
 		trailer = (struct nc_trailer *) skb_put (skb, sizeof *trailer);
-	} else if ((length % EP_SIZE (dev)) == 0) {
+	}
+
+#ifdef CONFIG_USB_GENELINK
+
+	  else if (info->flags & FLAG_GENELINK) {
+		u32 *packet_count, *packet_len;
+
+		// attach the packet count to the header
+		packet_count = (u32 *)skb_push(skb, (4 + 4*1));
+		packet_len = packet_count + 1;
+
+		// set packet to 1
+		*packet_count = 1;
+
+		// set packet length
+		*packet_len = length;
+
+		// add padding byte
+		if ((skb->len % EP_SIZE(dev)) == 0)
+			skb_put(skb, 1);
+	}
+
+#endif
+
+	  else if ((length % EP_SIZE (dev)) == 0) {
 			if (skb_shared (skb)) {
 				struct sk_buff *skb2;
 				skb2 = skb_unshare (skb, flags);
@@ -1408,10 +1848,19 @@
 		return 0;
 	}
 
-	if (usb_set_interface (udev, ifnum, altnum) < 0) {
-		err ("set_interface failed");
-		return 0;
+#ifdef CONFIG_USB_GENELINK
+	// genelink device didn't support set interface command
+	// it need to issue set interface command for genelink device
+	if (!((prod->idProduct == 0x0502) && (prod->idVendor == 0x05e3)))
+	{
+#endif
+		if (usb_set_interface (udev, ifnum, altnum) < 0) {
+			err ("set_interface failed");
+			return 0;
+		}
+#ifdef CONFIG_USB_GENELINK
 	}
+#endif
 
 	// set up our own records
 	if (!(dev = kmalloc (sizeof *dev, GFP_KERNEL))) {
@@ -1484,11 +1933,6 @@
 },
 #endif
 
-
-// GeneSys GL620USB (www.genesyslogic.com.tw)
-// (patch exists against an older driver version)
-
-
 #ifdef	CONFIG_USB_LINUXDEV
 /*
  * for example, this can be a host side talk-to-PDA driver.
@@ -1528,6 +1972,13 @@
 },
 #endif
 
+#ifdef	CONFIG_USB_GENELINK
+{
+	USB_DEVICE (0x05e3, 0x0502),	// GL620USB/GL620USB-A
+	driver_info:	(unsigned long) &genelink_info,
+},
+#endif
+
 	{ },		// END
 };
 MODULE_DEVICE_TABLE (usb, products);
@@ -1564,5 +2015,5 @@
 module_exit (usbnet_exit);
 
 MODULE_AUTHOR ("David Brownell <dbrownell@users.sourceforge.net>");
-MODULE_DESCRIPTION ("USB Host-to-Host Link Drivers (Belkin, Linux, NetChip, Prolific, ...)");
+MODULE_DESCRIPTION ("USB Host-to-Host Link Drivers (Belkin, Linux, NetChip, Prolific, Genesys Logic, ...)");
 MODULE_LICENSE("GPL");
--- linux/Documentation/Configure.help.orig	Tue Sep 25 00:08:44 2001
+++ linux/Documentation/Configure.help	Tue Sep 25 00:14:01 2001
@@ -11738,9 +11738,11 @@
 CONFIG_USB_USBNET
   This driver supports network links over USB with USB "Network"
   or "data transfer" cables, often used to network laptops to PCs.
-  Such cables have chips from suppliers such as NetChip and Prolific.
-  Intelligent USB devices could also use this approach to provide
-  Internet access, using standard USB cabling.
+  Such cables have chips from suppliers such as NetChip, Prolific
+  and GeneSys (GeneLink). Intelligent USB devices could also use this
+  approach to provide Internet access, using standard USB cabling.
+  You can find these chips also on some motherboards with USB PC2PC
+  support.
 
   These links will have names like "usb0", "usb1", etc.  They act
   like two-node Ethernets, so you can use 802.1d Ethernet Bridging
