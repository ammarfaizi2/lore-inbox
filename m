Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264786AbUEEUWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264786AbUEEUWJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 16:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264801AbUEEUWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 16:22:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:58527 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264786AbUEEUTC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 16:19:02 -0400
Date: Wed, 5 May 2004 13:18:59 -0700
From: Chris Wright <chrisw@osdl.org>
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Enhanced Linux System Accounting
Message-ID: <20040505131859.V22989@build.pdx.osdl.net>
References: <4098EB80.2060908@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <4098EB80.2060908@bull.net>; from guillaume.thouvenin@bull.net on Wed, May 05, 2004 at 03:26:24PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Guillaume Thouvenin (guillaume.thouvenin@bull.net) wrote:
>        o  provide an environment that can support System V accounting
>        o  provide a unify interface from existing accounting tools (like
> sar) to be used by existing Linux administrative tools (like WebMin)

I don't see why this can't be done under PAGG or CKRM, however that one
falls out.

> Any feedbacks, any comments are welcome

I think this thing needs a lot of work.  The locking is a major
issue, as is the ioctl args,unclear API, layering, and coding style.
It's difficult to see the layers in this design.  Seems bank and elsacct
overlap too much.

> diff -uprN -X elsa_import/dontdiff linux-2.6.5/drivers/elsacct/bank.c linux-2.6.5-elsa/drivers/elsacct/bank.c
> --- linux-2.6.5/drivers/elsacct/bank.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.5-elsa/drivers/elsacct/bank.c	2004-05-05 11:07:06.535625584 +0200
> @@ -0,0 +1,657 @@
> +/*
> + *  driver/elsacct/bank.c
> + * 
> + *  ELSA - Enhanced Linux System Accounting
> + *  Guillaume Thouvenin - 26/04/2004
> + *
> + *  This file implements Enhanced Linux System Accounting. It 
> + *  provides structure and functions to manipulate "BANK". 
> + *
> + * 
> + *  This code is licenced under GPL.
> + */
> +
> +#include <linux/slab.h>
> +#include <linux/mm.h>
> +#include <linux/sched.h>
> +#include <linux/errno.h>
> +#include <linux/seq_file.h>
> +#include <linux/module.h>
> +
> +#include <asm/semaphore.h>
> +
> +#include <linux/bank.h>

asm includes go last

> +/* It's the head on the list of banks */
> +static struct bank_root_s elsa_broot = BANK_ROOT_INIT(elsa_broot);

no need for noisy names like struct foo_s (just drop the _s).

> +
> +/* semaphore that protect access to bank id */
> +static DECLARE_MUTEX(elsa_bid_sem);

locking is unclear.  what protects the elsa_broot

> +
> + /**************************************************
> + * Here are declaration of functions that are only * 
> + * used in this file                               *
> + **************************************************/
> +
> +/* get informations */
> +static int elsa_get_bid(void);
> +static struct elsa_bank_s *elsa_get_bank(int bid);
> +static struct elsa_data_s *elsa_get_data(struct elsa_bank_s *bank,
> +					 struct task_struct *p);
> +
> +/* manage memory space used by banks */
> +static int elsa_bank_alloc(void);
> +static int elsa_bank_free(struct elsa_bank_s *bank);
> +
> +/* manage bank's data */
> +static void elsa_data_free(struct elsa_data_s *data);
> +
> + /************************************************
> + * Following functions can be use by a module or *
> + * a system call (=> they are exported)          *
> + ************************************************/
> +
> +/**
> + * elsa_bank_set_info - Set pointer to information in 
> + *                      bank structure 
> + * @bid: bank identifier
> + * @info: pointer to information to link with the bank
> + */
> +int elsa_bank_set_info(int bid, void *info)
> +{
> +	struct elsa_bank_s *bank = elsa_get_bank(bid);
> +
> +	if (bank)
> +		bank->info = info;
> +	else
> +		return -EAGAIN;
> +
> +	return bid;
> +}
> +
> +void *elsa_bank_get_info(int bid)
> +{
> +	struct elsa_bank_s *bank = elsa_get_bank(bid);
> +
> +	return (bank) ? bank->info : NULL;
> +}
> +
> +/**
> + * elsa_bank_init_cb - Initialize callbacks
> + * @bank_cb: function to call when bank is deleted
> + * @data_cb: function to call when data is deleted
> + *
> + * Initializes callbacks when bank and data are removed from a 
> + * list.
> + */
> +void elsa_bank_init_cb(void *bank_cb, void *data_cb)
> +{
> +	elsa_broot.bank_cb = bank_cb;
> +	elsa_broot.data_cb = data_cb;
> +}

This is exported, and can be called from other modules, but updates the
elsa_broot?  This is racy and seems odd way to do it.

