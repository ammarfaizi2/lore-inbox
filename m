Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263099AbUB0SKk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 13:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263100AbUB0SKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 13:10:40 -0500
Received: from oker.escape.de ([194.120.234.254]:28376 "EHLO oker.escape.de")
	by vger.kernel.org with ESMTP id S263099AbUB0SKI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 13:10:08 -0500
To: linux-kernel@vger.kernel.org
Subject: VLAN on Adaptec Starfire/DuraLAN not working
From: Urs Thuermann <urs@isnogud.escape.de>
Date: 27 Feb 2004 19:07:36 +0100
Message-ID: <m24qtcwg47.fsf@isnogud.escape.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've sent this mail to the linux-vlan mailing list already but didn't
get any answer.

I have a problem getting VLAN to work on an Adaptec NIC.  Searching
the VLAN mailing list archive, I couldn't find anything relevant.

I have 3 Linux boxes running Linux 2.4.24, connected by Ethernet with
no problems as far as VLAN is not concerned:

    machine A, IP address 10.0.0.1, NIC: RTL 8139
    machine B, IP address 10.0.0.3, NIC: Intel EEPRO/100
    machine C, IP address 10.0.0.5, NIC: Adaptec Duo64, ANA-62022

I tried to setup a 802.1q VLAN between these machines, by doing the
following:

    modprobe 8021q
    vconfig add eth0 200
    ip addr add dev eth0.200 192.168.0.1/24 brd 192.168.0.255
    ip link set eth0.200 up

on machine A, and likewise with 192.168.0.3 and 192.168.0.5 on
machines B and C.  The output from

    ip addr ls
    ip route ls

looks good and as expected.  I can ping between 192.168.0.1 and
192.168.0.3 without problems, and tcpdump on eth0 shows, that tagged
frames are sent and received.

However, machine C seems to be able to sent on the VLAN interface but
not receive.  When I try to ping from machine C to machine A, I get

    ping -c4 192.168.0.1
    PING 192.168.0.1 (192.168.0.1) 56(84) bytes of data.
    From 192.168.0.5 icmp_seq=1 Destination Host Unreachable
    ...

and tcpdump on machine C shows

    22:13:55.040604 0:0:d1:9d:7b:a8 ff:ff:ff:ff:ff:ff 8100 46: 802.1Q vlan#200 P0 arp who-has 192.168.0.1 tell 192.168.0.5
    22:13:56.039267 0:0:d1:9d:7b:a8 ff:ff:ff:ff:ff:ff 8100 46: 802.1Q vlan#200 P0 arp who-has 192.168.0.1 tell 192.168.0.5
    22:13:57.039277 0:0:d1:9d:7b:a8 ff:ff:ff:ff:ff:ff 8100 46: 802.1Q vlan#200 P0 arp who-has 192.168.0.1 tell 192.168.0.5
    ...

A tcpdump on machine A shows, that the ARP request arrive at machine A
and are answered

    22:13:55.045205 00:00:d1:9d:7b:a8 > ff:ff:ff:ff:ff:ff, ethertype 802.1Q, length 60: vlan 200, p 0, ethertype ARP, arp who-has 192.168.0.1 tell 192.168.0.5
    22:13:55.045306 00:e0:7d:78:e4:21 > 00:00:d1:9d:7b:a8, ethertype 802.1Q, length 46: vlan 200, p 0, ethertype ARP, arp reply 192.168.0.1 is-at 00:e0:7d:78:e4:21
    22:13:56.043827 00:00:d1:9d:7b:a8 > ff:ff:ff:ff:ff:ff, ethertype 802.1Q, length 60: vlan 200, p 0, ethertype ARP, arp who-has 192.168.0.1 tell 192.168.0.5
    22:13:56.043876 00:e0:7d:78:e4:21 > 00:00:d1:9d:7b:a8, ethertype 802.1Q, length 46: vlan 200, p 0, ethertype ARP, arp reply 192.168.0.1 is-at 00:e0:7d:78:e4:21
    22:13:57.043833 00:00:d1:9d:7b:a8 > ff:ff:ff:ff:ff:ff, ethertype 802.1Q, length 60: vlan 200, p 0, ethertype ARP, arp who-has 192.168.0.1 tell 192.168.0.5
    22:13:57.043893 00:e0:7d:78:e4:21 > 00:00:d1:9d:7b:a8, ethertype 802.1Q, length 46: vlan 200, p 0, ethertype ARP, arp reply 192.168.0.1 is-at 00:e0:7d:78:e4:21
    ...

For some reason, machine C does not see the ARP replies.  I have
looked into the driver source linux/drivers/net/starfire.c and learned
that this NIC obviously has a VLAN filter that must be configured with
the VLAN ID, that the NIC should receive.  I patched the driver to
print some more debugging output

