Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263753AbRFCUjh>; Sun, 3 Jun 2001 16:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263749AbRFCTyi>; Sun, 3 Jun 2001 15:54:38 -0400
Received: from colorfullife.com ([216.156.138.34]:56332 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S263748AbRFCTyZ>;
	Sun, 3 Jun 2001 15:54:25 -0400
Message-ID: <3B1A9558.2DBAECE7@colorfullife.com>
Date: Sun, 03 Jun 2001 21:51:52 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-ac6 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: multicast hash incorrect on big endian archs
Content-Type: multipart/mixed;
 boundary="------------8788A1E78D3711A276170233"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------8788A1E78D3711A276170233
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I noticed that the multicast hash calculations assumed little endian
byte ordering in the winbond-840 driver, and it seems that several other
drivers are also affected:

8139too, epic100, fealnx, pci-skeleton, sis900, starfile, sundance,
via-rhine, yellowfin
perhaps drivers/net/pcmcia/xircom_tulip_cb

I've attached an untested patch.
It's possible that the nic performs another byte swap if configured for
big endian support, but I've never seen a nic that performs byte swaps
on register writes, only on memory reads.

Please cc me, I'm not subscribed to the mailing lists.
--
	Manfred
--------------8788A1E78D3711A276170233
Content-Type: text/plain; charset=us-ascii;
 name="patch-ask"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-ask"

diff -u 2.4/drivers/net/8139too.c build-2.4/drivers/net/8139too.c
--- 2.4/drivers/net/8139too.c	Sat Jun  2 14:19:44 2001
+++ build-2.4/drivers/net/8139too.c	Sun Jun  3 19:46:05 2001
@@ -2248,6 +2248,10 @@
 	return crc;
 }
 
+static void set_bit_32(int offset, u32 * data)
+{
+	data[offset >> 5] |= (1 << (offset & 0x1f));
+}
 
 static void rtl8139_set_rx_mode (struct net_device *dev)
 {
@@ -2283,7 +2287,7 @@
 		mc_filter[1] = mc_filter[0] = 0;
 		for (i = 0, mclist = dev->mc_list; mclist && i < dev->mc_count;
 		     i++, mclist = mclist->next)
-			set_bit (ether_crc (ETH_ALEN, mclist->dmi_addr) >> 26,
+			set_bit_32(ether_crc (ETH_ALEN, mclist->dmi_addr) >> 26,
 				 mc_filter);
 	}
 
diff -u 2.4/drivers/net/epic100.c build-2.4/drivers/net/epic100.c
--- 2.4/drivers/net/epic100.c	Sat May 26 10:06:26 2001
+++ build-2.4/drivers/net/epic100.c	Sun Jun  3 19:48:44 2001
@@ -1305,11 +1305,16 @@
 	return crc;
 }
 
