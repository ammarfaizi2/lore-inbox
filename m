Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262125AbVBXJf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262125AbVBXJf6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 04:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262204AbVBXJf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 04:35:57 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:53998 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262125AbVBXJdP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 04:33:15 -0500
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Rik van Riel <riel@redhat.com>, Chris Mason <mason@suse.com>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [PATCH] CKRM: 3/10 CKRM: Core ckrm, rcfs 
In-reply-to: Your message of Mon, 29 Nov 2004 14:00:47 PST.
             <20041129220047.GC19892@kroah.com> 
Date: Thu, 24 Feb 2005 01:33:12 -0800
Message-Id: <E1D4FMu-0006ut-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 29 Nov 2004 14:00:47 PST, Greg KH wrote:
> On Mon, Nov 29, 2004 at 10:47:32AM -0800, Gerrit Huizenga wrote:
> > +/* Changes
> > + *
> > + * 12 Nov 2003
> > + *        Created.
> > + * 22 Apr 2004
> > + *        Adopted to classtypes
> > + */
> 
> Ok, I'm not going to say this for every future file... :)
 
Good - I won't have to say "globally fixed" for each one, then.  ;)

> > +#ifdef __KERNEL__
> 
> Not needed.

Ditto.

> > +typedef void *(*ce_classify_fct_t) (enum ckrm_event event, void *obj, ...);
> > +typedef void (*ce_notify_fct_t) (enum ckrm_event event, void *classobj,
> > +				 void *obj);
> 
> Ick.  Don't put a _t at the end of a typedef.  Wrong OS style guide.
 
Fixed.  Although this isn't an OS style guide thing - it is a Posix
driven convention whereby any header file defined in the standard
automatically has _t suffixed variables reserved to the implementation,
e.g. no application is define variables using _t.  This header file isn't
being used by user level applications so it doesn't matter.

> > +typedef struct ckrm_eng_callback {
> 
> no typedef.

Fixed (globally).

> > +	/* general state information */
> > +	int always_callback;	/* set if CE should always be called back 
> > +				   regardless of numclasses */
> > +
> > +	/* callbacks which are called without holding locks */
> > +
> > +	unsigned long c_interest;	/* set of classification events of 
> > +					 * interest to CE 
> > +					 */
> > +
> > +	/* generic classify */
> > +	ce_classify_fct_t classify;
> > +
> > +	/* class added */
> > +	void (*class_add) (const char *name, void *core, int classtype);
> > +
> > +	/* class deleted */
> > +	void (*class_delete) (const char *name, void *core, int classtype);
> > +
> > +	/* callbacks which are called while holding task_lock(tsk) */
> > +	unsigned long n_interest;	/* set of notification events of 
> > +					 *  interest to CE 
> > +					 */
> > +	/* notify on class switch */
> > +	ce_notify_fct_t notify;	
> > +} ckrm_eng_callback_t;
> 
> Especially one that ends in _t again :(
 
Fixed (globally).

> > +struct inode;
> > +struct dentry;
> > +
> > +typedef struct rbce_eng_callback {
> > +	int (*mkdir) (struct inode *, struct dentry *, int);	/* mkdir */
> > +	int (*rmdir) (struct inode *, struct dentry *);		/* rmdir */
> > +	int (*mnt) (void);
> > +	int (*umnt) (void);
> > +} rbce_eng_callback_t;
> 
> Again with the unneeded typedef.  Come on Gerrit, you should know
> better...
 
Sorry, years of implementing Posix conformant OS's and system header
files make this very common for anyone (including several of the
CKRM developers).  Specifically because of user level name space
collision avoidance issues (e.g. think preserving backwards compatibility
for user level apps).  It is the primary mechanism for simplifying the
#ifdef __KERNEL__ crap used in most OS's.

> > +extern int ckrm_register_engine(const char *name, ckrm_eng_callback_t *);
> > +extern int ckrm_unregister_engine(const char *name);
> > +
> > +extern void *ckrm_classobj(char *, int *classtype);
> > +extern int get_exe_path_name(struct task_struct *t, char *filename,
> > +			     int max_size);
> 
> Wasn't this function in some other header file already?
 
And equally unnecessary in the current code.  Fixed.

> > +
> > +extern int rcfs_register_engine(rbce_eng_callback_t *);
> > +extern int rcfs_unregister_engine(rbce_eng_callback_t *);
> > +
> > +extern int ckrm_reclassify(int pid);
> > +
> > +#ifndef _LINUX_CKRM_RC_H
> > +
> > +extern void ckrm_core_grab(void *);
> > +extern void ckrm_core_drop(void *);
> 
> void *?  You can't use a proper type?
 
That was odd - definition was correct, declaration was silly.  Fixed.

> > +typedef struct ckrm_shares {
> > +	int my_guarantee;
> > +	int my_limit;
> > +	int total_guarantee;
> > +	int max_limit;
> > +	int unused_guarantee;	/* not used as parameters */
> > +	int cur_max_limit;	/* not used as parameters */
> > +} ckrm_shares_t;
> 
> Consider this the last of the "no more typedefs except for function
> pointers" reminders for the rest of the code base.
 
Good enough.  All applied.

> > +
> > +#define CKRM_SHARE_UNCHANGED     (-1)	
> > +#define CKRM_SHARE_DONTCARE      (-2)	
> > +#define CKRM_SHARE_DFLT_TOTAL_GUARANTEE (100) 
> > +#define CKRM_SHARE_DFLT_MAX_LIMIT     (100)  
> 
> Trailing whitespace that is a tab, but yet, no tab within the define
> itself.  Odd creature.
 
Yeah, I'm not sure what some of the original authors used for editors
or if they just had big thumbs resting on the space bar.  Fixed.

> > +#define CKRM_CORE_MAGIC		0xBADCAFFE
>
> "Magic" checks should not be needed at all.  Please drop them all.
 
I'd like to leave them in while we are testing with -mm to help
tracking down any potential problems.  Prior to going to Linus',
yes, I think it makes sense to get rid of these.

> > +typedef struct ckrm_hnode {
> > +	struct ckrm_core_class *parent;
> > +	struct list_head siblings;	
> > +	struct list_head children;	
> > +} ckrm_hnode_t;
> 
> I'm going to be over here in the corner, sobbing into my old CodingStyle
> presentations that I know I forced you to sit through a number of
> times... {sniff}
 
I *would* recommend you update the coding style to point out the
Posix convention - it saves people from using __KERNEL__ in some
cases, and I *know* how much you hate that one, too.  ;-)

