Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbTENJ47 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 05:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbTENJ47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 05:56:59 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:33991 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261798AbTENJ40 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 05:56:26 -0400
Date: Wed, 14 May 2003 12:09:14 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] blk-aam, automatic acoustic management
Message-ID: <20030514100914.GF17033@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I posted an alpha copy of this patch some time ago, here's a more
polished and extended version. Basically, it allows a disk to be in
three states:

- idle. for ide, this is implemented as a spin down of the disk.
- quiet. slower seeks, more quiet, consumes less power.
- fast. faster seeks, more loud, consumes more power.

Transition between these three states is controlled by how much io the
disk is doing, and for how long. The disk starts in low power mode, an
io rate of 'high_mark' ios/sec over a period of 'high_cycle' or more
sets it into fast mode. 'low_mark' ios/sec or less over a period of
'low_cycle' or more sets the disk back to quiet mode. Zero ios over a
period of 'idle_cycle' spins the disk down.

Everything is in /proc/aam/hdX:

axboe@apu:/home/axboe $ ls /proc/aam/hda/
enabled     high_mark   low_cycle  status
high_cycle  idle_cycle  low_mark   verbose

enabled
	whether it's enabled or not. default: on
verbose
	whether transition between the 3 states should generate a log
	message. ala:

hda: iorate=149, switching to fast operation
...
hda: iorate=13, switching to quiet operation
...
hda: switching to spin down
hda: spun up by activity (bash)

status
	current status in (sample_time ios/sec mode) format

root@apu:/proc/aam/hda # cat status
14460 0 low

Goes well with the laptop mode patch posted before. It's a bit of an
experiement, so.... The code itself is solid, though. Patch is against
2.4.21-rc2 (with laptop mode applied).

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux 2.4 for PowerPC
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.877   -> 1.878  
#	drivers/block/Config.in	1.6     -> 1.7    
#	drivers/ide/ide-probe.c	1.28    -> 1.29   
#	include/linux/blkdev.h	1.24    -> 1.25   
#	drivers/ide/ide-disk.c	1.18    -> 1.19   
#	drivers/block/ll_rw_blk.c	1.42    -> 1.43   
#	Documentation/Configure.help	1.124   -> 1.125  
#	drivers/ide/ide-io.c	1.4     -> 1.5    
#	drivers/block/Makefile	1.5     -> 1.6    
#	               (new)	        -> 1.1     drivers/block/blk-aam.c
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/14	axboe@apu.(none)	1.878
# Automatic acoustic management
# --------------------------------------------
#
diff -Nru a/Documentation/Configure.help b/Documentation/Configure.help
--- a/Documentation/Configure.help	Wed May 14 12:02:39 2003
+++ b/Documentation/Configure.help	Wed May 14 12:02:39 2003
@@ -561,6 +561,28 @@
 
   If unsure, say N.
 
+Automatic acoustic management
+CONFIG_BLK_AAM
+  If you say yes here, the kernel can manage the acoustic level of your
+  drives. Currently only IDE drives are supported. If the rate of IO
+  rises above the specificed level, the drive is switched to fast (or
+  louder) mode. Drive is switched back to slow (or quiet) mode if the
+  IO rate drops below the specified level. See
+
+	/proc/aam/hdX/
+
+  for the tuning knobs.
+
+  This will work on any IDE drive that supports acoustic management, however
+  the primary target is power consumption on laptops. The lower acoustic
+  level is just an added bonus. Seeks are typically 20% faster in loud mode
+  than in quiet mode.
+
+  Selecting this option is safe on drives that don't support acoustic
+  management, it just won't do anything.
+
+  Say Y on a laptop or quiet work station kernel.
+
 Per partition statistics in /proc/partitions
 CONFIG_BLK_STATS
   If you say yes here, your kernel will keep statistical information
diff -Nru a/drivers/block/Config.in b/drivers/block/Config.in
--- a/drivers/block/Config.in	Wed May 14 12:02:38 2003
+++ b/drivers/block/Config.in	Wed May 14 12:02:38 2003
@@ -48,6 +48,8 @@
 fi
 dep_bool '  Initial RAM disk (initrd) support' CONFIG_BLK_DEV_INITRD $CONFIG_BLK_DEV_RAM
 
