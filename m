Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135624AbREAQDm>; Tue, 1 May 2001 12:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136638AbREAQDd>; Tue, 1 May 2001 12:03:33 -0400
Received: from mx03.uni-tuebingen.de ([134.2.3.13]:29195 "EHLO
	mx03.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id <S135624AbREAQD1>; Tue, 1 May 2001 12:03:27 -0400
Date: Tue, 1 May 2001 18:01:45 +0200
To: Jens Axboe <axboe@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: MO-Drive under 2.4.3
Message-ID: <20010501180145.A465@pelks01.extern.uni-tuebingen.de>
Mail-Followup-To: Jens Axboe <axboe@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20010422013738.A520@pelks01.extern.uni-tuebingen.de> <E14r7I2-0004d8-00@the-village.bc.nu> <20010422043618.C4058@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.1.12i
In-Reply-To: <20010422043618.C4058@suse.de>; from axboe@suse.de on Sun, Apr 22, 2001 at 04:36:18AM +0200
From: Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 22, 2001 at 04:36:18AM +0200, Jens Axboe wrote:
> On Sun, Apr 22 2001, Alan Cox wrote:
> > > a) Put in lots of bigblock special case code in FAT;
> > > b) teach submit_bh() or generic_make_request() to transparently reblock 
> > >    bhs < hw_blksize and remove most special cases from FAT. Specifically,
> > >    it ought to stop pretending in sb->s_blocksize to use 2k blocks when
> > >    the fs is really tied to 512 byte blocks.
> > > 
> > > I tend to favour b), but which one is more likely to be accepted?
> > 
> > Al Viro suggested c) which was to transparently make it a loopback mount of
> > the raw device and let a loopback layer do the work.
> 
> ... which is basically the same thing, in that we need to support writes
> < hardware block size to devices. This is never going to be an efficient
> mechanism, the read gathering required for a 512b write on a 2048b media
> is scary. Think cd-rw 64kB blocksize for write. Ugh.

Here's my stab at reblocking support. I've tested with VFAT filesystems on a
SCSI magneto-optical with 2k hw block size. losetup /dev/loop0 /dev/sda1 &&
mount /dev/loop0 /mnt/mo. read/write/mmap appear to work, but obviously the code
is in dire need for optimisations. What's the reasoning behind never caching bhs
to the underlying blkdev? Using getblk&friends instead of allocating each bh
ourselves and dropping it right afterwards would make the code a lot less
horrible. But I fear someone must have had good reason not to do so. Does
anyone know details? And moreover, does anyone see problems with this change
other than performance woes?

Regards,

Daniel.

--[snip]--

--- loop.c.vanilla	Mon Apr 30 21:08:05 2001
+++ loop.c	Tue May  1 17:05:32 2001
@@ -49,6 +49,10 @@
  *   problem above. Encryption modules that used to rely on the old scheme
  *   should just call ->i_mapping->bmap() to calculate the physical block
  *   number.
+ *
+ * Added reblocking support for misdesigned filesystems (read: FAT) that make
+ * strong assumptions about the max block size of the underlying device.
+ * Daniel Kobras <kobras@linux.de>, May 1st, 2001.
  */ 
 
 #include <linux/config.h>
@@ -381,9 +385,16 @@
 		loop_add_bh(lo, bh);
 }
 
+static void loop_end_io_sync(struct buffer_head *bh, int uptodate)
+{
+	mark_buffer_uptodate(bh, uptodate);
+	unlock_buffer(bh);
+}
+
 static struct buffer_head *loop_get_buffer(struct loop_device *lo,
 					   struct buffer_head *rbh)
 {
+	int bs;
 	struct buffer_head *bh;
 
 	do {
@@ -396,7 +407,6 @@
 	} while (1);
 	memset(bh, 0, sizeof(*bh));
 
-	bh->b_size = rbh->b_size;
 	bh->b_dev = rbh->b_rdev;
 	spin_lock_irq(&lo->lo_lock);
 	bh->b_rdev = lo->lo_device;
@@ -411,10 +421,21 @@
 	bh->b_page = alloc_page(GFP_BUFFER);
 	bh->b_data = kmap(bh->b_page);
 
+	init_waitqueue_head(&bh->b_wait);
+
 	bh->b_end_io = loop_end_io_transfer;
 	bh->b_rsector = rbh->b_rsector + (lo->lo_offset >> 9);
-	init_waitqueue_head(&bh->b_wait);
 
+	bs = loop_get_bs(lo);
+	
+	if (rbh->b_size >= bs) {
+		bh->b_size = rbh->b_size;
+		return bh;
+	}
+
+	bh->b_size = bs;
+	bh->b_rsector &= ~((bh->b_size>>9) - 1);
+	
 	return bh;
 }
 
@@ -468,9 +489,31 @@
 	bh->b_private = rbh;
 	IV = loop_get_iv(lo, bh->b_rsector);
 	if (rw == WRITE) {
-		set_bit(BH_Dirty, &bh->b_state);
-		if (lo_do_transfer(lo, WRITE, bh->b_data, rbh->b_data, bh->b_size, IV))
-			goto err;
+		if (bh->b_size == rbh->b_size) {
+			set_bit(BH_Dirty, &bh->b_state);
+			if (lo_do_transfer(lo, WRITE, bh->b_data, rbh->b_data,				                   rbh->b_size, IV))
+				goto err;
+		} else {
+			/* FIXME. This, of course, is outright ridiculous.
+			 * We obviously want to cache the bhs.  The naive
+			 * approch simply uses getblk() in loop_get_buffer(),
+			 * and we'd just call bread() below.  But surely the
+			 * current code has compelling reasons not to do so?
+			 * loop eating up too many bhs?
+			 */
+			unsigned long off;
+			bh->b_end_io = loop_end_io_sync;
+			generic_make_request(READ, bh);
+			lock_buffer(bh);
+			if (!buffer_uptodate(bh))
+				goto err;
+			bh->b_end_io = loop_end_io_transfer;
+			set_bit(BH_Dirty, &bh->b_state);
+			off = (rbh->b_rsector - bh->b_rsector) << 9;
+			if (lo_do_transfer(lo, WRITE, bh->b_data+off,
+	        	                   rbh->b_data, rbh->b_size, IV))
+				goto err;
+		}
 	}
 
 	generic_make_request(rw, bh);
@@ -503,9 +546,11 @@
 	} else {
 		struct buffer_head *rbh = bh->b_private;
 		unsigned long IV = loop_get_iv(lo, rbh->b_rsector);
-
-		ret = lo_do_transfer(lo, READ, bh->b_data, rbh->b_data,
-				     bh->b_size, IV);
+		unsigned long off = 0;
+		if (bh->b_size != rbh->b_size)
+			off = (rbh->b_rsector - bh->b_rsector) << 9;
+		ret = lo_do_transfer(lo, READ, bh->b_data+off, rbh->b_data,
+				     rbh->b_size, IV);
 
 		rbh->b_end_io(rbh, !ret);
 		loop_put_buffer(bh);
