Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290012AbSAKQ6N>; Fri, 11 Jan 2002 11:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290019AbSAKQ56>; Fri, 11 Jan 2002 11:57:58 -0500
Received: from 216-42-72-167.ppp.netsville.net ([216.42.72.167]:19843 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S290018AbSAKQ5d>; Fri, 11 Jan 2002 11:57:33 -0500
Date: Fri, 11 Jan 2002 11:56:48 -0500
From: Chris Mason <mason@suse.com>
To: Andre Hedrick <andre@linux-ide.org>, Hans Reiser <reiser@namesys.com>,
        axboe@suse.de
cc: "W. Wilson Ho" <ho@routefree.com>, "Gryaznova E." <grev@namesys.botik.ru>,
        Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>,
        linux-kernel@vger.kernel.org
Subject: Re: elevator algorithm in disk controller bad?
Message-ID: <122730000.1010768208@tiny>
In-Reply-To: <Pine.LNX.4.10.10201110157240.9366-100000@master.linux-ide.org>
In-Reply-To: <Pine.LNX.4.10.10201110157240.9366-100000@master.linux-ide.org>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, January 11, 2002 02:08:39 AM -0800 Andre Hedrick <andre@linux-ide.org> wrote:

> Or something more up to date?
> 
> ide.2.4.16.12102001.patch:+     flushcache:             NULL,
> ide.2.4.16.12102001.patch:+static int do_idedisk_flushcache(ide_drive_t

Andre, filesystems don't understand what an ide_drive_t is ;-)

Here's something against 2.4.17 + ide.2.4.16.12102001 that tries to use 
the flushcache stuff.  It is almost entirely untested, I did make sure 
the flushcache func is actually called, and returns zero.  But, I didn't 
make sure driver->flushcache wasn't the default noop func.

For this to actually be useful, we need a real interface, not some 
internal reiserfs hack.  But, I wanted to make sure I had the idea 
right before going any further...patch below.

Jens, it shouldn't be hard to adapt this to your write barrier stuff too...

-chris

Index: linus.17/fs/reiserfs/journal.c
--- linus.17/fs/reiserfs/journal.c Thu, 13 Dec 2001 11:06:51 -0500 root (linux/b/0_journal.c 1.2.1.1.4.2 644)
+++ linus.17(w)/fs/reiserfs/journal.c Fri, 11 Jan 2002 11:14:27 -0500 root (linux/b/0_journal.c 1.2.1.1.4.2 644)
@@ -736,9 +736,20 @@
 		   atomic_read(&(jl->j_commit_left)));
   }
 
+  /* make sure all the log blocks are on disk before we flush
+  ** the commit
+  */
+  reiserfs_write_barrier(jl->j_commit_bh) ;
+
   mark_buffer_dirty(jl->j_commit_bh) ;
   ll_rw_block(WRITE, 1, &(jl->j_commit_bh)) ;
   wait_on_buffer(jl->j_commit_bh) ;
+
+  /* make sure the commit is on disk before we allow anyone to start
+  ** writing the metadata
+  */
+  reiserfs_write_barrier(jl->j_commit_bh) ;
+
   if (!buffer_uptodate(jl->j_commit_bh)) {
     reiserfs_panic(s, "journal-615: buffer write failed\n") ;
   }
