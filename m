Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261815AbUK2WBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbUK2WBX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 17:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbUK2WBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 17:01:23 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:28631 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261815AbUK2WA5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 17:00:57 -0500
Date: Mon, 29 Nov 2004 14:00:47 -0800
From: Greg KH <greg@kroah.com>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Rik van Riel <riel@redhat.com>, Chris Mason <mason@suse.com>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [PATCH] CKRM: 3/10 CKRM:  Core ckrm, rcfs
Message-ID: <20041129220047.GC19892@kroah.com>
References: <E1CYqYe-00057g-00@w-gerrit.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CYqYe-00057g-00@w-gerrit.beaverton.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2004 at 10:47:32AM -0800, Gerrit Huizenga wrote:
> +/* Changes
> + *
> + * 12 Nov 2003
> + *        Created.
> + * 22 Apr 2004
> + *        Adopted to classtypes
> + */

Ok, I'm not going to say this for every future file... :)

> +#ifdef __KERNEL__

Not needed.

> +typedef void *(*ce_classify_fct_t) (enum ckrm_event event, void *obj, ...);
> +typedef void (*ce_notify_fct_t) (enum ckrm_event event, void *classobj,
> +				 void *obj);

Ick.  Don't put a _t at the end of a typedef.  Wrong OS style guide.

> +typedef struct ckrm_eng_callback {

no typedef.

> +	/* general state information */
> +	int always_callback;	/* set if CE should always be called back 
> +				   regardless of numclasses */
> +
> +	/* callbacks which are called without holding locks */
> +
> +	unsigned long c_interest;	/* set of classification events of 
> +					 * interest to CE 
> +					 */
> +
> +	/* generic classify */
> +	ce_classify_fct_t classify;
> +
> +	/* class added */
> +	void (*class_add) (const char *name, void *core, int classtype);
> +
> +	/* class deleted */
> +	void (*class_delete) (const char *name, void *core, int classtype);
> +
> +	/* callbacks which are called while holding task_lock(tsk) */
> +	unsigned long n_interest;	/* set of notification events of 
> +					 *  interest to CE 
> +					 */
> +	/* notify on class switch */
> +	ce_notify_fct_t notify;	
> +} ckrm_eng_callback_t;

