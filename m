Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbWCXQEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbWCXQEf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 11:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbWCXQEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 11:04:34 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:50615
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S932318AbWCXQEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 11:04:32 -0500
Subject: [PATCH] synclink_gt add gpio feature
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 24 Mar 2006 10:04:11 -0600
Message-Id: <1143216251.8513.3.camel@amdx2.microgate.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver support for general purpose I/O feature
of the Synclink GT adapters.

Signed-off-by: Paul Fulghum <paulkf@micrgate.com>

--- linux-2.6.16/drivers/char/synclink_gt.c	2006-03-19 23:53:29.000000000 -0600
+++ b/drivers/char/synclink_gt.c	2006-03-24 09:43:42.000000000 -0600
@@ -1,5 +1,5 @@
 /*
- * $Id: synclink_gt.c,v 4.22 2006/01/09 20:16:06 paulkf Exp $
+ * $Id: synclink_gt.c,v 4.25 2006/02/06 21:20:33 paulkf Exp $
  *
  * Device driver for Microgate SyncLink GT serial adapters.
  *
@@ -92,7 +92,7 @@
  * module identification
  */
 static char *driver_name     = "SyncLink GT";
-static char *driver_version  = "$Revision: 4.22 $";
+static char *driver_version  = "$Revision: 4.25 $";
 static char *tty_driver_name = "synclink_gt";
 static char *tty_dev_prefix  = "ttySLG";
 MODULE_LICENSE("GPL");