@@ -820,6 +831,9 @@
   if (trans_id >= SB_JOURNAL(p_s_sb)->j_last_flush_trans_id) {
     if (buffer_locked((SB_JOURNAL(p_s_sb)->j_header_bh)))  {
       wait_on_buffer((SB_JOURNAL(p_s_sb)->j_header_bh)) ;
+      /* no need for write barrier here, whoever locked the header bh
+      ** will do that for us.
+      */
       if (!buffer_uptodate(SB_JOURNAL(p_s_sb)->j_header_bh)) {
         reiserfs_panic(p_s_sb, "journal-699: buffer write failed\n") ;
       }
@@ -833,6 +847,9 @@
     set_bit(BH_Dirty, &(SB_JOURNAL(p_s_sb)->j_header_bh->b_state)) ;
     ll_rw_block(WRITE, 1, &(SB_JOURNAL(p_s_sb)->j_header_bh)) ;
     wait_on_buffer((SB_JOURNAL(p_s_sb)->j_header_bh)) ; 
+
+    reiserfs_write_barrier((SB_JOURNAL(p_s_sb)->j_header_bh)) ; 
+
     if (!buffer_uptodate(SB_JOURNAL(p_s_sb)->j_header_bh)) {
       printk( "reiserfs: journal-837: IO error during journal replay\n" );
       return -EIO ;
@@ -1088,6 +1105,11 @@
   if (flushall) {
     update_journal_header_block(s, (jl->j_start + jl->j_len + 2) % JOURNAL_BLOCK_COUNT, jl->j_trans_id) ;
   }
+  /* upddate_journal_header_block takes care of all the write barrier
+  ** requirements.  If writes from older journal lists get reordered before
+  ** the newest list triggers a flush on the journal header block, log replay
+  ** will fix everything for us.
+  */
   remove_all_from_journal_list(s, jl, 0) ;
   jl->j_len = 0 ;
   atomic_set(&(jl->j_nonzerolen), 0) ;
@@ -1101,6 +1123,10 @@
 } 
 
 
+/* kupdate_one_transaction doesn't need to worry about write
+** barriers at all.  That happens during the cleanups triggered by
+** flush_journal_list
+*/
 static int kupdate_one_transaction(struct super_block *s,
                                     struct reiserfs_journal_list *jl) 
 {
@@ -1747,6 +1773,11 @@
 	    CURRENT_TIME - start) ;
   }
   if (!is_read_only(p_s_sb->s_dev) && 
+       /* _update_journal_header_block is the only place during replay 
+       ** we trigger write barriers.  That's ok, if we crash before we 
+       ** hit this point, the same transactions will be replayed again, 
+       ** fixing any write ordering problems introduced.
+       */
        _update_journal_header_block(p_s_sb, SB_JOURNAL(p_s_sb)->j_start, 
                                    SB_JOURNAL(p_s_sb)->j_last_flush_trans_id))
   {
Index: linus.17/fs/reiserfs/Makefile
--- linus.17/fs/reiserfs/Makefile Tue, 27 Nov 2001 23:33:36 -0500 root (linux/b/1_Makefile 1.3 644)
+++ linus.17(w)/fs/reiserfs/Makefile Fri, 11 Jan 2002 10:32:41 -0500 root (linux/b/1_Makefile 1.3 644)
@@ -9,7 +9,7 @@
 
 O_TARGET := reiserfs.o
 obj-y   := bitmap.o do_balan.o namei.o inode.o file.o dir.o fix_node.o super.o prints.o objectid.o \
-lbalance.o ibalance.o stree.o hashes.o buffer2.o tail_conversion.o journal.o resize.o tail_conversion.o version.o item_ops.o ioctl.o procfs.o
+lbalance.o ibalance.o stree.o hashes.o buffer2.o tail_conversion.o journal.o resize.o tail_conversion.o version.o item_ops.o ioctl.o procfs.o writecache.o
 
 obj-m   := $(O_TARGET)
 
Index: linus.17/include/linux/reiserfs_fs.h
--- linus.17/include/linux/reiserfs_fs.h Thu, 13 Dec 2001 11:06:51 -0500 root (linux/k/d/7_reiserfs_f 1.2.2.1.2.1 644)
+++ linus.17(w)/include/linux/reiserfs_fs.h Fri, 11 Jan 2002 10:47:55 -0500 root (linux/k/d/7_reiserfs_f 1.2.2.1.2.1 644)
@@ -1918,6 +1918,9 @@
  
 /* ioctl's command */
 #define REISERFS_IOC_UNPACK		_IOW(0xCD,1,long)
+
+/* from writecache.c */
+int reiserfs_write_barrier(struct buffer_head *bh) ;
  			         
 #endif /* _LINUX_REISER_FS_H */
 
Index: linus.17/fs/reiserfs/writecache.c
--- linus.17/fs/reiserfs/writecache.c Fri, 11 Jan 2002 11:37:11 -0500 root ()
+++ linus.17(w)/fs/reiserfs/writecache.c Fri, 11 Jan 2002 11:26:34 -0500 root (linux/L/d/15_writecache  644)
@@ -0,0 +1,21 @@
+#include <linux/fs.h>
+#include <linux/ide.h>
+
+/* insert a write barrier on the device for this buffer.  All previous
+** requests will be on disk before the next request is
+*/
+int reiserfs_write_barrier(struct buffer_head *bh) {
+    ide_drive_t *drive ;
+    ide_driver_t *d ;
+
+    /* This won't help on lvm or scsi or software raid */
+    drive = get_info_ptr(bh->b_dev) ;
+    if (drive) {
+	d = drive->driver ;
+        if (d->flushcache && d->flushcache(drive)) {
+	    printk (KERN_INFO "%s: Write Cache FAILED Flushing!\n",drive->name);
+	    return -EIO ;
+	} 
+    }
+    return 0 ;
+}

