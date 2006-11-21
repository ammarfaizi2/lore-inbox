Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030610AbWKUGoS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030610AbWKUGoS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 01:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030628AbWKUGoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 01:44:18 -0500
Received: from tapsys.com ([72.36.178.242]:39876 "EHLO tapsys.com")
	by vger.kernel.org with ESMTP id S1030610AbWKUGoR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 01:44:17 -0500
Message-ID: <4562A006.3070308@madrabbit.org>
Date: Mon, 20 Nov 2006 22:43:18 -0800
From: Ray Lee <ray@madrabbit.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Larry Finger <Larry.Finger@lwfinger.net>,
       LKML <linux-kernel@vger.kernel.org>, Bcm43xx-dev@lists.berlios.de,
       Michael Buesch <mb@bu3sch.de>, John Linville <linville@tuxdriver.com>
Subject: Re: [patch 07/30] bcm43xx: Drain TX status before starting IRQs
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/06, Larry Finger <Larry.Finger@lwfinger.net> wrote:
> The regression turns out to be a locking problem involving bcm43xx,
> wpa_supplicant, and NetworkManager. The exact cause is unknown; however,
> this patch is clearly not the problem. Please
> reinstate it for inclusion in -stable.

This patch is different from the patch that I claim is wrong. The patch that I
think is bad *actually changes locking* (merge error?); it is different than
the -stable patch that was submitted.

Michael et al please read the patch (diff portion) below as if you're seeing
it for the first time. Please note the locking changes introduced.

user:        Michael Buesch <mb@bu3sch.de>
date:        Wed Nov 01 08:15:40 2006 +0500
files:       drivers/net/wireless/bcm43xx/bcm43xx_main.c
description:
[PATCH] bcm43xx: Fix low-traffic netdev watchdog TX timeouts

This fixes a netdev watchdog timeout problem.
The software needs to call netif_tx_disable before running the
hardware calibration code. The problem condition can be shown by the
following timegraph.

|---5secs - ~10 jiffies time---|---|OOPS
^                              ^
last real TX                   periodic work stops netif

At OOPS, the following happens:
The watchdog timer triggers, because the timeout of 5secs
is over. The watchdog first checks for stopped TX.
_Usually_ TX is only stopped from the TX handler to indicate
a full TX queue. But this is different. We need to stop TX here,
regardless of the TX queue state. So the watchdog recognizes
the stopped device and assumes it is stopped due to full
TX queues (Which is a _wrong_ assumption in this case). It then
tests how far the last TX has been in the past. If it's more than
5secs (which is the case for low or no traffic), it will fire
a TX timeout.

Signed-off-by: Michael Buesch <mb@bu3sch.de>
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: John W. Linville <linville@tuxdriver.com>

committer: John W. Linville <linville@laptop.(none)> 1162350940 -0500


diff -r 41ff0150cbadd56e692f148adb1bfd4ca420e3e0 -r
ca97546422bd9a52a7000607d657ca2915f31104
drivers/net/wireless/bcm43xx/bcm43xx_main.c
--- a/drivers/net/wireless/bcm43xx/bcm43xx_main.c       Wed Nov 01 08:15:39
2006 +0500
+++ b/drivers/net/wireless/bcm43xx/bcm43xx_main.c       Wed Nov 01 08:15:40
2006 +0500
@@ -3163,9 +3163,11 @@ static void bcm43xx_periodic_work_handle
 static void bcm43xx_periodic_work_handler(void *d)
 {
        struct bcm43xx_private *bcm = d;
+       struct net_device *net_dev = bcm->net_dev;
        unsigned long flags;
        u32 savedirqs = 0;
        int badness;
+       unsigned long orig_trans_start = 0;

        mutex_lock(&bcm->mutex);
        badness = estimate_periodic_work_badness(bcm->periodic_state);
@@ -3173,7 +3175,18 @@ static void bcm43xx_periodic_work_handle
                /* Periodic work will take a long time, so we want it to
                 * be preemtible.
                 */
-               netif_tx_disable(bcm->net_dev);
+
+               netif_tx_lock_bh(net_dev);
+               /* We must fake a started transmission here, as we are going to
+                * disable TX. If we wouldn't fake a TX, it would be possible to
+                * trigger the netdev watchdog, if the last real TX is already
+                * some time on the past (slightly less than 5secs)
+                */
+               orig_trans_start = net_dev->trans_start;
+               net_dev->trans_start = jiffies;
+               netif_stop_queue(net_dev);
+               netif_tx_unlock_bh(net_dev);
+
                spin_lock_irqsave(&bcm->irq_lock, flags);
                bcm43xx_mac_suspend(bcm);
                if (bcm43xx_using_pio(bcm))
@@ -3198,6 +3211,7 @@ static void bcm43xx_periodic_work_handle
                        bcm43xx_pio_thaw_txqueues(bcm);
                bcm43xx_mac_enable(bcm);
                netif_wake_queue(bcm->net_dev);
+               net_dev->trans_start = orig_trans_start;
        }
        mmiowb();
        spin_unlock_irqrestore(&bcm->irq_lock, flags);

or the patch via gitweb:
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=81e171b95d2d06a64465a1e6ab1e2fb864ea2448

Ray


