Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266543AbUA3Dcf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 22:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266539AbUA3Dcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 22:32:35 -0500
Received: from esperance.ozonline.com.au ([203.23.159.248]:62666 "EHLO
	ozonline.com.au") by vger.kernel.org with ESMTP id S266536AbUA3Dbp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 22:31:45 -0500
Date: Fri, 30 Jan 2004 14:35:53 +1100
From: Davin McCall <davmac@ozonline.com.au>
To: Davin McCall <davmac@ozonline.com.au>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH] various IDE patches/cleanups
Message-Id: <20040130143553.7ac8d1cc.davmac@ozonline.com.au>
In-Reply-To: <20040130143459.2c206af9.davmac@ozonline.com.au>
References: <20040103152802.6e27f5c5.davmac@ozonline.com.au>
	<200401051516.03364.bzolnier@elka.pw.edu.pl>
	<20040106135155.66535c13.davmac@ozonline.com.au>
	<200401061213.39843.bzolnier@elka.pw.edu.pl>
	<20040130142725.1a408f9e.davmac@ozonline.com.au>
	<20040130143041.1eb70817.davmac@ozonline.com.au>
	<20040130143355.630346cc.davmac@ozonline.com.au>
	<20040130143459.2c206af9.davmac@ozonline.com.au>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


5th patch notes
---------------

Ultimately this patch avoids the possibility in several places of returning
EBUSY error. This mainly affects /proc interface and ioctl's.

What we do is put a wait queue in the hwgroup structure, which can be used
to receive notification that the hwgroup is no longer busy. This avoids the
"test - sleep - test ..." style of hwgroup grabbing.

- (ide.h)
  - add notbusyq (wait_queue_head_t) to struct hwgroup_s.
  - remove function declaration ide_spin_wait_hwgroup
  - add function declaration ide_wait_hwgroup
  - define inline function ide_kick_queue
    (restart queue processing after grab)
- (ide-probe.c)
  - initialise the waitqueue when allocating the hwgroup
