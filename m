Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132426AbRAPTKP>; Tue, 16 Jan 2001 14:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132422AbRAPTKF>; Tue, 16 Jan 2001 14:10:05 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:7441 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S132388AbRAPTJs>; Tue, 16 Jan 2001 14:09:48 -0500
Date: Tue, 16 Jan 2001 14:12:23 -0500
From: Chris Mason <mason@suse.com>
To: Jakob Borg <jakob@borg.pp.se>, linux-kernel@vger.kernel.org
cc: torvalds@transmeta.com
Subject: Re: More information on reiserfs bug
Message-ID: <208780000.979672343@tiny>
In-Reply-To: <20010116193858.A733@borg.pp.se>
X-Mailer: Mulberry/2.0.6b1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday, January 16, 2001 07:38:58 PM +0100 Jakob Borg
<jakob@borg.pp.se> wrote:

> Hi again,
> 
> It seems the problem occurs every time i start fetchmail... Attached are
> ksymoops output and .config (if i remember this time). If there is
> anything else I can do to help debug this, just tell me

Linus fixed that hunk of debugging code in his merge, and it found a bug in
the reiserfs O_SYNC support.  reiserfs_commit_write needs to hold the BKL.

This should fix it:

--- linux/fs/reiserfs/inode.c.1	Tue Jan 16 13:46:35 2001
+++ linux/fs/reiserfs/inode.c	Tue Jan 16 13:49:21 2001
@@ -1853,6 +1853,11 @@
     struct reiserfs_transaction_handle th ;
     
     reiserfs_wait_on_write_block(inode->i_sb) ;
+
+    /* prevent_flush_page_lock must be called before generic_commit_write,
+    ** and the BKL must be held during the call.
+    */
+    lock_kernel() ;
     prevent_flush_page_lock(page, inode) ;
     ret = generic_commit_write(f, page, from, to) ;
     /* we test for O_SYNC here so we can commit the transaction
@@ -1866,6 +1871,8 @@
 	journal_end_sync(&th, inode->i_sb, 1) ;
     }
     allow_flush_page_lock(page, inode) ;
+    unlock_kernel() ;
+
     return ret ;
 }
 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
