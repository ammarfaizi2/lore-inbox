Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbTHTOfy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 10:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbTHTOfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 10:35:54 -0400
Received: from pat.uio.no ([129.240.130.16]:1175 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261985AbTHTOfw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 10:35:52 -0400
To: Ulrich Drepper <drepper@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: NFS regression in 2.6
References: <3F4268C1.9040608@redhat.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 19 Aug 2003 22:37:50 -0700
In-Reply-To: <3F4268C1.9040608@redhat.com>
Message-ID: <shszni499e9.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Ulrich Drepper <drepper@redhat.com> writes:

     > The result is always, 100% of the time, a failure in ftruncate.
     > The kernel reports ESTALE.  This has not been a problem in 2.4
     > and not even in 2.6 until <mumble> months ago.  And of course
     > it works with local disks.

There are known bugs in the way we handle readdirplus. That's why it
only hits NFSv3. Does the following patch fix it?

Cheers,
  Trond

diff -u --recursive --new-file linux-2.6.0-test2/fs/nfs/dir.c linux-2.6.0-test2-fix_cto/fs/nfs/dir.c
--- linux-2.6.0-test2/fs/nfs/dir.c	2003-06-30 07:19:26.000000000 -0700
+++ linux-2.6.0-test2-fix_cto/fs/nfs/dir.c	2003-08-11 07:54:47.000000000 -0700
@@ -557,7 +557,7 @@
 	/* Force a full look up iff the parent directory has changed */
 	if (nfs_check_verifier(dir, dentry)) {
 		if (nfs_lookup_verify_inode(inode, isopen))
-			goto out_bad;
+			goto out_zap_parent;
 		goto out_valid;
 	}
 
@@ -566,7 +566,7 @@
 		if (memcmp(NFS_FH(inode), &fhandle, sizeof(struct nfs_fh))!= 0)
 			goto out_bad;
 		if (nfs_lookup_verify_inode(inode, isopen))
-			goto out_bad;
+			goto out_zap_parent;
 		goto out_valid_renew;
 	}
 
@@ -587,6 +587,8 @@
 	unlock_kernel();
 	dput(parent);
 	return 1;
+out_zap_parent:
+	nfs_zap_caches(dir);
  out_bad:
 	NFS_CACHEINV(dir);
 	if (inode && S_ISDIR(inode->i_mode)) {
