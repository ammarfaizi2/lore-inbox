Return-Path: <linux-kernel-owner+w=401wt.eu-S965135AbXAEJq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965135AbXAEJq4 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 04:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965147AbXAEJq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 04:46:56 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:1689 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965135AbXAEJqz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 04:46:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=ogS9SyQzT/Hy205KJKb0LeojjI8uykmOv6EhR39hkaPNIHYwWbM6cGiim6RDLKTUGcn5Ct+QUT5SfPEGZwbi0f5SjiFmMRPaocXk3kDf5KRfKPXISffKLXCfC21yCNyZ/kLtixD4hZndItv+rYFxBucw79hWlzpe7KnyMwPrSbk=
Date: Fri, 5 Jan 2007 09:44:55 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] lockdep: unbalance at generic_sync_sb_inodes
Message-ID: <20070105094455.GC17863@slug>
References: <20070104220200.ae4e9a46.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070104220200.ae4e9a46.akpm@osdl.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2007 at 10:02:00PM -0800, Andrew Morton wrote:
 
> 	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc3/2.6.20-rc3-mm1/
Hi,

The reiser4-sb_sync_inodes.patch, which goal is to:
"This patch moves spin_lock/spin_unlock down to sync_sb_inodes."
Only really moved the spin_unlock, thus triggering the following
lockdep message:
[   65.267402] =====================================
[   65.267508] [ BUG: bad unlock balance detected! ]
[   65.267563] -------------------------------------
[   65.267619] swapper/0 is trying to release lock (inode_lock) at:
[   65.267751] [<c018f573>] generic_sync_sb_inodes+0xa6/0x2e8
[   65.267853] but there are no more locks to release!
[   65.267908]
[   65.267909] other info that might help us debug this:
[   65.268014] 1 lock held by swapper/0:
[   65.268068]  #0:  (&type->s_umount_key){--..}, at: [<c0174c18>] alloc_super+0xe8/0x1a5
[   65.268330]
[   65.268330] stack backtrace:
[   65.268433]  [<c010390d>] show_trace_log_lvl+0x1a/0x30
[   65.268528]  [<c0103935>] show_trace+0x12/0x14
[   65.268621]  [<c0103a2f>] dump_stack+0x16/0x18
[   65.268714]  [<c013b2a0>] print_unlock_inbalance_bug+0xce/0xd8
[   65.268811]  [<c013b39b>] lock_release_non_nested+0x6f/0x172
[   65.268907]  [<c013b4d2>] lock_release_nested+0x34/0xdc
[   65.269001]  [<c013b5ce>] __lock_release+0x54/0x56
[   65.269095]  [<c013b809>] lock_release+0x46/0x60
[   65.269188]  [<c03e8660>] _spin_unlock+0x16/0x40
[   65.269284]  [<c018f573>] generic_sync_sb_inodes+0xa6/0x2e8
[   65.269379]  [<c018f7d5>] sync_sb_inodes+0x20/0x23
[   65.269472]  [<c018f937>] sync_inodes_sb+0x82/0x8a
[   65.269566]  [<c0174eab>] __fsync_super+0xd/0x84
[   65.269659]  [<c0174f2d>] fsync_super+0xb/0x19
[   65.269753]  [<c017558a>] do_remount_sb+0x30/0xee
[   65.269846]  [<c0175aa2>] get_sb_single+0x66/0x8b
[   65.269940]  [<c01b45c1>] sysfs_get_sb+0x1d/0x2c
[   65.270036]  [<c0175b49>] vfs_kern_mount+0x82/0xfb
[   65.270130]  [<c0175c19>] kern_mount+0x16/0x1d
[   65.270223]  [<c055ddb6>] sysfs_init+0x57/0xad
[   65.270319]  [<c055c8d2>] mnt_init+0xbf/0x13b
[   65.270412]  [<c055c555>] vfs_caches_init+0x97/0xa7
[   65.270506]  [<c0544bd4>] start_kernel+0x1ca/0x261
[   65.270600]  [<00000000>] 0x0
[   65.270691]  =======================

Regards,
Frederik

Signed-off-by: Frederik Deweerdt <frederik.deweerdt@gmail.com>

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index ea054f7..7e84b93 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -306,6 +306,8 @@ int generic_sync_sb_inodes(struct super_
 	const unsigned long start = jiffies;	/* livelock avoidance */
 	int ret = 0;
 
+	spin_lock(&inode_lock);
+
 	if (!wbc->for_kupdate || list_empty(&sb->s_io))
 		list_splice_init(&sb->s_dirty, &sb->s_io);
 