> +
> +/**
> + * elsa_bank_add - Add a process to a given bank
> + * @bid: bank identifier
> + * @p  : pointer to a process
> + *
> + * Creates a new bank if BID is equal to 0, otherwise, add data
> + * to bank BID.
> + *
> + * If an error is encountered, a negative value is returned. 
> + * It can not return 0.
> + *
> + * Here are steps to perform
> + *  
> + *   1) get the bank with id bid
> + *      If we don't find it, there is a bug since this function is used to
> + *      add a child in parent's bank. Thus, there is at least the parent in
> + *      the bank
> + *   2) Allocate space to the new data
> + *   3) Initialize its fields
> + */
> +int elsa_bank_add(int bid, struct task_struct *p)
> +{
> +	struct elsa_bank_s *bank;
> +	struct elsa_data_s *data;
> +
> +	/* 
> +	 * Create a new bank if bid is equal to zero, 
> +	 * otherwise, find the bank with id equal to bid
> +	 */
> +	if (!bid) {
> +		/* create a new bank */
> +		bid = elsa_bank_alloc();

No error check on alloc.

> +		bank = elsa_get_bank(bid);

This is a weird interface.  Just return the pointer to the object, not
some id where you have to go and lookup the object.

> +		/* At this point bank != NULL or it is a bug */
> +		if (!bank) {
> +			printk("elsa_bank_add: found a bug !!!");
> +			return -EPROTO;

Try BUG_ON() or WARN_ON().

> +		}
> +	} else {
> +		bank = elsa_get_bank(bid);
> +		if (!bank) {
> +			printk("elsa_bank_add: Bank ID#%d not found\n", bid);

Too verbose.

> +			return -ENODATA;
> +		}
> +	}
> +
> +	/* 
> +	 * At this point, bank exists, we check if process is 
> +	 * already present 
> +	 */
> +	if (elsa_get_data(bank, p) != NULL)
> +		/* Process already in the bank, nothing to do */
> +		return bid;
> +
> +	/* allocate space to data */
> +	data =
> +	    (struct elsa_data_s *)kmalloc(sizeof(struct elsa_data_s),
> +					  GFP_KERNEL);
> +	if (!data) {
> +#ifdef CONFIG_ELSACCT_DEBUG
> +		printk("elsa_bank_add: cannot allocate space for data\n");
> +#endif

Don't litter with ifdefs.  Use a dprintk() or similar.

> +		return -ENOMEM;

leaks the bank you may have just allocated.

> +	}
> +
> +	/* initialize data */
> +	data->bid = bid;
> +	data->process = p;
> +	list_add(&(data->data_list), &(bank->data_head));
> +	list_add(&(data->bank_list), &(p->bank_head));
> +
> +#ifdef CONFIG_ELSACCT_DEBUG
> +	printk("elsa_bank_add: Add process #%d to bank #%d\n", p->pid, bid);
> +#endif

dprintk

> +
> +	return bid;
> +}
> +
> +/**
> + * elsa_bank_clean - Removes data in a given bank
> + * @bid: identifier of the bank to clean
> + *
> + * Removes data found in a bank given in paramater. It go through the
> + * list, removes link and free space occupied by the data.
> + */
> +int elsa_bank_clean(int bid)
> +{
> +	struct elsa_bank_s *bank;
> +	struct elsa_data_s *data;
> +
> +	bank = elsa_get_bank(bid);
> +	if (!bank) {
> +		/* bank doesn't exist */
> +		printk("elsa_bank_clean: bank doesn't exist\n");

Too verbose.

> +		return -EAGAIN;
> +	}
> +
> +	/* release all datas and remove the bank */
> +	while (!list_empty(&(bank->data_head))) {
> +		/* get pointer to the first element in the list */
> +		data = list_entry(bank->data_head.next,
> +				  struct elsa_data_s, data_list);
> +		if (data)
> +			elsa_data_free(data);
> +	}
> +
> +	return bid;
> +}
> +
> +/**
> + * elsa_bank_remove - Remove a process to one
> + * @bid: identifier of the bank where the process will be removed
> + * @pid: identifier of the process to be removed 
> + *
> + * Removes a given process from a given list. If parameter bid is equal to 
> + * zero, the process is removed from all banks. It returns the identifier 
> + * of the bank from which it is removed. 
> + */
> +int elsa_bank_remove(int bid, pid_t pid)
> +{
> +	struct elsa_data_s *data = NULL;
> +	struct task_struct *p = find_task_by_pid(pid);

no task_list locking

> +	int found = 0;
> +
> +	if (bid == 0) {
> +		elsa_bank_remove_all(p);
> +		return 0;
> +	}
> +
> +	/* found bank with identifier equal to BID */
> +	if (!list_empty(&(p->bank_head)))
> +		list_for_each_entry(data, &(p->bank_head), bank_list)
> +		    if (data->bid == bid) {
> +			found = bid;
> +			break;
> +		}
> +
> +	if (found && data)
> +		elsa_data_free(data);
> +
> +	return found;
> +}
> +
> +EXPORT_SYMBOL(elsa_bank_set_info);
> +EXPORT_SYMBOL(elsa_bank_get_info);
> +EXPORT_SYMBOL(elsa_bank_init_cb);
> +EXPORT_SYMBOL(elsa_bank_add);
> +EXPORT_SYMBOL(elsa_bank_clean);
> +EXPORT_SYMBOL(elsa_bank_remove);
> +
> + /*****************************************************************************
> + * Following functions are called from kernel function.                       *
> + *   elsa_copy_parent_bank() is used when child is created (kernel/fork.c)  *
> + *   elsa_bank_remove_all() is used when a process terminates (kernel/exit.c) *
> + *****************************************************************************/
> +
> +/**
> + * elsa_copy_parent_bank - Add a given process to the same banks 
> + *                          as another one
> + * @from: Process from where we will copy information
> + * @to: Process to where we will copy information 
> + * 
> + * Goes through the banks to which "from" process belong and add 
> + * the process in those banks. 
> + *
> + * It is used when doing a fork (kernel/fork.c - copy_process()). 
> + * This function is used by the kernel to update child's banks.
> + */
> +void elsa_copy_parent_bank(struct task_struct *from, struct task_struct *to)
> +{
> +	struct elsa_data_s *data;
> +
> +	if (!list_empty(&from->bank_head))
> +		list_for_each_entry(data, &(from->bank_head), bank_list) {
> +#ifdef CONFIG_ELSACCT_DEBUG
> +		printk("elsa_copy_parent_bank: from pid#%d to pid#%d\n",
> +		       from->pid, to->pid);

Just do dprintk() 

> +		if (data->bid == 0)
> +			printk("elsa_copy_parent_bank: Find a bug\n");

How about BUG_ON()?

> +#endif
> +		elsa_bank_add(data->bid, to);
> +		}
> +}
> +
> +/**
> + * elsa_bank_remove_all - Remove a process to all belonging banks
> + * @p: a pointer to the process to remove from banks
> + *
> + * Removes the process from all banks. We use field "bank_head" of the
> + * task_struct. So, this new field has been placed in the task_struct
> + * only to allow to remove a processus from all banks to which it belongs. 
> + * If it is the last process in the bank, the bank is released
> + */
> +void elsa_bank_remove_all(struct task_struct *p)
> +{
> +	struct elsa_data_s *data;
> +
> +	/* remove from all banks */
> +	while (!list_empty(&p->bank_head)) {
> +		data = list_entry(p->bank_head.next,
> +				  struct elsa_data_s, bank_list);
> +		if (data)
> +			elsa_data_free(data);
> +	}
> +}
> +
> + /******************************************************************
> + * As said at the begin of this file, following functions are only *
> + * for internal usage.                                             *
> + ******************************************************************/
> +
> +/**
> + * elsa_get_bid - Returns a bank identifier
> + *
> + * Retruns an available bank identifier. It first looks
> + * if there is one in the list of freebid, if not, it tests
> + * if there is still free id (equivalent to next_bid > 0). 
> + * If yes, it update next_bid returns the identifier. 
> + * If an error is encountered, a negative value is returned. 
> + * It can not return 0.
> + */
> +static int elsa_get_bid(void)
> +{
> +	struct elsa_freebid_s *freebid;
> +	int bid;
> +
> +	down(&elsa_bid_sem);
> +
> +	/* if there is one in the freebid list use it */
> +	if (!list_empty(&(elsa_broot.freebid_head))) {
> +		/* get the first entry in the list */
> +		freebid =
> +		    list_entry(elsa_broot.freebid_head.next,
> +			       struct elsa_freebid_s, bid_list);
> +
> +		/* got it */
> +		bid = freebid->bid;
> +
> +		/* remove it from the list */
> +		list_del(&(freebid->bid_list));
> +
> +		/* free space */
> +		kfree(freebid);
> +	} else {
> +		/* test if there is one available free ID */
> +		if (elsa_broot.next_bid <= 0) {
> +			/* there is no more banks */
> +			bid = -ENODATA;
> +		} else {
> +
> +			bid = elsa_broot.next_bid;
> +			elsa_broot.next_bid++;
> +		}
> +	}
> +
> +	up(&elsa_bid_sem);
> +	return bid;
> +}
> +
> +/**
> + * elsa_get_bank - Returns a pointer to a bank
> + * @bid: The identifier of a bank
> + * 
> + * Finds the bank with given ID in the list of banks
> + */
> +static struct elsa_bank_s *elsa_get_bank(int bid)
> +{
> +	struct elsa_bank_s *bank = NULL;
> +	int found = 0;
> +
> +	if (!list_empty(&(elsa_broot.bank_head)))

list_for_each will figure that out

> +		list_for_each_entry(bank, &(elsa_broot.bank_head), bank_list)
> +		    if (bank->bid == bid) {
> +			found = bid;
> +			break;
> +		}
> +
> +	return found ? bank : NULL;
> +}
> +
> +/**
> + * elsa_get_data - Returns a pointer to a data
> + * @bank: a pointer to the container in which we are looking for the data
> + * @pid: the process identifier to look for
> + * 
> + * Finds a data that points to a process if it exists.  
> + */
> +static struct elsa_data_s *elsa_get_data(struct elsa_bank_s *bank,
> +					 struct task_struct *p)
> +{
> +	struct elsa_data_s *data = NULL;
> +	int found = 0;
> +
> +	if (!list_empty(&(bank->data_head))) {

list_for_each will figure that out

> +		list_for_each_entry(data, &(bank->data_head), data_list) {
> +			if (data->process == p) {
> +#ifdef CONFIG_ELSACCT_DEBUG
> +				printk("elsa_get_data: found PID#%d\n", p->pid);
> +#endif

dprintk

> +				found = 1;
> +				break;
> +			}
> +		}
> +	}
> +
> +	/* if found != 0 then we return data */
> +	return found ? data : NULL;
> +}
> +
> +/**
> + * elsa_bank_alloc - Allocates a new bank
> + * 
> + * Allocates a new bank and returns the identifiers of the new created bank.
> + * If an error is encountered, a negative value is returned. 
> + * It can not return 0.
> + *
> + * Here are different steps of the operation
> + *
> + *   1) Allocate space for the new bank
> + *   2) Give it an identifier
> + *   3) Initialize the head of the list of items (items will point to process)
> + *   3) Add it to the list of available bank
> + */
> +static int elsa_bank_alloc(void)
> +{
> +	struct elsa_bank_s *new_bank;
> +	int new_bid;
> +
> +	/* allocate space for the new bank */
> +	new_bank =
> +	    (struct elsa_bank_s *)kmalloc(sizeof(struct elsa_bank_s),
> +					  GFP_KERNEL);
> +	if (!new_bank) {
> +#ifdef CONFIG_ELSACCT_DEBUG
> +		printk("elsa_bank_alloc: cannot allocate space for new_bank\n");
> +#endif

dprintk

> +		return -ENOMEM;
> +	}
> +
> +	/* give it an id */
> +	new_bid = elsa_get_bid();
> +	if (elsa_get_bid <= 0) {

err, I think you mean new_bid...

> +		/* There is no available id == ERROR */
> +		kfree(new_bank);
> +#ifdef CONFIG_ELSACCT_DEBUG
> +		printk("elsa_bank_alloc: can not find bank identifier\n");
> +#endif
> +		return -ENODATA;
> +	} else {
> +		new_bank->bid = new_bid;
> +	}
> +
> +	/* Set info to NULL */
> +	new_bank->info = NULL;
> +
> +	/* Initialize head (list of datas) */
> +	INIT_LIST_HEAD(&(new_bank->data_head));
> +
> +	/* add it to the list of banks */
> +	list_add(&(new_bank->bank_list), &(elsa_broot.bank_head));
> +
> +#ifdef CONFIG_ELSACCT_DEBUG
> +	printk
> +	    ("elsa_bank_alloc: bank #%d created and added to the list\n",
> +	     new_bank->bid);
> +#endif
> +	return new_bank->bid;
> +}
> +
> +/**
> + * elsa_bank_free - Frees space occupied by a bank.
> + * @bank: a pointer to the bank to delete
> + * 
> + * Removes a bank and returns the identifiers of the removed bank.
> + * When this function is called bank MUST be empty 
> + * If an error is encountered, a negative value is returned. 
> + * If there is no corresponding BANK_ID, 0 is returned.  
> + *
> + * Here are different steps of the operation
> + *
> + *   1) Write accounting information
> + *   2) Put bank ID in the list of free BID.
> + *   3) Remove it from the list of banks
> + *   4) Free space for the new bank
> + */
> +static int elsa_bank_free(struct elsa_bank_s *bank)
> +{
> +	struct elsa_freebid_s *new_freebid;
> +
> +	if (!list_empty(&bank->data_head)) {
> +		printk("elsa_bank_free: BUG found - lists isn't empty\n");
> +		return -EAGAIN;
> +	}
> +
> +	/* Before deleting the bank, we can do some action */
> +	/* callback */
> +	if (elsa_broot.bank_cb)
> +		(elsa_broot.bank_cb) (bank->bid);
> +
> +	/* Insert the identifier of the bank in the list of free bank ID */
> +	/* allocate space for the freebid item */
> +	new_freebid = (struct elsa_freebid_s *)
> +	    kmalloc(sizeof(struct elsa_freebid_s), GFP_KERNEL);

odd indent...and this is called in places with spin_locks held.

> +	if (!new_freebid) {
> +#ifdef CONFIG_ELSACCT_DEBUG
> +		printk("elsa_bank_free: cannot allocate space for freebid\n");
> +#endif
> +		return -ENOMEM;
> +	}
> +	new_freebid->bid = bank->bid;
> +	list_add(&(new_freebid->bid_list), &(elsa_broot.freebid_head));
> +
> +	/* we can now remove the bank from the list */
> +	list_del(&(bank->bank_list));
> +#ifdef CONFIG_ELSACCT_DEBUG
> +	printk("elsa_bank_free: bank #%d removed from the list\n", bank->bid);
> +#endif
> +	kfree(bank);
> +
> +	return new_freebid->bid;
> +}
> +
> +/**
> + * elsa_data_free - Free data
> + * @data: data to be removed
> + * 
> + * Frees memory space used by data. If it is the last element present in a 
> + * bank, bank will also be removed. Before calling this function, we must be
> + * sure that data is not a pointer to NULL.
> + */
> +#define __elsa_data_free(data) do { \
> +	list_del(&data->data_list); \
> +	list_del(&data->bank_list); \
> +	kfree(data);                \
> +} while (0)
> +
> +static void elsa_data_free(struct elsa_data_s *data)
> +{
> +	struct elsa_bank_s *bank = elsa_get_bank(data->bid);
> +
> +#ifdef CONFIG_ELSACCT_DEBUG
> +	printk
> +	    ("elsa_data_free: process #%d removed from bank #%d\n",
> +	     data->process->pid, data->bid);
> +#endif
> +	/* callback */
> +	if (elsa_broot.data_cb)
> +		(elsa_broot.data_cb) (data->bid, data->process);
> +
> +	if (data->data_list.next == data->data_list.prev) {
> +		/* data is the last item in the bank */
> +		__elsa_data_free(data);
> +		/* bank is now empty */
> +		elsa_bank_free(bank);
> +	} else {
> +		__elsa_data_free(data);
> +	}
> +}
> +
> + /*********************************
> + * functions used to manage /proc *
> + *                                *
> + * The entry is /proc/bankinfo    *
> + *********************************/
> +
> +/***
> + * Add an entry in /proc to get informations concerning
> + * banks. This entry is called /proc/bankinfo
> + ****/
> +#ifdef CONFIG_PROC_FS
> +static void *b_start(struct seq_file *m, loff_t * pos)
> +{
> +	loff_t n = *pos;
> +	struct list_head *p;
> +
> +	/* Header is displaying just during the first called */
> +	if (!n) {
> +		seq_puts(m, "# - bankinfo -\n");
> +		seq_puts(m, "# bankid:\t<process> <process> ...\n");
> +	}
> +
> +	if (list_empty(&elsa_broot.bank_head))
> +		return NULL;
> +
> +	p = elsa_broot.bank_head.next;
> +	while (n--) {
> +		p = p->next;
> +		if (p == &elsa_broot.bank_head)
> +			return NULL;
> +	}
> +
> +	/* we return a pointer to the data in the bank */
> +	return list_entry(p, struct elsa_bank_s, bank_list);
> +}
> +
> +static void b_stop(struct seq_file *m, void *v)
> +{
> +}
> +
> +static void *b_next(struct seq_file *m, void *v, loff_t * pos)
> +{
> +	struct elsa_bank_s *bank = v;
> +
> +	++*pos;
> +	return bank->bank_list.next == &elsa_broot.bank_head ? NULL :
> +	    list_entry(bank->bank_list.next, struct elsa_bank_s, bank_list);
> +}
> +
> +static int show_bankinfo(struct seq_file *m, void *v)
> +{
> +	struct elsa_bank_s *bank = v;
> +	struct elsa_data_s *data;
> +
> +	if (!bank) {
> +		seq_printf(m, "There is no banks\n");
> +	} else {
> +		/* display bank identifier */
> +		seq_printf(m, "%d:", bank->bid);
> +		/* add a tabulation */
> +		seq_printf(m, "\t");
> +		/* display list of processus */
> +		if (list_empty(&(bank->data_head))) {
> +			seq_printf(m, "Empty");
> +		} else {
> +			list_for_each_entry(data, &(bank->data_head), data_list)
> +			    seq_printf(m, "%d ", data->process->pid);
> +		}
> +		/* add EOL */
> +		seq_printf(m, "\n");
> +	}
> +
> +	return 0;
> +}
> +
> +/* bankinfo_op - iterator that generates /proc/bankinfo
> + *
> + * Output layout:
> + * bankID	pid ...
> + */
> +struct seq_operations bankinfo_op = {
> +	.start = b_start,
> +	.stop = b_stop,
> +	.next = b_next,
> +	.show = show_bankinfo,
> +};
> +
> +int bankinfo_open(struct inode *inode, struct file *file)
> +{
> +	return seq_open(file, &bankinfo_op);
> +}
> +
> +struct file_operations proc_bankinfo_ops = {
> +	.open = bankinfo_open,
> +	.read = seq_read,
> +	.llseek = seq_lseek,
> +	.release = seq_release,
> +};
> +
> +EXPORT_SYMBOL(proc_bankinfo_ops);
> +
> +#endif
> diff -uprN -X elsa_import/dontdiff linux-2.6.5/drivers/elsacct/elsacct.c linux-2.6.5-elsa/drivers/elsacct/elsacct.c
> --- linux-2.6.5/drivers/elsacct/elsacct.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.5-elsa/drivers/elsacct/elsacct.c	2004-05-05 11:02:45.935242864 +0200
> @@ -0,0 +1,435 @@
> +/*
> + *  driver/elsacct/elsacct.c
> + * 
> + *  ELSA - Enhanced Linux System Accounting
> + *  Guillaume Thouvenin - 26/04/2004
> + *
> + *  This module implements Enhanced Linux System Accounting. 
> + *  We implement a character driver to transfer data between 
> + *  BANK that are in the kernel adress space and the user 
> + *  adress space. 
> + *
> + *  This code is licenced under GPL.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/config.h>
> +#include <linux/init.h>
> +#include <linux/errno.h>
> +#include <linux/fs.h>
> +#include <linux/proc_fs.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/blkdev.h>
> +#include <linux/times.h>
> +
> +#include <asm/uaccess.h>
> +
> +#include <linux/elsacct.h>
> +#include <linux/bank.h>
> +
> +static int elsa_major;
> +
> +/**
> + *  encode_comp_t - encode an unsigned long into a comp_t
> + *  @value: value to encode
> + *
> + *  This routine has been adopted from the encode_comp_t() function in
> + *  the kern_acct.c file of the FreeBSD operating system. The encoding
> + *  is a 13-bit fraction with a 3-bit (base 8) exponent. 
> + *
> + *  This routine is taken from kernel/acct.c
> + */
> +
> +#define	MANTSIZE	13	/* 13 bit mantissa. */
> +#define	EXPSIZE		3	/* Base 8 (3 bit) exponent. */
> +#define	MAXFRACT	((1 << MANTSIZE) - 1)	/* Maximum fractional value. */
> +
> +typedef __u16 comp_t;
> +
> +static comp_t encode_comp_t(unsigned long value)
> +{
> +	int exp, rnd;
> +
> +	exp = rnd = 0;
> +	while (value > MAXFRACT) {
> +		rnd = value & (1 << (EXPSIZE - 1));	/* Round up? */
> +		value >>= EXPSIZE;	/* Base 8 exponent == 3 bit shift. */
> +		exp++;
> +	}
> +
> +	/*
> +	 * If we need to round up, do it (and handle overflow correctly).
> +	 */
> +	if (rnd && (++value > MAXFRACT)) {
> +		value >>= EXPSIZE;
> +		exp++;
> +	}
> +
> +	/*
> +	 * Clean it up and polish it off.
> +	 */
> +	exp <<= MANTSIZE;	/* Shift the exponent into place */
> +	exp += value;		/* and add on the mantissa. */
> +	return exp;
> +}
> +
> +/**
> + * do_elsa_acct - Accounting is done here
> + * @info: pointer to accounting informations
> + *
> + * We copy code from BSD accounting
> + */
> +void do_elsa_acct(struct elsa_acct_s *info, struct task_struct *p)
> +{
> +	u64 elapsed;
> +
> +	/* One more process in the bank */
> +	info->eac_ptot++;
> +
> +	/* elapsed time */
> +	elapsed = jiffies_64_to_clock_t(get_jiffies_64() - p->start_time);
> +	info->eac_etime += encode_comp_t(elapsed < (unsigned long)-1l ?
> +					 (unsigned long)elapsed : (unsigned
> +								   long)-1l);
> +
> +	/* user time and system time */
> +	info->eac_utime += encode_comp_t(jiffies_to_clock_t(p->utime));
> +	info->eac_stime += encode_comp_t(jiffies_to_clock_t(p->stime));
> +
> +	/* minor and major page faults */
> +	info->eac_minflt += encode_comp_t(p->min_flt);
> +	info->eac_majflt += encode_comp_t(p->maj_flt);
> +
> +	/* Number of swaps */
> +	info->eac_swaps += encode_comp_t(p->nswap);
> +}
> +
> +/**
> + * elsa_acct - callback hook to data
> + * @bid: bank identifier
> + * 
> + * Call when a data is destroyed. It does accounting updates.
> + */
> +void elsa_acct(int bid, struct task_struct *p)
> +{
> +	struct elsa_acct_s *info;
> +
> +	info = (struct elsa_acct_s *)elsa_bank_get_info(bid);
> +
> +	if (info)
> +		do_elsa_acct(info, p);
> +	else
> +		printk("elsa_acct: error BID == %d\n", bid);
> +}
> +
> +#define display_elsa_info(info) do {                             \
> +	printk("\tNumber of Processes : %d\n",info->eac_ptot);   \
> +	printk("\tElapsed Time        : %d\n",info->eac_etime);  \
> +	printk("\tUser Time           : %d\n",info->eac_utime);  \
> +	printk("\tSystem Time         : %d\n",info->eac_stime);  \
> +	printk("\tMinor page faults   : %d\n",info->eac_minflt); \
> +	printk("\tMajor page faults   : %d\n",info->eac_majflt); \
> +	printk("\tNumber of swaps     : %d\n",info->eac_swaps);  \
> +} while(0)

