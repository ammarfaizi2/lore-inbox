Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287351AbRL3HMN>; Sun, 30 Dec 2001 02:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287352AbRL3HMD>; Sun, 30 Dec 2001 02:12:03 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:16147 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S287351AbRL3HLv>; Sun, 30 Dec 2001 02:11:51 -0500
Message-ID: <3C2EBD62.6A98F670@zip.com.au>
Date: Sat, 29 Dec 2001 23:08:18 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Andrea Arcangeli <andrea@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        torrey.hoffman@myrio.com, linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: ramdisk corruption problems - was: RE: pivot_root and initrd kern  
 el panic woes
In-Reply-To: <3C2EB208.B2BA7CBF@zip.com.au> <Pine.GSO.4.21.0112300129060.8523-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As you pointed out offline, the -ac kernels fixed the problem using
*both* approaches.  Here's a 2.4.18-pre1 version.  generic_file_write()
is getting rather icky.

Please let me know if this looks like the way to proceed, and I'll
find a way to actually test the thing.


--- linux-2.4.18-pre1/fs/buffer.c	Fri Dec 21 11:19:14 2001
+++ linux-akpm/fs/buffer.c	Sat Dec 29 22:46:21 2001
@@ -1639,6 +1639,17 @@ static int __block_prepare_write(struct 
 	}
 	return 0;
 out:
+	bh = head;
+	block_start = 0;
+	do {
+		if (buffer_new(bh) && !buffer_uptodate(bh)) {
+			memset(kaddr+block_start, 0, bh->b_size);
+			set_bit(BH_Uptodate, &bh->b_state);
+			mark_buffer_dirty(bh);
+		}
+		block_start += bh->b_size;
+		bh = bh->b_this_page;
+	} while (bh != head);
 	return err;
 }
 
--- linux-2.4.18-pre1/mm/filemap.c	Wed Dec 26 11:47:41 2001
+++ linux-akpm/mm/filemap.c	Sat Dec 29 23:04:29 2001
@@ -2856,6 +2856,7 @@ generic_file_write(struct file *file,con
 	ssize_t		written;
 	long		status = 0;
 	int		err;
+	int		prepare_write_failed = 0;
 	unsigned	bytes;
 
 	if ((ssize_t) count < 0)
@@ -3003,8 +3004,10 @@ generic_file_write(struct file *file,con
 
 		kaddr = kmap(page);
 		status = mapping->a_ops->prepare_write(file, page, offset, offset+bytes);
-		if (status)
+		if (status) {
+			prepare_write_failed = 1;
 			goto unlock;
+		}
 		page_fault = __copy_from_user(kaddr+offset, buf, bytes);
 		flush_dcache_page(page);
 		status = mapping->a_ops->commit_write(file, page, offset, offset+bytes);
@@ -3026,8 +3029,18 @@ unlock:
 		UnlockPage(page);
 		page_cache_release(page);
 
-		if (status < 0)
+		if (status < 0) {
+			if (prepare_write_failed) {
+				/*
+				 * If blocksize < pagesize, prepare_write() may have
+				 * instantiated a few blocks outside i_size.  Trim
+				 * these off again.
+				 */
+				if (pos + bytes > inode->i_size)
+					vmtruncate(inode, inode->i_size);
+			}	
 			break;
+		}
 	} while (count);
 	*ppos = pos;