> > +#define ckrm_get_res_class(rescls, resid, type) \
> > +	((type*) (((resid != -1) && ((rescls) != NULL) \
> > +			   && ((rescls) != (void *)-1)) ? \
> > +	 ((struct ckrm_core_class *)(rescls))->res_class[resid] : NULL))
> 
> What exactly are you trying to do with this macro?  Cast to see if a
> pointer is not -1?  That doesn't sound very safe...

This needs to be fixed and better commented.  Basically, when a task
is exiting, it's class can be set to -1 (-1 in a pointer is, uh, icky).
But when uninitialized, it is set to NULL.  We need to come up with
a better fix for this one.

> > +static inline void ckrm_core_grab(struct ckrm_core_class *core)
> > +{
> > +	if (core)
> > +		atomic_inc(&core->refcnt);
> > +}
> 
> Please just use kref, don't invent your own reference counting.
 
I agree with this but haven't gotten to it yet.  It will take
a bit more transformation since the current code is 0 based references
and kref_t's appear to be initialized to 1.  Also, the interactions with
freeing code will need just a little bit of thought.  So I'm deferring
this for the moment but not dropping it.

> > +/*
> > + * iterate through all associate resource controllers:
> > + * requires following arguments (ckrm_core_class *cls, 
> > + *                               ckrm_res_ctrl   *ctlr,
> > + *                               void            *robj,
> > + *                               int              bmap)
> > + */
> > +
> > +#define forall_class_resobjs(cls,rcbs,robj,bmap)			\
> > +       for ( bmap=((cls->classtype)->bit_res_ctlrs) ;			\
> > +	     ({ int rid; ((rid=ffs(bmap)-1) >= 0) &&			\
> > +	                 (bmap &= ~(1<<rid),				\
> > +				((rcbs=cls->classtype->res_ctlrs[rid])	\
> > +				 && (robj=cls->res_class[rid]))); });	\
> > +           )
> 
> Use kerneldoc comments if you are going to take the time to actually
> document a macro.

Will do a more full sweep for doing kerneldoc since we are updating
documentation in general at the moment.