Just to dmesg buffer?  Too verbose, how do accounting tools handle this?

> +
> +/**
> + * free_elsa_info - callback hook to bank
> + * @bid: bank identifier
> + *
> + * Call when a bank is destroyed. It dumps accounting
> + * information to a buffer and release memory space 
> + * used to store information at the bank level
> + */
> +void free_elsa_info(int bid)
> +{
> +	struct elsa_acct_s *info;
> +
> +	info = (struct elsa_acct_s *)elsa_bank_get_info(bid);
> +
> +	/* 
> +	 * We put information in the log file. If the file isn't empty,
> +	 * information in the file will be destroyed.
> +	 */
> +	if (info) {
> +		printk("free_elsa_info: ELSA information about bank #%d\n",
> +		       bid);
> +		display_elsa_info(info);
> +		kfree(info);
> +	} else {
> +		printk("free_elsa_info: ERROR, info == NULL\n");
> +	}
> +}
> +
> +/**
> + * hang_elsa_info - attach info structure to the bank
> + * @bid: bank identifier
> + *
> + * create and attach a new info structure to bank with identifier
> + * equal to bid. 
> + */
> +void hang_elsa_info(int bid)
> +{
> +	struct elsa_acct_s *info;
> +
> +	info = (struct elsa_acct_s *)kmalloc(sizeof(struct elsa_acct_s),
> +					     GFP_KERNEL);
> +
> +	if (info) {
> +		printk("Bank #id%d created: info hung\n", bid);
> +
> +		/* initialize info fields */
> +		memset(info, 0, sizeof(struct elsa_acct_s));
> +		info->eac_bid = bid;
> +		/* So, fields are all equals to zero except eac_bid */
> +		elsa_bank_set_info(bid, info);
> +	} else {
> +		printk(KERN_WARNING "Bank #id%d created: info error\n", bid);
> +	}
> +
> +}
> +
> + /**************************************************************
> + * functions used to manipulate the device                     *
> + *                                                             *
> + * The enhanced linux system accounting device is /dev/elsacct *
> + * and the major number is dynamically given by OS             *
> + **************************************************************/
> +
> +/* 
> + * The process context, represented as a typical driver method - ioctl(), must 
> + * use spin_lock_irq() because it knows that interrupts are always enabled while 
> + * executing the device ioctl() method.
> + */
> +spinlock_t elsa_lock = SPIN_LOCK_UNLOCKED;
> +
> +/**
> + * elsacct_read - copy data to application code
> + * @file : file pointer
> + * @buf  : pointer to the user empty buffer
> + * @count: size of the requested data transfer
> + * @ppos : pointer to long offset type that indicates the file 
> + *         position the user is accessing
> + *
> + * Copy data from the device to user space. 
> + * Return a negative value if an error occurs.
> + */
> +ssize_t elsacct_read(struct file *file, char *buf, size_t count, loff_t * ppos)
> +{
> +	return (ssize_t) 0;
> +}

