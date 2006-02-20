Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932654AbWBTTnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932654AbWBTTnn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 14:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932655AbWBTTnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 14:43:43 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:3172 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S932654AbWBTTnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 14:43:42 -0500
Date: Mon, 20 Feb 2006 14:43:39 -0500
From: Jeff Mahoney <jeffm@suse.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Michael Chan <mchan@broadcom.com>, Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] tg3: netif_carrier_off runs too early; could still be queued when init fails
Message-ID: <20060220194337.GA21719@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.201-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 This patch moves the netif_carrier_off() call from tg3_init_one()->
 tg3_init_link_config() to tg3_open() as is the convention for most
 other network drivers.

 I was getting a panic after a tg3 device failed to initialize due to DMA
 failure. The oops pointed to the link watch queue with spinlock debugging
 enabled. Without spinlock debugging, the Oops didn't occur.

 I suspect that the link event was getting queued but not executed until
 after the DMA test had failed and the device was freed. The link event
 was then operating on freed memory, which could contain anything. With this
 patch applied, the Oops no longer occurs. 

 I believe this to be correct, but since I'm not a network guru, perhaps
 someone who is could comment?

Signed-off-by: Jeff Mahoney <jeffm@suse.com>

diff -ruNpX dontdiff linux-2.6.16-rc4/drivers/net/tg3.c linux-2.6.16-rc4.tg3/drivers/net/tg3.c
--- linux-2.6.16-rc4/drivers/net/tg3.c	2006-02-20 13:52:40.000000000 -0500
+++ linux-2.6.16-rc4.tg3/drivers/net/tg3.c	2006-02-20 13:54:20.000000000 -0500
@@ -6443,6 +6443,8 @@ static int tg3_open(struct net_device *d
 	struct tg3 *tp = netdev_priv(dev);
 	int err;
 
+	netif_carrier_off(tp->dev);
+
 	tg3_full_lock(tp, 0);
 
 	tg3_disable_ints(tp);
@@ -10430,7 +10432,6 @@ static void __devinit tg3_init_link_conf
 	tp->link_config.speed = SPEED_INVALID;
 	tp->link_config.duplex = DUPLEX_INVALID;
 	tp->link_config.autoneg = AUTONEG_ENABLE;
-	netif_carrier_off(tp->dev);
 	tp->link_config.active_speed = SPEED_INVALID;
 	tp->link_config.active_duplex = DUPLEX_INVALID;
 	tp->link_config.phy_is_low_power = 0;
-- 
Jeff Mahoney
SuSE Labs