> > +	ckrm_init();
> 
> Can't just make it an initcall?  What's wrong with the existing 7 levels
> that we have?
 
Okay, the initcalls hurt my head for a moment.  It looks like a quick
converstion to initcalls might change the order of events and I want
to hold off on that until I can make sure it doesn't break other things.
There are several order dependencies between the core, the filesystem
and the (potential) modules for controllers.

> > +#include <linux/config.h>
> > +#include <linux/init.h>
> > +#include <linux/linkage.h>
> > +#include <linux/kernel.h>
> > +#include <linux/errno.h>
> > +#include <asm/uaccess.h>
> > +#include <linux/mm.h>
> > +#include <asm/errno.h>
> > +#include <linux/string.h>
> > +#include <linux/list.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/module.h>
> > +#include <linux/ckrm_rc.h>
> > +#include <linux/rcfs.h>
> > +#include <net/sock.h>
> > +#include <linux/ip.h>
> 
> asm includes after the regular ones please.
 
Done.

> > +rwlock_t ckrm_class_lock = RW_LOCK_UNLOCKED;	/* protects classlists */
> 
> Isn't there a new way to define locks in an initialized state?  Ah yes,
> this should use rwlock_init() instead.
 
Done.

> > +struct rcfs_functions rcfs_fn;
> > +EXPORT_SYMBOL_GPL(rcfs_fn);
> 
> I don't understand.  Portions of ckrm are released under the LGPL, while
> others are under the GPL?  Why the difference?
 
Okay - I *just* realized why you've mentioned the LGPL twice.  Which is
there because some of the headers contain definitions that *could*
be used by user level applications of CKRM.  But the licensing looks
screwed up slightly at the moment.  I'll straighten that up in the
next release.  The goal is to minimize the exports to user land while
still allowing some header files to be shared.  It isn't done correctly
IMHO right now.  Will fix.

> > +/*
> > + * Return TRUE if the given resource is registered.
> > + */
> 
> What is "TRUE"?  True in the kernel sense is usually 0 :)

So if (0) is true.  Wow.  Modified comment to say "non-zero".  I think
every definition of TRUE I could find was "1".  But TRUE is just an
arbitrary definition.  ;-)

