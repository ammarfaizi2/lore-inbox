Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267866AbUJGTvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267866AbUJGTvG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 15:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267872AbUJGTrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 15:47:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:18075 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267620AbUJGTmX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 15:42:23 -0400
Date: Thu, 7 Oct 2004 12:42:21 -0700
From: Chris Wright <chrisw@osdl.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, chrisw@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2/3] lsm: add bsdjail module
Message-ID: <20041007124221.D2357@build.pdx.osdl.net>
References: <1097094103.6939.5.camel@serge.austin.ibm.com> <1097094270.6939.9.camel@serge.austin.ibm.com> <20041006162620.4c378320.akpm@osdl.org> <20041007190157.GA3892@IBM-BWN8ZTBWA01.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041007190157.GA3892@IBM-BWN8ZTBWA01.austin.ibm.com>; from serue@us.ibm.com on Thu, Oct 07, 2004 at 02:01:57PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Serge E. Hallyn (serue@us.ibm.com) wrote:
> Attached is a new version of the bsdjail patch with the requested code
> cleanups applied.

I noticed Andrew picked this up in -mm3, but that he had to do some diff
cleanups (see the thread/rlim changes in his tree).  If you'd like Andrew
to pick this up, it would be courteous to get the diff clean and
building against his tree.

> --- linux-2.6.9-rc3-bk6/security/bsdjail.c	1969-12-31 18:00:00.000000000 -0600
> +++ linux-2.6.9-rc3-bk6-jail/security/bsdjail.c	2004-10-07 11:30:21.000000000 -0500
> @@ -0,0 +1,1495 @@
> +/*
> + * File: linux/security/bsdjail.c
> + * Author: Serge Hallyn (serue@us.ibm.com)
> + * Date: Sep 12, 2004
> + *
> + * (See Documentation/bsdjail.txt for more information)
> + *
> + * Copyright (C) 2004 International Business Machines <serue@us.ibm.com>
> + *
> + *   This program is free software; you can redistribute it and/or modify
> + *   it under the terms of the GNU General Public License as published by
> + *   the Free Software Foundation; either version 2 of the License, or
> + *   (at your option) any later version.
> + */
> +
> +#include <linux/config.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/security.h>
> +#include <linux/namei.h>
> +#include <linux/namespace.h>
> +#include <linux/proc_fs.h>
> +#include <linux/in.h>
> +#include <linux/in6.h>
> +#include <linux/pagemap.h>
> +#include <linux/ip.h>
> +#include <net/ipv6.h>
> +#include <linux/mount.h>
> +#include <asm/uaccess.h>
> +#include <linux/netdevice.h>
> +#include <linux/inetdevice.h>
> +#include <linux/seq_file.h>
> +#include <linux/un.h>
> +#include <linux/smp_lock.h>
> +#include <linux/kref.h>

asm/ includes after linux/

> +
> +static int jail_debug = 0;

unecessary assignment to 0.

> +MODULE_PARM(jail_debug, "i");

use module_param

