Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265515AbTFSM5f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 08:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265522AbTFSM4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 08:56:43 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:41435 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S265515AbTFSM4b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 08:56:31 -0400
Date: Thu, 19 Jun 2003 18:41:13 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@digeo.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: [patch 3/3] dentry->d_count fixes
Message-ID: <20030619131113.GL1204@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20030619130943.GI1204@in.ibm.com> <20030619131013.GJ1204@in.ibm.com> <20030619131046.GK1204@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030619131046.GK1204@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




- hpfs_unlink() can race with lockless d_lookup(), as we can have situations
  where d_lookup() has successfully looked-up a dentry and at the sametime
  hpfs_unlink()--->d_drop() has dropped it. Taking the per dentry lock
  before checking the d_count in hpfs_unlink() solves this race condition.


 fs/hpfs/namei.c |    3 +++
 1 files changed, 3 insertions(+)

diff -puN fs/hpfs/namei.c~hpfs-d_count-fix fs/hpfs/namei.c
--- linux-2.5.72-mm2/fs/hpfs/namei.c~hpfs-d_count-fix	2003-06-19 17:46:05.000000000 +0530
+++ linux-2.5.72-mm2-maneesh/fs/hpfs/namei.c	2003-06-19 17:46:19.000000000 +0530
@@ -372,12 +372,15 @@ again:
 		if (rep)
 			goto ret;
 		d_drop(dentry);
+		spin_lock(&dentry->d_lock);
 		if (atomic_read(&dentry->d_count) > 1 ||
 		    permission(inode, MAY_WRITE) ||
 		    get_write_access(inode)) {
+			spin_unlock(&dentry->d_lock);
 			d_rehash(dentry);
 			goto ret;
 		}
+		spin_unlock(&dentry->d_lock);
 		/*printk("HPFS: truncating file before delete.\n");*/
 		newattrs.ia_size = 0;
 		newattrs.ia_valid = ATTR_SIZE | ATTR_CTIME;

_
-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/
