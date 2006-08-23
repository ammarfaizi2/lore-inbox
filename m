Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964976AbWHWP0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbWHWP0z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 11:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964981AbWHWP0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 11:26:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60039 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964976AbWHWP0y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 11:26:54 -0400
Date: Wed, 23 Aug 2006 11:09:35 -0400 (EDT)
From: Jason Baron <jbaron@redhat.com>
X-X-Sender: jbaron@dhcp83-20.boston.redhat.com
To: neilb@suse.de
cc: akpm@osdl.org, arjan@infradead.org, mingo@redhat.com, axboe@suse.de,
       a.p.zijlstra@chello.nl, linux-kernel@vger.kernel.org
Subject: [PATCH] block_dev.c mutex_lock_nested() fix
Message-ID: <Pine.LNX.4.64.0608231104220.5899@dhcp83-20.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

In the case below we are locking the whole disk not a partition. This 
change simply brings the code in line with the piece above where when we 
are the 'first' opener, and we are a partition.

thanks,

-Jason

Signed-off-by: Jason Baron <jbaron@redhat.com>

--- linux-2.6/fs/block_dev.c.bak
+++ linux-2.6/fs/block_dev.c
@@ -966,7 +966,7 @@ do_open(struct block_device *bdev, struc
 				rescan_partitions(bdev->bd_disk, bdev);
 		} else {
 			mutex_lock_nested(&bdev->bd_contains->bd_mutex,
-					  BD_MUTEX_PARTITION);
+					  BD_MUTEX_WHOLE);
 			bdev->bd_contains->bd_part_count++;
 			mutex_unlock(&bdev->bd_contains->bd_mutex);
 		}
