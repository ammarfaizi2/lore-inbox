Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265211AbUH3XMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265211AbUH3XMe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 19:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265230AbUH3XMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 19:12:34 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:51864
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S265211AbUH3XMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 19:12:31 -0400
Date: Mon, 30 Aug 2004 16:11:26 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Brian Somers <brian.somers@sun.com>
Cc: Michael.Waychison@sun.com, linux-kernel@vger.kernel.org
Subject: Re: TG3 doesn't work in kernel 2.4.27 (David S. Miller)
Message-Id: <20040830161126.585a6b62.davem@davemloft.net>
In-Reply-To: <412DC055.4070401@sun.com>
References: <20040816110000.1120.31256.Mailman@lists.us.dell.com>
	<200408162049.FFF09413.8592816B@anet.ne.jp>
	<20040816143824.15238e42.davem@redhat.com>
	<412CD101.4050406@sun.com>
	<20040825120831.55a20c57.davem@redhat.com>
	<412CF0E9.2010903@sun.com>
	<20040825175805.6807014c.davem@redhat.com>
	<412DC055.4070401@sun.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Michael Chan at Broadcom spotted the bug.

Things are totally broken if the switch/hub does not support
autonegotiation.  Checking for the MAC_STATUS_SIGNAL_DET bit
in the tg3 polling timer fixes the problem.

This is probably why it worked for you and doesn't with the
IBM blades as blades are more likely to be connected to
non-autoneg'ing devices.

===== drivers/net/tg3.c 1.199 vs edited =====
--- 1.199/drivers/net/tg3.c	2004-08-18 19:52:35 -07:00
+++ edited/drivers/net/tg3.c	2004-08-30 15:08:07 -07:00
@@ -5602,7 +5602,8 @@
 				need_setup = 1;
 			}
 			if (! netif_carrier_ok(tp->dev) &&
-			    (mac_stat & MAC_STATUS_PCS_SYNCED)) {
+			    (mac_stat & (MAC_STATUS_PCS_SYNCED |
+					 MAC_STATUS_SIGNAL_DET))) {
 				need_setup = 1;
 			}
 			if (need_setup) {
