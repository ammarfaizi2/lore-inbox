Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265593AbRFVXyA>; Fri, 22 Jun 2001 19:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265594AbRFVXxt>; Fri, 22 Jun 2001 19:53:49 -0400
Received: from pat.uio.no ([129.240.130.16]:52115 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S265593AbRFVXxa>;
	Fri, 22 Jun 2001 19:53:30 -0400
MIME-Version: 1.0
Message-ID: <15155.55920.648446.700067@charged.uio.no>
Date: Sat, 23 Jun 2001 01:53:20 +0200
To: Alan Cox <alan@redhat.com>, Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        NFS maillist <nfs@lists.sourceforge.net>
Subject: [2.4.5]Patch - fix page leak in nfs_prepare_write()
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

  The following patch fixes a leak in high memory in case a
process is signalled while in nfs_prepare_write().

Cheers,
  Trond

diff -u --recursive --new-file linux-2.4.6-mmap/fs/nfs/file.c linux-2.4.6-file/fs/nfs/file.c
--- linux-2.4.6-mmap/fs/nfs/file.c	Tue May 22 18:26:06 2001
+++ linux-2.4.6-file/fs/nfs/file.c	Fri Jun 22 18:43:34 2001
@@ -162,9 +162,18 @@
  */
 static int nfs_prepare_write(struct file *file, struct page *page, unsigned offset, unsigned to)
 {
+	int status;
+
 	kmap(page);
-	return nfs_flush_incompatible(file, page);
+	status = nfs_flush_incompatible(file, page);
+	if (status)
+		goto out_err;
+	return 0;
+ out_err:
+	kunmap(page);
+	return status;
 }
+
 static int nfs_commit_write(struct file *file, struct page *page, unsigned offset, unsigned to)
 {
 	long status;
