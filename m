Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282482AbRLKRiY>; Tue, 11 Dec 2001 12:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282329AbRLKRiE>; Tue, 11 Dec 2001 12:38:04 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24328 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281890AbRLKRiB>; Tue, 11 Dec 2001 12:38:01 -0500
Date: Tue, 11 Dec 2001 09:37:37 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: GOTO Masanori <gotom@debian.org>
cc: <marcelo@conectiva.com.br>, <linux-kernel@vger.kernel.org>,
        <andrea@suse.de>
Subject: Re: [PATCH] direct IO breaks root filesystem
In-Reply-To: <w534rmynn77.wl@megaela.fe.dis.titech.ac.jp>
Message-ID: <Pine.LNX.4.33.0112110932070.8613-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Dec 2001, GOTO Masanori wrote:
>
> Accessing with inode size unit (== 4096 byte) is ok, but if I accessed
> with block size unit, generic_direct_IO() returns error.  The reason
> is that blocksize is designated as inode->i_blkbits, and its value is
> not disk minimal block size (512), but inode's unit size (4096).

Actually, I now found the _real_ bug that explains both the "inode->i_dev"
_and_ the block size problem.

We have the wrong inode.

We use the on-disk inode, which is NOT the same as the "mapping" inode for
actually doing the IO.

This simple (and completely untested) patch should fix it.

This two-liner should also actually make the previous patch completely
unnecessary, because now "inode->i_dev" should be automatically correct. I
should have realized that inode->i_dev should always be right, and have
thought more about the fact that it wasn't.

		Linus

-----
--- v2.5.0/linux/mm/filemap.c	Wed Nov 21 14:07:25 2001
+++ linux/mm/filemap.c	Tue Dec 11 09:34:17 2001
@@ -1486,8 +1485,8 @@
 	ssize_t retval;
 	int new_iobuf, chunk_size, blocksize_mask, blocksize, blocksize_bits, iosize, progress;
 	struct kiobuf * iobuf;
-	struct inode * inode = filp->f_dentry->d_inode;
-	struct address_space * mapping = inode->i_mapping;
+	struct address_space * mapping = filp->f_dentry->d_inode->i_mapping;
+	struct inode * inode = mapping->host;

 	new_iobuf = 0;
 	iobuf = filp->f_iobuf;