> > +struct ckrm_res_ctlr *ckrm_resctlr_lookup(struct ckrm_classtype *clstype,
> > +					  const char *resname)
> > +{
> > +	int resid = -1;
> > +
> > +	if (!clstype || !resname) {
> > +		return NULL;
> > +	}
> 
> No extra {} needed.
 
Fixed.

> > +/* given a classname return the class handle and its classtype*/
> > +void *ckrm_classobj(char *classname, int *classTypeID)
> 
> Why not use proper kerneldoc form of comments if you are going to try to
> document the api?
 
Will do in the future.

> > +	*classTypeID = -1;
> 
> MixedCaseVariablesAreNotTheLinuxWay.
> PleaseReadDocumentationCodingStyleYetAgain.
 
Fixed.

> > +EXPORT_SYMBOL_GPL(is_res_regd);
> 
> Not the nicest global symbol.  Why not put ckrm at the front?
 
Fixed.

> > +/*
> > + * Registering a callback structure by the classification engine.
> > + *
> > + * Returns typeId of class on success -errno for failure.
> > + */
> > +int ckrm_register_engine(const char *typename, ckrm_eng_callback_t * ecbs)
> > +{
> > +	struct ckrm_classtype *ctype;
> > +
> > +	ctype = ckrm_find_classtype_by_name(typename);
> > +	if (ctype == NULL)
> > +		return (-ENOENT);
> > +
> > +	atomic_inc(&ctype->ce_regd);
> > +
> > +	/* another engine registered or trying to register ? */
> > +	if (atomic_read(&ctype->ce_regd) != 1) {
> > +		atomic_dec(&ctype->ce_regd);
> > +		return (-EBUSY);
> > +	}
> 
> Why not just use a lock if you are worried about this?
 
Wanted to avoid holding a lock while crossing the module boundary.
And, this is a very unlikely race.

> > +int ckrm_unregister_engine(const char *typename)
> > +{
> > +	struct ckrm_classtype *ctype;
> > +
> > +	ctype = ckrm_find_classtype_by_name(typename);
> > +	if (ctype == NULL)
> > +		return (-ENOENT);
> 
> return is not a function.
 
*snicker*  yeah.  See that space - must be a paranthetical expression.  ;)
Fixed.

> > +#define CLS_DEBUG(fmt, args...) \
> > +do { /* printk("%s: " fmt, __FUNCTION__ , ## args); */ } while (0)
> 
> Again, use pr_debug() please.
 
Done.

> > +int
> > +ckrm_init_core_class(struct ckrm_classtype *clstype,
> > +		     struct ckrm_core_class *dcore,
> > +		     struct ckrm_core_class *parent, const char *name)
> > +{
> > +	/* TODO:  Should replace name with dentry or add dentry? */
> 
> Shouldn't the TODO's be done by now?
 
This is an evolving project.  We could always do more.  I'd rather
release early and often (which we haven't done well so far) than to
dump a 100% complete project out at the end of development.
 
> > +	int i;
> > +
> > +	/* TODO:  How is this used in initialization? */
> 
> This makes me feel warm and fuzzy...

Looks like a stale comment but I'll verify with the original author
before I yank it.

> > +	CLS_DEBUG("name %s => %p\n", name ? name : "default", dcore);
> > +	if ((dcore != clstype->default_class) && (!ckrm_is_core_valid(parent))){
> > +		printk("error not a valid parent %p\n", parent);
> 
> printk() always needs a KERN_ value or the kernel janitors will come
> running after you with their pitchforks.  You do this in a lot of
> different places, please fix all of them.

Fixed with pr_debug().

> > +	if ((clstype == NULL) || (resid < 0)) {
> > +		return -EINVAL;
> > +	}
> 
> Again, {} not needed here, and in lots of other single statment if
> lines.  Please fix them all.
 
I think I have now.

> > +	/* TODO: probably need to also call deregistration function */
> 
> Well, do you? :)
> 
> > +	/* TODO: Need to call the callbacks of the RCFS client */
> > +	if (rcfs_fn.register_classtype) {
> > +		(*rcfs_fn.register_classtype) (clstype);
> > +		/* No error return for now. */
> 
> Why no error return?
> 
> > +	}
> > +	return tid;
> > +}
> > +
> > +int ckrm_unregister_classtype(struct ckrm_classtype *clstype)
> > +{
> > +	int tid = clstype->typeID;
> > +
> > +	if ((tid < 0) || (tid > CKRM_MAX_CLASSTYPES)
> > +	    || (ckrm_classtypes[tid] != clstype))
> > +		return -EINVAL;
> > +
> > +	if (rcfs_fn.deregister_classtype) {
> > +		(*rcfs_fn.deregister_classtype) (clstype);
> > +		// No error return for now
> 
> Again, why no error?
 
None of the controllers currently generate an error, even though
in the future they might.

> > --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> > +++ linux-2.6.10-rc2/kernel/ckrm/ckrmutils.c	2004-11-19 20:43:43.524211803 -0800
> > @@ -0,0 +1,195 @@
> > +/*
> > + * ckrmutils.c - Utility functions for CKRM
> > + *
> > + * Copyright (C) Chandra Seetharaman,  IBM Corp. 2003
> > + *           (C) Hubertus Franke    ,  IBM Corp. 2004
> > + * 
> > + * Provides simple utility functions for the core module, CE and resource
> > + * controllers.
> > + *
> > + * Latest version, more details at http://ckrm.sf.net
> > + * 
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> 
> You sure you want the "any later version" on here?  :)
 
Nope.  Copied from somewhere.  Fixed.

> > +int get_exe_path_name(struct task_struct *tsk, char *buf, int buflen)
> 
> Path name in what namespace?  I don't think this code is correct, or
> valid, or even legal.  Why do you need the full pathname of a program?
 
Gone.  Kabut.  Removed.  Unnneeded.

> > +/*
> > + * must be called with cnt_lock of parres held
> 
> Please put the proper sparse documention in the function call that
> checks for this then.
 
Will do.  Not in the next patch set but full sparse work coming soon.

> > + * Caller is responsible for holding any lock to protect the data
> > + * structures passed to this function
> > + */
> > +int
> > +set_shares(struct ckrm_shares *new, struct ckrm_shares *cur,
> > +	   struct ckrm_shares *par)
> > +{
> > +	int rc = -EINVAL;
> > +	int cur_usage_guar = cur->total_guarantee - cur->unused_guarantee;
> > +	int increase_by = new->my_guarantee - cur->my_guarantee;
> > +
> > +	/* Check total_guarantee for correctness */
> > +	if (new->total_guarantee <= CKRM_SHARE_DONTCARE) {
> > +		goto set_share_err;
> > +	} else if (new->total_guarantee == CKRM_SHARE_UNCHANGED) {
> > +		/* do nothing */;
> > +	} else if (cur_usage_guar > new->total_guarantee) {
> > +		goto set_share_err;
> > +	}
> > +	/* Check max_limit for correctness */
> > +	if (new->max_limit <= CKRM_SHARE_DONTCARE) {
> > +		goto set_share_err;
> > +	} else if (new->max_limit == CKRM_SHARE_UNCHANGED) {
> > +		/* do nothing */;
> > +	} else if (cur->cur_max_limit > new->max_limit) {
> > +		goto set_share_err;
> > +	}
> > +	/* Check my_guarantee for correctness */
> > +	if (new->my_guarantee == CKRM_SHARE_UNCHANGED) {
> > +		/* do nothing */;
> > +	} else if (new->my_guarantee == CKRM_SHARE_DONTCARE) {
> > +		/* do nothing */;
> > +	} else if (par && increase_by > par->unused_guarantee) {
> > +		goto set_share_err;
> > +	}
> > +	/* Check my_limit for correctness */
> > +	if (new->my_limit == CKRM_SHARE_UNCHANGED) {
> > +		/* do nothing */;
> > +	} else if (new->my_limit == CKRM_SHARE_DONTCARE) {
> > +		/* do nothing */;
> > +	} else if (par && new->my_limit > par->max_limit) {
> > +		/* I can't get more limit than my parent's limit */
> > +		goto set_share_err;
> > +
> > +	}
> > +	/* make sure guarantee is lesser than limit */
> > +	if (new->my_limit == CKRM_SHARE_DONTCARE) {
> > +		/* do nothing */;
> > +	} else if (new->my_limit == CKRM_SHARE_UNCHANGED) {
> > +		if (new->my_guarantee == CKRM_SHARE_DONTCARE) {
> > +			/* do nothing */;
> > +		} else if (new->my_guarantee == CKRM_SHARE_UNCHANGED) {
> > +			/*
> > +			 * do nothing; earlier setting would have
> > +			 * taken care of it
> > +			 */;
> > +		} else if (new->my_guarantee > cur->my_limit) {
> > +			goto set_share_err;
> > +		}
> > +	} else {		/* new->my_limit has a valid value */
> > +		if (new->my_guarantee == CKRM_SHARE_DONTCARE) {
> > +			/* do nothing */;
> > +		} else if (new->my_guarantee == CKRM_SHARE_UNCHANGED) {
> > +			if (cur->my_guarantee > new->my_limit) {
> > +				goto set_share_err;
> > +			}
> > +		} else if (new->my_guarantee > new->my_limit) {
> > +			goto set_share_err;
> > +		}
> > +	}
> > +	if (new->my_guarantee != CKRM_SHARE_UNCHANGED) {
> > +		child_guarantee_changed(par, cur->my_guarantee,
> > +					new->my_guarantee);
> > +		cur->my_guarantee = new->my_guarantee;
> > +	}
> > +	if (new->my_limit != CKRM_SHARE_UNCHANGED) {
> > +		child_maxlimit_changed(par, new->my_limit);
> > +		cur->my_limit = new->my_limit;
> > +	}
> > +	if (new->total_guarantee != CKRM_SHARE_UNCHANGED) {
> > +		cur->unused_guarantee = new->total_guarantee - cur_usage_guar;
> > +		cur->total_guarantee = new->total_guarantee;
> > +	}
> > +	if (new->max_limit != CKRM_SHARE_UNCHANGED) {
> > +		cur->max_limit = new->max_limit;
> > +	}
> > +	rc = 0;
> > +set_share_err:
> > +	return rc;
> > +}
> 
> There's a whole lot of "nothing" going on in this function.  Care to
> optimise it to get rid of those types of checks?  Or are you relying on
> the compiler to do it for you?
 
Most of this should be pretty straightforward for optimization but
yeah, some code wrangling could make this both easier to read and
more likely easier to optimize.  Probably will convert this to
a bunch of shorter, more focused inline functions.  Will save this
for a future release, though.

thanks!

gerrit
