Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265032AbUELMWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265032AbUELMWa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 08:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265034AbUELMWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 08:22:30 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:31177 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S265032AbUELMUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 08:20:51 -0400
Message-ID: <40A216A0.9010202@bull.net>
Date: Wed, 12 May 2004 14:20:48 +0200
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Enhanced Linux System Accounting
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 12/05/2004 14:23:44,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 12/05/2004 14:23:53,
	Serialize complete at 12/05/2004 14:23:53
Content-Type: multipart/mixed;
 boundary="------------020009030006040600060505"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020009030006040600060505
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

 This is a new patch "patch-2.6.6-elsa" for 2.6.6 kernel. It can be 
downloaded from:
http://sourceforge.net/project/showfiles.php?group_id=105806

  I also attach it at the end of this file. In this patch we rewrite 
functions and we made a clean separation between different parts of ELSA 
(thank you very much to Chris Wright for its usefull comments). This 
patch allows you to test BSD-like accounting for a group of process. 
Informations are dumped in /var/log/bank (need to change that). "BANK" 
can be manipulated via ioctl() and /dev/elsacct. A C program, called 
"elsa_cmd.c", that allows to add/remove process to/from a bank can be 
downloaded from the CVS:
http://cvs.sourceforge.net/viewcvs.py/elsa/tests/

  We need to improve lock between the main structure called "elsa_broot" 
and add new accounting informations. Our goal is to provide an 
environment that can support System V accounting and a unify interface 
from existing accounting tools (like sar) to be used by existing Linux 
administrative tools (like WebMin).

Any feedbacks, any comments are welcome
Best,
Guillaume



--------------020009030006040600060505
Content-Type: text/plain;
 name="patch-2.6.6-elsa"
Content-Disposition: inline;
 filename="patch-2.6.6-elsa"
Content-Transfer-Encoding: 7bit

