Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030326AbWHDFoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030326AbWHDFoG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 01:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030320AbWHDFn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 01:43:57 -0400
Received: from mail.suse.de ([195.135.220.2]:59620 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030326AbWHDFnn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 01:43:43 -0400
Date: Thu, 3 Aug 2006 22:39:06 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Stephen Hemminger <sch@sch-laptop.localdomain>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 07/23] sky2: NAPI bug
Message-ID: <20060804053906.GH769@kroah.com>
References: <20060804053258.391158155@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="sky2-napi-bug.patch"
In-Reply-To: <20060804053807.GA769@kroah.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Stephen Hemminger <shemminger@osdl.org>

If the sky2 driver decides to defer processing because it's NAPI
packet quota is done, then it won't correctly handle the rest
when it is rescheduled.

Signed-off-by: Stephen Hemminger <sch@sch-laptop.localdomain>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/net/sky2.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- linux-2.6.17.7.orig/drivers/net/sky2.c
+++ linux-2.6.17.7/drivers/net/sky2.c
@@ -2187,9 +2187,6 @@ static int sky2_poll(struct net_device *
 	int work_done = 0;
 	u32 status = sky2_read32(hw, B0_Y2_SP_EISR);
 
-	if (!~status)
-		goto out;
-
 	if (status & Y2_IS_HW_ERR)
 		sky2_hw_intr(hw);
 
@@ -2226,7 +2223,7 @@ static int sky2_poll(struct net_device *
 
 	if (sky2_more_work(hw))
 		return 1;
-out:
+
 	netif_rx_complete(dev0);
 
 	sky2_read32(hw, B0_Y2_SP_LISR);

--
