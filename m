Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280588AbRLQPts>; Mon, 17 Dec 2001 10:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280825AbRLQPti>; Mon, 17 Dec 2001 10:49:38 -0500
Received: from [212.16.7.124] ([212.16.7.124]:52866 "HELO laputa.namesys.com")
	by vger.kernel.org with SMTP id <S280805AbRLQPt2>;
	Mon, 17 Dec 2001 10:49:28 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15390.4943.64152.676583@laputa.namesys.com>
Date: Mon, 17 Dec 2001 18:46:23 +0300
To: Linus Torvalds <Torvalds@Transmeta.COM>
Cc: Reiserfs developers mail-list <Reiserfs-Dev@Namesys.COM>,
        "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: [PATCH]: reiserfs: B-check_nlink_in_reiserfs_read_inode2.patch
X-Mailer: VM 6.96 under 21.4 (patch 3) "Academic Rigor" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

    This patch closes a race between iput() and threads accessing files
    directly by "inode numbers" (i.e., bypassing directory lookup) like
    knfsd.

    Suppose, last reference to file is being unlinked and iput() sleeps
    in sb->s_op->delete_inode(), after removing inode from hash
    table. At this moment "knfsd" comes and looks for this inode. Inode
    is not found in hash table, new instance is created and
    hashed. ->read_inode() is called only to find that on disk inode is
    there, still not deleted by sb->s_op->delete_inode(), so
    ->read_inode() returns successfully. Now, delete_inode() wakes up
    and removes remaining meta-data. At this moment we have valid inode
    in memory without meta-data on disk.

    Reiserfs updates on-disk meta-data including nlink during unlink(),
    so it's enough to check nlink during reiserfs_read_inode2(). This is
    _not_ enough to fix this race for ext2.

Please apply.

Nikita.
diff -rup -X dontdiff linux/fs/reiserfs/inode.c linux.patched/fs/reiserfs/inode.c
--- linux/fs/reiserfs/inode.c	Wed Oct 31 02:11:34 2001
+++ linux.patched/fs/reiserfs/inode.c	Mon Nov 26 15:27:09 2001
@@ -1138,6 +1138,30 @@ void reiserfs_read_inode2 (struct inode 
     }
 
     init_inode (inode, &path_to_sd);
+   
+    /* It is possible that knfsd is trying to access inode of a file
+       that is being removed from the disk by some other thread. As we
+       update sd on unlink all that is required is to check for nlink
+       here. This bug was first found by Sizif when debugging
+       SquidNG/Butterfly, forgotten, and found again after Philippe
+       Gramoulle <philippe.gramoulle@mmania.com> reproduced it. 
+
+       More logical fix would require changes in fs/inode.c:iput() to
+       remove inode from hash-table _after_ fs cleaned disk stuff up and
+       in iget() to return NULL if I_FREEING inode is found in
+       hash-table. */
+    /* Currently there is one place where it's ok to meet inode with
+       nlink==0: processing of open-unlinked and half-truncated files
+       during mount (fs/reiserfs/super.c:finish_unfinished()). */
+    if( ( inode -> i_nlink == 0 ) && 
+	! inode -> i_sb -> u.reiserfs_sb.s_is_unlinked_ok ) {
+	    reiserfs_warning( "vs-13075: reiserfs_read_inode2: "
+			      "dead inode read from disk %K. "
+			      "This is likely to be race with knfsd. Ignore\n", 
+			      &key );
+	    make_bad_inode( inode );
+    }
+
     reiserfs_check_path(&path_to_sd) ; /* init inode should be relsing */
 
 }
diff -rup -X dontdiff linux/include/linux/reiserfs_fs_sb.h linux.patched/include/linux/reiserfs_fs_sb.h
--- linux/include/linux/reiserfs_fs_sb.h	Thu Nov 22 22:46:19 2001
+++ linux.patched/include/linux/reiserfs_fs_sb.h	Mon Nov 26 15:22:44 2001
@@ -420,6 +420,10 @@ struct reiserfs_sb_info
     int s_bmaps_without_search;
     int s_direct2indirect;
     int s_indirect2direct;
+	/* set up when it's ok for reiserfs_read_inode2() to read from
+	   disk inode with nlink==0. Currently this is only used during
+	   finish_unfinished() processing at mount time */
+    int s_is_unlinked_ok;
     reiserfs_proc_info_data_t s_proc_info_data;
     struct proc_dir_entry *procdir;
 };
