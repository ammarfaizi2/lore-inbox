Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267414AbRGLBrl>; Wed, 11 Jul 2001 21:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267415AbRGLBrc>; Wed, 11 Jul 2001 21:47:32 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:36247 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S267414AbRGLBrS>; Wed, 11 Jul 2001 21:47:18 -0400
Message-ID: <3B4D01E3.1A2F534F@uow.edu.au>
Date: Thu, 12 Jul 2001 11:48:19 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: Peter Zaitsev <pz@spylog.ru>, linux-kernel@vger.kernel.org
Subject: Re: Is  Swapping on software RAID1 possible  in linux 2.4 ?
In-Reply-To: message from Peter Zaitsev on Thursday July 5,
		<1011478953412.20010705152412@spylog.ru>
		<15172.22988.643481.421716@notabene.cse.unsw.edu.au>
		<11486070195.20010705172249@spylog.ru> <15180.63984.722843.539959@notabene.cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> 
> Also, can you find out what that process is doing when it is
> unkillable.
> If you compile with alt-sysrq support, then alt-sysrq-t should print
> the process table.  If you can get this out of dmesg and run if though
> ksymoops it might be most interesting.

Neil, he showed us a trace the other day - kswapd was
stuck in raid1_alloc_r1_bh().  This is basically the
same situation as I had yesterday, where bdflush was stuck
in the same place.

It is completely fatal to the VM for these two processes to
get stuck in this way.  The approach I took was to beef up
the reserved bh queues and to keep a number of them
reserved *only* for the swapout and dirty buffer flush functions.
That way, we have at hand the memory we need to be able to
free up memory.

It was necessary to define a new task_struct.flags bit so we
can identify when the caller is a `buffer flusher' - I expect
we'll need that in other places as well.

An easy way to demonstrate the problem is to put ext3 on RAID1,
boot with `mem=64m' and run `dd if=/dev/zero of=foo bs=1024k count=1k'.
The machine wedges on the first run.  This is due to a bdflush deadlock.
Once swap is on RAID1, there will be kswapd deadlocks as well.  The
patch *should* fix those, but I haven't tested that.

Could you please review these changes?

BTW: I removed the initial buffer_head reservation code.  It's
not necessary with the modified reservation algorithm - as soon
as we start to use the device the reserve pools will build
up.  There will be a deadlock opportunity if the machine is totally
and utterly oom when the RAID device initially starts up, but it's
really not worth the code space to even bother about this.




