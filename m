Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288969AbSBXAQl>; Sat, 23 Feb 2002 19:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288980AbSBXAQc>; Sat, 23 Feb 2002 19:16:32 -0500
Received: from web21309.mail.yahoo.com ([216.136.173.254]:16818 "HELO
	web21309.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S288969AbSBXAQY>; Sat, 23 Feb 2002 19:16:24 -0500
Message-ID: <20020224001623.1305.qmail@web21309.mail.yahoo.com>
Date: Sun, 24 Feb 2002 11:16:23 +1100 (EST)
From: =?iso-8859-1?q?Mark=20ZZZ=20Smith?= <markzzzsmith@yahoo.com.au>
Subject: [PATCH][RFC] Use pattern match buffers for up to 4 multicast addresses (natsemi.c, against 2.4.17)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Here is another patch against the natsemi.c driver, for the DP83815 chipset (used on the Netgear
FA311/FA312 NICs).

For up to the first four multicast addresses, it uses the pattern matching buffers of the card for
perfect multicast destination address matching, before reverting to the imperfect multicast hash
multicast destination address matching.

I was motivated to create this patch by the discussion on pg 138 of "IPv6 - The New Internet
protocol" 2nd ed, which explains why IPv6 doesn't use broadcasts, and that perfect multicast
destination address matching is better than hash multicast destination address matching.

It seems to work for me, I've tested it using two Linux boxes (each with a Netgear FA312), using
IPv6. 

Any comments, suggestions or criticisms, please CC me directly, as I'm not subscribed to the
mailing list.

Thanks,
Mark.

-----------------------------------------------SOT----------------------------------------
--- linux.2.4.17/drivers/net/natsemi.c  Sat Dec 22 15:38:15 2001
+++ linux.2.4.17.mrs/drivers/net/natsemi.c      Sun Feb 24 09:18:41 2002
@@ -102,6 +102,17 @@
        version 1.0.13:
                * ETHTOOL_[GS]EEPROM support (Tim Hockin)
 
+       version 1.0.13+MRS-PBMCAST:
+               * for up to 4 multicast addresses, use
+               DP83815 pattern matching buffers for
+               perfect multicast DA matching, rather 
+               than imperfect multicast hash DA matching.
+               See "IPv6 - The New Internet Protocol", 2nd ed,
+               pg 138, for explanation as to why perfect
+               multicast pattern matching is better, and why 
+               broadcasts are not used in IPv6.
+               * Mark R. Smith, markzzzsmith@yahoo.com.au
+
        TODO:
        * big endian support with CFG:BEM instead of cpu_to_le32
        * support for an external PHY
@@ -109,8 +120,8 @@
 */
 
 #define DRV_NAME       "natsemi"
-#define DRV_VERSION    "1.07+LK1.0.13"
-#define DRV_RELDATE    "Oct 19, 2001"
+#define DRV_VERSION    "1.07+LK1.0.13+MRS-PBMCAST"
+#define DRV_RELDATE    "Feb 23, 2002"
 
 /* Updated to recommendations in pci-skeleton v2.03. */
 
@@ -539,7 +550,17 @@
 
 enum RxFilterAddr_bits {
        RFCRAddressMask         = 0x3ff,
+       PatternBuf10Count       = 0x6,
+       PatternBuf32Count       = 0x8,
+       PatternBuf0Word0        = 0x280,
+       PatternBuf1Word0        = 0x282,
+       PatternBuf2Word0        = 0x300,
+       PatternBuf3Word0        = 0x302,
        AcceptMulticast         = 0x00200000,
+       AcceptPatternBuf0       = 0x00800000,
+       AcceptPatternBuf1       = 0x01000000,
+       AcceptPatternBuf2       = 0x02000000,
+       AcceptPatternBuf3       = 0x04000000,
        AcceptMyPhys            = 0x08000000,
        AcceptAllPhys           = 0x10000000,
        AcceptAllMulticast      = 0x20000000,
@@ -547,6 +568,8 @@
        RxFilterEnable          = 0x80000000
 };
 
+#define NUMPATTERNBUFS 4 
+
 enum StatsCtrl_bits {
        StatsWarn               = 0x1,
        StatsFreeze             = 0x2,
@@ -653,6 +676,8 @@
 static void set_rx_mode(struct net_device *dev);
 static void __get_stats(struct net_device *dev);
 static struct net_device_stats *get_stats(struct net_device *dev);
+static void __fill_pattern_bufs(struct net_device *dev);
+static void __enable_pattern_bufs(struct net_device *dev, u32 *rx_mode);
 static int netdev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
 static int netdev_set_wol(struct net_device *dev, u32 newval);
 static int netdev_get_wol(struct net_device *dev, u32 *supported, u32 *cur);
@@ -1706,6 +1731,100 @@
        return &np->stats;
 }
 
+/* Fill pattern buffers with multicast destination addresses */
+static void __fill_pattern_bufs(struct net_device *dev)
+{
+        long ioaddr = dev->base_addr;
+        struct dev_mc_list *mclist;
+        int i,j;
+        u32 iobase = 0x0, pcount10 = 0x0, pcount32 = 0x0;
+        u32 rfdr = 0x0;
+        u32 bufioaddr[] = { 
+               PatternBuf0Word0,
+               PatternBuf1Word0,
+               PatternBuf2Word0,
+               PatternBuf3Word0
+       };
+       struct pc {
+               u32 pcount10, pcount32;
+       } pcount[] = {
+               { 0x00000006,0x00000000 },
+               { 0x00000606,0x00000000 },
+               { 0x00000606,0x00000006 },
+               { 0x00000606,0x00000606 }
+       };
+
+       if ( dev->mc_count > NUMPATTERNBUFS ) {
+               printk(KERN_ERR "%s: Too many multicast addresses (%d) for available pattern
buffers (NUMPATTERNBUFS). Not going to load pattern buffers!\n",
dev->name, dev->mc_count);
+               return;
+       }
+
+       /* load up pattern buffers with mcast addresses */
+       /* see pg 61 of DP83815.pdf for pattern match buffer memory layout */
+       for (i=0, mclist = dev->mc_list; i < dev->mc_count; i++,
+               mclist = mclist->next) {
+               iobase = bufioaddr[i];
+
+               if (debug > 2) {
+                       printk(KERN_DEBUG "%s: loading pattern buffer at 0x%x with multicast
address number %d.\n",dev->name,iobase,i+1);
+               }
+               
+               for (j=0; j < ETH_ALEN; j++) {
+                       if (!(j & 1)) { /* maddr bytes 0, 2, 4 */
+                               rfdr = mclist->dmi_addr[j];
+                       } else { /* maddr bytes 1,3,5 */
+                               rfdr |= (mclist->dmi_addr[j] << 8);
+                               writel(iobase + ((j-1) << 1),
+                                       ioaddr + RxFilterAddr);
+                               writel(rfdr, ioaddr + RxFilterData);
+                               if (debug > 3) {
+                                       printk(KERN_DEBUG "%s: wrote 0x%x mcast addr bytes to
pattern buffer address 0x%x.\n",dev->name,rfdr,iobase + ((j-1)<
<1));
+                               }
+                               rfdr = 0x0;
+                       }       
+               }
+       }
+       
+       /* set pattern buffer byte match counts */
+       pcount10 = pcount[dev->mc_count-1].pcount10;
+       pcount32 = pcount[dev->mc_count-1].pcount32;
+       writel(PatternBuf10Count, ioaddr + RxFilterAddr);
+       writel(pcount10, ioaddr + RxFilterData);
+       writel(PatternBuf32Count, ioaddr + RxFilterAddr);
+       writel(pcount32, ioaddr + RxFilterData);
+
+       if (debug > 2) {
+               printk(KERN_DEBUG "%s: loaded %d multicast addresses into pattern
buffers.\n",dev->name,dev->mc_count);
+       }
+
+}
+
+/* Enable pattern buffer matching for the number of pattern buffers */
+/* that were loaded with multicast destination addresses */
+static void __enable_pattern_bufs(struct net_device *dev, u32 *rx_mode)
+{
+       u32 rx_mode_bits[] = {
+               AcceptPatternBuf0,
+               AcceptPatternBuf0 | AcceptPatternBuf1,
+               AcceptPatternBuf0 | AcceptPatternBuf1 | AcceptPatternBuf2,
+               AcceptPatternBuf0 | AcceptPatternBuf1 | AcceptPatternBuf2
+                       | AcceptPatternBuf3
+       };
+
+       if (dev->mc_count > NUMPATTERNBUFS) {
+               printk(KERN_ERR "%s: Don't have that many (%d) pattern buffers to enable! Instead,
I'll accept all multicasts.\n",dev->name,dev->mc_count);
+               *rx_mode |= AcceptAllMulticast;
+               return;
+       }
+
+       *rx_mode |= rx_mode_bits[dev->mc_count - 1];
+
+       if (debug > 2) {
+               printk(KERN_DEBUG "%s: enabled %d pattern buffers.\n",dev->name,dev->mc_count);
+       }
+       
+}
+
 /* The little-endian AUTODIN II ethernet CRC calculations.
    A big-endian version is also available.
    This is slow but compact code.  Do not use this routine for bulk data,
@@ -1771,32 +1890,40 @@
        long ioaddr = dev->base_addr;
        struct netdev_private *np = dev->priv;
        u8 mc_filter[64];                       /* Multicast hash filter */
-       u32 rx_mode;
+       u32 rx_mode = RxFilterEnable | AcceptMyPhys | AcceptBroadcast;
 
        if (dev->flags & IFF_PROMISC) {                 /* Set promiscuous. */
                /* Unconditionally log net taps. */
                printk(KERN_NOTICE "%s: Promiscuous mode enabled.\n", dev->name);
-               rx_mode = RxFilterEnable | AcceptBroadcast 
-                       | AcceptAllMulticast | AcceptAllPhys | AcceptMyPhys;
-       } else if ((dev->mc_count > multicast_filter_limit)
-                          ||  (dev->flags & IFF_ALLMULTI)) {
-               rx_mode = RxFilterEnable | AcceptBroadcast 
-                       | AcceptAllMulticast | AcceptMyPhys;
-       } else {
-               struct dev_mc_list *mclist;
-               int i;
-               memset(mc_filter, 0, sizeof(mc_filter));
-               for (i = 0, mclist = dev->mc_list; mclist && i < dev->mc_count;
-                        i++, mclist = mclist->next) {
-                       set_bit_le(ether_crc_le(ETH_ALEN, mclist->dmi_addr) & 0x1ff,
-                                       mc_filter);
-               }
-               rx_mode = RxFilterEnable | AcceptBroadcast 
-                       | AcceptMulticast | AcceptMyPhys;
-               for (i = 0; i < 64; i += 2) {
-                       writew(HASH_TABLE + i, ioaddr + RxFilterAddr);
-                       writew((mc_filter[i+1]<<8) + mc_filter[i], 
-                               ioaddr + RxFilterData);
+               rx_mode |= AcceptAllMulticast | AcceptAllPhys;
+       } else if (dev->mc_count) {
+               if ((dev->mc_count > multicast_filter_limit)
+                                  ||  (dev->flags & IFF_ALLMULTI)) {
+                       rx_mode |=  AcceptAllMulticast;
+               } else if (dev->mc_count <= NUMPATTERNBUFS) {
+                       if (debug > 1) {
+                               printk(KERN_DEBUG "%s: using pattern buffers for multicast
destination address matching.\n",dev->name);
+                       }
+                       __fill_pattern_bufs(dev);
+                       __enable_pattern_bufs(dev,&rx_mode);
+               } else {
+                       struct dev_mc_list *mclist;
+                       int i;
+                       if (debug > 1) {
+                               printk(KERN_DEBUG "%s: using multicast hash table for multicast
destination address matching.\n",dev->name);
+                       }
+                       memset(mc_filter, 0, sizeof(mc_filter));
+                       for (i = 0, mclist = dev->mc_list; mclist && i < dev->mc_count;
+                                i++, mclist = mclist->next) {
+                               set_bit_le(ether_crc_le(ETH_ALEN, mclist->dmi_addr) & 0x1ff,
+                                               mc_filter);
+                       }
+                       rx_mode |=  AcceptMulticast;
+                       for (i = 0; i < 64; i += 2) {
+                               writew(HASH_TABLE + i, ioaddr + RxFilterAddr);
+                               writew((mc_filter[i+1]<<8) + mc_filter[i], 
+                                       ioaddr + RxFilterData);
+                       }
                }
        }
        writel(rx_mode, ioaddr + RxFilterAddr);
--------------------------------------EOT--------------------------------------------------------





http://movies.yahoo.com.au - Yahoo! Movies
- Vote for your nominees in our online Oscars pool.
