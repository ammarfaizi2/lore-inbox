Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751350AbWHRKhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbWHRKhs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 06:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWHRKhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 06:37:48 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:17444 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751350AbWHRKhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 06:37:48 -0400
Subject: Re: [BUG?] possible recursive locking detected (blkdev_open)
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Arjan van de Ven <arjan@linux.intel.com>,
       Neil Brown <neilb@cse.unsw.edu.au>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <200608090757.32006.eike-kernel@sf-tec.de>
References: <200608090757.32006.eike-kernel@sf-tec.de>
Content-Type: text/plain
Date: Fri, 18 Aug 2006 12:35:21 +0200
Message-Id: <1155897321.5696.374.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(partial CC list from commit 663d440eaa496db903cc58be04b9b602ba45e43b)

On Wed, 2006-08-09 at 07:57 +0200, Rolf Eike Beer wrote:
> =============================================
> [ INFO: possible recursive locking detected ]
> ---------------------------------------------
> parted/7929 is trying to acquire lock:
>  (&bdev->bd_mutex){--..}, at: [<c105eb8d>] __blkdev_put+0x1e/0x13c
> 
> but task is already holding lock:
>  (&bdev->bd_mutex){--..}, at: [<c105eec6>] do_open+0x72/0x3a8
> 
> other info that might help us debug this:
> 1 lock held by parted/7929:
>  #0:  (&bdev->bd_mutex){--..}, at: [<c105eec6>] do_open+0x72/0x3a8
> stack backtrace:
>  [<c1003aad>] show_trace_log_lvl+0x58/0x15b
>  [<c100495f>] show_trace+0xd/0x10
>  [<c1004979>] dump_stack+0x17/0x1a
>  [<c102dee5>] __lock_acquire+0x753/0x99c
>  [<c102e3b0>] lock_acquire+0x4a/0x6a
>  [<c1204501>] mutex_lock_nested+0xc8/0x20c
>  [<c105eb8d>] __blkdev_put+0x1e/0x13c
>  [<c105ecc4>] blkdev_put+0xa/0xc
>  [<c105f18a>] do_open+0x336/0x3a8
>  [<c105f21b>] blkdev_open+0x1f/0x4c
>  [<c1057b40>] __dentry_open+0xc7/0x1aa
>  [<c1057c91>] nameidata_to_filp+0x1c/0x2e
>  [<c1057cd1>] do_filp_open+0x2e/0x35
>  [<c1057dd7>] do_sys_open+0x38/0x68
>  [<c1057e33>] sys_open+0x16/0x18
>  [<c1002845>] sysenter_past_esp+0x56/0x8d

OK, I'm having a look here; its all new to me so bear with me.

blkdev_open() calls
  do_open(bdev, ...,BD_MUTEX_NORMAL) and takes
    mutex_lock_nested(&bdev->bd_mutex, BD_MUTEX_NORMAL)
    
then something fails, and we're thrown to:

out_first: where
    if (bdev != bdev->bd_contains)
      blkdev_put(bdev->bd_contains) which is
        __blkdev_put(bdev->bd_contains, BD_MUTEX_NORMAL) which does
          mutex_lock_nested(&bdev->bd_contains->bd_mutex, BD_MUTEX_NORMAL) <--- lockdep trigger

When going to out_first, dbev->bd_contains is either bdev or whole, and
since we take the branch it must be whole. So it seems to me the
following patch would be the right one:

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 fs/block_dev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/fs/block_dev.c
===================================================================
--- linux-2.6.orig/fs/block_dev.c
+++ linux-2.6/fs/block_dev.c
@@ -980,7 +980,7 @@ out_first:
 	bdev->bd_disk = NULL;
 	bdev->bd_inode->i_data.backing_dev_info = &default_backing_dev_info;
 	if (bdev != bdev->bd_contains)
-		blkdev_put(bdev->bd_contains);
+		__blkdev_put(bdev->bd_contains, BD_MUTEX_WHOLE);
 	bdev->bd_contains = NULL;
 	put_disk(disk);
 	module_put(owner);