@@ -188,6 +188,20 @@ static void hdlcdev_exit(struct slgt_inf
 #define SLGT_REG_SIZE  256
 
 /*
+ * conditional wait facility
+ */
+struct cond_wait {
+	struct cond_wait *next;
+	wait_queue_head_t q;
+	wait_queue_t wait;
+	unsigned int data;
+};
+static void init_cond_wait(struct cond_wait *w, unsigned int data);
+static void add_cond_wait(struct cond_wait **head, struct cond_wait *w);
+static void remove_cond_wait(struct cond_wait **head, struct cond_wait *w);
+static void flush_cond_wait(struct cond_wait **head);
+
+/*
  * DMA buffer descriptor and access macros
  */
 struct slgt_desc
@@ -269,6 +283,9 @@ struct slgt_info {
 	struct timer_list	tx_timer;
 	struct timer_list	rx_timer;
 
+	unsigned int            gpio_present;
+	struct cond_wait        *gpio_wait_q;
+
 	spinlock_t lock;	/* spinlock for synchronizing with ISR */
 
 	struct work_struct task;
@@ -379,6 +396,11 @@ static MGSL_PARAMS default_params = {
 #define MASK_OVERRUN BIT4
 
 #define GSR   0x00 /* global status */
+#define JCR   0x04 /* JTAG control */
+#define IODR  0x08 /* GPIO direction */
+#define IOER  0x0c /* GPIO interrupt enable */
+#define IOVR  0x10 /* GPIO value */
+#define IOSR  0x14 /* GPIO interrupt status */
 #define TDR   0x80 /* tx data */
 #define RDR   0x80 /* rx data */
 #define TCR   0x82 /* tx control */
@@ -503,6 +525,9 @@ static int  tiocmset(struct tty_struct *
 static void set_break(struct tty_struct *tty, int break_state);
 static int  get_interface(struct slgt_info *info, int __user *if_mode);
 static int  set_interface(struct slgt_info *info, int if_mode);
+static int  set_gpio(struct slgt_info *info, struct gpio_desc __user *gpio);
+static int  get_gpio(struct slgt_info *info, struct gpio_desc __user *gpio);
+static int  wait_gpio(struct slgt_info *info, struct gpio_desc __user *gpio);
 
 /*
  * driver functions
@@ -1112,6 +1137,12 @@ static int ioctl(struct tty_struct *tty,
 		return get_interface(info, argp);
 	case MGSL_IOCSIF:
 		return set_interface(info,(int)arg);
+	case MGSL_IOCSGPIO:
+		return set_gpio(info, argp);
+	case MGSL_IOCGGPIO:
+		return get_gpio(info, argp);
+	case MGSL_IOCWAITGPIO:
+		return wait_gpio(info, argp);
 	case TIOCGICOUNT:
 		spin_lock_irqsave(&info->lock,flags);
 		cnow = info->icount;
@@ -2158,6 +2189,24 @@ static void isr_txeom(struct slgt_info *
 	}
 }
 
+static void isr_gpio(struct slgt_info *info, unsigned int changed, unsigned int state)
+{
+	struct cond_wait *w, *prev;
+
+	/* wake processes waiting for specific transitions */
+	for (w = info->gpio_wait_q, prev = NULL ; w != NULL ; w = w->next) {
+		if (w->data & changed) {
+			w->data = state;
+			wake_up_interruptible(&w->q);
+			if (prev != NULL)
+				prev->next = w->next;
+			else
+				info->gpio_wait_q = w->next;
+		} else
+			prev = w;
+	}
+}
+
 /* interrupt service routine
  *
  * 	irq	interrupt number
@@ -2193,6 +2242,22 @@ static irqreturn_t slgt_interrupt(int ir
 		}
 	}
 
+	if (info->gpio_present) {
+		unsigned int state;
+		unsigned int changed;
+		while ((changed = rd_reg32(info, IOSR)) != 0) {
+			DBGISR(("%s iosr=%08x\n", info->device_name, changed));
+			/* read latched state of GPIO signals */
+			state = rd_reg32(info, IOVR);
+			/* clear pending GPIO interrupt bits */
+			wr_reg32(info, IOSR, changed);
+			for (i=0 ; i < info->port_count ; i++) {
+				if (info->port_array[i] != NULL)
+					isr_gpio(info->port_array[i], changed, state);
+			}
+		}
+	}
+
 	for(i=0; i < info->port_count ; i++) {
 		struct slgt_info *port = info->port_array[i];
 
@@ -2276,6 +2341,8 @@ static void shutdown(struct slgt_info *i
 		set_signals(info);
 	}
 
+	flush_cond_wait(&info->gpio_wait_q);
+
 	spin_unlock_irqrestore(&info->lock,flags);
 
 	if (info->tty)
@@ -2650,6 +2717,175 @@ static int set_interface(struct slgt_inf
 	return 0;
 }
 
+/*
+ * set general purpose IO pin state and direction
+ *
+ * user_gpio fields:
+ * state   each bit indicates a pin state
+ * smask   set bit indicates pin state to set
+ * dir     each bit indicates a pin direction (0=input, 1=output)
+ * dmask   set bit indicates pin direction to set
+ */
+static int set_gpio(struct slgt_info *info, struct gpio_desc __user *user_gpio)
+{
+ 	unsigned long flags;
+	struct gpio_desc gpio;
+	__u32 data;
+
+	if (!info->gpio_present)
+		return -EINVAL;
+	if (copy_from_user(&gpio, user_gpio, sizeof(gpio)))
+		return -EFAULT;
+	DBGINFO(("%s set_gpio state=%08x smask=%08x dir=%08x dmask=%08x\n",
+		 info->device_name, gpio.state, gpio.smask,
+		 gpio.dir, gpio.dmask));
+
+	spin_lock_irqsave(&info->lock,flags);
+	if (gpio.dmask) {
+		data = rd_reg32(info, IODR);
+		data |= gpio.dmask & gpio.dir;
+		data &= ~(gpio.dmask & ~gpio.dir);
+		wr_reg32(info, IODR, data);
+	}
+	if (gpio.smask) {
+		data = rd_reg32(info, IOVR);
+		data |= gpio.smask & gpio.state;
+		data &= ~(gpio.smask & ~gpio.state);
+		wr_reg32(info, IOVR, data);
+	}
+	spin_unlock_irqrestore(&info->lock,flags);
+
+	return 0;
+}
+
+/*
+ * get general purpose IO pin state and direction
+ */
+static int get_gpio(struct slgt_info *info, struct gpio_desc __user *user_gpio)
+{
+	struct gpio_desc gpio;
+	if (!info->gpio_present)
+		return -EINVAL;
+	gpio.state = rd_reg32(info, IOVR);
+	gpio.smask = 0xffffffff;
+	gpio.dir   = rd_reg32(info, IODR);
+	gpio.dmask = 0xffffffff;
+	if (copy_to_user(user_gpio, &gpio, sizeof(gpio)))
+		return -EFAULT;
+	DBGINFO(("%s get_gpio state=%08x dir=%08x\n",
+		 info->device_name, gpio.state, gpio.dir));
+	return 0;
+}
+
+/*
+ * conditional wait facility
+ */
+static void init_cond_wait(struct cond_wait *w, unsigned int data)
+{
+	init_waitqueue_head(&w->q);
+	init_waitqueue_entry(&w->wait, current);
+	w->data = data;
+}
+
+static void add_cond_wait(struct cond_wait **head, struct cond_wait *w)
+{
+	set_current_state(TASK_INTERRUPTIBLE);
+	add_wait_queue(&w->q, &w->wait);
+	w->next = *head;
+	*head = w;
+}
+
+static void remove_cond_wait(struct cond_wait **head, struct cond_wait *cw)
+{
+	struct cond_wait *w, *prev;
+	remove_wait_queue(&cw->q, &cw->wait);
+	set_current_state(TASK_RUNNING);
+	for (w = *head, prev = NULL ; w != NULL ; prev = w, w = w->next) {
+		if (w == cw) {
+			if (prev != NULL)
+				prev->next = w->next;
+			else
+				*head = w->next;
+			break;
+		}
+	}
+}
+
+static void flush_cond_wait(struct cond_wait **head)
+{
+	while (*head != NULL) {
+		wake_up_interruptible(&(*head)->q);
+		*head = (*head)->next;
+	}
+}
+
+/*
+ * wait for general purpose I/O pin(s) to enter specified state
+ *
+ * user_gpio fields:
+ * state - bit indicates target pin state
+ * smask - set bit indicates watched pin
+ *
+ * The wait ends when at least one watched pin enters the specified
+ * state. When 0 (no error) is returned, user_gpio->state is set to the
+ * state of all GPIO pins when the wait ends.
+ *
+ * Note: Each pin may be a dedicated input, dedicated output, or
+ * configurable input/output. The number and configuration of pins
+ * varies with the specific adapter model. Only input pins (dedicated
+ * or configured) can be monitored with this function.
+ */
+static int wait_gpio(struct slgt_info *info, struct gpio_desc __user *user_gpio)
+{
+ 	unsigned long flags;
+	int rc = 0;
+	struct gpio_desc gpio;
+	struct cond_wait wait;
+	u32 state;
+
+	if (!info->gpio_present)
+		return -EINVAL;
+	if (copy_from_user(&gpio, user_gpio, sizeof(gpio)))
+		return -EFAULT;
+	DBGINFO(("%s wait_gpio() state=%08x smask=%08x\n",
+		 info->device_name, gpio.state, gpio.smask));
+	/* ignore output pins identified by set IODR bit */
+	if ((gpio.smask &= ~rd_reg32(info, IODR)) == 0)
+		return -EINVAL;
+	init_cond_wait(&wait, gpio.smask);
+
+	spin_lock_irqsave(&info->lock, flags);
+	/* enable interrupts for watched pins */
+	wr_reg32(info, IOER, rd_reg32(info, IOER) | gpio.smask);
+	/* get current pin states */
+	state = rd_reg32(info, IOVR);
+
+	if (gpio.smask & ~(state ^ gpio.state)) {
+		/* already in target state */
+		gpio.state = state;
+	} else {
+		/* wait for target state */
+		add_cond_wait(&info->gpio_wait_q, &wait);
+		spin_unlock_irqrestore(&info->lock, flags);
+		schedule();
+		if (signal_pending(current))
+			rc = -ERESTARTSYS;
+		else
+			gpio.state = wait.data;
+		spin_lock_irqsave(&info->lock, flags);
+		remove_cond_wait(&info->gpio_wait_q, &wait);
+	}
+
+	/* disable all GPIO interrupts if no waiting processes */
+	if (info->gpio_wait_q == NULL)
+		wr_reg32(info, IOER, 0);
+	spin_unlock_irqrestore(&info->lock,flags);
+
+	if ((rc == 0) && copy_to_user(user_gpio, &gpio, sizeof(gpio)))
+		rc = -EFAULT;
+	return rc;
+}
+
 static int modem_input_wait(struct slgt_info *info,int arg)
 {
  	unsigned long flags;
@@ -3166,8 +3402,10 @@ static void device_init(int adapter_num,
 		} else {
 			port_array[0]->irq_requested = 1;
 			adapter_test(port_array[0]);
-			for (i=1 ; i < port_count ; i++)
+			for (i=1 ; i < port_count ; i++) {
 				port_array[i]->init_error = port_array[0]->init_error;
+				port_array[i]->gpio_present = port_array[0]->gpio_present;
+			}
 		}
 	}
 }
@@ -4301,7 +4539,7 @@ static int register_test(struct slgt_inf
 			break;
 		}
 	}