What's the point?

> +
> +/**
> + * elsacct_write - copy data from application code
> + * @file : file pointer
> + * @buf  : pointer to the user buffer holding data to be written
> + * @count: size of the requested data transfer
> + * @ppos : pointer to long offset type that indicates the file 
> + *         position the user is accessing
> + *
> + * Copy data from user space to the device. 
> + * Return a negative value if an error occurs.
> + */
> +ssize_t elsacct_write(struct file * file, const char *buf,
> +		      size_t count, loff_t * ppos)
> +{
> +	ssize_t retval = 0;
> +
> +	return retval;
> +}

What's the point?

> +
> +/**
> + * elsacct_ioctl - issue a device specific command
> + * @inode: pointer to inode structure
> + * @file : file pointer
> + * @cmd  : specific command to perform.
> + *         Commands can be ELSACCT_CLEAN, ELSACCT_ADD or ELSACCT_REMOVE
> + * @arg  : arguments that depend of cmd.
> + *
> + * Perform some actions on banks that depend of command passed to the
> + * system call
> + */
> +int elsacct_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
> +		  unsigned long arg)
> +{
> +	int retval = 0;
> +	struct elsa_arg_s *args = (struct elsa_arg_s *)arg;

No, no, no.  You can't just cast and go...you've got to copy the thing
in.  elsacct_open() does zero security checking, 

> +	struct task_struct *p;
> +
> +	switch (cmd) {
> +	case ELSACCT_CLEAN:
> +		if (!args) {
> +			printk(KERN_WARNING
> +			       "elsacct_ioctl: ELSACCT_CLEAN wrong parameter\n");
> +			retval = -EINVAL;
> +		} else {
> +			printk(KERN_INFO "elsacct_ioctl: clean bank ID#%d\n",
> +			       args->bid);
> +			spin_lock_irq(&elsa_lock);
> +			/* critical section */
> +			retval = elsa_bank_clean(args->bid);

You never even checked this argument validity.

> +			spin_unlock_irq(&elsa_lock);
> +		}
> +		break;
> +
> +	case ELSACCT_ADD:
> +		if (!args) {
> +			printk(KERN_WARNING
> +			       "elsacct_ioctl: ELSACCT_CLEAN wrong parameter\n");
> +			retval = -EINVAL;
> +		} else {
> +			printk(KERN_INFO
> +			       "elsacct_ioctl: add process #%d to bank #%d\n",
> +			       args->pid, args->bid);

Too verbose.

> +
> +			p = find_task_by_pid(args->pid);

no task_list locking

> +			if (!p) {
> +				printk(KERN_WARNING
> +				       "elsacct_ioct: PID#%d not found\n",
> +				       args->pid);
> +				retval = -EAGAIN;
> +			} else {
> +				/* if args->bid == 0, it will create a new bank */
> +				spin_lock_irq(&elsa_lock);
> +				retval = elsa_bank_add(args->bid, p);

this will kmalloc(GFP_KERNEL)...with irq's off.

> +				if (retval > 0)
> +					hang_elsa_info(retval);
> +				spin_unlock_irq(&elsa_lock);
> +			}
> +		}
> +		break;
> +
> +	case ELSACCT_REMOVE:
> +		if (!args) {
> +			printk(KERN_WARNING
> +			       "elsacct_ioctl: ELSACCT_CLEAN wrong parameter\n");
> +			retval = -EINVAL;
> +		} else {
> +			printk(KERN_INFO
> +			       "elsacct_ioctl: remove process #%d to bank #%d\n",
> +			       args->pid, args->bid);
> +			spin_lock_irq(&elsa_lock);
> +			retval = elsa_bank_remove(args->bid, args->pid);
> +			spin_unlock_irq(&elsa_lock);
> +		}
> +		break;
> +
> +	default:
> +		printk(KERN_WARNING
> +		       "elsacct_ioctl: 0x%x unsupported ioctl command\n", cmd);
> +		retval = -ENOIOCTLCMD;
> +	};
> +
> +	return retval;
> +}
> +
> +int elsacct_open(struct inode *inode, struct file *file)
> +{
> +	return 0;
> +}
> +
> +int elsacct_release(struct inode *inode, struct file *file)
> +{
> +	return 0;
> +}
> +
> +struct file_operations elsa_fops = {
> +	.owner = THIS_MODULE,
> +	.read = elsacct_read,
> +	.write = elsacct_write,
> +	.ioctl = elsacct_ioctl,
> +	.open = elsacct_open,
> +	.release = elsacct_release,
> +};
> +
> +/**
> + * elsacct_init - Initialize enhanced linux system accounting
> + * 
> + * Initializes "callbacks" to bank and data. Those 
> + * functions are called a bank or a data are destroyed.
> + * It allows to perform some actions in the module.
> + */
> +static int __init elsacct_init(void)
> +{
> +	int retval = 0;
> +	struct proc_dir_entry *entry;
> +
> +	/* register character device with a dynamic major number */
> +	elsa_major = register_chrdev(0, "elsacct", &elsa_fops);
> +	if (!elsa_major) {
> +		printk(KERN_WARNING
> +		       "elsacct_init: can't get major %d\n", elsa_major);
> +		return -EIO;
> +	}
> +	printk(KERN_INFO "elsacct_init: get major %d\n", elsa_major);

Is this how you communicate the major device number back?

> +
> +	/* set bank and data callbacks */
> +	elsa_bank_init_cb(&free_elsa_info, &elsa_acct);
> +
> +#ifdef CONFIG_PROC_FS
> +	/* create /proc entry */
> +	entry = create_proc_entry("bankinfo", 0, NULL);
> +	if (entry)
> +		entry->proc_fops = &proc_bankinfo_ops;
> +	else
> +		return -EIO;

Never unregistered the device.

> +#endif
> +
> +	/* succeed */
> +	return retval;
> +
> +//      out_devfs:
> +	/* currently, we know that this code can not be run
> +	   but we add it because when init will become more 
> +	   complex we don't want to forget to remove some stuff
> +	   created before the problem */
> +//      unregister_chrdev(elsa_major, "elsacct");
> +//      return retval;
> +}
> +
> +#ifdef MODULE

