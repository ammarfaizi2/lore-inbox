Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266670AbUHCQDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266670AbUHCQDY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 12:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266686AbUHCQDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 12:03:24 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:17103 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S266670AbUHCQCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 12:02:50 -0400
Date: Tue, 3 Aug 2004 11:02:38 -0500
From: Greg Howard <ghoward@sgi.com>
X-X-Sender: ghoward@gallifrey.americas.sgi.com
To: akpm@osdl.org
cc: hch@infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [2.6.8-rc2-mm2] More Altix system controller changes
Message-ID: <Pine.SGI.4.58.0408031041220.10767@gallifrey.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Here's an update to the Altix system conroller communication driver.
It incorporates some suggestions Christoph made about the last patch
and fixes a couple of config files.  It's based on 2.6.8-rc2-mm2.

Thanks - Greg

Signed-off-by: Greg Howard <ghoward@sgi.com>

Changelog:
Rearrange the code in snsc.c to get rid of unnecessary forward
declarations.  Also manually inline some wrapper functions to make the
file more readable, and fix scdrv_read() to always release the
read-buffer semaphore before returning.  Add the system controller
communication driver to the default SN2 config file, and fix the
SGI_SNSC dependecy list in driver/char/Kconfig to depend on
IA64_SGI_SN2 rather than CONFIG_IA64_SGI_SN2.

 arch/ia64/configs/sn2_defconfig |    1
 drivers/char/Kconfig            |    2
 drivers/char/snsc.c             |  357 +++++++++++++++++-----------------------
 3 files changed, 159 insertions(+), 201 deletions(-)

diff -uprN -X dontdiff original/arch/ia64/configs/sn2_defconfig changed/arch/ia64/configs/sn2_defconfig
--- original/arch/ia64/configs/sn2_defconfig	2004-08-02 11:56:23.000000000 -0500
+++ changed/arch/ia64/configs/sn2_defconfig	2004-08-03 10:13:50.000000000 -0500
@@ -528,6 +528,7 @@ CONFIG_SERIAL_NONSTANDARD=y
 # CONFIG_SYNCLINKMP is not set
 # CONFIG_N_HDLC is not set
 # CONFIG_STALDRV is not set
+CONFIG_SGI_SNSC=y

 #
 # Serial drivers
diff -uprN -X dontdiff original/drivers/char/Kconfig changed/drivers/char/Kconfig
--- original/drivers/char/Kconfig	2004-08-02 11:56:24.000000000 -0500
+++ changed/drivers/char/Kconfig	2004-08-03 10:13:50.000000000 -0500
@@ -426,7 +426,7 @@ config A2232

 config SGI_SNSC
 	bool "SGI Altix system controller communication support"
-	depends on CONFIG_IA64_SGI_SN2
+	depends on IA64_SGI_SN2
 	help
 	  If you have an SGI Altix and you want to enable system
 	  controller communication from user space (you want this!),
diff -uprN -X dontdiff original/drivers/char/snsc.c changed/drivers/char/snsc.c
--- original/drivers/char/snsc.c	2004-08-02 11:56:24.000000000 -0500
+++ changed/drivers/char/snsc.c	2004-08-03 10:13:50.000000000 -0500
@@ -15,7 +15,6 @@
  * controller (a.k.a. "IRouter") network in an SGI SN system.
  */

-#include "snsc.h"
 #include <linux/interrupt.h>
 #include <linux/sched.h>
 #include <linux/device.h>
@@ -24,165 +23,38 @@
 #include <linux/slab.h>
 #include <asm/sn/sn_sal.h>
 #include <asm/sn/nodepda.h>
-
+#include "snsc.h"

 #define SYSCTL_BASENAME	"snsc"

 #define SCDRV_BUFSZ	2048
+#define SCDRV_TIMEOUT	1000

