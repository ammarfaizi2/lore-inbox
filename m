Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129490AbRBTWlL>; Tue, 20 Feb 2001 17:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129294AbRBTWlB>; Tue, 20 Feb 2001 17:41:01 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:52814 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129066AbRBTWku>; Tue, 20 Feb 2001 17:40:50 -0500
Date: Tue, 20 Feb 2001 23:42:19 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: lvm-devel@sistina.com
Cc: linux-lvm@sistina.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, okeefe@sistina.com,
        declerck@sistina.com
Subject: Re: [lvm-devel] *** ANNOUNCEMENT *** LVM 0.9.1 beta5 available at www.sistina.com
Message-ID: <20010220234219.B2023@athlon.random>
In-Reply-To: <20010220224907.D21281@srv.sistina.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010220224907.D21281@srv.sistina.com>; from Mauelshagen@sistina.com on Tue, Feb 20, 2001 at 10:49:07PM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2001 at 10:49:07PM +0000, Heinz Mauelshagen wrote:
> 
> Hi all,
> 
> a tarball of the Linux Logical Volume Manager 0.9.1 Beta 5 is available now at
> 
>    <http://www.sistina.com/>
> 
> for download (Follow the "LVM download page" link).
> 
> This release fixes several bugs.
> See the CHANGELOG file contained in the tarball for further information.
> 
> A change in the i/o protocoll version *forces* you to update
> the driver as well.
> Follow instructions in PATCHES/README to achieve this please.
> 
> 
> Please help us to stabilize for 0.9.1 ASAP and test is as much as possible!
> Feed back related information to <linux-lvm@sistina.com>.

The bheads in the lv_t is the wrong way to go, I just wrote an alternate patch
for rawio that keeps the bh inside the kiovec, not in the lv, this also
imrproves rawio performance in general (such allocation deallocation flood was
wasteful). No a single change is required at the lvm layer, all the changes lives in
the kiobuf layer. It's tested and it works for me.

diff -urN rawio-ref/fs/buffer.c rawio/fs/buffer.c
--- rawio-ref/fs/buffer.c	Tue Feb 20 23:17:10 2001
+++ rawio/fs/buffer.c	Tue Feb 20 23:17:27 2001
@@ -1240,6 +1240,29 @@
 	wake_up(&buffer_wait);
 }
 
+int alloc_kiobuf_bhs(struct kiobuf * kiobuf)
+{
+	int i, j;
+
+	for (i = 0; i < KIO_MAX_SECTORS; i++)
+		if (!(kiobuf->bh[i] = get_unused_buffer_head(0))) {
+			for (j = 0; j < i; j++)
+				put_unused_buffer_head(kiobuf->bh[j]);
+			wake_up(&buffer_wait);
+			return -ENOMEM;
+		}
+	return 0;
+}
+
+void free_kiobuf_bhs(struct kiobuf * kiobuf)
+{
+	int i;
+
+	for (i = 0; i < KIO_MAX_SECTORS; i++)
+		put_unused_buffer_head(kiobuf->bh[i]);
+	wake_up(&buffer_wait);
+}
+
 static void end_buffer_io_async(struct buffer_head * bh, int uptodate)
 {
 	unsigned long flags;
@@ -1333,10 +1356,8 @@
 			iosize = 0;
 		}
 		
-		put_unused_buffer_head(tmp);
 		iosize += size;
 	}
-	wake_up(&buffer_wait);
 	
 	dprintk ("do_kio end %d %d\n", iosize, err);
 	
@@ -1390,7 +1411,7 @@
 	int		i;
 	int		bufind;
 	int		pageind;
-	int		bhind;
+	int		bhind, kiobuf_bh_nr;
 	int		offset;
 	unsigned long	blocknr;
 	struct kiobuf *	iobuf = NULL;
