Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261948AbVFQLPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261948AbVFQLPh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 07:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261949AbVFQLPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 07:15:37 -0400
Received: from smtp11.wanadoo.fr ([193.252.22.31]:463 "EHLO smtp11.wanadoo.fr")
	by vger.kernel.org with ESMTP id S261948AbVFQLOV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 07:14:21 -0400
X-ME-UUID: 20050617111409938.E511C1C000B3@mwinf1103.wanadoo.fr
Message-ID: <28331967.1119006849927.JavaMail.www@wwinf1101>
From: Pascal CHAPPERON <pascal.chapperon@wanadoo.fr>
Reply-To: pascal.chapperon@wanadoo.fr
To: Francois Romieu <romieu@fr.zoreil.com>
Subject: Re: sis190
Cc: Andrew Hutchings <info@a-wing.co.uk>, linux-kernel@vger.kernel.org,
       vinay kumar <b4uvin@yahoo.co.in>, jgarzik@pobox.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [80.14.41.65]
X-WUM-FROM: |~|
X-WUM-TO: |~|
X-WUM-CC: |~||~||~||~|
X-WUM-REPLYTO: |~|
Date: Fri, 17 Jun 2005 13:14:09 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Message du 17/06/05 00:36
> De : "Francois Romieu" <romieu@fr.zoreil.com>
> 
> Can you give a try at:
> http://www.fr.zoreil.com/people/francois/misc/20050616-2.6.12-rc-sis190-test.patch
> 
> Please issue a few packets, say 4 to 8, and check your log after an
> ethtool -i eth0. Then wait for the Rx process to get stuck and issue
> the same ethtool command. You can probably lower NUM_RX_DESC to 16 or
> 32 to minimize the output.
> 
> --
> Ueimor
> 
> 

I noticed that you remove NET_IP_ALIGN in sis190_alloc_rx_skb(), 
but not in sis190_try_rx_copy(); though the driver "worked" like
yesterday...


BTW, i had to put the printk about RxdescRing in sis190_interrupt(),
as i had Kernel Oops when in sis190_get_drvinfo().


# diff -puN sis190-20050616.c sis190.c
--- sis190-20050616.c   2005-06-17 11:56:46.000000000 +0200
+++ sis190.c    2005-06-17 12:12:20.000000000 +0200
@@ -76,8 +76,8 @@ static int multicast_filter_limit = 32;
 /* MAC address length */
 #define MAC_ADDR_LEN   6

-#define NUM_TX_DESC    64      /* Number of Tx descriptor registers */
-#define NUM_RX_DESC    64      /* Number of Rx descriptor registers */
+#define NUM_TX_DESC    16      /* Number of Tx descriptor registers */
+#define NUM_RX_DESC    16      /* Number of Rx descriptor registers */
 #define TX_RING_BYTES  (NUM_TX_DESC * sizeof(struct TxDesc))
 #define RX_RING_BYTES  (NUM_RX_DESC * sizeof(struct RxDesc))
 #define RX_BUF_SIZE    1536    /* Rx Buffer size */