-#ifdef SCDRV_DEBUG
-#define DPRINTF(x...)	printk(x)
-#else
-#define DPRINTF(x...)	do {} while(0)
-#endif
-
-static int scdrv_open(struct inode *, struct file *);
-static int scdrv_release(struct inode *, struct file *);
-static ssize_t scdrv_read(struct file *, char __user *, size_t, loff_t *);
-static ssize_t scdrv_write(struct file *, const char __user *,
-			   size_t, loff_t *);
-static unsigned int scdrv_poll(struct file *, struct poll_table_struct *);
-static irqreturn_t scdrv_interrupt(int, void *, struct pt_regs *);
-
-static struct file_operations scdrv_fops = {
-	.owner =	THIS_MODULE,
-	.read =		scdrv_read,
-	.write =	scdrv_write,
-	.poll =		scdrv_poll,
-	.open =		scdrv_open,
-	.release =	scdrv_release,
-};
-
-/*
- * scdrv_wait
- *
- * Call this function to wait on one of the queues associated with an
- * open subchannel.  Avoid races by entering this function with a held
- * lock that protects the wait queue; don't release the lock until after
- * we've added ourselves to the queue.
- */
-static inline int
-scdrv_wait(wait_queue_head_t *waitq_head, spinlock_t *waitq_lock,
-	   unsigned long flags, unsigned long timeout)
-{
-	DECLARE_WAITQUEUE(wait, current);
-	int ret;
-
-	add_wait_queue(waitq_head, &wait);
-	set_current_state(TASK_INTERRUPTIBLE);
-	spin_unlock_irqrestore(waitq_lock, flags);
-
-	if (timeout) {
-		ret = schedule_timeout(timeout);
-	} else {
-		schedule();
-	}
-
-	remove_wait_queue(waitq_head, &wait);
-
-	if (signal_pending(current)) {
-		return (timeout ? -ret : -1);
-	}
-	return (timeout ? ret : 1);
-}
-
-/*
- * scdrv_init
- *
- * Called at boot time to initialize the system controller communication
- * facility.
- */
-int __init
-scdrv_init(void)
+static irqreturn_t
+scdrv_interrupt(int irq, void *subch_data, struct pt_regs *regs)
 {
-	geoid_t geoid;
-	cmoduleid_t cmod;
-	int i;
-	char devname[32];
-	char *devnamep;
-	module_t *m;
-	struct sysctl_data_s *scd;
-	void *salbuf;
-	struct class_simple *snsc_class;
-	dev_t first_dev, dev;
-
-	if (alloc_chrdev_region(&first_dev, 0, (MAX_SLABS*nummodules), "snsc")
-	    < 0) {
-		printk("%s: failed to register SN system controller device\n",
-		       __FUNCTION__);
-		return -ENODEV;
-	}
-	snsc_class = class_simple_create(THIS_MODULE, SYSCTL_BASENAME);
-
-	for (cmod = 0; cmod < nummodules; cmod++) {
-		m = sn_modules[cmod];
-		for (i = 0; i <= MAX_SLABS; i++) {
-
-			if (m->nodes[i] == -1) {
-				/* node is not alive in module */
-				continue;
-			}
-
-			geoid = m->geoid[i];
-			devnamep = devname;
-			format_module_id(devnamep, geo_module(geoid),
-					 MODULE_FORMAT_BRIEF);
-			devnamep = devname + strlen(devname);
-			sprintf(devnamep, "#%d", geo_slab(geoid));
-
-			/* allocate sysctl device data */
-			scd = kmalloc(sizeof (struct sysctl_data_s),
-				      GFP_KERNEL);
-			if (!scd) {
-				printk("%s: failed to allocate device info"
-				       "for %s/%s\n", __FUNCTION__,
-				       SYSCTL_BASENAME, devname);
-				continue;
-			}
-			memset(scd, 0, sizeof (struct sysctl_data_s));
-
-			/* initialize sysctl device data fields */
-			scd->scd_nasid = cnodeid_to_nasid(m->nodes[i]);
-			if (!(salbuf = kmalloc(SCDRV_BUFSZ, GFP_KERNEL))) {
-				printk("%s: failed to allocate driver buffer"
-				       "(%s%s)\n", __FUNCTION__,
-				       SYSCTL_BASENAME, devname);
-				kfree(scd);
-				continue;
-			}
-
-			if (ia64_sn_irtr_init(scd->scd_nasid, salbuf,
-					      SCDRV_BUFSZ) < 0) {
-				printk
-				    ("%s: failed to initialize SAL for"
-				     " system controller communication"
-				     " (%s/%s): outdated PROM?\n",
-				     __FUNCTION__, SYSCTL_BASENAME, devname);
-				kfree(scd);
-				kfree(salbuf);
-				continue;
-			}
-
-			dev = first_dev + m->nodes[i];
-			cdev_init(&scd->scd_cdev, &scdrv_fops);
-			if (cdev_add(&scd->scd_cdev, dev, 1)) {
-				printk("%s: failed to register system"
-				       " controller device (%s%s)\n",
-				       __FUNCTION__, SYSCTL_BASENAME, devname);
-				kfree(scd);
-				kfree(salbuf);
-				continue;
-			}
+	struct subch_data_s *sd = (struct subch_data_s *) subch_data;
+	unsigned long flags;
+	int status;

-			class_simple_device_add(snsc_class, dev, NULL,
-						"%s", devname);
+	spin_lock_irqsave(&sd->sd_rlock, flags);
+	spin_lock(&sd->sd_wlock);
+	status = ia64_sn_irtr_intr(sd->sd_nasid, sd->sd_subch);

-			ia64_sn_irtr_intr_enable(scd->scd_nasid,
-						 0 /*ignored */ ,
-						 SAL_IROUTER_INTR_RECV);
+	if (status > 0) {
+		if (status & SAL_IROUTER_INTR_RECV) {
+			wake_up_all(&sd->sd_rq);
+		}
+		if (status & SAL_IROUTER_INTR_XMIT) {
+			ia64_sn_irtr_intr_disable
+			    (sd->sd_nasid, sd->sd_subch,
+			     SAL_IROUTER_INTR_XMIT);
+			wake_up_all(&sd->sd_wq);
 		}
 	}
-	return 0;
+	spin_unlock(&sd->sd_wlock);
+	spin_unlock_irqrestore(&sd->sd_rlock, flags);
+	return IRQ_HANDLED;
 }

 /*
@@ -201,11 +73,6 @@ scdrv_open(struct inode *inode, struct f
 	/* look up device info for this device file */
 	scd = container_of(inode->i_cdev, struct sysctl_data_s, scd_cdev);

-	if (!scd) {
-		printk("%s: no such device\n", __FUNCTION__);
-		return -ENODEV;
-	}
-
 	/* allocate memory for subchannel data */
 	sd = kmalloc(sizeof (struct subch_data_s), GFP_KERNEL);
 	if (sd == NULL) {
@@ -313,16 +180,26 @@ scdrv_read(struct file *file, char __use

 	/* if not, and we're blocking I/O, loop */
 	while (status < 0) {
+		DECLARE_WAITQUEUE(wait, current);
+
 		if (file->f_flags & O_NONBLOCK) {
 			spin_unlock_irqrestore(&sd->sd_rlock, flags);
 			return -EAGAIN;
 		}
+
 		len = CHUNKSIZE;
-		if (scdrv_wait(&sd->sd_rq, &sd->sd_rlock, flags, 1000) < 0) {
-			/* something went wrong with wait */
+		add_wait_queue(&sd->sd_rq, &wait);
+		set_current_state(TASK_INTERRUPTIBLE);
+		spin_unlock_irqrestore(&sd->sd_rlock, flags);
+
+		schedule_timeout(SCDRV_TIMEOUT);
+
+		remove_wait_queue(&sd->sd_rq, &wait);
+		if (signal_pending(current)) {
+			/* wait was interrupted */
 			return -ERESTARTSYS;
 		}
-		/* sd->sd_rlock was unlocked by scdrv_wait(), above */
+
 		spin_lock_irqsave(&sd->sd_rlock, flags);
 		status = read_status_check(sd, &len);
 	}
@@ -333,12 +210,12 @@ scdrv_read(struct file *file, char __use
 		 * it out to user space
 		 */
 		if (count < len) {
-			DPRINTF("%s: only accepting %d of %d bytes\n",
-				__FUNCTION__, (int) count, len);
+			pr_debug("%s: only accepting %d of %d bytes\n",
+				 __FUNCTION__, (int) count, len);
 		}
 		len = min((int) count, len);
 		if (copy_to_user(buf, sd->sd_rb, len))
-			return -EFAULT;
+			len = -EFAULT;
 	}

 	/* release the read buffer and wake anyone who might be
@@ -396,16 +273,25 @@ scdrv_write(struct file *file, const cha

 	/* if we failed, and we want to block, then loop */
 	while (status <= 0) {
+		DECLARE_WAITQUEUE(wait, current);
+
 		if (file->f_flags & O_NONBLOCK) {
 			spin_unlock(&sd->sd_wlock);
 			return -EAGAIN;
 		}
-		if (scdrv_wait(&sd->sd_wq, &sd->sd_wlock, flags, 1000) < 0) {
-			/* something went wrong with wait */
+
+		add_wait_queue(&sd->sd_wq, &wait);
+		set_current_state(TASK_INTERRUPTIBLE);
+		spin_unlock_irqrestore(&sd->sd_wlock, flags);
+
+		schedule_timeout(SCDRV_TIMEOUT);
+
+		remove_wait_queue(&sd->sd_wq, &wait);
+		if (signal_pending(current)) {
+			/* wait was interrupted */
 			return -ERESTARTSYS;
 		}

-		/* sd->sd_wlock was unlocked by scdrv_wait(), above */
 		spin_lock_irqsave(&sd->sd_wlock, flags);
 		status = write_status_check(sd, count);
 	}
@@ -418,26 +304,12 @@ scdrv_write(struct file *file, const cha
 	 * "chunk" as requested)
 	 */
 	if ((status >= 0) && (status < count)) {
-		DPRINTF("Didn't accept the full chunk; %d of %d\n",
-			status, (int) count);
+		pr_debug("Didn't accept the full chunk; %d of %d\n",
+			 status, (int) count);
 	}
 	return status;
 }

-static inline void
-scdrv_lock_all(struct subch_data_s *sd, unsigned long *flags)
-{
-	spin_lock_irqsave(&sd->sd_rlock, *flags);
-	spin_lock(&sd->sd_wlock);
-}
-
-static inline void
-scdrv_unlock_all(struct subch_data_s *sd, unsigned long flags)
-{
-	spin_unlock(&sd->sd_wlock);
-	spin_unlock_irqrestore(&sd->sd_rlock, flags);
-}
-
 static unsigned int
 scdrv_poll(struct file *file, struct poll_table_struct *wait)
 {
@@ -449,9 +321,11 @@ scdrv_poll(struct file *file, struct pol
 	poll_wait(file, &sd->sd_rq, wait);
 	poll_wait(file, &sd->sd_wq, wait);

-	scdrv_lock_all(sd, &flags);
+	spin_lock_irqsave(&sd->sd_rlock, flags);
+	spin_lock(&sd->sd_wlock);
 	status = ia64_sn_irtr_intr(sd->sd_nasid, sd->sd_subch);
-	scdrv_unlock_all(sd, flags);
+	spin_unlock(&sd->sd_wlock);
+	spin_unlock_irqrestore(&sd->sd_rlock, flags);

 	if (status > 0) {
 		if (status & SAL_IROUTER_INTR_RECV) {
@@ -465,29 +339,112 @@ scdrv_poll(struct file *file, struct pol
 	return mask;
 }

-static irqreturn_t
-scdrv_interrupt(int irq, void *subch_data, struct pt_regs *regs)
+static struct file_operations scdrv_fops = {
+	.owner =	THIS_MODULE,
+	.read =		scdrv_read,
+	.write =	scdrv_write,
+	.poll =		scdrv_poll,
+	.open =		scdrv_open,
+	.release =	scdrv_release,
+};
+
+/*
+ * scdrv_init
+ *
+ * Called at boot time to initialize the system controller communication
+ * facility.
+ */
+int __init
+scdrv_init(void)
 {
-	struct subch_data_s *sd = (struct subch_data_s *) subch_data;
-	unsigned long flags;
-	int status;
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

-	scdrv_lock_all(sd, &flags);
-	status = ia64_sn_irtr_intr(sd->sd_nasid, sd->sd_subch);
+	if (alloc_chrdev_region(&first_dev, 0, (MAX_SLABS*nummodules),
+				SYSCTL_BASENAME) < 0) {
+		printk("%s: failed to register SN system controller device\n",
+		       __FUNCTION__);
+		return -ENODEV;
+	}
+	snsc_class = class_simple_create(THIS_MODULE, SYSCTL_BASENAME);

-	if (status > 0) {
-		if (status & SAL_IROUTER_INTR_RECV) {
-			wake_up_all(&sd->sd_rq);
-		}
-		if (status & SAL_IROUTER_INTR_XMIT) {
-			ia64_sn_irtr_intr_disable
-			    (sd->sd_nasid, sd->sd_subch,
-			     SAL_IROUTER_INTR_XMIT);
-			wake_up_all(&sd->sd_wq);
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
+			scd = kmalloc(sizeof (struct sysctl_data_s),
+				      GFP_KERNEL);
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
 		}
 	}
-	scdrv_unlock_all(sd, flags);
-	return IRQ_HANDLED;
+	return 0;
 }

 module_init(scdrv_init);
