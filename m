Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135679AbRA1Lpk>; Sun, 28 Jan 2001 06:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136168AbRA1LpV>; Sun, 28 Jan 2001 06:45:21 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:56262 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S135679AbRA1LpO>; Sun, 28 Jan 2001 06:45:14 -0500
Message-ID: <3A740682.3FB72EF4@uow.edu.au>
Date: Sun, 28 Jan 2001 22:46:10 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Shawn Starr <Shawn.Starr@Home.net>
CC: Shawn Starr <Shawn.Starr@Home.com>, Chris Mason <mason@suse.com>,
        "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.x and 2.4.1-preX - Higher latency then 2.2.xkernels?
In-Reply-To: <186870000.980100593@tiny> <3A6B6FDE.93AF69CC@Home.net> <3A72820A.1488BDC@uow.edu.au> <3A7280F5.F122FE35@Home.com> <3A738A36.F6294623@Home.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn Starr wrote:
> 
> Andrew, the patch HAS made a difference. For example, while untaring glibc-2.2.1.tar.gz the
> system was not sluggish (mouse movements in X) etc.
> 
> Seems to be a go for latency improvements on this system.

Shawn,

could you please try this patch in a pristine 2.4.1-pre10? It
gets reiserfs down to 4 milliseconds worst case.  If the
system's interactivity is still sluggish with this then
reiserfs isn't the cause.


Thanks.

--- linux-2.4.1-pre10/include/linux/reiserfs_fs.h	Tue Jan 23 19:28:16 2001
+++ linux-akpm/include/linux/reiserfs_fs.h	Sun Jan 28 22:37:11 2001
@@ -1161,7 +1161,8 @@
 #define fs_generation(s) ((s)->u.reiserfs_sb.s_generation_counter)
 #define get_generation(s) atomic_read (&fs_generation(s))
 #define FILESYSTEM_CHANGED_TB(tb)  (get_generation((tb)->tb_sb) != (tb)->fs_gen)
-#define fs_changed(gen,s) (gen != get_generation (s))
+#define __fs_changed(gen,s) (gen != get_generation (s))
+#define fs_changed(gen,s) ({if (current->need_resched) schedule(); __fs_changed(gen,s);})
 
 
 /***************************************************************************/
--- linux-2.4.1-pre10/fs/reiserfs/journal.c	Tue Jan 23 19:28:15 2001
+++ linux-akpm/fs/reiserfs/journal.c	Sun Jan 28 22:31:12 2001
@@ -2649,6 +2649,8 @@
       }
 #endif
       wait_on_buffer(bh) ;
+      if (current->need_resched)
+	schedule();
     }
     retry_count++ ;
   }
@@ -3085,6 +3087,8 @@
     /* copy all the real blocks into log area.  dirty log blocks */
     if (test_bit(BH_JDirty, &cn->bh->b_state)) {
       struct buffer_head *tmp_bh ;
+      if (current->need_resched)
+        schedule();
       tmp_bh = getblk(p_s_sb->s_dev, reiserfs_get_journal_block(p_s_sb) + 
 		     ((cur_write_start + jindex) % JOURNAL_BLOCK_COUNT), 
 				       p_s_sb->s_blocksize) ;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
