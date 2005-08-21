Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbVHUAYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbVHUAYX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 20:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbVHUAYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 20:24:23 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:34321 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S1750733AbVHUAYX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 20:24:23 -0400
To: Nick Warne <nick@linicks.net>
Cc: mihamina.rakotomandimby@etu.univ-orleans.fr, linux-kernel@vger.kernel.org
Subject: Re: RTL8139, the final patch ?
References: <200508202153.17837.nick@linicks.net>
	<200508202317.46937.nick@linicks.net>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 21 Aug 2005 09:24:04 +0900
In-Reply-To: <200508202317.46937.nick@linicks.net> (Nick Warne's message of "Sat, 20 Aug 2005 23:17:46 +0100")
Message-ID: <87pss8cf2z.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Nick Warne <nick@linicks.net> writes:

> On Saturday 20 August 2005 21:53, you wrote:
>> I have a problem with it:
>> It's about patching, reverting, patching, reverting,...
>> I got lost. That's why I asked for a... "straighter" one :-)
>
>>> But I looked at what he said and found the real problem on my system (after 
>>> all that):
>>> http://www.ussg.iu.edu/hypermail/linux/kernel/0403.1/1537.html
>
>> It's about a configuration option in the kernel?
>> The patch is about adding the option, if i'm right.
>
> No, what happened was on 2.6.2 all was well.  When 2.6.3 came out I got these 
> timeout errors on the NIC's - but using the 2.6.2 8139too.c file in 2.6.3 
> worked.  Mr Hirofumi then took up the challenge and sent me patches.  Slowly 
> he resolved the issue, but the conclusion was it wasn't the code causing it.
>
> It was an option in my BIOS PCI level/edge settings as I posted.  People on 
> laptops get this error, like you, but there is no BIOS option as such... :-/

Yes. Thanks Nick.

Rakotomandimby, can you try attached patch?

It would solve the problem, if the cause is level/edge trigger.
(Actually, patch is just hideing the problem.)

And please send dmesg, lspci -vvvxxx, cat /proc/interrupts, 8259A.pl, mptable.
In some cases, we may be able to add workaround. But we need to find
the cause of problem before it.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=8139too-napi-revert.patch


Disable 8139too NAPI for testing the Leval-Edge trigger problem

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 drivers/net/8139too.c |   37 ++++++++++++++++++++++++++++++-------
 1 files changed, 30 insertions(+), 7 deletions(-)

diff -puN drivers/net/8139too.c~8139too-napi-revert drivers/net/8139too.c
--- linux-2.6.13-rc6/drivers/net/8139too.c~8139too-napi-revert	2005-08-16 03:42:13.000000000 +0900
+++ linux-2.6.13-rc6-hirofumi/drivers/net/8139too.c	2005-08-16 03:52:15.000000000 +0900
@@ -112,7 +112,7 @@
 #include <asm/uaccess.h>
 #include <asm/irq.h>
 
-#define RTL8139_DRIVER_NAME   DRV_NAME " Fast Ethernet driver " DRV_VERSION
+#define RTL8139_DRIVER_NAME   DRV_NAME " Fast Ethernet driver (Disable NAPI) " DRV_VERSION
 #define PFX DRV_NAME ": "
 
 /* Default Message level */
@@ -120,6 +120,7 @@
                                  NETIF_MSG_PROBE  | \
                                  NETIF_MSG_LINK)
 
+//#define ENABLE_NAPI
 
 /* enable PIO instead of MMIO, if CONFIG_8139TOO_PIO is selected */
 #ifdef CONFIG_8139TOO_PIO
