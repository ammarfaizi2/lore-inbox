Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287711AbSAKFP3>; Fri, 11 Jan 2002 00:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289882AbSAKFPU>; Fri, 11 Jan 2002 00:15:20 -0500
Received: from nat.transgeek.com ([66.92.79.28]:41464 "HELO smtp.transgeek.com")
	by vger.kernel.org with SMTP id <S287711AbSAKFPN>;
	Fri, 11 Jan 2002 00:15:13 -0500
Content-Type: text/plain; charset=US-ASCII
From: Craig Christophel <merlin@transgeek.com>
Subject: one more BUG() to BUG_ON() patchset
Date: Fri, 11 Jan 2002 00:15:46 -0500
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Message-Id: <20020111011235.ADAA2C73A5@smtp.transgeek.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

here are patches that modify linux/(kernel,ipc) relavent to 2.5.2-pre11


Index: linux/ipc//msg.c
===================================================================
RCS file: /home/Media/cvs/linux/ipc/msg.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 msg.c
--- linux/ipc//msg.c	11 Jan 2002 03:11:06 -0000	1.1.1.1
+++ linux/ipc//msg.c	11 Jan 2002 05:11:37 -0000
@@ -317,8 +317,7 @@
 		ret = -EEXIST;
 	} else {
 		msq = msg_lock(id);
-		if(msq==NULL)
-			BUG();
+		BUG_ON(msq==NULL);
 		if (ipcperms(&msq->q_perm, msgflg))
 			ret = -EACCES;
 		else
@@ -833,8 +832,7 @@
 		}
 		err = PTR_ERR(msg);
 		if(err == -EAGAIN) {
-			if(msqid==-1)
-				BUG();
+			BUG_ON(msqid==-1);
 			list_del(&msr_d.r_list);
 			if (signal_pending(current))
 				err=-EINTR;
Index: linux/ipc//shm.c
===================================================================
RCS file: /home/Media/cvs/linux/ipc/shm.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 shm.c
--- linux/ipc//shm.c	11 Jan 2002 03:11:06 -0000	1.1.1.1
+++ linux/ipc//shm.c	11 Jan 2002 05:12:10 -0000
@@ -99,8 +99,7 @@
 static inline void shm_inc (int id) {
 	struct shmid_kernel *shp;
 
-	if(!(shp = shm_lock(id)))
-		BUG();
+	BUG_ON(!(shp = shm_lock(id)));
 	shp->shm_atim = CURRENT_TIME;
 	shp->shm_lprid = current->pid;
 	shp->shm_nattch++;
@@ -143,8 +142,7 @@
 
 	down (&shm_ids.sem);
 	/* remove from the list of attaches of the shm segment */
-	if(!(shp = shm_lock(id)))
-		BUG();
+	BUG_ON(!(shp = shm_lock(id)));
 	shp->shm_lprid = current->pid;
 	shp->shm_dtim = CURRENT_TIME;
 	shp->shm_nattch--;
@@ -242,8 +240,7 @@
 		err = -EEXIST;
 	} else {
 		shp = shm_lock(id);
-		if(shp==NULL)
-			BUG();
+		BUG_ON(shp==NULL);
 		if (shp->shm_segsz < size)
 			err = -EINVAL;
 		else if (ipcperms(&shp->shm_perm, shmflg))
@@ -648,8 +645,7 @@
 	up_write(&current->mm->mmap_sem);
 
 	down (&shm_ids.sem);
-	if(!(shp = shm_lock(shmid)))
-		BUG();
+	BUG_ON(!(shp = shm_lock(shmid)));
 	shp->shm_nattch--;
 	if(shp->shm_nattch == 0 &&
 	   shp->shm_flags & SHM_DEST)
Index: linux/ipc//util.c
===================================================================
RCS file: /home/Media/cvs/linux/ipc/util.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 util.c
--- linux/ipc//util.c	11 Jan 2002 03:11:06 -0000	1.1.1.1
+++ linux/ipc//util.c	11 Jan 2002 05:12:25 -0000
@@ -185,12 +185,10 @@
 {
 	struct kern_ipc_perm* p;
 	int lid = id % SEQ_MULTIPLIER;
-	if(lid >= ids->size)
-		BUG();
+	BUG_ON(lid >= ids->size);
 	p = ids->entries[lid].p;
 	ids->entries[lid].p = NULL;
-	if(p==NULL)
-		BUG();
+	BUG_ON(p==NULL);
 	ids->in_use--;
 
 	if (lid == ids->max_id) {
Index: linux/kernel//device.c
===================================================================
RCS file: /home/Media/cvs/linux/kernel/device.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 device.c
--- linux/kernel//device.c	11 Jan 2002 03:10:50 -0000	1.1.1.1
+++ linux/kernel//device.c	11 Jan 2002 05:05:43 -0000
@@ -458,9 +458,8 @@
 	iobus->parent = NULL;
 	unlock_iobus(iobus);
 
-	if (!list_empty(&iobus->devices) ||
-	    !list_empty(&iobus->children))
-		BUG();
+	BUG_ON(!list_empty(&iobus->devices) ||
+	    !list_empty(&iobus->children));
 
 	/* disavow parent's knowledge */
 	if (parent) {
Index: linux/kernel//exit.c
===================================================================
RCS file: /home/Media/cvs/linux/kernel/exit.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 exit.c
--- linux/kernel//exit.c	11 Jan 2002 03:10:50 -0000	1.1.1.1
+++ linux/kernel//exit.c	11 Jan 2002 05:06:30 -0000
@@ -31,8 +31,7 @@
 {
 	unsigned long flags;
 
-	if (p == current)
-		BUG();
+	BUG_ON(p == current);
 #ifdef CONFIG_SMP
 	wait_task_inactive(p);
 #endif
@@ -382,7 +381,7 @@
 	mm_release();
 	if (mm) {
 		atomic_inc(&mm->mm_count);
-		if (mm != tsk->active_mm) BUG();
+		BUG_ON(mm != tsk->active_mm);
 		/* more a memory barrier than a real lock */
 		task_lock(tsk);
 		tsk->mm = NULL;
Index: linux/kernel//fork.c
===================================================================
RCS file: /home/Media/cvs/linux/kernel/fork.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 fork.c
--- linux/kernel//fork.c	11 Jan 2002 03:10:50 -0000	1.1.1.1
+++ linux/kernel//fork.c	11 Jan 2002 05:06:44 -0000
@@ -250,7 +250,7 @@
  */
 inline void __mmdrop(struct mm_struct *mm)
 {
-	if (mm == &init_mm) BUG();
+	BUG_ON(mm == &init_mm);
 	pgd_free(mm->pgd);
 	destroy_context(mm);
 	free_mm(mm);
Index: linux/kernel//module.c
===================================================================
RCS file: /home/Media/cvs/linux/kernel/module.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 module.c
--- linux/kernel//module.c	11 Jan 2002 03:10:50 -0000	1.1.1.1
+++ linux/kernel//module.c	11 Jan 2002 05:07:33 -0000
@@ -109,7 +109,7 @@
 	spin_lock(&ime_lock);
 	list_for_each(tmp, &ime_list) {
 		ime = list_entry(tmp, struct inter_module_entry, list);
-		if (strcmp(ime->im_name, im_name) == 0) {
+		if (unlikely(strcmp(ime->im_name, im_name) == 0)) {
 			spin_unlock(&ime_lock);
 			kfree(ime_new);
 			/* Program logic error, fatal */
Index: linux/kernel//pm.c
===================================================================
RCS file: /home/Media/cvs/linux/kernel/pm.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 pm.c
--- linux/kernel//pm.c	11 Jan 2002 03:10:50 -0000	1.1.1.1
+++ linux/kernel//pm.c	11 Jan 2002 05:07:43 -0000
@@ -156,8 +156,7 @@
 	int status = 0;
 	int prev_state, next_state;
 
-	if (in_interrupt())
-		BUG();
+	BUG_ON(in_interrupt());
 
 	switch (rqst) {
 	case PM_SUSPEND:
Index: linux/kernel//printk.c
===================================================================
RCS file: /home/Media/cvs/linux/kernel/printk.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 printk.c
--- linux/kernel//printk.c	11 Jan 2002 03:10:50 -0000	1.1.1.1
+++ linux/kernel//printk.c	11 Jan 2002 05:08:01 -0000
@@ -331,8 +331,7 @@
 	unsigned long cur_index, start_print;
 	static int msg_level = -1;
 
-	if (((long)(start - end)) > 0)
-		BUG();
+	BUG_ON(((long)(start - end)) > 0);
 
 	cur_index = start;
 	start_print = start;
@@ -469,8 +468,8 @@
  */
 void acquire_console_sem(void)
 {
-	if (in_interrupt())
-		BUG();
+	BUG_ON(in_interrupt());
+
 	down(&console_sem);
 	console_may_schedule = 1;
 }
Index: linux/kernel//sched.c
===================================================================
RCS file: /home/Media/cvs/linux/kernel/sched.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 sched.c
--- linux/kernel//sched.c	11 Jan 2002 03:10:50 -0000	1.1.1.1
+++ linux/kernel//sched.c	11 Jan 2002 05:08:18 -0000
@@ -466,8 +466,8 @@
 	list_t *queue;
 	int idx;
 
-	if (unlikely(in_interrupt()))
-		BUG();
+	BUG_ON(in_interrupt());
+
 need_resched_back:
 	prev = current;
 	release_kernel_lock(prev, smp_processor_id());
Index: linux/kernel//softirq.c
===================================================================
RCS file: /home/Media/cvs/linux/kernel/softirq.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 softirq.c
--- linux/kernel//softirq.c	11 Jan 2002 03:10:50 -0000	1.1.1.1
+++ linux/kernel//softirq.c	11 Jan 2002 05:09:00 -0000
@@ -190,7 +190,7 @@
 
 		if (tasklet_trylock(t)) {
 			if (!atomic_read(&t->count)) {
-				if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
+				if (unlikely(!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state)))
 					BUG();
 				t->func(t->data);
 				tasklet_unlock(t);
@@ -224,7 +224,7 @@
 
 		if (tasklet_trylock(t)) {
 			if (!atomic_read(&t->count)) {
-				if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
+				if (unlikely(!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state)))
 					BUG();
 				t->func(t->data);
 				tasklet_unlock(t);
@@ -369,8 +369,7 @@
 
 	/* Migrate to the right CPU */
 	set_cpus_allowed(current, 1UL << cpu);
-	if (smp_processor_id() != cpu)
-		BUG();
+	BUG_ON(smp_processor_id() != cpu);
 
 	sprintf(current->comm, "ksoftirqd_CPU%d", bind_cpu);
 
