Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030474AbWAXNWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030474AbWAXNWX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 08:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030476AbWAXNWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 08:22:23 -0500
Received: from mail.gmx.net ([213.165.64.21]:31381 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030474AbWAXNWW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 08:22:22 -0500
X-Authenticated: #31060655
Message-ID: <43D6297C.8000900@gmx.net>
Date: Tue, 24 Jan 2006 14:19:56 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.12) Gecko/20050921
X-Accept-Language: de, en
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
Subject: [PATCH] sky2: fix hang on Yukon-EC (0xb6) rev 1
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch for sky2 fixes a hang on Yukon-EC (0xb6) rev 1
where suddenly no more interrupts were delivered.

I don't know the real cause of the hang due to lack of docs,
but the patch has been running stable for a few hours
whereas the unmodified driver will hang after less than
2 minutes.

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/

Signed-off-by: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>

--- linux-2.6.15/drivers/net/sky2.c	2006-01-23 23:41:35.000000000 +0100
+++ linux-2.6.15/drivers/net/sky2.c	2006-01-24 14:12:12.000000000 +0100
@@ -1913,8 +1913,26 @@
 	}
 
 exit_loop:
+	/* Is this really a good idea?
+	 * We clear all IRQs although there may be pending work due to
+	 * - packets arrived since start of this function
+	 * - the (++work_done >= to_do) abort
+	 */
 	sky2_write32(hw, STAT_CTRL, SC_STAT_CLR_IRQ);
 
+	/* Pending resolution of the comment above, at least kick the
+	 * STAT_LEV_TIMER_CTRL timer.
+	 * This fixes my hangs on Yukon-EC (0xb6) rev 1.
+	 * The if clause is there to start the timer only if it has been
+	 * configured correctly and not been disabled via ethtool.
+	 * Maybe it would be sufficient to only restart the timer if
+	 * there is pending work. Without docs, that is hard to say.
+	 */
+	if (sky2_read8(hw, STAT_LEV_TIMER_CTRL) == TIM_START) {
+		sky2_write8(hw, STAT_LEV_TIMER_CTRL, TIM_STOP);
+		sky2_write8(hw, STAT_LEV_TIMER_CTRL, TIM_START);
+	}
+
 	sky2_tx_check(hw, 0, tx_done[0]);
 	sky2_tx_check(hw, 1, tx_done[1]);
 

