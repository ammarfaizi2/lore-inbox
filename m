Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131480AbRDWH6w>; Mon, 23 Apr 2001 03:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131497AbRDWH6m>; Mon, 23 Apr 2001 03:58:42 -0400
Received: from mons.uio.no ([129.240.130.14]:23692 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S131480AbRDWH62>;
	Mon, 23 Apr 2001 03:58:28 -0400
MIME-Version: 1.0
Message-ID: <15075.57494.135118.223555@charged.uio.no>
Date: Mon, 23 Apr 2001 09:58:14 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: NFS devel <nfs-devel@linux.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.4-pre6 NFSv3 maximum filesize correction
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

  The current 2.4.4-pre series assumes that NFSv3 is always fully LFS
capable. This is of course not the case on 32bit architectures such as
the 2.2.x series.
  The following patch to fs/nfs/inode.c corrects this bug by using the
NFSPROC3_FSINFO call to provide the maximum supported filesize on the
filesystem in question. On NFSv2 it will be set to 0x7FFFFFFF.

  In doing this, I also noticed that knfsd was still supplying 4Gb as
its maximum supported filesize. The appended patch to
fs/nfsd/nfs3proc.c causes the FSINFO call to return sb->s_maxbytes to
the client.

Cheers,
  Trond

diff -u --recursive --new-file linux-2.4.4-pre6/fs/nfs/inode.c linux-2.4.4-maxfile/fs/nfs/inode.c
--- linux-2.4.4-pre6/fs/nfs/inode.c	Fri Apr 20 02:59:42 2001
+++ linux-2.4.4-maxfile/fs/nfs/inode.c	Fri Apr 20 14:50:25 2001
@@ -435,8 +435,7 @@
         if (server->namelen == 0 || server->namelen > maxlen)
                 server->namelen = maxlen;
 
-	if(version > 2)
-		sb->s_maxbytes = ~0ULL;	/* Unlimited on NFSv3 */
+	sb->s_maxbytes = fsinfo.maxfilesize;
 
 	/* Fire up the writeback cache */
 	if (nfs_reqlist_alloc(server) < 0) {
diff -u --recursive --new-file linux-2.4.4-pre6/fs/nfsd/nfs3proc.c linux-2.4.4-maxfile/fs/nfsd/nfs3proc.c
--- linux-2.4.4-pre6/fs/nfsd/nfs3proc.c	Fri Feb  9 20:29:44 2001
+++ linux-2.4.4-maxfile/fs/nfsd/nfs3proc.c	Fri Apr 20 14:49:38 2001
@@ -542,6 +542,7 @@
 		if (sb->s_magic == 0x4d44 /* MSDOS_SUPER_MAGIC */) {
 			resp->f_properties = NFS3_FSF_BILLYBOY;
 		}
+		resp->f_maxfilesize = sb->s_maxbytes;
 	}
 
 	fh_put(&argp->fh);