-
+	info->gpio_present = (rd_reg32(info, JCR) & BIT5) ? 1 : 0;
 	info->init_error = rc ? 0 : DiagStatus_AddressFailure;
 	return rc;
 }
--- linux-2.6.16/include/linux/synclink.h	2006-03-19 23:53:29.000000000 -0600
+++ b/include/linux/synclink.h	2006-03-24 09:52:55.000000000 -0600
@@ -1,7 +1,7 @@
 /*
  * SyncLink Multiprotocol Serial Adapter Driver
  *
- * $Id: synclink.h,v 3.10 2005/11/08 19:50:54 paulkf Exp $
+ * $Id: synclink.h,v 3.11 2006/02/06 21:20:29 paulkf Exp $
  *
  * Copyright (C) 1998-2000 by Microgate Corporation
  *
@@ -221,6 +221,12 @@ struct mgsl_icount {
 	__u32	rxidle;
 };
 
+struct gpio_desc {
+	__u32 state;
+	__u32 smask;
+	__u32 dir;
+	__u32 dmask;
+};
 
 #define DEBUG_LEVEL_DATA	1
 #define DEBUG_LEVEL_ERROR 	2
@@ -276,5 +282,8 @@ struct mgsl_icount {
 #define MGSL_IOCLOOPTXDONE	_IO(MGSL_MAGIC_IOC,9)
 #define MGSL_IOCSIF		_IO(MGSL_MAGIC_IOC,10)
 #define MGSL_IOCGIF		_IO(MGSL_MAGIC_IOC,11)
+#define MGSL_IOCSGPIO		_IOW(MGSL_MAGIC_IOC,16,struct gpio_desc)
+#define MGSL_IOCGGPIO		_IOR(MGSL_MAGIC_IOC,17,struct gpio_desc)
+#define MGSL_IOCWAITGPIO	_IOWR(MGSL_MAGIC_IOC,18,struct gpio_desc)
 
 #endif /* _SYNCLINK_H_ */


