Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750892AbWGGHew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbWGGHew (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 03:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750886AbWGGHew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 03:34:52 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:59343 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750887AbWGGHew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 03:34:52 -0400
Subject: Re: lockdep: bdev->bd_mutex deadlock
From: Arjan van de Ven <arjan@infradead.org>
To: Peter Jones <pjones@redhat.com>
Cc: mingo@elte.hu, linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>
In-Reply-To: <1152221477.25480.9.camel@localhost.localdomain>
References: <1152221477.25480.9.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 07 Jul 2006 09:34:47 +0200
Message-Id: <1152257687.3111.23.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> <4> [<c0463f46>] __blkdev_put+0x22/0x123
> <4> [<c0464060>] blkdev_put+0xa/0xc
> <4> [<c04644e2>] do_open+0x313/0x385
> <4> [<c0464759>] blkdev_open+0x1f/0x48

ok this is a missing annotation in the error path

the patch below should fix this, can you verify this?



---
 fs/block_dev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.18-rc1/fs/block_dev.c
===================================================================
--- linux-2.6.18-rc1.orig/fs/block_dev.c
+++ linux-2.6.18-rc1/fs/block_dev.c
@@ -980,7 +980,7 @@ out_first:
 	bdev->bd_disk = NULL;
 	bdev->bd_inode->i_data.backing_dev_info = &default_backing_dev_info;
 	if (bdev != bdev->bd_contains)
-		blkdev_put(bdev->bd_contains);
+		blkdev_put_partition(bdev->bd_contains);
 	bdev->bd_contains = NULL;
 	put_disk(disk);
 	module_put(owner);


