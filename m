Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278366AbRJMTMR>; Sat, 13 Oct 2001 15:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278367AbRJMTL5>; Sat, 13 Oct 2001 15:11:57 -0400
Received: from mons.uio.no ([129.240.130.14]:44416 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S278366AbRJMTLt>;
	Sat, 13 Oct 2001 15:11:49 -0400
To: David Chow <davidchow@rcn.com.hk>
Cc: Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org,
        nfs@lists.sourceforge.net
Subject: Re: [PATCH] NFSv3 symlink bug
In-Reply-To: <jelmiuj7w2.fsf@sykes.suse.de> <3BC88B44.E461CB63@rcn.com.hk>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 13 Oct 2001 21:12:15 +0200
In-Reply-To: David Chow's message of "Sun, 14 Oct 2001 02:43:16 +0800"
Message-ID: <shsvghjuzg0.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == David Chow <davidchow@rcn.com.hk> writes:

     > Not just that. the call to vfs_symlink on an NFS v3 mounted
     > filesystem, the dentry that passed to vfs_symlink did not
     > result with an inode member it remains null. This also lead to
     > problem in the dcache and didn't have a d_instantiate() and
     > d_add() in the nfs_symlink() . I have proved this is a bug. in

Wrong. Look again... We do instantiate NFSv3 symlinks.

     > kernel version 2.4.0 up to 2.4.10 . Not tested with 2.4.12 and
     > 2.4.11 . This will not affect most of the process context

The only bug I can see is if nfs_fhget() fails to allocate a new
inode. In that case we should drop the dentry. That should be a pretty
rare bug though and would only happen under extremely low memory
conditions.

Cheers,
   Trond

--- linux-2.4.12/fs/nfs/dir.c.orig	Tue Jun 12 20:15:08 2001
+++ linux-2.4.12/fs/nfs/dir.c	Sat Oct 13 21:07:26 2001
@@ -928,6 +928,8 @@
 					  &attr, &sym_fh, &sym_attr);
 	if (!error && sym_fh.size != 0 && (sym_attr.valid & NFS_ATTR_FATTR)) {
 		error = nfs_instantiate(dentry, &sym_fh, &sym_attr);
+		if (error)
+			d_drop(dentry);
 	} else {
 		if (error == -EEXIST)
 			printk("nfs_proc_symlink: %s/%s already exists??\n",

