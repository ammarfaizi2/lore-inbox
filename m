Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319183AbSHTQUC>; Tue, 20 Aug 2002 12:20:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319185AbSHTQUC>; Tue, 20 Aug 2002 12:20:02 -0400
Received: from pat.uio.no ([129.240.130.16]:26545 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S319183AbSHTQUA>;
	Tue, 20 Aug 2002 12:20:00 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15714.27938.609022.349176@charged.uio.no>
Date: Tue, 20 Aug 2002 18:24:02 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Improve READDIR/READDIRPLUS sanity checking..
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  - Use req->rq_received to determine the message length instead of
    assuming that it goes to the end of the page.
  - If the server returned an illegal record so that we cannot make
    progress by retrying the request on a fresh page, truncate the
    entire listing and return a syslog error.

Cheers,
  Trond


diff -u --recursive --new-file linux-2.5.31-fix_read/fs/nfs/nfs2xdr.c linux-2.5.31-fix_readdir/fs/nfs/nfs2xdr.c
--- linux-2.5.31-fix_read/fs/nfs/nfs2xdr.c	Tue Aug 20 17:10:08 2002
+++ linux-2.5.31-fix_readdir/fs/nfs/nfs2xdr.c	Tue Aug 20 17:10:52 2002
@@ -393,7 +393,7 @@
 	struct xdr_buf *rcvbuf = &req->rq_rcv_buf;
 	struct iovec *iov = rcvbuf->head;
 	struct page **page;
-	int hdrlen;
+	int hdrlen, recvd;
 	int status, nr;
 	unsigned int len, pglen;
 	u32 *end, *entry;
@@ -402,17 +402,24 @@
 		return -nfs_stat_to_errno(status);
 
 	hdrlen = (u8 *) p - (u8 *) iov->iov_base;
-	if (iov->iov_len > hdrlen) {
+	if (iov->iov_len < hdrlen) {
+		printk(KERN_WARNING "NFS: READDIR reply header overflowed:"
+				"length %d > %d\n", hdrlen, iov->iov_len);
+		return -errno_NFSERR_IO;
+	} else if (iov->iov_len != hdrlen) {
 		dprintk("NFS: READDIR header is short. iovec will be shifted.\n");
 		xdr_shift_buf(rcvbuf, iov->iov_len - hdrlen);
 	}
 
 	pglen = rcvbuf->page_len;
+	recvd = req->rq_received - hdrlen;
+	if (pglen > recvd)
+		pglen = recvd;
 	page = rcvbuf->pages;
 	p = kmap(*page);
 	end = (u32 *)((char *)p + pglen);
+	entry = p;
 	for (nr = 0; *p++; nr++) {
-		entry = p - 1;
 		if (p + 2 > end)
 			goto short_pkt;
 		p++; /* fileid */
@@ -425,14 +432,21 @@
 		}
 		if (p + 2 > end)
 			goto short_pkt;
+		entry = p;
 	}
+	if (!nr)
+		goto short_pkt;
+ out:
 	kunmap(*page);
 	return nr;
  short_pkt:
-	printk(KERN_NOTICE "NFS: short packet in readdir reply!\n");
 	entry[0] = entry[1] = 0;
-	kunmap(*page);
-	return nr;
+	/* truncate listing ? */
+	if (!nr) {
+		printk(KERN_NOTICE "NFS: readdir reply truncated!\n");
+		entry[1] = 1;
+	}
+	goto out;
 err_unmap:
 	kunmap(*page);
 	return -errno_NFSERR_IO;
diff -u --recursive --new-file linux-2.5.31-fix_read/fs/nfs/nfs3xdr.c linux-2.5.31-fix_readdir/fs/nfs/nfs3xdr.c
--- linux-2.5.31-fix_read/fs/nfs/nfs3xdr.c	Tue Aug 20 17:10:08 2002
+++ linux-2.5.31-fix_readdir/fs/nfs/nfs3xdr.c	Tue Aug 20 17:10:52 2002
@@ -504,7 +504,7 @@
 	struct xdr_buf *rcvbuf = &req->rq_rcv_buf;
 	struct iovec *iov = rcvbuf->head;
 	struct page **page;
-	int hdrlen;
+	int hdrlen, recvd;
 	int status, nr;
 	unsigned int len, pglen;
 	u32 *entry, *end;
@@ -523,17 +523,24 @@
 	}
 
 	hdrlen = (u8 *) p - (u8 *) iov->iov_base;
-	if (iov->iov_len > hdrlen) {
+	if (iov->iov_len < hdrlen) {
+		printk(KERN_WARNING "NFS: READDIR reply header overflowed:"
+				"length %d > %d\n", hdrlen, iov->iov_len);
+		return -errno_NFSERR_IO;
+	} else if (iov->iov_len != hdrlen) {
 		dprintk("NFS: READDIR header is short. iovec will be shifted.\n");
 		xdr_shift_buf(rcvbuf, iov->iov_len - hdrlen);
 	}
 
 	pglen = rcvbuf->page_len;
+	recvd = req->rq_received - hdrlen;
+	if (pglen > recvd)
+		pglen = recvd;
 	page = rcvbuf->pages;
 	p = kmap(*page);
 	end = (u32 *)((char *)p + pglen);
+	entry = p;
 	for (nr = 0; *p++; nr++) {
-		entry = p - 1;
 		if (p + 3 > end)
 			goto short_pkt;
 		p += 2;				/* inode # */
@@ -570,15 +577,21 @@
 
 		if (p + 2 > end)
 			goto short_pkt;
+		entry = p;
 	}
+	if (!nr)
+		goto short_pkt;
+ out:
 	kunmap(*page);
 	return nr;
  short_pkt:
-	printk(KERN_NOTICE "NFS: short packet in readdir reply!\n");
-	/* truncate listing */
 	entry[0] = entry[1] = 0;
-	kunmap(*page);
-	return nr;
+	/* truncate listing ? */
+	if (!nr) {
+		printk(KERN_NOTICE "NFS: readdir reply truncated!\n");
+		entry[1] = 1;
+	}
+	goto out;
 err_unmap:
 	kunmap(*page);
 	return -errno_NFSERR_IO;
