Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261981AbVA0Ddk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbVA0Ddk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 22:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262393AbVA0Ddk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 22:33:40 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:27562 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S261981AbVA0DbN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 22:31:13 -0500
Date: Thu, 27 Jan 2005 04:31:09 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: RFC: assert_spin_locked() for 2.6
Message-ID: <20050127033109.GB20720@mail.13thfloor.at>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greetings!

overcautious programming will kill your kernel ;)

ever thought about checking a spin_lock or even
asserting that it must be held (maybe just for
spinlock debugging?) ...

there are several checks present in the kernel
where somebody does a variation on the following:

  BUG_ON(!spin_is_locked(&some_lock));
  
so what's wrong about that? nothing, unless you
compile the code with CONFIG_DEBUG_SPINLOCK but 
without CONFIG_SMP ... in which case the BUG()
will kill your kernel ...

maybe it's not advised to make such assertions, 
but here is a solution which works for me ...
(compile tested for sh, x86_64 and x86, boot/run
tested for x86 only)

comments?

best,
Herbert

;
; define the new assert_spin_locked() macro and make
; sure that it does the proper checks regardless of
; CONFIG_SMP
;
diff -NurpP --minimal linux-2.6.11-rc2/include/linux/spinlock.h linux-2.6.11-rc2-spin/include/linux/spinlock.h
--- linux-2.6.11-rc2/include/linux/spinlock.h	2005-01-22 15:08:01 +0100
+++ linux-2.6.11-rc2-spin/include/linux/spinlock.h	2005-01-27 02:34:54 +0100
@@ -38,6 +38,8 @@
  * If CONFIG_SMP is set, pull in the _raw_* definitions
  */
 #ifdef CONFIG_SMP
+
+#define assert_spin_locked(x)	BUG_ON(!spin_is_locked(x))
 #include <asm/spinlock.h>
 
 int __lockfunc _spin_trylock(spinlock_t *lock);
@@ -145,6 +147,14 @@ typedef struct {
 		0; \
 	})
 
+/* with debugging, assert_spin_locked() on UP does check
+ * the lock value properly */
+#define assert_spin_locked(x) \
+	({ \
+		CHECK_LOCK(x); \
+		BUG_ON(!(x)->lock); \
+	})
+
 /* without debugging, spin_trylock on UP always says
  * TRUE. --> printk if already locked. */
 #define _raw_spin_trylock(x) \
