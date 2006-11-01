Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945946AbWKAFx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945946AbWKAFx3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946515AbWKAFjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:39:33 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:51345 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946386AbWKAFj3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:39:29 -0500
Message-Id: <20061101053933.470581000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:34:05 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Michael Buesch <mb@bu3sch.de>
Subject: [PATCH 25/61] bcm43xx: fix watchdog timeouts.
Content-Disposition: inline; filename=bcm43xx-fix-watchdog-timeouts.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Michael Buesch <mb@bu3sch.de>

This fixes a netdev watchdog timeout problem.
The problem is caused by a needed netif_tx_disable
in the hardware calibration code and can be shown by the
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
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 drivers/net/wireless/bcm43xx/bcm43xx_main.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- linux-2.6.18.1.orig/drivers/net/wireless/bcm43xx/bcm43xx_main.c
+++ linux-2.6.18.1/drivers/net/wireless/bcm43xx/bcm43xx_main.c
@@ -3165,7 +3165,15 @@ static void bcm43xx_periodic_work_handle
 
 	badness = estimate_periodic_work_badness(bcm->periodic_state);
 	mutex_lock(&bcm->mutex);
+
+	/* We must fake a started transmission here, as we are going to
+	 * disable TX. If we wouldn't fake a TX, it would be possible to
+	 * trigger the netdev watchdog, if the last real TX is already
+	 * some time on the past (slightly less than 5secs)
+	 */
+	bcm->net_dev->trans_start = jiffies;
 	netif_tx_disable(bcm->net_dev);
+
 	spin_lock_irqsave(&bcm->irq_lock, flags);
 	if (badness > BADNESS_LIMIT) {
 		/* Periodic work will take a long time, so we want it to

--
