Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbVGBKw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVGBKw2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 06:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbVGBKw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 06:52:28 -0400
Received: from smtp15.wanadoo.fr ([193.252.23.84]:47136 "EHLO
	smtp15.wanadoo.fr") by vger.kernel.org with ESMTP id S261154AbVGBKwI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 06:52:08 -0400
X-ME-UUID: 20050702105207306.4AD277000081@mwinf1504.wanadoo.fr
Message-ID: <22391136.1120301527301.JavaMail.www@wwinf1518>
From: Pascal CHAPPERON <pascal.chapperon@wanadoo.fr>
Reply-To: pascal.chapperon@wanadoo.fr
To: Francois Romieu <romieu@fr.zoreil.com>
Subject: Re: sis190
Cc: Juha Laiho <Juha.Laiho@iki.fi>, Andrew Hutchings <info@a-wing.co.uk>,
       linux-kernel@vger.kernel.org, vinay kumar <b4uvin@yahoo.co.in>,
       jgarzik@pobox.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [80.13.96.141]
X-WUM-FROM: |~|
X-WUM-TO: |~|
X-WUM-CC: |~||~||~||~||~|
X-WUM-REPLYTO: |~|
Date: Sat,  2 Jul 2005 12:52:07 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Message du 01/07/05 01:39
> De : "Francois Romieu" <romieu@fr.zoreil.com>
[...]
> 
> There is an updated version at 
> http://www.zoreil.com/~romieu/sis190/20050630-2.6.13-rc1-sis190-test.patch
> 
> It would be nice to know how it behaves wrt preempt (no need to experiment
> with the media management), especially if you can describe the freeze more
> specifically.
> 
> --
> Ueimor
> 
> 
François, it's really incredible! 
A few lines diff, and now the driver is very stable with or 
without preempted kernel...

I'll be very happy if you can tell me where is the trick.

I tried it carefully : console, X11 (without nvidia), X11 (with nvidia),
IRQ sharing between sis190/nvidia, full load : it worked perfectly.

# uname -a
Linux local 2.6.12.1 #2 Thu Jun 23 11:05:57 CEST 2005 x86_64 x86_64 x86_64 GNU/Linux


# modinfo sis190
filename:       /lib/modules/2.6.12.1/kernel/drivers/net/sis190.ko
[...]
vermagic:       2.6.12.1 preempt gcc-3.4


# cat /proc/interrupts
           CPU0
  0:    4403978          XT-PIC  timer
  1:       4594          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  3:          1          XT-PIC  ohci_hcd:usb3
  5:          1          XT-PIC  ohci_hcd:usb4
  7:          7          XT-PIC  ohci_hcd:usb2
  8:          0          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 10:          1          XT-PIC  ehci_hcd:usb1
 11:   18607531          XT-PIC  SiS SI7012, nvidia, eth0
 12:     139167          XT-PIC  i8042
 14:     196392          XT-PIC  ide0
 15:      39224          XT-PIC  ide1
NMI:       2849
LOC:    4403221
ERR:          0
MIS:          0


I executed simultaneously :
- a loop within 2 TX 700MB and 1 RX 700MB
- a loop within /usr/src/linux/make clean;make
- an audio stream
- an openglx demo
- my usual tasks (mozilla, xemacs)

# ifconfig
eth0      Link encap:Ethernet  HWaddr 00:11:2F:E9:42:70
          inet addr:10.169.21.21  Bcast:10.169.23.255  Mask:255.255.252.0
          inet6 addr: fe80::211:2fff:fee9:4270/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:9922052 errors:0 dropped:0 overruns:0 frame:0
          TX packets:17974399 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:8064017712 (7.5 GiB)  TX bytes:23410613404 (21.8 GiB)
          Interrupt:11 Base address:0xdead


The average speed of the transfers was about 10MB/s under full load
without hurting too much CPU resource.

I retried the previous patch in the same conditions : it frooze the
box after a few seconds, not only with X11 (no nvidia), but also
with an audio stream (at the console).

I also retried (last patch) 10Mb/full autoneg off on the r8169 link 
partner (it prevously froze the box) : it worked perfectly.

The TX performances are also improved (r8169 LP):
- 10 full autoneg off : 1,2 MB both directions
- 100 full autoneg off : 11.6MB/s both directions

It still remains a problem in half duplex modes.

Perhaps somebody else want to try the patch with different
link partners (switchs, 10Mb cards, ...)

I can not make other tries before Monday, but i'll take a
look at the media management after...

BTW, can you remove the following printks from the patch ?
The printks in interrupt functions make dmesg unusuable, 
and the stuff in sis190_get_drvinfo triggers a kernel oops
when the module is loaded (null pointer assignment).

# diff -puN sis190-20050630.c sis190.c
--- sis190-20050630.c   2005-07-02 09:07:19.000000000 +0200
+++ sis190.c    2005-07-02 10:49:52.000000000 +0200
@@ -456,8 +456,6 @@ static inline int sis190_try_rx_copy(str
                skb = dev_alloc_skb(pkt_size + NET_IP_ALIGN);
                if (skb) {
                        skb_reserve(skb, NET_IP_ALIGN);
-                       printk(KERN_INFO "sk_buff[0]->tail = %p\n",
-                              sk_buff[0]->tail);
                        eth_copy_and_sum(skb, sk_buff[0]->tail, pkt_size, 0);
                        *sk_buff = skb;
                        sis190_give_to_asic(desc, rx_buf_sz);
@@ -483,15 +481,12 @@ static int sis190_rx_interrupt(struct ne
                u32 status;

                rmb();
-               printk(KERN_INFO "%s: Rx status = %08x\n", dev->name,
-                      desc->status);

                if (desc->status & OWNbit)
                        break;

                status = le32_to_cpu(desc->PSize);

-               printk(KERN_INFO "%s: Rx PSize = %08x\n", dev->name, status);

                if (status & RxCRC) {
                        printk(KERN_INFO "%s: crc error. status = %08x\n",
@@ -638,7 +633,6 @@ static irqreturn_t sis190_interrupt(int

                SIS_W32(IntrStatus, status);

-               printk(KERN_INFO "%s: status = %08x\n", dev->name, status);

                if ((status & LinkChange) && netif_running(dev)) {
                        printk(KERN_INFO "%s: link change\n", dev->name);
@@ -1230,31 +1224,11 @@ static void sis190_get_drvinfo(struct ne
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


Regards
Pascal


