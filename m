Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268757AbUHTVQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268757AbUHTVQi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 17:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268753AbUHTVP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 17:15:58 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:30141 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268752AbUHTVPI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 17:15:08 -0400
Subject: [PATCH] HVCS fixes suggested by Jeff Garzik on July 29th
From: Ryan Arnold <rsa@us.ibm.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>
Content-Type: multipart/mixed; boundary="=-edNwGmDI+ea+zmcsz9Ft"
Organization: IBM
Message-Id: <1093036553.28320.103.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 20 Aug 2004 16:15:54 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-edNwGmDI+ea+zmcsz9Ft
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hey all,

Here are a set of HVCS (drivers/char/hvcs.c) fixes that were suggested
by Jeff Garzik on July 29th in his review of this driver as well as some
other fixes for problems I found while reviewing the driver.  These are
all relatively minor, but necessary.

Jeff, I didn't really understand your questions/suggestions about how I
was handling scheduling in khvcsd.  Could you elaborate?

This driver was built against 2.6.8.1.

changlog:
drivers/char/hvcs.c
-----------------------------------------------------------------------
-Cleaned up curly braces on single line conditional blocks.

-Replaced debug memset(...,0x3F,...) with memset(...,0x00,...).

-Removed explicit '= 0' after static int declarations since these
default to zero.

-Removed list_for_each_safe() instances and replaced with
list_for_each_entry() which cut down on amt of code.  The 'safe' version
is un-needed now that the driver is using spinlocks.

-Changed spin_lock_irqsave() to spin_lock() when locking
hvcs_structs_lock and hvcs_pi_lock since these are not touched in an int
handler.

-changed spin_lock_irqsave() to spin_lock() in interrupt handler.

-Initialized hvcs_structs_lock and hvcs_pi_lock to SPIN_LOCK_UNLOCKED at
declaration tiem rather than in hvcs_module_init().

-Added spin_lock around list_del() in destroy_hvcs_struct() to protect
the list traversal from deletion.  The original omission was an
oversight.

-Removed '= NULL' from pointer declarations since they are initialized
NULL by default.

-Removed wmb() instance from hvcs_try_write().  They probably aren't
needed with locking in place.

-Added check and cleanup for hvcs_pi_buff = kmalloc() in
hvcs_module_init(). 

-Exposed hvcs_struct.index via a sysfs attribute so that the coupling
between /dev/hvcs* and a vty-server can be systematically determined.

-Moved kobject_put() in hvcs_open() outside of the
spin_unlock_irqrestore().

-In hvcs_probe() changed kmalloc(sizeof(*hvcsd),...) to
kmalloc(sizeof(struct hvcs_struct)) because hvcsd references a NULL
pointer at the time of kmalloc.

-Incremented the HVCS_DRIVER_VERSION to 1.3.1


arch/ppc64/kernel/hvcserver.c
-----------------------------------------------------------------------
-Changed function documentation of EXPORTed functions to comply with
proper kernel-doc documentation style.

-Changed 'unsigned int' types to 'uint32_t' to comply with how unit
addresses and partition IDs are handled in other arch/ppc64 vterm code.

-Cleaned up curly braces on single line conditional blocks.


include/asm-ppc64/hvcserver.h
-----------------------------------------------------------------------
-Added kernel-doc style documentation for hvcs_partner_info struct.

-changed 'unsigned int' types to 'uint32_t' to comply with how unit
addresses and partition IDs are handled in other arch/ppc64 vterm code.

Ryan S. Arnold
IBM Linux Technology Center

--=-edNwGmDI+ea+zmcsz9Ft
Content-Disposition: attachment; filename=hvcs_fixes_draft1.patch
Content-Type: text/x-patch; name=hvcs_fixes_draft1.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Signed-off-by: Ryan S. Arnold <rsa@us.ibm.com>
--- linux-2.6.8.1/drivers/char/hvcs.c	Sat Aug 14 05:55:33 2004
+++ hvcs_patch1_lkml_linux-2.6.8.1/drivers/char/hvcs.c	Fri Aug 20 15:06:47 2004
@@ -111,8 +111,29 @@
  * that hvcs_struct instances aren't added or removed during list traversal.
  * Cleaned up comment style, added spaces after commas, and broke function
  * declaration lines to be under 80 columns.
