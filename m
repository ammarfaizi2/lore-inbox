Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265668AbTFNLtf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 07:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265669AbTFNLtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 07:49:35 -0400
Received: from ppp-217-133-190-246.cust-adsl.tiscali.it ([217.133.190.246]:934
	"EHLO home.lb.ods.org") by vger.kernel.org with ESMTP
	id S265668AbTFNLtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 07:49:33 -0400
Subject: [PATCH] Fix use-after-free in tun/tap driver
From: Luca Barbieri <lb@lb.ods.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>, vtun@office.satix.net
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1055592155.3810.5.camel@home.lb.ods.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.2 (1.3.2-1) (Preview Release)
Date: 14 Jun 2003 14:02:35 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

unregister_netdevice works asynchronously so freeing the device
structure immediately after calling it is not a good idea.

The memory should instead be freed in the net_device destructor, and the
patch does this.


--- linux-2.5.70/drivers/net/tun.c~	2003-05-27 03:00:39.000000000 +0200
+++ linux-2.5.70/drivers/net/tun.c	2003-06-14 11:27:09.000000000 +0200
@@ -115,6 +115,11 @@ static struct net_device_stats *tun_net_
 	return &tun->stats;
 }
 
+void tun_net_destroy(struct net_device *dev)
+{
+	kfree((char*)dev - offsetof(struct tun_struct, dev));
+}
+
 /* Initialize net device. */
 int tun_net_init(struct net_device *dev)
 {
@@ -127,6 +132,7 @@ int tun_net_init(struct net_device *dev)
 	dev->hard_start_xmit = tun_net_xmit;
 	dev->stop = tun_net_close;
 	dev->get_stats = tun_net_stats;
+	dev->destructor = tun_net_destroy;
 
 	switch (tun->flags & TUN_TYPE_MASK) {
 	case TUN_TUN_DEV:
@@ -551,7 +557,6 @@ static int tun_chr_close(struct inode *i
 	if (!(tun->flags & TUN_PERSIST)) {
 		dev_close(&tun->dev);
 		unregister_netdevice(&tun->dev);
-		kfree(tun);
 	}
 
 	rtnl_unlock();



-- 
Luca Barbieri <lb@lb.ods.org>
