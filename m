Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262270AbSJAUjg>; Tue, 1 Oct 2002 16:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262272AbSJAUjg>; Tue, 1 Oct 2002 16:39:36 -0400
Received: from [198.149.18.6] ([198.149.18.6]:20929 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S262270AbSJAUij>;
	Tue, 1 Oct 2002 16:38:39 -0400
Date: Tue, 1 Oct 2002 23:58:07 -0400
From: Christoph Hellwig <hch@sgi.com>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] Workqueue Abstraction, 2.5.40-H7
Message-ID: <20021001235807.A3743@sgi.com>
Mail-Followup-To: Christoph Hellwig <hch@sgi.com>,
	Marc-Christian Petersen <m.c.p@wolk-project.de>,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
References: <200210012048.39981.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200210012048.39981.m.c.p@wolk-project.de>; from m.c.p@wolk-project.de on Tue, Oct 01, 2002 at 08:52:27PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2002 at 08:52:27PM +0200, Marc-Christian Petersen wrote:
> does not compile on 2.5.40 with XFS. Compiles clean w/o your patch.
> (I cannot have a look into your maxi-config.bz2 because it is corrupt)

I posted the 2.5.40 fix on this list some time ago.
The top of tree fix (different) is below:

diff -uNr -p linux-2.5-xfs/fs/xfs/pagebuf/page_buf.c /home/hch/linux/fs/xfs/pagebuf/page_buf.c
--- linux-2.5-xfs/fs/xfs/pagebuf/page_buf.c	Tue Oct  1 22:26:22 2002
+++ /home/hch/linux/fs/xfs/pagebuf/page_buf.c	Tue Oct  1 22:11:17 2002
@@ -179,6 +179,11 @@ pagebuf_param_t pb_params = {{ HZ, 15 * 
 struct pbstats pbstats;
 
 /*
+ * Queue for delayed I/O completion.
+ */
+struct workqueue_struct *pagebuf_workqueue;
+
+/*
  * Pagebuf allocation / freeing.
  */
 
@@ -1167,7 +1172,7 @@ _pagebuf_wait_unpin(
  *	present, will be called as a side-effect.
  */
 void
-pagebuf_iodone_sched(
+pagebuf_iodone_work(
 	void			*v)
 {
 	page_buf_t		*pb = (page_buf_t *)v;
@@ -1196,11 +1201,8 @@ pagebuf_iodone(
 	PB_TRACE(pb, PB_TRACE_REC(done), pb->pb_iodone);
 
 	if ((pb->pb_iodone) || (pb->pb_flags & PBF_ASYNC)) {
-		INIT_TQUEUE(&pb->pb_iodone_sched,
-			pagebuf_iodone_sched, (void *)pb);
-
-		schedule_task(&pb->pb_iodone_sched);
-
+		INIT_WORK(&pb->pb_iodone_work, pagebuf_iodone_work, pb);
+		queue_work(pagebuf_workqueue, &pb->pb_iodone_work);
 	} else {
 		up(&pb->pb_iodonesema);
 	}
@@ -1854,6 +1856,10 @@ pagebuf_daemon_start(void)
 
 		kernel_thread(pagebuf_daemon, (void *)pb_daemon,
 				CLONE_FS|CLONE_FILES|CLONE_VM);
+
+		pagebuf_workqueue = create_workqueue("pagebuf");
+		if (!pagebuf_workqueue)
+			return -1;
 	}
 	return 0;
 }
@@ -1867,6 +1873,9 @@ STATIC void
 pagebuf_daemon_stop(void)
 {
 	if (pb_daemon) {
+		flush_workqueue(pagebuf_workqueue);
+		destroy_workqueue(pagebuf_workqueue);
+
 		pb_daemon->active = 0;
 		pb_daemon->io_active = 0;
 
diff -uNr -p linux-2.5-xfs/fs/xfs/pagebuf/page_buf.h /home/hch/linux/fs/xfs/pagebuf/page_buf.h
--- linux-2.5-xfs/fs/xfs/pagebuf/page_buf.h	Tue Oct  1 22:26:22 2002
+++ /home/hch/linux/fs/xfs/pagebuf/page_buf.h	Tue Oct  1 22:11:38 2002
@@ -47,7 +47,7 @@
 #include <linux/fs.h>
 #include <linux/buffer_head.h>
 #include <linux/uio.h>
-#include <linux/tqueue.h>
+#include <linux/workqueue.h>
 
 enum xfs_buffer_state { BH_Delay = BH_PrivateStart };
 BUFFER_FNS(Delay, delay);
@@ -214,7 +214,7 @@ typedef struct page_buf_s {
 	size_t			pb_buffer_length; /* size of buffer in bytes */
 	size_t			pb_count_desired; /* desired transfer size */
 	void			*pb_addr;	/* virtual address of buffer */
-	struct tq_struct	pb_iodone_sched;
+	struct work_struct	pb_iodone_work;
 	page_buf_iodone_t	pb_iodone;	/* I/O completion function */
 	page_buf_relse_t	pb_relse;	/* releasing function */
 	page_buf_bdstrat_t	pb_strat;	/* pre-write function */
@@ -394,5 +394,7 @@ static __inline__ int __pagebuf_ioreques
 		return pb->pb_strat(pb);
 	return pagebuf_iorequest(pb);
 }
+
+extern struct workqueue_struct *pagebuf_workqueue;
 
 #endif /* __PAGE_BUF_H__ */
diff -uNr -p linux-2.5-xfs/fs/xfs/xfs_log.c /home/hch/linux/fs/xfs/xfs_log.c
--- linux-2.5-xfs/fs/xfs/xfs_log.c	Thu Sep 26 21:26:31 2002
+++ /home/hch/linux/fs/xfs/xfs_log.c	Tue Oct  1 22:00:27 2002
@@ -2714,7 +2714,7 @@ xlog_state_put_ticket(xlog_t	    *log,
 	LOG_UNLOCK(log, s);
 }	/* xlog_state_put_ticket */
 
-void xlog_sync_sched(
+void xlog_sync_work(
 	void	*v)
 {
 	xlog_in_core_t	*iclog = (xlog_in_core_t *)v;
@@ -2773,13 +2773,12 @@ xlog_state_release_iclog(xlog_t		*log,
 	 * flags after this point.
 	 */
 	if (sync) {
-		INIT_TQUEUE(&iclog->ic_write_sched,
-			xlog_sync_sched, (void *) iclog);
+		INIT_WORK(&iclog->ic_write_work, xlog_sync_work, iclog);
 		switch (xlog_mode) {
 		case 0:
 			return xlog_sync(log, iclog, 0);
 		case 1:
-			pagebuf_queue_task(&iclog->ic_write_sched);
+		        queue_work(pagebuf_workqueue, &iclog->ic_write_work);
 		}
 	}
 	return (0);
diff -uNr -p linux-2.5-xfs/fs/xfs/xfs_log_priv.h /home/hch/linux/fs/xfs/xfs_log_priv.h
--- linux-2.5-xfs/fs/xfs/xfs_log_priv.h	Thu Sep 26 21:26:31 2002
+++ /home/hch/linux/fs/xfs/xfs_log_priv.h	Tue Oct  1 22:09:40 2002
@@ -438,7 +438,7 @@ typedef struct xlog_iclog_fields {
 	int			ic_bwritecnt;
 	ushort_t		ic_state;
 	char			*ic_datap;	/* pointer to iclog data */
-	struct tq_struct	ic_write_sched;
+	struct work_struct	ic_write_work;
 } xlog_iclog_fields_t;
 
 typedef struct xlog_in_core2 {
@@ -458,7 +458,7 @@ typedef struct xlog_in_core {
  * Defines to save our code from this glop.
  */
 #define ic_forcesema	hic_fields.ic_forcesema
-#define ic_write_sched	hic_fields.ic_write_sched
+#define ic_write_work	hic_fields.ic_write_work
 #define ic_next		hic_fields.ic_next
 #define ic_prev		hic_fields.ic_prev
 #define ic_bp		hic_fields.ic_bp