- (ide-io.c)
  - ide_do_request()
    - First thing in the service loop, check the wait queue. If it's not
      empty, do not process further requests, and wake a waiter if no requests
      are currently being executed (leave ->busy set to avoid re-entrance;
      it's the waiters responsibility to clear it).
- (ide.c)
  - new function ide_wait_hwgroup. A replacement for ide_spin_wait_hwgroup.
    - must be called with ide_lock held.
    - ide_spin_wait_hwgroup, if successful, returned with ide_lock held
      and ->busy clear. The new function returns with ide_lock held but
      busy may be clear or set.
  - remove ide_spin_wait_hwgroup().
  - ide_write_setting()
    - trivial: correct comment
    - use new ide_wait_hwgroup mechanism
- (ide-disk.c)
  - set_nowerr()
    - use new ide_wait_hwgroup().
- (ide-proc.c)
  - proc_ide_write_config()
    - use new ide_wait_hwgroup() mechanism.


diff -urN linux-2.6.0-patch4/drivers/ide/ide-disk.c linux-2.6.0/drivers/ide/ide-disk.c
--- linux-2.6.0-patch4/drivers/ide/ide-disk.c	Thu Jan 29 13:53:38 2004
+++ linux-2.6.0/drivers/ide/ide-disk.c	Thu Jan 29 13:56:30 2004
@@ -1360,10 +1360,11 @@
 
 static int set_nowerr(ide_drive_t *drive, int arg)
 {
-	if (ide_spin_wait_hwgroup(drive))
-		return -EBUSY;
+	spin_lock_irq(&ide_lock);
+	ide_wait_hwgroup(HWGROUP(drive));
 	drive->nowerr = arg;
 	drive->bad_wstat = arg ? BAD_R_STAT : BAD_W_STAT;
+	ide_kick_queue(HWGROUP(drive));
 	spin_unlock_irq(&ide_lock);
 	return 0;
 }
diff -urN linux-2.6.0-patch4/drivers/ide/ide-io.c linux-2.6.0/drivers/ide/ide-io.c
--- linux-2.6.0-patch4/drivers/ide/ide-io.c	Thu Jan 29 12:48:09 2004
+++ linux-2.6.0/drivers/ide/ide-io.c	Thu Jan 29 13:56:30 2004
@@ -842,10 +842,21 @@
 
 	while (!hwgroup->busy) {
 		hwgroup->busy = 1;
+		if (waitqueue_active(&hwgroup->notbusyq)) {
+			/*
+			 * check each drive to make sure there are no pending commands ie. that
+			 * we are truly "not busy".
+			 */
+			if (ata_pending_commands(hwgroup->drive))
+				return;
+			wake_up(&hwgroup->notbusyq);
+			return;
+		}
+		
 		drive = choose_drive(hwgroup);
 		if (drive == NULL) {
 			unsigned long sleep = 0;
-			hwgroup->busy = ata_pending_commands(hwgroup->drive);
+			hwgroup->busy = ata_pending_commands(drive);
 			if (hwgroup->sleeping) break;
 			hwgroup->rq = NULL;
 			drive = hwgroup->drive;
diff -urN linux-2.6.0-patch4/drivers/ide/ide-probe.c linux-2.6.0/drivers/ide/ide-probe.c
--- linux-2.6.0-patch4/drivers/ide/ide-probe.c	Thu Jan 29 13:53:38 2004
+++ linux-2.6.0/drivers/ide/ide-probe.c	Thu Jan 29 13:56:30 2004
@@ -1050,6 +1050,7 @@
 		init_timer(&hwgroup->timer);
 		hwgroup->timer.function = &ide_timer_expiry;
 		hwgroup->timer.data = (unsigned long) hwgroup;
+		init_waitqueue_head(&hwgroup->notbusyq);
 	}
 
 	/*
diff -urN linux-2.6.0-patch4/drivers/ide/ide-proc.c linux-2.6.0/drivers/ide/ide-proc.c
--- linux-2.6.0-patch4/drivers/ide/ide-proc.c	Thu Jan 29 13:53:38 2004
+++ linux-2.6.0/drivers/ide/ide-proc.c	Thu Jan 29 13:56:30 2004
@@ -127,6 +127,8 @@
 	int		for_real = 0;
 	unsigned long	startn = 0, n, flags;
 	const char	*start = NULL, *msg = NULL;
+	ide_hwgroup_t *mygroup = (ide_hwgroup_t *)hwif->hwgroup;
+	ide_hwgroup_t *mategroup = NULL;
 
 	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
 		return -EACCES;
@@ -145,22 +147,19 @@
 	do {
 		const char *p;
 		if (for_real) {
-			unsigned long timeout = jiffies + (3 * HZ);
-			ide_hwgroup_t *mygroup = (ide_hwgroup_t *)(hwif->hwgroup);
-			ide_hwgroup_t *mategroup = NULL;
 			if (hwif->mate && hwif->mate->hwgroup)
 				mategroup = (ide_hwgroup_t *)(hwif->mate->hwgroup);
-			spin_lock_irqsave(&ide_lock, flags);
-			while (mygroup->busy ||
-			       (mategroup && mategroup->busy)) {
-				spin_unlock_irqrestore(&ide_lock, flags);
-				if (time_after(jiffies, timeout)) {
-					printk("/proc/ide/%s/config: channel(s) busy, cannot write\n", hwif->name);
-					spin_unlock_irqrestore(&ide_lock, flags);
-					return -EBUSY;
-				}
-				spin_lock_irqsave(&ide_lock, flags);
+			if (mategroup == mygroup)
+				mategroup = NULL;
+			if (mategroup && mategroup < mygroup) {
+				/* arrange a consistent locking ordering, to avoid deadlock */
+				mygroup = mategroup;
+				mategroup = hwif->hwgroup;
 			}
+			spin_lock_irqsave(&ide_lock, flags);
+			ide_wait_hwgroup(mygroup);
+			if (mategroup)
+				ide_wait_hwgroup(mategroup);				
 		}
 		p = buffer;
 		n = count;
@@ -242,6 +241,9 @@
 							break;
 					}
 					if (rc) {
+						ide_kick_queue(mygroup);
+						if (mategroup)
+							ide_kick_queue(mategroup);						
 						spin_unlock_irqrestore(&ide_lock, flags);
 						printk("proc_ide_write_config: error writing %s at bus %02x dev %02x reg 0x%x value 0x%x\n",
 							msg, dev->bus->number, dev->devfn, reg, val);
@@ -284,6 +286,9 @@
 			}
 		}
 	} while (!for_real++);
+	ide_kick_queue(mygroup);
+	if (mategroup)
+		ide_kick_queue(mategroup);
 	spin_unlock_irqrestore(&ide_lock, flags);
 	return count;
 parse_error:
diff -urN linux-2.6.0-patch4/drivers/ide/ide.c linux-2.6.0/drivers/ide/ide.c
--- linux-2.6.0-patch4/drivers/ide/ide.c	Thu Jan 29 13:53:38 2004
+++ linux-2.6.0/drivers/ide/ide.c	Thu Jan 29 13:56:30 2004
@@ -1270,32 +1270,47 @@
 	return val;
 }
 