> +MODULE_PARM_DESC(jail_debug, "Print bsd jail debugging messages.\n");
> +
> +#define DBG 0
> +#define WARN 1
> +#define bsdj_debug(how, fmt, arg... ) \
> +	do { \
> +		if ( how || jail_debug ) \
> +			printk(KERN_NOTICE "%s: %s: " fmt, \
> +				MY_NAME, __FUNCTION__, \

Andrew has cleanup here (__FUNCTION__ ,).  I just use __func__, anyway.

> +				## arg ); \
> +	} while ( 0 )
> +
> +#define MY_NAME "bsdjail"
> +
> +/* flag to keep track of how we were registered */
> +static int secondary = 0;

unecessary assignment to 0

> +/*
> + * The task structure holding jail information.
> + * Taskp->security points to one of these (or is null).
> + * There is exactly one jail_struct for each jail.  If >1 process
> + * are in the same jail, they share the same jail_struct.
> + */
> +struct jail_struct {
> +	struct kref		kref;
> +
> +	/* these are set on writes to /proc/<pid>/attr/exec */
> +	char *root_pathname; /* char * containing path to use as jail / */
> +	char *ip4_addr_name;  /* char * containing ip4 addr to use for jail */
> +	char *ip6_addr_name;  /* char * containing ip6 addr to use for jail */
> +
> +	/* these are set when a jail becomes active */
> +	__u32 addr4;      	/* internal form of ip4_addr_name */
> +	struct in6_addr addr6;	/* internal form of ip6_addr_name */
> +
> +	struct dentry *dentry;  /* dentry of fs root */
> +	struct vfsmount *mnt;   /* vfsmnt of fs root */
> +
> +	/* Resource limits.  0 = no limit */
> +	int max_nrtask;		/* maximum number of tasks within this jail. */
> +	int cur_nrtask;	/* current number of tasks within this jail. */
> +	long maxtimeslice;      /* max timeslice in ms for procs in this jail */
> +	long nice;      	/* nice level for processes in this jail */
> +	long max_data, max_memlock;  /* equivalent to RLIMIT_{DATA, MEMLOCK} */
> +/* values for the jail_flags field */
> +#define IN_USE 1	 /* if 0, task is setting up jail, not yet in it */
> +#define GOT_IPV4 2
> +#define GOT_IPV6 4	 /* if 0, ipv4, else ipv6 */
> +	char jail_flags;
> +};

Could go into header.  Perhaps not needed if it's all there is, and it's
not shared anywhere though.

> +/*
> + * disable_jail:  A jail which was in use, but has no references
> + * left, is disabled - we free up the mountpoint and dentry, and
> + * give up our reference on the module.
> + *
> + *   don't need to put namespace, it will be done automatically
> + *     when the last process in jail is put.
> + *   DO need to put the dentry and vfsmount
> + */
> +static void
> +disable_jail(struct jail_struct *tsec)
> +{
> +	dput(tsec->dentry);
> +	mntput(tsec->mnt);
> +	module_put(THIS_MODULE);
> +}
> +
> +
> +static void free_jail(struct jail_struct *tsec)
> +{
> +	if (!tsec)
> +		return;
> +
> +	kfree(tsec->root_pathname);
> +	kfree(tsec->ip4_addr_name);
> +	kfree(tsec->ip6_addr_name);
> +	kfree(tsec);
> +}
> +
> +/* release_jail:
> + * Callback for kref_put to use for releasing a jail when its
> + * last user exits.
> + */
> +static void release_jail(struct kref *kref)
> +{
> +	struct jail_struct *tsec;
> +
> +	tsec = container_of(kref, struct jail_struct, kref);
> +	disable_jail(tsec);
> +	free_jail(tsec);
> +}
> +
> +/*
> + * jail_task_free_security: this is the callback hooked into LSM.
> + * If there was no task->security field for bsdjail, do nothing.
> + * If there was, but it was never put into use, free the jail.
> + * If there was, and the jail is in use, then decrement the usage
> + *  count, and disable and free the jail if the usage count hits 0.
> + */
> +static void jail_task_free_security(struct task_struct *task)
> +{
> +	struct jail_struct *tsec;
> +
> +	tsec = task->security;
> +
> +	if (!tsec)
> +		return;
> +
> +	if (!(tsec->jail_flags & IN_USE)) {
> +		/*
> +		 * someone did 'echo -n x > /proc/<pid>/attr/exec' but
> +		 * then forked before execing.  Nuke the old info.
> +		 */
> +		free_jail(tsec);
> +		task->security = NULL;
> +		return;
> +	}
> +	tsec->cur_nrtask--;
> +	/* If this was the last process in the jail, delete the jail */
> +	kref_put(&tsec->kref, release_jail);
> +}
> +
> +static struct jail_struct *
> +alloc_task_security(struct task_struct *tsk)
> +{
> +	struct jail_struct *tsec;
> +	tsec = kmalloc(sizeof(struct jail_struct), GFP_KERNEL);
> +	if (!tsec)
> +		return ERR_PTR(-ENOMEM);

Just return NULL, that's expected norm, plus you're not using the error
anyway.

> +	memset(tsec, 0, sizeof(struct jail_struct));
> +	tsk->security = tsec;
> +	return tsec;
> +}
> +
> +static inline int
> +in_jail(struct task_struct *t)
> +{
> +	struct jail_struct *tsec = t->security;
> +
> +	if (tsec && (tsec->jail_flags & IN_USE))
> +		return 1;
> +
> +	return 0;
> +}
> +
> +/*
> + * If a network address was passed into /proc/<pid>/attr/exec,
> + * then process in its jail will only be allowed to bind/listen
> + * to that address.
> + */
> +static void
> +setup_netaddress(struct jail_struct *tsec)
> +{
> +	unsigned int a, b, c, d, i;
> +	unsigned int x[8];
> +
> +	tsec->jail_flags &= ~(GOT_IPV4 | GOT_IPV6);
> +	tsec->addr4 = 0;
> +	ipv6_addr_set(&tsec->addr6, 0, 0, 0, 0);
> +
> +	if (tsec->ip4_addr_name) {
> +		if (sscanf(tsec->ip4_addr_name, "%u.%u.%u.%u",
> +					&a, &b, &c, &d) != 4)
> +			return;
> +		if (a>255 || b>255 || c>255 || d>255)
> +			return;
> +		tsec->addr4 = htonl((a<<24) | (b<<16) | (c<<8) | d);
> +		tsec->jail_flags |= GOT_IPV4;
> +		bsdj_debug(DBG, "Network (ipv4) set up (%s)\n",
> +			tsec->ip4_addr_name);
> +	}
> +
> +	if (tsec->ip6_addr_name) {
> +		if (sscanf(tsec->ip6_addr_name, "%x:%x:%x:%x:%x:%x:%x:%x",
> +			&x[0], &x[1], &x[2], &x[3], &x[4], &x[5], &x[6],
> +			&x[7]) != 8) {
> +			printk(KERN_INFO "%s: bad ipv6 addr %s\n", __FUNCTION__,
> +				tsec->ip6_addr_name);
> +			return;
> +		}
> +		for (i=0; i<8; i++) {
> +			if (x[i] > 65535) {
> +				printk("%s: %x > 65535 at %d\n", __FUNCTION__, x[i], i);
> +				return;
> +			}
> +			tsec->addr6.in6_u.u6_addr16[i] = htons(x[i]);
> +		}
> +		tsec->jail_flags |= GOT_IPV6;
> +		bsdj_debug(DBG, "Network (ipv6) set up (%s)\n",
> +			tsec->ip6_addr_name);
> +	}
> +}
> +
> +/*
> + * enable_jail:
> + * Called when a process is placed into a new jail to handle the
> + * actual creation of the jail.
> + *   Creates namespace
> + *   Sets process root+pwd
> + *   Stores the requested ip address
> + *   Registers a unique pseudo-proc filesystem for this jail
> + */
> +static int enable_jail(struct task_struct *tsk)
> +{
> +	struct nameidata nd;
> +	struct jail_struct *tsec = tsk->security;;
                                                ^^
generates compile error, kill the extra semi-colon

> +	int retval = -EFAULT;
> +
> +	if (!tsec || !tsec->root_pathname)
> +		goto out;
> +
> +	/*
> +	 * USE_JAIL_NAMESPACE: could be useful, so that future mounts outside
> +	 * the jail don't affect the jail.  But it's not necessary, and
> +	 * requires exporting copy_namespace from fs/namespace.c
> +	 *
> +	 * Actually, it would also be useful for truly hiding
> +	 * information about mounts which do not exist in this jail.
> +#define USE_JAIL_NAMESPACE
> +	 */
> +#ifdef USE_JAIL_NAMESPACE
> +	bsdj_debug(DBG, "bsdjail: copying namespace.\n");
> +	retval = -EPERM;
> +	if (copy_namespace(CLONE_NEWNS, tsk))
> +		goto out;
> +	bsdj_debug(DBG, "bsdjail: copied namespace.\n");
> +#endif
> +
> +	/* find our new root directory */
> +	bsdj_debug(DBG, "bsdjail: looking up %s\n", tsec->root_pathname);
> +	retval = path_lookup(tsec->root_pathname, LOOKUP_FOLLOW | LOOKUP_DIRECTORY, &nd);
> +	if (retval)
> +		goto out;
> +
> +	bsdj_debug(DBG, "bsdjail: got %s, setting root to it\n", tsec->root_pathname);
> +
> +	/* and set the fsroot to it */
> +	set_fs_root(tsk->fs, nd.mnt, nd.dentry);
> +	set_fs_pwd(tsk->fs, nd.mnt, nd.dentry);
> +
> +	bsdj_debug(DBG, "bsdjail: root has been set.  Have fun.\n");
> +
> +	/* set up networking */
> +	if (tsec->ip4_addr_name || tsec->ip6_addr_name)
> +		setup_netaddress(tsec);
> +
> +	tsec->cur_nrtask = 1;
> +	if (tsec->nice)
> +		set_user_nice(current, tsec->nice);
> +	if (tsec->max_data) {
> +		current->rlim[RLIMIT_DATA].rlim_cur = tsec->max_data;
> +		current->rlim[RLIMIT_DATA].rlim_max = tsec->max_data;
> +	}
> +	if (tsec->max_memlock) {
> +		current->rlim[RLIMIT_MEMLOCK].rlim_cur = tsec->max_memlock;
> +		current->rlim[RLIMIT_MEMLOCK].rlim_max = tsec->max_memlock;
> +	}
> +	if (tsec->maxtimeslice) {
> +		current->rlim[RLIMIT_CPU].rlim_cur = tsec->maxtimeslice;
> +		current->rlim[RLIMIT_CPU].rlim_max = tsec->maxtimeslice;
> +	}
> +	/* success and end */
> +	tsec->mnt = mntget(nd.mnt);
> +	tsec->dentry = dget(nd.dentry);
> +	path_release(&nd);
> +	kref_init(&tsec->kref);
> +	tsec->jail_flags |= IN_USE;
> +
> +	/* won't let ourselves be removed until this jail goes away */
> +	try_module_get(THIS_MODULE);
> +
> +	return 0;
> +
> +out:
> +	return retval;
> +}
> +
> +/*
> + * LSM /proc/<pid>/attr hooks.
> + * You may write into /proc/<pid>/attr/exec:
> + *    root /some/path
> + *    ip 2.2.2.2
> + * These values will be used on the next exec() to set up your jail
> + *  (assuming you're not already in a jail)
> + */
> +static int
> +jail_setprocattr(struct task_struct *p, char *name, void *value, size_t size)
> +{
> +	struct jail_struct *tsec = current->security;
> +	long val;
> +	int start, len;
> +
> +	if (tsec && (tsec->jail_flags & IN_USE))
> +		return -EINVAL;  /* let them guess why */
> +
> +	if (p != current || strcmp(name, "exec"))
> +		return -EPERM;
> +
> +	if (strncmp(value, "root ", 5) == 0) {
> +		if (!tsec)
> +			tsec = alloc_task_security(current);
> +		if (IS_ERR(tsec))
> +			return -ENOMEM;

I think encoding error, testing error, then returning hardcoded error is
wasteful.  I'd change alloc_task_security api to return NULL on ENOMEM.

> +
> +		if (tsec->root_pathname)
> +			kfree(tsec->root_pathname);
> +		start = 5;
> +		len = size-start;
> +		tsec->root_pathname = kmalloc(len+1, GFP_KERNEL);
> +		if (!tsec->root_pathname)
> +			return -ENOMEM;
> +		strlcpy(tsec->root_pathname, value+start, len+1);
> +	} else if (strncmp(value, "ip ", 3) == 0) {
> +		if (!tsec)
> +			tsec = alloc_task_security(current);
> +		if (IS_ERR(tsec))
> +			return -ENOMEM;
> +
> +		if (tsec->ip4_addr_name)
> +			kfree(tsec->ip4_addr_name);
> +		start = 3;
> +		len = size-start;
> +		tsec->ip4_addr_name = kmalloc(len+1, GFP_KERNEL);
> +		if (!tsec->ip4_addr_name)
> +			return -ENOMEM;
> +		strlcpy(tsec->ip4_addr_name, value+start, len+1);
> +	} else if (strncmp(value, "ip6 ", 4) == 0) {
> +		if (!tsec)
> +			tsec = alloc_task_security(current);
> +		if (IS_ERR(tsec))
> +			return -ENOMEM;
> +
> +		if (tsec->ip6_addr_name)
> +			kfree(tsec->ip6_addr_name);
> +		start = 4;
> +		len = size-start;
> +		tsec->ip6_addr_name = kmalloc(len+1, GFP_KERNEL);
> +		if (!tsec->ip6_addr_name)
> +			return -ENOMEM;
> +		strlcpy(tsec->ip6_addr_name, value+start, len+1);
> +
> +	/* the next two are equivalent */
> +	} else if (strncmp(value, "slice ", 6) == 0) {
> +		if (!tsec)
> +			tsec = alloc_task_security(current);
> +		if (IS_ERR(tsec))
> +			return -ENOMEM;
> +
> +		val = simple_strtoul(value+6, NULL, 0);
> +		tsec->maxtimeslice = val;
> +	} else if (strncmp(value, "timeslice ", 10) == 0) {
> +		if (!tsec)
> +			tsec = alloc_task_security(current);
> +		if (IS_ERR(tsec))
> +			return -ENOMEM;
> +
> +		val = simple_strtoul(value+10, NULL, 0);
> +		tsec->maxtimeslice = val;
> +	} else if (strncmp(value, "nrtask ", 7) == 0) {
> +		if (!tsec)
> +			tsec = alloc_task_security(current);
> +		if (IS_ERR(tsec))
> +			return -ENOMEM;
> +
> +		val = (int) simple_strtol(value+7, NULL, 0);
> +		if (val < 1)
> +			return -EINVAL;
> +		tsec->max_nrtask = val;
> +	} else if (strncmp(value, "memlock ", 8) == 0) {
> +		if (!tsec)
> +			tsec = alloc_task_security(current);
> +		if (IS_ERR(tsec))
> +			return -ENOMEM;
> +
> +		val = simple_strtoul(value+8, NULL, 0);
> +		tsec->max_memlock = val;
> +	} else if (strncmp(value, "data ", 5) == 0) {
> +		if (!tsec)
> +			tsec = alloc_task_security(current);
> +		if (IS_ERR(tsec))
> +			return -ENOMEM;
> +
> +		val = simple_strtoul(value+5, NULL, 0);
> +		tsec->max_data = val;
> +	} else if (strncmp(value, "nice ", 5) == 0) {
> +		if (!tsec)
> +			tsec = alloc_task_security(current);
> +		if (IS_ERR(tsec))
> +			return -ENOMEM;
> +
> +		val = simple_strtoul(value+5, NULL, 0);
> +		tsec->nice = val;
> +	} else
> +		return -EINVAL;

Do you need all those alloc_task_security's in there?  Why not just one
at the top?  And are you convinced there's no leak on the other kmalloc
failures?

more after lunch.
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