@@ -621,6 +621,8 @@ static irqreturn_t sis190_interrupt(int
        void __iomem *ioaddr = tp->mmio_addr;
        int handled = 0;
        int boguscnt;
+       unsigned int i;
+       u32 *u;

        for (boguscnt = max_interrupt_work; boguscnt > 0; boguscnt--) {
                u32 status = SIS_R32(IntrStatus);
@@ -637,7 +639,8 @@ static irqreturn_t sis190_interrupt(int

                SIS_W32(IntrStatus, status);

-               printk(KERN_INFO "%s: status = %08x\n", dev->name, status);
+               if ( status != 0x20000000)
+                 printk(KERN_INFO "%s: status = %08x\n", dev->name, status);

                if ((status & LinkChange) && netif_running(dev)) {
                        printk(KERN_INFO "%s: link change\n", dev->name);
@@ -647,8 +650,29 @@ static irqreturn_t sis190_interrupt(int
                if ((status & (TxQ0Int | RxQInt)) == 0)
                        break;

-               if (status & (RxQInt))
-                       sis190_rx_interrupt(dev, tp, ioaddr);
+               if (status & (RxQInt)) {
+                 if ( tp->cur_rx > 29) {
+                   printk(KERN_INFO "%s: dirty_rx=%ld cur_rx=%ld\n",
+                          dev->name, tp->dirty_rx, tp->cur_rx);
+                   u = (void *) tp->RxDescRing;
+                   printk(KERN_INFO "   PSize    status   addr     size     PSize    status   addr     size\n");
+                   for (i = 0; i < (NUM_RX_DESC / 2); i++) {
+                     printk(KERN_INFO "%02d:%08x %08x %08x %08x %08x %08x %08x %08x\n",
+                            i, u[0], u[1], u[2], u[3], u[4], u[5], u[6], u[7]);
+                     u += 8;
+                   }
+                   printk(KERN_INFO "%s: dirty_tx=%ld cur_tx=%ld\n",
+                          dev->name, tp->dirty_tx, tp->cur_tx);
+                   u = (void *) tp->TxDescRing;
+                   printk(KERN_INFO "   PSize    status   addr     size     PSize    status   addr     size\n");
+                   for (i = 0; i < (NUM_TX_DESC / 2); i++) {
+                     printk(KERN_INFO "%02d %08x %08x %08x %08x %08x %08x %08x %08x\n",
+                            i, u[0], u[1], u[2], u[3], u[4], u[5], u[6], u[7]);
+                     u += 8;
+                   }
+                 }
+                 sis190_rx_interrupt(dev, tp, ioaddr);
+               }

                if (status & (TxQ0Int)) {
                        spin_lock(&tp->lock);
@@ -1233,31 +1257,11 @@ static void sis190_get_drvinfo(struct ne
                               struct ethtool_drvinfo *info)
 {
        struct sis190_private *tp = netdev_priv(dev);
-       unsigned int i;
-       u32 *u;

        strcpy(info->driver, DRV_NAME);
        strcpy(info->version, DRV_VERSION);
        strcpy(info->bus_info, pci_name(tp->pci_dev));

-       printk(KERN_INFO "%s: dirty_rx=%ld cur_rx=%ld\n",
-              dev->name, tp->dirty_rx, tp->cur_rx);
-       u = (void *) tp->RxDescRing;
-       printk(KERN_INFO "   PSize    status   addr     size     PSize    status   addr     size\n");
-       for (i = 0; i < (NUM_RX_DESC / 2); i++) {
-               printk(KERN_INFO "%02d:%08x %08x %08x %08x %08x %08x %08x %08x\n",
-                      i, u[0], u[1], u[2], u[3], u[4], u[5], u[6], u[7]);
-               u += 8;
-       }
-       printk(KERN_INFO "%s: dirty_tx=%ld cur_tx=%ld\n",
-              dev->name, tp->dirty_tx, tp->cur_tx);
-       u = (void *) tp->TxDescRing;
-       printk(KERN_INFO "   PSize    status   addr     size     PSize    status   addr     size\n");
-       for (i = 0; i < (NUM_TX_DESC / 2); i++) {
-               printk(KERN_INFO "%02d %08x %08x %08x %08x %08x %08x %08x %08x\n",
-                      i, u[0], u[1], u[2], u[3], u[4], u[5], u[6], u[7]);
-               u += 8;
-       }
 }

 static struct ethtool_ops sis190_ethtool_ops = {
@@ -1311,6 +1315,7 @@ static int __devinit sis190_init_one(str
        dev->open = sis190_open;
        dev->hard_start_xmit = sis190_start_xmit;
        dev->get_stats = sis190_get_stats;
+       SET_ETHTOOL_OPS(dev, &sis190_ethtool_ops);
        dev->stop = sis190_close;
        dev->tx_timeout = sis190_tx_timeout;
        dev->set_multicast_list = sis190_set_rx_mode;
 



# dmesg
[...]
sis190 Gigabit Ethernet driver 1.2 loaded
ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:04.0 to 64
0000:00:04.0: sis190 at ffffc20000004c00 (IRQ: 11), 00:11:2f:e9:42:70
eth0: Enabling Auto-negotiation.
eth0: status = 22000000
eth0: mii 0x1f = 0000.
eth0: mii lpa = 4501.
eth0: Link on 1000 Mbps Full Duplex mode.
eth0: no IPv6 routers present
eth0: status = 0000000c
eth0: status = 00000040
eth0: Rx status = 40040040
eth0: Rx PSize = 01010040
sk_buff[0]->tail = ffff810013381010
eth0: Rx status = c0000000
[...]
eth0: status = 20000040
eth0: dirty_rx=30 cur_rx=30
   PSize    status   addr     size     PSize    status   addr     size
00:00000000 c0000000 13381010 00000600 00000000 c0000000 13847010 00000600
01:00000000 c0000000 1edcb810 00000600 00000000 c0000000 1b694810 00000600
02:00000000 c0000000 1b697010 00000600 00000000 c0000000 077c4810 00000600
03:00000000 c0000000 07e15010 00000600 00000000 c0000000 06e3e810 00000600
04:00000000 c0000000 1719e810 00000600 00000000 c0000000 1b69b810 00000600
05:00000000 c0000000 1b694010 00000600 00000000 c0000000 07741010 00000600
06:00000000 c0000000 065d8010 00000600 00000000 c0000000 07a84010 00000600
07:010100a6 76040040 13381810 00000600 00000000 c0000000 1f7c1010 00000600
eth0: dirty_tx=36 cur_tx=36
   PSize    status   addr     size     PSize    status   addr     size
00 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
01 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
02 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
03 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
04 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
05 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
06 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
07 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
eth0: Rx status = 76040040
eth0: Rx PSize = 010100a6
sk_buff[0]->tail = ffff810013381810
eth0: Rx status = c0000000
eth0: status = 0000000c
eth0: status = 000000c0
eth0: dirty_rx=31 cur_rx=31
   PSize    status   addr     size     PSize    status   addr     size
00:00000000 c0000000 13381010 00000600 00000000 c0000000 13847010 00000600
01:00000000 c0000000 1edcb810 00000600 00000000 c0000000 1b694810 00000600
02:00000000 c0000000 1b697010 00000600 00000000 c0000000 077c4810 00000600
03:00000000 c0000000 07e15010 00000600 00000000 c0000000 06e3e810 00000600
04:00000000 c0000000 1719e810 00000600 00000000 c0000000 1b69b810 00000600
05:00000000 c0000000 1b694010 00000600 00000000 c0000000 07741010 00000600
06:00000000 c0000000 065d8010 00000600 00000000 c0000000 07a84010 00000600
07:00000000 c0000000 13381810 00000600 010100a6 76040040 1f7c1010 00000600
eth0: dirty_tx=37 cur_tx=37
   PSize    status   addr     size     PSize    status   addr     size
00 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
01 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
02 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
03 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
04 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
05 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
06 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
07 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
eth0: Rx status = 76040040
eth0: Rx PSize = 010100a6
sk_buff[0]->tail = ffff81001f7c1010
eth0: Rx status = c0000000
eth0: status = 0000000c
eth0: status = 0000000c
eth0: status = 0000000c
eth0: status = 2000000c
eth0: status = 2000000c
eth0: status = 2000000c
eth0: status = 2000000c
eth0: status = 2000000c
eth0: status = 2000000c
eth0: status = 2000000c
eth0: status = 2000000c
[...]



No more traces about RxDescRing after that, as
status & (RxQInt) was always 0 in sis190_interrupt().




# ifconfig
eth0      Link encap:Ethernet  HWaddr 00:11:2F:E9:42:70
          inet addr:10.169.21.20  Bcast:10.169.23.255  Mask:255.255.252.0
          inet6 addr: fe80::211:2fff:fee9:4270/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:32 errors:0 dropped:0 overruns:0 frame:0
          TX packets:87 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:4833 (4.7 KiB)  TX bytes:7364 (7.1 KiB)
          Interrupt:11 Base address:0xdead



After that, i made various tries (most of them stupids).


I noticed that whith the default packet size, ping could work 
as long as i wanted.


So i removed the test "if (pkt_size < rx_copybreak) {" in sis190_try_rx_copy().


The driver now works "correctly" (ping, ssh, scp) as long as i want,
but probably not in the way you want...


I don't understand how the Rx packets are managed when  pkt_size is
greater than rx_copybreak...


I also tried to force 10H, 10F, 100H, 100F autoneg off on the other card.
All modes were working, but obviously something was wrong :
- 10H  0,4Mo/s both directions
- 10F  1,2Mo/s  "     "
- 100H   5Mo/s  "     "
- 100F 1,2Mo/s and 0,3Mo/s 

For 100F, sis190 reported "100 Mbps Half Duplex" and the other card 100 Full.

Autoneg on gived 100 Full detected and 5Mo/s both directions...




# diff -puN sis190-20050616.c sis190.c
--- sis190-20050616.c   2005-06-17 11:56:46.000000000 +0200
+++ sis190.c    2005-06-17 12:59:08.000000000 +0200
@@ -450,7 +450,6 @@ static inline int sis190_try_rx_copy(str
 {
        int ret = -1;

-       if (pkt_size < rx_copybreak) {
                struct sk_buff *skb;

                skb = dev_alloc_skb(pkt_size + NET_IP_ALIGN);
@@ -463,7 +462,6 @@ static inline int sis190_try_rx_copy(str
                        sis190_give_to_asic(desc, rx_buf_sz);
                        ret = 0;
                }
-       }
        return ret;
 }

@@ -637,7 +635,8 @@ static irqreturn_t sis190_interrupt(int

                SIS_W32(IntrStatus, status);

-               printk(KERN_INFO "%s: status = %08x\n", dev->name, status);
+               if ( status != 0x20000000)
+                 printk(KERN_INFO "%s: status = %08x\n", dev->name, status);

                if ((status & LinkChange) && netif_running(dev)) {
                        printk(KERN_INFO "%s: link change\n", dev->name);
@@ -647,8 +646,8 @@ static irqreturn_t sis190_interrupt(int
                if ((status & (TxQ0Int | RxQInt)) == 0)
                        break;

-               if (status & (RxQInt))
-                       sis190_rx_interrupt(dev, tp, ioaddr);
+               if (status & (RxQInt))
+                       sis190_rx_interrupt(dev, tp, ioaddr);

                if (status & (TxQ0Int)) {
                        spin_lock(&tp->lock);
@@ -845,7 +844,7 @@ static void sis190_phy_task(void * data)
                val = mdio_read(ioaddr, MII_LPA);
                printk(KERN_INFO "%s: mii lpa = %04x.\n", dev->name, val);
                for (p = reg31; p->ctl; p++) {
-                       if (val & p->val)
+                 if ((val & p->val) == p->val)
                                break;
                }
                if (p->ctl)
@@ -1233,31 +1232,11 @@ static void sis190_get_drvinfo(struct ne
                               struct ethtool_drvinfo *info)
 {
        struct sis190_private *tp = netdev_priv(dev);
-       unsigned int i;
-       u32 *u;

        strcpy(info->driver, DRV_NAME);
        strcpy(info->version, DRV_VERSION);
        strcpy(info->bus_info, pci_name(tp->pci_dev));

-       printk(KERN_INFO "%s: dirty_rx=%ld cur_rx=%ld\n",
-              dev->name, tp->dirty_rx, tp->cur_rx);
-       u = (void *) tp->RxDescRing;
-       printk(KERN_INFO "   PSize    status   addr     size     PSize    status   addr     size\n");
-       for (i = 0; i < (NUM_RX_DESC / 2); i++) {
-               printk(KERN_INFO "%02d:%08x %08x %08x %08x %08x %08x %08x %08x\n",
-                      i, u[0], u[1], u[2], u[3], u[4], u[5], u[6], u[7]);
-               u += 8;
-       }
-       printk(KERN_INFO "%s: dirty_tx=%ld cur_tx=%ld\n",
-              dev->name, tp->dirty_tx, tp->cur_tx);
-       u = (void *) tp->TxDescRing;
-       printk(KERN_INFO "   PSize    status   addr     size     PSize    status   addr     size\n");
-       for (i = 0; i < (NUM_TX_DESC / 2); i++) {
-               printk(KERN_INFO "%02d %08x %08x %08x %08x %08x %08x %08x %08x\n",
-                      i, u[0], u[1], u[2], u[3], u[4], u[5], u[6], u[7]);
-               u += 8;
-       }
 }

 static struct ethtool_ops sis190_ethtool_ops = {
@@ -1311,6 +1290,7 @@ static int __devinit sis190_init_one(str
        dev->open = sis190_open;
        dev->hard_start_xmit = sis190_start_xmit;
        dev->get_stats = sis190_get_stats;
+       SET_ETHTOOL_OPS(dev, &sis190_ethtool_ops);
        dev->stop = sis190_close;
        dev->tx_timeout = sis190_tx_timeout;
        dev->set_multicast_list = sis190_set_rx_mode;



Regards
Pascal

