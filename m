Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267199AbUHYMLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267199AbUHYMLt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 08:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267237AbUHYMLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 08:11:49 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:715 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S267199AbUHYMJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 08:09:53 -0400
Date: Wed, 25 Aug 2004 13:53:18 +0200
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ELSA updated for kernel 2.6.8.1
Message-ID: <20040825115318.GA2721@frec.bull.fr>
Mime-Version: 1.0
User-Agent: Mutt/1.5.6+20040722i
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 25/08/2004 13:58:35,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 25/08/2004 13:58:47,
	Serialize complete at 25/08/2004 13:58:47
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

  Here is the Enhanced Linux System Accounting patch for 
kernel 2.6.8.1. This is the second announce because in the 
previous one we didn't attach the patch and we didn't explain 
what changes have been done. Sorry for the troubles.

  This patch provides structures and functions to do accounting for a
group of process. There is two parts. On one hand there is two APIs
that allow the creation and the destruction of an item called a "bank"
that will contain a group of processes. There is also two other 
routines that can add or remove processes in a bank. On the other hand,
you have the accounting mechanism that used bank to perform BSD-like 
accounting for a group of process. We used ioctl() interface to 
create/destroy a bank and also to add/remove a process in a bank. 
Currently, device driver is dev/elsacct and the major number is 
dynamically allocated, therefore you need to check the number in the 
/proc/devices and create the corresponding device.

  The next step is to provide more accounting metrics. Therefore we are
working on the improvement of BSD accounting as ELSA accounting is 
based on it. We currently trying to get informations about IO as fields
are already present in BSD-like accounting but they are not updated.

  Changelog:
      24/08/2004 - Guillaume
      This patch is just a port for the kernel 2.6.8.1 so there are 
      only minor changes that are relative to warning produce when 
      applying the previous patch. 
     
Chears,
Guillaume
 
Signed-off-by: Guillaume Thouvenin <guillaume.thouvenin@bull.net>