+ *
+ * 1.3.0 -> 1.3.1 In hvcs_open memset(..,0x00,..) instead of memset(..,0x3F,00).
+ * Removed braces around single statements following conditionals.  Removed '=
+ * 0' after static int declarations since these default to zero.  Removed
+ * list_for_each_safe() and replaced with list_for_each_entry() in
+ * hvcs_get_by_index().  The 'safe' version is un-needed now that the driver is
+ * using spinlocks.  Changed spin_lock_irqsave() to spin_lock() when locking
+ * hvcs_structs_lock and hvcs_pi_lock since these are not touched in an int
+ * handler.  Initialized hvcs_structs_lock and hvcs_pi_lock to
+ * SPIN_LOCK_UNLOCKED at declaration time rather than in hvcs_module_init().
+ * Added spin_lock around list_del() in destroy_hvcs_struct() to protect the
+ * list traversals from a deletion.  Removed '= NULL' from pointer declaration
+ * statements since they are initialized NULL by default.  In hvcs_probe()
+ * changed kmalloc(sizeof(*hvcsd),...) to kmalloc(sizeof(struct
+ * hvcs_struct),...) because otherwise allocation would only be the size of a
+ * pointer.  Removed wmb() instances from hvcs_try_write().  They probably
+ * aren't needed with locking in place.  Added check and cleanup for
+ * hvcs_pi_buff = kmalloc() in hvcs_module_init().  Exposed hvcs_struct.index
+ * via a sysfs attribute so that the coupling between /dev/hvcs* and a
+ * vty-server can be automatically determined.  Moved kobject_put() in hvcs_open
+ * outside of the spin_unlock_irqrestore().
  */
-#define HVCS_DRIVER_VERSION "1.3.0"
+#define HVCS_DRIVER_VERSION "1.3.1"
 
 MODULE_AUTHOR("Ryan S. Arnold <rsa@us.ibm.com>");
 MODULE_DESCRIPTION("IBM hvcs (Hypervisor Virtual Console Server) Driver");
@@ -194,7 +215,7 @@
 	= "IBM hvcs (Hypervisor Virtual Console Server) Driver";
 
 /* Status of partner info rescan triggered via sysfs. */
-static int hvcs_rescan_status = 0;
+static int hvcs_rescan_status;
 
 static struct tty_driver *hvcs_tty_driver;
 
@@ -212,7 +233,7 @@
  * Used by the khvcsd to pick up I/O operations when the kernel_thread is
  * already awake but potentially shifted to TASK_INTERRUPTIBLE state.
  */
-static int hvcs_kicked = 0;
+static int hvcs_kicked;
 
 /* Used the the kthread construct for task operations */
 static struct task_struct *hvcs_task;
@@ -223,7 +244,7 @@
  */
 static unsigned long *hvcs_pi_buff;
 
