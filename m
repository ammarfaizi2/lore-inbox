Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288994AbSAIT6F>; Wed, 9 Jan 2002 14:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288991AbSAIT5t>; Wed, 9 Jan 2002 14:57:49 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20234 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S288990AbSAIT4J>;
	Wed, 9 Jan 2002 14:56:09 -0500
Date: Wed, 9 Jan 2002 19:56:07 +0000
From: Joel Becker <jlbec@evilplan.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrea Arcangeli <andrea@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] O_DIRECT with hardware blocksize alignment
Message-ID: <20020109195606.A16884@parcelfarce.linux.theplanet.co.uk>
Mail-Followup-To: Joel Becker <jlbec@evilplan.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Andrea Arcangeli <andrea@suse.de>,
	lkml <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,
	Some major users of O_DIRECT (Oracle, for instance) align and
size I/O based on the 512byte hardware blocksize common to most hard
disk drives.  The current O_DIRECT code enforces that the alignment and
size of the I/O match the software blocksize (inot->i_sb->s_blocksize).
This patch relaxes that restriction to a minimum of the hardware
blocksize.  In the interest of efficiency,
min(I/O alignment, s_blocksize) is used as the effective
blocksize.  eg:

I/O alignment	s_blocksize	final blocksize
8192		4096		4096
4096		4096		4096
512		4096		512

Joel


diff -uNr linux-2.4.17/fs/buffer.c linux-2.4.17-od/fs/buffer.c
--- linux-2.4.17/fs/buffer.c	Fri Dec 21 09:41:55 2001
+++ linux-2.4.17-od/fs/buffer.c	Wed Jan  9 10:55:52 2002
@@ -2003,6 +2003,17 @@
 {
 	int i, nr_blocks, retval;
 	unsigned long * blocks = iobuf->blocks;
+	int i_bscale, i_blocknr, i_blockoff;
+
+	/* Calculate I/O blocksize to sw blocksize scaling factor */
+	i_bscale = 1;
+	if (blocksize != inode->i_sb->s_blocksize)
+	{
+		if ((inode->i_sb->s_blocksize < blocksize) ||
+		    ((inode->i_sb->s_blocksize % blocksize) != 0))
+			BUG();
+		i_bscale = inode->i_sb->s_blocksize / blocksize;
+	}
 
 	nr_blocks = iobuf->length / blocksize;
 	/* build the blocklist */
@@ -2013,7 +2024,13 @@
 		bh.b_dev = inode->i_dev;
 		bh.b_size = blocksize;
 
-		retval = get_block(inode, blocknr, &bh, rw == READ ? 0 : 1);
+		/* Convert blocknr to the software blocksize */
+		if (!i_bscale)
+			BUG();
+		i_blocknr = blocknr / i_bscale;
+		i_blockoff = blocknr % i_bscale;
+
+		retval = get_block(inode, i_blocknr, &bh, rw == READ ? 0 : 1);
 		if (retval)
 			goto out;
 
@@ -2031,7 +2048,12 @@
 			if (!buffer_mapped(&bh))
 				BUG();
 		}
-		blocks[i] = bh.b_blocknr;
+
+		/*
+		 * Convert the returned blocknr back to the
+		 * I/O blocksize.
+		 */
+		blocks[i] = (bh.b_blocknr * i_bscale) + i_blockoff;
 	}
 
 	retval = brw_kiovec(rw, 1, &iobuf, inode->i_dev, iobuf->blocks, blocksize);
diff -uNr linux-2.4.17/mm/filemap.c linux-2.4.17-od/mm/filemap.c
--- linux-2.4.17/mm/filemap.c	Fri Dec 21 09:42:04 2001
+++ linux-2.4.17-od/mm/filemap.c	Wed Jan  9 10:58:13 2002
@@ -1491,6 +1491,7 @@
 {
 	ssize_t retval;
 	int new_iobuf, chunk_size, blocksize_mask, blocksize, blocksize_bits, iosize, progress;
+	int b_bsize, b_bmask;
 	struct kiobuf * iobuf;
 	struct address_space * mapping = filp->f_dentry->d_inode->i_mapping;
 	struct inode * inode = mapping->host;
@@ -1508,14 +1509,36 @@
 		new_iobuf = 1;
 	}
 
+	chunk_size = KIO_MAX_ATOMIC_IO << 10;
+
+	retval = -EINVAL;
+
+	/*
+	 * Starting at the software blocksize, check size
+	 * and alignment of the I/O.  Shift the blocksize
+	 * down until we get an alignment that works, or we hit
+	 * the hardware blocksize and fail.
+	 */
+	b_bsize = get_hardsect_size(inode->i_dev);
+	b_bmask = (b_bsize - 1);
+
 	blocksize = 1 << inode->i_blkbits;
 	blocksize_bits = inode->i_blkbits;
 	blocksize_mask = blocksize - 1;
-	chunk_size = KIO_MAX_ATOMIC_IO << 10;
+	while (blocksize >= b_bsize)
+	{
+		if (! ((offset & blocksize_mask) ||
+		       (count & blocksize_mask) ||
+		       ((unsigned long)buf & blocksize_mask)))
+			break;
 
-	retval = -EINVAL;
-	if ((offset & blocksize_mask) || (count & blocksize_mask))
+		blocksize >>= 1;
+		blocksize_mask = (blocksize - 1);
+		blocksize_bits--;
+	}
+	if (blocksize < b_bsize)
 		goto out_free;
+
 	if (!mapping->a_ops->direct_IO)
 		goto out_free;
 
-- 

"Every new beginning comes from some other beginning's end."

			http://www.jlbec.org/
			jlbec@evilplan.org