Especially one that ends in _t again :(

> +struct inode;
> +struct dentry;
> +
> +typedef struct rbce_eng_callback {
> +	int (*mkdir) (struct inode *, struct dentry *, int);	/* mkdir */
> +	int (*rmdir) (struct inode *, struct dentry *);		/* rmdir */
> +	int (*mnt) (void);
> +	int (*umnt) (void);
> +} rbce_eng_callback_t;

Again with the unneeded typedef.  Come on Gerrit, you should know
better...

> +extern int ckrm_register_engine(const char *name, ckrm_eng_callback_t *);
> +extern int ckrm_unregister_engine(const char *name);
> +
> +extern void *ckrm_classobj(char *, int *classtype);
> +extern int get_exe_path_name(struct task_struct *t, char *filename,
> +			     int max_size);

Wasn't this function in some other header file already?

> +
> +extern int rcfs_register_engine(rbce_eng_callback_t *);
> +extern int rcfs_unregister_engine(rbce_eng_callback_t *);
> +
> +extern int ckrm_reclassify(int pid);
> +
> +#ifndef _LINUX_CKRM_RC_H
> +
> +extern void ckrm_core_grab(void *);
> +extern void ckrm_core_drop(void *);

void *?  You can't use a proper type?

> +typedef struct ckrm_shares {
> +	int my_guarantee;
> +	int my_limit;
> +	int total_guarantee;
> +	int max_limit;
> +	int unused_guarantee;	/* not used as parameters */
> +	int cur_max_limit;	/* not used as parameters */
> +} ckrm_shares_t;

Consider this the last of the "no more typedefs except for function
pointers" reminders for the rest of the code base.

> +
> +#define CKRM_SHARE_UNCHANGED     (-1)	
> +#define CKRM_SHARE_DONTCARE      (-2)	
> +#define CKRM_SHARE_DFLT_TOTAL_GUARANTEE (100) 
> +#define CKRM_SHARE_DFLT_MAX_LIMIT     (100)  

Trailing whitespace that is a tab, but yet, no tab within the define
itself.  Odd creature.

> +#define CKRM_CORE_MAGIC		0xBADCAFFE

"Magic" checks should not be needed at all.  Please drop them all.
> +typedef struct ckrm_hnode {
> +	struct ckrm_core_class *parent;
> +	struct list_head siblings;	
> +	struct list_head children;	
> +} ckrm_hnode_t;

I'm going to be over here in the corner, sobbing into my old CodingStyle
presentations that I know I forced you to sit through a number of
times... {sniff}

> +#define ckrm_get_res_class(rescls, resid, type) \
> +	((type*) (((resid != -1) && ((rescls) != NULL) \
> +			   && ((rescls) != (void *)-1)) ? \
> +	 ((struct ckrm_core_class *)(rescls))->res_class[resid] : NULL))

What exactly are you trying to do with this macro?  Cast to see if a
pointer is not -1?  That doesn't sound very safe...

> +static inline void ckrm_core_grab(struct ckrm_core_class *core)
> +{
> +	if (core)
> +		atomic_inc(&core->refcnt);
> +}

Please just use kref, don't invent your own reference counting.

> +/*
> + * iterate through all associate resource controllers:
> + * requires following arguments (ckrm_core_class *cls, 
> + *                               ckrm_res_ctrl   *ctlr,
> + *                               void            *robj,
> + *                               int              bmap)
> + */
> +
> +#define forall_class_resobjs(cls,rcbs,robj,bmap)			\
> +       for ( bmap=((cls->classtype)->bit_res_ctlrs) ;			\
> +	     ({ int rid; ((rid=ffs(bmap)-1) >= 0) &&			\
> +	                 (bmap &= ~(1<<rid),				\
> +				((rcbs=cls->classtype->res_ctlrs[rid])	\
> +				 && (robj=cls->res_class[rid]))); });	\
> +           )

Use kerneldoc comments if you are going to take the time to actually
document a macro.

> +	ckrm_init();

Can't just make it an initcall?  What's wrong with the existing 7 levels
that we have?

> +#include <linux/config.h>
> +#include <linux/init.h>
> +#include <linux/linkage.h>
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <asm/uaccess.h>
> +#include <linux/mm.h>
> +#include <asm/errno.h>
> +#include <linux/string.h>
> +#include <linux/list.h>
> +#include <linux/spinlock.h>
> +#include <linux/module.h>
> +#include <linux/ckrm_rc.h>
> +#include <linux/rcfs.h>
> +#include <net/sock.h>
> +#include <linux/ip.h>

asm includes after the regular ones please.

> +rwlock_t ckrm_class_lock = RW_LOCK_UNLOCKED;	/* protects classlists */

Isn't there a new way to define locks in an initialized state?  Ah yes,
this should use rwlock_init() instead.

> +struct rcfs_functions rcfs_fn;
> +EXPORT_SYMBOL_GPL(rcfs_fn);

I don't understand.  Portions of ckrm are released under the LGPL, while
others are under the GPL?  Why the difference?

> +/*
> + * Return TRUE if the given resource is registered.
> + */

What is "TRUE"?  True in the kernel sense is usually 0 :)

