Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964934AbVIKMQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934AbVIKMQE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 08:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964930AbVIKMQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 08:16:04 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:684 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S964934AbVIKMQC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 08:16:02 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: rl@hellgate.ch, Jeff Garzik <jgarzik@pobox.com>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: 2.6.13: "via-rhine + link loss + autoneg off" bug is still not fixed
Date: Sun, 11 Sep 2005 15:15:13 +0300
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200509111515.13986.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a heads-up.

The recipe:
* have via-rhine NIC
* unplug network cable
* reboot box
* force HDX (I do in with ethtool -s if autoneg off duplex half)
* plug cable back
* kernel still thinks that carrier is off despite "ethtool if"
  saying that link is detected.

Why:

...
        if (intr_status & IntrLinkChange)
                rhine_check_media(dev, 0);
...

static void rhine_check_media(struct net_device *dev, unsigned int init_media)
{
        struct rhine_private *rp = netdev_priv(dev);
        void __iomem *ioaddr = rp->base;

        mii_check_media(&rp->mii_if, debug, init_media);
...

unsigned int mii_check_media (struct mii_if_info *mii,
                              unsigned int ok_to_print,
                              unsigned int init_media)
{
        unsigned int old_carrier, new_carrier;
        int advertise, lpa, media, duplex;
        int lpa2 = 0;

        /* if forced media, go no further */
        if (mii->force_media)   <============================ HERE
                return 0; /* duplex did not change */

        /* check current and old link status */
        old_carrier = netif_carrier_ok(mii->dev) ? 1 : 0;
        new_carrier = (unsigned int) mii_link_ok(mii);

        /* if carrier state did not change, this is a "bounce",
         * just exit as everything is already set correctly
         */
        if ((!init_media) && (old_carrier == new_carrier))
                return 0; /* duplex did not change */

        /* no carrier, nothing much to do */
        if (!new_carrier) {
                netif_carrier_off(mii->dev);
                if (ok_to_print)
                        printk(KERN_INFO "%s: link down\n", mii->dev->name);
                return 0; /* duplex did not change */
        }

        /*
         * we have carrier, see who's on the other end
         */
        netif_carrier_on(mii->dev);
...

We can never reach netif_carrier_on if mii->force_media == TRUE!

If I disable that "if(...) return 0;" it works.
Instrumented log:

17:54:20.07751 kern.info: qdisc_restart: start, q->dequeue=c03e86c6 <== noop_dequeue
17:54:21.07736 kern.info: qdisc_restart: start, q->dequeue=c03e86c6
17:54:23.14445 kern.info: rhine_check_media(init_media:0)
17:54:23.14454 kern.info: mii_check_media
17:54:23.14457 kern.info: mii_check_media: mii->force_media == TRUE, bailing DISABLED --vda

Would bail out, but I killed that if, and we proceed:

17:54:23.14462 kern.info: mii_check_media: old_carrier:0 new_carrier:1
17:54:23.14466 kern.info: mii_check_media: netif_carrier_on
17:54:23.14469 kern.info: if: link up, 10Mbps, half-duplex, lpa 0x0000
17:54:23.14474 kern.info: dev_activate(if);
17:54:23.14477 kern.info: dev_activate(): dev->qdisc = dev->qdisc_sleeping
17:54:24.64489 kern.info: pfifo_fast_enqueue returns 0
17:54:24.64496 kern.info: pfifo_fast_dequeue returns a skb
17:54:24.64499 kern.info: pfifo_fast_dequeue returns NULL
17:54:24.64584 kern.info: pfifo_fast_enqueue returns 0
17:54:24.64588 kern.info: qdisc_restart: start, q->dequeue=c03e87b6 <== pfifo_fast_dequeue
17:54:24.64597 kern.info: pfifo_fast_dequeue returns a skb
17:54:24.64601 kern.info: qdisc_restart: skb!=NULL

Patch is not made because I suspect that this isn't a proper fix.
--
vda
