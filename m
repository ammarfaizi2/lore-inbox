Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270408AbTGRVle (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 17:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271880AbTGRVku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 17:40:50 -0400
Received: from inet-mail1.oracle.com ([148.87.2.201]:6836 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id S271824AbTGRVjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 17:39:40 -0400
Date: Fri, 18 Jul 2003 14:54:22 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: marcelo@conectiva.com.br
Cc: sct@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH-2.4] [RESEND] Fix deadlock in journal_create
Message-ID: <20030718215421.GF1014@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Oracle Corporation
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,
	I sent this initially against 2.4.21-rc6 and it didn't make it in
 -- even though it got Stephen's OK. Here's a resend -- I've identified that
the bug still exists and 2.4.22-pre7. The patch didn't need to be changed as
it still applies cleanly.

	I ran across a deadlock when trying to do a journal_create
at mount time. The problem is that journal_create does a sync_dev which
eventually tries to do a get_super which does:

down_read(&s->s_umount);

The problem arises if I call journal_create from my read_super method in
which case get_sb_bdev has already done:

down_write(&s->s_umount);

from alloc_super. Replacing the sync_dev call with an fsync_no_super seems
to have fixed the deadlock. 

It you want to test this out using ext3 (I have verified it with my own
filesystem), simply follow these steps:
1) create an ext2 filesystem on a device
2) mount that new partition and make a "journal file" on it (using dd).
get the inode number of that file.
3) unmount it and remount it as an ext3 filesystem using the option:
journal=inode_number where inode number is the inode number of the journal
file you just created.
This will get ext3's read_super method to call ext3_create_journal which
will hang during a journal_create.

A trivial patch to fix this is attached.
	--Mark

--
Mark Fasheh
Software Developer, Oracle Corp
mark.fasheh@oracle.com

--- linux-2.4.22-pre7/fs/jbd/journal.c.orig	2003-05-30 11:49:10.000000000 -0700
+++ linux-2.4.22-pre7/fs/jbd/journal.c	2003-05-30 11:49:18.000000000 -0700
@@ -912,7 +912,7 @@ int journal_create(journal_t *journal)
 		__brelse(bh);
 	}
 
-	sync_dev(journal->j_dev);
+	fsync_no_super(journal->j_dev);
 	jbd_debug(1, "JBD: journal cleared.\n");
 
 	/* OK, fill in the initial static fields in the new superblock */