unnecessary.  the module macros do the right thing.

> +
> + /************************
> + * Module initialization *
> + ************************/
> +
> +/**
> + * elsacct_init_module - called when module is loaded
> + *
> + * Display a message in dmesg and call the real 
> + * initialization function.
> + */
> +static int __init elsacct_init_module(void)
> +{
> +	printk(KERN_INFO "ELSA accounting started\n");
> +	return elsacct_init();
> +}
> +
> +/**
> + * elsacct_cleanup - called when module is unloaded
> + *
> + * Display a message in dmesg 
> + */
> +static void __exit elsacct_cleanup_module(void)
> +{
> +	/* release the major number when module is unloaded */
> +	if (unregister_chrdev(elsa_major, "elsacct"))
> +		printk(KERN_WARNING
> +		       "elsacct_cleanup: cannot unregister blkdev\n");
> +	else
> +		printk(KERN_INFO "elsacct_cleanup: accounting terminated\n");
> +}
> +
> +module_init(elsacct_init_module);
> +module_exit(elsacct_cleanup_module);
> +
> +MODULE_DESCRIPTION("Enhanced Linux System Accounting.");
> +MODULE_AUTHOR("Guillaume Thouvenin <guillaume.thouvenin@bull.net>");
> +
> +MODULE_LICENSE("GPL");
> +
> +#else
> +
> +module_init(elsacct_init);
> +
> +#endif				/* !(MODULE) */
> diff -uprN -X elsa_import/dontdiff linux-2.6.5/drivers/elsacct/Kconfig linux-2.6.5-elsa/drivers/elsacct/Kconfig
> --- linux-2.6.5/drivers/elsacct/Kconfig	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.5-elsa/drivers/elsacct/Kconfig	2004-05-05 10:27:50.000000000 +0200
> @@ -0,0 +1,52 @@
> +#
> +# For a description of the syntax of this configuration file,
> +# see Documentation/kbuild/kconfig-language.txt.
> +#
> +
> +menu "ELSAcct Driver"
> +
> +config BANK
> +	bool "ELSA bank support"
> +	depends on EXPERIMENTAL
> +	default n
> +	---help---
> +	  BANK structures are needed if you want to do enhanced 
> +	  linux system accounting
> +
> +	  say Y if you want to use Enhanced Linux Sytem Accounting
> +
> +config ELSACCT
> +	tristate "Enhanced Linux System Accounting"
> +	depends on EXPERIMENTAL
> +	requires BANK
> +	default n
> +	---help---
> +  	  The goal of accounting is to collect and report the use of various 
> +  	  system resources by applications. Informations, like process time, 
> +  	  CPU usage, connect time or disk space usage, provides data that helps 
> +  	  the system to adjust the use of resources between processes.
> +  	
> +  	  The current BSD-like process accounting that already exists in Linux 
> +  	  collects informations on individual users or groups of users. The ELSA 
> +  	  project aims to improve and extend the monitoring of resources with 
> +  	  different criteria like groups of processes. Another target for this 
> +  	  project is to give Linux an homogeneous set of commands for all kinds 
> +  	  of accounting (memory, CPU and I/O).
> +  	
> +     	  To compile this driver as a module, choose M here: the module will be 
> +  	  called elsa-acct.
> +  
> +  	  Documentation about ELSA is available from
> +  	  <http://elsa.sourceforge.net>
> +
> +config ELSACCT_DEBUG
> +	bool "ELSA bank debugging support"
> +	depends on ELSACCT
> +	default n
> +	---help---
> +          This option allows you to enable debugging output when using 
> +	  banks structure. Currently, such structure is used by Enhanced
> +	  Linux System Accounting (ELSA). Informations are sent to the 
> +	  console.
> +
> +endmenu
> diff -uprN -X elsa_import/dontdiff linux-2.6.5/drivers/elsacct/Makefile linux-2.6.5-elsa/drivers/elsacct/Makefile
> --- linux-2.6.5/drivers/elsacct/Makefile	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.5-elsa/drivers/elsacct/Makefile	2004-05-05 10:15:41.000000000 +0200
> @@ -0,0 +1,5 @@
> +#
> +# Makefile for the linux kernel.

