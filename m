Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261283AbVBFTlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbVBFTlF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 14:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbVBFTlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 14:41:05 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:28373 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261283AbVBFTlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 14:41:01 -0500
Subject: [PATCH] raw1394 : Fix hang on unload
From: Parag Warudkar <kernel-stuff@comcast.net>
To: akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net,
       Jody McIntyre <scjody@modernduck.com>
Content-Type: multipart/mixed; boundary="=-qtZxAWYzLp4skE61MVeh"
Date: Sun, 06 Feb 2005 14:41:15 -0500
Message-Id: <1107718875.4378.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qtZxAWYzLp4skE61MVeh
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I was seeing rmmod getting stuck consistently in D state while removing
raw1394. Looking at raw1394.c:cleanup_raw1394 - the order of doing
things seemed incorrect to me after comparing other places in raw1394.c
which do the same thing but with a different order.

bash          R  running task       0  4319   3884                3900
(NOTLB)
rmmod         D 0000008428792a16     0  4490   3900
(NOTLB)
ffff81001cff9dd8 0000000000000082 0000000000000000 0000000100000000
       0000007400000000 ffff8100211c9070 000000000000097b
ffff81002c8a2800
       ffffffff80397c97 ffff81002b6f9360
Call Trace:<ffffffff80379d25>{__down+421}
<ffffffff80133510>{default_wake_function+0}
       <ffffffff8037cd8c>{__down_failed+53}
<ffffffff801c0e40>{generic_delete_inode+0}
       <ffffffff8029e540>{.text.lock.driver+5}
<ffffffff885a8260>{:raw1394:cleanup_raw1394+16}
       <ffffffff8015eb31>{sys_delete_module+497}
<ffffffff8021a692>{__up_write+514}
       <ffffffff80183efb>{sys_munmap+107} <ffffffff8010ecda>{system_call
+126}

Attached patch fixes the rmmod raw1394 hang. Tested.

Parag

--=-qtZxAWYzLp4skE61MVeh
Content-Disposition: attachment; filename=raw1394.c.patch
Content-Type: text/x-patch; name=raw1394.c.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- drivers/ieee1394/raw1394.c.orig	2005-02-06 14:34:58.000000000 -0500
+++ drivers/ieee1394/raw1394.c	2005-02-06 14:36:18.000000000 -0500
@@ -2758,10 +2758,10 @@
 
 static void __exit cleanup_raw1394(void)
 {
-	hpsb_unregister_protocol(&raw1394_driver);
 	cdev_del(&raw1394_cdev);
         devfs_remove(RAW1394_DEVICE_NAME);
         hpsb_unregister_highlevel(&raw1394_highlevel);
+	hpsb_unregister_protocol(&raw1394_driver);
 }
 
 module_init(init_raw1394);

--=-qtZxAWYzLp4skE61MVeh--

