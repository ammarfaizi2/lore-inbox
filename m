Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbWHaMnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWHaMnE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 08:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWHaMnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 08:43:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35535 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932162AbWHaMnB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 08:43:01 -0400
From: David Howells <dhowells@redhat.com>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] CacheFiles: Handle ENOSPC on create/mkdir better
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 31 Aug 2006 13:42:49 +0100
Message-ID: <15165.1157028169@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Handle ENOSPC on create/mkdir calls to the backing filesystem better.  Rather
than returning it to FS-Cache or FS-Cache returning it to the netfs, it is
converted into ENOBUFS.

This can be reproduced by setting up a very small cache, for example with:

	dd if=/dev/zero of=/root/fakedisc bs=10240 count=1024
	mke2fs -j /root/fakedisc 
	tune2fs -o user_xattr /root/fakedisc 
	mount -o loop /root/fakedisc /var/fscache/
	cachefilesd

And then running a "find" over a few thousand NFS files on an NFS share that's
mounted with "-o fsc".  This will eventually run the cache out of free inodes,
and ENOSPC will be returned by Ext3, yielding a lot of these messages in the
kernel log:

	FS-Cache: error from cache: -28

David
---

 fs/cachefiles/cf-namei.c |    7 ++++++-
 fs/fscache/cookie.c      |    5 ++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/cachefiles/cf-namei.c b/fs/cachefiles/cf-namei.c
index 20db88a..202b89b 100644
--- a/fs/cachefiles/cf-namei.c
+++ b/fs/cachefiles/cf-namei.c
@@ -501,11 +501,13 @@ lookup_again:
 	return 0;
 
 create_error:
+	_debug("create error %d", ret);
 	if (ret == -EIO)
 		cachefiles_io_error(cache, "create/mkdir failed");
 	goto error;
 
 check_error:
+	_debug("check error %d", ret);
 	write_lock(&cache->active_lock);
 	rb_erase(&object->active_node, &cache->active_nodes);
 	write_unlock(&cache->active_lock);
@@ -538,7 +540,10 @@ error_out:
 	current->fsuid = fsuid;
 	current->fsgid = fsgid;
 
-	_leave(" = ret");
+	if (ret == -ENOSPC)
+		ret = -ENOBUFS;
+
+	_leave(" = error %d", -ret);
 	return ret;
 }
 
diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index 9a6ac8b..8528eb7 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -750,7 +750,10 @@ no_cache:
 	ret = -ENOMEDIUM;
 	goto error_cleanup;
 error:
-	printk(KERN_ERR "FS-Cache: error from cache: %d\n", ret);
+	if (ret != -ENOBUFS) {
+		printk(KERN_ERR "FS-Cache: error from cache: %d\n", ret);
+		ret = -ENOBUFS;
+	}
 error_cleanup:
 	if (cookie) {
 		up_write(&cookie->sem);