diff -uprN -X elsa_import/dontdiff linux-2.6.6/drivers/elsacct/bank.c linux-2.6.6-elsa/drivers/elsacct/bank.c
--- linux-2.6.6/drivers/elsacct/bank.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.6-elsa/drivers/elsacct/bank.c	2004-05-12 07:24:41.380161848 +0200
@@ -0,0 +1,607 @@
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
+#include <linux/seq_file.h>
+#include <linux/module.h>
+
+#include <linux/bank.h>
+
+#include <asm/semaphore.h>
+#include <asm/bug.h>
+
+ /*********************************************
+ * structures and macros used to manage banks *
+ *********************************************/
+
+#ifdef CONFIG_BANK_DEBUG
+#define dprintk(format...) printk(format)
+#else
+#define dprintk(format)
+#endif
+
+/* It's the head on the list of banks */
+static struct bank_root elsa_broot = BANK_ROOT_INIT(elsa_broot);
+
+/* semaphore that protect access to bank id */
+static DECLARE_MUTEX(elsa_bid_sem);
+//SPIN_LOCK_UNLOCKED(elsalist_lock);
+
+ /********************************************************************
+ * Following functions can be use by a module (=> they are exported) *
+ ********************************************************************/
+
+/**
+ * elsa_bank_alloc - Allocates a new bank
+ * @fn : callback used when a data or a bank are destroyed
+ * @info : generic information attached to a bank (used for accounting) 
+ *
+ * Allocates a new bank and returns the new created bank.
+ * If an error is encountered NULL is returned.
+ *
+ * Here are different steps of the operation
+ *
+ *   1) Allocate space for the new bank
+ *   2) Give it an identifier
+ *   3) Initialize the head of the list of items (items will point to process)
+ *   4) Add it to the list of available bank
+ */
+struct elsa_bank
+*elsa_bank_alloc(int (*fn) (int, struct elsa_bank *, struct elsa_data *),
+		 void *info)
+{
+	struct elsa_bank *b;
+	int bid;
+
+	/* allocate space for the new bank */
+	b = (struct elsa_bank *)kmalloc(sizeof(struct elsa_bank), GFP_KERNEL);
+	if (!b) {
+		printk("elsa_bank_alloc: cannot allocate space\n");
+		return NULL;
+	}
+
+	/* 
+	 * give it an id 
+	 * Currently we only used next_bid field but this mechnism 
+	 * can give problems if we use many banks and the bid go through
+	 * its maximum  
+	 */
+	down(&elsa_bid_sem);
+	bid = elsa_broot.next_bid++;
+	up(&elsa_bid_sem);
+
+	if (bid <= 0) {
+		/* There is no available id == ERROR */
+		kfree(b);
+		printk("elsa_bank_alloc: can not find bank identifier\n");
+		return NULL;
+	} else {
+		b->bid = bid;
+	}
+
+	/* Initialize fields */
+	b->info = info;
+	b->callback = fn;
+	INIT_LIST_HEAD(&(b->data_head));
+
+	/* add the new bank to the list of banks --- NEED LOCK */
+	list_add(&(b->bank_list), &(elsa_broot.bank_head));
+
+	dprintk("elsa_bank_alloc: bank #%d created\n", b->bid);
+
+	return b;
+}
+
+/**
+ * elsa_data_alloc - Allocates a new data
+ * 
+ * Allocates a new data and returns the new created item.
+ * If an error is encountered NULL is returned.
+ *
+ * Here are different steps of the operation
+ *
+ *   1) Allocate space for the new data
+ *   2) Initialize different fields
+ */
+struct elsa_data *elsa_data_alloc(void)
+{
+	struct elsa_data *d;
+
+	/* allocate space for the new data */
+	d = (struct elsa_data *)kmalloc(sizeof(struct elsa_data), GFP_KERNEL);
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
+ * elsa_bank_free - Frees space occupied by a bank.
+ * @bank: a pointer to the bank to delete
+ * 
+ * Removes a bank and returns the identifiers of the removed bank.
+ * When this function is called bank *MUST* be empty.
+ *
+ * Here are different steps of the operation
+ *
+ *   1) Write accounting information
+ *   2) Remove it from the list of banks
+ *   3) Free space used by bank
+ */
+void elsa_bank_free(struct elsa_bank *bank)
+{
+	BUG_ON(bank == NULL);
+	BUG_ON(!list_empty(&bank->data_head));
+
+	/* Before deleting the bank, we can do some action */
+	/* callback */
+	if (bank->callback) {
+		(bank->callback) (ELSA_BANK_CALLBACK, bank, NULL);
+	}
+
+	/* remove bank from the bank's list */
+	list_del(&(bank->bank_list));
+	dprintk("elsa_bank_free: bank #%d removed from the list\n", bank->bid);
+	kfree(bank);
+}
+
+/**
+ * elsa_data_free - Free data
+ * @data: data to be removed
+ * 
+ * Frees memory space used by data. 
+ */
+void elsa_data_free(struct elsa_data *data)
+{
+	struct elsa_bank *b = NULL;
+
+	BUG_ON(data == NULL);
+
+	/*
+	 * if data->bid is equal to 0, it means that an error occured between
+	 * data's allocation and data's addition in a bank. So, it isn't inserted
+	 * in any list and there is no need to call the "callback"
+	 */
+	if (data->bid != 0) {
+		/* callback, we are in the child so callback code */
+		b = elsa_get_bank(data->bid);
+		if (b && b->callback) {
+			(b->callback) (ELSA_DATA_CALLBACK, b, data);
+		}
+
+		list_del(&data->data_list);
+
+		/* Need access to head_list in task_struct */
+		write_lock_irq(&tasklist_lock);
+		list_del(&data->bank_list);
+		write_unlock_irq(&tasklist_lock);
+
+		dprintk
+		    ("elsa_data_free: process #%d removed from the bank#%d\n",
+		     data->process->pid, b->bid);
+	}
+
+	kfree(data);
+}
+
+/**
+ * elsa_bank_add - Add a process to a given bank
+ * @b  : pointer to a bank 
+ * @p  : pointer to a process
+ *
+ * add a data to a bank by setting lists. Other fields are unchanged
+ *
+ * If an error is encountered, a negative value is returned. 
+ * It can not return 0.
+ *
+ * Here are steps to perform
+ *  
+ *   1) Check arguments
+ *   2) Check if process is already in the bank
+ *   3) Initialize its fields
+ *   4) Return BID
+ */
+int elsa_bank_add(struct elsa_bank *b, struct elsa_data *d)
+{
+	if (!b || !d || !(d->process)) {
+		dprintk("elsa_bank_add: Wrong parameters\n");
+		return -EINVAL;
+	}
+
+	/* Bank ID cannot be equal to 0 */
+	BUG_ON(b->bid == 0);
+
+	/* check if process is already present */
+	if (elsa_process_present(d->process, b))
+		/* Process already in the bank, so we can not add it */
+		return -EPERM;
+
+	/* Set BID */
+	d->bid = b->bid;
+
+	/* Add data in the list of bank's data */
+	list_add(&(d->data_list), &(b->data_head));
+
+	/* Add data in the list of process's bank */
+	write_lock_irq(&tasklist_lock);
+	list_add(&(d->bank_list), &(d->process->bank_head));
+	write_unlock_irq(&tasklist_lock);
+
+	dprintk("elsa_bank_add: Add process #%d to bank #%d\n", d->process->pid,
+		b->bid);
+
+	return b->bid;
+}
+
+/**
+ * elsa_bank_remove - Remove a process to a given bank
+ * @b: pointer to the bank
+ * @d: pointer to the process
+ *
+ * Removes a given process from a given bank. 
+ * Return 0 if succedeed, negative value otherwise
+ */
+int elsa_bank_remove(struct elsa_data *d)
+{
+	int b_empty = 0;
+	struct elsa_bank *b = NULL;	/*  Used if d is the last 
+					   item of the bank */
+
+	if (!d)
+		return -EINVAL;
+
+	/* bank will be empty if d is the last item in the bank */
+	if (d->data_list.next == d->data_list.prev) {
+		b_empty = 1;
+		b = elsa_get_bank(d->bid);
+	}
+
+	/* kfree memory */
+	elsa_data_free(d);
+
+	/* 
+	 * We must free bank after data otherwise we will miss 
+	 * accounting informations 
+	 */
+	if (b_empty)
+		elsa_bank_free(b);
+
+	return 0;
+}
+
+/**
+ * elsa_bank_clean - Removes all datas in a given bank
+ * @b: pointer to the bank to be removed
+ *
+ * Removes data found in a bank given as paramater. It go through the
+ * list, removes link and free space occupied by the data.
+ * Return 0 if succedeed, negative value otherwise
+ */
+int elsa_bank_clean(struct elsa_bank *b)
+{
+	if (!b) {
+		/* bank doesn't exist */
+		dprintk("elsa_bank_clean: bank doesn't exist\n");
+		return -EAGAIN;
+	}
+
+	/* release all datas and remove the bank */
+	while (!list_empty(&(b->data_head))) {
+		/* get pointer to the first element in the list */
+		struct elsa_data *d = list_entry(b->data_head.next,
+						 struct elsa_data, data_list);
+		elsa_data_free(d);
+	}
+
+	elsa_bank_free(b);
+
+	return 0;
+}
+
+/**
+ * elsa_process_remove - Remove a process from all banks that it belongs
+ * @p: pointer to the process to be removed
+ *
+ * Removes process from all banks
+ * Return 0 if succedeed, negative value otherwise
+ */
+int elsa_process_remove(struct task_struct *p)
+{
+
+	if (!p) {
+		/* bank doesn't exist */
+		dprintk("elsa_process_remove: process doesn't exist\n");
+		return -EAGAIN;
+	}
+
+	/* release all datas and remove the bank */
+	while (!list_empty(&(p->bank_head))) {
+		/* get pointer to the first element in the list */
+		struct elsa_data *d = list_entry(p->bank_head.next,
+						 struct elsa_data, bank_list);
+		elsa_bank_remove(d);
+	}
+
+	return 0;
+}
+
+/**
+ * elsa_get_bank - Returns a pointer to a bank
+ * @bid: The identifier of a bank
+ * 
+ * Finds the bank with given ID in the list of banks
+ */
+struct elsa_bank *elsa_get_bank(unsigned int bid)
+{
+	struct list_head *entry;
+
+	list_for_each(entry, &(elsa_broot.bank_head)) {
+		struct elsa_bank *b =
+		    list_entry(entry, struct elsa_bank, bank_list);
+		if (b->bid == bid)
+			return b;
+	}
+
+	return NULL;
+}
+
+/**
+ * elsa_get_data - Returns a pointer to the container of a 
+ *                 given pid in a given bank.
+ * @pid: The identifier of the process
+ * 
+ * Find the data that holds process #PID in a given bank. If
+ * not found, NULL is returned.
+ */
+struct elsa_data *elsa_get_data(unsigned int pid, unsigned int bid)
+{
+	struct list_head *entry;
+	struct task_struct *p;
+
+	read_lock(&tasklist_lock);
+	p = find_task_by_pid(pid);
+	read_unlock(&tasklist_lock);
+
+	list_for_each(entry, &(p->bank_head)) {
+		struct elsa_data *d =
+		    list_entry(entry, struct elsa_data, bank_list);
+		if (d->bid == bid)
+			/* Got it */
+			return d;
+	}
+
+	return NULL;
+}
+
+/**
+ * elsa_process_present - Returns 1 if process is in the bank
+ * @p: the process identifier to look for
+ * @b: the bank in which we must look.
+ * 
+ * Return 1 if process is present in a bank, 0 otherwise
+ */
+int elsa_process_present(struct task_struct *p, struct elsa_bank *b)
+{
+	struct list_head *entry;
+
+	list_for_each(entry, &(b->data_head)) {
+		struct elsa_data *d =
+		    list_entry(entry, struct elsa_data, data_list);
+		if (d->process == p) {
+			/* Found it */
+			return 1;
+		}
+	}
+
+	/* Process not found in b */
+	return 0;
+}
+
+/* memory management */
+EXPORT_SYMBOL(elsa_bank_alloc);
+EXPORT_SYMBOL(elsa_data_alloc);
+EXPORT_SYMBOL(elsa_bank_free);
+EXPORT_SYMBOL(elsa_data_free);
+
+/* data manipulation */
+EXPORT_SYMBOL(elsa_bank_add);
+EXPORT_SYMBOL(elsa_bank_remove);
+EXPORT_SYMBOL(elsa_bank_clean);
+EXPORT_SYMBOL(elsa_process_remove);
+
+/* get informations */
+EXPORT_SYMBOL(elsa_get_bank);
+EXPORT_SYMBOL(elsa_get_data);
+EXPORT_SYMBOL(elsa_process_present);
+
+ /*****************************************************************************
+ * Following functions are called from kernel function.                       *
+ *   elsa_copy_parent_bank() is used when child is created (kernel/fork.c)  *
+ *****************************************************************************/
+
+/**
+ * elsa_copy_parent_bank - Add a given process to the same banks 
+ *                          as another one
+ * @from: Process from where we will copy information
+ * @to: Process to where we will copy information 
+ * 
+ * Goes through the banks to which "from" process belong and add 
+ * the process in those banks. 
+ *
+ * It is used when doing a fork (kernel/fork.c - copy_process()). 
+ * This function is used by the kernel to update child's banks.
+ */
+void elsa_copy_parent_bank(struct task_struct *from, struct task_struct *to)
+{
+	struct list_head *entry;
+
+	/* 
+	 * First, initialize to->bank_head otherwise, if 
+	 * from->bank_head is NULL it won't be initialize
+	 */
+	write_lock_irq(&tasklist_lock);
+	INIT_LIST_HEAD(&(to->bank_head));
+	write_unlock_irq(&tasklist_lock);
+
+	list_for_each(entry, &(from->bank_head)) {
+		struct elsa_bank *b;
+		struct elsa_data *d_from;
+		struct elsa_data *d_to;
+
+		dprintk("elsa_copy_parent_bank: from pid#%d to pid#%d\n",
+			from->pid, to->pid);
+
+		d_from = list_entry(entry, struct elsa_data, bank_list);
+		if (!d_from)
+			return;
+
+		/* allocat space to new data */
+		d_to = elsa_data_alloc();
+		if (!d_to) {
+			printk("elsa_copy_parent_bank: Cannot create data\n");
+			return;
+		}
+
+		d_to->bid = d_from->bid;
+		d_to->process = to;
+
+		/* d_to->process is set so we can call elsa_bank_add */
+		b = elsa_get_bank(d_from->bid);
+		if (!b) {
+			elsa_data_free(d_to);
+			printk
+			    ("elsa_copy_parent_bank: Destination not found\n");
+			return;
+		}
+
+		if (b->bid != elsa_bank_add(b, d_to)) {
+			elsa_data_free(d_to);
+			printk("elsa_copy_parent_bank: Copy error\n");
+			return;
+		}
+	}
+}
+
+ /*********************************
+ * functions used to manage /proc *
+ *                                *
+ * The entry is /proc/bankinfo    *
+ *********************************/
+
+/***
+ * Add an entry in /proc to get informations concerning
+ * banks. This entry is called /proc/bankinfo
+ ****/
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
+	if (list_empty(&elsa_broot.bank_head))
+		return NULL;
+
+	p = elsa_broot.bank_head.next;
+	while (n--) {
+		p = p->next;
+		if (p == &elsa_broot.bank_head)
+			return NULL;
+	}
+
+	/* we return a pointer to the data in the bank */
+	return list_entry(p, struct elsa_bank, bank_list);
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
+	return bank->bank_list.next == &elsa_broot.bank_head ? NULL :
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
+			list_for_each_entry(data, &(bank->data_head), data_list)
+			    seq_printf(m, "%d ", data->process->pid);
+		}
+		/* add EOL */
+		seq_printf(m, "\n");
+	}
+
+	return 0;
+}
+
+/* bankinfo_op - iterator that generates /proc/bankinfo
+ *
+ * Output layout:
+ * bankID	pid ...
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
diff -uprN -X elsa_import/dontdiff linux-2.6.6/drivers/elsacct/elsacct.c linux-2.6.6-elsa/drivers/elsacct/elsacct.c
--- linux-2.6.6/drivers/elsacct/elsacct.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.6-elsa/drivers/elsacct/elsacct.c	2004-05-12 07:24:41.389160480 +0200
@@ -0,0 +1,438 @@
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
+static int elsa_major;
+static struct elsa_acct acct_info = ELSA_ACCT_INIT;
+
+/**
+ *  encode_comp_t - encode an unsigned long into a comp_t
+ *  @value: value to encode
+ *
+ *  This routine has been adopted from the encode_comp_t() function in
+ *  the kern_acct.c file of the FreeBSD operating system. The encoding
+ *  is a 13-bit fraction with a 3-bit (base 8) exponent. 
+ *
+ *  This routine is taken from kernel/acct.c
+ */
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
+ /**************************
+ * Accounting is done here *
+ **************************/
+/*
+ * It's just for testing (Can not choose file)
+ */
+/**
+ * do_elsacct_data - Update accounting information when bank is removed
+ * @b: pointer to bank's data
+ *
+ * We copy code from BSD accounting. It's just to test accounting
+ * Result is written in a file (you can not choose it for now).
+ * It returns 0 if succeded, negative value otherwise
+ */
+static int do_elsacct_bank(struct elsa_bank *b)
+{
+	struct elsa_acct *info = (struct elsa_acct *)b->info;
+	struct file *file = NULL;
+	mm_segment_t old_fs;
+
+	if (!info)
+		return -EINVAL;
+
+	/* Set bank ID */
+	info->eac_bid = b->bid;
+
+	/* Open file where accounting information will be written */
+	file = filp_open(ELSACCT_FILE, O_CREAT | O_WRONLY | O_APPEND, 0666);
+
+	if (IS_ERR(file)) {
+		return (PTR_ERR(file));
+	}
+
+	if (!S_ISREG(file->f_dentry->d_inode->i_mode)) {
+		filp_close(file, NULL);
+		return (-EACCES);
+	}
+
+	if (!file->f_op->write) {
+		filp_close(file, NULL);
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
+	file->f_op->write(file, (char *)info, sizeof(struct elsa_acct),
+			  &file->f_pos);
+
+	set_fs(old_fs);
+
+	filp_close(file, NULL);
+	return 0;
+}
+
+/**
+ * do_elsacct_data - Update accounting information when data is removed
+ * @b: pointer to bank's data
+ * @d: pointer to the data
+ *
+ * We copy code from BSD accounting. It's just to test accounting
+ * It returns 0 if succeded, negative value otherwise
+ */
+static int do_elsacct_data(struct elsa_bank *b, struct elsa_data *d)
+{
+	u64 elapsed;
+	struct elsa_acct *info = (struct elsa_acct *)b->info;
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
+	info->eac_etime += encode_comp_t(elapsed < (unsigned long)-1l ?
+					 (unsigned long)elapsed : (unsigned
+								   long)-1l);
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
+int do_elsacct(int opcode, struct elsa_bank *b, struct elsa_data *d)
+{
+	int retval = 0;
+
+	switch (opcode) {
+	case ELSA_BANK_CALLBACK:
+		BUG_ON(b == NULL);
+		retval = do_elsacct_bank(b);
+		break;
+	case ELSA_DATA_CALLBACK:
+		BUG_ON(b == NULL);
+		BUG_ON(d == NULL);
+		retval = do_elsacct_data(b, d);
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
+ /**************************************************************
+ * functions used to manipulate the device                     *
+ *                                                             *
+ * The enhanced linux system accounting device is /dev/elsacct *
+ * and the major number is dynamically given by OS             *
+ **************************************************************/
+
+/* 
+ * The process context, represented as a typical driver method - ioctl(), must 
+ * use spin_lock_irq() because it knows that interrupts are always enabled while 
+ * executing the device ioctl() method.
+ */
+spinlock_t elsa_lock = SPIN_LOCK_UNLOCKED;
+
+/**
+ * elsacct_ioctl - issue a device specific command
+ * @inode: pointer to inode structure
+ * @file : file pointer
+ * @cmd  : specific command to perform.
+ * @arg  : arguments that depend of cmd.
+ *
+ * Perform some actions on banks that depend of command passed to the
+ * system call
+ */
+int elsacct_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+		  unsigned long arg)
+{
+	int retval = 0;
+	struct elsa_ioctl_args args;
+	struct task_struct *p;
+	struct elsa_bank *b;
+	struct elsa_data *d;
+
+	/* Recover ioctl parameters */
+	if (copy_from_user(&args, (struct elsa_ioctl_args *)arg,
+			   sizeof(struct elsa_ioctl_args)))
+		return -EFAULT;
+
+	switch (cmd) {
+	case ELSACCT_BANK_REMOVE:
+		/*
+		 * To remove a data from a bank, we need to:
+		 *     1) if #BID == 0
+		 *            get pointer to process
+		 *            remove from all banks that it belongs
+		 *        else
+		 *            get pointer to data
+		 *            remove from bank #BID
+		 *        endif
+		 */
+		if (args.bid == 0) {
+			read_lock(&tasklist_lock);
+			p = find_task_by_pid(args.pid);
+			read_unlock(&tasklist_lock);
+			if (!p) {
+				dprintk("elsacct_ioct: process #%d not found\n",
+					args.pid);
+				return -EAGAIN;
+			}
+
+			spin_lock_irq(&elsa_lock);
+			retval = elsa_process_remove(p);
+			spin_unlock_irq(&elsa_lock);
+		} else {
+
+			d = elsa_get_data(args.pid, args.bid);
+			if (!d) {
+				dprintk("elsacct_ioct: data not found\n");
+				return -EAGAIN;
+			}
+
+			spin_lock_irq(&elsa_lock);
+			retval = elsa_bank_remove(d);
+			spin_unlock_irq(&elsa_lock);
+		}
+		break;
+
+	case ELSACCT_BANK_CLEAN:
+		/*
+		 * To clean a bank (remove all data), we need to:
+		 *     1) Get pointer to the bank
+		 *     2) Remove it
+		 */
+		b = elsa_get_bank(args.bid);
+		if (!b) {
+			dprintk("elsacct_ioct: BANK not found\n");
+			return -EAGAIN;
+		}
+
+		spin_lock_irq(&elsa_lock);
+		retval = elsa_bank_clean(b);
+		spin_unlock_irq(&elsa_lock);
+		break;
+
+	case ELSACCT_BANK_ADD:
+		/*
+		 * To add a process to a bank we need to perform 
+		 * following actions:
+		 *     1) Allocate memory space to data (container)
+		 *     2) Update process in data field
+		 *     3) If #BID == 0
+		 *          create a new bank;
+		 *        else
+		 *          get pointer to bank #BID
+		 *     4) Add the container to the bank
+		 */
+		d = elsa_data_alloc();
+		if (!d)
+			return -ENOMEM;
+
+		/* We need the pointer to task_struct */
+		read_lock(&tasklist_lock);
+		p = find_task_by_pid(args.pid);
+		read_unlock(&tasklist_lock);
+		if (!p) {
+			dprintk("elsacct_ioct: PID#%d not found\n", args.pid);
+			/* Don't forget to release memory */
+			elsa_data_free(d);
+			return -EAGAIN;
+		}
+		d->process = p;
+
+		if (args.bid == 0)
+			b = elsa_bank_alloc(&do_elsacct, &acct_info);
+		else
+			b = elsa_get_bank(args.bid);
+
+		if (!b) {
+			dprintk("elsacct_ioct: BID#%d not found\n", args.bid);
+			/* Don't forget to release memory */
+			elsa_data_free(d);
+			return -EAGAIN;
+		}
+
+		spin_lock_irq(&elsa_lock);
+		retval = elsa_bank_add(b, d);
+		spin_unlock_irq(&elsa_lock);
+		break;
+
+	default:
+		dprintk(KERN_WARNING
+			"elsacct_ioctl: 0x%x unsupported ioctl command\n", cmd);
+		retval = -ENOIOCTLCMD;
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
+ * Initializes "callbacks" to bank and data. Those 
+ * functions are called a bank or a data are destroyed.
+ * It allows to perform some actions in the module.
+ */
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
+ /************************
+ * Module initialization *
+ ************************/
+
+/**
+ * elsacct_init_module - called when module is loaded
+ *
+ * Display a message in dmesg and call the real 
+ * initialization function.
+ */
+static int __init elsacct_init_module(void)
+{
+	dprintk(KERN_INFO "ELSA accounting started\n");
+	return elsacct_init();
+}
+
+/**
+ * elsacct_cleanup - called when module is unloaded
+ *
+ * Display a message in dmesg 
+ */
+static void __exit elsacct_cleanup_module(void)
+{
+	/* release the major number when module is unloaded */
+	if (unregister_chrdev(elsa_major, "elsacct"))
+		dprintk(KERN_WARNING
+			"elsacct_cleanup: cannot unregister blkdev\n");
+	else
+		dprintk(KERN_INFO "elsacct_cleanup: accounting terminated\n");
+}
+
+module_init(elsacct_init_module);
+module_exit(elsacct_cleanup_module);
+
+MODULE_DESCRIPTION("Enhanced Linux System Accounting.");
+MODULE_AUTHOR("Guillaume Thouvenin <guillaume.thouvenin@bull.net>");
+
+MODULE_LICENSE("GPL");
diff -uprN -X elsa_import/dontdiff linux-2.6.6/drivers/elsacct/Kconfig linux-2.6.6-elsa/drivers/elsacct/Kconfig
--- linux-2.6.6/drivers/elsacct/Kconfig	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.6-elsa/drivers/elsacct/Kconfig	2004-05-11 14:19:56.000000000 +0200
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
+	tristate "Enhanced Linux System Accounting"
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
diff -uprN -X elsa_import/dontdiff linux-2.6.6/drivers/elsacct/Makefile linux-2.6.6-elsa/drivers/elsacct/Makefile
--- linux-2.6.6/drivers/elsacct/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.6-elsa/drivers/elsacct/Makefile	2004-05-06 12:39:50.000000000 +0200
@@ -0,0 +1,5 @@
+#
+# Makefile for the Enhanced Linux System Accounting
+#
+obj-$(CONFIG_BANK)	+= bank.o
+obj-$(CONFIG_ELSACCT)	+= elsacct.o
diff -uprN -X elsa_import/dontdiff linux-2.6.6/drivers/Kconfig linux-2.6.6-elsa/drivers/Kconfig
--- linux-2.6.6/drivers/Kconfig	2004-05-10 04:33:20.000000000 +0200
+++ linux-2.6.6-elsa/drivers/Kconfig	2004-05-10 09:45:43.000000000 +0200
@@ -4,6 +4,8 @@ menu "Device Drivers"
 
 source "drivers/base/Kconfig"
 
+source "drivers/elsacct/Kconfig"
+
 source "drivers/mtd/Kconfig"
 
 source "drivers/parport/Kconfig"
diff -uprN -X elsa_import/dontdiff linux-2.6.6/drivers/Makefile linux-2.6.6-elsa/drivers/Makefile
--- linux-2.6.6/drivers/Makefile	2004-05-10 04:33:13.000000000 +0200
+++ linux-2.6.6-elsa/drivers/Makefile	2004-05-10 09:46:10.000000000 +0200
@@ -50,3 +50,4 @@ obj-$(CONFIG_MCA)		+= mca/
 obj-$(CONFIG_EISA)		+= eisa/
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
 obj-y				+= firmware/
+obj-y				+= elsacct/
diff -uprN -X elsa_import/dontdiff linux-2.6.6/include/linux/bank.h linux-2.6.6-elsa/include/linux/bank.h
--- linux-2.6.6/include/linux/bank.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.6-elsa/include/linux/bank.h	2004-05-12 07:24:35.766015328 +0200
@@ -0,0 +1,164 @@
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
+ *         elsa_broot         -----------       ----------- 
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
+#include <linux/spinlock.h>
+
+#define ELSA_BANK_CALLBACK 0
+#define ELSA_DATA_CALLBACK 1
+
+extern rwlock_t elsalist_lock;
+
+/***
+ * Internal structures
+ ***/
+
+struct bank_root {
+	/* 
+	 * We need to protect ID by a semaphore since it must be
+	 * a unique number. We can't have to bank with same ID
+	 */
+	unsigned int next_bid;	/* next available bank identifier */
+	struct list_head freebid_head;	/* a list of free bank identifier - Not used yet */
+	struct list_head bank_head;	/* head of the list of bank */
+};
+
+#define BANK_ROOT_INIT(root) \
+{							     \
+	.next_bid 	= 1,                                 \
+	.freebid_head 	= LIST_HEAD_INIT(root.freebid_head), \
+	.bank_head	= LIST_HEAD_INIT(root.bank_head),    \
+}
+
+struct elsa_freebid {
+	int bid;
+	struct list_head bid_list;
+};
+
+struct elsa_data;		/* Needed in struct elsa_bank */
+
+struct elsa_bank {
+	int bid;		/* the bank identifier */
+	void *info;		/* allow to hang information to banks */
+	int (*callback) (int, struct elsa_bank *, struct elsa_data *);	/* callback */
+	struct list_head bank_list;	/* list of available banks */
+	struct list_head data_head;	/* head of the list of datas in the 
+					   bank */
+};
+
+struct elsa_data {
+	int bid;		/* the bank to which data belong */
+	struct task_struct *process;	/* the process information */
+	struct list_head data_list;	/* link between datas in a bank */
+	struct list_head bank_list;	/* used by a process to link banks 
+					   that contains it */
+};
+
+#ifdef CONFIG_PROC_FS
+extern struct file_operations proc_bankinfo_ops;
+#endif
+
+ /*********************************************
+ * Following functions can be use by a module *
+ * (=> they are exported)                     *
+ *********************************************/
+
+/* allocate memory space: (call to kmalloc) */
+struct elsa_bank
+*elsa_bank_alloc(int (*fn) (int, struct elsa_bank *, struct elsa_data *),
+		 void *);
+struct elsa_data *elsa_data_alloc(void);
+void elsa_bank_free(struct elsa_bank *bank);
+void elsa_data_free(struct elsa_data *data);
+
+/* 
+ * manipulate datas:
+ * Memory space can be released (call to kfree) in the last three
+ * functions.
+ */
+int elsa_bank_add(struct elsa_bank *b, struct elsa_data *d);
+int elsa_bank_remove(struct elsa_data *d);
+int elsa_bank_clean(struct elsa_bank *b);
+/* elsa_process_remove() is used by the kernel so it is declared below */
+
+/* get information */
+struct elsa_bank *elsa_get_bank(unsigned int bid);
+struct elsa_data *elsa_get_data(unsigned int pid, unsigned int bid);
+int elsa_process_present(struct task_struct *p, struct elsa_bank *b);
+
+ /*****************************************************************************
+ * Following functions are called from kernel function.                       *
+ *   elsa_copy_parent() is used when child is created (kernel/fork.c)         *
+ *   elsa_process_remove() is used when a process terminates (kernel/exit.c) *
+ *****************************************************************************/
+#ifdef CONFIG_BANK
+extern void elsa_copy_parent_bank(struct task_struct *from,
+				  struct task_struct *to);
+extern int elsa_process_remove(struct task_struct *p);
+#else
+#define elsa_copy_parent_bank(a,b) do {} while(0)
+#define elsa_bank_remove_all(a)    do {} while(0)
+#endif				/* !(CONFIG_BANK) */
+
+#endif				/* !(__LINUX_BANK_H) */
diff -uprN -X elsa_import/dontdiff linux-2.6.6/include/linux/elsacct.h linux-2.6.6-elsa/include/linux/elsacct.h
--- linux-2.6.6/include/linux/elsacct.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.6-elsa/include/linux/elsacct.h	2004-05-12 07:24:32.067577576 +0200
@@ -0,0 +1,55 @@
+/*
+ *  include/linux/elsa_acct.h
+ * 
+ *  ELSA - Enhanced Linux System Accounting
+ *  Guillaume Thouvenin - 26/04/2004
+ *      
+ */
+
+#ifndef __LINUX_ELSACCT_H
+#define __LINUX_ELSACCT_H
+
+/* IOCTL numbers */
+#define ELSACCT_MAGIC		0x3538
+
+#define ELSACCT_BANK_REMOVE	0x353801	/* Remove one data from a bank, 
+						 * if #BID == 0 remove from all banks */
+#define ELSACCT_BANK_CLEAN	0x353802	/* Remove all data from a bank */
+#define ELSACCT_BANK_ADD	0x353803	/* Add a process to a bank,
+						 * if #BID == 0 create the bank */
+
+/* Currently, informations are stored in the same file and we cannot chose it */
+#define ELSACCT_FILE	"/var/log/bank"
+
+struct elsa_ioctl_args {
+	unsigned int bid;	/* bank identifier */
+	unsigned int pid;	/* process identifier */
+};
+
+/* 
+ * Currently, we take as a starting point the BSD-style 
+ * process accounting and we write values into dmesg
+ * buffer. (of course we need to change this) 
+ */
+struct elsa_acct {
+	int eac_bid;		/* Bank id */
+	int eac_ptot;		/* Total number of process that are added to a bank */
+	int eac_utime;		/* Accounting User Time */
+	int eac_stime;		/* Accounting System Time */
+	int eac_etime;		/* Accounting Elapsed Time */
+	int eac_minflt;		/* Accounting Minor Pagefaults */
+	int eac_majflt;		/* Accounting Major Pagefaults */
+};
+
+#define ELSA_ACCT_INIT 		\
+{ 				\
+	.eac_bid 	= 0,	\
+	.eac_ptot	= 0,	\
+	.eac_utime	= 0,	\
+	.eac_stime	= 0,	\
+	.eac_etime	= 0,	\
+	.eac_minflt 	= 0,	\
+	.eac_majflt 	= 0,	\
+}
+
+#endif				/* !(__LINUX_ELSACCT_H) */
diff -uprN -X elsa_import/dontdiff linux-2.6.6/include/linux/init_task.h linux-2.6.6-elsa/include/linux/init_task.h
--- linux-2.6.6/include/linux/init_task.h	2004-05-10 04:32:00.000000000 +0200
+++ linux-2.6.6-elsa/include/linux/init_task.h	2004-05-10 09:48:18.000000000 +0200
@@ -112,6 +112,7 @@ extern struct group_info init_groups;
 	.proc_lock	= SPIN_LOCK_UNLOCKED,				\
 	.switch_lock	= SPIN_LOCK_UNLOCKED,				\
 	.journal_info	= NULL,						\
+	.bank_head	= LIST_HEAD_INIT(tsk.bank_head),		\
 }
 
 
diff -uprN -X elsa_import/dontdiff linux-2.6.6/include/linux/sched.h linux-2.6.6-elsa/include/linux/sched.h
--- linux-2.6.6/include/linux/sched.h	2004-05-10 04:32:00.000000000 +0200
+++ linux-2.6.6-elsa/include/linux/sched.h	2004-05-10 09:50:04.000000000 +0200
@@ -504,6 +504,9 @@ struct task_struct {
 
 	unsigned long ptrace_message;
 	siginfo_t *last_siginfo; /* For ptrace use.  */
+
+/* List of BANK to which the process belong -- Used by ELSA */
+	struct list_head bank_head;
 };
 
 static inline pid_t process_group(struct task_struct *tsk)
diff -uprN -X elsa_import/dontdiff linux-2.6.6/kernel/exit.c linux-2.6.6-elsa/kernel/exit.c
--- linux-2.6.6/kernel/exit.c	2004-05-10 04:33:19.000000000 +0200
+++ linux-2.6.6-elsa/kernel/exit.c	2004-05-10 09:55:57.000000000 +0200
@@ -59,6 +59,7 @@ repeat: 
 	atomic_dec(&p->user->processes);
 	spin_lock(&p->proc_lock);
 	proc_dentry = proc_pid_unhash(p);
+	elsa_process_remove(p);
 	write_lock_irq(&tasklist_lock);
 	if (unlikely(p->ptrace))
 		__ptrace_unlink(p);
diff -uprN -X elsa_import/dontdiff linux-2.6.6/kernel/fork.c linux-2.6.6-elsa/kernel/fork.c
--- linux-2.6.6/kernel/fork.c	2004-05-10 04:32:00.000000000 +0200
+++ linux-2.6.6-elsa/kernel/fork.c	2004-05-10 09:57:36.000000000 +0200
@@ -1011,6 +1011,19 @@ struct task_struct *copy_process(unsigne
 	INIT_LIST_HEAD(&p->ptrace_children);
 	INIT_LIST_HEAD(&p->ptrace_list);
 
+        /*
+         * Child is in the same BANK as parent. So we copy the list of banks
+         * from current to p. We can not just counting reference on the structure
+         * because the may evoluate in differents way. I think it's easier to
+         * do like this but maybe I'm wrong... -- guillaume
+         *
+         * We put that call outside lock_irq because elsa_copy_parent_bank
+         * uses kmalloc(GFP_KERNEL). Therefore, as we modify task_struct,
+         * we manage lock_irq ourselves. -- guillaume
+         *
+         */
+        elsa_copy_parent_bank(current, p);
+	
 	/* Need tasklist lock for parent etc handling! */
 	write_lock_irq(&tasklist_lock);
 	/*
diff -uprN -X elsa_import/dontdiff linux-2.6.6/Makefile linux-2.6.6-elsa/Makefile
--- linux-2.6.6/Makefile	2004-05-10 04:32:53.000000000 +0200
+++ linux-2.6.6-elsa/Makefile	2004-05-10 09:58:01.000000000 +0200
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 6
-EXTRAVERSION =
+EXTRAVERSION = -elsa
 NAME=Zonked Quokka
 
 # *DOCUMENTATION*


--------------020009030006040600060505--