--------------------------------------
diff -uprN -X dontdiff linux-2.6.8.1-vanilla/drivers/elsacct/bank.c linux-2.6.8.1-elsa/drivers/elsacct/bank.c
--- linux-2.6.8.1-vanilla/drivers/elsacct/bank.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.8.1-elsa/drivers/elsacct/bank.c	2004-08-23 09:38:34.371517320 +0200
@@ -0,0 +1,434 @@
+/*
+ *  driver/elsacct/bank.c
+ * 
+ *  ELSA - Enhanced Linux System Accounting
+ *  Guillaume Thouvenin - 26/04/2004
+ *
+ *  This file implements Enhanced Linux System Accounting. It 
+ *  provides structure and functions to manipulate "BANK". 
+ *
+ * 
+ *  This code is licenced under GPL.
+ */
+
+#include <linux/slab.h>
+#include <linux/mm.h>
+#include <linux/sched.h>
+#include <linux/errno.h>
+#include <linux/module.h>
+
+#include <linux/bank.h>
+
+#include <asm/bug.h>
+
+ /*********************************************
+ * structures and macros used to manage banks *
+ *********************************************/
+
+#ifdef CONFIG_BANK_DEBUG
+#define dprintk(format...) printk(format)
+#else
+#define dprintk(format...)
+#endif
+
+#define ELSACCT_MIN_PID	1024	/* cannot add process if pid < ELSACCT_MIN_PID */
+
+/* Functions used internally */
+static int elsa_process_present(struct task_struct *p,
+				struct elsa_bank *b);
+
+ /********************************************************************
+ * Following functions can be use by a module (=> they are exported) *
+ ********************************************************************/
+
+/**
+ * elsa_bank_alloc - Allocates a new bank
+ *
+ * Description: allocates a new bank and returns the new created bank.
+ **/
+struct elsa_bank *elsa_bank_alloc(void)
+{
+	struct elsa_bank *b;
+
+	/* allocate space for the new bank */
+	b = (struct elsa_bank *) kmalloc(sizeof(struct elsa_bank),
+					 GFP_KERNEL);
+	if (!b) {
+		printk("elsa_bank_alloc: cannot allocate space\n");
+		return NULL;
+	}
+
+	/* Initialize fields */
+	b->info = NULL;
+	b->callback = NULL;
+	INIT_LIST_HEAD(&(b->data_head));
+
+	return b;
+}
+
+/**
+ * elsa_bank_free - Frees space occupied by a bank.
+ * @bank: a pointer to the bank to delete
+ * 
+ * Description: Free space used by bank
+ **/
+void elsa_bank_free(struct elsa_bank *b)
+{
+	/* 
+	 * Before releasing kernel memory occupied by the bank
+	 * we can do some action. We do it here instead of 
+	 * elsa_bank_remove() because elsa_bank_remove() is
+	 * called in a spinlock and the callback write records into
+	 * a file (and so cannot be done in a spinlock)
+	 */
+	if (b->callback) {
+		(b->callback) (ELSA_BANK_CALLBACK, b, NULL);
+	}
+
+	dprintk("elsa_bank_free: bank released\n");
+	kfree(b);
+}
+
+/**
+ * elsa_bank_add - Add a new bank to a bank's root
+ * @br: a pointer to bank's root
+ * @b: a pointer to a bank
+ * @fn: pointer to a callback called when bank or data are destroyed
+ * @info: pointer that can be used to store information 
+ * 
+ * Description: Add a new bank in the bank_root. It associates a 
+ * callback to a bank. The callback will be called each time a bank
+ * or a data will be removed. pointer @info can be used to store 
+ * usefull informations at bank level. 
+ **/
+int elsa_bank_add(struct bank_root *br,
+		  struct elsa_bank *b,
+		  int (*fn) (int, struct elsa_bank *, struct elsa_data *),
+		  void *info)
+{
+	/* 
+	 * give it an id. As it must be unique. As this function is only 
+	 * called from ioctl (drivers/erlsacct/elsacct.c) which is protected
+	 * by a spinlock, we know that only one instance will be execute. 
+	 * Currently we only used next_bid field but this mechnism 
+	 * can give problems if we use many banks and the bid go through
+	 * its maximum  
+	 */
+	b->bid = br->next_bid++;
+
+	if (b->bid <= 0) {
+		printk("elsa_bank_alloc: can not find bank identifier\n");
+		return 0;
+	}
+
+	/* Initialize fields */
+	b->info = info;
+	b->callback = fn;
+
+	/* 
+	 * add the new bank to the list of banks 
+	 */
+	list_add(&(b->bank_list), &(br->bank_head));
+
+	dprintk("elsa_bank_alloc: bank #%d created\n", b->bid);
+
+	return b->bid;
+}
+
+/**
+ * elsa_bank_remove - remove a bank from the list of banks 
+ * @b: a pointer to a bank
+ * 
+ * Description: remove a bank from a bank_root and returns the 
+ * identifier of the removed bank. When this function is called 
+ * bank _MUST_ be empty.
+ * Here are different steps of the operation:
+ *   1) Write accounting information
+ *   2) Remove it from the list of banks
+ **/
+int elsa_bank_remove(struct elsa_bank *b)
+{
+	if (unlikely(b == NULL) || unlikely(!list_empty(&b->data_head)))
+		BUG();
+
+	/* 
+	 * remove bank from the bank's list
+	 */
+	list_del(&(b->bank_list));
+
+	dprintk("elsa_bank_remove: bank #%d removed\n", b->bid);
+
+	return b->bid;
+}
+
+/**
+ * elsa_data_alloc - Allocates a new data
+ * 
+ * Description: allocates a new data and returns the new 
+ * created item. If an error is encountered NULL is returned.
+ * Here are different steps of the operation:
+ *   1) Allocate space for the new data
+ *   2) Initialize different fields
+ **/
+struct elsa_data *elsa_data_alloc(void)
+{
+	static struct elsa_data *d;
+
+	/* allocate space for the new data */
+	d = (struct elsa_data *) kmalloc(sizeof(struct elsa_data),
+					 GFP_KERNEL);
+	if (!d) {
+		printk("elsa_data_alloc: cannot allocate space\n");
+		return NULL;
+	}
+
+	/* Initialize fields */
+	d->bid = 0;
+	d->process = NULL;
+	INIT_LIST_HEAD(&(d->data_list));
+	INIT_LIST_HEAD(&(d->bank_list));
+
+	return d;
+}
+
+/**
+ * elsa_data_free - Free data
+ * @d: pointer to data to be removed
+ * 
+ * Description: releases memory used by data. 
+ **/
+void elsa_data_free(struct elsa_data *d)
+{
+	dprintk("elsa_data_free: data released\n");
+	kfree(d);
+}
+
+/**
+ * elsa_data_add - Add a process to a given bank
+ * @b  : pointer to a bank 
+ * @p  : pointer to a process
+ *
+ * Description: add a data to a bank by setting lists. Other fields are unchanged
+ * If an error is encountered, a negative value is returned. It can not return 0.
+ * Here are steps to perform:
+ *   1) Check arguments
+ *   2) Check if process is already in the bank
+ *   3) Initialize its fields
+ *   4) Return BID
+ **/
+int elsa_data_add(struct elsa_bank *b, struct elsa_data *d)
+{
+	static int present;
+
+	if (!b || !d || !(d->process)) {
+		dprintk("elsa_data_add: Wrong parameters\n");
+		return -EINVAL;
+	}
+
+	/* Bank ID cannot be equal to 0 */
+	if (unlikely(b->bid == 0))
+		BUG();
+
+	if (d->process->pid < ELSACCT_MIN_PID) {
+		dprintk("elsa_data_add: PID < %d\n", ELSACCT_MIN_PID);
+		return -EINVAL;
+	}
+
+	/* check if process is already present */
+	present = elsa_process_present(d->process, b);
+	if (present) {
+		/* Process already in the bank, so we can not add it */
+		return -EPERM;
+	}
+
+	/* Set BID */
+	d->bid = b->bid;
+
+	/* Add data in the list of bank's data */
+	list_add(&(d->data_list), &(b->data_head));
+
+	/* 
+	 * Add data in the list of process's bank. We modify task struct so we 
+	 * need to protect that.
+	 */
+	write_lock_irq(&tasklist_lock);
+	list_add(&(d->bank_list), &(d->process->bank_head));
+	write_unlock_irq(&tasklist_lock);
+
+	dprintk("elsa_data_add: Add process #%d to bank #%d\n",
+		d->process->pid, b->bid);
+
+	return b->bid;
+}
+
+/**
+ * elsa_data_remove - Remove a process to a given bank
+ * @b: pointer to the bank
+ * @d: pointer to the process
+ *
+ * Description: removes a given process from a given bank. 
+ * Return 0 if succedeed, BID of the bank if it is empty and 
+ * negative value otherwise
+ **/
+int elsa_data_remove(struct elsa_bank *b, struct elsa_data *d)
+{
+
+	if (!d)
+		return -EINVAL;
+
+	if (unlikely(d->process->pid < ELSACCT_MIN_PID))
+		BUG();
+
+	/* callback, we are in the child so callback code */
+	if (b && b->callback) {
+		(b->callback) (ELSA_DATA_CALLBACK, b, d);
+	}
+
+	/* remove data from the list of data */
+	list_del(&d->data_list);
+
+	/* Need access to head_list in task_struct */
+	/* We are in a spin_lock */
+	write_lock_irq(&tasklist_lock);
+	list_del(&d->bank_list);
+	write_unlock_irq(&tasklist_lock);
+
+	if (list_empty(&(b->data_head)))
+		/* bank is empty so we return its BID */
+		return b->bid;
+
+	return 0;		/* sucess and bank isn't empty */
+}
+
+/**
+ * elsa_get_bank - Returns a pointer to a bank
+ * @br: pointer to the root of banks
+ * @bid: the identifier of a bank
+ * 
+ * Description: finds the bank with given ID in the list of banks
+ **/
+struct elsa_bank *elsa_get_bank(struct bank_root *br, __u32 bid)
+{
+	static struct list_head *entry;
+	static struct elsa_bank *b;
+
+	if (bid == 0)
+		return NULL;
+
+	/*
+	 * We traverse the list searching for entries without changing
+	 * the list itself, so we use read_lock_irqsave
+	 */
+	list_for_each(entry, &(br->bank_head)) {
+		b = list_entry(entry, struct elsa_bank, bank_list);
+		if (b->bid == bid) {
+			return b;
+		}
+	}
+
+	/* We don't find the bank with corresponding BID */
+	return NULL;
+}
+
+/**
+ * elsa_get_data - Returns a pointer to an &elsa_data
+ * @pid: The identifier of the process
+ * @bid: The identifier of a bank
+ * 
+ * Description: returns a pointer to the container of a given pid in a 
+ * given bank. If the data isn't found, NULL is returned.
+ **/
+struct elsa_data *elsa_get_data(pid_t pid, __u32 bid)
+{
+	static struct list_head *entry;	/* entry == NULL */
+	static struct task_struct *p;	/* p == NULL */
+	static struct elsa_data *d;	/* d == NULL */
+
+	read_lock(&tasklist_lock);
+	p = find_task_by_pid(pid);
+	read_unlock(&tasklist_lock);
+
+	if ((p == NULL) || (bid == 0))
+		return NULL;
+
+	list_for_each(entry, &(p->bank_head)) {
+		d = list_entry(entry, struct elsa_data, bank_list);
+		/*  bank can not be empty */
+		if (unlikely(d == NULL))
+			BUG();
+
+		if (d->bid == bid) {
+			/* Got it */
+			return d;
+		}
+	}
+
+	return NULL;
+}
+
+/**
+ * elsa_get_first - Returns a pointer to the first element of a list
+ * @head: a pointer to the head of a list
+ * 
+ * Description: returns a pointer to the first data in a list.
+ * If list is empty, NULL is returned.
+ **/
+//struct elsa_data *elsa_get_first_data(struct list_head *head)
+//{
+//      static struct list_head *entry; /* entry == NULL */
+//      static struct elsa_data *d;     /* data == NULL */
+//
+//      list_for_each(entry, head) {
+//              d = list_entry(entry, struct elsa_data, data_list);
+//              return d;
+//      }
+//
+//      return NULL;
+//}
+
+/* memory management */
+EXPORT_SYMBOL(elsa_bank_alloc);
+EXPORT_SYMBOL(elsa_bank_free);
+EXPORT_SYMBOL(elsa_data_alloc);
+EXPORT_SYMBOL(elsa_data_free);
+
+/* data manipulation */
+EXPORT_SYMBOL(elsa_bank_add);
+EXPORT_SYMBOL(elsa_bank_remove);
+EXPORT_SYMBOL(elsa_data_add);
+EXPORT_SYMBOL(elsa_data_remove);
+
+/* get informations */
+EXPORT_SYMBOL(elsa_get_bank);
+EXPORT_SYMBOL(elsa_get_data);
+
+ /*************************************************
+ * Following functions are only used in this file *
+ *************************************************/
+
+/**
+ * elsa_process_present - Returns 1 if process is in the bank
+ * @p: the process identifier to look for
+ * @b: the bank in which we must look
+ * 
+ * Description: returns 1 if process is present in a bank, 0 otherwise
+ **/
+static int elsa_process_present(struct task_struct *p, struct elsa_bank *b)
+{
+	static struct list_head *entry;
+	static struct elsa_data *d;
+
+	read_lock(&tasklist_lock);
+	list_for_each(entry, &(b->data_head)) {
+		d = list_entry(entry, struct elsa_data, data_list);
+		if (d->process == p) {
+			/* Found it */
+			read_unlock(&tasklist_lock);
+			return 1;
+		}
+	}
+	read_unlock(&tasklist_lock);
+
+	/* Process not found in b */
+	return 0;
+}
diff -uprN -X dontdiff linux-2.6.8.1-vanilla/drivers/elsacct/elsacct.c linux-2.6.8.1-elsa/drivers/elsacct/elsacct.c
--- linux-2.6.8.1-vanilla/drivers/elsacct/elsacct.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.8.1-elsa/drivers/elsacct/elsacct.c	2004-08-23 09:25:41.758972280 +0200
@@ -0,0 +1,827 @@
+/*
+ *  driver/elsacct/elsacct.c
+ * 
+ *  ELSA - Enhanced Linux System Accounting
+ *  Guillaume Thouvenin - 26/04/2004
+ *
+ *  This module implements Enhanced Linux System Accounting. 
+ *  We implement a character driver to transfer data between 
+ *  BANK that are in the kernel adress space and the user 
+ *  adress space. 
+ *
+ *  This code is licenced under GPL.
+ */
+
+#include <linux/module.h>
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/blkdev.h>
+#include <linux/times.h>
+
+#include <linux/elsacct.h>
+#include <linux/bank.h>
+
+#include <asm/uaccess.h>
+
+#ifdef CONFIG_ELSACCT_DEBUG
+#define dprintk(format...) printk(format)
+#else
+#define dprintk(format...)
+#endif
+
+/* Currently, informations are stored in the same file and we cannot chose it */
+#define ELSACCT_FILE	"/var/log/bank"
+
+/* It's the head on the list of banks */
+static struct bank_root elsa_br = BANK_ROOT_INIT(elsa_br);
+
+/* this is the major number dynamically got when registered */
+static int elsa_major;
+
+/* lock used to protect bank's list modifications */
+static spinlock_t elsa_lock = SPIN_LOCK_UNLOCKED;
+
+/**
+ * encode_comp_t - encode an unsigned long into a comp_t
+ * @value: value to encode
+ *
+ * Description: This routine has been adopted from the encode_comp_t() 
+ * function in the kern_acct.c file of the FreeBSD operating system. The 
+ * encoding is a 13-bit fraction with a 3-bit (base 8) exponent. 
+ * This routine is taken from kernel/acct.c
+ **/
+#define	MANTSIZE	13	/* 13 bit mantissa. */
+#define	EXPSIZE		3	/* Base 8 (3 bit) exponent. */
+#define	MAXFRACT	((1 << MANTSIZE) - 1)	/* Maximum fractional value. */
+
+typedef __u16 comp_t;
+
+static comp_t encode_comp_t(unsigned long value)
+{
+	int exp, rnd;
+
+	exp = rnd = 0;
+	while (value > MAXFRACT) {
+		rnd = value & (1 << (EXPSIZE - 1));	/* Round up? */
+		value >>= EXPSIZE;	/* Base 8 exponent == 3 bit shift. */
+		exp++;
+	}
+
+	/*
+	 * If we need to round up, do it (and handle overflow correctly).
+	 */
+	if (rnd && (++value > MAXFRACT)) {
+		value >>= EXPSIZE;
+		exp++;
+	}
+
+	/*
+	 * Clean it up and polish it off.
+	 */
+	exp <<= MANTSIZE;	/* Shift the exponent into place */
+	exp += value;		/* and add on the mantissa. */
+	return exp;
+}
+
+/**
+ * do_elsacct_data - Update accounting information when bank is removed
+ * @b: pointer to bank's data
+ *
+ * Description: copies code from BSD accounting. It's just to test accounting
+ * Result is written in a file (you can not choose it for now).
+ * It returns 0 if succeded, negative value otherwise
+ * !!! It's just for testing that means that we cannot choose dump file. !!!
+ * 
+ * Accounting is done here.
+ **/
+static int do_elsacct_bank(struct elsa_bank *b)
+{
+	static struct file *filp;
+	//static int irq_restore;
+	struct elsa_acct *info = (struct elsa_acct *) b->info;
+	mm_segment_t old_fs;
+
+	if (!info)
+		return -EINVAL;
+
+	/* Set bank ID */
+	info->eac_bid = b->bid;
+
+	/* Cannot open a file if irqs are disabled */
+	//if (irqs_disabled()) {
+	//      local_irq_enable();
+	//      irq_restore = 1;
+	//}
+
+	/* Open file where accounting information will be written */
+	filp = filp_open(ELSACCT_FILE, O_CREAT | O_RDWR | O_APPEND, 0666);
+
+	if (IS_ERR(filp)) {
+		return (PTR_ERR(filp));
+	}
+
+	if (!filp->f_op->write) {
+		filp_close(filp, NULL);
+		return (-EIO);
+	}
+
+	/*
+	 * Kernel segment override to datasegment and write it
+	 * to the accounting file. 
+	 */
+	old_fs = get_fs();
+	set_fs(KERNEL_DS);
+
+	filp->f_op->write(filp, (char *) info,
+			  sizeof(struct elsa_acct), &filp->f_pos);
+
+	set_fs(old_fs);
+
+	filp_close(filp, NULL);
+
+	//if (irq_restore)
+	//      local_irq_disable();
+
+	return 0;
+}
+
+/**
+ * do_elsacct_data - Update accounting information when data is removed
+ * @b: pointer to bank's data
+ * @d: pointer to the data
+ *
+ * Description: copies code from BSD accounting. It's just to test accounting
+ * It returns 0 if succeded, negative value otherwise
+ **/
+static int do_elsacct_data(struct elsa_bank *b, struct elsa_data *d)
+{
+	u64 elapsed;
+	struct elsa_acct *info = (struct elsa_acct *) b->info;
+	struct task_struct *p = d->process;
+
+	if (!info)
+		return -EINVAL;
+
+	/* One more process in the bank */
+	info->eac_ptot++;
+
+	/* elapsed time */
+	elapsed = jiffies_64_to_clock_t(get_jiffies_64() - p->start_time);
+	info->eac_etime += encode_comp_t(elapsed < (unsigned long) -1l ?
+					 (unsigned long) elapsed
+					 : (unsigned long) -1l);
+
+	/* user time and system time */
+	info->eac_utime += encode_comp_t(jiffies_to_clock_t(p->utime));
+	info->eac_stime += encode_comp_t(jiffies_to_clock_t(p->stime));
+
+	/* minor and major page faults */
+	info->eac_minflt += encode_comp_t(p->min_flt);
+	info->eac_majflt += encode_comp_t(p->maj_flt);
+
+	return 0;
+}
+
+/**
+ * do_elsacct - choose the right accounting treatment
+ * @opcode: operation to perform
+ * @b: pointer to a bank
+ * @d: pointer to a data
+ * 
+ * Description: it allows to choose to update accounting information 
+ * when a data is removed from a bank or to dump information if a
+ * bank is removed. 
+ **/
+int do_elsacct(int opcode, struct elsa_bank *b, struct elsa_data *d)
+{
+	int retval = 0;
+
+	switch (opcode) {
+	case ELSA_BANK_CALLBACK:
+		if (unlikely(b == NULL))
+			printk("do_elsacct: wrong parameter\n");
+		else
+			retval = do_elsacct_bank(b);
+		break;
+	case ELSA_DATA_CALLBACK:
+		if (unlikely(b == NULL) || unlikely(d == NULL))
+			printk("do_elsacct: wrong parameters\n");
+		else
+			retval = do_elsacct_data(b, d);
+		break;
+	default:
+		printk("do_elsacct: unknown opcode\n");
+		retval = -ENOIOCTLCMD;
+		break;
+	}
+
+	return retval;
+}
+
+/* Used internally by kernel/fork.c */
+void elsacct_process_copy(struct task_struct *from, struct task_struct *to)
+{
+	static struct list_head *entry;	/* entry == NULL */
+	static struct elsa_bank *b;	/* b == NULL */
+	static struct elsa_data *d;	/* d == NULL */
+	static struct elsa_data *new_d;	/* d == NULL */
+
+	/* 
+	 * First, initialize to->bank_head otherwise, if 
+	 * from->bank_head is NULL it won't be initialize
+	 */
+	write_lock_irq(&tasklist_lock);
+	INIT_LIST_HEAD(&(to->bank_head));
+	write_unlock_irq(&tasklist_lock);
+
+	list_for_each(entry, &from->bank_head) {
+		read_lock_irq(&tasklist_lock);
+		d = list_entry(entry, struct elsa_data, bank_list);
+		read_unlock_irq(&tasklist_lock);
+
+		new_d = elsa_data_alloc();
+		if (new_d) {
+			spin_lock_irq(&elsa_lock);
+			b = elsa_get_bank(&elsa_br, d->bid);
+			if (!b) {
+				/* release memory */
+				elsa_data_free(new_d);
+			} else {
+				new_d->process = to;
+				if (!elsa_data_add(b, new_d))
+					elsa_data_free(new_d);
+			}
+			spin_unlock_irq(&elsa_lock);
+		}
+	}
+}
+
+/* Used internally by kernel/exit.c */
+void elsacct_process_remove(struct task_struct *p)
+{
+	static struct elsa_data *d;	/* d == NULL */
+	static struct elsa_bank *b;	/* b == NULL */
+	int empty = 0;
+
+	while (!empty) {
+		int bid;
+
+		spin_lock_irq(&elsa_lock);
+
+		read_lock(&tasklist_lock);
+		if (list_empty(&p->bank_head)) {
+			d = NULL;
+		} else {
+			d = list_entry((p->bank_head).next,
+				       struct elsa_data, bank_list);
+		}
+		read_unlock(&tasklist_lock);
+
+		if (d != NULL) {
+			/* We don't need to check the return value */
+			b = elsa_get_bank(&elsa_br, d->bid);
+			bid = elsa_data_remove(b, d);
+
+			elsa_data_free(d);
+
+			if (bid) {
+				/* bank is empty */
+				elsa_bank_remove(b);
+				/* 
+				 * unlock before releasing memory used by 
+				 * the bank
+				 */
+				spin_unlock_irq(&elsa_lock);
+				kfree(b->info);
+				elsa_bank_free(b);
+			}
+		} else {
+			empty = 1;
+			spin_unlock_irq(&elsa_lock);
+		}
+
+	}
+}
+
+ /**************************************************************
+ * functions used to manipulate the device                     *
+ *                                                             *
+ * The enhanced linux system accounting device is /dev/elsacct *
+ * and the major number is dynamically given by OS             *
+ **************************************************************/
+
+/* 
+ * The process context, represented as a typical driver method - ioctl(), must 
+ * use spin_lock_irq() because it knows that interrupts are always enabled 
+ * while executing the device ioctl() method.
+ */
+
+/**
+ * elsacct_ioctl - issue a device specific command
+ * @inode: pointer to inode structure
+ * @filp : file pointer
+ * @cmd  : specific command to perform.
+ * @arg  : arguments that depend of cmd.
+ *
+ * Descritpion: Perform some actions on banks that depend of command passed to 
+ * the system call
+ **/
+int elsacct_ioctl(struct inode *inode, struct file *filp, unsigned int cmd,
+		  unsigned long arg)
+{
+	static int retval;	/* retval == 0 */
+	static struct elsa_ioctl_args iarg;
+	static struct task_struct *p;
+	static struct elsa_bank *b;
+	static struct elsa_data *d;
+
+	/* We can make some checks */
+	if (_IOC_TYPE(cmd) != ELSACCT_MAGIC)
+		return -ENOTTY;
+	if (_IOC_NR(cmd) > ELSACCT_MAXNR)
+		return -ENOTTY;
+	if ((cmd != ELSACCT_PROCESS_ADD) && (cmd != ELSACCT_PROCESS_REMOVE)
+	    && (cmd != ELSACCT_PROCESS_REMOVE_ALL)
+	    && (cmd != ELSACCT_BANK_CLEAN))
+		return -ENOTTY;
+
+	if (!access_ok(VERIFY_READ, (void *) arg, _IOC_SIZE(cmd)))
+		return -EFAULT;
+
+	/* Recover ioctl parameters */
+	if (copy_from_user(&iarg, (struct elsa_ioctl_args *) arg,
+			   sizeof(struct elsa_ioctl_args))) {
+		return -EFAULT;
+	}
+
+	dprintk("ELSAIOCTL: iarg = {bid#%d - pid#%d}\n", iarg.bid,
+		iarg.pid);
+
+	switch (cmd) {
+	case ELSACCT_PROCESS_ADD:
+		/*
+		 * To add a process to a bank we need to perform 
+		 * following actions:
+		 *     1) Allocate memory space to data (container)
+		 *     2) Allocate memory space to a bank or get a 
+		 *        pointer to an existing bank if BID != 0
+		 *     3) Update process in data field
+		 *     4) Add the container to the bank
+		 */
+		/* 
+		 * We need the pointer to task_struct. We catch it now so if 
+		 * it fails we will not allocate memory for new data
+		 */
+		read_lock(&tasklist_lock);
+		p = find_task_by_pid(iarg.pid);
+		read_unlock(&tasklist_lock);
+		if (!p) {
+			dprintk("elsacct_ioct: PID#%d not found\n",
+				iarg.pid);
+			return -EAGAIN;
+		}
+
+		d = elsa_data_alloc();
+		if (!d) {
+			return -ENOMEM;
+		}
+
+		if (iarg.bid == 0) {
+			struct elsa_acct *acctinfo;
+			int bid;
+
+			acctinfo = (struct elsa_acct *)
+			    kmalloc(sizeof(struct elsa_acct), GFP_KERNEL);
+			if (!acctinfo) {
+				printk
+				    ("ELSA: cannot allocate space for accounting \n");
+				return -ENOMEM;
+			}
+
+			b = elsa_bank_alloc();
+			if (!b) {
+				dprintk ("elsacct_ioct: cannot create BID\n");
+				/* release memory */
+				elsa_data_free(d);
+				kfree(acctinfo);
+				return -ENOMEM;
+			}
+
+			/* Macro to initialize accounting informations */
+			elsa_acct_init(acctinfo);
+
+			spin_lock_irq(&elsa_lock);
+			bid =
+			    elsa_bank_add(&elsa_br, b, &do_elsacct,
+					  acctinfo);
+			spin_unlock_irq(&elsa_lock);
+
+			if (!bid) {
+				dprintk
+				    ("elsacct_ioct: error during bank creation\n");
+				/* release memory */
+				elsa_data_free(d);
+				elsa_bank_free(b);
+				kfree(acctinfo);
+				return -EFAULT;
+			}
+		} else {
+			b = elsa_get_bank(&elsa_br, iarg.bid);
+			if (!b) {
+				dprintk("elsacct_ioct: BID#%d not found\n",
+					iarg.bid);
+				/* release memory */
+				elsa_data_free(d);
+				return -EINVAL;
+			}
+		}
+
+		/* At this point, b cannot be NULL */
+
+		d->process = p;
+
+		spin_lock_irq(&elsa_lock);
+		retval = elsa_data_add(b, d);
+		spin_unlock_irq(&elsa_lock);
+		break;
+
+	case ELSACCT_PROCESS_REMOVE:
+		/*
+		 * We want to remove a process from one given bank
+		 * Steps are:
+		 *      1) get a pointer to the given bank
+		 *      2) get a pointer to the container of the process
+		 *      3) remove the process
+		 *      4) free memory used by it
+		 *      5) release bank if empty
+		 */
+		spin_lock_irq(&elsa_lock);
+
+		b = elsa_get_bank(&elsa_br, iarg.bid);
+		if (!b) {
+			spin_unlock_irq(&elsa_lock);
+			dprintk("EBR: bank not found\n");
+			return -EINVAL;
+		}
+
+		d = elsa_get_data(iarg.pid, iarg.bid);
+		if (!d) {
+			spin_unlock_irq(&elsa_lock);
+			dprintk("EBR: data not found\n");
+			return -EINVAL;
+		}
+
+		retval = elsa_data_remove(b, d);
+
+		elsa_data_free(d);
+
+		if (retval) {
+			dprintk("EBR: Bank is now empty\n");
+
+			elsa_bank_remove(b);
+
+			dprintk("EBR: bank release\n");
+
+			spin_unlock_irq(&elsa_lock);
+			kfree(b->info);
+			elsa_bank_free(b);
+		} else {
+			spin_unlock_irq(&elsa_lock);
+		}
+
+		retval = 0;
+		break;
+
+	case ELSACCT_PROCESS_REMOVE_ALL:
+		/*
+		 * remove a process from all banks that it
+		 * belongs. To achieve this we need to:
+		 *      1) get a pointer to the process
+		 *      2) get the first data 
+		 *      3) remove it from the bank
+		 *      4) release the data
+		 *      5) if necessary, remove and release bank
+		 *
+		 */
+		read_lock(&tasklist_lock);
+		p = find_task_by_pid(iarg.pid);
+		read_unlock(&tasklist_lock);
+		if (!p) {
+			dprintk("elsacct_ioct: PID#%d not found\n",
+				iarg.pid);
+			return -EAGAIN;
+		}
+
+		retval = 1;
+		while (retval) {
+			int bid;
+
+			spin_lock_irq(&elsa_lock);
+
+			read_lock(&tasklist_lock);
+			if (list_empty(&p->bank_head)) {
+				d = NULL;
+			} else {
+				d = list_entry((p->bank_head).next,
+					       struct elsa_data,
+					       bank_list);
+				dprintk("EPRA: remove ...");
+				if (unlikely(d == NULL))
+					BUG();
+				dprintk(" from bank #%d ...", d->bid);
+				dprintk(" pid #%d\n", d->process->pid);
+			}
+			read_unlock(&tasklist_lock);
+
+			if (d != NULL) {
+				/* We don't need to check the return value */
+				b = elsa_get_bank(&elsa_br, d->bid);
+				bid = elsa_data_remove(b, d);
+
+				elsa_data_free(d);
+
+				if (bid) {
+					/* bank is empty */
+					elsa_bank_remove(b);
+					/* 
+					 * unlock before releasing memory 
+					 * occupied by the bank 
+					 */
+					spin_unlock_irq(&elsa_lock);
+					kfree(b->info);
+					elsa_bank_free(b);
+				}
+			} else {
+				dprintk
+				    ("EPRA: Process removed from all banks\n");
+				retval = 0;
+				spin_unlock_irq(&elsa_lock);
+			}
+
+		}
+		break;
+
+	case ELSACCT_BANK_CLEAN:
+		/*
+		 * remove all process from one given bank
+		 * Steps are:
+		 *      1) get a pointer to the given bank
+		 *      2) while there is data in the bank
+		 *              -> remove the data
+		 *      3) release bank
+		 */
+		spin_lock_irq(&elsa_lock);
+		b = elsa_get_bank(&elsa_br, iarg.bid);
+
+		if (!b) {
+			spin_unlock_irq(&elsa_lock);
+			dprintk("EBC: bank not found\n");
+			return -EINVAL;
+		}
+
+		retval = 1;
+		while (retval) {
+
+			if (list_empty(&b->data_head)) {
+				d = NULL;
+			} else {
+				d = list_entry((b->data_head).next,
+					       struct elsa_data,
+					       data_list);
+			}
+
+			if (d) {
+				dprintk
+				    ("EBC: Remove pid#%d from bank#%d\n",
+				     d->process->pid, b->bid);
+				/* We don't need to check the return value */
+				elsa_data_remove(b, d);
+				elsa_data_free(d);
+			} else {
+				retval = 0;
+				dprintk("EBC: Bank#%d is now empty\n",
+					b->bid);
+			}
+		}
+
+		/* bank is empty */
+		elsa_bank_remove(b);
+
+		spin_unlock_irq(&elsa_lock);
+		kfree(b->info);
+		elsa_bank_free(b);
+
+		break;
+
+	default:
+		/*
+		 * The POSIX standard, states that if an inappropriate ioctl command 
+		 * has been issued, then -ENOTTY should be returned.
+		 */
+		retval = -ENOTTY;
+	};
+
+	return retval;
+}
+
+struct file_operations elsa_fops = {
+	.owner = THIS_MODULE,
+	.ioctl = elsacct_ioctl,
+};
+
+/**
+ * elsacct_init - Initialize enhanced linux system accounting
+ * 
+ * Description: initializes "callbacks" to bank and data. Those 
+ * functions are called a bank or a data are destroyed.
+ * It allows to perform some actions in the module.
+ **/
+static int __init elsacct_init(void)
+{
+	int retval = 0;
+	struct proc_dir_entry *entry;
+
+	/* register character device with a dynamic major number */
+	elsa_major = register_chrdev(0, "elsacct", &elsa_fops);
+	if (!elsa_major) {
+		dprintk(KERN_WARNING
+			"elsacct_init: can't get major %d\n", elsa_major);
+		return -EIO;
+	}
+
+	/* 
+	 * To get the major number we use a script that parse /proc/devices
+	 * and get the correct major number. We don't use elsa_major except
+	 * to test if the device is registered.
+	 */
+	dprintk(KERN_INFO "ELSACCT: device driver is recorded\n");
+	/*
+	 * From here, dev is registered. Thus, if there is a problem
+	 * we must unregister the device.
+	 */
+
+#ifdef CONFIG_PROC_FS
+	/* create /proc entry */
+	entry = create_proc_entry("bankinfo", 0, NULL);
+	if (entry) {
+		entry->proc_fops = &proc_bankinfo_ops;
+	} else {
+		unregister_chrdev(elsa_major, "elsacct");
+		return -EIO;
+	}
+#endif
+
+	/* succeed */
+	return retval;
+}
+
+ /*********************************
+ * functions used to manage /proc *
+ *                                *
+ * The entry is /proc/bankinfo    *
+ *********************************/
+
+/*
+ * Add an entry in /proc to get informations concerning
+ * banks. This entry is called /proc/bankinfo
+ */
+#ifdef CONFIG_PROC_FS
+static void *b_start(struct seq_file *m, loff_t * pos)
+{
+	loff_t n = *pos;
+	struct list_head *p;
+
+	/* Header is displaying just during the first called */
+	if (!n) {
+		seq_puts(m, "# - bankinfo -\n");
+		seq_puts(m, "# bankid:\t<process> <process> ...\n");
+	}
+
+	if (list_empty(&elsa_br.bank_head))
+		return NULL;
+
+	p = elsa_br.bank_head.next;
+	while (n--) {
+		p = p->next;
+		if (p == &elsa_br.bank_head)
+			return NULL;
+	}
+
+	/* we return a pointer to the data in the bank */
+	return list_entry(p, struct elsa_bank, bank_list);
+
+}
+
+static void b_stop(struct seq_file *m, void *v)
+{
+}
+
+static void *b_next(struct seq_file *m, void *v, loff_t * pos)
+{
+	struct elsa_bank *bank = v;
+
+	++*pos;
+	return bank->bank_list.next == &elsa_br.bank_head ? NULL :
+	    list_entry(bank->bank_list.next, struct elsa_bank, bank_list);
+}
+
+static int show_bankinfo(struct seq_file *m, void *v)
+{
+	struct elsa_bank *bank = v;
+	struct elsa_data *data;
+
+	if (!bank) {
+		seq_printf(m, "There is no banks\n");
+	} else {
+		/* display bank identifier */
+		seq_printf(m, "%d:", bank->bid);
+		/* add a tabulation */
+		seq_printf(m, "\t");
+		/* display list of processus */
+		if (list_empty(&(bank->data_head))) {
+			seq_printf(m, "Empty");
+		} else {
+			list_for_each_entry(data, &(bank->data_head),
+					    data_list)
+			    seq_printf(m, "%d ", data->process->pid);
+		}
+		/* add EOL */
+		seq_printf(m, "\n");
+	}
+
+	return 0;
+}
+
+/* 
+ * bankinfo_op - iterator that generates /proc/bankinfo
+ * Output layout is:
+ *     bankID	pid ...
+ */
+struct seq_operations bankinfo_op = {
+	.start = b_start,
+	.stop = b_stop,
+	.next = b_next,
+	.show = show_bankinfo,
+};
+
+int bankinfo_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &bankinfo_op);
+}
+
+struct file_operations proc_bankinfo_ops = {
+	.open = bankinfo_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+EXPORT_SYMBOL(proc_bankinfo_ops);
+
+#endif
+
+ /************************
+ * Module initialization *
+ ************************/
+
+/**
+ * elsacct_init_module - called when module is loaded
+ *
+ * Description: display a message in dmesg and call the real 
+ * initialization function.
+ **/
+static int __init elsacct_init_module(void)
+{
+	dprintk(KERN_INFO "ELSA accounting started\n");
+	return elsacct_init();
+}
+
+/**
+ * elsacct_cleanup - called when module is unloaded
+ *
+ * Description: display a message in dmesg 
+ **/
+static void __exit elsacct_cleanup_module(void)
+{
+	/* release the major number when module is unloaded */
+	if (unregister_chrdev(elsa_major, "elsacct"))
+		dprintk(KERN_WARNING
+			"elsacct_cleanup: cannot unregister blkdev\n");
+	else
+		dprintk(KERN_INFO
+			"elsacct_cleanup: accounting terminated\n");
+}
+
+module_init(elsacct_init_module);
+module_exit(elsacct_cleanup_module);
+
+MODULE_DESCRIPTION("Enhanced Linux System Accounting.");
+MODULE_AUTHOR("Guillaume Thouvenin <guillaume.thouvenin@bull.net>");
+
+MODULE_LICENSE("GPL");
diff -uprN -X dontdiff linux-2.6.8.1-vanilla/drivers/elsacct/Kconfig linux-2.6.8.1-elsa/drivers/elsacct/Kconfig
--- linux-2.6.8.1-vanilla/drivers/elsacct/Kconfig	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.8.1-elsa/drivers/elsacct/Kconfig	2004-08-23 09:25:41.758972280 +0200
@@ -0,0 +1,61 @@
+#
+# For a description of the syntax of this configuration file,
+# see Documentation/kbuild/kconfig-language.txt.
+#
+
+menu "ELSAcct Driver"
+
+config BANK
+	bool "ELSA bank support"
+	depends on EXPERIMENTAL
+	default n
+	---help---
+	  BANK structures are needed if you want to do enhanced 
+	  linux system accounting
+
+	  say Y if you want to use Enhanced Linux Sytem Accounting
+
+config BANK_DEBUG
+	bool "ELSA bank debugging support"
+	depends on BANK
+	default n
+	---help---
+          This option allows you to enable debugging output when using 
+	  banks structure. Currently, such structure is used by Enhanced
+	  Linux System Accounting (ELSA). Informations are sent to the 
+	  console.
+
+config ELSACCT
+	bool "Enhanced Linux System Accounting"
+	depends on EXPERIMENTAL
+	requires BANK
+	default n
+	---help---
+  	  The goal of accounting is to collect and report the use of various 
+  	  system resources by applications. Informations, like process time, 
+  	  CPU usage, connect time or disk space usage, provides data that helps 
+  	  the system to adjust the use of resources between processes.
+  	
+  	  The current BSD-like process accounting that already exists in Linux 
+  	  collects informations on individual users or groups of users. The ELSA 
+  	  project aims to improve and extend the monitoring of resources with 
+  	  different criteria like groups of processes. Another target for this 
+  	  project is to give Linux an homogeneous set of commands for all kinds 
+  	  of accounting (memory, CPU and I/O).
+  	
+     	  To compile this driver as a module, choose M here: the module will be 
+  	  called elsa-acct.
+  
+  	  Documentation about ELSA is available from
+  	  <http://elsa.sourceforge.net>
+
+config ELSACCT_DEBUG
+	bool "ELSA accounting debugging support"
+	depends on ELSACCT
+	default n
+	---help---
+          This option allows you to enable debugging output when using 
+	  enhanced linux system accounting. Informations are sent to the 
+	  console.
+
+endmenu
diff -uprN -X dontdiff linux-2.6.8.1-vanilla/drivers/elsacct/Makefile linux-2.6.8.1-elsa/drivers/elsacct/Makefile
--- linux-2.6.8.1-vanilla/drivers/elsacct/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.8.1-elsa/drivers/elsacct/Makefile	2004-08-23 09:25:41.759972128 +0200
@@ -0,0 +1,5 @@
+#
+# Makefile for the Enhanced Linux System Accounting
+#
+obj-$(CONFIG_BANK)	+= bank.o
+obj-$(CONFIG_ELSACCT)	+= elsacct.o
diff -uprN -X dontdiff linux-2.6.8.1-vanilla/drivers/Kconfig linux-2.6.8.1-elsa/drivers/Kconfig
--- linux-2.6.8.1-vanilla/drivers/Kconfig	2004-08-14 12:56:22.000000000 +0200
+++ linux-2.6.8.1-elsa/drivers/Kconfig	2004-08-23 09:25:41.759972128 +0200
@@ -4,6 +4,8 @@ menu "Device Drivers"
 
 source "drivers/base/Kconfig"
 
+source "drivers/elsacct/Kconfig"
+
 source "drivers/mtd/Kconfig"
 
 source "drivers/parport/Kconfig"
diff -uprN -X dontdiff linux-2.6.8.1-vanilla/drivers/Makefile linux-2.6.8.1-elsa/drivers/Makefile
--- linux-2.6.8.1-vanilla/drivers/Makefile	2004-08-14 12:55:59.000000000 +0200
+++ linux-2.6.8.1-elsa/drivers/Makefile	2004-08-23 09:25:41.760971976 +0200
@@ -51,3 +51,4 @@ obj-$(CONFIG_MCA)		+= mca/
 obj-$(CONFIG_EISA)		+= eisa/
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
 obj-y				+= firmware/
+obj-y				+= elsacct/
diff -uprN -X dontdiff linux-2.6.8.1-vanilla/include/linux/bank.h linux-2.6.8.1-elsa/include/linux/bank.h
--- linux-2.6.8.1-vanilla/include/linux/bank.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.8.1-elsa/include/linux/bank.h	2004-08-23 09:25:41.761971824 +0200
@@ -0,0 +1,183 @@
+/*
+ *  include/linux/elsa_bank.h
+ * 
+ *  ELSA - Enhanced Linux System Accounting
+ *  Guillaume Thouvenin - 26/04/2004
+ *  
+ *  Provides structures and functions to manipulate "BANK". 
+ *  They are containers that store a set of processes. 
+ *  When a "BANK" is empty it is destroy and accounting infor-
+ *  mations are stored in a file. Informations are about 
+ *  all process contained in a "BANK"
+ * 
+ *  The idea is to provide a mechanism that allows to group 
+ *  chosen process together. "BANK" must have some properties like:
+ *    o If a process belongs to a bank, its children belong to the same bank
+ *    o A process can be placed in several different banks
+ *    o When the user adds a process to an non-existent bank, the container
+ *      must automatically be created
+ *    o When the last process of a bank exits, informations about all processes
+ *      that belonged to the bank must be stored (maybe in a file) and the
+ *      container must be destroyed
+ * 
+ *  To do that, we use a double linked list provides by the kernel
+ *  (include/linux/list.h) and we do the following thing:
+ * 
+ *                              BANK #1           BANK #2  
+ *                             elsa_bank       elsa_bank  
+ *            ROOT            -----------       ----------- 
+ *          bank_root        |  bid = 1  |     |  bid = 2  |
+ *       --------------      |-----------|     |-----------|
+ *      | next_bid = 3 |     |   info    |     |   info    |
+ *      |--------------|     |-----------|     |-----------|
+ *      | freebid_head |     | callback  |     | callback  |
+ *      |--------------|     |-----------|     |-----------|
+ *      | bank_head    |<===>| bank_list |<===>| bank_list |<===>...
+ *       --------------      |-----------|     |-----------|
+ *                           | data_head |     | data_head |<===>...
+ *                            ----------        -----------
+ *                                   ^ ^
+ *                                   | |
+ *                                   |  ================= 
+ *    PROCESS            DATA #1     |     DATA #2       |  
+ *  task_struct         elsa_data    |    elsa_data      |
+ *   ---------         -----------   |   -----------     |
+ *  |         |       |  bid = 1  |  |  |  bid = 1  |    |
+ *  |         |       |-----------|  |  |-----------|    |
+ *  |         |<------|  process  |  |  |  process  |    |
+ *  |         |       |-----------|  |  |-----------|    |
+ *  |         |       | data_list |<=   | data_list |<===
+ * ...       ...      |           |<===>|           |
+ *  |---------|       |-----------|     |-----------|
+ *  |bank_head|<=====>| bank_list |     | bank_list |
+ *   ---------         -----------       -----------
+ *
+ *
+ * Field "bank_list" in the elsa_data is used to know which are banks with
+ * a given process. Structure "task_struc" is modified to use this field.
+ */
+
+#ifndef __LINUX_BANK_H
+#define __LINUX_BANK_H
+
+#include <linux/types.h>
+#include <linux/sched.h>
+#include <linux/list.h>
+#include <asm/rwlock.h>
+
+#define ELSA_BANK_CALLBACK 0
+#define ELSA_DATA_CALLBACK 1
+
+/***
+ * Internal structures
+ ***/
+
+/**
+ * struct bank_root - Main structure
+ * @lock: protect elsa_broot manipulation
+ * @next_bid: next available bank identifier
+ * @freebid_head: list of free bank identifier
+ * @bank_head: head of the list of banks
+ *
+ * Description: This is the main structure.
+ * We need to protect ID by a semaphore since it must be
+ * a unique number. We can't have to bank with same ID. This 
+ * lock will also be used when the structure need to be modified.
+ *
+ * Currently the list of free bank identifier is not used. 
+ **/
+struct bank_root {
+	__u32 next_bid;
+	struct list_head freebid_head;
+	struct list_head bank_head;
+};
+
+#define BANK_ROOT_INIT(root) \
+{							     \
+	.next_bid 	= 1,                                 \
+	.freebid_head 	= LIST_HEAD_INIT(root.freebid_head), \
+	.bank_head	= LIST_HEAD_INIT(root.bank_head),    \
+}
+
+/**
+ * struct elsa_freebid - list of free bank identifier
+ * @bid: bank identifier
+ * @bid_list: list of free bank ID
+ **/
+struct elsa_freebid {
+	__u32 bid;
+	struct list_head bid_list;
+};
+
+struct elsa_data;
+
+/**
+ * struct elsa_bank - container that will holds process
+ * @bid: bank identifier
+ * @info: allow to hang informations about processes in a bank 
+ * @callback : callback ;)
+ * @bank_list: list of available banks
+ * @data_head: head of the list of datas in the bank
+ *
+ * Description: This structure holds information about data that 
+ * can be found in a bank. 
+ **/
+struct elsa_bank {
+	__u32 bid;
+	void *info;
+	int (*callback) (int, struct elsa_bank *, struct elsa_data *);
+	struct list_head bank_list;
+	struct list_head data_head;
+};
+
+/**
+ * struct elsa_data - data found in a bank
+ * @bid: the bank to which data belong
+ * @process: pointer to a process
+ * @data_list: list of data in the same bank
+ * @bank_list: list of banks (used by process)
+ *
+ * Description: This structure holds information about data that 
+ * can be found in a bank. When a process need to be removed from
+ * all banks that it belongs, we used the @bank_list field to know
+ * from which banks it will be removed.
+ **/
+struct elsa_data {
+	__u32 bid;
+	struct task_struct *process;
+	struct list_head data_list;
+	struct list_head bank_list;
+};
+
+ /*********************************************
+ * Following functions can be use by a module *
+ * (=> they are exported)                     *
+ *********************************************/
+
+/* allocate memory space: (call to kmalloc) */
+struct elsa_bank *elsa_bank_alloc(void);
+void elsa_bank_free(struct elsa_bank *bank);
+
+struct elsa_data *elsa_data_alloc(void);
+void elsa_data_free(struct elsa_data *data);
+
+/* 
+ * manipulate datas:
+ * Memory space can be released (call to kfree) in the last three
+ * functions.
+ */
+int elsa_bank_add(struct bank_root *br,
+		  struct elsa_bank *b,
+		  int (*fn) (int, struct elsa_bank *, struct elsa_data *),
+		  void *info);
+int elsa_bank_remove(struct elsa_bank *b);
+int elsa_data_add(struct elsa_bank *b, struct elsa_data *d);
+int elsa_data_remove(struct elsa_bank *b, struct elsa_data *d);
+/* elsa_process_remove() is used by the kernel so it is declared below */
+
+/* get information */
+struct elsa_bank *elsa_get_bank(struct bank_root *br, __u32 bid);
+struct elsa_data *elsa_get_data(pid_t pid, __u32 bid);
+//int elsa_process_present(struct task_struct *p, struct elsa_bank *b);
+
+#endif				/* !(__LINUX_BANK_H) */
diff -uprN -X dontdiff linux-2.6.8.1-vanilla/include/linux/elsacct.h linux-2.6.8.1-elsa/include/linux/elsacct.h
--- linux-2.6.8.1-vanilla/include/linux/elsacct.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.8.1-elsa/include/linux/elsacct.h	2004-08-23 09:25:41.762971672 +0200
@@ -0,0 +1,85 @@
+/*
+ *  include/linux/elsacct.h
+ * 
+ *  ELSA - Enhanced Linux System Accounting
+ *  Guillaume Thouvenin - 26/04/2004
+ *      
+ */
+
+#ifndef __LINUX_ELSACCT_H
+#define __LINUX_ELSACCT_H
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+/* IOCTL numbers */
+/* If you add a new IOCTL number don't forget to update ELSACCT_MAXNR */
+#define ELSACCT_MAGIC			0x35
+#define ELSACCT_PROCESS_ADD		_IOW(ELSACCT_MAGIC,0,struct elsa_acct)
+#define ELSACCT_PROCESS_REMOVE		_IOW(ELSACCT_MAGIC,1,struct elsa_acct)
+#define ELSACCT_PROCESS_REMOVE_ALL	_IOW(ELSACCT_MAGIC,2,struct elsa_acct)
+#define ELSACCT_BANK_CLEAN		_IOW(ELSACCT_MAGIC,3,struct elsa_acct)
+
+#define ELSACCT_MAXNR 3
+
+#ifdef CONFIG_PROC_FS
+extern struct file_operations proc_bankinfo_ops;
+#endif
+
+/**
+ * struct elsa_ioctl_args - used to pass arguments with ioctl
+ * @bid: bank identifier
+ * @pid: process identifier
+ *
+ * Description: This structure is used to pass two arguments when
+ * doing an ioctl on the elsacct device. 
+ **/
+struct elsa_ioctl_args {
+	__u32 bid;
+	__u32 pid;
+};
+
+/**
+ * struct elsa_acct - main accounting structure
+ * @eac_bid: bank ID
+ * @eac_ptot: total number of process that are added to a bank
+ * @eac_utime: accounting User Time
+ * @eac_stime: accounting System Time
+ * @eac_etime: accounting Elapsed Time
+ * @eac_minflt: accounting Minor Pagefaults
+ * @eac_majflt: accounting Major Pagefaults
+ *
+ * Description: Currently, we take as a starting point the BSD-style 
+ * process accounting and we write values into /var/log/bank. (of course we need to 
+ * change this behaviour to be more flexible) 
+ */
+struct elsa_acct {
+	__u32 eac_bid;
+	__u32 eac_ptot;
+	__u32 eac_utime;
+	__u32 eac_stime;
+	__u32 eac_etime;
+	__u32 eac_minflt;
+	__u32 eac_majflt;
+};
+
+#define elsa_acct_init(ptr) do { 	\
+	(ptr)->eac_bid 		= 0;	\
+	(ptr)->eac_ptot		= 0;	\
+	(ptr)->eac_utime	= 0;	\
+	(ptr)->eac_stime	= 0;	\
+	(ptr)->eac_etime	= 0;	\
+	(ptr)->eac_minflt 	= 0;	\
+	(ptr)->eac_majflt 	= 0;	\
+} while(0)
+
+#ifdef CONFIG_ELSACCT
+extern void elsacct_process_copy(struct task_struct *,
+				 struct task_struct *);
+extern void elsacct_process_remove(struct task_struct *);
+#else
+#define elsacct_process_copy(a,b) do {} while (0)
+#define elsacct_process_remove(a) do {} while (0)
+#endif				/* !(CONFIG_ELSACCT) */
+
+#endif				/* !(__LINUX_ELSACCT_H) */
diff -uprN -X dontdiff linux-2.6.8.1-vanilla/include/linux/init_task.h linux-2.6.8.1-elsa/include/linux/init_task.h
--- linux-2.6.8.1-vanilla/include/linux/init_task.h	2004-08-14 12:54:49.000000000 +0200
+++ linux-2.6.8.1-elsa/include/linux/init_task.h	2004-08-23 09:25:41.762971672 +0200
@@ -112,6 +112,7 @@ extern struct group_info init_groups;
 	.proc_lock	= SPIN_LOCK_UNLOCKED,				\
 	.switch_lock	= SPIN_LOCK_UNLOCKED,				\
 	.journal_info	= NULL,						\
