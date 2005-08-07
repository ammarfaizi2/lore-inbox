Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751791AbVHGNwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791AbVHGNwQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 09:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751796AbVHGNwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 09:52:16 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:35258 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S1751791AbVHGNwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 09:52:15 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Tommy Christensen <tommy.christensen@tpack.net>
Subject: Re: 2.6.11-rc5 and 2.6.12: cannot transmit anything - more info
Date: Sun, 7 Aug 2005 16:51:43 +0300
User-Agent: KMail/1.5.4
Cc: "David S. Miller" <davem@davemloft.net>, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
References: <200508030947.01901.vda@ilport.com.ua> <42F27E6D.2030200@tpack.net>
In-Reply-To: <42F27E6D.2030200@tpack.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508071651.43250.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 August 2005 23:45, Tommy Christensen wrote:
> Denis Vlasenko wrote:
> > Hi,
> > 
> > As reported earlier, sometimes my home box don't want
> > to send anything.
> > 
> > # ip r
> > 1.1.5.5 dev tun0  proto kernel  scope link  src 1.1.5.6
> > 1.1.4.0/24 dev if  proto kernel  scope link  src 1.1.4.6
> > default via 1.1.5.5 dev tun0
> > # ping 1.1.4.1 -i 0.01
> 
> > 2005-08-02_19:12:18.19551 kern.info: qdisc_restart: start, q->dequeue=c03e8662
> > 2005-08-02_19:12:19.19536 kern.info: qdisc_restart: start, q->dequeue=c03e8662
> > 
> > System.map:
> > c03e8662 t noop_dequeue
> > 
> > I guess this explains why I do not see calls to pfifo_fast_dequeue! :)
> > But how come my interface is using noop queue, is a mystery to me.
> 
> Because link is down.  Or at least the kernel thinks so.
> 
> > # ip l
> > 1: if: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 1000
> >     link/ether 00:0a:e6:7c:dd:79 brd ff:ff:ff:ff:ff:ff
> > 2: lo: <LOOPBACK,UP> mtu 16436 qdisc noqueue
> >     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
> > 17: tun0: <POINTOPOINT,MULTICAST,NOARP,UP> mtu 1464 qdisc pfifo_fast qlen 100
> >     link/[65534]
> > 
> > As you can see, ip l reports that iface 'if' uses pfifo_fast, not noop...
> 
> Yeah, a bit confusing.  pfifo_fast is the *configured* qdisc, but in this
> case it is not the *active* qdisc.  The qdisc is set to noop when carrier
> is lost.
> 
> > Any ideas?
> 
> Try tracking the calls to netif_carrier_on/off.

Your analysis is correct. I just caught it again. diff between logs:

/* Basic mode status register. */
#define BMSR_ERCAP              0x0001  /* Ext-reg capability          */
#define BMSR_JCD                0x0002  /* Jabber detected             */
#define BMSR_LSTATUS            0x0004  /* Link status                 */
#define BMSR_ANEGCAPABLE        0x0008  /* Able to do auto-negotiation */
#define BMSR_RFAULT             0x0010  /* Remote fault detected       */
#define BMSR_ANEGCOMPLETE       0x0020  /* Auto-negotiation complete   */
#define BMSR_RESV               0x07c0  /* Unused...                   */
#define BMSR_10HALF             0x0800  /* Can do 10mbps, half-duplex  */
#define BMSR_10FULL             0x1000  /* Can do 10mbps, full-duplex  */
#define BMSR_100HALF            0x2000  /* Can do 100mbps, half-duplex */
#define BMSR_100FULL            0x4000  /* Can do 100mbps, full-duplex */
#define BMSR_100BASE4           0x8000  /* Can do 100mbps, 4k packets  */

9 = 1001 - link down
D = 1101 - link up

--- klog        Sun Aug  7 14:21:20 2005
+++ klog2       Sun Aug  7 14:21:29 2005
@@ -125,7 +125,7 @@
 kern.warn: PCI: setting IRQ 11 as level-triggered
 kern.info: ACPI: PCI Interrupt 0000:00:12.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
 kern.info: eth0: VIA Rhine II at 0x1e800, 00:0a:e6:7c:dd:79, IRQ 11.
-kern.info: eth0: MII PHY found at address 1, status 0x7849 advertising 05e1 Link 0000.
+kern.info: eth0: MII PHY found at address 1, status 0x784d advertising 05e1 Link 0000.
                                                     ^^^^^^
	Here. It thinks that link is down.
	I will run ethtool next time...

 kern.warn: cs89x0:cs89x0_probe(0x0)
 kern.warn: PP_addr=0xffff
 kern.err: eth1: incorrect signature 0xffff
@@ -287,13 +287,27 @@
 kern.info: ACPI: PCI Interrupt 0000:00:11.5[C] -> Link [LNKC] -> GSI 10 (level, low) -> IRQ 10
 kern.debug: PCI: Setting latency timer of device 0000:00:11.5 to 64
 kern.warn: netdev tun0: qdisc = pfifo_fast_qdisc
-kern.warn: qdisc_restart: start, q->dequeue=c03e8662
-kern.warn: qdisc_restart: start, q->dequeue=c03e8662
-kern.warn: qdisc_restart: start, q->dequeue=c03e8662 <== noop
+kern.warn: pfifo_fast_enqueue returns 0
+kern.warn: qdisc_restart: start, q->dequeue=c03e8752 <== pfifo_fast
+kern.warn: pfifo_fast_dequeue returns a skb
+kern.warn: qdisc_restart: skb!=NULL
+kern.warn: qdisc_restart: start, q->dequeue=c03e8752
+kern.warn: pfifo_fast_dequeue returns NULL
+kern.warn: pfifo_fast_enqueue returns 0
+kern.warn: qdisc_restart: start, q->dequeue=c03e8752
+kern.warn: pfifo_fast_dequeue returns a skb
+kern.warn: qdisc_restart: skb!=NULL
+kern.warn: qdisc_restart: start, q->dequeue=c03e8752
+kern.warn: pfifo_fast_dequeue returns NULL
 kern.warn: pfifo_fast_enqueue returns 0
 kern.warn: pfifo_fast_dequeue returns a skb
 kern.warn: pfifo_fast_dequeue returns NULL
-kern.warn: qdisc_restart: start, q->dequeue=c03e8662
+kern.warn: pfifo_fast_enqueue returns 0
+kern.warn: qdisc_restart: start, q->dequeue=c03e8752
+kern.warn: pfifo_fast_dequeue returns a skb
+kern.warn: qdisc_restart: skb!=NULL
+kern.warn: qdisc_restart: start, q->dequeue=c03e8752
+kern.warn: pfifo_fast_dequeue returns NULL
 kern.info: usbcore: registered new driver usbfs
...
--
vda

