Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263539AbTLXRed (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 12:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263723AbTLXRed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 12:34:33 -0500
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:18356 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S263539AbTLXRea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 12:34:30 -0500
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] loop.c doesn't fail init gracefully
Date: Wed, 24 Dec 2003 13:26:41 +0100
User-Agent: KMail/1.5
Cc: akpm@osdl.org
MIME-Version: 1.0
Message-Id: <200312241257.06579.blaisorblade_spam@yahoo.it>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_BYY6/d9BbDQtonQ"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_BYY6/d9BbDQtonQ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

THIS PATCH:
loop_init doesn't fail gracefully for two reasons:
1)If initialization of loop driver fails, we have an call to devfs_add("loop") 
without any devfs_remove; I add that.
2) On lwn.net 2.6 kernel docs, Jonathan Corbet says:
"If you are calling add_disk() in your driver initialization routine, you 
should not fail the initialization process after the first call."

So I make loop.c conform to this request by moving add_disk after all memory 
allocations.
CC me on reply as I'm not subscribed, please.
-- 
Paolo Giarrusso, aka Blaisorblade



--Boundary-00=_BYY6/d9BbDQtonQ
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

--Boundary-00=_BYY6/d9BbDQtonQ--