-static spinlock_t hvcs_pi_lock;
+static spinlock_t hvcs_pi_lock = SPIN_LOCK_UNLOCKED;
 
 /* One vty-server per hvcs_struct */
 struct hvcs_struct {
@@ -263,8 +284,8 @@
 	 */
 	struct kobject kobj; /* ref count & hvcs_struct lifetime */
 	int connected; /* is the vty-server currently connected to a vty? */
-	unsigned int p_unit_address; /* partner unit address */
-	unsigned int p_partition_ID; /* partner partition ID */
+	uint32_t p_unit_address; /* partner unit address */
+	uint32_t p_partition_ID; /* partner partition ID */
 	char p_location_code[CLC_LENGTH];
 	struct list_head next; /* list management */
 	struct vio_dev *vdev;
@@ -274,7 +295,7 @@
 #define from_kobj(kobj) container_of(kobj, struct hvcs_struct, kobj)
 
 static struct list_head hvcs_structs = LIST_HEAD_INIT(hvcs_structs);
-static spinlock_t hvcs_structs_lock;
+static spinlock_t hvcs_structs_lock = SPIN_LOCK_UNLOCKED;
 
 static void hvcs_unthrottle(struct tty_struct *tty);
 static void hvcs_throttle(struct tty_struct *tty);
@@ -357,12 +378,11 @@
 		struct pt_regs *regs)
 {
 	struct hvcs_struct *hvcsd = dev_instance;
-	unsigned long flags;
 
-	spin_lock_irqsave(&hvcsd->lock, flags);
+	spin_lock(&hvcsd->lock);
 	vio_disable_interrupts(hvcsd->vdev);
 	hvcsd->todo_mask |= HVCS_SCHED_READ;
-	spin_unlock_irqrestore(&hvcsd->lock, flags);
+	spin_unlock(&hvcsd->lock);
 	hvcs_kick();
 
 	return IRQ_HANDLED;
@@ -371,7 +391,7 @@
 /* This function must be called with the hvcsd->lock held */
 static void hvcs_try_write(struct hvcs_struct *hvcsd)
 {
-	unsigned int unit_address = hvcsd->vdev->unit_address;
+	uint32_t unit_address = hvcsd->vdev->unit_address;
 	struct tty_struct *tty = hvcsd->tty;
 	int sent;
 
@@ -382,9 +402,9 @@
 				hvcsd->chars_in_buffer );
 		if (sent > 0) {
 			hvcsd->chars_in_buffer = 0;
-			wmb();
+			/* wmb(); */
 			hvcsd->todo_mask &= ~(HVCS_TRY_WRITE);
-			wmb();
+			/* wmb(); */
 
 			/*
 			 * We are still obligated to deliver the data to the
@@ -404,7 +424,7 @@
 
 static int hvcs_io(struct hvcs_struct *hvcsd)
 {
-	unsigned int unit_address;
+	uint32_t unit_address;
 	struct tty_struct *tty;
 	char buf[HVCS_BUFF_LEN] __ALIGNED__;
 	unsigned long flags;
@@ -461,11 +481,8 @@
 
 static int khvcsd(void *unused)
 {
-	struct hvcs_struct *hvcsd = NULL;
-	struct list_head *element;
-	struct list_head *safe_temp;
+	struct hvcs_struct *hvcsd;
 	int hvcs_todo_mask;
-	unsigned long structs_flags;
 
 	__set_current_state(TASK_RUNNING);
 
@@ -474,12 +491,11 @@
 		hvcs_kicked = 0;
 		wmb();
 
-		spin_lock_irqsave(&hvcs_structs_lock, structs_flags);
-		list_for_each_safe(element, safe_temp, &hvcs_structs) {
-			hvcsd = list_entry(element, struct hvcs_struct, next);
-				hvcs_todo_mask |= hvcs_io(hvcsd);
+		spin_lock(&hvcs_structs_lock);
+		list_for_each_entry(hvcsd, &hvcs_structs, next) {
+			hvcs_todo_mask |= hvcs_io(hvcsd);
 		}
-		spin_unlock_irqrestore(&hvcs_structs_lock, structs_flags);
+		spin_unlock(&hvcs_structs_lock);
 
 		/*
 		 * If any of the hvcs adapters want to try a write or quick read
@@ -513,6 +529,7 @@
 	struct vio_dev *vdev;
 	unsigned long flags;
 
+	spin_lock(&hvcs_structs_lock);
 	spin_lock_irqsave(&hvcsd->lock, flags);
 
 	/* the list_del poisons the pointers */
@@ -524,7 +541,7 @@
 				" partner vty@%X:%d connection.\n",
 				hvcsd->vdev->unit_address,
 				hvcsd->p_unit_address,
-				(unsigned int)hvcsd->p_partition_ID);
+				(uint32_t)hvcsd->p_partition_ID);
 	}
 	printk(KERN_INFO "HVCS: Destroyed hvcs_struct for vty-server@%X.\n",
 			hvcsd->vdev->unit_address);
