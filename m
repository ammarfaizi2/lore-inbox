Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289874AbSAPFRH>; Wed, 16 Jan 2002 00:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289867AbSAPFQs>; Wed, 16 Jan 2002 00:16:48 -0500
Received: from [202.135.142.196] ([202.135.142.196]:46345 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S289874AbSAPFQc>; Wed, 16 Jan 2002 00:16:32 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] need_resched abstraction 
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, dhowells@redhat.com,
        linux-kernel@vger.kernel.org, akpm@zip.com.au
In-Reply-To: Your message of "Tue, 15 Jan 2002 19:06:05 -0800."
             <Pine.LNX.4.33.0201151904120.1357-100000@penguin.transmeta.com> 
Date: Wed, 16 Jan 2002 16:16:39 +1100
Message-Id: <E16QiRE-0006zc-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.33.0201151904120.1357-100000@penguin.transmeta.com> you 
write:
> 
> On Wed, 16 Jan 2002, Rusty Russell wrote:
> > ... And I prefer maybe_schedule().
> 
> My tree calls them "cond_resched()" and "need_resched()" respectively.

Bastard!  Then please apply (thanks to Andrew Morton):

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.3-pre1/drivers/block/ll_rw_blk.c working-2.5.3-pre1-ll/drivers/block/ll_rw_blk.c
--- linux-2.5.3-pre1/drivers/block/ll_rw_blk.c	Tue Jan 15 17:25:32 2002
+++ working-2.5.3-pre1-ll/drivers/block/ll_rw_blk.c	Wed Jan 16 16:15:10 2002
@@ -996,6 +996,7 @@
 		if (++rl->count >= batch_requests &&waitqueue_active(&rl->wait))
 			wake_up(&rl->wait);
 	}
+	cond_resched();
 }
 
 /*
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.3-pre1/fs/buffer.c working-2.5.3-pre1-ll/fs/buffer.c
--- linux-2.5.3-pre1/fs/buffer.c	Tue Jan 15 17:25:47 2002
+++ working-2.5.3-pre1-ll/fs/buffer.c	Wed Jan 16 16:15:10 2002
@@ -250,12 +250,19 @@
 	struct buffer_head * next;
 	int nr;
 
-	next = lru_list[index];
 	nr = nr_buffers_type[index];
+repeat:
+	next = lru_list[index];
 	while (next && --nr >= 0) {
 		struct buffer_head *bh = next;
 		next = bh->b_next_free;
 
+		if (dev == NODEV && need_resched()) {
+			spin_unlock(&lru_list_lock);
+			cond_resched();
+			spin_lock(&lru_list_lock);
+			goto repeat;
+		}
 		if (!buffer_locked(bh)) {
 			if (refile)
 				__refile_buffer(bh);
@@ -1180,8 +1187,10 @@
 	struct buffer_head * bh = __getblk(bdev, block, size);
 
 	touch_buffer(bh);
-	if (buffer_uptodate(bh))
+	if (buffer_uptodate(bh)) {
+		cond_resched();
 		return bh;
+	}
 	ll_rw_block(READ, 1, &bh);
 	wait_on_buffer(bh);
 	if (buffer_uptodate(bh))
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.3-pre1/fs/dcache.c working-2.5.3-pre1-ll/fs/dcache.c
--- linux-2.5.3-pre1/fs/dcache.c	Tue Jan 15 17:25:47 2002
+++ working-2.5.3-pre1-ll/fs/dcache.c	Wed Jan 16 16:15:10 2002
@@ -84,6 +84,7 @@
 			iput(inode);
 	} else
 		spin_unlock(&dcache_lock);
+	cond_resched();
 }
 
 /* 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.3-pre1/fs/jbd/commit.c working-2.5.3-pre1-ll/fs/jbd/commit.c
--- linux-2.5.3-pre1/fs/jbd/commit.c	Tue Jan 15 17:25:48 2002
+++ working-2.5.3-pre1-ll/fs/jbd/commit.c	Wed Jan 16 16:15:10 2002
@@ -212,6 +212,16 @@
 				__journal_remove_journal_head(bh);
 				refile_buffer(bh);
 				__brelse(bh);
+				if (need_resched()) {
+					if (commit_transaction->t_sync_datalist)
+						commit_transaction->t_sync_datalist =
+							next_jh;
+					if (bufs)
+						break;
+					spin_unlock(&journal_datalist_lock);
+					cond_resched();
+					goto write_out_data;
+				}
 			}
 		}
 		if (bufs == ARRAY_SIZE(wbuf)) {
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.3-pre1/fs/proc/array.c working-2.5.3-pre1-ll/fs/proc/array.c
--- linux-2.5.3-pre1/fs/proc/array.c	Wed Jan 16 10:52:29 2002
+++ working-2.5.3-pre1-ll/fs/proc/array.c	Wed Jan 16 16:15:10 2002
@@ -419,6 +419,8 @@
 		pte_t page = *pte;
 		struct page *ptpage;
 
+		cond_resched();
+
 		address += PAGE_SIZE;
 		pte++;
 		if (pte_none(page))
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.3-pre1/fs/proc/generic.c working-2.5.3-pre1-ll/fs/proc/generic.c
--- linux-2.5.3-pre1/fs/proc/generic.c	Sat Sep  8 03:53:59 2001
+++ working-2.5.3-pre1-ll/fs/proc/generic.c	Wed Jan 16 16:15:10 2002
@@ -98,7 +98,9 @@
 				retval = n;
 			break;
 		}
-		
+
+		cond_resched();
+
 		/* This is a hack to allow mangling of file pos independent
  		 * of actual bytes read.  Simply place the data at page,
  		 * return the bytes, and set `start' to the desired offset
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.3-pre1/mm/filemap.c working-2.5.3-pre1-ll/mm/filemap.c
--- linux-2.5.3-pre1/mm/filemap.c	Wed Jan 16 10:52:30 2002
+++ working-2.5.3-pre1-ll/mm/filemap.c	Wed Jan 16 16:15:10 2002
@@ -603,6 +603,7 @@
 			UnlockPage(page);
 
 		page_cache_release(page);
+		cond_resched();
 		spin_lock(&pagecache_lock);
 	}
 	spin_unlock(&pagecache_lock);
@@ -1386,6 +1387,9 @@
 		offset &= ~PAGE_CACHE_MASK;
 
 		page_cache_release(page);
+
+		cond_resched();
+
 		if (ret == nr && desc->count)
 			continue;
 		break;
@@ -3019,6 +3023,8 @@
 		SetPageReferenced(page);
 		UnlockPage(page);
 		page_cache_release(page);
+
+		cond_resched();
 
 		if (status < 0)
 			break;
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
