Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbTEDQyP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 12:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbTEDQyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 12:54:15 -0400
Received: from pat.uio.no ([129.240.130.16]:4264 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261163AbTEDQyN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 12:54:13 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16053.18588.804576.739631@charged.uio.no>
Date: Sun, 4 May 2003 19:06:36 +0200
To: Andrew Morton <akpm@digeo.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Tweak to NFS memory management for writes...
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew,

  With the following patch I'm able to get good interactive response
even when running a 256-thread iozone session over NFSv3 + X +... (as
opposed to simply crashing due to OOM). It contains the following
elements:

  - Add missing unstable write accounting in sync_inodes_sb()
  - Add missing unstable write accounting in wakeup_bdflush().
  - Decrement nr_unstable only when the COMMIT RPC call is done
    (rather then doing so when we schedule the RPC call). This ensures
    that we do try to wait for completion.
  - It is better to do too many rather than too *few* writes. Don't
    overestimate how many pages we wrote out in nfs_writepages().

Comments and/or objections before I send it on to Linus?

Cheers,
  Trond

--- linux-2.5.68-up/fs/nfs/write.c.orig	2003-04-15 04:46:02.000000000 +0200
+++ linux-2.5.68-up/fs/nfs/write.c	2003-05-04 16:15:50.000000000 +0200
@@ -280,8 +280,6 @@
 		err = nfs_wb_all(inode);
 	} else
 		nfs_commit_file(inode, NULL, 0, 0, 0);
-	/* Avoid races. Tell upstream we've done all we were told to do */
-	wbc->nr_to_write = 0;
 out:
 	return err;
 }
@@ -490,7 +488,6 @@
 	int	res;
 	res = nfs_scan_list(&nfsi->commit, dst, file, idx_start, npages);
 	nfsi->ncommit -= res;
-	sub_page_state(nr_unstable,res);
 	if ((nfsi->ncommit == 0) != list_empty(&nfsi->commit))
 		printk(KERN_ERR "NFS: desynchronized value of nfs_i.ncommit.\n");
 	return res;
@@ -1009,6 +1006,7 @@
 {
 	struct nfs_write_data	*data = (struct nfs_write_data *)task->tk_calldata;
 	struct nfs_page		*req;
+	int res = 0;
 
         dprintk("NFS: %4d nfs_commit_done (status %d)\n",
                                 task->tk_pid, task->tk_status);
@@ -1043,7 +1041,9 @@
 		nfs_mark_request_dirty(req);
 	next:
 		nfs_unlock_request(req);
+		res++;
 	}
+	sub_page_state(nr_unstable,res);
 }
 #endif
 
--- linux-2.5.68-up/fs/fs-writeback.c.orig	2003-04-08 12:16:30.000000000 +0200
+++ linux-2.5.68-up/fs/fs-writeback.c	2003-05-04 15:09:32.000000000 +0200
@@ -367,7 +367,8 @@
 	};
 
 	get_page_state(&ps);
-	wbc.nr_to_write = ps.nr_dirty + ps.nr_dirty / 4;
+	wbc.nr_to_write = ps.nr_dirty + ps.nr_unstable +
+		(ps.nr_dirty + ps.nr_unstable) / 4;
 	spin_lock(&inode_lock);
 	sync_sb_inodes(sb, &wbc);
 	spin_unlock(&inode_lock);
--- linux-2.5.68-up/mm/page-writeback.c.orig	2003-04-20 08:22:32.000000000 +0200
+++ linux-2.5.68-up/mm/page-writeback.c	2003-05-04 14:39:40.000000000 +0200
@@ -272,7 +272,7 @@
 		struct page_state ps;
 
 		get_page_state(&ps);
-		nr_pages = ps.nr_dirty;
+		nr_pages = ps.nr_dirty + ps.nr_unstable;
 	}
 	return pdflush_operation(background_writeout, nr_pages);
 }
