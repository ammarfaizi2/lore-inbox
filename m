Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267189AbUG1O66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267189AbUG1O66 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 10:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267194AbUG1O66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 10:58:58 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:23489 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S267189AbUG1OzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 10:55:15 -0400
Date: Tue, 27 Jul 2004 15:07:49 -0500
From: Greg Howard <ghoward@sgi.com>
X-X-Sender: ghoward@gallifrey.americas.sgi.com
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Altix system controller communication driver
Message-ID: <Pine.SGI.4.58.0407271457240.1364@gallifrey.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

The following patch ("altix-system-controller-driver.patch")
implements a driver that allows user applications to access the system
controllers on SGI Altix machines.  It applies on top of the
2.6.8-rc-mm1 patch.

Most of the patch is just the new file drivers/char/snsc.c.  It allows
system-controller-related applications (e.g., "flashsc" which flashes
the system controller firmware) to forward data to SAL; SAL contains
the code that multiplexes this system controller traffic with other
such traffic (including console I/O).  It's expected that each node
will have a corresponding system controller device file, and each such
device file can be used to open a number of "subchannels".  The data
structures and macros for the new driver are kept in a separate header
file (snsc.h), since I anticipate eventually adding an additional file
that will leverage some of this code to log environmental event
notifications coming from the system controllers. Inline wrapper
functions for the the SAL services used by the driver have been added
to include/asm-ia64/sn/sn_sal.h.

The only other significant (though small) change is in the Altix
console driver, drivers/serial/sn_console.c.  This driver must share
an interrupt with snsc.c.  A few config-related files are also patched
(sn2_defconfig and drivers/char/[Kconfig,Makefile]).

Thanks - Greg

Signed-off-by: Greg Howard <ghoward@sgi.com>

 arch/ia64/configs/sn2_defconfig |    1
 drivers/char/Kconfig            |    7
 drivers/char/Makefile           |    1
 drivers/char/snsc.c             |  491 ++++++++++++++++++++++++++++++++++++++++
 drivers/char/snsc.h             |   50 ++++
 drivers/serial/sn_console.c     |    3
 include/asm-ia64/sn/sn_sal.h    |  142 +++++++++++
 7 files changed, 693 insertions(+), 2 deletions(-)

diff -uprN -X dontdiff original/arch/ia64/configs/sn2_defconfig changed/arch/ia64/configs/sn2_defconfig
--- original/arch/ia64/configs/sn2_defconfig	2004-07-11 12:33:53.000000000 -0500
+++ changed/arch/ia64/configs/sn2_defconfig	2004-07-27 14:32:50.000000000 -0500
@@ -529,6 +529,7 @@ CONFIG_SERIAL_NONSTANDARD=y
 # CONFIG_STALDRV is not set
 CONFIG_SGI_L1_SERIAL=y
 CONFIG_SGI_L1_SERIAL_CONSOLE=y
+CONFIG_SGI_SNSC=y

 #
 # Serial drivers
diff -uprN -X dontdiff original/drivers/char/Kconfig changed/drivers/char/Kconfig
--- original/drivers/char/Kconfig	2004-07-27 13:32:37.000000000 -0500
+++ changed/drivers/char/Kconfig	2004-07-27 14:32:50.000000000 -0500
@@ -424,6 +424,13 @@ config A2232
 	  will also be built as a module. This has to be loaded before
 	  "ser_a2232". If you want to do this, answer M here.

+config SGI_SNSC
+	bool "SGI Altix system controller communication support"
+	help
+	  If you have an SGI Altix and you want to enable system
+	  controller communication from user space (you want this!),
+	  say Y.  Otherwise, say N.
+
 source "drivers/serial/Kconfig"

 config UNIX98_PTYS