--- linux-2.4.6/include/linux/sched.h	Wed May  2 22:00:07 2001
+++ lk-ext3/include/linux/sched.h	Thu Jul 12 01:03:20 2001
@@ -413,7 +418,7 @@ struct task_struct {
 #define PF_SIGNALED	0x00000400	/* killed by a signal */
 #define PF_MEMALLOC	0x00000800	/* Allocating memory */
 #define PF_VFORK	0x00001000	/* Wake up parent in mm_release */
-
+#define PF_FLUSH	0x00002000	/* Flushes buffers to disk */
 #define PF_USEDFPU	0x00100000	/* task used FPU this quantum (SMP) */
 
 /*
--- linux-2.4.6/include/linux/raid/raid1.h	Tue Dec 12 08:20:08 2000
+++ lk-ext3/include/linux/raid/raid1.h	Thu Jul 12 01:15:39 2001
@@ -37,12 +37,12 @@ struct raid1_private_data {
 	/* buffer pool */
 	/* buffer_heads that we have pre-allocated have b_pprev -> &freebh
 	 * and are linked into a stack using b_next
-	 * raid1_bh that are pre-allocated have R1BH_PreAlloc set.
 	 * All these variable are protected by device_lock
 	 */
 	struct buffer_head	*freebh;
 	int			freebh_cnt;	/* how many are on the list */
 	struct raid1_bh		*freer1;
+	unsigned		freer1_cnt;
 	struct raid1_bh		*freebuf; 	/* each bh_req has a page allocated */
 	md_wait_queue_head_t	wait_buffer;
 
@@ -87,5 +87,4 @@ struct raid1_bh {
 /* bits for raid1_bh.state */
 #define	R1BH_Uptodate	1
 #define	R1BH_SyncPhase	2
-#define	R1BH_PreAlloc	3	/* this was pre-allocated, add to free list */
 #endif
--- linux-2.4.6/fs/buffer.c	Wed Jul  4 18:21:31 2001
+++ lk-ext3/fs/buffer.c	Thu Jul 12 01:03:57 2001
@@ -2685,6 +2748,7 @@ int bdflush(void *sem)
 	sigfillset(&tsk->blocked);
 	recalc_sigpending(tsk);
 	spin_unlock_irq(&tsk->sigmask_lock);
+	current->flags |= PF_FLUSH;
 
 	up((struct semaphore *)sem);
 
@@ -2726,6 +2790,7 @@ int kupdate(void *sem)
 	siginitsetinv(&current->blocked, sigmask(SIGCONT) | sigmask(SIGSTOP));
 	recalc_sigpending(tsk);
 	spin_unlock_irq(&tsk->sigmask_lock);
+	current->flags |= PF_FLUSH;
 
 	up((struct semaphore *)sem);
 
--- linux-2.4.6/drivers/md/raid1.c	Wed Jul  4 18:21:26 2001
+++ lk-ext3/drivers/md/raid1.c	Thu Jul 12 01:28:58 2001
@@ -51,6 +51,28 @@ static mdk_personality_t raid1_personali
 static md_spinlock_t retry_list_lock = MD_SPIN_LOCK_UNLOCKED;
 struct raid1_bh *raid1_retry_list = NULL, **raid1_retry_tail;
 
+/*
+ * We need to scale the number of reserved buffers by the page size
+ * to make writepage()s sucessful. --akpm
+ */
+#define R1_BLOCKS_PP			(PAGE_CACHE_SIZE / 1024)
+#define FREER1_MEMALLOC_RESERVED	(16 * R1_BLOCKS_PP)
+
+/*
+ * Return true if the caller make take a bh from the list.
+ * PF_FLUSH and PF_MEMALLOC tasks are allowed to use the reserves, because
+ * they're trying to *free* some memory.
+ *
+ * Requires that conf->device_lock be held.
+ */
+static int may_take_bh(raid1_conf_t *conf, int cnt)
+{
+	int min_free = (current->flags & (PF_FLUSH|PF_MEMALLOC)) ?
+			cnt :
+			(cnt + FREER1_MEMALLOC_RESERVED * conf->raid_disks);
+	return conf->freebh_cnt >= min_free;
+}
+
 static struct buffer_head *raid1_alloc_bh(raid1_conf_t *conf, int cnt)
 {
 	/* return a linked list of "cnt" struct buffer_heads.
@@ -62,7 +84,7 @@ static struct buffer_head *raid1_alloc_b
 	while(cnt) {
 		struct buffer_head *t;
 		md_spin_lock_irq(&conf->device_lock);
-		if (conf->freebh_cnt >= cnt)
+		if (may_take_bh(conf, cnt))
 			while (cnt) {
 				t = conf->freebh;
 				conf->freebh = t->b_next;
@@ -83,7 +105,7 @@ static struct buffer_head *raid1_alloc_b
 			cnt--;
 		} else {
 			PRINTK("raid1: waiting for %d bh\n", cnt);
-			wait_event(conf->wait_buffer, conf->freebh_cnt >= cnt);
+			wait_event(conf->wait_buffer, may_take_bh(conf, cnt));
 		}
 	}
 	return bh;
@@ -96,9 +118,9 @@ static inline void raid1_free_bh(raid1_c
 	while (bh) {
 		struct buffer_head *t = bh;
 		bh=bh->b_next;
-		if (t->b_pprev == NULL)
+		if (conf->freebh_cnt >= FREER1_MEMALLOC_RESERVED) {
 			kfree(t);
-		else {
+		} else {
 			t->b_next= conf->freebh;
 			conf->freebh = t;
 			conf->freebh_cnt++;
@@ -108,29 +130,6 @@ static inline void raid1_free_bh(raid1_c
 	wake_up(&conf->wait_buffer);
 }
 
-static int raid1_grow_bh(raid1_conf_t *conf, int cnt)
-{
-	/* allocate cnt buffer_heads, possibly less if kalloc fails */
-	int i = 0;
-
-	while (i < cnt) {
-		struct buffer_head *bh;
-		bh = kmalloc(sizeof(*bh), GFP_KERNEL);
-		if (!bh) break;
-		memset(bh, 0, sizeof(*bh));
-
-		md_spin_lock_irq(&conf->device_lock);
-		bh->b_pprev = &conf->freebh;
-		bh->b_next = conf->freebh;
-		conf->freebh = bh;
-		conf->freebh_cnt++;
-		md_spin_unlock_irq(&conf->device_lock);
-
-		i++;
-	}
-	return i;
-}
-
 static int raid1_shrink_bh(raid1_conf_t *conf, int cnt)
 {
 	/* discard cnt buffer_heads, if we can find them */
@@ -147,7 +146,16 @@ static int raid1_shrink_bh(raid1_conf_t 
 	md_spin_unlock_irq(&conf->device_lock);
 	return i;
 }
-		
+
+/*
+ * Return true if the caller make take a raid1_bh from the list.
+ * Requires that conf->device_lock be held.
+ */
+static int may_take_r1bh(raid1_conf_t *conf)
+{
+	return ((conf->freer1_cnt > FREER1_MEMALLOC_RESERVED) ||
+		  (current->flags & (PF_FLUSH|PF_MEMALLOC))) && conf->freer1;
+}
 
 static struct raid1_bh *raid1_alloc_r1bh(raid1_conf_t *conf)
 {
@@ -155,8 +163,9 @@ static struct raid1_bh *raid1_alloc_r1bh
 
 	do {
 		md_spin_lock_irq(&conf->device_lock);
-		if (conf->freer1) {
+		if (may_take_r1bh(conf)) {
 			r1_bh = conf->freer1;
+			conf->freer1_cnt--;
 			conf->freer1 = r1_bh->next_r1;
 			r1_bh->next_r1 = NULL;
 			r1_bh->state = 0;
@@ -170,7 +179,7 @@ static struct raid1_bh *raid1_alloc_r1bh
 			memset(r1_bh, 0, sizeof(*r1_bh));
 			return r1_bh;
 		}
-		wait_event(conf->wait_buffer, conf->freer1);
+		wait_event(conf->wait_buffer, may_take_r1bh(conf));
 	} while (1);
 }
 
@@ -178,49 +187,30 @@ static inline void raid1_free_r1bh(struc
 {
 	struct buffer_head *bh = r1_bh->mirror_bh_list;
 	raid1_conf_t *conf = mddev_to_conf(r1_bh->mddev);
+	unsigned long flags;
 
 	r1_bh->mirror_bh_list = NULL;
 
-	if (test_bit(R1BH_PreAlloc, &r1_bh->state)) {
-		unsigned long flags;
-		spin_lock_irqsave(&conf->device_lock, flags);
+	spin_lock_irqsave(&conf->device_lock, flags);
+	if (conf->freer1_cnt < FREER1_MEMALLOC_RESERVED) {
 		r1_bh->next_r1 = conf->freer1;
 		conf->freer1 = r1_bh;
+		conf->freer1_cnt++;
 		spin_unlock_irqrestore(&conf->device_lock, flags);
 	} else {
+		spin_unlock_irqrestore(&conf->device_lock, flags);
 		kfree(r1_bh);
 	}
 	raid1_free_bh(conf, bh);
 }
 
-static int raid1_grow_r1bh (raid1_conf_t *conf, int cnt)
-{
-	int i = 0;
-
-	while (i < cnt) {
-		struct raid1_bh *r1_bh;
-		r1_bh = (struct raid1_bh*)kmalloc(sizeof(*r1_bh), GFP_KERNEL);
-		if (!r1_bh)
-			break;
-		memset(r1_bh, 0, sizeof(*r1_bh));
-
-		md_spin_lock_irq(&conf->device_lock);
-		set_bit(R1BH_PreAlloc, &r1_bh->state);
-		r1_bh->next_r1 = conf->freer1;
-		conf->freer1 = r1_bh;
-		md_spin_unlock_irq(&conf->device_lock);
-
-		i++;
-	}
-	return i;
-}
-
 static void raid1_shrink_r1bh(raid1_conf_t *conf)
 {
 	md_spin_lock_irq(&conf->device_lock);
 	while (conf->freer1) {
 		struct raid1_bh *r1_bh = conf->freer1;
 		conf->freer1 = r1_bh->next_r1;
+		conf->freer1_cnt--;	/* pedantry */
 		kfree(r1_bh);
 	}
 	md_spin_unlock_irq(&conf->device_lock);
@@ -1610,21 +1600,6 @@ static int raid1_run (mddev_t *mddev)
 		goto out_free_conf;
 	}
 
-
-	/* pre-allocate some buffer_head structures.
-	 * As a minimum, 1 r1bh and raid_disks buffer_heads
-	 * would probably get us by in tight memory situations,
-	 * but a few more is probably a good idea.
-	 * For now, try 16 r1bh and 16*raid_disks bufferheads
-	 * This will allow at least 16 concurrent reads or writes
-	 * even if kmalloc starts failing
-	 */
-	if (raid1_grow_r1bh(conf, 16) < 16 ||
-	    raid1_grow_bh(conf, 16*conf->raid_disks)< 16*conf->raid_disks) {
-		printk(MEM_ERROR, mdidx(mddev));
-		goto out_free_conf;
-	}
-
 	for (i = 0; i < MD_SB_DISKS; i++) {
 		
 		descriptor = sb->disks+i;
@@ -1713,6 +1688,8 @@ out_free_conf:
 	raid1_shrink_r1bh(conf);
 	raid1_shrink_bh(conf, conf->freebh_cnt);
 	raid1_shrink_buffers(conf);
+	if (conf->freer1_cnt != 0)
+		BUG();
 	kfree(conf);
 	mddev->private = NULL;
 out:
