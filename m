Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270134AbRIHQYa>; Sat, 8 Sep 2001 12:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270155AbRIHQYV>; Sat, 8 Sep 2001 12:24:21 -0400
Received: from pat.uio.no ([129.240.130.16]:2539 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S270134AbRIHQYD>;
	Sat, 8 Sep 2001 12:24:03 -0400
MIME-Version: 1.0
Message-ID: <15258.17964.30516.825575@charged.uio.no>
Date: Sat, 8 Sep 2001 18:24:11 +0200
To: Linus Torvalds <torvalds@transmeta.com>
CC: Alan Cox <alan@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
        NFS maillist <nfs@lists.sourceforge.net>
Subject: [PATCH] 2.4.9 Fix 'noac' and 'sync' mount flags
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

The following patch has been requested by people who are interested in
using databases over NFS. Basically they argue that our implementation
of the 'noac' mount flag differs from that of other *NIX in that we
still allow asynchronous writes. As 'noac' is supposed to mean no
attribute caching, caching writes on the client is a violation.

For various reasons, they also argue against adapting the 'O_SYNC'
style behaviour of firing off asynchronous writes, and then using
generic_osync_inode() to sync the data.
Basically they want 'noac' to ensure that only 1 NFS_STABLE write is
going down the wire at any point in time as this is the standard *NIX
behaviour.

After having studied the problem, we've come to the conclusion
therefore that the best solution is the following, in which we simply
use nfs_writepage_sync(). That limits the effective wsize to being <=
PAGE_CACHE_SIZE, but it's the only way of avoiding races.

Incidentally, the patch also fixes a typo in nfs_writepage() in which
I have used the rsize rather than wsize in deciding whether or not to
use asynchronous writes.

Cheers,
  Trond

diff -u --recursive --new-file linux-2.4.9/fs/nfs/inode.c linux-2.4.9-sync/fs/nfs/inode.c
--- linux-2.4.9/fs/nfs/inode.c	Thu Aug 16 18:39:37 2001
+++ linux-2.4.9-sync/fs/nfs/inode.c	Thu Aug 30 09:13:33 2001
@@ -312,6 +312,7 @@
 	if (data->flags & NFS_MOUNT_NOAC) {
 		data->acregmin = data->acregmax = 0;
 		data->acdirmin = data->acdirmax = 0;
+		sb->s_flags |= MS_SYNCHRONOUS;
 	}
 	server->acregmin = data->acregmin*HZ;
 	server->acregmax = data->acregmax*HZ;
diff -u --recursive --new-file linux-2.4.9/fs/nfs/write.c linux-2.4.9-sync/fs/nfs/write.c
--- linux-2.4.9/fs/nfs/write.c	Thu Aug 16 18:39:37 2001
+++ linux-2.4.9-sync/fs/nfs/write.c	Thu Aug 30 09:31:37 2001
@@ -288,7 +288,7 @@
 		goto out;
 do_it:
 	lock_kernel();
-	if (NFS_SERVER(inode)->rsize >= PAGE_CACHE_SIZE) {
+	if (NFS_SERVER(inode)->wsize >= PAGE_CACHE_SIZE && !IS_SYNC(inode)) {
 		err = nfs_writepage_async(NULL, inode, page, 0, offset);
 		if (err >= 0)
 			err = 0;
@@ -1031,7 +1031,7 @@
 	 * If wsize is smaller than page size, update and write
 	 * page synchronously.
 	 */
-	if (NFS_SERVER(inode)->wsize < PAGE_SIZE)
+	if (NFS_SERVER(inode)->wsize < PAGE_CACHE_SIZE || IS_SYNC(inode))
 		return nfs_writepage_sync(file, inode, page, offset, count);
 
 	/*

