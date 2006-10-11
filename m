Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbWJKNi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbWJKNi2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 09:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbWJKNi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 09:38:28 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:26039 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751312AbWJKNi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 09:38:26 -0400
Date: Wed, 11 Oct 2006 15:38:17 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Please pull git390 'for-linus' branch
Message-ID: <20061011133815.GA11560@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull from 'for-linus' branch of

	git://git390.osdl.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

 arch/s390/appldata/appldata_base.c |    2 -
 arch/s390/kernel/s390_ext.c        |    4 +
 arch/s390/kernel/stacktrace.c      |   17 +++--
 arch/s390/kernel/vtime.c           |    8 +--
 drivers/s390/char/monwriter.c      |    2 -
 drivers/s390/cio/chsc.c            |   23 +++----
 drivers/s390/cio/cio.c             |    4 +
 drivers/s390/cio/css.c             |    2 -
 drivers/s390/cio/css.h             |    7 +-
 drivers/s390/cio/device.c          |   48 +++++++--------
 drivers/s390/cio/device.h          |    1 
 drivers/s390/cio/device_fsm.c      |  113 ++++++++++--------------------------
 drivers/s390/cio/device_id.c       |   14 +++-
 drivers/s390/cio/device_ops.c      |    6 +-
 drivers/s390/cio/device_pgid.c     |   23 ++++---
 drivers/s390/cio/device_status.c   |    7 +-
 drivers/s390/cio/qdio.c            |   10 ++-
 include/asm-s390/cio.h             |    6 ++
 include/asm-s390/timer.h           |    2 -
 19 files changed, 123 insertions(+), 176 deletions(-)

Christian Borntraeger:
      [S390] stacktrace bug.

Cornelia Huck:
      [S390] cio: add missing KERN_INFO printk header.
      [S390] cio: Use ccw_dev_id and subchannel_id in ccw_device_private
      [S390] cio: Remove grace period for vary off chpid.
      [S390] cio: remove casts from/to (void *).

Heiko Carstens:
      [S390] irq change improvements.

Melissa Howland:
      [S390] monwriter kzalloc size.

diff --git a/arch/s390/appldata/appldata_base.c b/arch/s390/appldata/appldata_base.c
index 2b1e6c9..45c9fa7 100644
--- a/arch/s390/appldata/appldata_base.c
+++ b/arch/s390/appldata/appldata_base.c
@@ -109,7 +109,7 @@ static LIST_HEAD(appldata_ops_list);
  *
  * schedule work and reschedule timer
  */