+bool 'Automatic acoustic management' CONFIG_BLK_AAM
+
 bool 'Per partition statistics in /proc/partitions' CONFIG_BLK_STATS
 
 endmenu
diff -Nru a/drivers/block/Makefile b/drivers/block/Makefile
--- a/drivers/block/Makefile	Wed May 14 12:02:39 2003
+++ b/drivers/block/Makefile	Wed May 14 12:02:39 2003
@@ -10,7 +10,7 @@
 
 O_TARGET := block.o
 
-export-objs	:= ll_rw_blk.o blkpg.o loop.o DAC960.o genhd.o acsi.o
+export-objs	:= ll_rw_blk.o blkpg.o loop.o DAC960.o genhd.o acsi.o blk-aam.o
 
 obj-y	:= ll_rw_blk.o blkpg.o genhd.o elevator.o
 
@@ -31,6 +31,7 @@
 obj-$(CONFIG_BLK_DEV_DAC960)	+= DAC960.o
 obj-$(CONFIG_BLK_DEV_UMEM)	+= umem.o
 obj-$(CONFIG_BLK_DEV_NBD)	+= nbd.o
+obj-$(CONFIG_BLK_AAM)		+= blk-aam.o
 
 subdir-$(CONFIG_PARIDE) += paride
 
diff -Nru a/drivers/block/blk-aam.c b/drivers/block/blk-aam.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/block/blk-aam.c	Wed May 14 12:02:39 2003
@@ -0,0 +1,478 @@
+/*
+ * linux/drivers/block/blk-aam.c
+ *
+ * Automatic acoustic and power management accounting for block drivers
+ *
+ * Copyright (C) 2003 Jens Axboe <axboe@suse.de>
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/proc_fs.h>
+#include <linux/blkdev.h>
+
+#include <asm/uaccess.h>
+
+#define blk_start_sample(p)	do {	\
+	(p)->sample_start = jiffies;	\
+	(p)->sample_ios = 0;		\
+} while (0);
+
+inline void blk_acct_activity(request_queue_t *q, struct blk_power *p)
+{
+	p->last_activity = jiffies;
+
+	/*
+	 * activity forces a transition from idle to low
+	 */
+	if (p->power_state == BLK_POWER_IDLE) {
+		p->power_state = BLK_POWER_LOW;
+		if (p->verbose)
+			printk("%s: spun up by activity (%s)\n", q->name, current->comm);
+	}
+
+	/*
+	 * start a new sample
+	 */
+	if (p->sample_ios == -1)
+		blk_start_sample(p);
+
+	p->sample_ios++;
+}
+
+void blk_power_acct(request_queue_t *q)
+{
+	struct blk_power *p = q->power;
+	int iorate;
+
+	if (!p || !p->enabled)
+		return;
+
+	blk_acct_activity(q, p);
+
+	/*
+	 * already going full speed
+	 */
+	if (p->power_state == BLK_POWER_HIGH)
+		goto out_timer;
+
+	/*
+	 * haven't sampled for long enough
+	 */
+	if (time_before(jiffies, p->sample_start + p->high_cycle))
+		goto out_timer;
+
+	/*
+	 * we have a sample, check if we need to change
+	 */
+	iorate = (p->sample_ios * HZ) / (jiffies - p->sample_start);
+	if (iorate >= p->high_mark) {
+		if (p->verbose)
+			printk("%s: iorate=%d, switching to fast operation\n", q->name, iorate);
+		p->power_state = BLK_POWER_HIGH;
+		p->power_change = 1;
+		schedule_task(&p->power_task);
+	}
+
+	blk_start_sample(p);
+	return;
+out_timer:
+	mod_timer(&p->power_timer, jiffies + HZ);
+}
+
+/*
+ * task context for switching to lower power state
+ */
+static void blk_power_task(void *data)
+{
+	request_queue_t *q = data;
+	struct blk_power *p = q->power;
+
+	/*
+	 * never there, or perhaps cancelled
+	 */
+	if (!p->power_change)
+		return;
+
+	p->power_change = 0;
+	p->power_fn(q);
+
+	/*
+	 * arm power-down timer
+	 */
+	if (p->power_state != BLK_POWER_IDLE)
+		mod_timer(&p->power_timer, jiffies + HZ);
+
+	blk_start_sample(p);
+}
+
+/*
+ * checks whether it's time to set low or idle power mode
+ */
+static void blk_power_timer(unsigned long data)
+{
+	request_queue_t *q = (request_queue_t *) data;
+	struct blk_power *p = q->power;
+	int iorate;
+
+	/*
+	 * haven't sampled for long enough
+	 */
+	if (time_before(jiffies, p->sample_start + p->low_cycle))
+		goto out_timer;
+
+	/*
+	 * we have a sample, check if we need to change
+	 */
+	iorate = (p->sample_ios * HZ) / (jiffies - p->sample_start);
+	if (iorate > p->low_mark)
+		goto clear_sample;
+
+	/*
+	 *  we may drop to low power mode
+	 */
+	if (p->verbose && p->power_state != BLK_POWER_LOW) {
+		printk("%s: iorate=%d, switching to quiet operation\n", q->name, iorate);
+	}
+
+	p->power_change = 1;
+	p->power_state = BLK_POWER_LOW;
+
+	if (!time_before(jiffies, p->last_activity + p->idle_cycle)) {
+		if (!p->sample_ios) {
+			if (p->verbose)
+				printk("%s: switching to spin down\n", q->name);
+
+			p->power_state = BLK_POWER_IDLE;
+		}
+	}
+
+	schedule_task(&p->power_task);
+	return;
+clear_sample:
+	blk_start_sample(p);
+out_timer:
+	mod_timer(&p->power_timer, jiffies + HZ);
+}
+
+static int blk_aam_proc_status_read(char *page, char **start, off_t off,
+				    int count, int *eof, void *data)
+{
+	request_queue_t *q = data;
+	struct blk_power *p = q->power;
+	unsigned long elapsed = 0;
+	int iorate = 0;
+	char *ptr = page;
+
+	if (jiffies != p->sample_start) {
+		elapsed = ((jiffies - p->sample_start) * 1000) / HZ;
+		iorate = (p->sample_ios * HZ) / (jiffies - p->sample_start);
+	}
+
+	ptr += sprintf(ptr, "%lu %u ", elapsed, iorate);
+	if (p->power_state == BLK_POWER_HIGH)
+		ptr += sprintf(ptr, "high\n");
+	else if (p->power_state == BLK_POWER_LOW)
+		ptr += sprintf(ptr, "low\n");
+	else
+		ptr += sprintf(ptr, "idle\n");
+
+	return ptr - page;
+}
+
+static int blk_aam_proc_enabled_read(char *page, char **start, off_t off,
+				     int count, int *eof, void *data)
+{
+	request_queue_t *q = data;
+	struct blk_power *p = q->power;
+	char *ptr = page;
+
+	ptr += sprintf(ptr, "%d\n", p->enabled);
+	return ptr - page;
+}
+
+static int blk_aam_proc_verbose_read(char *page, char **start, off_t off,
+				     int count, int *eof, void *data)
+{
+	request_queue_t *q = data;
+	struct blk_power *p = q->power;
+	char *ptr = page;
+
+	ptr += sprintf(ptr, "%d\n", p->verbose);
+	return ptr - page;
+}
+
+static int blk_aam_proc_lm_read(char *page, char **start, off_t off,
+				int count, int *eof, void *data)
+{
+	request_queue_t *q = data;
+	struct blk_power *p = q->power;
+	char *ptr = page;
+
+	ptr += sprintf(ptr, "%d\n", p->low_mark);
+	return ptr - page;
+}
+
+static int blk_aam_proc_hm_read(char *page, char **start, off_t off,
+				int count, int *eof, void *data)
+{
+	request_queue_t *q = data;
+	struct blk_power *p = q->power;
+	char *ptr = page;
+
+	ptr += sprintf(ptr, "%d\n", p->high_mark);
+	return ptr - page;
+}
+
+static int blk_aam_proc_lc_read(char *page, char **start, off_t off,
+				int count, int *eof, void *data)
+{
+	request_queue_t *q = data;
+	struct blk_power *p = q->power;
+	char *ptr = page;
+
+	ptr += sprintf(ptr, "%d\n", p->low_cycle);
+	return ptr - page;
+}
+
+static int blk_aam_proc_hc_read(char *page, char **start, off_t off,
+				int count, int *eof, void *data)
+{
+	request_queue_t *q = data;
+	struct blk_power *p = q->power;
+	char *ptr = page;
+
+	ptr += sprintf(ptr, "%d\n", p->high_cycle);
+	return ptr - page;
+}
+
+static int blk_aam_proc_idle_read(char *page, char **start, off_t off,
+				  int count, int *eof, void *data)
+{
+	request_queue_t *q = data;
+	struct blk_power *p = q->power;
+	char *ptr = page;
+
+	ptr += sprintf(ptr, "%d\n", p->idle_cycle);
+	return ptr - page;
+}
+
+static int blk_aam_proc_write(const char *buf, unsigned long count,
+			      unsigned int *val)
+{
+	char tmp[33];
+
+	if (!count)
+		return -EINVAL;
+	if (count > 32)
+		count = 32;
+	if (copy_from_user(tmp, buf, count))
+		return -EFAULT;
+
+	*val = simple_strtoul(tmp, NULL, 0);
+	return 0;
+}
+
+static int blk_aam_proc_enabled_write(struct file *file, const char *buf,
+				      unsigned long count, void *data)
+{
+	request_queue_t *q = data;
+	struct blk_power *p = q->power;
+	unsigned int val;
+	int ret;
+
+	if ((ret = blk_aam_proc_write(buf, count, &val)) < 0)
+		return ret;
+
+	p->enabled = !!val;
+	return count;
+}
+
+static int blk_aam_proc_verbose_write(struct file *file, const char *buf,
+				      unsigned long count, void *data)
+{
+	request_queue_t *q = data;
+	struct blk_power *p = q->power;
+	unsigned int val;
+	int ret;
+
+	if ((ret = blk_aam_proc_write(buf, count, &val)) < 0)
+		return ret;
+
+	p->verbose = !!val;
+	return count;
+}
+
+static int blk_aam_proc_lm_write(struct file *file, const char *buf,
+				 unsigned long count, void *data)
+{
+	request_queue_t *q = data;
+	struct blk_power *p = q->power;
+	int ret;
+
+	if ((ret = blk_aam_proc_write(buf, count, &p->low_mark)) < 0)
+		return ret;
+
+	return count;
+}
+
+static int blk_aam_proc_lc_write(struct file *file, const char *buf,
+				 unsigned long count, void *data)
+{
+	request_queue_t *q = data;
+	struct blk_power *p = q->power;
+	int ret;
+
+	if ((ret = blk_aam_proc_write(buf, count, &p->low_cycle)) < 0)
+		return ret;
+
+	return count;
+}
+
+static int blk_aam_proc_hc_write(struct file *file, const char *buf,
+				 unsigned long count, void *data)
+{
+	request_queue_t *q = data;
+	struct blk_power *p = q->power;
+	int ret;
+
+	if ((ret = blk_aam_proc_write(buf, count, &p->high_cycle)) < 0)
+		return ret;
+
+	return count;
+}
+
+static int blk_aam_proc_hm_write(struct file *file, const char *buf,
+				 unsigned long count, void *data)
+{
+	request_queue_t *q = data;
+	struct blk_power *p = q->power;
+	int ret;
+
+	if ((ret = blk_aam_proc_write(buf, count, &p->high_mark)) < 0)
+		return ret;
+
+	return count;
+}
+
+static int blk_aam_proc_idle_write(struct file *file, const char *buf,
+				   unsigned long count, void *data)
+{
+	request_queue_t *q = data;
+	struct blk_power *p = q->power;
+	int ret;
+
+	if ((ret = blk_aam_proc_write(buf, count, &p->idle_cycle)) < 0)
+		return ret;
+
+	return count;
+}
+
+/*
+ * driver must have set the name with blk_queue_set_name first
+ */
+int blk_set_power_fn(request_queue_t *q, power_fn *pfn)
+{
+	struct blk_power *p;
+	char tmp[32];
+
+	if (q->name[0] == 0) {
+		printk("%s: must set name first\n", __FUNCTION__);
+		return -ENXIO;
+	}
+
+	p = kmalloc(sizeof(struct blk_power), GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	q->power = p;
+	p->enabled		= 1;
+	p->verbose		= 0;
+	p->power_fn		= pfn;
+	p->power_state		= BLK_POWER_LOW;
+	p->power_change		= 0;
+	p->power_timer.data	= (unsigned long) q;
+	p->power_timer.function	= blk_power_timer;
+	init_timer(&p->power_timer);
+	blk_start_sample(p);
+	INIT_TQUEUE(&p->power_task, blk_power_task, q);
+
+	p->low_mark		= BLK_POWER_LOW_MARK;
+	p->high_mark		= BLK_POWER_HIGH_MARK;
+	p->low_cycle		= BLK_POWER_LOW_CYCLE;
+	p->high_cycle		= BLK_POWER_HIGH_CYCLE;
+	p->idle_cycle		= BLK_POWER_IDLE_CYCLE;
+
+	sprintf(tmp, "aam/%s", q->name);
+	q->proc = proc_mkdir(tmp, 0);
+
+	p->p_enabled = create_proc_entry("enabled", 0644, q->proc);
+	if (p->p_enabled) {
+		p->p_enabled->nlink = 1;
+		p->p_enabled->read_proc = blk_aam_proc_enabled_read;
+		p->p_enabled->write_proc = blk_aam_proc_enabled_write;
+		p->p_enabled->data = q;
+	}
+
+	p->p_verbose = create_proc_entry("verbose", 0644, q->proc);
+	if (p->p_verbose) {
+		p->p_verbose->nlink = 1;
+		p->p_verbose->read_proc = blk_aam_proc_verbose_read;
+		p->p_verbose->write_proc = blk_aam_proc_verbose_write;
+		p->p_verbose->data = q;
+	}
+
+	p->p_low_mark = create_proc_entry("low_mark", 0644, q->proc);
+	if (p->p_low_mark) {
+		p->p_low_mark->nlink = 1;
+		p->p_low_mark->read_proc = blk_aam_proc_lm_read;
+		p->p_low_mark->write_proc = blk_aam_proc_lm_write;
+		p->p_low_mark->data = q;
+	}
+
+	p->p_high_mark = create_proc_entry("high_mark", 0644, q->proc);
+	if (p->p_high_mark) {
+		p->p_high_mark->nlink = 1;
+		p->p_high_mark->read_proc = blk_aam_proc_hm_read;
+		p->p_high_mark->write_proc = blk_aam_proc_hm_write;
+		p->p_high_mark->data = q;
+	}
+
+	p->p_low_cycle = create_proc_entry("low_cycle", 0644, q->proc);
+	if (p->p_low_cycle) {
+		p->p_low_cycle->nlink = 1;
+		p->p_low_cycle->read_proc = blk_aam_proc_lc_read;
+		p->p_low_cycle->write_proc = blk_aam_proc_lc_write;
+		p->p_low_cycle->data = q;
+	}
+
+	p->p_high_cycle = create_proc_entry("high_cycle", 0644, q->proc);
+	if (p->p_high_cycle) {
+		p->p_high_cycle->nlink = 1;
+		p->p_high_cycle->read_proc = blk_aam_proc_hc_read;
+		p->p_high_cycle->write_proc = blk_aam_proc_hc_write;
+		p->p_high_cycle->data = q;
+	}
+	p->p_idle_cycle = create_proc_entry("idle_cycle", 0644, q->proc);
+	if (p->p_idle_cycle) {
+		p->p_idle_cycle->nlink = 1;
+		p->p_idle_cycle->read_proc = blk_aam_proc_idle_read;
+		p->p_idle_cycle->write_proc = blk_aam_proc_idle_write;
+		p->p_idle_cycle->data = q;
+	}
+
+	p->p_status = create_proc_entry("status", 0444, q->proc);
+	if (p->p_status) {
+		p->p_status->nlink = 1;
+		p->p_status->read_proc = blk_aam_proc_status_read;
+		p->p_status->data = q;
+	}
+
+	return 0;
+}
+
+EXPORT_SYMBOL(blk_set_power_fn);
+
diff -Nru a/drivers/block/ll_rw_blk.c b/drivers/block/ll_rw_blk.c
--- a/drivers/block/ll_rw_blk.c	Wed May 14 12:02:39 2003
+++ b/drivers/block/ll_rw_blk.c	Wed May 14 12:02:39 2003
@@ -31,6 +31,7 @@
 #include <linux/highmem.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/proc_fs.h>
 
 /*
  * MAC Floppy IWM hooks
@@ -125,6 +126,10 @@
 
 static struct timer_list writeback_timer;
 
+#ifdef CONFIG_BLK_AAM
+static struct proc_dir_entry *blk_aam_root;
+#endif
+
 static inline int get_max_sectors(kdev_t dev)
 {
 	if (!max_sectors[MAJOR(dev)])
@@ -379,6 +384,11 @@
 	spin_unlock_irqrestore(&io_request_lock, flags);
 }
 
+void blk_queue_set_name(request_queue_t *q, const char *name)
+{
+	strncpy(q->name, name, sizeof(q->name));
+}
+
 /** blk_grow_request_list
  *  @q: The &request_queue_t
  *  @nr_requests: how many requests are desired
@@ -495,6 +505,10 @@
 	q->plug_tq.routine	= &generic_unplug_device;
 	q->plug_tq.data		= q;
 	q->plugged        	= 0;
+	q->power		= NULL;
+	q->proc			= NULL;
+	memset(q->name, 0, sizeof(q->name));
+
 	/*
 	 * These booleans describe the queue properties.  We set the
 	 * default (and most common) values here.  Other drivers can
@@ -804,6 +818,8 @@
 {
 	drive_stat_acct(req->rq_dev, req->cmd, req->nr_sectors, 1);
 
+	blk_power_acct(q);
+
 	if (!q->plugged && q->head_active && insert_here == &q->queue_head) {
 		spin_unlock_irq(&io_request_lock);
 		BUG();
@@ -1427,6 +1443,10 @@
 	init_timer(&writeback_timer);
 	writeback_timer.function = blk_writeback_timer;
 
+#ifdef CONFIG_BLK_AAM
+	blk_aam_root = proc_mkdir("aam", 0);
+#endif
+
 #ifdef CONFIG_AMIGA_Z2RAM
 	z2_init();
 #endif
@@ -1542,3 +1562,4 @@
 EXPORT_SYMBOL(blk_max_pfn);
 EXPORT_SYMBOL(blk_seg_merge_ok);
 EXPORT_SYMBOL(blk_nohighio);
+EXPORT_SYMBOL(blk_queue_set_name);
diff -Nru a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c	Wed May 14 12:02:39 2003
+++ b/drivers/ide/ide-disk.c	Wed May 14 12:02:39 2003
@@ -1552,6 +1552,24 @@
 	return 0;
 }
 
+static void idedisk_power_fn(request_queue_t *q)
+{
+	ide_drive_t *drive = q->queuedata;
+	struct blk_power *p = q->power;
+
+	switch (p->power_state) {
+		case BLK_POWER_HIGH:
+			set_acoustic(drive, 0xfe);
+			break;
+		case BLK_POWER_LOW:
+			set_acoustic(drive, 0x80);
+			break;
+		case BLK_POWER_IDLE:
+			do_idedisk_standby(drive);
+			break;
+	}
+}
+
 static int probe_lba_addressing (ide_drive_t *drive, int arg)
 {
 	drive->addressing =  0;
@@ -1734,6 +1752,12 @@
 	drive->no_io_32bit = id->dword_io ? 1 : 0;
 	if (drive->id->cfs_enable_2 & 0x3000)
 		write_cache(drive, (id->cfs_enable_2 & 0x3000));
+
+	/*
+	 * acoustic management supported
+	 */
+	if ((id->command_set_2 & 0x200) && (id->cfs_enable_2 & 0x200))
+		blk_set_power_fn(&drive->queue, idedisk_power_fn);
 }
 
 static int idedisk_cleanup(ide_drive_t *drive)