Heh, I think it's not for whole kernel ;-)

> +#
> +obj-$(CONFIG_BANK)	+= bank.o
> +obj-$(CONFIG_ELSACCT)	+= elsacct.o
> diff -uprN -X elsa_import/dontdiff linux-2.6.5/drivers/Kconfig linux-2.6.5-elsa/drivers/Kconfig
> --- linux-2.6.5/drivers/Kconfig	2004-04-04 05:38:17.000000000 +0200
> +++ linux-2.6.5-elsa/drivers/Kconfig	2004-05-05 08:46:35.000000000 +0200
> @@ -4,6 +4,8 @@ menu "Device Drivers"
>  
>  source "drivers/base/Kconfig"
>  
> +source "drivers/elsacct/Kconfig"
> +
>  source "drivers/mtd/Kconfig"
>  
>  source "drivers/parport/Kconfig"
> diff -uprN -X elsa_import/dontdiff linux-2.6.5/drivers/Makefile linux-2.6.5-elsa/drivers/Makefile
> --- linux-2.6.5/drivers/Makefile	2004-04-04 05:37:43.000000000 +0200
> +++ linux-2.6.5-elsa/drivers/Makefile	2004-05-05 07:46:34.000000000 +0200
> @@ -50,3 +50,4 @@ obj-$(CONFIG_MCA)		+= mca/
>  obj-$(CONFIG_EISA)		+= eisa/
>  obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
>  obj-y				+= firmware/
> +obj-y				+= elsacct/
> diff -uprN -X elsa_import/dontdiff linux-2.6.5/include/linux/bank.h linux-2.6.5-elsa/include/linux/bank.h
> --- linux-2.6.5/include/linux/bank.h	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.5-elsa/include/linux/bank.h	2004-05-05 11:02:56.087699456 +0200
> @@ -0,0 +1,141 @@
> +/*
> + *  include/linux/elsa_bank.h
> + * 
> + *  ELSA - Enhanced Linux System Accounting
> + *  Guillaume Thouvenin - 26/04/2004
> + *  
> + *  Provides structures and functions to manipulate "BANK". 
> + *  They are containers that store a set of processes. 
> + *  When a "BANK" is empty it is destroy and accounting infor-
> + *  mations are stored in a file. Informations are about 
> + *  all process contained in a "BANK"
> + * 
> + *  The idea is to provide a mechanism that allows to group 
> + *  chosen process together. "BANK" must have some properties like:
> + *    o If a process belongs to a bank, its children belong to the same bank
> + *    o A process can be placed in several different banks
> + *    o When the user adds a process to an non-existent bank, the container
> + *      must automatically be created
> + *    o When the last process of a bank exits, informations about all processes
> + *      that belonged to the bank must be stored (maybe in a file) and the
> + *      container must be destroyed
> + * 
> + *  To do that, we use a double linked list provides by the kernel
> + *  (include/linux/list.h) and we do the following thing:
> + * 
> + *         elsa_broot          BANK #1           BANK #2  
> + *        bank_root_s         elsa_bank_s       elsa_bank_s  
> + *       --------------       -----------       ----------- 
> + *      | next_bid = 3 |     |  bid = 1  |     |  bid = 2  |
> + *      |--------------|     |-----------|     |-----------|
> + * <===>| freebid_head |     |   info    |     |   info    |
> + *      |--------------|     |-----------|     |-----------|
> + *      | bank_head    |<===>| bank_list |<===>| bank_list |<===>...
> + *      |--------------|     |-----------|     |-----------|
> + *      | bank_cb      |     | data_head |     | data_head |<===>...
> + *      |--------------|      ----------        -----------
> + *      | data_cb      |             ^ ^
> + *       --------------              | |
> + *                                   |  ================= 
> + *    PROCESS            DATA #1     |     DATA #2       |  
> + *  task_struct        elsa_data_s   |   elsa_data_s     |
> + *   ---------         -----------   |   -----------     |
> + *  |         |       |  bid = 1  |  |  |  bid = 1  |    |
> + *  |         |       |-----------|  |  |-----------|    |
> + *  |         |<------|  process  |  |  |  process  |    |
> + *  |         |       |-----------|  |  |-----------|    |
> + *  |         |       | data_list |<=   | data_list |<===
> + * ...       ...      |           |<===>|           |
> + *  |---------|       |-----------|     |-----------|
> + *  |bank_head|<=====>| bank_list |     | bank_list |
> + *  |---------|        -----------       -----------
> + * ...       ...
> + *
> + *
> + * Field "bank_list" in the elsa_data_s is used to know which are banks with
> + * a given process. Structure "task_struc" is modified to use this field.
> + */
> +
> +#ifndef __LINUX_BANK_H
> +#define __LINUX_BANK_H
> +
> +#include <linux/types.h>
> +#include <linux/sched.h>
> +#include <linux/list.h>
> +
> +/***
> + * Internal structures
> + ***/
> +struct bank_root_s {
> +	/* 
> +	 * We need to protect ID by a semaphore since it must be
> +	 * a unique number. We can't have to bank with same ID
> +	 */
> +	int next_bid;		/* next available bank identifier */
> +	struct list_head freebid_head;	/* a list of free bank identifier */
> +	struct list_head bank_head;	/* head of the list of bank */
> +	void (*bank_cb) (int bid);	/* action to perform when bank is removed */
> +	void (*data_cb) (int bid, struct task_struct * p);	/* action to perform when data is removed */
> +};
> +
> +#define BANK_ROOT_INIT(root) {                     \
> +		1,                                 \
> +		LIST_HEAD_INIT(root.freebid_head), \
> +		LIST_HEAD_INIT(root.bank_head),    \
> +		NULL,				   \
> +		NULL 				   \
> +}
> +
> +struct elsa_freebid_s {
> +	int bid;
> +	struct list_head bid_list;
> +};
> +
> +struct elsa_bank_s {
> +	int bid;		/* the bank identifier */
> +	int uid;		/* identifier of user that creates the bank */
> +	void *info;		/* allow to hang information to banks */
> +	struct list_head bank_list;	/* list of available banks */
> +	struct list_head data_head;	/* head of the list of datas in the 
> +					   bank */
> +};
> +
> +struct elsa_data_s {
> +	int bid;		/* the bank to which data belong */
> +	struct task_struct *process;	/* the process information */
> +	struct list_head data_list;	/* link between datas in a bank */
> +	struct list_head bank_list;	/* used by a process to link banks 
> +					   that contains it */
> +};
> +
> +#ifdef CONFIG_PROC_FS
> +extern struct file_operations proc_bankinfo_ops;
> +#endif
> +
> + /*********************************************
> + * Following functions can be use by a module *
> + * (=> they are exported)                     *
> + *********************************************/
> +void elsa_bank_init_cb(void *bank_cb, void *data_cb);
> +int elsa_bank_set_info(int bid, void *info);
> +void *elsa_bank_get_info(int bid);
> +
> +int elsa_bank_add(int bid, struct task_struct *p);
> +int elsa_bank_clean(int bid);
> +int elsa_bank_remove(int bid, pid_t pid);
> +
> + /*****************************************************************************
> + * Following functions are called from kernel function.                       *
> + *   elsa_copy_parent() is used when child is created (kernel/fork.c)         *
> + *   elsa_bank_remove_all() is used when a process terminates (kernel/exit.c) *
> + *****************************************************************************/
> +#ifdef CONFIG_BANK
> +extern void elsa_copy_parent_bank(struct task_struct *from,
> +				  struct task_struct *to);
> +extern void elsa_bank_remove_all(struct task_struct *p);
> +#else
> +#define elsa_copy_parent_bank(a,b) do {} while(0)
> +#define elsa_bank_remove_all(a)    do {} while(0)
> +#endif				/* !(CONFIG_BANK) */
> +
> +#endif				/* !(__LINUX_BANK_H) */
> diff -uprN -X elsa_import/dontdiff linux-2.6.5/include/linux/elsacct.h linux-2.6.5-elsa/include/linux/elsacct.h
> --- linux-2.6.5/include/linux/elsacct.h	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.5-elsa/include/linux/elsacct.h	2004-05-05 11:02:52.144298944 +0200
> @@ -0,0 +1,53 @@
> +/*
> + *  include/linux/elsa_acct.h
> + * 
> + *  ELSA - Enhanced Linux System Accounting
> + *  Guillaume Thouvenin - 26/04/2004
> + *      
> + */
> +
> +#ifndef __LINUX_ELSACCT_H
> +#define __LINUX_ELSACCT_H
> +
> +/* IOCTL numbers */
> +/* 
> + * Remove all process present in a bank. It needs one argument which 
> + * is the identifier of the bank.
> + */
> +#define ELSACCT_CLEAN	0x0
> +/*
> + * Add a process to a given bank. It needs two arguments which are:
> + * ARG0, the identifier of the bank and
> + * ARG1 the pid of the process to add. 
> + */
> +#define ELSACCT_ADD 	0x1
> +/* 
> + * Remove a process from a given bank. It needs two arguments which are:
> + * ARG0 is the identifier of the bank. If it is equal to zero, it means 
> + *      that process should be removed from all banks and
> + * ARG1 is the pid of the process to remove. 
> + */
> +#define ELSACCT_REMOVE	0x2
> +
> +/* structure used when passing argument to ioctl */
> +struct elsa_arg_s {
> +	int bid;
> +	int pid;
> +};
> +
> +/* 
> + * Currently, we take as a starting point the BSD-style 
> + * process accounting. 
> + */
> +struct elsa_acct_s {
> +	int eac_bid;		/* Bank id */
> +	int eac_ptot;		/* Total number of process that are added to a bank */
> +	int eac_utime;		/* Accounting User Time */
> +	int eac_stime;		/* Accounting System Time */
> +	int eac_etime;		/* Accounting Elapsed Time */
> +	int eac_minflt;		/* Accounting Minor Pagefaults */
> +	int eac_majflt;		/* Accounting Major Pagefaults */
> +	int eac_swaps;		/* Accounting Number of Swaps */
> +};