+	.bank_head	= LIST_HEAD_INIT(tsk.bank_head),		\
 }
 
 
diff -uprN -X dontdiff linux-2.6.8.1-vanilla/include/linux/sched.h linux-2.6.8.1-elsa/include/linux/sched.h
--- linux-2.6.8.1-vanilla/include/linux/sched.h	2004-08-14 12:54:49.000000000 +0200
+++ linux-2.6.8.1-elsa/include/linux/sched.h	2004-08-23 09:25:41.763971520 +0200
@@ -527,6 +527,9 @@ struct task_struct {
   	struct mempolicy *mempolicy;
   	short il_next;		/* could be shared with used_math */
 #endif
+
+/* List of BANK to which the process belong -- Used by ELSA */
+	struct list_head bank_head;
 };
 
 static inline pid_t process_group(struct task_struct *tsk)
diff -uprN -X dontdiff linux-2.6.8.1-vanilla/kernel/exit.c linux-2.6.8.1-elsa/kernel/exit.c
--- linux-2.6.8.1-vanilla/kernel/exit.c	2004-08-14 12:56:01.000000000 +0200
+++ linux-2.6.8.1-elsa/kernel/exit.c	2004-08-23 09:25:41.764971368 +0200
@@ -23,6 +23,7 @@
 #include <linux/mount.h>
 #include <linux/proc_fs.h>
 #include <linux/mempolicy.h>