diff -Nru a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
--- a/drivers/ide/ide-io.c	Wed May 14 12:02:39 2003
+++ b/drivers/ide/ide-io.c	Wed May 14 12:02:39 2003
@@ -893,7 +893,9 @@
  */
 void do_ide_request(request_queue_t *q)
 {
-	ide_do_request(q->queuedata, IDE_NO_IRQ);
+	ide_drive_t *drive = q->queuedata;
+
+	ide_do_request(HWGROUP(drive), IDE_NO_IRQ);
 }
 
 /*
diff -Nru a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c	Wed May 14 12:02:39 2003
+++ b/drivers/ide/ide-probe.c	Wed May 14 12:02:39 2003
@@ -970,8 +970,10 @@
 {
 	request_queue_t *q = &drive->queue;
 
-	q->queuedata = HWGROUP(drive);
 	blk_init_queue(q, do_ide_request);
+	q->queuedata = drive;
+
+	blk_queue_set_name(q, drive->name);
 }
 
 #undef __IRQ_HELL_SPIN
diff -Nru a/include/linux/blkdev.h b/include/linux/blkdev.h
--- a/include/linux/blkdev.h	Wed May 14 12:02:39 2003
+++ b/include/linux/blkdev.h	Wed May 14 12:02:39 2003
@@ -7,6 +7,7 @@
 #include <linux/tqueue.h>
 #include <linux/list.h>
 #include <linux/mm.h>
+#include <linux/sysctl.h>
 
 #include <asm/io.h>
 
@@ -63,6 +64,7 @@
 typedef int (make_request_fn) (request_queue_t *q, int rw, struct buffer_head *bh);
 typedef void (plug_device_fn) (request_queue_t *q, kdev_t device);
 typedef void (unplug_device_fn) (void *q);
+typedef void (power_fn) (request_queue_t *);
 
 /*
  * Default nr free requests per queue, ll_rw_blk will scale it down
@@ -75,6 +77,54 @@
 	struct list_head free;
 };
 
+enum blk_power_state {
+	BLK_POWER_IDLE = 1,
+	BLK_POWER_LOW,
+	BLK_POWER_HIGH,
+};
+
+struct blk_power {
+	power_fn		*power_fn;
+
+	char			power_state;
+	char			power_change;
+	char			verbose;
+	char			enabled;
+
+	struct timer_list	power_timer;
+	struct tq_struct	power_task;
+
+	unsigned long		sample_start;
+	unsigned int		sample_ios;
+
+	unsigned long		last_activity;
+
+	/*
+	 * settings
+	 */
+	unsigned int		low_mark;
+	unsigned int		high_mark;
+	unsigned int		low_cycle;
+	unsigned int		high_cycle;
+	unsigned int		idle_cycle;
+
+	struct proc_dir_entry	*p_enabled;
+	struct proc_dir_entry	*p_verbose;
+	struct proc_dir_entry	*p_status;
+	struct proc_dir_entry	*p_low_mark;
+	struct proc_dir_entry	*p_low_cycle;
+	struct proc_dir_entry	*p_high_mark;
+	struct proc_dir_entry	*p_high_cycle;
+	struct proc_dir_entry	*p_idle_cycle;
+};
+
+#define BLK_POWER_LOW_MARK	(25)
+#define BLK_POWER_HIGH_MARK	(50)
+
+#define BLK_POWER_HIGH_CYCLE	(3 * HZ)
+#define BLK_POWER_LOW_CYCLE	(30 * HZ)
+#define BLK_POWER_IDLE_CYCLE	(60 * HZ)
+
 struct request_queue
 {
 	/*
@@ -97,6 +147,8 @@
 	 */
 	struct list_head	queue_head;
 	elevator_t		elevator;
+	char			name[8];
+	struct proc_dir_entry	*proc;
 
 	request_fn_proc		* request_fn;
 	merge_request_fn	* back_merge_fn;
@@ -104,6 +156,12 @@
 	merge_requests_fn	* merge_requests_fn;
 	make_request_fn		* make_request_fn;
 	plug_device_fn		* plug_device_fn;
+
+	/*
+	 * power management stuff
+	 */
+	struct blk_power	*power;
+
 	/*
 	 * The queue owner gets to use this for whatever they like.
 	 * ll_rw_blk doesn't touch it.
@@ -228,6 +286,17 @@
 extern void blk_queue_make_request(request_queue_t *, make_request_fn *);
 extern void generic_unplug_device(void *);
 extern inline int blk_seg_merge_ok(struct buffer_head *, struct buffer_head *);
+extern void blk_queue_set_name(request_queue_t *, const char *);
+#ifdef CONFIG_BLK_AAM
+extern int blk_set_power_fn(request_queue_t *, power_fn *);
+extern void blk_power_acct(request_queue_t *);
+#else
+static inline int blk_set_power_fn(request_queue_t *q, power_fn *pfn)
+{
+	return 0;
+}
+#define blk_power_acct(q)	do { } while (0)
+#endif
 
 extern int * blk_size[MAX_BLKDEV];
 

-- 
Jens Axboe

