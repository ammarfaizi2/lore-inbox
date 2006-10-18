Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423017AbWJRVo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423017AbWJRVo2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 17:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423015AbWJRVo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 17:44:28 -0400
Received: from twin.jikos.cz ([213.151.79.26]:21956 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1423017AbWJRVo1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 17:44:27 -0400
Date: Wed, 18 Oct 2006 23:44:03 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: Gabriel C <nix.or.die@googlemail.com>, Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc2-mm1
In-Reply-To: <453675A6.9080001@googlemail.com>
Message-ID: <Pine.LNX.4.64.0610182330340.29022@twin.jikos.cz>
References: <20061016230645.fed53c5b.akpm@osdl.org> <453675A6.9080001@googlemail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2006, Gabriel C wrote:

> Me again :) Just found this in my syslog:
> [ 20.540964] VFS: Mounted root (ext3 filesystem) readonly.
> [ 20.541245] Freeing unused kernel memory: 196k freed
> [ 22.114421] EXT3 FS on hda1, internal journal
> [ 22.320373] BUG: warning at fs/inode.c:1389/i_size_write()
> [ 22.320380] [<c0174f14>] i_size_write+0x36/0x57
> [ 22.320391] [<c017c287>] simple_commit_write+0x5b/0x6a
> [ 22.320395] [<c016b0d8>] __page_symlink+0xb4/0x152
> [ 22.320400] [<c016b18c>] page_symlink+0x16/0x19
> [ 22.320404] [<c01cd7f3>] ramfs_symlink+0x41/0xae
> [ 22.320410] [<c016b81d>] permission+0xc7/0xda
> [ 22.320413] [<c016ba6d>] vfs_symlink+0xb4/0x115
> [ 22.320416] [<c016dcc1>] sys_symlinkat+0x74/0xab
> [ 22.320420] [<c016dd07>] sys_symlink+0xf/0x13
> [ 22.320423] [<c0102c62>] sysenter_past_esp+0x5f/0x85
> [ 22.320428] [<c0300033>] xfrm_lookup+0x2a2/0x4b9
> [ 22.320434] =======================

I guess this fixes the warning. Should it be applied? I am not quite sure 
...

[PATCH] VFS: fix i_mutex locking in page_symlink()

The inode->i_mutex should be held every time when calling i_size_write(), 
and the function contains WARN_ON() for that condition. 
page_symlink(), however, does not lock i_mutex. It is perfectly OK, as the 
i_mutex for the directory is held at the time page_symlink() is running, 
so noone is able to change i_size during race condition. However, 
i_size_write() spits out the warning without this patch.

Signed-off-by: Jiri Kosina <jikos@jikos.cz>

--- 

 fs/namei.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 61f99c1..1025973 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2701,17 +2701,22 @@ retry:
 	page = find_or_create_page(mapping, 0, gfp_mask);
 	if (!page)
 		goto fail;
+	mutex_lock(&inode->i_mutex);
 	err = mapping->a_ops->prepare_write(NULL, page, 0, len-1);
 	if (err == AOP_TRUNCATED_PAGE) {
 		page_cache_release(page);
+		mutex_unlock(&inode->i_mutex);
 		goto retry;
 	}
-	if (err)
+	if (err) {
+		mutex_unlock(&inode->i_mutex);
 		goto fail_map;
+	}
 	kaddr = kmap_atomic(page, KM_USER0);
 	memcpy(kaddr, symname, len-1);
 	kunmap_atomic(kaddr, KM_USER0);
 	err = mapping->a_ops->commit_write(NULL, page, 0, len-1);
+	mutex_unlock(&inode->i_mutex);
 	if (err == AOP_TRUNCATED_PAGE) {
 		page_cache_release(page);
 		goto retry;

-- 
Jiri Kosina