+static void set_bit_16(int offset, u16 *data)
+{
+	data[offset >> 4] |= (1<<(offset & 0xf));
+}
+
 static void set_rx_mode(struct net_device *dev)
 {
 	long ioaddr = dev->base_addr;
 	struct epic_private *ep = dev->priv;
-	unsigned char mc_filter[8];		 /* Multicast hash filter */
+	u16 mc_filter[8];		 /* Multicast hash filter */
 	int i;
 
 	if (dev->flags & IFF_PROMISC) {			/* Set promiscuous. */
@@ -1332,13 +1337,13 @@
 		memset(mc_filter, 0, sizeof(mc_filter));
 		for (i = 0, mclist = dev->mc_list; mclist && i < dev->mc_count;
 			 i++, mclist = mclist->next)
-			set_bit(ether_crc_le(ETH_ALEN, mclist->dmi_addr) & 0x3f,
+			set_bit_16(ether_crc_le(ETH_ALEN, mclist->dmi_addr) & 0x3f,
 					mc_filter);
 	}
 	/* ToDo: perhaps we need to stop the Tx and Rx process here? */
 	if (memcmp(mc_filter, ep->mc_filter, sizeof(mc_filter))) {
 		for (i = 0; i < 4; i++)
-			outw(((u16 *)mc_filter)[i], ioaddr + MC0 + i*4);
+			outw(mc_filter[i], ioaddr + MC0 + i*4);
 		memcpy(ep->mc_filter, mc_filter, sizeof(mc_filter));
 	}
 	return;
diff -u 2.4/drivers/net/fealnx.c build-2.4/drivers/net/fealnx.c
--- 2.4/drivers/net/fealnx.c	Sat May 26 10:06:26 2001
+++ build-2.4/drivers/net/fealnx.c	Sun Jun  3 19:49:45 2001
@@ -1642,6 +1642,10 @@
 	return crc;
 }
 
+static void set_bit_32(int offset, u32 * data)
+{
+	data[offset >> 5] |= (1 << (offset & 0x1f));
+}
 
 static void set_rx_mode(struct net_device *dev)
 {
@@ -1667,7 +1671,7 @@
 		memset(mc_filter, 0, sizeof(mc_filter));
 		for (i = 0, mclist = dev->mc_list; mclist && i < dev->mc_count;
 		     i++, mclist = mclist->next) {
-			set_bit((ether_crc(ETH_ALEN, mclist->dmi_addr) >> 26) ^ 0x3F,
+			set_bit_32((ether_crc(ETH_ALEN, mclist->dmi_addr) >> 26) ^ 0x3F,
 				mc_filter);
 		}
 		rx_mode = AB | AM;
diff -u 2.4/drivers/net/pci-skeleton.c build-2.4/drivers/net/pci-skeleton.c
--- 2.4/drivers/net/pci-skeleton.c	Fri Apr 20 20:54:23 2001
+++ build-2.4/drivers/net/pci-skeleton.c	Sun Jun  3 20:01:52 2001
@@ -1862,6 +1862,10 @@
 	return crc;
 }
 
+static void set_bit_32(int offset, u32 * data)
+{
+	data[offset >> 5] |= (1 << (offset & 0x1f));
+}
 
 static void netdrv_set_rx_mode (struct net_device *dev)
 {
@@ -1896,7 +1900,7 @@
 		mc_filter[1] = mc_filter[0] = 0;
 		for (i = 0, mclist = dev->mc_list; mclist && i < dev->mc_count;
 		     i++, mclist = mclist->next)
-			set_bit (ether_crc (ETH_ALEN, mclist->dmi_addr) >> 26,
+			set_bit_32 (ether_crc (ETH_ALEN, mclist->dmi_addr) >> 26,
 				 mc_filter);
 	}
 
diff -u 2.4/drivers/net/sis900.c build-2.4/drivers/net/sis900.c
--- 2.4/drivers/net/sis900.c	Sat Jun  2 14:19:44 2001
+++ build-2.4/drivers/net/sis900.c	Sun Jun  3 19:51:38 2001
@@ -1870,6 +1870,11 @@
  *	Multicast hash table changes from 128 to 256 bits for 635M/B & 900B0.
  */
 
+static void set_bit_16(int offset, u16 *data)
+{
+	data[offset >> 4] |= (1<<(offset & 0xf));
+}
+
 static void set_rx_mode(struct net_device *net_dev)
 {
 	long ioaddr = net_dev->base_addr;
@@ -1904,7 +1909,7 @@
 		rx_mode = RFAAB;
 		for (i = 0, mclist = net_dev->mc_list; mclist && i < net_dev->mc_count;
 		     i++, mclist = mclist->next)
-			set_bit(sis900_compute_hashtable_index(mclist->dmi_addr, revision),
+			set_bit_16(sis900_compute_hashtable_index(mclist->dmi_addr, revision),
 				mc_filter);
 	}
 
diff -u 2.4/drivers/net/starfire.c build-2.4/drivers/net/starfire.c
--- 2.4/drivers/net/starfire.c	Fri Apr 20 20:54:23 2001
+++ build-2.4/drivers/net/starfire.c	Sun Jun  3 19:53:07 2001
@@ -1185,6 +1185,12 @@
 	return crc;
 }
 
+static void set_bit_16(int offset, u16 *data)
+{
+	data[offset >> 4] |= (1<<(offset & 0xf));
+}
+
+
 static void set_rx_mode(struct net_device *dev)
 {
 	long ioaddr = dev->base_addr;
@@ -1219,12 +1225,12 @@
 	} else {
 		/* Must use a multicast hash table. */
 		long filter_addr;
-		u16 mc_filter[32] __attribute__ ((aligned(sizeof(long))));	/* Multicast hash filter */
+		u16 mc_filter[32];	/* Multicast hash filter */
 
 		memset(mc_filter, 0, sizeof(mc_filter));
 		for (i = 0, mclist = dev->mc_list; mclist && i < dev->mc_count;
 			 i++, mclist = mclist->next) {
-			set_bit(ether_crc_le(ETH_ALEN, mclist->dmi_addr) >> 23, mc_filter);
+			set_bit_16(ether_crc_le(ETH_ALEN, mclist->dmi_addr) >> 23, mc_filter);
 		}
 		/* Clear the perfect filter list. */
 		filter_addr = ioaddr + 0x56000 + 1*16;
diff -u 2.4/drivers/net/sundance.c build-2.4/drivers/net/sundance.c
--- 2.4/drivers/net/sundance.c	Fri Apr 20 20:54:22 2001
+++ build-2.4/drivers/net/sundance.c	Sun Jun  3 19:53:45 2001
@@ -1121,6 +1121,11 @@
 	return crc;
 }
 
+static void set_bit_16(int offset, u16 *data)
+{
+	data[offset >> 4] |= (1<<(offset & 0xf));
+}
+
 static void set_rx_mode(struct net_device *dev)
 {
 	long ioaddr = dev->base_addr;
@@ -1143,7 +1148,7 @@
 		memset(mc_filter, 0, sizeof(mc_filter));
 		for (i = 0, mclist = dev->mc_list; mclist && i < dev->mc_count;
 			 i++, mclist = mclist->next) {
-			set_bit(ether_crc_le(ETH_ALEN, mclist->dmi_addr) & 0x3f,
+			set_bit_16(ether_crc_le(ETH_ALEN, mclist->dmi_addr) & 0x3f,
 					mc_filter);
 		}
 		rx_mode = AcceptBroadcast | AcceptMultiHash | AcceptMyPhys;
diff -u 2.4/drivers/net/via-rhine.c build-2.4/drivers/net/via-rhine.c
--- 2.4/drivers/net/via-rhine.c	Fri Apr 20 20:54:23 2001
+++ build-2.4/drivers/net/via-rhine.c	Sun Jun  3 19:54:28 2001
@@ -1365,6 +1365,11 @@
     return crc;
 }
 
+static void set_bit_32(int offset, u32 * data)
+{
+	data[offset >> 5] |= (1 << (offset & 0x1f));
+}
+
 static void via_rhine_set_rx_mode(struct net_device *dev)
 {
 	struct netdev_private *np = dev->priv;
@@ -1388,7 +1393,7 @@
 		memset(mc_filter, 0, sizeof(mc_filter));
 		for (i = 0, mclist = dev->mc_list; mclist && i < dev->mc_count;
 			 i++, mclist = mclist->next) {
-			set_bit(ether_crc(ETH_ALEN, mclist->dmi_addr) >> 26, mc_filter);
+			set_bit_32(ether_crc(ETH_ALEN, mclist->dmi_addr) >> 26, mc_filter);
 		}
 		writel(mc_filter[0], ioaddr + MulticastFilter0);
 		writel(mc_filter[1], ioaddr + MulticastFilter1);
diff -u 2.4/drivers/net/yellowfin.c build-2.4/drivers/net/yellowfin.c
--- 2.4/drivers/net/yellowfin.c	Sat May 26 10:06:26 2001
+++ build-2.4/drivers/net/yellowfin.c	Sun Jun  3 19:55:38 2001
@@ -1283,6 +1283,10 @@
 	return crc;
 }
 
+static void set_bit_16(int offset, u16 *data)
+{
+	data[offset >> 4] |= (1<<(offset & 0xf));
+}
 
 static void set_rx_mode(struct net_device *dev)
 {
@@ -1309,14 +1313,14 @@
 			/* Due to a bug in the early chip versions, multiple filter
 			   slots must be set for each address. */
 			if (yp->drv_flags & HasMulticastBug) {
-				set_bit((ether_crc_le(3, mclist->dmi_addr) >> 3) & 0x3f,
+				set_bit_16((ether_crc_le(3, mclist->dmi_addr) >> 3) & 0x3f,
 						hash_table);
-				set_bit((ether_crc_le(4, mclist->dmi_addr) >> 3) & 0x3f,
+				set_bit_16((ether_crc_le(4, mclist->dmi_addr) >> 3) & 0x3f,
 						hash_table);
-				set_bit((ether_crc_le(5, mclist->dmi_addr) >> 3) & 0x3f,
+				set_bit_16((ether_crc_le(5, mclist->dmi_addr) >> 3) & 0x3f,
 						hash_table);
 			}
-			set_bit((ether_crc_le(6, mclist->dmi_addr) >> 3) & 0x3f,
+			set_bit_16((ether_crc_le(6, mclist->dmi_addr) >> 3) & 0x3f,
 					hash_table);
 		}
 		/* Copy the hash table to the chip. */

--------------8788A1E78D3711A276170233--


