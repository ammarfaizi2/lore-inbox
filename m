Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265724AbUFIJMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265724AbUFIJMX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 05:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265725AbUFIJMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 05:12:22 -0400
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:9367 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S265724AbUFIJMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 05:12:09 -0400
Date: Wed, 9 Jun 2004 10:12:08 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [2.6.7-bk patch] Update Documentation/filesystems/Locking 
Message-ID: <Pine.SOL.4.58.0406091003330.28207@orange.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, hi Linus,

As I discovered while working on NTFS and as agreed by Andrew, a
filesystem's ->writepage() implementation nowadays must run either
redirty_page_for_writepage() or the combination of set_page_writeback()/
end_page_writeback().  Failure to do so leaves the page itself marked
clean but it is tagged as dirty in the radix tree (PAGECACHE_TAG_DIRTY).
This incoherency can lead to all sorts of hard-to-debug problems in the
filesystem like having dirty inodes at umount and losing written data.

Please apply the below patch which updates
Documentation/filesystems/Locking to reflect this requirement.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

--- bklinux-2.6/Documentation/filesystems/Locking.old	2004-06-09 09:34:23.808663656 +0100
+++ bklinux-2.6/Documentation/filesystems/Locking	2004-06-09 09:57:52.315538064 +0100
@@ -203,20 +203,34 @@ currently-in-progress I/O.

 If the filesystem is not called for "sync" and it determines that it
 would need to block against in-progress I/O to be able to start new I/O
-against the page the filesystem shoud redirty the page (usually with
-__set_page_dirty_nobuffers()), then unlock the page and return zero.
+against the page the filesystem should redirty the page with
+redirty_page_for_writepage(), then unlock the page and return zero.
 This may also be done to avoid internal deadlocks, but rarely.

 If the filesytem is called for sync then it must wait on any
 in-progress I/O and then start new I/O.

 The filesystem should unlock the page synchronously, before returning
-to the caller.  If the page has write I/O underway against it,
-writepage() should run SetPageWriteback() against the page prior to
-unlocking it.  The write I/O completion handler should run
-end_page_writeback() against the page.
+to the caller.

-That is: after 2.5.12, pages which are under writeout are *not* locked.
+Unless the filesystem is going to redirty_page_for_writepage(), unlock the page
+and return zero, writepage *must* run set_page_writeback() against the page,
+followed by unlocking it.  Once set_page_writeback() has been run against the
+page, write I/O can be submitted and the write I/O completion handler must run
+end_page_writeback() once the I/O is complete.  If no I/O is submitted, the
+filesystem must run end_page_writeback() against the page before returning from
+writepage.
+
+That is: after 2.5.12, pages which are under writeout are *not* locked.  Note,
+if the filesystem needs the page to be locked during writeout, that is ok, too,
+the page is allowed to be unlocked at any point in time between the calls to
+set_page_writeback() and end_page_writeback().
+
+Note, failure to run either redirty_page_for_writepage() or the combination of
+set_page_writeback()/end_page_writeback() on a page submitted to writepage
+will leave the page itself marked clean but it will be tagged as dirty in the
+radix tree.  This incoherency can lead to all sorts of hard-to-debug problems
+in the filesystem like having dirty inodes at umount and losing written data.

 	->sync_page() locking rules are not well-defined - usually it is called
 with lock on page, but that is not guaranteed. Considering the currently