To do BSD-style you'd need to keep same data, right?  Also, it writes to
an account file, not the dmesg buffer.

> +
> +#endif				/* !(__LINUX_ELSACCT_H) */
> diff -uprN -X elsa_import/dontdiff linux-2.6.5/include/linux/sched.h linux-2.6.5-elsa/include/linux/sched.h
> --- linux-2.6.5/include/linux/sched.h	2004-04-04 05:36:18.000000000 +0200
> +++ linux-2.6.5-elsa/include/linux/sched.h	2004-05-04 13:27:03.000000000 +0200
> @@ -493,6 +493,9 @@ struct task_struct {
>  
>  	unsigned long ptrace_message;
>  	siginfo_t *last_siginfo; /* For ptrace use.  */
> +
> +/* List of BANK to which the process belong - Used by ELSA */
> +	struct list_head bank_head;
>  };
>  
>  static inline pid_t process_group(struct task_struct *tsk)
> diff -uprN -X elsa_import/dontdiff linux-2.6.5/kernel/exit.c linux-2.6.5-elsa/kernel/exit.c
> --- linux-2.6.5/kernel/exit.c	2004-04-04 05:38:13.000000000 +0200
> +++ linux-2.6.5-elsa/kernel/exit.c	2004-05-05 07:51:31.000000000 +0200
> @@ -22,6 +22,7 @@
>  #include <linux/profile.h>
>  #include <linux/mount.h>
>  #include <linux/proc_fs.h>
> +#include <linux/bank.h>
>  
>  #include <asm/uaccess.h>
>  #include <asm/pgtable.h>
> @@ -95,6 +96,7 @@ repeat: 
>  	p->parent->cnswap += p->nswap + p->cnswap;
>  	p->parent->cnvcsw += p->nvcsw + p->cnvcsw;
>  	p->parent->cnivcsw += p->nivcsw + p->cnivcsw;
> +	elsa_bank_remove_all(p);

