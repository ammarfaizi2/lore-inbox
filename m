Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbWBZCAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbWBZCAh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 21:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWBZCAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 21:00:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:31179 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751165AbWBZCAg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 21:00:36 -0500
Date: Sat, 25 Feb 2006 18:03:53 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
Cc: Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org,
       Ian Kumlien <pomac@vapor.com>, Wolfgang Hoffmann <woho@woho.de>,
       Pavel Volkovitskiy <int@mtx.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert sky2 to 0.13a
Message-ID: <20060225180353.5908c955@localhost.localdomain>
In-Reply-To: <4400FC28.1060705@gmx.net>
References: <4400FC28.1060705@gmx.net>
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of whining, try this.


--- drivers/net/sky2.c.orig	2006-02-25 18:02:10.000000000 -0800
+++ drivers/net/sky2.c	2006-02-25 18:03:13.000000000 -0800
@@ -1895,19 +1895,6 @@
 	u16 hwidx;
 	u16 tx_done[2] = { TX_NO_STATUS, TX_NO_STATUS };
 
-	sky2_write32(hw, STAT_CTRL, SC_STAT_CLR_IRQ);
-
-	/*
-	 * Kick the STAT_LEV_TIMER_CTRL timer.
-	 * This fixes my hangs on Yukon-EC (0xb6) rev 1.
-	 * The if clause is there to start the timer only if it has been
-	 * configured correctly and not been disabled via ethtool.
-	 */
-	if (sky2_read8(hw, STAT_LEV_TIMER_CTRL) == TIM_START) {
-		sky2_write8(hw, STAT_LEV_TIMER_CTRL, TIM_STOP);
-		sky2_write8(hw, STAT_LEV_TIMER_CTRL, TIM_START);
-	}
-
 	hwidx = sky2_read16(hw, STAT_PUT_IDX);
 	BUG_ON(hwidx >= STATUS_RING_SIZE);
 	rmb();
@@ -1995,7 +1982,20 @@
 		sky2_write8(hw, STAT_TX_TIMER_CTRL, TIM_START);
 	}
 
-	if (likely(work_done < to_do)) {
+	sky2_write32(hw, STAT_CTRL, SC_STAT_CLR_IRQ);
+
+	/*
+	 * Kick the STAT_LEV_TIMER_CTRL timer.
+	 * This fixes my hangs on Yukon-EC (0xb6) rev 1.
+	 * The if clause is there to start the timer only if it has been
+	 * configured correctly and not been disabled via ethtool.
+	 */
+	if (sky2_read8(hw, STAT_LEV_TIMER_CTRL) == TIM_START) {
+		sky2_write8(hw, STAT_LEV_TIMER_CTRL, TIM_STOP);
+		sky2_write8(hw, STAT_LEV_TIMER_CTRL, TIM_START);
+	}
+
+	if (sky2_read16(hw, STAT_PUT_IDX) == hw->st_idx) {
 		spin_lock_irq(&hw->hw_lock);
 		__netif_rx_complete(dev0);
 
