Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129300AbRCBQxv>; Fri, 2 Mar 2001 11:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129306AbRCBQxm>; Fri, 2 Mar 2001 11:53:42 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:43792 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S129300AbRCBQx2>; Fri, 2 Mar 2001 11:53:28 -0500
Date: Fri, 2 Mar 2001 19:54:52 +0300
From: Alexander Zarochentcev <zam@namesys.com>
To: torvalds@transmeta.com, alan@redhat.com
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: [PATCH] adds missed lock_kernel/unlock_kernel to reiserfs_dir_fsync().
Message-ID: <20010302195452.A2133@crimson.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

Bug found in reiserfs in linux-2.4.2: reiserfs_dir_fsync has no
lock_kernel/unlock_kernel calls which are required by reiserfs journal
interface functions.  It causes reserfs_panic in any attempt to fsync a
directory (on SMP machines).

Bug report was related to qmail which likes to
fsync a directory.

This trivial fix cures the problem:

--- linux.old/fs/reiserfs/dir.c Fri Mar  2 14:48:12 2001
+++ linux/fs/reiserfs/dir.c     Fri Mar  2 14:49:31 2001
@@ -51,12 +51,16 @@
   int windex ;
   struct reiserfs_transaction_handle th ;

+  lock_kernel();
+
   journal_begin(&th, dentry->d_inode->i_sb, 1) ;
   windex = push_journal_writer("dir_fsync") ;
   reiserfs_prepare_for_journal(th.t_super, SB_BUFFER_WITH_SB(th.t_super), 1) ;
   journal_mark_dirty(&th, dentry->d_inode->i_sb, SB_BUFFER_WITH_SB (dentry->d_inode->i_sb)) ;
   pop_journal_writer(windex) ;
   journal_end_sync(&th, dentry->d_inode->i_sb, 1) ;
+
+  unlock_kernel();

   return ret ;
 }


Regards,
Alex.