+#include <linux/elsacct.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -59,6 +60,7 @@ repeat: 
 	BUG_ON(p->state < TASK_ZOMBIE);
  
 	atomic_dec(&p->user->processes);
+	elsacct_process_remove(p);
 	spin_lock(&p->proc_lock);
 	proc_dentry = proc_pid_unhash(p);
 	write_lock_irq(&tasklist_lock);
diff -uprN -X dontdiff linux-2.6.8.1-vanilla/kernel/fork.c linux-2.6.8.1-elsa/kernel/fork.c
--- linux-2.6.8.1-vanilla/kernel/fork.c	2004-08-14 12:54:49.000000000 +0200
+++ linux-2.6.8.1-elsa/kernel/fork.c	2004-08-23 09:25:41.766971064 +0200
@@ -36,6 +36,7 @@
 #include <linux/mount.h>
 #include <linux/audit.h>
 #include <linux/rmap.h>
+#include <linux/elsacct.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -1030,6 +1031,19 @@ struct task_struct *copy_process(unsigne
 	INIT_LIST_HEAD(&p->ptrace_children);
 	INIT_LIST_HEAD(&p->ptrace_list);
 
+        /*
+         * Child is in the same BANK as parent. So we copy the list of banks
+         * from current to p. We can not just counting reference on the structure
+         * because the may evoluate differently. I think it's easier to
+         * do like this but maybe I'm wrong... -- guillaume
+         *
+         * We put that call outside lock_irq because elsa_process_copy()
+         * uses kmalloc(GFP_KERNEL). Therefore, as we modify task_struct,
+         * we manage lock_irq ourselves. -- guillaume
+         *
+         */
+        elsacct_process_copy(current, p);
+
 	/* Need tasklist lock for parent etc handling! */
 	write_lock_irq(&tasklist_lock);
 	/*
diff -uprN -X dontdiff linux-2.6.8.1-vanilla/Makefile linux-2.6.8.1-elsa/Makefile
--- linux-2.6.8.1-vanilla/Makefile	2004-08-14 12:55:35.000000000 +0200
+++ linux-2.6.8.1-elsa/Makefile	2004-08-23 09:29:29.689321600 +0200
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 8
-EXTRAVERSION = .1
+EXTRAVERSION = .1-elsa
 NAME=Zonked Quokka
 
 # *DOCUMENTATION*