This can call kmalloc(GFP_KERNEL) within write_lock_irq.

>  	sched_exit(p);
>  	write_unlock_irq(&tasklist_lock);
>  	spin_unlock(&p->proc_lock);
> diff -uprN -X elsa_import/dontdiff linux-2.6.5/kernel/fork.c linux-2.6.5-elsa/kernel/fork.c
> --- linux-2.6.5/kernel/fork.c	2004-04-04 05:36:18.000000000 +0200
> +++ linux-2.6.5-elsa/kernel/fork.c	2004-05-05 07:51:52.000000000 +0200
> @@ -31,6 +31,7 @@
>  #include <linux/futex.h>
>  #include <linux/ptrace.h>
>  #include <linux/mount.h>
> +#include <linux/bank.h>
>  
>  #include <asm/pgtable.h>
>  #include <asm/pgalloc.h>
> @@ -232,6 +233,13 @@ void __init fork_init(unsigned long memp
>  
>  	init_task.rlim[RLIMIT_NPROC].rlim_cur = max_threads/2;
>  	init_task.rlim[RLIMIT_NPROC].rlim_max = max_threads/2;
> +
> +	/* 
> +	 * We initialize the field of process 0, otherwise it will cause
> +	 * an oops in elsa_copy_parent_bank(from, to) with from->pid==0
> +	 * and to->pid==1
> +	 */
> +	INIT_LIST_HEAD(&(current->bank_head));

Not here.  Do this in the INIT_TASK macro.

>  }
>  
>  static struct task_struct *dup_task_struct(struct task_struct *orig)
> @@ -1053,6 +1061,8 @@ struct task_struct *copy_process(unsigne
>  	if (p->ptrace & PT_PTRACED)
>  		__ptrace_link(p, current->parent);
>  
> +	INIT_LIST_HEAD(&(p->bank_head));

Just copy the thing here like all the other copy_foo() routines do.  And
if it's identical, what's wrong with just refcounting it and keeping
same data structure?

> +
>  	attach_pid(p, PIDTYPE_PID, p->pid);
>  	if (thread_group_leader(p)) {
>  		attach_pid(p, PIDTYPE_TGID, p->tgid);
> @@ -1187,6 +1197,13 @@ long do_fork(unsigned long clone_flags,
>  			 * COW overhead when the child exec()s afterwards.
>  			 */
>  			set_need_resched();
> +
> +		/* 
> +		 * Child is in the same BANK as parent. So we copy
> +		 * the list of banks from parent (current) to 
> +		 * child (p)  
> +		 */
> +		elsa_copy_parent_bank(current, p);

should be done in copy_process, and a list is too simple, some
refcounted data structure would work better.

>  	}
>  	return pid;
>  }
> diff -uprN -X elsa_import/dontdiff linux-2.6.5/Makefile linux-2.6.5-elsa/Makefile
> --- linux-2.6.5/Makefile	2004-04-04 05:37:36.000000000 +0200
> +++ linux-2.6.5-elsa/Makefile	2004-05-05 11:06:22.767279384 +0200
> @@ -1,7 +1,7 @@
>  VERSION = 2
>  PATCHLEVEL = 6
>  SUBLEVEL = 5
> -EXTRAVERSION =
> +EXTRAVERSION = -elsa
>  NAME=Zonked Quokka
>  
>  # *DOCUMENTATION*
> 
> 


-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
