Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315942AbSEZUkX>; Sun, 26 May 2002 16:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316388AbSEZUjC>; Sun, 26 May 2002 16:39:02 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43792 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316374AbSEZUhy>;
	Sun, 26 May 2002 16:37:54 -0400
Message-ID: <3CF14860.30A48829@zip.com.au>
Date: Sun, 26 May 2002 13:41:04 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 6/18] relax nr_to_write requirements
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Relax the requirements on the writeback_mapping a_op.

This function is passed the number of pages which it should write.  The
current fs-writeback.c code will get confused if the address_space
writes back more pages than it was asked to.

With this change the address_space may write more pages than required
if that is convenient.  Extent-based fileystems may wish to do this.

=====================================

--- 2.5.18/fs/fs-writeback.c~relax-nr-to_write	Sat May 25 23:26:46 2002
+++ 2.5.18-akpm/fs/fs-writeback.c	Sun May 26 00:50:19 2002
@@ -257,7 +257,7 @@ static void sync_sb_inodes(struct super_
 		if (current_is_pdflush())
 			writeback_release(bdi);
 
-		if (nr_to_write && *nr_to_write == 0)
+		if (nr_to_write && *nr_to_write <= 0)
 			break;
 	}
 out:
@@ -301,7 +301,7 @@ void writeback_unlocked_inodes(int *nr_t
 					older_than_this);
 			spin_lock(&sb_lock);
 		}
-		if (nr_to_write && *nr_to_write == 0)
+		if (nr_to_write && *nr_to_write <= 0)
 			break;
 	}
 	spin_unlock(&sb_lock);
--- 2.5.18/Documentation/filesystems/Locking~relax-nr-to_write	Sat May 25 23:26:46 2002
+++ 2.5.18-akpm/Documentation/filesystems/Locking	Sun May 26 00:50:22 2002
@@ -179,11 +179,12 @@ existing instances of this method ->sync
 well-defined...
 
 	->writeback_mapping() is used for periodic writeback and for
-systemcall-initiated sync operations. The address_space should start
-I/O against at least *nr_to_write pages.  *nr_to_write must be decremented
-for each page which is written.  *nr_to_write must not go negative (this
-will be relaxed later).  If nr_to_write is NULL, all dirty pages must
-be written.
+systemcall-initiated sync operations.  The address_space should start
+I/O against at least *nr_to_write pages.  *nr_to_write must be
+decremented for each page which is written.  The address_space
+implementation may write more (or less) pages than *nr_to_write asks
+for, but it should try to be reasonably close.  If nr_to_write is NULL,
+all dirty pages must be written.
 
 	->vm_writeback() is called from the VM.  The address_space should
 start I/O against at least *nr_to_write pages, including the passed page. As


-
