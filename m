Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265396AbTAJQZ4>; Fri, 10 Jan 2003 11:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265409AbTAJQZz>; Fri, 10 Jan 2003 11:25:55 -0500
Received: from fwext.dif.dk ([130.227.136.2]:59645 "EHLO DIFPST1A.dif.dk")
	by vger.kernel.org with ESMTP id <S265396AbTAJQZp>;
	Fri, 10 Jan 2003 11:25:45 -0500
Subject: Ethernet frame padding bug in several drivers - patch(es) included
From: Jesper Juhl <jju@dif.dk>
To: linux-kernel@vger.kernel.org
Cc: Donald Becker <becker@scyld.com>, "Bao C. Ha." <bao.ha@srs.gov>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 10 Jan 2003 17:31:32 +0100
Message-Id: <1042216292.9139.2.camel@jju_lnx.backbone.dif.dk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I send this mail once before (about 16 hours ago), but it seems it never
reached the list, so I'm resending it. If you recieve it twice I
appologize.


---[ original mail below ]---

Hi,

First of all, please CC me on replies as I'm not subscribed to the list.

I just read a paper by Ofir Arkin and Josh Anderson from @stake 
(http://www.atstake.com/research/advisories/2003/atstake_etherleak_report.pdf), 
that documents a bug related to incorrect padding of ethernet frames in
many 
Linux (and other OS) device drivers.

Briefly, the problem is that when a frame is less than the minimum
required 
size, the frame *should* be padded with 0 bytes, but is instead padded
with 
kernel memory. This happens since the drivers don't take care to zero
the 
padding of the buffer before transmitting it.
I won't repeat the paper here as it does quite a good job explaining the
issue.

After reading the paper I took a look at the source for my 2.4.20
kernel, and 
saw that the problem was indeed present in many drivers. I then desided
that 
I might as well fix it as anyone else and started on the task.

So far I've only patched 3 drivers (randomly selected), and I would like
to 
get some feedback on the patches before I do the rest of them. I would
like 
to make sure the fix is correct before spending time implementing a
flawed 
fix in all the affected drivers.
The fix is more or less straight from the paper from @stake, so those
people 
should get all the credit. I'm just doing the legwork of actually fixing
up 
the driver files (patches are against vanilla 2.4.20).

If I get positive feedback on these 3 small patches, then I'll go ahead
and do 
the rest of the drivers tomorrow and submit the new patches.

Here are the patches:

patch for drivers/net/3c507.c

--- 3c507.c.orig        2003-01-10 01:51:13.000000000 +0100
+++ 3c507.c     2003-01-10 02:05:30.000000000 +0100
@@ -494,9 +494,16 @@
        struct net_local *lp = (struct net_local *) dev->priv;
        int ioaddr = dev->base_addr;
        unsigned long flags;
-       short length = ETH_ZLEN < skb->len ? skb->len : ETH_ZLEN;
+       short length;
        unsigned char *buf = skb->data;

+       if (skb->len < ETH_ZLEN) {
+               length = ETH_ZLEN;
+               memset(buf + skb->len, 0, length - skb->len);
+       } else {
+               length = skb->len;
+       }
+
        netif_stop_queue (dev);

        spin_lock_irqsave (&lp->lock, flags);


patch for drivers/net/atp.c

--- atp.c.orig  2003-01-10 01:51:13.000000000 +0100
+++ atp.c       2003-01-10 02:03:35.000000000 +0100
@@ -553,7 +553,12 @@
        int length;
        long flags;

-       length = ETH_ZLEN < skb->len ? skb->len : ETH_ZLEN;
+       if (skb->len < ETH_ZLEN) {
+               length = ETH_ZLEN;
+               memset(&skb->data + skb->len, 0, length - skb->len);
+       } else {
+               length = skb->len;
+       }

        netif_stop_queue(dev);


patch for drivers/net/eepro.c

--- eepro.c.orig        2003-01-10 01:51:13.000000000 +0100
+++ eepro.c     2003-01-10 02:17:00.000000000 +0100
@@ -1138,9 +1138,16 @@
        spin_lock_irqsave(&lp->lock, flags);

        {
-               short length = ETH_ZLEN < skb->len ? skb->len :
ETH_ZLEN;
+               short length;
                unsigned char *buf = skb->data;

+               if (skb->len < ETH_ZLEN) {
+                       length = ETH_ZLEN;
+                       memset(buf + skb->len, 0, length - skb->len);
+               } else {
+                       length = skb->len;
+               }
+
                if (hardware_send_packet(dev, buf, length))
                        /* we won't wake queue here because we're out of
space 
*/
                        lp->stats.tx_dropped++;



Best regards,

Jesper Juhl <jju@dif.dk>


