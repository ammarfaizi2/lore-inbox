Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262000AbVF0XKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbVF0XKl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 19:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262093AbVF0XIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 19:08:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14265 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262092AbVF0XDM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 19:03:12 -0400
Date: Mon, 27 Jun 2005 15:59:31 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: akpm@osdl.org, "Theodore Ts'o" <tytso@mit.edu>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Justin Forbes <jmforbes@linuxtx.org>,
       Randy Dunlap <rdunlap@xenotime.net>, torvalds@osdl.org,
       Chuck Wolber <chuckw@quantumlinux.com>, alan@lxorguk.ukuu.org.uk,
       Mitch Williams <mitch.a.williams@intel.com>, jgarzik@pobox.com
Subject: [04/07] e1000: fix spinlock bug
Message-ID: <20050627225931.GM9046@shell0.pdx.osdl.net>
References: <20050627224651.GI9046@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050627224651.GI9046@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------


This patch fixes an obvious and nasty bug where we could exit the transmit
routine while holding tx_lock.

Signed-off-by:  Mitch Williams <mitch.a.williams@intel.com>
Signed-off-by:  Chris Wright <chrisw@osdl.org>
---


diff -urpN -X dontdiff linux-2.6.12-clean/drivers/net/e1000/e1000_main.c linux-2.6.12/drivers/net/e1000/e1000_main.c
--- linux-2.6.12-clean/drivers/net/e1000/e1000_main.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12/drivers/net/e1000/e1000_main.c	2005-06-21 10:42:29.000000000 -0700
@@ -2307,6 +2307,7 @@ e1000_xmit_frame(struct sk_buff *skb, st
 	tso = e1000_tso(adapter, skb);
 	if (tso < 0) {
 		dev_kfree_skb_any(skb);
+		spin_unlock_irqrestore(&adapter->tx_lock, flags);
 		return NETDEV_TX_OK;
 	}