-int ide_spin_wait_hwgroup (ide_drive_t *drive)
+/*
+ * ide_wait_hwgroup  - Wait for the hwgroup to become not busy.
+ * @hwgroup: the group to wait for.
+ *
+ * Call with "ide_lock" spinlock held.
+ *
+ * If it returns with hwgroup->busy clear, caller can simply release ide_lock
+ * to continue processing. To release ide_lock without releasing the hwgroup,
+ * set ->busy before releasing ide_lock.
+ *
+ * If it returns with hwgroup->busy set, use ide_kick_queue() to release the
+ * hwgroup. ide_lock can be released at any time (but must be re-acquired
+ * before calling ide_kick_queue, and released afterwards).
+ *
+ * ide_kick_queue() can be used in the former case (->busy clear) also.
+ */
+void ide_wait_hwgroup (ide_hwgroup_t *hwgroup)
 {
-	ide_hwgroup_t *hwgroup = HWGROUP(drive);
-	unsigned long timeout = jiffies + (3 * HZ);
-
+	DEFINE_WAIT(wait);
+	
+	if (!hwgroup->busy)
+		return;
+	
+	/*
+	 * The wait queue is effectively protected by ide_lock, so it's possible
+	 * to bypass some of the usual mechanisms here
+	 */
+	wait.flags |= WQ_FLAG_EXCLUSIVE;
+	__add_wait_queue_tail(&hwgroup->notbusyq,&wait);
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	spin_unlock_irq(&ide_lock);
+	schedule();
+	
 	spin_lock_irq(&ide_lock);
-
-	while (hwgroup->busy) {
-		unsigned long lflags;
-		spin_unlock_irq(&ide_lock);
-		local_irq_set(lflags);
-		if (time_after(jiffies, timeout)) {
-			local_irq_restore(lflags);
-			printk(KERN_ERR "%s: channel busy\n", drive->name);
-			return -EBUSY;
-		}
-		local_irq_restore(lflags);
-		spin_lock_irq(&ide_lock);
-	}
-	return 0;
+	return;
 }
-
-EXPORT_SYMBOL(ide_spin_wait_hwgroup);
+	
+EXPORT_SYMBOL(ide_wait_hwgroup);
 
 /**
- *	ide_write_setting	-	read an IDE setting
+ *	ide_write_setting	-	write an IDE setting
  *	@drive: drive to read from
  *	@setting: drive setting
  *	@val: value
@@ -1306,10 +1321,6 @@
  *	BUGS: the data return and error are the same return value
  *	so an error -EINVAL and true return of the same value cannot
  *	be told apart
- *
- *	FIXME:  This should be changed to enqueue a special request
- *	to the driver to change settings, and then wait on a sema for completion.
- *	The current scheme of polling is kludgy, though safe enough.
  */
 int ide_write_setting (ide_drive_t *drive, ide_settings_t *setting, int val)
 {
@@ -1324,8 +1335,8 @@
 		return -EINVAL;
 	if (setting->set)
 		return setting->set(drive, val);
-	if (ide_spin_wait_hwgroup(drive))
-		return -EBUSY;
+	spin_lock_irq(&ide_lock);
+	ide_wait_hwgroup(HWGROUP(drive));
 	switch (setting->data_type) {
 		case TYPE_BYTE:
 			*((u8 *) setting->data) = val;
@@ -1342,6 +1353,7 @@
 				*p = val;
 			break;
 	}
+	ide_kick_queue(HWGROUP(drive));
 	spin_unlock_irq(&ide_lock);
 	return 0;
 }
diff -urN linux-2.6.0-patch4/include/linux/ide.h linux-2.6.0/include/linux/ide.h
--- linux-2.6.0-patch4/include/linux/ide.h	Thu Jan 29 13:52:44 2004
+++ linux-2.6.0/include/linux/ide.h	Thu Jan 29 13:55:50 2004
@@ -1066,6 +1066,9 @@
 		/* ide_system_bus_speed */
 	int pio_clock;
 
+		/* wait for group to become not-busy */
+	wait_queue_head_t notbusyq;
+
 	unsigned char cmd_buf[4];
 } ide_hwgroup_t;
 
@@ -1606,11 +1609,25 @@
  */
 extern void ide_stall_queue(ide_drive_t *drive, unsigned long timeout);
 
-extern int ide_spin_wait_hwgroup(ide_drive_t *);
+extern void ide_wait_hwgroup(ide_hwgroup_t *);
 extern void ide_timer_expiry(unsigned long);
 extern irqreturn_t ide_intr(int irq, void *dev_id, struct pt_regs *regs);
 extern void do_ide_request(request_queue_t *);
+extern void ide_do_request(ide_hwgroup_t *, int masked_irq);
 extern void ide_init_subdrivers(void);
+
+/*
+ * For use after ide_wait_hwgroup(). Kick a queue if it needs to be kicked.
+ * Ie. ensure requests are processed. Call with ide_lock held.
+ */
+static inline void ide_kick_queue(ide_hwgroup_t *q)
+{
+	if (q->busy) {
+		q->busy = 0;
+		if (q->drive)
+			do_ide_request(q->drive->queue);
+	}
+}
 
 extern struct block_device_operations ide_fops[];
 extern ide_proc_entry_t generic_subdriver_entries[];