> +struct ckrm_res_ctlr *ckrm_resctlr_lookup(struct ckrm_classtype *clstype,
> +					  const char *resname)
> +{
> +	int resid = -1;
> +
> +	if (!clstype || !resname) {
> +		return NULL;
> +	}

No extra {} needed.

> +/* given a classname return the class handle and its classtype*/
> +void *ckrm_classobj(char *classname, int *classTypeID)

Why not use proper kerneldoc form of comments if you are going to try to
document the api?

> +	*classTypeID = -1;

MixedCaseVariablesAreNotTheLinuxWay.
PleaseReadDocumentationCodingStyleYetAgain.

> +EXPORT_SYMBOL_GPL(is_res_regd);

Not the nicest global symbol.  Why not put ckrm at the front?

> +/*
> + * Registering a callback structure by the classification engine.
> + *
> + * Returns typeId of class on success -errno for failure.
> + */
> +int ckrm_register_engine(const char *typename, ckrm_eng_callback_t * ecbs)
> +{
> +	struct ckrm_classtype *ctype;
> +
> +	ctype = ckrm_find_classtype_by_name(typename);
> +	if (ctype == NULL)
> +		return (-ENOENT);
> +
> +	atomic_inc(&ctype->ce_regd);
> +
> +	/* another engine registered or trying to register ? */
> +	if (atomic_read(&ctype->ce_regd) != 1) {
> +		atomic_dec(&ctype->ce_regd);
> +		return (-EBUSY);
> +	}

Why not just use a lock if you are worried about this?

> +int ckrm_unregister_engine(const char *typename)
> +{
> +	struct ckrm_classtype *ctype;
> +
> +	ctype = ckrm_find_classtype_by_name(typename);
> +	if (ctype == NULL)
> +		return (-ENOENT);

return is not a function.

> +#define CLS_DEBUG(fmt, args...) \
> +do { /* printk("%s: " fmt, __FUNCTION__ , ## args); */ } while (0)

Again, use pr_debug() please.

> +int
> +ckrm_init_core_class(struct ckrm_classtype *clstype,
> +		     struct ckrm_core_class *dcore,
> +		     struct ckrm_core_class *parent, const char *name)
> +{
> +	/* TODO:  Should replace name with dentry or add dentry? */

Shouldn't the TODO's be done by now?


> +	int i;
> +
> +	/* TODO:  How is this used in initialization? */

This makes me feel warm and fuzzy...

> +	CLS_DEBUG("name %s => %p\n", name ? name : "default", dcore);
> +	if ((dcore != clstype->default_class) && (!ckrm_is_core_valid(parent))){
> +		printk("error not a valid parent %p\n", parent);

printk() always needs a KERN_ value or the kernel janitors will come
running after you with their pitchforks.  You do this in a lot of
different places, please fix all of them.

> +	if ((clstype == NULL) || (resid < 0)) {
> +		return -EINVAL;
> +	}

Again, {} not needed here, and in lots of other single statment if
lines.  Please fix them all.

> +	/* TODO: probably need to also call deregistration function */

Well, do you? :)

> +	/* TODO: Need to call the callbacks of the RCFS client */
> +	if (rcfs_fn.register_classtype) {
> +		(*rcfs_fn.register_classtype) (clstype);
> +		/* No error return for now. */

Why no error return?

> +	}
> +	return tid;
> +}
> +
> +int ckrm_unregister_classtype(struct ckrm_classtype *clstype)
> +{
> +	int tid = clstype->typeID;
> +
> +	if ((tid < 0) || (tid > CKRM_MAX_CLASSTYPES)
> +	    || (ckrm_classtypes[tid] != clstype))
> +		return -EINVAL;
> +
> +	if (rcfs_fn.deregister_classtype) {
> +		(*rcfs_fn.deregister_classtype) (clstype);
> +		// No error return for now

Again, why no error?

> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.10-rc2/kernel/ckrm/ckrmutils.c	2004-11-19 20:43:43.524211803 -0800
> @@ -0,0 +1,195 @@
> +/*
> + * ckrmutils.c - Utility functions for CKRM
> + *
> + * Copyright (C) Chandra Seetharaman,  IBM Corp. 2003
> + *           (C) Hubertus Franke    ,  IBM Corp. 2004
> + * 
> + * Provides simple utility functions for the core module, CE and resource
> + * controllers.
> + *
> + * Latest version, more details at http://ckrm.sf.net
> + * 
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.

You sure you want the "any later version" on here?  :)

> +int get_exe_path_name(struct task_struct *tsk, char *buf, int buflen)

Path name in what namespace?  I don't think this code is correct, or
valid, or even legal.  Why do you need the full pathname of a program?

> +/*
> + * must be called with cnt_lock of parres held

Please put the proper sparse documention in the function call that
checks for this then.


> + * Caller is responsible for holding any lock to protect the data
> + * structures passed to this function
> + */
> +int
> +set_shares(struct ckrm_shares *new, struct ckrm_shares *cur,
> +	   struct ckrm_shares *par)
> +{
> +	int rc = -EINVAL;
> +	int cur_usage_guar = cur->total_guarantee - cur->unused_guarantee;
> +	int increase_by = new->my_guarantee - cur->my_guarantee;
> +
> +	/* Check total_guarantee for correctness */
> +	if (new->total_guarantee <= CKRM_SHARE_DONTCARE) {
> +		goto set_share_err;
> +	} else if (new->total_guarantee == CKRM_SHARE_UNCHANGED) {
> +		/* do nothing */;
> +	} else if (cur_usage_guar > new->total_guarantee) {
> +		goto set_share_err;
> +	}
> +	/* Check max_limit for correctness */
> +	if (new->max_limit <= CKRM_SHARE_DONTCARE) {
> +		goto set_share_err;
> +	} else if (new->max_limit == CKRM_SHARE_UNCHANGED) {
> +		/* do nothing */;
> +	} else if (cur->cur_max_limit > new->max_limit) {
> +		goto set_share_err;
> +	}
> +	/* Check my_guarantee for correctness */
> +	if (new->my_guarantee == CKRM_SHARE_UNCHANGED) {
> +		/* do nothing */;
> +	} else if (new->my_guarantee == CKRM_SHARE_DONTCARE) {
> +		/* do nothing */;
> +	} else if (par && increase_by > par->unused_guarantee) {
> +		goto set_share_err;
> +	}
> +	/* Check my_limit for correctness */
> +	if (new->my_limit == CKRM_SHARE_UNCHANGED) {
> +		/* do nothing */;
> +	} else if (new->my_limit == CKRM_SHARE_DONTCARE) {
> +		/* do nothing */;
> +	} else if (par && new->my_limit > par->max_limit) {
> +		/* I can't get more limit than my parent's limit */
> +		goto set_share_err;
> +
> +	}
> +	/* make sure guarantee is lesser than limit */
> +	if (new->my_limit == CKRM_SHARE_DONTCARE) {
> +		/* do nothing */;
> +	} else if (new->my_limit == CKRM_SHARE_UNCHANGED) {
> +		if (new->my_guarantee == CKRM_SHARE_DONTCARE) {
> +			/* do nothing */;
> +		} else if (new->my_guarantee == CKRM_SHARE_UNCHANGED) {
> +			/*
> +			 * do nothing; earlier setting would have
> +			 * taken care of it
> +			 */;
> +		} else if (new->my_guarantee > cur->my_limit) {
> +			goto set_share_err;
> +		}
> +	} else {		/* new->my_limit has a valid value */
> +		if (new->my_guarantee == CKRM_SHARE_DONTCARE) {
> +			/* do nothing */;
> +		} else if (new->my_guarantee == CKRM_SHARE_UNCHANGED) {
> +			if (cur->my_guarantee > new->my_limit) {
> +				goto set_share_err;
> +			}
> +		} else if (new->my_guarantee > new->my_limit) {
> +			goto set_share_err;
> +		}
> +	}
> +	if (new->my_guarantee != CKRM_SHARE_UNCHANGED) {
> +		child_guarantee_changed(par, cur->my_guarantee,
> +					new->my_guarantee);
> +		cur->my_guarantee = new->my_guarantee;
> +	}
> +	if (new->my_limit != CKRM_SHARE_UNCHANGED) {
> +		child_maxlimit_changed(par, new->my_limit);
> +		cur->my_limit = new->my_limit;
> +	}
> +	if (new->total_guarantee != CKRM_SHARE_UNCHANGED) {
> +		cur->unused_guarantee = new->total_guarantee - cur_usage_guar;
> +		cur->total_guarantee = new->total_guarantee;
> +	}
> +	if (new->max_limit != CKRM_SHARE_UNCHANGED) {
> +		cur->max_limit = new->max_limit;
> +	}
> +	rc = 0;
> +set_share_err:
> +	return rc;
> +}

There's a whole lot of "nothing" going on in this function.  Care to
optimise it to get rid of those types of checks?  Or are you relying on
the compiler to do it for you?

thanks,

greg k-h