@@ -201,6 +211,7 @@ typedef struct {
 #define spin_lock_init(lock)	do { (void)(lock); } while(0)
 #define _raw_spin_lock(lock)	do { (void)(lock); } while(0)
 #define spin_is_locked(lock)	((void)(lock), 0)
+#define assert_spin_locked(lock)	do { (void)(lock); } while(0)
 #define _raw_spin_trylock(lock)	(((void)(lock), 1))
 #define spin_unlock_wait(lock)	(void)(lock)
 #define _raw_spin_unlock(lock) do { (void)(lock); } while(0)


diff -NurpP --minimal linux-2.6.11-rc2/arch/s390/mm/extmem.c linux-2.6.11-rc2-spin/arch/s390/mm/extmem.c
--- linux-2.6.11-rc2/arch/s390/mm/extmem.c	2005-01-22 15:07:31 +0100
+++ linux-2.6.11-rc2-spin/arch/s390/mm/extmem.c	2005-01-27 01:30:24 +0100
@@ -117,7 +117,7 @@ segment_by_name (char *name)
 	struct list_head *l;
 	struct dcss_segment *tmp, *retval = NULL;
 
-	BUG_ON (!spin_is_locked(&dcss_lock));
+	assert_spin_locked(&dcss_lock);
 	dcss_mkname (name, dcss_name);
 	list_for_each (l, &dcss_list) {
 		tmp = list_entry (l, struct dcss_segment, list);
@@ -271,7 +271,7 @@ segment_overlaps_others (struct dcss_seg
 	struct list_head *l;
 	struct dcss_segment *tmp;
 
-	BUG_ON (!spin_is_locked(&dcss_lock));
+	assert_spin_locked(&dcss_lock);
 	list_for_each(l, &dcss_list) {
 		tmp = list_entry(l, struct dcss_segment, list);
 		if ((tmp->start_addr >> 20) > (seg->end >> 20))
diff -NurpP --minimal linux-2.6.11-rc2/drivers/md/raid5.c linux-2.6.11-rc2-spin/drivers/md/raid5.c
--- linux-2.6.11-rc2/drivers/md/raid5.c	2005-01-22 15:07:37 +0100
+++ linux-2.6.11-rc2-spin/drivers/md/raid5.c	2005-01-27 01:31:13 +0100
@@ -56,7 +56,7 @@
 #define RAID5_DEBUG	0
 #define RAID5_PARANOIA	1
 #if RAID5_PARANOIA && defined(CONFIG_SMP)
-# define CHECK_DEVLOCK() if (!spin_is_locked(&conf->device_lock)) BUG()
+# define CHECK_DEVLOCK() assert_spin_locked(&conf->device_lock)
 #else
 # define CHECK_DEVLOCK()
 #endif
diff -NurpP --minimal linux-2.6.11-rc2/drivers/md/raid6main.c linux-2.6.11-rc2-spin/drivers/md/raid6main.c
--- linux-2.6.11-rc2/drivers/md/raid6main.c	2005-01-22 15:07:37 +0100
+++ linux-2.6.11-rc2-spin/drivers/md/raid6main.c	2005-01-27 01:31:35 +0100
@@ -62,7 +62,7 @@
 #define RAID6_PARANOIA	1	/* Check spinlocks */
 #define RAID6_DUMPSTATE 0	/* Include stripe cache state in /proc/mdstat */
 #if RAID6_PARANOIA && defined(CONFIG_SMP)
-# define CHECK_DEVLOCK() if (!spin_is_locked(&conf->device_lock)) BUG()
+# define CHECK_DEVLOCK() assert_spin_locked(&conf->device_lock)
 #else
 # define CHECK_DEVLOCK()
 #endif
diff -NurpP --minimal linux-2.6.11-rc2/drivers/media/common/saa7146_fops.c linux-2.6.11-rc2-spin/drivers/media/common/saa7146_fops.c
--- linux-2.6.11-rc2/drivers/media/common/saa7146_fops.c	2004-12-25 01:54:55 +0100
+++ linux-2.6.11-rc2-spin/drivers/media/common/saa7146_fops.c	2005-01-27 01:32:35 +0100
@@ -73,9 +73,7 @@ int saa7146_buffer_queue(struct saa7146_
 			 struct saa7146_dmaqueue *q,
 			 struct saa7146_buf *buf)
 {
-#ifdef DEBUG_SPINLOCKS
-	BUG_ON(!spin_is_locked(&dev->slock));
-#endif
+	assert_spin_locked(&dev->slock);
 	DEB_EE(("dev:%p, dmaq:%p, buf:%p\n", dev, q, buf));
 
 	BUG_ON(!q);
@@ -96,9 +94,7 @@ void saa7146_buffer_finish(struct saa714
 			   struct saa7146_dmaqueue *q,
 			   int state)
 {
-#ifdef DEBUG_SPINLOCKS
-	BUG_ON(!spin_is_locked(&dev->slock));
-#endif
+	assert_spin_locked(&dev->slock);
 	DEB_EE(("dev:%p, dmaq:%p, state:%d\n", dev, q, state));
 	DEB_EE(("q->curr:%p\n",q->curr));
 
@@ -126,9 +122,7 @@ void saa7146_buffer_next(struct saa7146_
 
 	DEB_INT(("dev:%p, dmaq:%p, vbi:%d\n", dev, q, vbi));
 
-#ifdef DEBUG_SPINLOCKS
-	BUG_ON(!spin_is_locked(&dev->slock));
-#endif
+	assert_spin_locked(&dev->slock);
 	if (!list_empty(&q->queue)) {
 		/* activate next one from queue */
 		buf = list_entry(q->queue.next,struct saa7146_buf,vb.queue);
diff -NurpP --minimal linux-2.6.11-rc2/drivers/media/video/saa7134/saa7134-core.c linux-2.6.11-rc2-spin/drivers/media/video/saa7134/saa7134-core.c
--- linux-2.6.11-rc2/drivers/media/video/saa7134/saa7134-core.c	2005-01-22 15:07:38 +0100
+++ linux-2.6.11-rc2-spin/drivers/media/video/saa7134/saa7134-core.c	2005-01-27 01:33:58 +0100
@@ -319,10 +319,8 @@ int saa7134_buffer_queue(struct saa7134_
 			 struct saa7134_buf *buf)
 {
 	struct saa7134_buf *next = NULL;
-#ifdef DEBUG_SPINLOCKS
-	BUG_ON(!spin_is_locked(&dev->slock));
-#endif
 
+	assert_spin_locked(&dev->slock);
 	dprintk("buffer_queue %p\n",buf);
 	if (NULL == q->curr) {
 		if (!q->need_two) {
@@ -348,9 +346,7 @@ void saa7134_buffer_finish(struct saa713
 			   struct saa7134_dmaqueue *q,
 			   unsigned int state)
 {
-#ifdef DEBUG_SPINLOCKS
-	BUG_ON(!spin_is_locked(&dev->slock));
-#endif
+	assert_spin_locked(&dev->slock);
 	dprintk("buffer_finish %p\n",q->curr);
 
 	/* finish current buffer */
@@ -365,9 +361,7 @@ void saa7134_buffer_next(struct saa7134_
 {
 	struct saa7134_buf *buf,*next = NULL;
 
-#ifdef DEBUG_SPINLOCKS
-	BUG_ON(!spin_is_locked(&dev->slock));
-#endif
+	assert_spin_locked(&dev->slock);
 	BUG_ON(NULL != q->curr);
 
 	if (!list_empty(&q->queue)) {
@@ -422,9 +416,7 @@ int saa7134_set_dmabits(struct saa7134_d
 	enum v4l2_field cap = V4L2_FIELD_ANY;
 	enum v4l2_field ov  = V4L2_FIELD_ANY;
 
-#ifdef DEBUG_SPINLOCKS
-	BUG_ON(!spin_is_locked(&dev->slock));
-#endif
+	assert_spin_locked(&dev->slock);
 
 	/* video capture -- dma 0 + video task A */
 	if (dev->video_q.curr) {
diff -NurpP --minimal linux-2.6.11-rc2/drivers/scsi/megaraid/megaraid_mbox.c linux-2.6.11-rc2-spin/drivers/scsi/megaraid/megaraid_mbox.c
--- linux-2.6.11-rc2/drivers/scsi/megaraid/megaraid_mbox.c	2004-12-25 01:55:12 +0100
+++ linux-2.6.11-rc2-spin/drivers/scsi/megaraid/megaraid_mbox.c	2005-01-27 01:35:38 +0100
@@ -1600,7 +1600,7 @@ megaraid_queue_command(struct scsi_cmnd 
 	scp->scsi_done	= done;
 	scp->result	= 0;
 
-	ASSERT(spin_is_locked(adapter->host_lock));
+	assert_spin_locked(adapter->host_lock);
 
 	spin_unlock(adapter->host_lock);
 
@@ -2043,7 +2043,7 @@ megaraid_mbox_runpendq(adapter_t *adapte
 
 	while (!list_empty(&adapter->pend_list)) {
 
-		ASSERT(spin_is_locked(PENDING_LIST_LOCK(adapter)));
+		assert_spin_locked(PENDING_LIST_LOCK(adapter));
 
 		scb = list_entry(adapter->pend_list.next, scb_t, list);
 
@@ -2615,7 +2615,7 @@ megaraid_abort_handler(struct scsi_cmnd 
 	adapter		= SCP2ADAPTER(scp);
 	raid_dev	= ADAP2RAIDDEV(adapter);
 
-	ASSERT(spin_is_locked(adapter->host_lock));
+	assert_spin_locked(adapter->host_lock);
 
 	con_log(CL_ANN, (KERN_WARNING
 		"megaraid: aborting-%ld cmd=%x <c=%d t=%d l=%d>\n",
@@ -2762,7 +2762,7 @@ megaraid_reset_handler(struct scsi_cmnd 
 	adapter		= SCP2ADAPTER(scp);
 	raid_dev	= ADAP2RAIDDEV(adapter);
 
-	ASSERT(spin_is_locked(adapter->host_lock));
+	assert_spin_locked(adapter->host_lock);
 
 	con_log(CL_ANN, (KERN_WARNING "megaraid: reseting the host...\n"));
 
diff -NurpP --minimal linux-2.6.11-rc2/drivers/usb/host/ehci-q.c linux-2.6.11-rc2-spin/drivers/usb/host/ehci-q.c
--- linux-2.6.11-rc2/drivers/usb/host/ehci-q.c	2005-01-22 15:07:48 +0100
+++ linux-2.6.11-rc2-spin/drivers/usb/host/ehci-q.c	2005-01-27 01:37:15 +0100
@@ -986,13 +986,10 @@ static void start_unlink_async (struct e
 	struct ehci_qh	*prev;
 
 #ifdef DEBUG
+	assert_spin_locked(&ehci->lock);
 	if (ehci->reclaim
 			|| (qh->qh_state != QH_STATE_LINKED
 				&& qh->qh_state != QH_STATE_UNLINK_WAIT)
-#ifdef CONFIG_SMP
-// this macro lies except on SMP compiles
-			|| !spin_is_locked (&ehci->lock)
-#endif
 			)
 		BUG ();
 #endif
diff -NurpP --minimal linux-2.6.11-rc2/include/asm-sh/spinlock.h linux-2.6.11-rc2-spin/include/asm-sh/spinlock.h
--- linux-2.6.11-rc2/include/asm-sh/spinlock.h	2005-01-22 15:07:59 +0100
+++ linux-2.6.11-rc2-spin/include/asm-sh/spinlock.h	2005-01-27 01:38:18 +0100
@@ -51,9 +51,7 @@ static inline void _raw_spin_lock(spinlo
 
 static inline void _raw_spin_unlock(spinlock_t *lock)
 {
-#ifdef CONFIG_DEBUG_SPINLOCK
-	BUG_ON(!spin_is_locked(lock));
-#endif
+	assert_spin_locked(lock);
 
 	lock->lock = 0;
 }
diff -NurpP --minimal linux-2.6.11-rc2/include/asm-x86_64/spinlock.h linux-2.6.11-rc2-spin/include/asm-x86_64/spinlock.h
--- linux-2.6.11-rc2/include/asm-x86_64/spinlock.h	2005-01-22 15:08:00 +0100
+++ linux-2.6.11-rc2-spin/include/asm-x86_64/spinlock.h	2005-01-27 01:39:43 +0100
@@ -75,7 +75,7 @@ static inline void _raw_spin_unlock(spin
 {
 #ifdef CONFIG_DEBUG_SPINLOCK
 	BUG_ON(lock->magic != SPINLOCK_MAGIC);
-	BUG_ON(!spin_is_locked(lock));
+	assert_spin_locked(lock);
 #endif
 	__asm__ __volatile__(
 		spin_unlock_string
@@ -94,7 +94,7 @@ static inline void _raw_spin_unlock(spin
 	char oldval = 1;
 #ifdef CONFIG_DEBUG_SPINLOCK
 	BUG_ON(lock->magic != SPINLOCK_MAGIC);
-	BUG_ON(!spin_is_locked(lock));
+	assert_spin_locked(lock);
 #endif
 	__asm__ __volatile__(
 		spin_unlock_string
diff -NurpP --minimal linux-2.6.11-rc2/kernel/sched.c linux-2.6.11-rc2-spin/kernel/sched.c
--- linux-2.6.11-rc2/kernel/sched.c	2005-01-22 15:08:02 +0100
+++ linux-2.6.11-rc2-spin/kernel/sched.c	2005-01-27 01:42:04 +0100
@@ -778,7 +778,7 @@ static void resched_task(task_t *p)
 {
 	int need_resched, nrpolling;
 
-	BUG_ON(!spin_is_locked(&task_rq(p)->lock));
+	assert_spin_locked(&task_rq(p)->lock);
 
 	/* minimise the chance of sending an interrupt to poll_idle() */
 	nrpolling = test_tsk_thread_flag(p,TIF_POLLING_NRFLAG);
diff -NurpP --minimal linux-2.6.11-rc2/kernel/signal.c linux-2.6.11-rc2-spin/kernel/signal.c
--- linux-2.6.11-rc2/kernel/signal.c	2005-01-22 15:08:02 +0100
+++ linux-2.6.11-rc2-spin/kernel/signal.c	2005-01-27 01:42:57 +0100
@@ -847,10 +847,7 @@ specific_send_sig_info(int sig, struct s
 
 	if (!irqs_disabled())
 		BUG();
-#ifdef CONFIG_SMP
-	if (!spin_is_locked(&t->sighand->siglock))
-		BUG();
-#endif
+	assert_spin_locked(&t->sighand->siglock);
 
 	if (((unsigned long)info > 2) && (info->si_code == SI_TIMER))
 		/*
@@ -1044,10 +1041,7 @@ __group_send_sig_info(int sig, struct si
 {
 	int ret = 0;
 
-#ifdef CONFIG_SMP
-	if (!spin_is_locked(&p->sighand->siglock))
-		BUG();
-#endif
+	assert_spin_locked(&p->sighand->siglock);
 	handle_stop_signal(sig, p);
 
 	if (((unsigned long)info > 2) && (info->si_code == SI_TIMER))

;
; the only tiny semantical change: we check the spin_lock
; even if JBD_ASSERTIONS is undefined and J_ASSERT is removed 
; by the preprocessor, but I guess this is fine, because:
;   a) it requires CONFIG_DEBUG_SPINLOCK to be set and
;   b) JBD_ASSERTIONS is defined by default ...
; 
diff -NurpP --minimal linux-2.6.11-rc2/include/linux/jbd.h linux-2.6.11-rc2-spin/include/linux/jbd.h
--- linux-2.6.11-rc2/include/linux/jbd.h	2005-01-22 15:08:00 +0100
+++ linux-2.6.11-rc2-spin/include/linux/jbd.h	2005-01-27 01:40:40 +0100
@@ -1062,12 +1062,6 @@ extern int jbd_blocks_per_page(struct in
 
 #ifdef __KERNEL__
 
-#ifdef CONFIG_SMP
-#define assert_spin_locked(lock)	J_ASSERT(spin_is_locked(lock))
-#else
-#define assert_spin_locked(lock)	do {} while(0)
-#endif
-
 #define buffer_trace_init(bh)	do {} while (0)
 #define print_buffer_fields(bh)	do {} while (0)
 #define print_buffer_trace(bh)	do {} while (0)


