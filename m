Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312498AbSDJGw6>; Wed, 10 Apr 2002 02:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312499AbSDJGw5>; Wed, 10 Apr 2002 02:52:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40971 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312498AbSDJGw4>;
	Wed, 10 Apr 2002 02:52:56 -0400
Message-ID: <3CB3E145.BDBC6124@zip.com.au>
Date: Tue, 09 Apr 2002 23:52:53 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] use pdflush for unused inode writeback
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is pdflush's first application!  The writeback of
the unused inodes list by keventd is removed, and a
pdflush thread is dispatched instead.
 
There is a need for exclusion - to prevent all the
pdflush threads from working against the same request
queue.  This is implemented locally.  And this is a 
problem, because other pdflush threads can be dispatched
to writeback other filesystem objects, and they don't
know that there's already a pdflush thread working that
request queue.

So moving the exclusion into the request queue itself
is on my things-to-do-list.  But the code as-is works
OK - under a `dbench 100' load the number of pdflush
instances can grow as high as four or five.  Some fine
tuning is needed...

Patch is against 2.5.8-pre3+ratcache+readahead+pageprivate+pdflush


--- 2.5.8-pre3/fs/inode.c~dallocbase-45-pdflush_inodes	Tue Apr  9 22:53:11 2002
+++ 2.5.8-pre3-akpm/fs/inode.c	Tue Apr  9 22:53:11 2002
@@ -433,7 +433,7 @@ void sync_inodes(void)
 	}
 }
 
-static void try_to_sync_unused_inodes(void * arg)
+static void try_to_sync_unused_inodes(unsigned long pexclusive)
 {
 	struct super_block * sb;
 	int nr_inodes = inodes_stat.nr_unused;
@@ -450,10 +450,9 @@ static void try_to_sync_unused_inodes(vo
 	}
 	spin_unlock(&sb_lock);
 	spin_unlock(&inode_lock);
+	clear_bit(0, (unsigned long *)pexclusive);
 }
 
-static struct tq_struct unused_inodes_flush_task;
-
 /**
  *	write_inode_now	-	write an inode to disk
  *	@inode: inode to write to disk
@@ -746,8 +745,15 @@ void prune_icache(int goal)
 	 * from here or we're either synchronously dogslow
 	 * or we deadlock with oom.
 	 */
-	if (goal)
-		schedule_task(&unused_inodes_flush_task);
+	if (goal) {
+		static unsigned long exclusive;
+
+		if (!test_and_set_bit(0, &exclusive)) {
+			if (pdflush_operation(try_to_sync_unused_inodes,
+						(unsigned long)&exclusive))
+				clear_bit(0, &exclusive);
+		}
+	}
 }
 /*
  * This is called from kswapd when we think we need some
@@ -1173,8 +1179,6 @@ void __init inode_init(unsigned long mem
 					 NULL);
 	if (!inode_cachep)
 		panic("cannot create inode slab cache");
-
-	unused_inodes_flush_task.routine = try_to_sync_unused_inodes;
 }
 
 static inline void do_atime_update(struct inode *inode)

-
