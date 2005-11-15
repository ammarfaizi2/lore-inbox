Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbVKOF0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbVKOF0h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 00:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbVKOF0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 00:26:37 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:59851 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751294AbVKOF0g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 00:26:36 -0500
Date: Mon, 14 Nov 2005 23:51:10 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org, frankeh@watson.ibm.com, haveblue@us.ibm.com
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
Message-ID: <20051115055107.GB3252@IBM-BWN8ZTBWAO1>
References: <20051114212341.724084000@sergelap> <20051114153649.75e265e7.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051114153649.75e265e7.pj@sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Jackson (pj@sgi.com):
> Have you crosstool'd built this for most arch's?  I could imagine
> some piece of code having a local or other struct variable named 'pid'
> that would be broken by a mistake in this change.  This could be so
> whether the change was done by a script, or by hand.  Probably need
> to test 'allyesconfig' too.

Argh - in fact it appears I compiled and booted my 2.6.14 version,
not this 2.6.15-rc1 version.  Another patch is needed for this to
compile and boot (on a power5 system, in addition to a patch pending
for -mm to make rpaphp_pci compile).  Sorry.

Signed-off-by: Serge Hallyn <serue@us.ibm.com>
---
 block/cfq-iosched.c |    4 ++--
 block/ll_rw_blk.c   |    2 +-
 kernel/ptrace.c     |    2 +-
 net/llc/af_llc.c    |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

Index: linux-2.6.14/kernel/ptrace.c
===================================================================
--- linux-2.6.14.orig/kernel/ptrace.c	2005-11-14 22:52:24.000000000 -0600
+++ linux-2.6.14/kernel/ptrace.c	2005-11-14 22:54:37.000000000 -0600
@@ -155,7 +155,7 @@ int ptrace_attach(struct task_struct *ta
 	retval = -EPERM;
 	if (task_pid(task) <= 1)
 		goto bad;
-	if (task->tgid == current->tgid)
+	if (task_tgid(task) == task_tgid(current))
 		goto bad;
 	/* the same process cannot be attached many times */
 	if (task->ptrace & PT_PTRACED)
Index: linux-2.6.14/block/ll_rw_blk.c
===================================================================
--- linux-2.6.14.orig/block/ll_rw_blk.c	2005-11-14 22:52:07.000000000 -0600
+++ linux-2.6.14/block/ll_rw_blk.c	2005-11-14 23:07:51.000000000 -0600
@@ -2925,7 +2925,7 @@ void submit_bio(int rw, struct bio *bio)
 	if (unlikely(block_dump)) {
 		char b[BDEVNAME_SIZE];
 		printk(KERN_DEBUG "%s(%d): %s block %Lu on %s\n",
-			current->comm, current->pid,
+			current->comm, task_pid(current),
 			(rw & WRITE) ? "WRITE" : "READ",
 			(unsigned long long)bio->bi_sector,
 			bdevname(bio->bi_bdev,b));
Index: linux-2.6.14/block/cfq-iosched.c
===================================================================
--- linux-2.6.14.orig/block/cfq-iosched.c	2005-11-14 22:52:07.000000000 -0600
+++ linux-2.6.14/block/cfq-iosched.c	2005-11-14 23:08:44.000000000 -0600
@@ -621,7 +621,7 @@ cfq_reposition_crq_rb(struct cfq_queue *
 static struct request *cfq_find_rq_rb(struct cfq_data *cfqd, sector_t sector)
 
 {
-	struct cfq_queue *cfqq = cfq_find_cfq_hash(cfqd, current->pid, CFQ_KEY_ANY);
+	struct cfq_queue *cfqq = cfq_find_cfq_hash(cfqd, task_pid(current), CFQ_KEY_ANY);
 	struct rb_node *n;
 
 	if (!cfqq)
@@ -1754,7 +1754,7 @@ static void cfq_prio_boost(struct cfq_qu
 static inline pid_t cfq_queue_pid(struct task_struct *task, int rw)
 {
 	if (rw == READ || process_sync(task))
-		return task->pid;
+		return task_pid(task);
 
 	return CFQ_KEY_ASYNC;
 }
Index: linux-2.6.14/net/llc/af_llc.c
===================================================================
--- linux-2.6.14.orig/net/llc/af_llc.c	2005-10-27 19:02:08.000000000 -0500
+++ linux-2.6.14/net/llc/af_llc.c	2005-11-14 23:09:44.000000000 -0600
@@ -757,7 +757,7 @@ static int llc_ui_recvmsg(struct kiocb *
 			if (net_ratelimit())
 				printk(KERN_DEBUG "LLC(%s:%d): Application "
 						  "bug, race in MSG_PEEK.\n",
-				       current->comm, current->pid);
+				       current->comm, task_pid(current));
 			peek_seq = llc->copied_seq;
 		}
 		continue;