--- starfire.c.orig	2003-11-29 23:24:54.000000000 +0100
+++ starfire.c	2004-01-18 15:25:06.000000000 +0100
@@ -1819,8 +1819,12 @@
 	if (np->vlgrp) {
 		int vlan_count = 0;
 		long filter_addr = ioaddr + HashTable + 8;
+		printk("set_rx_mode: vlgrp is %p, vlgrp->vlan_devices is %p\n",
+			np->vlgrp, np->vlgrp->vlan_devices);
 		for (i = 0; i < VLAN_VID_MASK; i++) {
 			if (np->vlgrp->vlan_devices[i]) {
+				printk("set_rx_mode: vlan_devices[%d] = %p\n",
+					i, np->vlgrp->vlan_devices[i]);
 				if (vlan_count >= 32)
 					break;
 				writew(cpu_to_be16(i), filter_addr);


then I loaded the recompiled driver using

    modprobe starfire debug=5

The relevant kernel output from loading the VLAN and starfire modules
and from configuring VLAN on eth0 is

    Jan 18 17:39:48 janus kernel: 802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
    Jan 18 17:39:48 janus kernel: All bugs added by David S. Miller <davem@redhat.com>
    Jan 18 17:39:52 janus kernel: starfire.c:v1.03 7/26/2000  Written by Donald Becker <becker@scyld.com>
    Jan 18 17:39:52 janus kernel:  (unofficial 2.2/2.4 kernel port, version 1.03+LK1.3.9, December 13, 2002)
    Jan 18 17:39:52 janus kernel: 04 90 15 69 00 02 04 90 10 00 01 00 00 00 00 a8
    Jan 18 17:39:52 janus kernel: 7b 9d d1 00 00 09 05 ff ff ff ff ff ff ff ff ff
    Jan 18 17:39:52 janus kernel: eth0: Dropping NETIF_F_SG since no checksum feature.
    Jan 18 17:39:52 janus kernel: eth0: Adaptec Starfire 6915 at 0xf881e000, 00:00:d1:9d:7b:a8, IRQ 19.
    Jan 18 17:39:52 janus kernel: eth0: MII PHY found at address 1, status 0x7809 advertising 0x01e1.
    Jan 18 17:39:52 janus kernel: eth0: scatter-gather and hardware TCP cksumming disabled.
    Jan 18 17:39:52 janus kernel: 04 90 15 69 00 02 04 90 10 00 01 00 00 00 00 a9
    Jan 18 17:39:52 janus kernel: 7b 9d d1 00 00 09 05 ff ff ff ff ff ff ff ff ff
    Jan 18 17:39:52 janus kernel: eth1: Dropping NETIF_F_SG since no checksum feature.
    Jan 18 17:39:52 janus kernel: eth1: Adaptec Starfire 6915 at 0xf89a5000, 00:00:d1:9d:7b:a9, IRQ 16.
    Jan 18 17:39:52 janus kernel: eth1: MII PHY found at address 1, status 0x7809 advertising 0x01e1.
    Jan 18 17:39:52 janus kernel: eth1: scatter-gather and hardware TCP cksumming disabled.
    ...
    Jan 18 17:40:00 janus kernel: eth0: Setting vlgrp to f51a8000
    Jan 18 17:40:00 janus kernel: set_rx_mode: vlgrp is f51a8000, vlgrp->vlan_devices is f51a8004
    Jan 18 17:40:00 janus kernel: eth0: Adding vlanid 200 to vlan filter
    Jan 18 17:40:00 janus kernel: set_rx_mode: vlgrp is f51a8000, vlgrp->vlan_devices is f51a8004
    Jan 18 17:40:00 janus kernel: set_rx_mode: vlan_devices[200] = f5ca1400

So it seems, the dev->vlan_rx_register() and dev->vlan_rx_add_vid()
functions are correctly called and indeed try to set the VLAN filter
of the NIC.  I see kernel output from the drivers interrupt routine
when I ping to 10.0.0.5 (i.e. the non VLAN eth0 interface), which
looks like this

    Jan 18 17:54:20 janus kernel: eth0: Interrupt status 0x00008101.
    Jan 18 17:54:20 janus kernel:   netdev_rx() status of 273 was 0x60110042.
    Jan 18 17:54:20 janus kernel:   netdev_rx() normal Rx pkt length 66, bogus_cnt 255.
    Jan 18 17:54:20 janus kernel:   netdev_rx() status2 of 273 was 0x8000.
    Jan 18 17:54:20 janus kernel: eth0: Tx Consumer index is 30.
    Jan 18 17:54:20 janus kernel: eth0: Interrupt status 0x00000000.
    Jan 18 17:54:20 janus kernel: eth0: exiting interrupt, status=0x00000000.

but no output when I ping to the 192.168.0.5 on the VLAN interface,
although the interrupt routine begin with     

    /* The interrupt handler does all of the Rx thread work and cleans up
       after the Tx thread. */
    static void intr_handler(int irq, void *dev_instance, struct pt_regs *rgs)
    {
            ...
    
            ioaddr = dev->base_addr;
            np = dev->priv;
    
            do {
                    u32 intr_status = readl(ioaddr + IntrClear);
    
                    if (debug > 4)
                            printk(KERN_DEBUG "%s: Interrupt status %#8.8x.\n",
                                   dev->name, intr_status);

and I have loaded the module with debug=5.  So to me it seems, that
the VLAN filter on my Adaptec NIC isn't working or the driver doesn't
set it up right.

I have also observed, that after setting up VLAN on the Adaptec NIC,
it sometimes also can't receive normal, i.e. non VLAN etherframes
anymore.  This is not quite deterministic, sometimes it works,
sometimes not, while there is not a single problem, when I don't use
VLAN.
    
OK, this got somewhat longer than I intended, but I hope the
information can help finding the problem.  Has anyone had success or
similar failure using VLAN with the Adaptec NIC?  Any idea what to do
next?


urs
