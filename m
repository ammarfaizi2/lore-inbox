Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265734AbUBBSlz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 13:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265802AbUBBSly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 13:41:54 -0500
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:14512 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S265734AbUBBSlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 13:41:45 -0500
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] loop.c doesn't fail init gracefully
Date: Sun, 1 Feb 2004 20:01:12 +0100
User-Agent: KMail/1.5
Cc: akpm@osdl.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_4zUHAd0DJE7Kfwo"
Message-Id: <200402012001.12911.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_4zUHAd0DJE7Kfwo
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I'm reposting this patch (which was included in 2.6.0-mm1 and then dropped) 
since it is not clear why it was dropped in 2.6.0-mm2 (maybe I'm wrong, maybe 
it was lost/I was not clear); but the bugs are still there (at least in stock 
2.6.1).

THIS PATCH:

loop_init doesn't fail gracefully for two reasons:
1)If initialization of loop driver fails, we have an call to devfs_add("loop") 
without any devfs_remove; I add that.

2) On lwn.net 2.6 kernel docs, Jonathan Corbet says:
"If you are calling add_disk() in your driver initialization routine, you 
should not fail the initialization process after the first call."

Also, if that is not invalid, then we would need to call del_gendisk on 
failure. So the fix I post is the simplest one.

So I make loop.c conform to this request by moving add_disk after all memory 
allocations.

CC me on reply as I'm not subscribed, please.

Thanks for attention.
-- 
Paolo Giarrusso, aka Blaisorblade





--Boundary-00=_4zUHAd0DJE7Kfwo
Content-Type: text/x-diff;
  charset="us-ascii";
  name="B-01-Loop_loadFailed_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="B-01-Loop_loadFailed_fix.patch"

--- ./drivers/block/loop.c.nofix	2003-12-11 19:37:08.000000000 +0100
+++ ./drivers/block/loop.c	2003-12-11 19:46:43.000000000 +0100
@@ -1212,14 +1212,18 @@
 		sprintf(disk->devfs_name, "loop/%d", i);
 		disk->private_data = lo;
 		disk->queue = lo->lo_queue;
-		add_disk(disk);
 	}
+
+	/* We cannot fail after we call this, so another loop!*/
+	for (i = 0; i < max_loop; i++)
+		add_disk(disks[i]);
 	printk(KERN_INFO "loop: loaded (max %d devices)\n", max_loop);
 	return 0;
 
 out_mem4:
 	while (i--)
 		blk_put_queue(loop_dev[i].lo_queue);
+	devfs_remove("loop");
 	i = max_loop;
 out_mem3:
 	while (i--)

--Boundary-00=_4zUHAd0DJE7Kfwo--


