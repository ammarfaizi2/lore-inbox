Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317023AbSG1PZm>; Sun, 28 Jul 2002 11:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316906AbSG1PY1>; Sun, 28 Jul 2002 11:24:27 -0400
Received: from pat.uio.no ([129.240.130.16]:60307 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S316882AbSG1PXe>;
	Sun, 28 Jul 2002 11:23:34 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15684.3384.221358.537571@charged.uio.no>
Date: Sun, 28 Jul 2002 17:26:48 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: [PATCH] Support for cached lookups via readdirplus [6/6]
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add support for the glibc 'd_type' field in cases where we have the
READDIRPLUS file attribute information available to us in
nfs_do_filldir().

Cheers,
  Trond

diff -u --recursive --new-file linux-2.5.29-rdplus5/fs/nfs/dir.c linux-2.5.29-rdplus6/fs/nfs/dir.c
--- linux-2.5.29-rdplus5/fs/nfs/dir.c	Sat Jul 27 19:15:41 2002
+++ linux-2.5.29-rdplus6/fs/nfs/dir.c	Sat Jul 27 19:15:33 2002
@@ -249,6 +249,24 @@
 	return res;
 }
 
+static unsigned int nfs_type2dtype[] = {
+	DT_UNKNOWN,
+	DT_REG,
+	DT_DIR,
+	DT_BLK,
+	DT_CHR,
+	DT_LNK,
+	DT_SOCK,
+	DT_UNKNOWN,
+	DT_FIFO
+};
+
+static inline
+unsigned int nfs_type_to_d_type(enum nfs_ftype type)
+{
+	return nfs_type2dtype[type];
+}
+
 /*
  * Once we've found the start of the dirent within a page: fill 'er up...
  */
@@ -265,11 +283,17 @@
 	dfprintk(VFS, "NFS: nfs_do_filldir() filling starting @ cookie %Lu\n", (long long)desc->target);
 
 	for(;;) {
+		unsigned d_type = DT_UNKNOWN;
 		/* Note: entry->prev_cookie contains the cookie for
 		 *	 retrieving the current dirent on the server */
 		fileid = nfs_fileid_to_ino_t(entry->ino);
+
+		/* Use readdirplus info */
+		if (desc->plus && (entry->fattr->valid & NFS_ATTR_FATTR))
+			d_type = nfs_type_to_d_type(entry->fattr->type);
+
 		res = filldir(dirent, entry->name, entry->len, 
-			      entry->prev_cookie, fileid, DT_UNKNOWN);
+			      entry->prev_cookie, fileid, d_type);
 		if (res < 0)
 			break;
 		file->f_pos = desc->target = entry->cookie;
