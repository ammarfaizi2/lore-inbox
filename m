Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281690AbRKZNzX>; Mon, 26 Nov 2001 08:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281692AbRKZNzO>; Mon, 26 Nov 2001 08:55:14 -0500
Received: from pat.uio.no ([129.240.130.16]:61332 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S281690AbRKZNzG>;
	Mon, 26 Nov 2001 08:55:06 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15362.18626.303009.379772@charged.uio.no>
Date: Mon, 26 Nov 2001 14:50:58 +0100
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: NFS maillist <nfs@lists.sourceforge.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Fix knfsd readahead cache in 2.4.15
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

  The following patch fixes a bug in the knfsd readahead code. The
memset() that is referenced in the patch below is clobbering the
pointer to the next list element (ra->p_next), thus reducing the inode
readahead cache to 1 entry upon the very first call to
nfsd_get_raparms().

  BTW: looking at the choice of cache size. Why is this set to number
of threads * 2? Isn't it better to have a minimum cache size? After
all, the fact that I have 8 threads running does not at all reflect
the number of inodes that I might have open on my various clients...

Cheers,
   Trond

--- linux-2.4.16-pre1/fs/nfsd/vfs.c.orig	Fri Oct  5 21:23:53 2001
+++ linux-2.4.16-pre1/fs/nfsd/vfs.c	Mon Nov 26 14:32:09 2001
@@ -560,9 +560,13 @@
 		return NULL;
 	rap = frap;
 	ra = *frap;
-	memset(ra, 0, sizeof(*ra));
 	ra->p_dev = dev;
 	ra->p_ino = ino;
+	ra->p_reada = 0;
+	ra->p_ramax = 0;
+	ra->p_raend = 0;
+	ra->p_ralen = 0;
+	ra->p_rawin = 0;
 found:
 	if (rap != &raparm_cache) {
 		*rap = ra->p_next;