@@ -1422,6 +1443,7 @@
 	 */
 	bufind = bhind = transferred = err = 0;
 	for (i = 0; i < nr; i++) {
+		kiobuf_bh_nr = 0;
 		iobuf = iovec[i];
 		err = setup_kiobuf_bounce_pages(iobuf, GFP_USER);
 		if (err) 
@@ -1444,12 +1466,8 @@
 
 			while (length > 0) {
 				blocknr = b[bufind++];
-				tmp = get_unused_buffer_head(0);
-				if (!tmp) {
-					err = -ENOMEM;
-					goto error;
-				}
-				
+				tmp = iobuf->bh[kiobuf_bh_nr++];
+
 				tmp->b_dev = B_FREE;
 				tmp->b_size = size;
 				tmp->b_data = (char *) (page + offset);
@@ -1460,7 +1478,8 @@
 				if (rw == WRITE) {
 					set_bit(BH_Uptodate, &tmp->b_state);
 					set_bit(BH_Dirty, &tmp->b_state);
-				}
+				} else
+					clear_bit(BH_Uptodate, &tmp->b_state);
 
 				dprintk ("buffer %d (%d) at %p\n", 
 					 bhind, tmp->b_blocknr, tmp->b_data);
@@ -1478,7 +1497,7 @@
 						transferred += err;
 					else
 						goto finished;
-					bhind = 0;
+					kiobuf_bh_nr = bhind = 0;
 				}
 				
 				if (offset >= PAGE_SIZE) {
@@ -1506,17 +1525,6 @@
 	if (transferred)
 		return transferred;
 	return err;
-
- error:
-	/* We got an error allocation the bh'es.  Just free the current
-           buffer_heads and exit. */
-	for (i = 0; i < bhind; i++)
-		put_unused_buffer_head(bh[i]);
-	wake_up(&buffer_wait);
-
-	clear_kiobuf_bounce_pages(iobuf);
-
-	goto finished;
 }
 
 /*
diff -urN rawio-ref/fs/iobuf.c rawio/fs/iobuf.c
--- rawio-ref/fs/iobuf.c	Tue Feb 20 23:17:10 2001
+++ rawio/fs/iobuf.c	Tue Feb 20 23:17:24 2001
@@ -41,6 +41,11 @@
 		iobuf->pagelist   = iobuf->page_array;
 		iobuf->maplist    = iobuf->map_array;
 		iobuf->bouncelist = iobuf->bounce_array;
+		if (alloc_kiobuf_bhs(iobuf)) {
+			kmem_cache_free(kiobuf_cachep, iobuf);
+			free_kiovec(i, bufp);
+			return -ENOMEM;
+		}
 		*bufp++ = iobuf;
 	}
 	
@@ -73,6 +78,7 @@
 		if (iobuf->array_len > KIO_STATIC_PAGES) {
 			kfree (iobuf->pagelist);
 		}
+		free_kiobuf_bhs(iobuf);
 		kmem_cache_free(kiobuf_cachep, bufp[i]);
 	}
 }
diff -urN rawio-ref/include/linux/iobuf.h rawio/include/linux/iobuf.h
--- rawio-ref/include/linux/iobuf.h	Tue Feb 20 23:17:10 2001
+++ rawio/include/linux/iobuf.h	Tue Feb 20 23:17:24 2001
@@ -50,6 +50,7 @@
 	unsigned long	page_array[KIO_STATIC_PAGES];
 	struct page *	map_array[KIO_STATIC_PAGES];
 	unsigned long	bounce_array[KIO_STATIC_PAGES];
+	struct buffer_head *bh[KIO_MAX_SECTORS];
 };
 
 
@@ -67,6 +68,8 @@
 int	setup_kiobuf_bounce_pages(struct kiobuf *, int gfp_mask);
 void	clear_kiobuf_bounce_pages(struct kiobuf *);
 void	kiobuf_copy_bounce(struct kiobuf *, int direction, int max);
+extern int alloc_kiobuf_bhs(struct kiobuf *);
+extern void free_kiobuf_bhs(struct kiobuf *);
 
 /* Direction codes for kiobuf_copy_bounce: */
 enum {



I didn't had much time to look into beta5 yet but I can't see why you changed
the protocol to 11. There's no breakage between beta4 and beta5 in the
datastructures shared with userspace.  I don't like gratuitous API breakage.

Just as reminer the hardsectsize fix isn't yet merged in beta5.

Andrea
