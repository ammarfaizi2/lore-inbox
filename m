Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751856AbWISQUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856AbWISQUZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 12:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751858AbWISQUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 12:20:25 -0400
Received: from pat.uio.no ([129.240.10.4]:42467 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751856AbWISQUX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 12:20:23 -0400
Subject: [GIT] Fix three Oopsable conditions in the 2.6.18-rc7 NFS client
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 19 Sep 2006 12:20:09 -0400
Message-Id: <1158682809.5724.18.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.816, required 12,
	autolearn=disabled, AWL 1.18, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the 'fixes' branch of the repository at

   git pull git://git.linux-nfs.org/pub/linux/nfs-2.6.git fixes

This will update the following files through the appended changesets.

  Cheers,
    Trond

----
 fs/nfs/nfs4proc.c |    6 +++---
 fs/nfs/read.c     |    6 ++++--
 fs/nfs/write.c    |    4 ++--
 3 files changed, 9 insertions(+), 7 deletions(-)

commit 5c2d97cb31fb77981797fec46230ca005b865799
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Sep 18 23:20:35 2006 -0400

    NFS: Fix nfs_page use after free issues in fs/nfs/write.c
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 76723de0cf5b186afe2f329eeef304c321d52bf8
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Fri Sep 15 08:11:51 2006 -0400

    NFSv4: Fix incorrect semaphore release in _nfs4_do_open()
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 7a52411107e1ac8f5be6967936ec237f40a1c7e4
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Fri Sep 15 16:03:45 2006 -0400

    NFS: Fix Oopsable condition in nfs_readpage_sync()
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 153898e..b14145b 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -970,7 +970,7 @@ static int _nfs4_do_open(struct inode *d
 	status = -ENOMEM;
 	opendata = nfs4_opendata_alloc(dentry, sp, flags, sattr);
 	if (opendata == NULL)
-		goto err_put_state_owner;
+		goto err_release_rwsem;
 
 	status = _nfs4_proc_open(opendata);
 	if (status != 0)
@@ -989,11 +989,11 @@ static int _nfs4_do_open(struct inode *d
 	return 0;
 err_opendata_free:
 	nfs4_opendata_free(opendata);
+err_release_rwsem:
+	up_read(&clp->cl_sem);
 err_put_state_owner:
 	nfs4_put_state_owner(sp);
 out_err:
-	/* Note: clp->cl_sem must be released before nfs4_put_open_state()! */
-	up_read(&clp->cl_sem);
 	*res = NULL;
 	return status;
 }
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index 7a9ee00..f0aff82 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -204,9 +204,11 @@ static int nfs_readpage_sync(struct nfs_
 	NFS_I(inode)->cache_validity |= NFS_INO_INVALID_ATIME;
 	spin_unlock(&inode->i_lock);
 
-	nfs_readpage_truncate_uninitialised_page(rdata);
-	if (rdata->res.eof || rdata->res.count == rdata->args.count)
+	if (rdata->res.eof || rdata->res.count == rdata->args.count) {
 		SetPageUptodate(page);
+		if (rdata->res.eof && count != 0)
+			memclear_highpage_flush(page, rdata->args.pgbase, count);
+	}
 	result = 0;
 
 io_error:
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 8ab3cf1..7084ac9 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -590,8 +590,8 @@ static void nfs_cancel_commit_list(struc
 		req = nfs_list_entry(head->next);
 		nfs_list_remove_request(req);
 		nfs_inode_remove_request(req);
-		nfs_clear_page_writeback(req);
 		dec_zone_page_state(req->wb_page, NR_UNSTABLE_NFS);
+		nfs_clear_page_writeback(req);
 	}
 }
 
@@ -1386,8 +1386,8 @@ nfs_commit_list(struct inode *inode, str
 		req = nfs_list_entry(head->next);
 		nfs_list_remove_request(req);
 		nfs_mark_request_commit(req);
-		nfs_clear_page_writeback(req);
 		dec_zone_page_state(req->wb_page, NR_UNSTABLE_NFS);
+		nfs_clear_page_writeback(req);
 	}
 	return -ENOMEM;
 }