@@ -624,7 +625,9 @@ static void rtl8139_tx_timeout (struct n
 static void rtl8139_init_ring (struct net_device *dev);
 static int rtl8139_start_xmit (struct sk_buff *skb,
 			       struct net_device *dev);
+#ifdef ENABLE_NAPI
 static int rtl8139_poll(struct net_device *dev, int *budget);
+#endif
 #ifdef CONFIG_NET_POLL_CONTROLLER
 static void rtl8139_poll_controller(struct net_device *dev);
 #endif
@@ -974,8 +977,10 @@ static int __devinit rtl8139_init_one (s
 	/* The Rtl8139-specific entries in the device structure. */
 	dev->open = rtl8139_open;
 	dev->hard_start_xmit = rtl8139_start_xmit;
+#ifdef ENABLE_NAPI
 	dev->poll = rtl8139_poll;
 	dev->weight = 64;
+#endif
 	dev->stop = rtl8139_close;
 	dev->get_stats = rtl8139_get_stats;
 	dev->set_multicast_list = rtl8139_set_rx_mode;
@@ -2024,8 +2029,11 @@ no_early_rx:
 			dev->last_rx = jiffies;
 			tp->stats.rx_bytes += pkt_size;
 			tp->stats.rx_packets++;
-
+#ifdef ENABLE_NAPI
 			netif_receive_skb (skb);
+#else
+			netif_rx (skb);
+#endif
 		} else {
 			if (net_ratelimit()) 
 				printk (KERN_WARNING
@@ -2103,7 +2111,7 @@ static void rtl8139_weird_interrupt (str
 			dev->name, pci_cmd_status);
 	}
 }
-
+#ifdef ENABLE_NAPI
 static int rtl8139_poll(struct net_device *dev, int *budget)
 {
 	struct rtl8139_private *tp = netdev_priv(dev);
@@ -2137,7 +2145,7 @@ static int rtl8139_poll(struct net_devic
 
 	return !done;
 }
-
+#endif /* !ENABLE_NAPI */
 /* The interrupt handler does all of the Rx thread work and cleans up
    after the Tx thread. */
 static irqreturn_t rtl8139_interrupt (int irq, void *dev_instance,
@@ -2149,8 +2157,14 @@ static irqreturn_t rtl8139_interrupt (in
 	u16 status, ackstat;
 	int link_changed = 0; /* avoid bogus "uninit" warning */
 	int handled = 0;
+#ifndef ENABLE_NAPI
+	int boguscnt = 20;
+#endif
 
 	spin_lock (&tp->lock);
+#ifndef ENABLE_NAPI
+retry:
+#endif
 	status = RTL_R16 (IntrStatus);
 
 	/* shared irq? */
@@ -2162,13 +2176,13 @@ static irqreturn_t rtl8139_interrupt (in
 	/* h/w no longer present (hotplug?) or major error, bail */
 	if (unlikely(status == 0xFFFF)) 
 		goto out;
-
+#ifdef ENABLE_NAPI
 	/* close possible race's with dev_close */
 	if (unlikely(!netif_running(dev))) {
 		RTL_W16 (IntrMask, 0);
 		goto out;
 	}
-
+#endif
 	/* Acknowledge all of the current interrupt sources ASAP, but
 	   an first get an additional status bit from CSCR. */
 	if (unlikely(status & RxUnderrun))
@@ -2178,6 +2192,7 @@ static irqreturn_t rtl8139_interrupt (in
 	if (ackstat)
 		RTL_W16 (IntrStatus, ackstat);
 
+#ifdef ENABLE_NAPI
 	/* Receive packets are processed by poll routine.
 	   If not running start it now. */
 	if (status & RxAckBits){
@@ -2186,7 +2201,10 @@ static irqreturn_t rtl8139_interrupt (in
 			__netif_rx_schedule (dev);
 		}
 	}
-
+#else
+	if (netif_running(dev) && (status & RxAckBits))
+		rtl8139_rx (dev, tp, INT_MAX);
+#endif
 	/* Check uncommon events with one test. */
 	if (unlikely(status & (PCIErr | PCSTimeout | RxUnderrun | RxErr)))
 		rtl8139_weird_interrupt (dev, tp, ioaddr,
@@ -2197,6 +2215,11 @@ static irqreturn_t rtl8139_interrupt (in
 		if (status & TxErr)
 			RTL_W16 (IntrStatus, TxErr);
 	}
+#ifndef ENABLE_NAPI
+	boguscnt--;
+	if (boguscnt > 0)
+		goto retry;
+#endif
  out:
 	spin_unlock (&tp->lock);
 
_

--=-=-=
Content-Type: text/x-perl
Content-Disposition: inline; filename=8259A.pl

#!/usr/bin/perl
#
# 8259A
#

use strict;
use warnings;

use Getopt::Std;

sub outb
{
    my $data = shift;
    my $port = shift;

    open(IO, "> /dev/port") || die "open /dev/port: $!\n";
    sysseek(IO, $port, 0) || die;
    my $x = pack("C", $data);
    syswrite(IO, $x, 1);
    close(IO);
}

sub inb
{
    my $port = shift;
    my $data;

    open(IO, "/dev/port") || die "open /dev/port: $!\n";
    sysseek(IO, $port, 0) || die;
    sysread(IO, $data, 1);
    close(IO);

    return unpack("C", $data);
}

sub set_edge_level
{
    my $irq = shift;
    my $to = shift;
    my $mask = 1 << ($irq & 7);
    my $port = 0x4d0 + ($irq >> 3);
    my $val = inb($port);

    if ($to eq "edge") {
	outb($val & ~$mask, $port);
    } else {
	outb($val | $mask, $port);
    }
    print "irq $irq: -> $to\n";
}

our($opt_e, $opt_l);
getopts('e:l:');

if ($opt_e and ($opt_e < 15)) {
    set_edge_level($opt_e, "edge");
} elsif ($opt_l and ($opt_l < 15)) {
    set_edge_level($opt_l, "level");
}

foreach my $irq (0..15) {
    my $mask = 1 << ($irq & 7);
    my $port = 0x4d0 + ($irq >> 3);
    my $val = inb($port);

    printf "irq %d: %02x, %s\n", $irq, $val, ($val & $mask) ? "level" : "edge";
}

--=-=-=--
