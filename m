Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265976AbUA1PDi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 10:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265978AbUA1PDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 10:03:38 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:48651 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265976AbUA1PCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 10:02:09 -0500
Date: Wed, 28 Jan 2004 15:02:06 +0000
From: Christoph Hellwig <hch@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org,
       =?iso-8859-1?Q?David_Mart=EDnez_Moreno?= <ender@debian.org>,
       Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org
Subject: Re: Fix sleep_on abuse in XFS, Was: Re: 2.6.2-rc2-mm1 (Breakage?)
Message-ID: <20040128150206.A28974@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Alistair John Strachan <s0348365@sms.ed.ac.uk>,
	linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?David_Mart=EDnez_Moreno?= <ender@debian.org>,
	Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org
References: <20040127233402.6f5d3497.akpm@osdl.org> <200401281313.03790.ender@debian.org> <200401281225.37234.s0348365@sms.ed.ac.uk> <20040128133357.A28038@infradead.org> <1075300114.1633.156.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1075300114.1633.156.camel@hades.cambridge.redhat.com>; from dwmw2@infradead.org on Wed, Jan 28, 2004 at 02:28:34PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 28, 2004 at 02:28:34PM +0000, David Woodhouse wrote:
> On Wed, 2004-01-28 at 13:33 +0000, Christoph Hellwig wrote:
> > +	complete(&pagebuf_daemon_done);
> >  	return 0;
> 
> Use complete_and_exit() please. S'what it was invented for.

Index: fs/xfs/linux-2.6/xfs_buf.c
===================================================================
RCS file: /cvs/linux-2.6-xfs/fs/xfs/linux-2.6/xfs_buf.c,v
retrieving revision 1.136
diff -u -p -r1.136 xfs_buf.c
--- fs/xfs/linux-2.6/xfs_buf.c	27 Jan 2004 18:47:46 -0000	1.136
+++ fs/xfs/linux-2.6/xfs_buf.c	28 Jan 2004 15:00:47 -0000
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
@@ -1640,7 +1640,6 @@ pagebuf_iomove(
  * Pagebuf delayed write buffer handling
  */
 
-STATIC int pbd_active = 1;
 STATIC LIST_HEAD(pbd_delwrite_queue);
 STATIC spinlock_t pbd_delwrite_lock = SPIN_LOCK_UNLOCKED;
 
@@ -1687,21 +1686,19 @@ pagebuf_runall_queues(
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
@@ -1709,29 +1706,22 @@ pagebuf_daemon(
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
 
@@ -1775,12 +1765,9 @@ pagebuf_daemon(
 			blk_run_queues();
 
 		force_flush = 0;
-	} while (pbd_active == 1);
-
-	pbd_active = -1;
-	wake_up_interruptible(&pbd_waitq);
+	} while (pagebuf_daemon_active);
 
-	return 0;
+	complete_and_exit(&pagebuf_daemon_done, 0);
 }
 
 void
@@ -1890,9 +1877,10 @@ pagebuf_daemon_start(void)
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
