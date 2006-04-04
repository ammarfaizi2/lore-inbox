Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750892AbWDEAAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbWDEAAk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 20:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbWDEAAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 20:00:39 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:3216 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1750956AbWDEAAf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 20:00:35 -0400
Date: Tue, 4 Apr 2006 16:59:52 -0700
From: gregkh@suse.de
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       clemens@ladisch.de, David Brownell <dbrownell@users.sourceforge.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 04/26] USB: EHCI full speed ISO bugfixes
Message-ID: <20060404235952.GE27049@kroah.com>
References: <20060404235634.696852000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-ehci-full-speed-iso-bugfixes.patch"
In-Reply-To: <20060404235927.GA27049@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch replaces the split ISO raw_mask calculation code in the
iso_stream_init() function that computed incorrect numbers of high
speed transactions for both input and output transfers.

In the output case, it added a superfluous start-split transaction for
all maxmimum packet sizes that are a multiple of 188.

In the input case, it forgot to add complete-split transactions for all
microframes covered by the full speed transaction, and the additional
complete-split transaction needed for the case when full speed data
starts arriving near the end of a microframe.

These changes don't affect the lack of full speed bandwidth, but at
least it removes the MMF errors that the HC raised with some input
streams.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/host/ehci-sched.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- linux-2.6.16.1.orig/drivers/usb/host/ehci-sched.c
+++ linux-2.6.16.1/drivers/usb/host/ehci-sched.c
@@ -707,6 +707,7 @@ iso_stream_init (
 	} else {
 		u32		addr;
 		int		think_time;
+		int		hs_transfers;
 
 		addr = dev->ttport << 24;
 		if (!ehci_is_TDI(ehci)
@@ -719,6 +720,7 @@ iso_stream_init (
 		think_time = dev->tt ? dev->tt->think_time : 0;
 		stream->tt_usecs = NS_TO_US (think_time + usb_calc_bus_time (
 				dev->speed, is_input, 1, maxp));
+		hs_transfers = max (1u, (maxp + 187) / 188);
 		if (is_input) {
 			u32	tmp;
 
@@ -727,12 +729,11 @@ iso_stream_init (
 			stream->usecs = HS_USECS_ISO (1);
 			stream->raw_mask = 1;
 
-			/* pessimistic c-mask */
-			tmp = usb_calc_bus_time (USB_SPEED_FULL, 1, 0, maxp)
-					/ (125 * 1000);
-			stream->raw_mask |= 3 << (tmp + 9);
+			/* c-mask as specified in USB 2.0 11.18.4 3.c */
+			tmp = (1 << (hs_transfers + 2)) - 1;
+			stream->raw_mask |= tmp << (8 + 2);
 		} else
-			stream->raw_mask = smask_out [maxp / 188];
+			stream->raw_mask = smask_out [hs_transfers - 1];
 		bandwidth = stream->usecs + stream->c_usecs;
 		bandwidth /= 1 << (interval + 2);
 

--
