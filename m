Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262164AbSJNVeM>; Mon, 14 Oct 2002 17:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262189AbSJNVeM>; Mon, 14 Oct 2002 17:34:12 -0400
Received: from rj.sgi.com ([192.82.208.96]:41857 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S262164AbSJNVeL>;
	Mon, 14 Oct 2002 17:34:11 -0400
Date: Tue, 15 Oct 2002 00:21:10 -0400
From: Christoph Hellwig <hch@sgi.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] switch knfsd to vfs_read/vfs_write
Message-ID: <20021015002110.A18265@sgi.com>
Mail-Followup-To: Christoph Hellwig <hch@sgi.com>,
	Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Switch knfsd to vfs_read/vfs_write to work on aio-only filesystems.
This also gets stuff like the LSM checks and mandatory lock checking
for free.


diff -uNr -p linux-2.5.40-mm1/fs/nfsd/vfs.c linux/fs/nfsd/vfs.c
--- linux-2.5.40-mm1/fs/nfsd/vfs.c	Tue Oct  1 14:23:50 2002
+++ linux/fs/nfsd/vfs.c	Tue Oct  1 14:53:37 2002
@@ -585,8 +585,6 @@ nfsd_read(struct svc_rqst *rqstp, struct
 	if (err)
 		goto out;
 	err = nfserr_perm;
-	if (!file.f_op->read)
-		goto out_close;
 	inode = file.f_dentry->d_inode;
 #ifdef MSNFS
 	if ((fhp->fh_export->ex_flags & NFSEXP_MSNFS) &&
@@ -598,11 +596,10 @@ nfsd_read(struct svc_rqst *rqstp, struct
 	ra = nfsd_get_raparms(inode->i_dev, inode->i_ino);
 	if (ra)
 		file.f_ra = ra->p_ra;
-	file.f_pos = offset;
 
 	oldfs = get_fs();
 	set_fs(KERNEL_DS);
-	err = file.f_op->read(&file, buf, *count, &file.f_pos);
+	err = vfs_read(&file, buf, *count, &offset);
 	set_fs(oldfs);
 
 	/* Write back readahead params */
@@ -644,8 +641,7 @@ nfsd_write(struct svc_rqst *rqstp, struc
 	if (!cnt)
 		goto out_close;
 	err = nfserr_perm;
-	if (!file.f_op->write)
-		goto out_close;
+
 #ifdef MSNFS
 	if ((fhp->fh_export->ex_flags & NFSEXP_MSNFS) &&
 		(!lock_may_write(file.f_dentry->d_inode, offset, cnt)))
@@ -675,11 +671,9 @@ nfsd_write(struct svc_rqst *rqstp, struc
 	if (stable && !EX_WGATHER(exp))
 		file.f_flags |= O_SYNC;
 
-	file.f_pos = offset;		/* set write offset */
-
 	/* Write the data. */
 	oldfs = get_fs(); set_fs(KERNEL_DS);
-	err = file.f_op->write(&file, buf, cnt, &file.f_pos);
+	err = vfs_write(&file, buf, cnt, &offset);
 	if (err >= 0)
 		nfsdstats.io_write += cnt;
 	set_fs(oldfs);