diff -uprN -X dontdiff original/drivers/char/Makefile changed/drivers/char/Makefile
--- original/drivers/char/Makefile	2004-07-27 13:32:37.000000000 -0500
+++ changed/drivers/char/Makefile	2004-07-27 14:32:50.000000000 -0500
@@ -41,6 +41,7 @@ obj-$(CONFIG_SX)		+= sx.o generic_serial
 obj-$(CONFIG_RIO)		+= rio/ generic_serial.o
 obj-$(CONFIG_HVC_CONSOLE)	+= hvc_console.o
 obj-$(CONFIG_RAW_DRIVER)	+= raw.o
+obj-$(CONFIG_SGI_SNSC)		+= snsc.o
 obj-$(CONFIG_VIOCONS) += viocons.o
 obj-$(CONFIG_VIOTAPE)		+= viotape.o

diff -uprN -X dontdiff original/drivers/char/snsc.c changed/drivers/char/snsc.c
--- original/drivers/char/snsc.c	1969-12-31 18:00:00.000000000 -0600
+++ changed/drivers/char/snsc.c	2004-07-27 14:32:50.000000000 -0500
@@ -0,0 +1,491 @@
+/*
+ * SN Platform system controller communication support
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2004 Silicon Graphics, Inc. All rights reserved.
+ */
+
+/*
+ * System controller communication driver
+ *
+ * This driver allows a user process to communicate with the system
+ * controller (a.k.a. "IRouter") network in an SGI SN system.
+ */
+
+#include "snsc.h"
+#include <linux/interrupt.h>
+#include <linux/sched.h>
+#include <linux/device.h>
+#include <linux/poll.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <asm/sn/sn_sal.h>
+#include <asm/sn/nodepda.h>
+
+
+#define SYSCTL_BASENAME	"snsc"
+
+#define SCDRV_BUFSZ	2048
+
+#ifdef SCDRV_DEBUG
+#define DPRINTF(x...)	printk(x)
+#else
+#define DPRINTF(x...)	do {} while(0)
+#endif
+
+static int scdrv_open(struct inode *, struct file *);
+static int scdrv_release(struct inode *, struct file *);
+static ssize_t scdrv_read(struct file *, char *, size_t, loff_t *);
+static ssize_t scdrv_write(struct file *, const char *, size_t, loff_t *);
+static unsigned int scdrv_poll(struct file *, struct poll_table_struct *);
+static irqreturn_t scdrv_interrupt(int, void *, struct pt_regs *);
+
+static struct file_operations scdrv_fops = {
+	owner:THIS_MODULE,
+	read:scdrv_read,
+	write:scdrv_write,
+	poll:scdrv_poll,
+	open:scdrv_open,
+	release:scdrv_release,
+};
+
+/*
+ * scdrv_wait
+ *
+ * Call this function to wait on one of the queues associated with an
+ * open subchannel.  Avoid races by entering this function with a held
+ * lock that protects the wait queue; don't release the lock until after
+ * we've added ourselves to the queue.
+ */
+static inline int
+scdrv_wait(wait_queue_head_t * waitq_head, spinlock_t * waitq_lock,
+	   unsigned long flags, unsigned long timeout)
+{
+	DECLARE_WAITQUEUE(wait, current);
+	int ret;
+
+	add_wait_queue(waitq_head, &wait);
+	set_current_state(TASK_INTERRUPTIBLE);
+	spin_unlock_irqrestore(waitq_lock, flags);
+
+	if (timeout) {
+		ret = schedule_timeout(timeout);
+	} else {
+		schedule();
+	}
+
+	remove_wait_queue(waitq_head, &wait);
+
+	if (signal_pending(current)) {
+		return (timeout ? -ret : -1);
+	}
+	return (timeout ? ret : 1);
+}
+
+/*
+ * scdrv_init
+ *
+ * Called at boot time to initialize the system controller communication
+ * facility.
+ */
+int __init
+scdrv_init(void)
+{
+	geoid_t geoid;
+	cmoduleid_t cmod;
+	int i;
+	char devname[32];
+	char *devnamep;
+	module_t *m;
+	struct sysctl_data_s *scd;
+	void *salbuf;
+	struct class_simple *snsc_class;
+	dev_t first_dev, dev;
+
+	if (alloc_chrdev_region(&first_dev, 0, (MAX_SLABS*nummodules), "snsc")
+	    < 0) {
+		printk("%s: failed to register SN system controller device\n",
+		       __FUNCTION__);
+		return -ENODEV;
+	}
+	snsc_class = class_simple_create(THIS_MODULE, SYSCTL_BASENAME);
+
+	for (cmod = 0; cmod < nummodules; cmod++) {
+		m = sn_modules[cmod];
+		for (i = 0; i <= MAX_SLABS; i++) {
+
+			if (m->nodes[i] == -1) {
+				/* node is not alive in module */
+				continue;
+			}
+
+			geoid = m->geoid[i];
+			devnamep = devname;
+			format_module_id(devnamep, geo_module(geoid),
+					 MODULE_FORMAT_BRIEF);
+			devnamep = devname + strlen(devname);
+			sprintf(devnamep, "#%d", geo_slab(geoid));
+
+			/* allocate sysctl device data */
+			scd =
+			    (struct sysctl_data_s *) kmalloc
+				(sizeof (struct sysctl_data_s), GFP_KERNEL);
+			if (!scd) {
+				printk("%s: failed to allocate device info"
+				       "for %s/%s\n", __FUNCTION__,
+				       SYSCTL_BASENAME, devname);
+				continue;
+			}
+			memset(scd, 0, sizeof (struct sysctl_data_s));
+
+			/* initialize sysctl device data fields */
+			scd->scd_nasid = cnodeid_to_nasid(m->nodes[i]);
+			if (!(salbuf = kmalloc(SCDRV_BUFSZ, GFP_KERNEL))) {
+				printk("%s: failed to allocate driver buffer"
+				       "(%s%s)\n", __FUNCTION__,
+				       SYSCTL_BASENAME, devname);
+				kfree(scd);
+				continue;
+			}
+
+			if (ia64_sn_irtr_init(scd->scd_nasid, salbuf,
+					      SCDRV_BUFSZ) < 0) {
+				printk
+				    ("%s: failed to initialize SAL for"
+				     " system controller communication"
+				     " (%s/%s): outdated PROM?\n",
+				     __FUNCTION__, SYSCTL_BASENAME, devname);
+				kfree(scd);
+				kfree(salbuf);
+				continue;
+			}
+
+			dev = first_dev + m->nodes[i];
+			cdev_init(&scd->scd_cdev, &scdrv_fops);
+			if (cdev_add(&scd->scd_cdev, dev, 1)) {
+				printk("%s: failed to register system"
+				       " controller device (%s%s)\n",
+				       __FUNCTION__, SYSCTL_BASENAME, devname);
+				kfree(scd);
+				kfree(salbuf);
+				continue;
+			}
+
+			class_simple_device_add(snsc_class, dev, NULL,
+						"%s", devname);
+
+			ia64_sn_irtr_intr_enable(scd->scd_nasid,
+						 0 /*ignored */ ,
+						 SAL_IROUTER_INTR_RECV);
+		}
+	}
+	return 0;
+}
+
+/*
+ * scdrv_open
+ *
+ * Reserve a subchannel for system controller communication.
+ */
+
+static int
+scdrv_open(struct inode *inode, struct file *file)
+{
+	struct sysctl_data_s *scd;
+	struct subch_data_s *sd;
+	int rv;
+
+	/* look up device info for this device file */
+	scd = container_of(inode->i_cdev, struct sysctl_data_s, scd_cdev);
+
+	if (!scd) {
+		printk("%s: no such device\n", __FUNCTION__);
+		return -ENODEV;
+	}
+
+	/* allocate memory for subchannel data */
+	sd = (struct subch_data_s *)
+		kmalloc(sizeof (struct subch_data_s), GFP_KERNEL);
+	if (sd == NULL) {
+		printk("%s: couldn't allocate subchannel data\n",
+		       __FUNCTION__);
+		return -ENOMEM;
+	}
+
+	/* initialize subch_data_s fields */
+	memset(sd, 0, sizeof (struct subch_data_s));
+	sd->sd_nasid = scd->scd_nasid;
+	sd->sd_subch = ia64_sn_irtr_open(scd->scd_nasid);
+
+	if (sd->sd_subch < 0) {
+		kfree(sd);
+		printk("%s: couldn't allocate subchannel\n", __FUNCTION__);
+		return -EBUSY;
+	}
+
+	spin_lock_init(&sd->sd_rlock);
+	spin_lock_init(&sd->sd_wlock);
+	init_waitqueue_head(&sd->sd_rq);
+	init_waitqueue_head(&sd->sd_wq);
+	sema_init(&sd->sd_rbs, 1);
+	sema_init(&sd->sd_wbs, 1);
+
+	file->private_data = sd;
+
+	/* hook this subchannel up to the system controller interrupt */
+	rv = request_irq(SGI_UART_VECTOR, scdrv_interrupt,
+			 SA_SHIRQ | SA_INTERRUPT,
+			 SYSCTL_BASENAME, sd);
+	if (rv) {
+		ia64_sn_irtr_close(sd->sd_nasid, sd->sd_subch);
+		kfree(sd);
+		printk("%s: irq request failed (%d)\n", __FUNCTION__, rv);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+/*
+ * scdrv_release
+ *
+ * Release a previously-reserved subchannel.
+ */
+
+static int
+scdrv_release(struct inode *inode, struct file *file)
+{
+	struct subch_data_s *sd = (struct subch_data_s *) file->private_data;
+	int rv;
+
+	/* free the interrupt */
+	free_irq(SGI_UART_VECTOR, sd);
+
+	/* ask SAL to close the subchannel */
+	rv = ia64_sn_irtr_close(sd->sd_nasid, sd->sd_subch);
+
+	kfree(sd);
+	return rv;
+}
+
+/*
+ * scdrv_read
+ *
+ * Called to read bytes from the open IRouter pipe.
+ *
+ */
+
+static inline int
+read_status_check(struct subch_data_s * sd, int *len)
+{
+	return ia64_sn_irtr_recv(sd->sd_nasid, sd->sd_subch, sd->sd_rb, len);
+}
+
+static ssize_t
+scdrv_read(struct file *file, char *buf, size_t count, loff_t * f_pos)
+{
+	int status;
+	int len;
+	unsigned long flags;
+	struct subch_data_s *sd = (struct subch_data_s *) file->private_data;
+
+	/* try to get control of the read buffer */
+	if (down_trylock(&sd->sd_rbs)) {
+		/* somebody else has it now;
+		 * if we're non-blocking, then exit...
+		 */
+		if (file->f_flags & O_NONBLOCK) {
+			return -EAGAIN;
+		}
+		/* ...or if we want to block, then do so here */
+		if (down_interruptible(&sd->sd_rbs)) {
+			/* something went wrong with wait */
+			return -ERESTARTSYS;
+		}
+	}
+
+	/* anything to read? */
+	len = CHUNKSIZE;
+	spin_lock_irqsave(&sd->sd_rlock, flags);
+	status = read_status_check(sd, &len);
+
+	/* if not, and we're blocking I/O, loop */
+	while (status < 0) {
+		if (file->f_flags & O_NONBLOCK) {
+			spin_unlock_irqrestore(&sd->sd_rlock, flags);
+			return -EAGAIN;
+		}
+		len = CHUNKSIZE;
+		if (scdrv_wait(&sd->sd_rq, &sd->sd_rlock, flags, 1000) < 0) {
+			/* something went wrong with wait */
+			return -ERESTARTSYS;
+		}
+		/* sd->sd_rlock was unlocked by scdrv_wait(), above */
+		spin_lock_irqsave(&sd->sd_rlock, flags);
+		status = read_status_check(sd, &len);
+	}
+	spin_unlock_irqrestore(&sd->sd_rlock, flags);
+
+	if (len > 0) {
+		/* we read something in the last read_status_check(); copy
+		 * it out to user space
+		 */
+		if (count < len) {
+			DPRINTF("%s: only accepting %d of %d bytes\n",
+				__FUNCTION__, (int) count, len);
+		}
+		len = min((int) count, len);
+		copy_to_user(buf, sd->sd_rb, len);
+	}
+
+	/* release the read buffer and wake anyone who might be
+	 * waiting for it
+	 */
+	up(&sd->sd_rbs);
+
+	/* return the number of characters read in */
+	return len;
+}
+
+/*
+ * scdrv_write
+ *
+ * Writes a chunk of an IRouter packet (or other system controller data)
+ * to the system controller.
+ *
+ */
+static inline int
+write_status_check(struct subch_data_s * sd, int count)
+{
+	return ia64_sn_irtr_send(sd->sd_nasid, sd->sd_subch, sd->sd_wb, count);
+}
+
+static ssize_t
+scdrv_write(struct file *file, const char *buf, size_t count, loff_t * f_pos)
+{
+	unsigned long flags;
+	int status;
+	struct subch_data_s *sd = (struct subch_data_s *) file->private_data;
+
+	/* try to get control of the write buffer */
+	if (down_trylock(&sd->sd_wbs)) {
+		/* somebody else has it now;
+		 * if we're non-blocking, then exit...
+		 */
+		if (file->f_flags & O_NONBLOCK) {
+			return -EAGAIN;
+		}
+		/* ...or if we want to block, then do so here */
+		if (down_interruptible(&sd->sd_wbs)) {
+			/* something went wrong with wait */
+			return -ERESTARTSYS;
+		}
+	}
+
+	count = min((int) count, CHUNKSIZE);
+	copy_from_user(sd->sd_wb, buf, count);
+
+	/* try to send the buffer */
+	spin_lock_irqsave(&sd->sd_wlock, flags);
+	status = write_status_check(sd, count);
+
+	/* if we failed, and we want to block, then loop */
+	while (status <= 0) {
+		if (file->f_flags & O_NONBLOCK) {
+			spin_unlock(&sd->sd_wlock);
+			return -EAGAIN;
+		}
+		if (scdrv_wait(&sd->sd_wq, &sd->sd_wlock, flags, 1000) < 0) {
+			/* something went wrong with wait */
+			return -ERESTARTSYS;
+		}
+
+		/* sd->sd_wlock was unlocked by scdrv_wait(), above */
+		spin_lock_irqsave(&sd->sd_wlock, flags);
+		status = write_status_check(sd, count);
+	}
+	spin_unlock_irqrestore(&sd->sd_wlock, flags);
+
+	/* release the write buffer and wake anyone who's waiting for it */
+	up(&sd->sd_wbs);
+
+	/* return the number of characters accepted (should be the complete
+	 * "chunk" as requested)
+	 */
+	if ((status >= 0) && (status < count)) {
+		DPRINTF("Didn't accept the full chunk; %d of %d\n",
+			status, (int) count);
+	}
+	return status;
+}
+
+static inline void
+scdrv_lock_all(struct subch_data_s * sd, unsigned long *flags)
+{
+	spin_lock_irqsave(&sd->sd_rlock, *flags);
+	spin_lock(&sd->sd_wlock);
+}
+
+static inline void
+scdrv_unlock_all(struct subch_data_s * sd, unsigned long flags)
+{
+	spin_unlock(&sd->sd_wlock);
+	spin_unlock_irqrestore(&sd->sd_rlock, flags);
+}
+
+static unsigned int
+scdrv_poll(struct file *file, struct poll_table_struct *wait)
+{
+	unsigned int mask = 0;
+	int status = 0;
+	struct subch_data_s *sd = (struct subch_data_s *) file->private_data;
+	unsigned long flags;
+
+	scdrv_lock_all(sd, &flags);
+	poll_wait(file, &sd->sd_rq, wait);
+	poll_wait(file, &sd->sd_wq, wait);
+
+	status = ia64_sn_irtr_intr(sd->sd_nasid, sd->sd_subch);
+	scdrv_unlock_all(sd, flags);
+
+	if (status > 0) {
+		if (status & SAL_IROUTER_INTR_RECV) {
+			mask |= POLLIN | POLLRDNORM;
+		}
+		if (status & SAL_IROUTER_INTR_XMIT) {
+			mask |= POLLOUT | POLLWRNORM;
+		}
+	}
+
+	return mask;
+}
+
+static irqreturn_t
+scdrv_interrupt(int irq, void *subch_data, struct pt_regs *regs)
+{
+	struct subch_data_s *sd = (struct subch_data_s *) subch_data;
+	unsigned long flags;
+	int status;
+
+	scdrv_lock_all(sd, &flags);
+	status = ia64_sn_irtr_intr(sd->sd_nasid, sd->sd_subch);
+
+	if (status > 0) {
+		if (status & SAL_IROUTER_INTR_RECV) {
+			wake_up_all(&sd->sd_rq);
+		}
+		if (status & SAL_IROUTER_INTR_XMIT) {
+			ia64_sn_irtr_intr_disable
+			    (sd->sd_nasid, sd->sd_subch,
+			     SAL_IROUTER_INTR_XMIT);
+			wake_up_all(&sd->sd_wq);
+		}
+	}
+	scdrv_unlock_all(sd, flags);
+	return IRQ_HANDLED;
+}
+
+module_init(scdrv_init);
diff -uprN -X dontdiff original/drivers/char/snsc.h changed/drivers/char/snsc.h
--- original/drivers/char/snsc.h	1969-12-31 18:00:00.000000000 -0600
+++ changed/drivers/char/snsc.h	2004-07-27 14:32:50.000000000 -0500
@@ -0,0 +1,50 @@
+/*
+ * SN Platform system controller communication support
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2004 Silicon Graphics, Inc. All rights reserved.
+ */
+
+/*
+ * This file contains macros and data types for communication with the
+ * system controllers in SGI SN systems.
+ */
+
+#ifndef _SN_SYSCTL_H_
+#define _SN_SYSCTL_H_
+
+#include <linux/types.h>
+#include <linux/spinlock.h>
+#include <linux/wait.h>
+#include <linux/kobject.h>
+#include <linux/fs.h>
+#include <linux/cdev.h>
+#include <asm/sn/types.h>
+#include <asm/semaphore.h>
+
+#define CHUNKSIZE 127
+
+/* This structure is used to track an open subchannel. */
+struct subch_data_s {
+	nasid_t sd_nasid;	/* node on which the subchannel was opened */
+	int sd_subch;		/* subchannel number */
+	spinlock_t sd_rlock;	/* monitor lock for rsv */
+	spinlock_t sd_wlock;	/* monitor lock for wsv */
+	wait_queue_head_t sd_rq;	/* wait queue for readers */
+	wait_queue_head_t sd_wq;	/* wait queue for writers */
+	struct semaphore sd_rbs;	/* semaphore for read buffer */
+	struct semaphore sd_wbs;	/* semaphore for write buffer */
+
+	char sd_rb[CHUNKSIZE];	/* read buffer */
+	char sd_wb[CHUNKSIZE];	/* write buffer */
+};
+
+struct sysctl_data_s {
+	struct cdev scd_cdev;	/* Character device info */
+	nasid_t scd_nasid;	/* Node on which subchannels are opened. */
+};
+
+#endif /* _SN_SYSCTL_H_ */
diff -uprN -X dontdiff original/drivers/serial/sn_console.c changed/drivers/serial/sn_console.c
--- original/drivers/serial/sn_console.c	2004-07-27 13:32:38.000000000 -0500
+++ changed/drivers/serial/sn_console.c	2004-07-27 14:32:50.000000000 -0500
@@ -712,7 +712,8 @@ sn_sal_interrupt(int irq, void *dev_id,
 static int
 sn_sal_connect_interrupt(struct sn_cons_port *port)
 {
-	if (request_irq(SGI_UART_VECTOR, sn_sal_interrupt, SA_INTERRUPT,
+	if (request_irq(SGI_UART_VECTOR, sn_sal_interrupt,
+			SA_INTERRUPT | SA_SHIRQ,
 			"SAL console driver", port) >= 0) {
 		return SGI_UART_VECTOR;
 	}
diff -uprN -X dontdiff original/include/asm-ia64/sn/sn_sal.h changed/include/asm-ia64/sn/sn_sal.h
--- original/include/asm-ia64/sn/sn_sal.h	2004-07-11 12:35:31.000000000 -0500
+++ changed/include/asm-ia64/sn/sn_sal.h	2004-07-27 14:32:50.000000000 -0500
@@ -8,7 +8,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (c) 2000-2003 Silicon Graphics, Inc.  All rights reserved.
+ * Copyright (c) 2000-2004 Silicon Graphics, Inc.  All rights reserved.
  */


@@ -60,6 +60,7 @@
 #define  SN_SAL_SYSCTL_FRU_CAPTURE		   0x0200003f

 #define  SN_SAL_SYSCTL_IOBRICK_PCI_OP		   0x02000042	// reentrant
+#define	 SN_SAL_IROUTER_OP			   0x02000043

 /*
  * Service-specific constants
@@ -86,6 +87,25 @@
 #endif	/* CONFIG_HOTPLUG_PCI_SGI */

 /*
+ * IRouter (i.e. generalized system controller) operations
+ */
+#define SAL_IROUTER_OPEN	0	/* open a subchannel */
+#define SAL_IROUTER_CLOSE	1	/* close a subchannel */
+#define SAL_IROUTER_SEND	2	/* send part of an IRouter packet */
+#define SAL_IROUTER_RECV	3	/* receive part of an IRouter packet */
+#define SAL_IROUTER_INTR_STATUS	4	/* check the interrupt status for
+					 * an open subchannel
+					 */
+#define SAL_IROUTER_INTR_ON	5	/* enable an interrupt */
+#define SAL_IROUTER_INTR_OFF	6	/* disable an interrupt */
+#define SAL_IROUTER_INIT	7	/* initialize IRouter driver */
+
+/* IRouter interrupt mask bits */
+#define SAL_IROUTER_INTR_XMIT	SAL_CONSOLE_INTR_XMIT
+#define SAL_IROUTER_INTR_RECV	SAL_CONSOLE_INTR_RECV
+
+
+/*
  * SN_SAL_GET_PARTITION_ADDR return constants
  */
 #define SALRET_MORE_PASSES	1
@@ -704,4 +724,124 @@ ia64_sn_set_error_handling_features(cons
 	return rv.status;
 }

+
+/*
+ * Open a subchannel for sending arbitrary data to the system
+ * controller network via the system controller device associated with
+ * 'nasid'.  Return the subchannel number or a negative error code.
+ */
+static inline int
+ia64_sn_irtr_open(nasid_t nasid)
+{
+	struct ia64_sal_retval rv;
+	SAL_CALL_REENTRANT(rv, SN_SAL_IROUTER_OP, SAL_IROUTER_OPEN, nasid,
+			   0, 0, 0, 0, 0);
+	return (int) rv.v0;
+}
+
+/*
+ * Close system controller subchannel 'subch' previously opened on 'nasid'.
+ */
+static inline int
+ia64_sn_irtr_close(nasid_t nasid, int subch)
+{
+	struct ia64_sal_retval rv;
+	SAL_CALL_REENTRANT(rv, SN_SAL_IROUTER_OP, SAL_IROUTER_CLOSE,
+			   (u64) nasid, (u64) subch, 0, 0, 0, 0);
+	return (int) rv.status;
+}
+
+/*
+ * Read data from system controller associated with 'nasid' on
+ * subchannel 'subch'.  The buffer to be filled is pointed to by
+ * 'buf', and its capacity is in the integer pointed to by 'len'.  The
+ * referent of 'len' is set to the number of bytes read by the SAL
+ * call.  The return value is either SALRET_OK (for bytes read) or
+ * SALRET_ERROR (for error or "no data available").
+ */
+static inline int
+ia64_sn_irtr_recv(nasid_t nasid, int subch, char *buf, int *len)
+{
+	struct ia64_sal_retval rv;
+	SAL_CALL_REENTRANT(rv, SN_SAL_IROUTER_OP, SAL_IROUTER_RECV,
+			   (u64) nasid, (u64) subch, (u64) buf, (u64) len,
+			   0, 0);
+	return (int) rv.status;
+}
+
+/*
+ * Write data to the system controller network via the system
+ * controller associated with 'nasid' on suchannel 'subch'.  The
+ * buffer to be written out is pointed to by 'buf', and 'len' is the
+ * number of bytes to be written.  The return value is either the
+ * number of bytes written (which could be zero) or a negative error
+ * code.
+ */
+static inline int
+ia64_sn_irtr_send(nasid_t nasid, int subch, char *buf, int len)
+{
+	struct ia64_sal_retval rv;
+	SAL_CALL_REENTRANT(rv, SN_SAL_IROUTER_OP, SAL_IROUTER_SEND,
+			   (u64) nasid, (u64) subch, (u64) buf, (u64) len,
+			   0, 0);
+	return (int) rv.v0;
+}
+
+/*
+ * Check whether any interrupts are pending for the system controller
+ * associated with 'nasid' and its subchannel 'subch'.  The return
+ * value is a mask of pending interrupts (SAL_IROUTER_INTR_XMIT and/or
+ * SAL_IROUTER_INTR_RECV).
+ */
+static inline int
+ia64_sn_irtr_intr(nasid_t nasid, int subch)
+{
+	struct ia64_sal_retval rv;
+	SAL_CALL_REENTRANT(rv, SN_SAL_IROUTER_OP, SAL_IROUTER_INTR_STATUS,
+			   (u64) nasid, (u64) subch, 0, 0, 0, 0);
+	return (int) rv.v0;
+}
+
+/*
+ * Enable the interrupt indicated by the intr parameter (either
+ * SAL_IROUTER_INTR_XMIT or SAL_IROUTER_INTR_RECV).
+ */
+static inline int
+ia64_sn_irtr_intr_enable(nasid_t nasid, int subch, u64 intr)
+{
+	struct ia64_sal_retval rv;
+	SAL_CALL_REENTRANT(rv, SN_SAL_IROUTER_OP, SAL_IROUTER_INTR_ON,
+			   (u64) nasid, (u64) subch, intr, 0, 0, 0);
+	return (int) rv.v0;
+}
+
+/*
+ * Disable the interrupt indicated by the intr parameter (either
+ * SAL_IROUTER_INTR_XMIT or SAL_IROUTER_INTR_RECV).
+ */
+static inline int
+ia64_sn_irtr_intr_disable(nasid_t nasid, int subch, u64 intr)
+{
+	struct ia64_sal_retval rv;
+	SAL_CALL_REENTRANT(rv, SN_SAL_IROUTER_OP, SAL_IROUTER_INTR_OFF,
+			   (u64) nasid, (u64) subch, intr, 0, 0, 0);
+	return (int) rv.v0;
+}
+
+/*
+ * Initialize the SAL components of the system controller
+ * communication driver; specifically pass in a sizable buffer that
+ * can be used for allocation of subchannel queues as new subchannels
+ * are opened.  "buf" points to the buffer, and "len" specifies its
+ * length.
+ */
+static inline int
+ia64_sn_irtr_init(nasid_t nasid, void *buf, int len)
+{
+	struct ia64_sal_retval rv;
+	SAL_CALL_REENTRANT(rv, SN_SAL_IROUTER_OP, SAL_IROUTER_INIT,
+			   (u64) nasid, (u64) buf, (u64) len, 0, 0, 0);
+	return (int) rv.status;
+}
+
 #endif /* _ASM_IA64_SN_SN_SAL_H */



