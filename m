Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129392AbRBSPFz>; Mon, 19 Feb 2001 10:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129539AbRBSPFq>; Mon, 19 Feb 2001 10:05:46 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:3607 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129238AbRBSPFj>; Mon, 19 Feb 2001 10:05:39 -0500
Date: Mon, 19 Feb 2001 16:06:07 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: tytso@valinux.com
Cc: alan@lxorguk.ukuu.org.uk, sflory@valinux.com, chip@valinux.com,
        linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: mke2fs and kernel VM issues
Message-ID: <20010219160607.C5170@athlon.random>
In-Reply-To: <E14ThUy-0002ed-00@the-village.bc.nu> <E14TkFk-0007Nz-00@beefcake.hdqt.valinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E14TkFk-0007Nz-00@beefcake.hdqt.valinux.com>; from tytso@valinux.com on Fri, Feb 16, 2001 at 04:44:48AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2001 at 04:44:48AM -0800, Theodore Y. Ts'o wrote:
> Note that this only shows up when using mke2fs to create very large
> filesystems, and you have relatively little memory.  In this particular

If you can reproduce the oom of mke2fs on recent 2.2.19pre, could you try
again after applying this additional VM patch?

--- VM-locked/fs/buffer.c.~1~	Sun Feb 18 04:01:32 2001
+++ VM-locked/fs/buffer.c	Sun Feb 18 23:03:32 2001
@@ -1530,9 +1530,13 @@
 		struct buffer_head *p = tmp;
 		tmp = tmp->b_this_page;
 
-		if (buffer_dirty(p))
-			if (test_and_set_bit(BH_Wait_IO, &p->b_state))
-				ll_rw_block(WRITE, 1, &p);
+		if (buffer_dirty(p) || buffer_locked(p))
+			if (test_and_set_bit(BH_Wait_IO, &p->b_state)) {
+				if (buffer_dirty(p))
+					ll_rw_block(WRITE, 1, &p);
+				else if (buffer_locked(p))
+					wait_on_buffer(p);
+			}
 	} while (tmp != bh);
 
 	/* Restore the visibility of the page before returning. */
--- VM-locked/include/linux/fs.h.~1~	Sun Feb 18 04:01:32 2001
+++ VM-locked/include/linux/fs.h	Sun Feb 18 22:59:00 2001
@@ -810,7 +810,6 @@
 	if (test_and_clear_bit(BH_Dirty, &bh->b_state)) {
 		if (bh->b_list == BUF_DIRTY)
 			refile_buffer(bh);
-		clear_bit(BH_Wait_IO, &bh->b_state);
 	}
 }
 
--- VM-locked/include/linux/locks.h.~1~	Sun Feb 18 06:31:15 2001
+++ VM-locked/include/linux/locks.h	Sun Feb 18 22:59:09 2001
@@ -29,6 +29,7 @@
 extern inline void unlock_buffer(struct buffer_head *bh)
 {
 	clear_bit(BH_Lock, &bh->b_state);
+	clear_bit(BH_Wait_IO, &bh->b_state);
 	wake_up(&bh->b_wait);
 }
 
Andrea