@@ -537,6 +554,7 @@
 	memset(&hvcsd->p_location_code[0], 0x00, CLC_LENGTH);
 
 	spin_unlock_irqrestore(&hvcsd->lock, flags);
+	spin_unlock(&hvcs_structs_lock);
 
 	hvcs_remove_device_attrs(vdev);
 
@@ -572,17 +590,15 @@
 	const struct vio_device_id *id)
 {
 	struct hvcs_struct *hvcsd;
-	unsigned long structs_flags;
 
 	if (!dev || !id) {
 		printk(KERN_ERR "HVCS: probed with invalid parameter.\n");
 		return -EPERM;
 	}
 
-	hvcsd = kmalloc(sizeof(*hvcsd), GFP_KERNEL);
-	if (!hvcsd) {
+	hvcsd = kmalloc(sizeof(struct hvcs_struct), GFP_KERNEL);
+	if (!hvcsd)
 		return -ENODEV;
-	}
 
 	/* hvcsd->tty is zeroed out with the memset */
 	memset(hvcsd, 0x00, sizeof(*hvcsd));
@@ -617,11 +633,11 @@
 	 * will get -ENODEV.
 	 */
 
-	spin_lock_irqsave(&hvcs_structs_lock, structs_flags);
+	spin_lock(&hvcs_structs_lock);
 
 	list_add_tail(&(hvcsd->next), &hvcs_structs);
 
-	spin_unlock_irqrestore(&hvcs_structs_lock, structs_flags);
+	spin_unlock(&hvcs_structs_lock);
 
 	hvcs_create_device_attrs(hvcsd);
 
@@ -711,20 +727,18 @@
  */
 static int hvcs_get_pi(struct hvcs_struct *hvcsd)
 {
-	/* struct hvcs_partner_info *head_pi = NULL; */
-	struct hvcs_partner_info *pi = NULL;
-	unsigned int unit_address = hvcsd->vdev->unit_address;
+	struct hvcs_partner_info *pi;
+	uint32_t unit_address = hvcsd->vdev->unit_address;
 	struct list_head head;
-	unsigned long flags;
 	int retval;
 
-	spin_lock_irqsave(&hvcs_pi_lock, flags);
+	spin_lock(&hvcs_pi_lock);
 	if (!hvcs_pi_buff) {
-		spin_unlock_irqrestore(&hvcs_pi_lock, flags);
+		spin_unlock(&hvcs_pi_lock);
 		return -EFAULT;
 	}
 	retval = hvcs_get_partner_info(unit_address, &head, hvcs_pi_buff);
-	spin_unlock_irqrestore(&hvcs_pi_lock, flags);
+	spin_unlock(&hvcs_pi_lock);
 	if (retval) {
 		printk(KERN_ERR "HVCS: Failed to fetch partner"
 			" info for vty-server@%x.\n", unit_address);
@@ -748,11 +762,10 @@
  */
 static int hvcs_rescan_devices_list(void)
 {
-	struct hvcs_struct *hvcsd = NULL;
+	struct hvcs_struct *hvcsd;
 	unsigned long flags;
-	unsigned long structs_flags;
 
-	spin_lock_irqsave(&hvcs_structs_lock, structs_flags);
+	spin_lock(&hvcs_structs_lock);
 
 	list_for_each_entry(hvcsd, &hvcs_structs, next) {
 		spin_lock_irqsave(&hvcsd->lock, flags);
@@ -760,7 +773,7 @@
 		spin_unlock_irqrestore(&hvcsd->lock, flags);
 	}
 
-	spin_unlock_irqrestore(&hvcs_structs_lock, structs_flags);
+	spin_unlock(&hvcs_structs_lock);
 
 	return 0;
 }
@@ -848,13 +861,14 @@
 		unsigned int irq, struct vio_dev *vdev)
 {
 	unsigned long flags;
+	int rc;
 
 	/*
 	 * It is possible that the vty-server was removed between the time that
 	 * the conn was registered and now.
 	 */
-	if (!request_irq(irq, &hvcs_handle_interrupt,
-				SA_INTERRUPT, "ibmhvcs", hvcsd)) {
+	if (!(rc = request_irq(irq, &hvcs_handle_interrupt,
+				SA_INTERRUPT, "ibmhvcs", hvcsd))) {
 		/*
 		 * It is possible the vty-server was removed after the irq was
 		 * requested but before we have time to enable interrupts.
@@ -874,7 +888,7 @@
 	hvcs_partner_free(hvcsd);
 	spin_unlock_irqrestore(&hvcsd->lock, flags);
 
-	return -ENODEV;
+	return rc;
 
 }
 
@@ -887,23 +901,18 @@
  */
 struct hvcs_struct *hvcs_get_by_index(int index)
 {
-	struct hvcs_struct *hvcsd = NULL;
-	struct list_head *element;
-	struct list_head *safe_temp;
+	struct hvcs_struct *hvcsd;
 	unsigned long flags;
-	unsigned long structs_flags;
 
-	spin_lock_irqsave(&hvcs_structs_lock, structs_flags);
+	spin_lock(&hvcs_structs_lock);
 	/* We can immediately discard OOB requests */
 	if (index >= 0 && index < HVCS_MAX_SERVER_ADAPTERS) {
-		list_for_each_safe(element, safe_temp, &hvcs_structs) {
-			hvcsd = list_entry(element, struct hvcs_struct, next);
+		list_for_each_entry(hvcsd, &hvcs_structs, next) {
 			spin_lock_irqsave(&hvcsd->lock, flags);
 			if (hvcsd->index == index) {
 				kobject_get(&hvcsd->kobj);
 				spin_unlock_irqrestore(&hvcsd->lock, flags);
-				spin_unlock_irqrestore(&hvcs_structs_lock,
-						structs_flags);
+				spin_unlock(&hvcs_structs_lock);
 				return hvcsd;
 			}
 			spin_unlock_irqrestore(&hvcsd->lock, flags);
@@ -911,7 +920,7 @@
 		hvcsd = NULL;
 	}
 
-	spin_unlock_irqrestore(&hvcs_structs_lock, structs_flags);
+	spin_unlock(&hvcs_structs_lock);
 	return hvcsd;
 }
 
@@ -921,12 +930,13 @@
  */
 static int hvcs_open(struct tty_struct *tty, struct file *filp)
 {
-	struct hvcs_struct *hvcsd = NULL;
-	int retval = 0;
+	struct hvcs_struct *hvcsd;
+	int rc, retval = 0;
 	unsigned long flags;
 	unsigned int irq;
 	struct vio_dev *vdev;
 	unsigned long unit_address;
+	struct kobject *kobjp;
 
 	if (tty->driver_data)
 		goto fast_open;
@@ -959,7 +969,7 @@
 	 */
 	tty->low_latency = 1;
 
-	memset(&hvcsd->buffer[0], 0x3F, HVCS_BUFF_LEN);
+	memset(&hvcsd->buffer[0], 0x00, HVCS_BUFF_LEN);
 
 	/*
 	 * Save these in the spinlock for the enable operations that need them
@@ -976,10 +986,10 @@
 	 * This must be done outside of the spinlock because it requests irqs
 	 * and will grab the spinlcok and free the connection if it fails.
 	 */
-	if ((hvcs_enable_device(hvcsd, unit_address, irq, vdev))) {
+	if (((rc = hvcs_enable_device(hvcsd, unit_address, irq, vdev)))) {
 		kobject_put(&hvcsd->kobj);
 		printk(KERN_WARNING "HVCS: enable device failed.\n");
-		return -ENODEV;
+		return rc;
 	}
 
 	goto open_success;
@@ -1008,6 +1018,7 @@
 	return 0;
 
 error_release:
+	kobjp = &hvcsd->kobj;
 	spin_unlock_irqrestore(&hvcsd->lock, flags);
 	kobject_put(&hvcsd->kobj);
 
@@ -1346,10 +1357,12 @@
 		return rc;
 	}
 
-	hvcs_structs_lock = SPIN_LOCK_UNLOCKED;
-
-	hvcs_pi_lock = SPIN_LOCK_UNLOCKED;
 	hvcs_pi_buff = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!hvcs_pi_buff) {
+		tty_unregister_driver(hvcs_tty_driver);
+		put_tty_driver(hvcs_tty_driver);
+		return -ENOMEM;
+	}
 
 	hvcs_task = kthread_run(khvcsd, NULL, "khvcsd");
 	if (IS_ERR(hvcs_task)) {
@@ -1374,8 +1387,6 @@
 
 static void __exit hvcs_module_exit(void)
 {
-	unsigned long flags;
-
 	/*
 	 * This driver receives hvcs_remove callbacks for each device upon
 	 * module removal.
@@ -1387,10 +1398,10 @@
 	 */
 	kthread_stop(hvcs_task);
 
-	spin_lock_irqsave(&hvcs_pi_lock, flags);
+	spin_lock(&hvcs_pi_lock);
 	kfree(hvcs_pi_buff);
 	hvcs_pi_buff = NULL;
-	spin_unlock_irqrestore(&hvcs_pi_lock, flags);
+	spin_unlock(&hvcs_pi_lock);
 
 	hvcs_remove_driver_attrs();
 
@@ -1499,7 +1510,7 @@
 			" partner vty@%X:%d connection.\n",
 			hvcsd->vdev->unit_address,
 			hvcsd->p_unit_address,
-			(unsigned int)hvcsd->p_partition_ID);
+			(uint32_t)hvcsd->p_partition_ID);
 
 	spin_unlock_irqrestore(&hvcsd->lock, flags);
 	return count;
@@ -1520,11 +1531,27 @@
 static DEVICE_ATTR(vterm_state, S_IRUGO | S_IWUSR,
 		hvcs_vterm_state_show, hvcs_vterm_state_store);
 
+static ssize_t hvcs_index_show(struct device *dev, char *buf)
+{
+	struct vio_dev *viod = to_vio_dev(dev);
+	struct hvcs_struct *hvcsd = from_vio_dev(viod);
+	unsigned long flags;
+	int retval;
+
+	spin_lock_irqsave(&hvcsd->lock, flags);
+	retval = sprintf(buf, "%d\n", hvcsd->index);
+	spin_unlock_irqrestore(&hvcsd->lock, flags);
+	return retval;
+}
+
+static DEVICE_ATTR(index, S_IRUGO, hvcs_index_show, NULL);
+
 static struct attribute *hvcs_attrs[] = {
 	&dev_attr_partner_vtys.attr,
 	&dev_attr_partner_clcs.attr,
 	&dev_attr_current_vty.attr,
 	&dev_attr_vterm_state.attr,
+	&dev_attr_index.attr,
 	NULL,
 };
 
--- linux-2.6.8.1/arch/ppc64/kernel/hvcserver.c	Sat Aug 14 05:55:33 2004
+++ hvcs_patch1_lkml_linux-2.6.8.1/arch/ppc64/kernel/hvcserver.c	Fri Aug 20 14:55:56 2004
@@ -61,14 +61,21 @@
 	}
 }
 
+/**
+ * hvcs_free_partner_info - free pi allocated by hvcs_get_partner_info
+ * @head: list_head pointer for an allocated list of partner info structs to
+ *	free.
+ *
+ * This function is used to free the partner info list that was returned by
+ * calling hvcs_get_partner_info().
+ */
 int hvcs_free_partner_info(struct list_head *head)
 {
 	struct hvcs_partner_info *pi;
 	struct list_head *element;
 
-	if (!head) {
+	if (!head)
 		return -EINVAL;
-	}
 
 	while (!list_empty(head)) {
 		element = head->next;
@@ -82,7 +89,7 @@
 EXPORT_SYMBOL(hvcs_free_partner_info);
 
 /* Helper function for hvcs_get_partner_info */
-int hvcs_next_partner(unsigned int unit_address,
+int hvcs_next_partner(uint32_t unit_address,
 		unsigned long last_p_partition_ID,
 		unsigned long last_p_unit_address, unsigned long *pi_buff)
 
@@ -94,25 +101,37 @@
 	return hvcs_convert(retval);
 }
 
-/*
- * The unit_address parameter is the unit address of the vty-server vdevice
- * in whose partner information the caller is interested.  This function
- * uses a pointer to a list_head instance in which to store the partner info.
+/**
+ * hvcs_get_partner_info - Get all of the partner info for a vty-server adapter
+ * @unit_address: The unit_address of the vty-server adapter for which this
+ *	function is fetching partner info.
+ * @head: An initialized list_head pointer to an empty list to use to return the
+ *	list of partner info fetched from the hypervisor to the caller.
+ * @pi_buff: A page sized buffer pre-allocated prior to calling this function
+ *	that is to be used to be used by firmware as an iterator to keep track
+ *	of the partner info retrieval.
+ *
  * This function returns non-zero on success, or if there is no partner info.
  *
+ * The pi_buff is pre-allocated prior to calling this function because this
+ * function may be called with a spin_lock held and kmalloc of a page is not
+ * recommended as GFP_ATOMIC.
+ *
+ * The first long of this buffer is used to store a partner unit address.  The
+ * second long is used to store a partner partition ID and starting at
+ * pi_buff[2] is the 79 character Converged Location Code (diff size than the
+ * unsigned longs, hence the casting mumbo jumbo you see later).
+ *
  * Invocation of this function should always be followed by an invocation of
  * hvcs_free_partner_info() using a pointer to the SAME list head instance
- * that was used to store the partner_info list.
+ * that was passed as a parameter to this function.
  */
-int hvcs_get_partner_info(unsigned int unit_address, struct list_head *head,
+int hvcs_get_partner_info(uint32_t unit_address, struct list_head *head,
 		unsigned long *pi_buff)
 {
 	/*
-	 * This is a page sized buffer to be passed to hvcall per invocation.
-	 * NOTE: the first long returned is unit_address.  The second long
-	 * returned is the partition ID and starting with pi_buff[2] are
-	 * HVCS_CLC_LENGTH characters, which are diff size than the unsigned
-	 * long, hence the casting mumbojumbo you see later.
+	 * Dealt with as longs because of the hcall interface even though the
+	 * values are uint32_t.
 	 */
 	unsigned long	last_p_partition_ID;
 	unsigned long	last_p_unit_address;
@@ -122,15 +141,12 @@
 
 	memset(pi_buff, 0x00, PAGE_SIZE);
 	/* invalid parameters */
-	if (!head)
+	if (!head || !pi_buff)
 		return -EINVAL;
 
 	last_p_partition_ID = last_p_unit_address = ~0UL;
 	INIT_LIST_HEAD(head);
 
-	if (!pi_buff)
-		return -ENOMEM;
-
 	do {
 		retval = hvcs_next_partner(unit_address, last_p_partition_ID,
 				last_p_unit_address, pi_buff);
@@ -183,21 +199,29 @@
 }
 EXPORT_SYMBOL(hvcs_get_partner_info);
 
-/*
+/**
+ * hvcs_register_connection - establish a connection between this vty-server and
+ *	a vty.
+ * @unit_address: The unit address of the vty-server adapter that is to be
+ *	establish a connection.
+ * @p_partition_ID: The partition ID of the vty adapter that is to be connected.
+ * @p_unit_address: The unit address of the vty adapter to which the vty-server
+ *	is to be connected.
+ *
  * If this function is called once and -EINVAL is returned it may
  * indicate that the partner info needs to be refreshed for the
  * target unit address at which point the caller must invoke
  * hvcs_get_partner_info() and then call this function again.  If,
  * for a second time, -EINVAL is returned then it indicates that
  * there is probably already a partner connection registered to a
- * different vty-server@ vdevice.  It is also possible that a second
+ * different vty-server adapter.  It is also possible that a second
  * -EINVAL may indicate that one of the parms is not valid, for
- * instance if the link was removed between the vty-server@ vdevice
- * and the vty@ vdevice that you are trying to open.  Don't shoot the
+ * instance if the link was removed between the vty-server adapter
+ * and the vty adapter that you are trying to open.  Don't shoot the
  * messenger.  Firmware implemented it this way.
  */
-int hvcs_register_connection( unsigned int unit_address,
-		unsigned int p_partition_ID, unsigned int p_unit_address)
+int hvcs_register_connection( uint32_t unit_address,
+		uint32_t p_partition_ID, uint32_t p_unit_address)
 {
 	long retval;
 	retval = plpar_hcall_norets(H_REGISTER_VTERM, unit_address,
@@ -206,11 +230,17 @@
 }
 EXPORT_SYMBOL(hvcs_register_connection);
 
-/*
- * If -EBUSY is returned continue to call this function
- * until 0 is returned.
+/**
+ * hvcs_free_connection - free the connection between a vty-server and vty
+ * @unit_address: The unit address of the vty-server that is to have its
+ *	connection severed.
+ *
+ * This function is used to free the partner connection between a vty-server
+ * adapter and a vty adapter.
+ *
+ * If -EBUSY is returned continue to call this function until 0 is returned.
  */
-int hvcs_free_connection(unsigned int unit_address)
+int hvcs_free_connection(uint32_t unit_address)
 {
 	long retval;
 	retval = plpar_hcall_norets(H_FREE_VTERM, unit_address);
--- linux-2.6.8.1/include/asm-ppc64/hvcserver.h	Sat Aug 14 05:55:10 2004
+++ hvcs_patch1_lkml_linux-2.6.8.1/include/asm-ppc64/hvcserver.h	Fri Aug 20 14:55:36 2004
@@ -27,18 +27,31 @@
 /* Converged Location Code length */
 #define HVCS_CLC_LENGTH	79
 
+/**
+ * hvcs_partner_info - an element in a list of partner info
+ * @node: list_head denoting this partner_info struct's position in the list of
+ *	partner info.
+ * @unit_address: The partner unit address of this entry.
+ * @partition_ID: The partner partition ID of this entry.
+ * @location_code: The converged location code of this entry + 1 char for the
+ *	null-term.
+ *
+ * This structure outlines the format that partner info is presented to a caller
+ * of the hvcs partner info fetching functions.  These are strung together into
+ * a list using linux kernel lists.
+ */
 struct hvcs_partner_info {
 	struct list_head node;
-	unsigned int unit_address;
-	unsigned int partition_ID;
+	uint32_t unit_address;
+	uint32_t partition_ID;
 	char location_code[HVCS_CLC_LENGTH + 1]; /* CLC + 1 null-term char */
 };
 
 extern int hvcs_free_partner_info(struct list_head *head);
-extern int hvcs_get_partner_info(unsigned int unit_address,
+extern int hvcs_get_partner_info(uint32_t unit_address,
 		struct list_head *head, unsigned long *pi_buff);
-extern int hvcs_register_connection(unsigned int unit_address,
-		unsigned int p_partition_ID, unsigned int p_unit_address);
-extern int hvcs_free_connection(unsigned int unit_address);
+extern int hvcs_register_connection(uint32_t unit_address,
+		uint32_t p_partition_ID, uint32_t p_unit_address);
+extern int hvcs_free_connection(uint32_t unit_address);
 
 #endif /* _PPC64_HVCSERVER_H */

--=-edNwGmDI+ea+zmcsz9Ft--

