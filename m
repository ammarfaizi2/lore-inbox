Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265503AbTFSM4c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 08:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265522AbTFSM4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 08:56:31 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:5339 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S265503AbTFSM4D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 08:56:03 -0400
Date: Thu, 19 Jun 2003 18:40:46 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@digeo.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: [patch 2/3] dentry->d_count fixes
Message-ID: <20030619131046.GK1204@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20030619130943.GI1204@in.ibm.com> <20030619131013.GJ1204@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030619131013.GJ1204@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




- nfs_unlink() can race with lockless d_lookup() as d_lookup() can
  successfully lookup a dentry for which nfs_unlink() can assume that no one
  else is using and can go ahead and do nfs_safe_remove() on it. By using
  per dentry lock, it is solved as we d_lookup() will fail the lookup for
  unhashed dentries.


 fs/nfs/dir.c |    3 +++
 1 files changed, 3 insertions(+)

diff -puN fs/nfs/dir.c~nfs_unlink-d_count-fix fs/nfs/dir.c
--- linux-2.5.72-mm2/fs/nfs/dir.c~nfs_unlink-d_count-fix	2003-06-19 17:38:51.000000000 +0530
+++ linux-2.5.72-mm2-maneesh/fs/nfs/dir.c	2003-06-19 17:38:56.000000000 +0530
@@ -1015,7 +1015,9 @@ static int nfs_unlink(struct inode *dir,
 
 	lock_kernel();
 	spin_lock(&dcache_lock);
+	spin_lock(&dentry->d_lock);
 	if (atomic_read(&dentry->d_count) > 1) {
+		spin_unlock(&dentry->d_lock);
 		spin_unlock(&dcache_lock);
 		error = nfs_sillyrename(dir, dentry);
 		unlock_kernel();
@@ -1025,6 +1027,7 @@ static int nfs_unlink(struct inode *dir,
 		__d_drop(dentry);
 		need_rehash = 1;
 	}
+	spin_unlock(&dentry->d_lock);
 	spin_unlock(&dcache_lock);
 	error = nfs_safe_remove(dentry);
 	if (!error)

_
-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/
