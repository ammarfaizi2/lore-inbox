Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270147AbUJUHUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270147AbUJUHUO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 03:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270266AbUJUHDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 03:03:31 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:14728 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S270123AbUJUG7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 02:59:51 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] Sonypi: use wait_event_interruptible and other assorted changes
Date: Thu, 21 Oct 2004 01:58:54 -0500
User-Agent: KMail/1.6.2
Cc: stelian@popies.net
References: <200410210154.58301.dtor_core@ameritech.net> <200410210157.22833.dtor_core@ameritech.net> <200410210158.12014.dtor_core@ameritech.net>
In-Reply-To: <200410210158.12014.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410210158.57064.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1979, 2004-10-21 01:47:57-05:00, dtor_core@ameritech.net
  Sonypi: miscellaneous fixes
          - convert sonypi_misc_read to use wait_event_interruptible;
          - fix race sonypi_misc_read when sonypi_emptyq reports queue
            is not empty and other thread steals the byte before
            sonypi_pullq is called;
          - spin lock should be initialized at registration time, not
            at open time because interrupt handler takes it and it may
            come before misc device is opened;
          - ensure that all parts of device is properly registered
            before enabling it (used to register input device after
            enabling interrupts from the hardware, could crash).
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 sonypi.c |  145 +++++++++++++++++++++++++++++----------------------------------
 sonypi.h |    4 -
 2 files changed, 70 insertions(+), 79 deletions(-)


===================================================================



diff -Nru a/drivers/char/sonypi.c b/drivers/char/sonypi.c
--- a/drivers/char/sonypi.c	2004-10-21 01:54:42 -05:00
+++ b/drivers/char/sonypi.c	2004-10-21 01:54:42 -05:00
@@ -94,40 +94,48 @@
 /* Inits the queue */
 static inline void sonypi_initq(void)
 {
-        sonypi_device.queue.head = sonypi_device.queue.tail = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&sonypi_device.queue.s_lock, flags);
+	sonypi_device.queue.head = sonypi_device.queue.tail = 0;
 	sonypi_device.queue.len = 0;
-	sonypi_device.queue.s_lock = SPIN_LOCK_UNLOCKED;
-	init_waitqueue_head(&sonypi_device.queue.proc_list);
+	spin_unlock_irqrestore(&sonypi_device.queue.s_lock, flags);
+}
+
+/* Tests if the queue is empty */
+static inline int sonypi_emptyq(void)
+{
+        return sonypi_device.queue.len == 0;
 }
 
 /* Pulls an event from the queue */
