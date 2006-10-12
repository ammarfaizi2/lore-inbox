Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbWJLXZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbWJLXZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 19:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWJLXZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 19:25:56 -0400
Received: from mga01.intel.com ([192.55.52.88]:56448 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1751315AbWJLXZz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 19:25:55 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,301,1157353200"; 
   d="scan'208"; a="3360469:sNHT33255405"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Zach Brown'" <zach.brown@oracle.com>,
       "'Suparna Bhattacharya'" <suparna@in.ibm.com>,
       "Lahaise, Benjamin C" <benjamin.c.lahaise@intel.com>
Cc: <linux-kernel@vger.kernel.org>, "linux-aio" <linux-aio@kvack.org>
Subject: [patch] rearrange kioctx and aio_ring_info
Date: Thu, 12 Oct 2006 16:25:54 -0700
Message-ID: <000101c6ee55$c3e121a0$db34030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcbuVcNygEnQk0xvS3Od0aXYAuZ0FA==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch is result of our kernel data latency analysis on a
large database setup (128 logical CPU, 1 TB memory, a couple thousand
disks). The analysis is done at an individual cache line level through
hardware performance monitor unit.  What we did essentially is to collect
data access latency on every kernel memory address and look for top 50
longest average access latency.  The hardware performance unit also keeps
track of instruction address for each collected data access.  This allows
us to further associate each of the top 50 cache lines to instruction
sequences that caused long latency.

One structure stood out in the woods is the AIO kioctx structure.  In
particular, kioctx->users and kioctx->ctx_lock are the two hottest variables
within one cache line (there are multiple of these cache lines since db
app uses multiple kioctx). What also appears to be a more serious cacheline
conflict between io_submit_one and aio_complete path: aio_complete()
finishes process an iocb, unlocks ctx->ctx_lock (which implies it just lost
ownership of that cache line), turns around and access wait->task_list and
also does an atomic update to ctx->users.  I think that is causing cache
lines to be bounced around when another process took the ctx_lock in between.

So here we go, I'd like to take this opportunity to rearrange kioctx, put
variables that used together in close proximity.  The rearrangement doesn't
change number of cache line touched in io_submit_one or io_getevents, however,
it reduces one line in aio_complete path.  Also I think we ought to watch
out on updating variable that is in the same cache line of ctx_lock.

Thoughts?  Comments?  Flames?


Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>


diff -Nurp linux-2.6.18/include/linux/aio.h linux-2.6.18.ken/include/linux/aio.h
--- linux-2.6.18/include/linux/aio.h	2006-09-19 20:42:06.000000000 -0700
+++ linux-2.6.18.ken/include/linux/aio.h	2006-10-12 13:28:17.000000000 -0700
@@ -156,41 +156,38 @@ struct aio_ring {
 
 #define AIO_RING_PAGES	8
 struct aio_ring_info {
-	unsigned long		mmap_base;
-	unsigned long		mmap_size;
-
-	struct page		**ring_pages;
 	spinlock_t		ring_lock;
-	long			nr_pages;
-
+	int			nr_pages;
 	unsigned		nr, tail;
 
+	struct page		**ring_pages;
 	struct page		*internal_pages[AIO_RING_PAGES];
+
+	unsigned long		mmap_base;
+	unsigned long		mmap_size;
 };
 
 struct kioctx {
 	atomic_t		users;
 	int			dead;
-	struct mm_struct	*mm;
-
-	/* This needs improving */
-	unsigned long		user_id;
-	struct kioctx		*next;
-
 	wait_queue_head_t	wait;
 
 	spinlock_t		ctx_lock;
-
 	int			reqs_active;
 	struct list_head	active_reqs;	/* used for cancellation */
 	struct list_head	run_list;	/* used for kicked reqs */
 
-	/* sys_io_setup currently limits this to an unsigned int */
-	unsigned		max_reqs;
-
 	struct aio_ring_info	ring_info;
 
+	/* This needs improving */
+	unsigned long		user_id;
+	struct kioctx		*next;
+	struct mm_struct	*mm;
+
 	struct work_struct	wq;
+
+	/* sys_io_setup currently limits this to an unsigned int */
+	unsigned		max_reqs;
 };
 
 /* prototypes */
