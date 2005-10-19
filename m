Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932446AbVJSBde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbVJSBde (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 21:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbVJSBde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 21:33:34 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:4 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932441AbVJSBd3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 21:33:29 -0400
Date: Tue, 18 Oct 2005 21:31:01 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: jgarzik@pobox.com
Subject: [patch 2.6.14-rc3] epic100: fix counting of work_done in epic_poll
Message-ID: <10182005213101.12633@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.5
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

work_done is overwritten each time through the rx_action loop in
epic_poll.  This screws-up the NAPI accounting if the loop is executed
more than once.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/net/epic100.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/epic100.c b/drivers/net/epic100.c
--- a/drivers/net/epic100.c
+++ b/drivers/net/epic100.c
@@ -1334,7 +1334,7 @@ static void epic_rx_err(struct net_devic
 static int epic_poll(struct net_device *dev, int *budget)
 {
 	struct epic_private *ep = dev->priv;
-	int work_done, orig_budget;
+	int work_done = 0, orig_budget;
 	long ioaddr = dev->base_addr;
 
 	orig_budget = (*budget > dev->quota) ? dev->quota : *budget;
@@ -1343,7 +1343,7 @@ rx_action:
 
 	epic_tx(dev, ep);
 
-	work_done = epic_rx(dev, *budget);
+	work_done += epic_rx(dev, *budget);
 
 	epic_rx_err(dev, ep);
 