-static void appldata_timer_function(unsigned long data, struct pt_regs *regs)
+static void appldata_timer_function(unsigned long data)
 {
 	P_DEBUG("   -= Timer =-\n");
 	P_DEBUG("CPU: %i, expire_count: %i\n", smp_processor_id(),
diff --git a/arch/s390/kernel/s390_ext.c b/arch/s390/kernel/s390_ext.c
index c49ab8c..4faf96f 100644
--- a/arch/s390/kernel/s390_ext.c
+++ b/arch/s390/kernel/s390_ext.c
@@ -117,8 +117,8 @@ void do_extint(struct pt_regs *regs, uns
         int index;
 	struct pt_regs *old_regs;
 
-	irq_enter();
 	old_regs = set_irq_regs(regs);
+	irq_enter();
 	asm volatile ("mc 0,0");
 	if (S390_lowcore.int_clock >= S390_lowcore.jiffy_timer)
 		/**
@@ -134,8 +134,8 @@ void do_extint(struct pt_regs *regs, uns
 				p->handler(code);
 		}
 	}
-	set_irq_regs(old_regs);
 	irq_exit();
+	set_irq_regs(old_regs);
 }
 
 EXPORT_SYMBOL(register_external_interrupt);
diff --git a/arch/s390/kernel/stacktrace.c b/arch/s390/kernel/stacktrace.c
index d9428a0..0d14a47 100644
--- a/arch/s390/kernel/stacktrace.c
+++ b/arch/s390/kernel/stacktrace.c
@@ -62,27 +62,26 @@ static inline unsigned long save_context
 void save_stack_trace(struct stack_trace *trace, struct task_struct *task)
 {
 	register unsigned long sp asm ("15");
-	unsigned long orig_sp;
+	unsigned long orig_sp, new_sp;
 
-	sp &= PSW_ADDR_INSN;
-	orig_sp = sp;
+	orig_sp = sp & PSW_ADDR_INSN;
 
-	sp = save_context_stack(trace, &trace->skip, sp,
+	new_sp = save_context_stack(trace, &trace->skip, orig_sp,
 				S390_lowcore.panic_stack - PAGE_SIZE,
 				S390_lowcore.panic_stack);
-	if ((sp != orig_sp) && !trace->all_contexts)
+	if ((new_sp != orig_sp) && !trace->all_contexts)
 		return;
-	sp = save_context_stack(trace, &trace->skip, sp,
+	new_sp = save_context_stack(trace, &trace->skip, new_sp,
 				S390_lowcore.async_stack - ASYNC_SIZE,
 				S390_lowcore.async_stack);
-	if ((sp != orig_sp) && !trace->all_contexts)
+	if ((new_sp != orig_sp) && !trace->all_contexts)
 		return;
 	if (task)
-		save_context_stack(trace, &trace->skip, sp,
+		save_context_stack(trace, &trace->skip, new_sp,
 				   (unsigned long) task_stack_page(task),
 				   (unsigned long) task_stack_page(task) + THREAD_SIZE);
 	else
-		save_context_stack(trace, &trace->skip, sp,
+		save_context_stack(trace, &trace->skip, new_sp,
 				   S390_lowcore.thread_info,
 				   S390_lowcore.thread_info + THREAD_SIZE);
 	return;
diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index 1d7d393..21baaf5 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -209,11 +209,11 @@ static void list_add_sorted(struct vtime
  * Do the callback functions of expired vtimer events.
  * Called from within the interrupt handler.
  */
-static void do_callbacks(struct list_head *cb_list, struct pt_regs *regs)
+static void do_callbacks(struct list_head *cb_list)
 {
 	struct vtimer_queue *vt_list;
 	struct vtimer_list *event, *tmp;
-	void (*fn)(unsigned long, struct pt_regs*);
+	void (*fn)(unsigned long);
 	unsigned long data;
 
 	if (list_empty(cb_list))
@@ -224,7 +224,7 @@ static void do_callbacks(struct list_hea
 	list_for_each_entry_safe(event, tmp, cb_list, entry) {
 		fn = event->function;
 		data = event->data;
-		fn(data, regs);
+		fn(data);
 
 		if (!event->interval)
 			/* delete one shot timer */
@@ -275,7 +275,7 @@ static void do_cpu_timer_interrupt(__u16
 		list_move_tail(&event->entry, &cb_list);
 	}
 	spin_unlock(&vt_list->lock);
-	do_callbacks(&cb_list, get_irq_regs());
+	do_callbacks(&cb_list);
 
 	/* next event is first in list */
 	spin_lock(&vt_list->lock);
diff --git a/drivers/s390/char/monwriter.c b/drivers/s390/char/monwriter.c
index 4362ff2..abd02ed 100644
--- a/drivers/s390/char/monwriter.c
+++ b/drivers/s390/char/monwriter.c
@@ -110,7 +110,7 @@ static int monwrite_new_hdr(struct mon_p
 		monbuf = kzalloc(sizeof(struct mon_buf), GFP_KERNEL);
 		if (!monbuf)
 			return -ENOMEM;
-		monbuf->data = kzalloc(monbuf->hdr.datalen,
+		monbuf->data = kzalloc(monhdr->datalen,
 				       GFP_KERNEL | GFP_DMA);
 		if (!monbuf->data) {
 			kfree(monbuf);
diff --git a/drivers/s390/cio/chsc.c b/drivers/s390/cio/chsc.c
index 07c7f19..2d78f0f 100644
--- a/drivers/s390/cio/chsc.c
+++ b/drivers/s390/cio/chsc.c
@@ -370,7 +370,7 @@ __s390_process_res_acc(struct subchannel
 	struct res_acc_data *res_data;
 	struct subchannel *sch;
 
-	res_data = (struct res_acc_data *)data;
+	res_data = data;
 	sch = get_subchannel_by_schid(schid);
 	if (!sch)
 		/* Check if a subchannel is newly available. */
@@ -444,7 +444,7 @@ __get_chpid_from_lir(void *data)
 		u32 isinfo[28];
 	} *lir;
 
-	lir = (struct lir*) data;
+	lir = data;
 	if (!(lir->iq&0x80))
 		/* NULL link incident record */
 		return -EINVAL;
@@ -628,7 +628,7 @@ __chp_add(struct subchannel_id schid, vo
 	struct channel_path *chp;
 	struct subchannel *sch;
 
-	chp = (struct channel_path *)data;
+	chp = data;
 	sch = get_subchannel_by_schid(schid);
 	if (!sch)
 		/* Check if the subchannel is now available. */
@@ -707,8 +707,7 @@ chp_process_crw(int chpid, int on)
 	return chp_add(chpid);
 }
 
-static inline int
-__check_for_io_and_kill(struct subchannel *sch, int index)
+static inline int check_for_io_on_path(struct subchannel *sch, int index)
 {
 	int cc;
 
@@ -718,10 +717,8 @@ __check_for_io_and_kill(struct subchanne
 	cc = stsch(sch->schid, &sch->schib);
 	if (cc)
 		return 0;
-	if (sch->schib.scsw.actl && sch->schib.pmcw.lpum == (0x80 >> index)) {
-		device_set_waiting(sch);
+	if (sch->schib.scsw.actl && sch->schib.pmcw.lpum == (0x80 >> index))
 		return 1;
-	}
 	return 0;
 }
 
@@ -750,12 +747,10 @@ __s390_subchannel_vary_chpid(struct subc
 		} else {
 			sch->opm &= ~(0x80 >> chp);
 			sch->lpm &= ~(0x80 >> chp);
-			/*
-			 * Give running I/O a grace period in which it
-			 * can successfully terminate, even using the
-			 * just varied off path. Then kill it.
-			 */
-			if (!__check_for_io_and_kill(sch, chp) && !sch->lpm) {
+			if (check_for_io_on_path(sch, chp))
+				/* Path verification is done after killing. */
+				device_kill_io(sch);
+			else if (!sch->lpm) {
 				if (css_enqueue_subchannel_slow(sch->schid)) {
 					css_clear_subchannel_slow_list();
 					need_rescan = 1;
diff --git a/drivers/s390/cio/cio.c b/drivers/s390/cio/cio.c
index f18b162..8936e46 100644
--- a/drivers/s390/cio/cio.c
+++ b/drivers/s390/cio/cio.c
@@ -609,8 +609,8 @@ do_IRQ (struct pt_regs *regs)
 	struct irb *irb;
 	struct pt_regs *old_regs;
 
-	irq_enter ();
 	old_regs = set_irq_regs(regs);
+	irq_enter();
 	asm volatile ("mc 0,0");
 	if (S390_lowcore.int_clock >= S390_lowcore.jiffy_timer)
 		/**
@@ -655,8 +655,8 @@ do_IRQ (struct pt_regs *regs)
 		 * out of the sie which costs more cycles than it saves.
 		 */
 	} while (!MACHINE_IS_VM && tpi (NULL) != 0);
+	irq_exit();
 	set_irq_regs(old_regs);
-	irq_exit ();
 }
 
 #ifdef CONFIG_CCW_CONSOLE
diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index 7086a74..a2dee5b 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -177,7 +177,7 @@ get_subchannel_by_schid(struct subchanne
 	struct device *dev;
 
 	dev = bus_find_device(&css_bus_type, NULL,
-			      (void *)&schid, check_subchannel);
+			      &schid, check_subchannel);
 
 	return dev ? to_subchannel(dev) : NULL;
 }
diff --git a/drivers/s390/cio/css.h b/drivers/s390/cio/css.h
index 8aabb4a..4c2ff83 100644
--- a/drivers/s390/cio/css.h
+++ b/drivers/s390/cio/css.h
@@ -76,9 +76,8 @@ struct ccw_device_private {
 	int state;		/* device state */
 	atomic_t onoff;
 	unsigned long registered;
-	__u16 devno;		/* device number */
-	__u16 sch_no;		/* subchannel number */
-	__u8 ssid;              /* subchannel set id */
+	struct ccw_dev_id dev_id;	/* device id */
+	struct subchannel_id schid;	/* subchannel number */
 	__u8 imask;		/* lpm mask for SNID/SID/SPGID */
 	int iretry;		/* retry counter SNID/SID/SPGID */
 	struct {
@@ -171,7 +170,7 @@ void device_trigger_reprobe(struct subch
 
 /* Helper functions for vary on/off. */
 int device_is_online(struct subchannel *);
-void device_set_waiting(struct subchannel *);
+void device_kill_io(struct subchannel *);
 
 /* Machine check helper function. */
 void device_kill_pending_timer(struct subchannel *);
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index 6889456..94bdd4d 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -552,21 +552,19 @@ ccw_device_register(struct ccw_device *c
 }
 
 struct match_data {
-	unsigned int devno;
-	unsigned int ssid;
+	struct ccw_dev_id dev_id;
 	struct ccw_device * sibling;
 };
 
 static int
 match_devno(struct device * dev, void * data)
 {
-	struct match_data * d = (struct match_data *)data;
+	struct match_data * d = data;
 	struct ccw_device * cdev;
 
 	cdev = to_ccwdev(dev);
 	if ((cdev->private->state == DEV_STATE_DISCONNECTED) &&
-	    (cdev->private->devno == d->devno) &&
-	    (cdev->private->ssid == d->ssid) &&
+	    ccw_dev_id_is_equal(&cdev->private->dev_id, &d->dev_id) &&
 	    (cdev != d->sibling)) {
 		cdev->private->state = DEV_STATE_NOT_OPER;
 		return 1;
@@ -574,15 +572,13 @@ match_devno(struct device * dev, void * 
 	return 0;
 }
 
-static struct ccw_device *
-get_disc_ccwdev_by_devno(unsigned int devno, unsigned int ssid,
-			 struct ccw_device *sibling)
+static struct ccw_device * get_disc_ccwdev_by_dev_id(struct ccw_dev_id *dev_id,
+						     struct ccw_device *sibling)
 {
 	struct device *dev;
 	struct match_data data;
 
-	data.devno = devno;
-	data.ssid = ssid;
+	data.dev_id = *dev_id;
 	data.sibling = sibling;
 	dev = bus_find_device(&ccw_bus_type, NULL, &data, match_devno);
 
@@ -595,7 +591,7 @@ ccw_device_add_changed(void *data)
 
 	struct ccw_device *cdev;
 
-	cdev = (struct ccw_device *)data;
+	cdev = data;
 	if (device_add(&cdev->dev)) {
 		put_device(&cdev->dev);
 		return;
@@ -616,9 +612,9 @@ ccw_device_do_unreg_rereg(void *data)
 	struct subchannel *sch;
 	int need_rename;
 
-	cdev = (struct ccw_device *)data;
+	cdev = data;
 	sch = to_subchannel(cdev->dev.parent);
-	if (cdev->private->devno != sch->schib.pmcw.dev) {
+	if (cdev->private->dev_id.devno != sch->schib.pmcw.dev) {
 		/*
 		 * The device number has changed. This is usually only when
 		 * a device has been detached under VM and then re-appeared
@@ -633,10 +629,12 @@ ccw_device_do_unreg_rereg(void *data)
 		 *        get possibly sick...
 		 */
 		struct ccw_device *other_cdev;
+		struct ccw_dev_id dev_id;
 
 		need_rename = 1;
-		other_cdev = get_disc_ccwdev_by_devno(sch->schib.pmcw.dev,
-						      sch->schid.ssid, cdev);
+		dev_id.devno = sch->schib.pmcw.dev;
+		dev_id.ssid = sch->schid.ssid;
+		other_cdev = get_disc_ccwdev_by_dev_id(&dev_id, cdev);
 		if (other_cdev) {
 			struct subchannel *other_sch;
 
@@ -652,7 +650,7 @@ ccw_device_do_unreg_rereg(void *data)
 		}
 		/* Update ssd info here. */
 		css_get_ssd_info(sch);
-		cdev->private->devno = sch->schib.pmcw.dev;
+		cdev->private->dev_id.devno = sch->schib.pmcw.dev;
 	} else
 		need_rename = 0;
 	device_remove_files(&cdev->dev);
@@ -662,7 +660,7 @@ ccw_device_do_unreg_rereg(void *data)
 		snprintf (cdev->dev.bus_id, BUS_ID_SIZE, "0.%x.%04x",
 			  sch->schid.ssid, sch->schib.pmcw.dev);
 	PREPARE_WORK(&cdev->private->kick_work,
-		     ccw_device_add_changed, (void *)cdev);
+		     ccw_device_add_changed, cdev);
 	queue_work(ccw_device_work, &cdev->private->kick_work);
 }
 
@@ -687,7 +685,7 @@ io_subchannel_register(void *data)
 	int ret;
 	unsigned long flags;
 
-	cdev = (struct ccw_device *) data;
+	cdev = data;
 	sch = to_subchannel(cdev->dev.parent);
 
 	if (klist_node_attached(&cdev->dev.knode_parent)) {
@@ -759,7 +757,7 @@ io_subchannel_recog_done(struct ccw_devi
 			break;
 		sch = to_subchannel(cdev->dev.parent);
 		PREPARE_WORK(&cdev->private->kick_work,
-			     ccw_device_call_sch_unregister, (void *) cdev);
+			     ccw_device_call_sch_unregister, cdev);
 		queue_work(slow_path_wq, &cdev->private->kick_work);
 		if (atomic_dec_and_test(&ccw_device_init_count))
 			wake_up(&ccw_device_init_wq);
@@ -774,7 +772,7 @@ io_subchannel_recog_done(struct ccw_devi
 		if (!get_device(&cdev->dev))
 			break;
 		PREPARE_WORK(&cdev->private->kick_work,
-			     io_subchannel_register, (void *) cdev);
+			     io_subchannel_register, cdev);
 		queue_work(slow_path_wq, &cdev->private->kick_work);
 		break;
 	}
@@ -792,9 +790,9 @@ io_subchannel_recog(struct ccw_device *c
 
 	/* Init private data. */
 	priv = cdev->private;
-	priv->devno = sch->schib.pmcw.dev;
-	priv->ssid = sch->schid.ssid;
-	priv->sch_no = sch->schid.sch_no;
+	priv->dev_id.devno = sch->schib.pmcw.dev;
+	priv->dev_id.ssid = sch->schid.ssid;
+	priv->schid = sch->schid;
 	priv->state = DEV_STATE_NOT_OPER;
 	INIT_LIST_HEAD(&priv->cmb_list);
 	init_waitqueue_head(&priv->wait_q);
@@ -912,7 +910,7 @@ io_subchannel_remove (struct subchannel 
 	 */
 	if (get_device(&cdev->dev)) {
 		PREPARE_WORK(&cdev->private->kick_work,
-			     ccw_device_unregister, (void *) cdev);
+			     ccw_device_unregister, cdev);
 		queue_work(ccw_device_work, &cdev->private->kick_work);
 	}
 	return 0;
@@ -1055,7 +1053,7 @@ __ccwdev_check_busid(struct device *dev,
 {
 	char *bus_id;
 
-	bus_id = (char *)id;
+	bus_id = id;
 
 	return (strncmp(bus_id, dev->bus_id, BUS_ID_SIZE) == 0);
 }
diff --git a/drivers/s390/cio/device.h b/drivers/s390/cio/device.h
index 00be9a5..c6140cc 100644
--- a/drivers/s390/cio/device.h
+++ b/drivers/s390/cio/device.h
@@ -21,7 +21,6 @@ enum dev_state {
 	/* states to wait for i/o completion before doing something */
 	DEV_STATE_CLEAR_VERIFY,
 	DEV_STATE_TIMEOUT_KILL,
-	DEV_STATE_WAIT4IO,
 	DEV_STATE_QUIESCE,
 	/* special states for devices gone not operational */
 	DEV_STATE_DISCONNECTED,
diff --git a/drivers/s390/cio/device_fsm.c b/drivers/s390/cio/device_fsm.c
index b676202..fcaf28d 100644
--- a/drivers/s390/cio/device_fsm.c
+++ b/drivers/s390/cio/device_fsm.c
@@ -59,18 +59,6 @@ device_set_disconnected(struct subchanne
 	cdev->private->state = DEV_STATE_DISCONNECTED;
 }
 
-void
-device_set_waiting(struct subchannel *sch)
-{
-	struct ccw_device *cdev;
-
-	if (!sch->dev.driver_data)
-		return;
-	cdev = sch->dev.driver_data;
-	ccw_device_set_timeout(cdev, 10*HZ);
-	cdev->private->state = DEV_STATE_WAIT4IO;
-}
-
 /*
  * Timeout function. It just triggers a DEV_EVENT_TIMEOUT.
  */
@@ -183,9 +171,9 @@ ccw_device_handle_oper(struct ccw_device
 	    cdev->id.cu_model != cdev->private->senseid.cu_model ||
 	    cdev->id.dev_type != cdev->private->senseid.dev_type ||
 	    cdev->id.dev_model != cdev->private->senseid.dev_model ||
-	    cdev->private->devno != sch->schib.pmcw.dev) {
+	    cdev->private->dev_id.devno != sch->schib.pmcw.dev) {
 		PREPARE_WORK(&cdev->private->kick_work,
-			     ccw_device_do_unreg_rereg, (void *)cdev);
+			     ccw_device_do_unreg_rereg, cdev);
 		queue_work(ccw_device_work, &cdev->private->kick_work);
 		return 0;
 	}
@@ -255,7 +243,7 @@ ccw_device_recog_done(struct ccw_device 
 	case DEV_STATE_NOT_OPER:
 		CIO_DEBUG(KERN_WARNING, 2,
 			  "SenseID : unknown device %04x on subchannel "
-			  "0.%x.%04x\n", cdev->private->devno,
+			  "0.%x.%04x\n", cdev->private->dev_id.devno,
 			  sch->schid.ssid, sch->schid.sch_no);
 		break;
 	case DEV_STATE_OFFLINE:
@@ -282,14 +270,15 @@ ccw_device_recog_done(struct ccw_device 
 		CIO_DEBUG(KERN_INFO, 2, "SenseID : device 0.%x.%04x reports: "
 			  "CU  Type/Mod = %04X/%02X, Dev Type/Mod = "
 			  "%04X/%02X\n",
-			  cdev->private->ssid, cdev->private->devno,
+			  cdev->private->dev_id.ssid,
+			  cdev->private->dev_id.devno,
 			  cdev->id.cu_type, cdev->id.cu_model,
 			  cdev->id.dev_type, cdev->id.dev_model);
 		break;
 	case DEV_STATE_BOXED:
 		CIO_DEBUG(KERN_WARNING, 2,
 			  "SenseID : boxed device %04x on subchannel "
-			  "0.%x.%04x\n", cdev->private->devno,
+			  "0.%x.%04x\n", cdev->private->dev_id.devno,
 			  sch->schid.ssid, sch->schid.sch_no);
 		break;
 	}
@@ -325,13 +314,13 @@ ccw_device_oper_notify(void *data)
 	struct subchannel *sch;
 	int ret;
 
-	cdev = (struct ccw_device *)data;
+	cdev = data;
 	sch = to_subchannel(cdev->dev.parent);
 	ret = (sch->driver && sch->driver->notify) ?
 		sch->driver->notify(&sch->dev, CIO_OPER) : 0;
 	if (!ret)
 		/* Driver doesn't want device back. */
-		ccw_device_do_unreg_rereg((void *)cdev);
+		ccw_device_do_unreg_rereg(cdev);
 	else {
 		/* Reenable channel measurements, if needed. */
 		cmf_reenable(cdev);
@@ -363,12 +352,12 @@ ccw_device_done(struct ccw_device *cdev,
 	if (state == DEV_STATE_BOXED)
 		CIO_DEBUG(KERN_WARNING, 2,
 			  "Boxed device %04x on subchannel %04x\n",
-			  cdev->private->devno, sch->schid.sch_no);
+			  cdev->private->dev_id.devno, sch->schid.sch_no);
 
 	if (cdev->private->flags.donotify) {
 		cdev->private->flags.donotify = 0;
 		PREPARE_WORK(&cdev->private->kick_work, ccw_device_oper_notify,
-			     (void *)cdev);
+			     cdev);
 		queue_work(ccw_device_notify_work, &cdev->private->kick_work);
 	}
 	wake_up(&cdev->private->wait_q);
@@ -412,7 +401,8 @@ static void __ccw_device_get_common_pgid
 		/* PGID mismatch, can't pathgroup. */
 		CIO_MSG_EVENT(0, "SNID - pgid mismatch for device "
 			      "0.%x.%04x, can't pathgroup\n",
-			      cdev->private->ssid, cdev->private->devno);
+			      cdev->private->dev_id.ssid,
+			      cdev->private->dev_id.devno);
 		cdev->private->options.pgroup = 0;
 		return;
 	}
@@ -523,7 +513,7 @@ ccw_device_nopath_notify(void *data)
 	struct subchannel *sch;
 	int ret;
 
-	cdev = (struct ccw_device *)data;
+	cdev = data;
 	sch = to_subchannel(cdev->dev.parent);
 	/* Extra sanity. */
 	if (sch->lpm)
@@ -537,7 +527,7 @@ ccw_device_nopath_notify(void *data)
 			if (get_device(&cdev->dev)) {
 				PREPARE_WORK(&cdev->private->kick_work,
 					     ccw_device_call_sch_unregister,
-					     (void *)cdev);
+					     cdev);
 				queue_work(ccw_device_work,
 					   &cdev->private->kick_work);
 			} else
@@ -592,7 +582,7 @@ ccw_device_verify_done(struct ccw_device
 		break;
 	default:
 		PREPARE_WORK(&cdev->private->kick_work,
-			     ccw_device_nopath_notify, (void *)cdev);
+			     ccw_device_nopath_notify, cdev);
 		queue_work(ccw_device_notify_work, &cdev->private->kick_work);
 		ccw_device_done(cdev, DEV_STATE_NOT_OPER);
 		break;
@@ -723,7 +713,7 @@ ccw_device_offline_notoper(struct ccw_de
 	sch = to_subchannel(cdev->dev.parent);
 	if (get_device(&cdev->dev)) {
 		PREPARE_WORK(&cdev->private->kick_work,
-			     ccw_device_call_sch_unregister, (void *)cdev);
+			     ccw_device_call_sch_unregister, cdev);
 		queue_work(ccw_device_work, &cdev->private->kick_work);
 	}
 	wake_up(&cdev->private->wait_q);
@@ -754,7 +744,7 @@ ccw_device_online_notoper(struct ccw_dev
 	}
 	if (get_device(&cdev->dev)) {
 		PREPARE_WORK(&cdev->private->kick_work,
-			     ccw_device_call_sch_unregister, (void *)cdev);
+			     ccw_device_call_sch_unregister, cdev);
 		queue_work(ccw_device_work, &cdev->private->kick_work);
 	}
 	wake_up(&cdev->private->wait_q);
@@ -859,7 +849,7 @@ ccw_device_online_timeout(struct ccw_dev
 		sch = to_subchannel(cdev->dev.parent);
 		if (!sch->lpm) {
 			PREPARE_WORK(&cdev->private->kick_work,
-				     ccw_device_nopath_notify, (void *)cdev);
+				     ccw_device_nopath_notify, cdev);
 			queue_work(ccw_device_notify_work,
 				   &cdev->private->kick_work);
 		} else
@@ -885,7 +875,8 @@ ccw_device_w4sense(struct ccw_device *cd
 			/* Basic sense hasn't started. Try again. */
 			ccw_device_do_sense(cdev, irb);
 		else {
-			printk("Huh? %s(%s): unsolicited interrupt...\n",
+			printk(KERN_INFO "Huh? %s(%s): unsolicited "
+			       "interrupt...\n",
 			       __FUNCTION__, cdev->dev.bus_id);
 			if (cdev->handler)
 				cdev->handler (cdev, 0, irb);
@@ -944,10 +935,10 @@ ccw_device_killing_irq(struct ccw_device
 	cdev->private->state = DEV_STATE_ONLINE;
 	if (cdev->handler)
 		cdev->handler(cdev, cdev->private->intparm,
-			      ERR_PTR(-ETIMEDOUT));
+			      ERR_PTR(-EIO));
 	if (!sch->lpm) {
 		PREPARE_WORK(&cdev->private->kick_work,
-			     ccw_device_nopath_notify, (void *)cdev);
+			     ccw_device_nopath_notify, cdev);
 		queue_work(ccw_device_notify_work, &cdev->private->kick_work);
 	} else if (cdev->private->flags.doverify)
 		/* Start delayed path verification. */
@@ -970,7 +961,7 @@ ccw_device_killing_timeout(struct ccw_de
 		sch = to_subchannel(cdev->dev.parent);
 		if (!sch->lpm) {
 			PREPARE_WORK(&cdev->private->kick_work,
-				     ccw_device_nopath_notify, (void *)cdev);
+				     ccw_device_nopath_notify, cdev);
 			queue_work(ccw_device_notify_work,
 				   &cdev->private->kick_work);
 		} else
@@ -981,51 +972,15 @@ ccw_device_killing_timeout(struct ccw_de
 	cdev->private->state = DEV_STATE_ONLINE;
 	if (cdev->handler)
 		cdev->handler(cdev, cdev->private->intparm,
-			      ERR_PTR(-ETIMEDOUT));
-}
-
-static void
-ccw_device_wait4io_irq(struct ccw_device *cdev, enum dev_event dev_event)
-{
-	struct irb *irb;
-	struct subchannel *sch;
-
-	irb = (struct irb *) __LC_IRB;
-	/*
-	 * Accumulate status and find out if a basic sense is needed.
-	 * This is fine since we have already adapted the lpm.
-	 */
-	ccw_device_accumulate_irb(cdev, irb);
-	if (cdev->private->flags.dosense) {
-		if (ccw_device_do_sense(cdev, irb) == 0) {
-			cdev->private->state = DEV_STATE_W4SENSE;
-		}
-		return;
-	}
-
-	/* Iff device is idle, reset timeout. */
-	sch = to_subchannel(cdev->dev.parent);
-	if (!stsch(sch->schid, &sch->schib))
-		if (sch->schib.scsw.actl == 0)
-			ccw_device_set_timeout(cdev, 0);
-	/* Call the handler. */
-	ccw_device_call_handler(cdev);
-	if (!sch->lpm) {
-		PREPARE_WORK(&cdev->private->kick_work,
-			     ccw_device_nopath_notify, (void *)cdev);
-		queue_work(ccw_device_notify_work, &cdev->private->kick_work);
-	} else if (cdev->private->flags.doverify)
-		ccw_device_online_verify(cdev, 0);
+			      ERR_PTR(-EIO));
 }
 
-static void
-ccw_device_wait4io_timeout(struct ccw_device *cdev, enum dev_event dev_event)
+void device_kill_io(struct subchannel *sch)
 {
 	int ret;
-	struct subchannel *sch;
+	struct ccw_device *cdev;
 
-	sch = to_subchannel(cdev->dev.parent);
-	ccw_device_set_timeout(cdev, 0);
+	cdev = sch->dev.driver_data;
 	ret = ccw_device_cancel_halt_clear(cdev);
 	if (ret == -EBUSY) {
 		ccw_device_set_timeout(cdev, 3*HZ);
@@ -1035,7 +990,7 @@ ccw_device_wait4io_timeout(struct ccw_de
 	if (ret == -ENODEV) {
 		if (!sch->lpm) {
 			PREPARE_WORK(&cdev->private->kick_work,
-				     ccw_device_nopath_notify, (void *)cdev);
+				     ccw_device_nopath_notify, cdev);
 			queue_work(ccw_device_notify_work,
 				   &cdev->private->kick_work);
 		} else
@@ -1044,12 +999,12 @@ ccw_device_wait4io_timeout(struct ccw_de
 	}
 	if (cdev->handler)
 		cdev->handler(cdev, cdev->private->intparm,
-			      ERR_PTR(-ETIMEDOUT));
+			      ERR_PTR(-EIO));
 	if (!sch->lpm) {
 		PREPARE_WORK(&cdev->private->kick_work,
-			     ccw_device_nopath_notify, (void *)cdev);
+			     ccw_device_nopath_notify, cdev);
 		queue_work(ccw_device_notify_work, &cdev->private->kick_work);
-	} else if (cdev->private->flags.doverify)
+	} else
 		/* Start delayed path verification. */
 		ccw_device_online_verify(cdev, 0);
 }
@@ -1286,12 +1241,6 @@ fsm_func_t *dev_jumptable[NR_DEV_STATES]
 		[DEV_EVENT_TIMEOUT]	= ccw_device_killing_timeout,
 		[DEV_EVENT_VERIFY]	= ccw_device_nop, //FIXME
 	},
-	[DEV_STATE_WAIT4IO] = {
-		[DEV_EVENT_NOTOPER]	= ccw_device_online_notoper,
-		[DEV_EVENT_INTERRUPT]	= ccw_device_wait4io_irq,
-		[DEV_EVENT_TIMEOUT]	= ccw_device_wait4io_timeout,
-		[DEV_EVENT_VERIFY]	= ccw_device_delay_verify,
-	},
 	[DEV_STATE_QUIESCE] = {
 		[DEV_EVENT_NOTOPER]	= ccw_device_quiesce_done,
 		[DEV_EVENT_INTERRUPT]	= ccw_device_quiesce_done,
diff --git a/drivers/s390/cio/device_id.c b/drivers/s390/cio/device_id.c
index 1398367..a74785b 100644
--- a/drivers/s390/cio/device_id.c
+++ b/drivers/s390/cio/device_id.c
@@ -251,7 +251,7 @@ ccw_device_check_sense_id(struct ccw_dev
 		 */
 		CIO_MSG_EVENT(2, "SenseID : device %04x on Subchannel "
 			      "0.%x.%04x reports cmd reject\n",
-			      cdev->private->devno, sch->schid.ssid,
+			      cdev->private->dev_id.devno, sch->schid.ssid,
 			      sch->schid.sch_no);
 		return -EOPNOTSUPP;
 	}
@@ -259,7 +259,8 @@ ccw_device_check_sense_id(struct ccw_dev
 		CIO_MSG_EVENT(2, "SenseID : UC on dev 0.%x.%04x, "
 			      "lpum %02X, cnt %02d, sns :"
 			      " %02X%02X%02X%02X %02X%02X%02X%02X ...\n",
-			      cdev->private->ssid, cdev->private->devno,
+			      cdev->private->dev_id.ssid,
+			      cdev->private->dev_id.devno,
 			      irb->esw.esw0.sublog.lpum,
 			      irb->esw.esw0.erw.scnt,
 			      irb->ecw[0], irb->ecw[1],
@@ -274,14 +275,15 @@ ccw_device_check_sense_id(struct ccw_dev
 			CIO_MSG_EVENT(2, "SenseID : path %02X for device %04x "
 				      "on subchannel 0.%x.%04x is "
 				      "'not operational'\n", sch->orb.lpm,
-				      cdev->private->devno, sch->schid.ssid,
-				      sch->schid.sch_no);
+				      cdev->private->dev_id.devno,
+				      sch->schid.ssid, sch->schid.sch_no);
 		return -EACCES;
 	}
 	/* Hmm, whatever happened, try again. */
 	CIO_MSG_EVENT(2, "SenseID : start_IO() for device %04x on "
 		      "subchannel 0.%x.%04x returns status %02X%02X\n",
-		      cdev->private->devno, sch->schid.ssid, sch->schid.sch_no,
+		      cdev->private->dev_id.devno, sch->schid.ssid,
+		      sch->schid.sch_no,
 		      irb->scsw.dstat, irb->scsw.cstat);
 	return -EAGAIN;
 }
@@ -330,7 +332,7 @@ ccw_device_sense_id_irq(struct ccw_devic
 		/* fall through. */
 	default:		/* Sense ID failed. Try asking VM. */
 		if (MACHINE_IS_VM) {
-			VM_virtual_device_info (cdev->private->devno,
+			VM_virtual_device_info (cdev->private->dev_id.devno,
 						&cdev->private->senseid);
 			if (cdev->private->senseid.cu_type != 0xFFFF) {
 				/* Got the device information from VM. */
diff --git a/drivers/s390/cio/device_ops.c b/drivers/s390/cio/device_ops.c
index 84b9b18..b39c1fa 100644
--- a/drivers/s390/cio/device_ops.c
+++ b/drivers/s390/cio/device_ops.c
@@ -50,7 +50,6 @@ ccw_device_clear(struct ccw_device *cdev
 	if (cdev->private->state == DEV_STATE_NOT_OPER)
 		return -ENODEV;
 	if (cdev->private->state != DEV_STATE_ONLINE &&
-	    cdev->private->state != DEV_STATE_WAIT4IO &&
 	    cdev->private->state != DEV_STATE_W4SENSE)
 		return -EINVAL;
 	sch = to_subchannel(cdev->dev.parent);
@@ -155,7 +154,6 @@ ccw_device_halt(struct ccw_device *cdev,
 	if (cdev->private->state == DEV_STATE_NOT_OPER)
 		return -ENODEV;
 	if (cdev->private->state != DEV_STATE_ONLINE &&
-	    cdev->private->state != DEV_STATE_WAIT4IO &&
 	    cdev->private->state != DEV_STATE_W4SENSE)
 		return -EINVAL;
 	sch = to_subchannel(cdev->dev.parent);
@@ -592,13 +590,13 @@ ccw_device_get_chp_desc(struct ccw_devic
 int
 _ccw_device_get_subchannel_number(struct ccw_device *cdev)
 {
-	return cdev->private->sch_no;
+	return cdev->private->schid.sch_no;
 }
 
 int
 _ccw_device_get_device_number(struct ccw_device *cdev)
 {
-	return cdev->private->devno;
+	return cdev->private->dev_id.devno;
 }
 
 
diff --git a/drivers/s390/cio/device_pgid.c b/drivers/s390/cio/device_pgid.c
index 84917b3..2975ce8 100644
--- a/drivers/s390/cio/device_pgid.c
+++ b/drivers/s390/cio/device_pgid.c
@@ -79,7 +79,8 @@ __ccw_device_sense_pgid_start(struct ccw
 			CIO_MSG_EVENT(2, "SNID - Device %04x on Subchannel "
 				      "0.%x.%04x, lpm %02X, became 'not "
 				      "operational'\n",
-				      cdev->private->devno, sch->schid.ssid,
+				      cdev->private->dev_id.devno,
+				      sch->schid.ssid,
 				      sch->schid.sch_no, cdev->private->imask);
 
 		}
@@ -135,7 +136,8 @@ __ccw_device_check_sense_pgid(struct ccw
 		CIO_MSG_EVENT(2, "SNID - device 0.%x.%04x, unit check, "
 			      "lpum %02X, cnt %02d, sns : "
 			      "%02X%02X%02X%02X %02X%02X%02X%02X ...\n",
-			      cdev->private->ssid, cdev->private->devno,
+			      cdev->private->dev_id.ssid,
+			      cdev->private->dev_id.devno,
 			      irb->esw.esw0.sublog.lpum,
 			      irb->esw.esw0.erw.scnt,
 			      irb->ecw[0], irb->ecw[1],
@@ -147,7 +149,7 @@ __ccw_device_check_sense_pgid(struct ccw
 	if (irb->scsw.cc == 3) {
 		CIO_MSG_EVENT(2, "SNID - Device %04x on Subchannel 0.%x.%04x,"
 			      " lpm %02X, became 'not operational'\n",
-			      cdev->private->devno, sch->schid.ssid,
+			      cdev->private->dev_id.devno, sch->schid.ssid,
 			      sch->schid.sch_no, sch->orb.lpm);
 		return -EACCES;
 	}
@@ -155,7 +157,7 @@ __ccw_device_check_sense_pgid(struct ccw
 	if (cdev->private->pgid[i].inf.ps.state2 == SNID_STATE2_RESVD_ELSE) {
 		CIO_MSG_EVENT(2, "SNID - Device %04x on Subchannel 0.%x.%04x "
 			      "is reserved by someone else\n",
-			      cdev->private->devno, sch->schid.ssid,
+			      cdev->private->dev_id.devno, sch->schid.ssid,
 			      sch->schid.sch_no);
 		return -EUSERS;
 	}
@@ -261,7 +263,7 @@ __ccw_device_do_pgid(struct ccw_device *
 	/* PGID command failed on this path. */
 	CIO_MSG_EVENT(2, "SPID - Device %04x on Subchannel "
 		      "0.%x.%04x, lpm %02X, became 'not operational'\n",
-		      cdev->private->devno, sch->schid.ssid,
+		      cdev->private->dev_id.devno, sch->schid.ssid,
 		      sch->schid.sch_no, cdev->private->imask);
 	return ret;
 }
@@ -301,7 +303,7 @@ static int __ccw_device_do_nop(struct cc
 	/* nop command failed on this path. */
 	CIO_MSG_EVENT(2, "NOP - Device %04x on Subchannel "
 		      "0.%x.%04x, lpm %02X, became 'not operational'\n",
-		      cdev->private->devno, sch->schid.ssid,
+		      cdev->private->dev_id.devno, sch->schid.ssid,
 		      sch->schid.sch_no, cdev->private->imask);
 	return ret;
 }
@@ -328,8 +330,9 @@ __ccw_device_check_pgid(struct ccw_devic
 		CIO_MSG_EVENT(2, "SPID - device 0.%x.%04x, unit check, "
 			      "cnt %02d, "
 			      "sns : %02X%02X%02X%02X %02X%02X%02X%02X ...\n",
-			      cdev->private->ssid,
-			      cdev->private->devno, irb->esw.esw0.erw.scnt,
+			      cdev->private->dev_id.ssid,
+			      cdev->private->dev_id.devno,
+			      irb->esw.esw0.erw.scnt,
 			      irb->ecw[0], irb->ecw[1],
 			      irb->ecw[2], irb->ecw[3],
 			      irb->ecw[4], irb->ecw[5],
@@ -339,7 +342,7 @@ __ccw_device_check_pgid(struct ccw_devic
 	if (irb->scsw.cc == 3) {
 		CIO_MSG_EVENT(2, "SPID - Device %04x on Subchannel 0.%x.%04x,"
 			      " lpm %02X, became 'not operational'\n",
-			      cdev->private->devno, sch->schid.ssid,
+			      cdev->private->dev_id.devno, sch->schid.ssid,
 			      sch->schid.sch_no, cdev->private->imask);
 		return -EACCES;
 	}
@@ -362,7 +365,7 @@ static int __ccw_device_check_nop(struct
 	if (irb->scsw.cc == 3) {
 		CIO_MSG_EVENT(2, "NOP - Device %04x on Subchannel 0.%x.%04x,"
 			      " lpm %02X, became 'not operational'\n",
-			      cdev->private->devno, sch->schid.ssid,
+			      cdev->private->dev_id.devno, sch->schid.ssid,
 			      sch->schid.sch_no, cdev->private->imask);
 		return -EACCES;
 	}
diff --git a/drivers/s390/cio/device_status.c b/drivers/s390/cio/device_status.c
index caf148d..3f7cbce 100644
--- a/drivers/s390/cio/device_status.c
+++ b/drivers/s390/cio/device_status.c
@@ -32,19 +32,18 @@ ccw_device_msg_control_check(struct ccw_
 				 SCHN_STAT_CHN_CTRL_CHK |
 				 SCHN_STAT_INTF_CTRL_CHK)))
 		return;
-		
 	CIO_MSG_EVENT(0, "Channel-Check or Interface-Control-Check "
 		      "received"
 		      " ... device %04x on subchannel 0.%x.%04x, dev_stat "
 		      ": %02X sch_stat : %02X\n",
-		      cdev->private->devno, cdev->private->ssid,
-		      cdev->private->sch_no,
+		      cdev->private->dev_id.devno, cdev->private->schid.ssid,
+		      cdev->private->schid.sch_no,
 		      irb->scsw.dstat, irb->scsw.cstat);
 
 	if (irb->scsw.cc != 3) {
 		char dbf_text[15];
 
-		sprintf(dbf_text, "chk%x", cdev->private->sch_no);
+		sprintf(dbf_text, "chk%x", cdev->private->schid.sch_no);
 		CIO_TRACE_EVENT(0, dbf_text);
 		CIO_HEX_EVENT(0, irb, sizeof (struct irb));
 	}
diff --git a/drivers/s390/cio/qdio.c b/drivers/s390/cio/qdio.c
index cde822d..0648ce5 100644
--- a/drivers/s390/cio/qdio.c
+++ b/drivers/s390/cio/qdio.c
@@ -1741,7 +1741,7 @@ qdio_fill_qs(struct qdio_irq *irq_ptr, s
 	void *ptr;
 	int available;
 
-	sprintf(dbf_text,"qfqs%4x",cdev->private->sch_no);
+	sprintf(dbf_text,"qfqs%4x",cdev->private->schid.sch_no);
 	QDIO_DBF_TEXT0(0,setup,dbf_text);
 	for (i=0;i<no_input_qs;i++) {
 		q=irq_ptr->input_qs[i];
@@ -2924,7 +2924,7 @@ qdio_establish_handle_irq(struct ccw_dev
 
 	irq_ptr = cdev->private->qdio_data;
 
-	sprintf(dbf_text,"qehi%4x",cdev->private->sch_no);
+	sprintf(dbf_text,"qehi%4x",cdev->private->schid.sch_no);
 	QDIO_DBF_TEXT0(0,setup,dbf_text);
 	QDIO_DBF_TEXT0(0,trace,dbf_text);
 
@@ -2943,7 +2943,7 @@ qdio_initialize(struct qdio_initialize *
 	int rc;
 	char dbf_text[15];
 
-	sprintf(dbf_text,"qini%4x",init_data->cdev->private->sch_no);
+	sprintf(dbf_text,"qini%4x",init_data->cdev->private->schid.sch_no);
 	QDIO_DBF_TEXT0(0,setup,dbf_text);
 	QDIO_DBF_TEXT0(0,trace,dbf_text);
 
@@ -2964,7 +2964,7 @@ qdio_allocate(struct qdio_initialize *in
 	struct qdio_irq *irq_ptr;
 	char dbf_text[15];
 
-	sprintf(dbf_text,"qalc%4x",init_data->cdev->private->sch_no);
+	sprintf(dbf_text,"qalc%4x",init_data->cdev->private->schid.sch_no);
 	QDIO_DBF_TEXT0(0,setup,dbf_text);
 	QDIO_DBF_TEXT0(0,trace,dbf_text);
 	if ( (init_data->no_input_qs>QDIO_MAX_QUEUES_PER_IRQ) ||
@@ -3187,7 +3187,7 @@ qdio_establish(struct qdio_initialize *i
 		tiqdio_set_delay_target(irq_ptr,TIQDIO_DELAY_TARGET);
 	}
 
-	sprintf(dbf_text,"qest%4x",cdev->private->sch_no);
+	sprintf(dbf_text,"qest%4x",cdev->private->schid.sch_no);
 	QDIO_DBF_TEXT0(0,setup,dbf_text);
 	QDIO_DBF_TEXT0(0,trace,dbf_text);
 
diff --git a/include/asm-s390/cio.h b/include/asm-s390/cio.h
index da063cd..81287d8 100644
--- a/include/asm-s390/cio.h
+++ b/include/asm-s390/cio.h
@@ -275,6 +275,12 @@ struct ccw_dev_id {
 	u16 devno;
 };
 
+static inline int ccw_dev_id_is_equal(struct ccw_dev_id *dev_id1,
+				      struct ccw_dev_id *dev_id2)
+{
+	return !memcmp(dev_id1, dev_id2, sizeof(struct ccw_dev_id));
+}
+
 extern int diag210(struct diag210 *addr);
 
 extern void wait_cons_dev(void);
diff --git a/include/asm-s390/timer.h b/include/asm-s390/timer.h
index fcd6c25..30e5cbe 100644
--- a/include/asm-s390/timer.h
+++ b/include/asm-s390/timer.h
@@ -26,7 +26,7 @@ struct vtimer_list {
 	spinlock_t lock;
 	unsigned long magic;
 
-	void (*function)(unsigned long, struct pt_regs*);
+	void (*function)(unsigned long);
 	unsigned long data;
 };
 
