Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265953AbUA1NeT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 08:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265956AbUA1NeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 08:34:19 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:2315 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265953AbUA1NeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 08:34:02 -0500
Date: Wed, 28 Jan 2004 13:33:58 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org,
       =?iso-8859-1?Q?David_Mart=EDnez_Moreno?= <ender@debian.org>,
       Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org
Subject: Fix sleep_on abuse in XFS, Was: Re: 2.6.2-rc2-mm1 (Breakage?)
Message-ID: <20040128133357.A28038@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alistair John Strachan <s0348365@sms.ed.ac.uk>,
	linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?David_Mart=EDnez_Moreno?= <ender@debian.org>,
	Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org
References: <20040127233402.6f5d3497.akpm@osdl.org> <200401281313.03790.ender@debian.org> <200401281225.37234.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200401281225.37234.s0348365@sms.ed.ac.uk>; from s0348365@sms.ed.ac.uk on Wed, Jan 28, 2004 at 12:25:37PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, okay, I give up, here's a patch to remove sleep_on usage from XFS.

It's not actually racy but such horrible code deserves to be replaced
anyway.


Index: fs/xfs/linux-2.6/xfs_buf.c
===================================================================
RCS file: /cvs/linux-2.6-xfs/fs/xfs/linux-2.6/xfs_buf.c,v
retrieving revision 1.136
diff -u -p -r1.136 xfs_buf.c
--- fs/xfs/linux-2.6/xfs_buf.c	27 Jan 2004 18:47:46 -0000	1.136
+++ fs/xfs/linux-2.6/xfs_buf.c	28 Jan 2004 13:09:33 -0000
@@ -80,7 +80,7 @@
  */
 
 STATIC kmem_cache_t *pagebuf_cache;
-STATIC void pagebuf_daemon_wakeup(int);
+STATIC void pagebuf_daemon_wakeup(void);
 STATIC void pagebuf_delwri_queue(page_buf_t *, int);
 STATIC struct workqueue_struct *pagebuf_logio_workqueue;
 STATIC struct workqueue_struct *pagebuf_dataio_workqueue;
@@ -510,7 +510,7 @@ _pagebuf_lookup_pages(
 			if (!page) {
 				if (--retry_count > 0) {
 					PB_STATS_INC(pb_page_retries);
-					pagebuf_daemon_wakeup(1);
+					pagebuf_daemon_wakeup();
 					current->state = TASK_UNINTERRUPTIBLE;
 					schedule_timeout(10);
 					goto retry;
@@ -1640,7 +1605,6 @@ pagebuf_iomove(
  * Pagebuf delayed write buffer handling
  */
 
-STATIC int pbd_active = 1;
 STATIC LIST_HEAD(pbd_delwrite_queue);
 STATIC spinlock_t pbd_delwrite_lock = SPIN_LOCK_UNLOCKED;
 
@@ -1687,21 +1651,19 @@ pagebuf_runall_queues(
 }
 
 /* Defines for pagebuf daemon */
-DECLARE_WAIT_QUEUE_HEAD(pbd_waitq);
+STATIC DECLARE_COMPLETION(pagebuf_daemon_done);
+STATIC struct task_struct *pagebuf_daemon_task;
+STATIC int pagebuf_daemon_active;
 STATIC int force_flush;
 
 STATIC void
-pagebuf_daemon_wakeup(
-	int			flag)
+pagebuf_daemon_wakeup(void)
 {
-	force_flush = flag;
-	if (waitqueue_active(&pbd_waitq)) {
-		wake_up_interruptible(&pbd_waitq);
-	}
+	force_flush = 1;
+	barrier();
+	wake_up_process(pagebuf_daemon_task);
 }
 
-typedef void (*timeout_fn)(unsigned long);
-
 STATIC int
 pagebuf_daemon(
 	void			*data)
@@ -1709,29 +1671,22 @@ pagebuf_daemon(
 	int			count;
 	page_buf_t		*pb;
 	struct list_head	*curr, *next, tmp;
-	struct timer_list	pb_daemon_timer =
-		TIMER_INITIALIZER((timeout_fn)pagebuf_daemon_wakeup, 0, 0);
 
 	/*  Set up the thread  */
 	daemonize("pagebufd");
-
 	current->flags |= PF_MEMALLOC;
 
+	pagebuf_daemon_task = current;
+	pagebuf_daemon_active = 1;
+	barrier();
+
 	INIT_LIST_HEAD(&tmp);
 	do {
 		/* swsusp */
 		if (current->flags & PF_FREEZE)
 			refrigerator(PF_IOTHREAD);
 
-		if (pbd_active == 1) {
-			mod_timer(&pb_daemon_timer,
-				  jiffies + pb_params.flush_interval.val);
-			interruptible_sleep_on(&pbd_waitq);
-		}
-
-		if (pbd_active == 0) {
-			del_timer_sync(&pb_daemon_timer);
-		}
+		schedule_timeout(pb_params.flush_interval.val);
 
 		spin_lock(&pbd_delwrite_lock);
 
@@ -1775,11 +1730,9 @@ pagebuf_daemon(
 			blk_run_queues();
 
 		force_flush = 0;
-	} while (pbd_active == 1);
-
-	pbd_active = -1;
-	wake_up_interruptible(&pbd_waitq);
+	} while (pagebuf_daemon_active);
 
+	complete(&pagebuf_daemon_done);
 	return 0;
 }
 
@@ -1890,9 +1843,10 @@ pagebuf_daemon_start(void)
 STATIC void
 pagebuf_daemon_stop(void)
 {
-	pbd_active = 0;
-	wake_up_interruptible(&pbd_waitq);
-	wait_event_interruptible(pbd_waitq, pbd_active);
+	pagebuf_daemon_active = 0;
+	barrier();
+	wait_for_completion(&pagebuf_daemon_done);
+
 	destroy_workqueue(pagebuf_logio_workqueue);
 	destroy_workqueue(pagebuf_dataio_workqueue);
 }
