Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269293AbUINLpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269293AbUINLpV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 07:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269282AbUINLoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 07:44:10 -0400
Received: from mx2.elte.hu ([157.181.151.9]:5529 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269291AbUINLl4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 07:41:56 -0400
Date: Tue, 14 Sep 2004 13:42:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] sched: fix scheduling latencies for !PREEMPT kernels
Message-ID: <20040914114228.GD2804@elte.hu>
References: <20040914095731.GA24622@elte.hu> <20040914100652.GB24622@elte.hu> <20040914101904.GD24622@elte.hu> <20040914102517.GE24622@elte.hu> <20040914104449.GA30790@elte.hu> <20040914105048.GA31238@elte.hu> <20040914105904.GB31370@elte.hu> <20040914110237.GC31370@elte.hu> <20040914110611.GA32077@elte.hu> <20040914112847.GA2804@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="xo44VMWPx7vlQ2+2"
Content-Disposition: inline
In-Reply-To: <20040914112847.GA2804@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xo44VMWPx7vlQ2+2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


this patch adds a handful of cond_resched() points to a number of
key, scheduling-latency related non-inlined functions.

this reduces preemption latency for !PREEMPT kernels. These are
scheduling points complementary to PREEMPT_VOLUNTARY scheduling
points (might_sleep() places) - i.e. these are all points where
an explicit cond_resched() had to be added.

has been tested as part of the -VP patchset.

	Ingo

--xo44VMWPx7vlQ2+2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fix-latency-nopreempt.patch"


this patch adds a handful of cond_resched() points to a number of
key, scheduling-latency related non-inlined functions.

this reduces preemption latency for !PREEMPT kernels. These are
scheduling points complementary to PREEMPT_VOLUNTARY scheduling
points (might_sleep() places) - i.e. these are all points where
an explicit cond_resched() had to be added.

has been tested as part of the -VP patchset.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/fs/exec.c.orig	
+++ linux/fs/exec.c	
@@ -184,6 +184,7 @@ static int count(char __user * __user * 
 			argv++;
 			if(++i > max)
 				return -E2BIG;
+			cond_resched();
 		}
 	}
 	return i;
--- linux/fs/fs-writeback.c.orig	
+++ linux/fs/fs-writeback.c	
@@ -366,6 +366,7 @@ sync_sb_inodes(struct super_block *sb, s
 			list_move(&inode->i_list, &sb->s_dirty);
 		}
 		spin_unlock(&inode_lock);
+		cond_resched();
 		iput(inode);
 		spin_lock(&inode_lock);
 		if (wbc->nr_to_write <= 0)
--- linux/fs/select.c.orig	
+++ linux/fs/select.c	
@@ -239,6 +239,7 @@ int do_select(int n, fd_set_bits *fds, l
 						retval++;
 					}
 				}
+				cond_resched();
 			}
 			if (res_in)
 				*rinp = res_in;
--- linux/kernel/printk.c.orig	
+++ linux/kernel/printk.c	
@@ -280,6 +280,7 @@ int do_syslog(int type, char __user * bu
 			error = __put_user(c,buf);
 			buf++;
 			i++;
+			cond_resched();
 			spin_lock_irq(&logbuf_lock);
 		}
 		spin_unlock_irq(&logbuf_lock);
@@ -321,6 +322,7 @@ int do_syslog(int type, char __user * bu
 			c = LOG_BUF(j);
 			spin_unlock_irq(&logbuf_lock);
 			error = __put_user(c,&buf[count-1-i]);
+			cond_resched();
 			spin_lock_irq(&logbuf_lock);
 		}
 		spin_unlock_irq(&logbuf_lock);
@@ -336,6 +338,7 @@ int do_syslog(int type, char __user * bu
 					error = -EFAULT;
 					break;
 				}
+				cond_resched();
 			}
 		}
 		break;
--- linux/mm/memory.c.orig	
+++ linux/mm/memory.c	
@@ -1516,6 +1516,7 @@ do_no_page(struct mm_struct *mm, struct 
 	}
 	smp_rmb();  /* Prevent CPU from reordering lock-free ->nopage() */
 retry:
+	cond_resched();
 	new_page = vma->vm_ops->nopage(vma, address & PAGE_MASK, &ret);
 
 	/* no page was available -- either SIGBUS or OOM */
--- linux/mm/slab.c.orig	
+++ linux/mm/slab.c	
@@ -2793,7 +2793,7 @@ static void cache_reap(void *unused)
 next_unlock:
 		spin_unlock_irq(&searchp->spinlock);
 next:
-		;
+		cond_resched();
 	}
 	check_irq_on();
 	up(&cache_chain_sem);
--- linux/mm/vmscan.c.orig	
+++ linux/mm/vmscan.c	
@@ -361,6 +361,8 @@ static int shrink_list(struct list_head 
 		int may_enter_fs;
 		int referenced;
 
+		cond_resched();
+
 		page = lru_to_page(page_list);
 		list_del(&page->lru);
 
@@ -710,6 +712,7 @@ refill_inactive_zone(struct zone *zone, 
 		reclaim_mapped = 1;
 
 	while (!list_empty(&l_hold)) {
+		cond_resched();
 		page = lru_to_page(&l_hold);
 		list_del(&page->lru);
 		if (page_mapped(page)) {

--xo44VMWPx7vlQ2+2--
