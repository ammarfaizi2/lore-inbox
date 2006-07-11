Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751034AbWGKLOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbWGKLOw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 07:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751035AbWGKLOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 07:14:52 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:48772 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751033AbWGKLOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 07:14:51 -0400
Subject: Re: lockdep: bdev->bd_mutex deadlock
From: Arjan van de Ven <arjan@infradead.org>
To: Peter Jones <pjones@redhat.com>
Cc: mingo@elte.hu, linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>
In-Reply-To: <1152287003.14409.2.camel@localhost.localdomain>
References: <1152221477.25480.9.camel@localhost.localdomain>
	 <1152257687.3111.23.camel@laptopd505.fenrus.org>
	 <1152287003.14409.2.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 11 Jul 2006 13:14:46 +0200
Message-Id: <1152616486.3128.34.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-07 at 11:43 -0400, Peter Jones wrote:
> <4> [<c05ebd9d>] mutex_lock+0x21/0x24
> <4> [<c04c4acf>] blkdev_ioctl+0x5dd/0x732
> <4> [<c046323b>] block_ioctl+0x16/0x1b


From: Arjan van de Ven <arjan@linux.intel.com>
Subject: lockdep: annotate the BLKPG_DEL_PARTITION ioctl

The delete partition IOCTL takes the bd_mutex for both the disk and the partition;
these have an obvious hierarchical relationship and this patch annotates this
relationship for lockdep.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
Index: linux-2.6.18-rc1/block/ioctl.c
===================================================================
--- linux-2.6.18-rc1.orig/block/ioctl.c
+++ linux-2.6.18-rc1/block/ioctl.c
@@ -72,7 +72,7 @@ static int blkpg_ioctl(struct block_devi
 			bdevp = bdget_disk(disk, part);
 			if (!bdevp)
 				return -ENOMEM;
-			mutex_lock(&bdevp->bd_mutex);
+			mutex_lock_nested(&bdevp->bd_mutex, BD_MUTEX_PARTITION);
 			if (bdevp->bd_openers) {
 				mutex_unlock(&bdevp->bd_mutex);
 				bdput(bdevp);
@@ -82,7 +82,7 @@ static int blkpg_ioctl(struct block_devi
 			fsync_bdev(bdevp);
 			invalidate_bdev(bdevp, 0);
 
-			mutex_lock(&bdev->bd_mutex);
+			mutex_lock_nested(&bdev->bd_mutex, BD_MUTEX_WHOLE);
 			delete_partition(disk, part);
 			mutex_unlock(&bdev->bd_mutex);
 			mutex_unlock(&bdevp->bd_mutex);