-static inline unsigned char sonypi_pullq(void)
+static int sonypi_pullq(unsigned char *c)
 {
-        unsigned char result;
+	int have_data = 0;
 	unsigned long flags;
 
 	spin_lock_irqsave(&sonypi_device.queue.s_lock, flags);
-	if (!sonypi_device.queue.len) {
-		spin_unlock_irqrestore(&sonypi_device.queue.s_lock, flags);
-		return 0;
+	if (!sonypi_emptyq()) {
+		*c = sonypi_device.queue.buf[sonypi_device.queue.head];
+		sonypi_device.queue.head++;
+		sonypi_device.queue.head &= (SONYPI_BUF_SIZE - 1);
+		sonypi_device.queue.len--;
+		have_data = 1;
 	}
-	result = sonypi_device.queue.buf[sonypi_device.queue.head];
-        sonypi_device.queue.head++;
-	sonypi_device.queue.head &= (SONYPI_BUF_SIZE - 1);
-	sonypi_device.queue.len--;
 	spin_unlock_irqrestore(&sonypi_device.queue.s_lock, flags);
-        return result;
+
+	return have_data;
 }
 
 /* Pushes an event into the queue */
-static inline void sonypi_pushq(unsigned char event)
+static void sonypi_pushq(unsigned char event)
 {
 	unsigned long flags;
 
 	spin_lock_irqsave(&sonypi_device.queue.s_lock, flags);
 	if (sonypi_device.queue.len == SONYPI_BUF_SIZE) {
 		/* remove the first element */
-        	sonypi_device.queue.head++;
+		sonypi_device.queue.head++;
 		sonypi_device.queue.head &= (SONYPI_BUF_SIZE - 1);
 		sonypi_device.queue.len--;
 	}
@@ -135,22 +143,10 @@
 	sonypi_device.queue.tail++;
 	sonypi_device.queue.tail &= (SONYPI_BUF_SIZE - 1);
 	sonypi_device.queue.len++;
-
-	kill_fasync(&sonypi_device.queue.fasync, SIGIO, POLL_IN);
-	wake_up_interruptible(&sonypi_device.queue.proc_list);
 	spin_unlock_irqrestore(&sonypi_device.queue.s_lock, flags);
-}
-
-/* Tests if the queue is empty */
-static inline int sonypi_emptyq(void)
-{
-        int result;
-	unsigned long flags;
 
-	spin_lock_irqsave(&sonypi_device.queue.s_lock, flags);
-        result = (sonypi_device.queue.len == 0);
-	spin_unlock_irqrestore(&sonypi_device.queue.s_lock, flags);
-        return result;
+	kill_fasync(&sonypi_device.fasync, SIGIO, POLL_IN);
+	wake_up_interruptible(&sonypi_device.proc_list);
 }
 
 static int sonypi_ec_write(u8 addr, u8 value)
@@ -520,7 +516,7 @@
 {
 	int retval;
 
-	retval = fasync_helper(fd, filp, on, &sonypi_device.queue.fasync);
+	retval = fasync_helper(fd, filp, on, &sonypi_device.fasync);
 	if (retval < 0)
 		return retval;
 	return 0;
@@ -549,40 +545,31 @@
 static ssize_t sonypi_misc_read(struct file * file, char __user * buf,
 			size_t count, loff_t *pos)
 {
-	DECLARE_WAITQUEUE(wait, current);
-	ssize_t i = count;
+	ssize_t ret;
 	unsigned char c;
 
-	if (sonypi_emptyq()) {
-		if (file->f_flags & O_NONBLOCK)
-			return -EAGAIN;
-		add_wait_queue(&sonypi_device.queue.proc_list, &wait);
-repeat:
-		set_current_state(TASK_INTERRUPTIBLE);
-		if (sonypi_emptyq() && !signal_pending(current)) {
-			schedule();
-			goto repeat;
-		}
-		current->state = TASK_RUNNING;
-		remove_wait_queue(&sonypi_device.queue.proc_list, &wait);
-	}
-	while (i > 0 && !sonypi_emptyq()) {
-		c = sonypi_pullq();
-		put_user(c, buf++);
-		i--;
+	if (sonypi_emptyq() && (file->f_flags & O_NONBLOCK))
+		return -EAGAIN;
+
+	ret = wait_event_interruptible(sonypi_device.proc_list, !sonypi_emptyq());
+	if (ret)
+		return ret;
+
+	while (ret < count && !sonypi_pullq(&c)) {
+		if (put_user(c, buf++))
+			return -EFAULT;
+		ret++;
         }
-	if (count - i) {
+
+	if (ret > 0)
 		file->f_dentry->d_inode->i_atime = CURRENT_TIME;
-		return count-i;
-	}
-	if (signal_pending(current))
-		return -ERESTARTSYS;
-	return 0;
+
+	return ret;
 }
 
 static unsigned int sonypi_misc_poll(struct file *file, poll_table * wait)
 {
-	poll_wait(file, &sonypi_device.queue.proc_list, wait);
+	poll_wait(file, &sonypi_device.proc_list, wait);
 	if (!sonypi_emptyq())
 		return POLLIN | POLLRDNORM;
 	return 0;
@@ -685,7 +672,9 @@
 };
 
 struct miscdevice sonypi_misc_device = {
-	-1, "sonypi", &sonypi_misc_fops
+	.minor	= -1,
+	.name	= "sonypi",
+	.fops	= &sonypi_misc_fops,
 };
 
 static void sonypi_enable(unsigned int camera_on)
@@ -767,12 +756,14 @@
 	struct sonypi_ioport_list *ioport_list;
 	struct sonypi_irq_list *irq_list;
 
-	sonypi_device.dev = pcidev;
-	sonypi_device.model = pcidev ?
-		SONYPI_DEVICE_MODEL_TYPE1 : SONYPI_DEVICE_MODEL_TYPE2;
+	spin_lock_init(&sonypi_device.queue.s_lock);
+	init_waitqueue_head(&sonypi_device.proc_list);
 	sonypi_initq();
 	init_MUTEX(&sonypi_device.lock);
 	sonypi_device.bluetooth_power = 0;
+	sonypi_device.dev = pcidev;
+	sonypi_device.model = pcidev ?
+		SONYPI_DEVICE_MODEL_TYPE1 : SONYPI_DEVICE_MODEL_TYPE2;
 
 	if (pcidev && pci_enable_device(pcidev)) {
 		printk(KERN_ERR "sonypi: pci_enable_device failed\n");
@@ -839,6 +830,23 @@
 		goto out4;
 	}
 
+#ifdef SONYPI_USE_INPUT
+	if (useinput) {
+		/* Initialize the Input Drivers: */
+		sonypi_device.jog_dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
+		sonypi_device.jog_dev.keybit[LONG(BTN_MOUSE)] = BIT(BTN_MIDDLE);
+		sonypi_device.jog_dev.relbit[0] = BIT(REL_WHEEL);
+		sonypi_device.jog_dev.name = (char *) kmalloc(
+			sizeof(SONYPI_INPUTNAME), GFP_KERNEL);
+		sprintf(sonypi_device.jog_dev.name, SONYPI_INPUTNAME);
+		sonypi_device.jog_dev.id.bustype = BUS_ISA;
+		sonypi_device.jog_dev.id.vendor = PCI_VENDOR_ID_SONY;
+
+		input_register_device(&sonypi_device.jog_dev);
+		printk(KERN_INFO "%s installed.\n", sonypi_device.jog_dev.name);
+	}
+#endif /* SONYPI_USE_INPUT */
+
 	sonypi_enable(0);
 
 	printk(KERN_INFO "sonypi: Sony Programmable I/O Controller Driver v%d.%d.\n",
@@ -863,23 +871,6 @@
 	if (minor == -1)
 		printk(KERN_INFO "sonypi: device allocated minor is %d\n",
 		       sonypi_misc_device.minor);
-
-#ifdef SONYPI_USE_INPUT
-	if (useinput) {
-		/* Initialize the Input Drivers: */
-		sonypi_device.jog_dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
-		sonypi_device.jog_dev.keybit[LONG(BTN_MOUSE)] = BIT(BTN_MIDDLE);
-		sonypi_device.jog_dev.relbit[0] = BIT(REL_WHEEL);
-		sonypi_device.jog_dev.name = (char *) kmalloc(
-			sizeof(SONYPI_INPUTNAME), GFP_KERNEL);
-		sprintf(sonypi_device.jog_dev.name, SONYPI_INPUTNAME);
-		sonypi_device.jog_dev.id.bustype = BUS_ISA;
-		sonypi_device.jog_dev.id.vendor = PCI_VENDOR_ID_SONY;
-
-		input_register_device(&sonypi_device.jog_dev);
-		printk(KERN_INFO "%s installed.\n", sonypi_device.jog_dev.name);
-	}
-#endif /* SONYPI_USE_INPUT */
 
 	return 0;
 
diff -Nru a/drivers/char/sonypi.h b/drivers/char/sonypi.h
--- a/drivers/char/sonypi.h	2004-10-21 01:54:42 -05:00
+++ b/drivers/char/sonypi.h	2004-10-21 01:54:42 -05:00
@@ -344,8 +344,6 @@
 	unsigned long tail;
 	unsigned long len;
 	spinlock_t s_lock;
-	wait_queue_head_t proc_list;
-	struct fasync_struct *fasync;
 	unsigned char buf[SONYPI_BUF_SIZE];
 };
 
@@ -373,6 +371,8 @@
 	int camera_power;
 	int bluetooth_power;
 	struct semaphore lock;
+	wait_queue_head_t proc_list;
+	struct fasync_struct *fasync;
 	struct sonypi_queue queue;
 	int open_count;
 	int model;
