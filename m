Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750903AbWGKQjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbWGKQjz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 12:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbWGKQjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 12:39:55 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:60347 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750895AbWGKQjy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 12:39:54 -0400
Message-ID: <44B3D435.8090706@sw.ru>
Date: Tue, 11 Jul 2006 20:39:17 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Cedric Le Goater <clg@fr.ibm.com>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH -mm 5/7] add user namespace
References: <20060711075051.382004000@localhost.localdomain> <20060711075420.937831000@localhost.localdomain>
In-Reply-To: <20060711075420.937831000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wonder about another namespace coupling I found thinking
about your patches.

Lets take a look at sys_setpriority() or any other function calling find_user():
it can change the priority for all user or group processes like:

do_each_thread_ve(g, p) {
    if (p->uid == who)
        error = set_one_prio(p, niceval, error);
} while_each_thread_ve(g, p);

which essentially means that user-namespace becomes coupled with
process-namespace. Sure, we can check in every such place for
  p->nsproxy->user_ns == current->nsproxy->user_ns
condition. But this a way IMHO leading to kernel full of security
crap which is hardly maintainable.

Another example of not so evident coupling here:
user structure maintains number of processes/opened files/sigpending/locked_shm etc.
if a single user can belong to different proccess/ipc/... namespaces
all these becomes unusable.

Small patch comment:
- what is the reason in adding 2nd arg to find_user()?

Thanks,
Kirill

> This patch adds the user namespace.
> 
> Basically, it allows a process to unshare its user_struct table,
> resetting at the same time its own user_struct and all the associated
> accounting.
> 
> For the moment, the root_user is added to the new user namespace when
> it is cloned. An alternative behavior would be to let the system
> allocate a new user_struct(0) in each new user namespace. However,
> these 0 users would not have the privileges of the root_user and it
> would be necessary to work on the process capabilities to give them
> some permissions.
> 
> Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
> Cc: Andrew Morton <akpm@osdl.org>
> Cc: Kirill Korotaev <dev@openvz.org>
> Cc: Andrey Savochkin <saw@sw.ru>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Herbert Poetzl <herbert@13thfloor.at>
> Cc: Sam Vilain <sam.vilain@catalyst.net.nz>
> Cc: Serge E. Hallyn <serue@us.ibm.com>
> Cc: Dave Hansen <haveblue@us.ibm.com>
> 
> ---
>  fs/ioprio.c               |    5 +
>  include/linux/init_task.h |    2 
>  include/linux/nsproxy.h   |    2 
>  include/linux/sched.h     |    6 +-
>  include/linux/user.h      |   45 +++++++++++++++
>  init/Kconfig              |    8 ++
>  kernel/nsproxy.c          |   15 ++++-
>  kernel/sys.c              |    8 +-
>  kernel/user.c             |  135 ++++++++++++++++++++++++++++++++++++++++++----
>  9 files changed, 208 insertions(+), 18 deletions(-)
> 
> Index: 2.6.18-rc1-mm1/kernel/user.c
> ===================================================================
> --- 2.6.18-rc1-mm1.orig/kernel/user.c
> +++ 2.6.18-rc1-mm1/kernel/user.c
> @@ -14,20 +14,28 @@
>  #include <linux/bitops.h>
>  #include <linux/key.h>
>  #include <linux/interrupt.h>
> +#include <linux/user.h>
> +#include <linux/module.h>
> +#include <linux/nsproxy.h>
>  
>  /*
>   * UID task count cache, to get fast user lookup in "alloc_uid"
>   * when changing user ID's (ie setuid() and friends).
>   */
>  
> -#define UIDHASH_BITS (CONFIG_BASE_SMALL ? 3 : 8)
> -#define UIDHASH_SZ		(1 << UIDHASH_BITS)
>  #define UIDHASH_MASK		(UIDHASH_SZ - 1)
>  #define __uidhashfn(uid)	(((uid >> UIDHASH_BITS) + uid) & UIDHASH_MASK)
> -#define uidhashentry(uid)	(uidhash_table + __uidhashfn((uid)))
> +#define uidhashentry(ns, uid)	((ns)->uidhash_table + __uidhashfn((uid)))
>  
>  static kmem_cache_t *uid_cachep;
> -static struct list_head uidhash_table[UIDHASH_SZ];
> +
> +struct user_namespace init_user_ns = {
> +	.kref = {
> +		.refcount	= ATOMIC_INIT(2),
> +	},
> +};
> +
> +EXPORT_SYMBOL_GPL(init_user_ns);
>  
>  /*
>   * The uidhash_lock is mostly taken from process context, but it is
> @@ -84,19 +92,126 @@ static inline struct user_struct *uid_ha
>  	return NULL;
>  }
>  
> +
> +#ifdef CONFIG_USER_NS
> +
> +/*
> + * Clone a new ns copying an original user ns, setting refcount to 1
> + * @old_ns: namespace to clone
> + * Return NULL on error (failure to kmalloc), new ns otherwise
> + */
> +static struct user_namespace *clone_user_ns(struct user_namespace *old_ns)
> +{
> +	struct user_namespace *ns;
> +
> +	ns = kmalloc(sizeof(struct user_namespace), GFP_KERNEL);
> +	if (ns) {
> +		int n;
> +		struct user_struct *new_user;
> +
> +		kref_init(&ns->kref);
> +
> +		for(n = 0; n < UIDHASH_SZ; ++n)
> +			INIT_LIST_HEAD(ns->uidhash_table + n);
> +
> +		/* Insert default root user. An alternate solution
> +		 * would be to let the system allocate a new user 0
> +		 * for this namespace and work on capabilities to give
> +		 * the process some privileges.
> +		 */
> +		spin_lock_irq(&uidhash_lock);
> +		uid_hash_insert(&root_user, uidhashentry(ns, 0));
> +		spin_unlock_irq(&uidhash_lock);
> +
> +		/* Reset current->user with a new one */
> +		new_user = alloc_uid(ns, current->uid);
> +		if (!new_user) {
> +			kfree(ns);
> +			return NULL;
> +		}
> +
> +		switch_uid(new_user);
> +	}
> +	return ns;
> +}
> +
> +/*
> + * unshare the current process' user namespace.
> + */
> +int unshare_user_ns(unsigned long unshare_flags,
> +		    struct user_namespace **new_user)
> +{
> +	if (unshare_flags & CLONE_NEWUSER) {
> +		if (!capable(CAP_SYS_ADMIN))
> +			return -EPERM;
> +
> +		*new_user = clone_user_ns(current->nsproxy->user_ns);
> +		if (!*new_user)
> +			return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Copy task tsk's user namespace, or clone it if flags specifies
> + * CLONE_NEWUSER. In latter case, changes to the user namespace of
> + * this process won't be seen by parent, and vice versa.
> + */
> +int copy_user_ns(int flags, struct task_struct *tsk)
> +{
> +	struct user_namespace *old_ns = tsk->nsproxy->user_ns;
> +	struct user_namespace *new_ns;
> +	int err = 0;
> +
> +	if (!old_ns)
> +		return 0;
> +
> +	get_user_ns(old_ns);
> +
> +	if (!(flags & CLONE_NEWUSER))
> +		return 0;
> +
> +	if (!capable(CAP_SYS_ADMIN)) {
> +		err = -EPERM;
> +		goto out;
> +	}
> +
> +	new_ns = clone_user_ns(old_ns);
> +	if (!new_ns) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +	tsk->nsproxy->user_ns = new_ns;
> +
> +out:
> +	put_user_ns(old_ns);
> +	return err;
> +}
> +
> +void free_user_ns(struct kref *kref)
> +{
> +	struct user_namespace *ns;
> +
> +	ns = container_of(kref, struct user_namespace, kref);
> +	kfree(ns);
> +}
> +
> +#endif /* CONFIG_USER_NS */
> +
>  /*
>   * Locate the user_struct for the passed UID.  If found, take a ref on it.  The
>   * caller must undo that ref with free_uid().
>   *
>   * If the user_struct could not be found, return NULL.
>   */
> -struct user_struct *find_user(uid_t uid)
> +struct user_struct *find_user(struct user_namespace *ns, uid_t uid)
>  {
>  	struct user_struct *ret;
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&uidhash_lock, flags);
> -	ret = uid_hash_find(uid, uidhashentry(uid));
> +	ret = uid_hash_find(uid, uidhashentry(ns, uid));
>  	spin_unlock_irqrestore(&uidhash_lock, flags);
>  	return ret;
>  }
> @@ -120,9 +235,9 @@ void free_uid(struct user_struct *up)
>  	}
>  }
>  
> -struct user_struct * alloc_uid(uid_t uid)
> +struct user_struct * alloc_uid(struct user_namespace *ns, uid_t uid)
>  {
> -	struct list_head *hashent = uidhashentry(uid);
> +	struct list_head *hashent = uidhashentry(ns, uid);
>  	struct user_struct *up;
>  
>  	spin_lock_irq(&uidhash_lock);
> @@ -200,11 +315,11 @@ static int __init uid_cache_init(void)
>  			0, SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
>  
>  	for(n = 0; n < UIDHASH_SZ; ++n)
> -		INIT_LIST_HEAD(uidhash_table + n);
> +		INIT_LIST_HEAD(init_user_ns.uidhash_table + n);
>  
>  	/* Insert the root user immediately (init already runs as root) */
>  	spin_lock_irq(&uidhash_lock);
> -	uid_hash_insert(&root_user, uidhashentry(0));
> +	uid_hash_insert(&root_user, uidhashentry(&init_user_ns, 0));
>  	spin_unlock_irq(&uidhash_lock);
>  
>  	return 0;
> Index: 2.6.18-rc1-mm1/include/linux/nsproxy.h
> ===================================================================
> --- 2.6.18-rc1-mm1.orig/include/linux/nsproxy.h
> +++ 2.6.18-rc1-mm1/include/linux/nsproxy.h
> @@ -7,6 +7,7 @@
>  struct namespace;
>  struct uts_namespace;
>  struct ipc_namespace;
> +struct user_namespace;
>  
>  /*
>   * A structure to contain pointers to all per-process
> @@ -25,6 +26,7 @@ struct nsproxy {
>  	spinlock_t nslock;
>  	struct uts_namespace *uts_ns;
>  	struct ipc_namespace *ipc_ns;
> +	struct user_namespace *user_ns;
>  	struct namespace *namespace;
>  };
>  extern struct nsproxy init_nsproxy;
> Index: 2.6.18-rc1-mm1/include/linux/user.h
> ===================================================================
> --- 2.6.18-rc1-mm1.orig/include/linux/user.h
> +++ 2.6.18-rc1-mm1/include/linux/user.h
> @@ -1 +1,46 @@
> +#ifndef _LINUX_USER_H
> +#define _LINUX_USER_H
> +
>  #include <asm/user.h>
> +
> +#define UIDHASH_BITS (CONFIG_BASE_SMALL ? 3 : 8)
> +#define UIDHASH_SZ		(1 << UIDHASH_BITS)
> +
> +struct user_namespace {
> +	struct kref		kref;
> +	struct list_head	uidhash_table[UIDHASH_SZ];
> +};
> +
> +extern struct user_namespace init_user_ns;
> +
> +static inline void get_user_ns(struct user_namespace *ns)
> +{
> +	kref_get(&ns->kref);
> +}
> +
> +#ifdef CONFIG_USER_NS
> +extern int unshare_user_ns(unsigned long unshare_flags,
> +			   struct user_namespace **new_user);
> +extern int copy_user_ns(int flags, struct task_struct *tsk);
> +extern void free_user_ns(struct kref *kref);
> +
> +static inline void put_user_ns(struct user_namespace *ns)
> +{
> +	kref_put(&ns->kref, free_user_ns);
> +}
> +#else
> +static inline int unshare_user_ns(unsigned long unshare_flags,
> +			struct user_namespace **new_user)
> +{
> +	return -EINVAL;
> +}
> +static inline int copy_user_ns(int flags, struct task_struct *tsk)
> +{
> +	return 0;
> +}
> +static inline void put_user_ns(struct user_namespace *ns)
> +{
> +}
> +#endif /* CONFIG_USER_NS */
> +
> +#endif /* _LINUX_USER_H */
> Index: 2.6.18-rc1-mm1/kernel/nsproxy.c
> ===================================================================
> --- 2.6.18-rc1-mm1.orig/kernel/nsproxy.c
> +++ 2.6.18-rc1-mm1/kernel/nsproxy.c
> @@ -18,6 +18,7 @@
>  #include <linux/nsproxy.h>
>  #include <linux/namespace.h>
>  #include <linux/utsname.h>
> +#include <linux/user.h>
>  
>  static inline void get_nsproxy(struct nsproxy *ns)
>  {
> @@ -65,6 +66,8 @@ struct nsproxy *dup_namespaces(struct ns
>  			get_uts_ns(ns->uts_ns);
>  		if (ns->ipc_ns)
>  			get_ipc_ns(ns->ipc_ns);
> +		if (ns->user_ns)
> +			get_user_ns(ns->user_ns);
>  	}
>  
>  	return ns;
> @@ -85,7 +88,8 @@ int copy_namespaces(int flags, struct ta
>  
>  	get_nsproxy(old_ns);
>  
> -	if (!(flags & (CLONE_NEWNS | CLONE_NEWUTS | CLONE_NEWIPC)))
> +	if (!(flags & (CLONE_NEWNS | CLONE_NEWUTS | CLONE_NEWIPC |
> +			CLONE_NEWUSER)))
>  		return 0;
>  
>  	new_ns = clone_namespaces(old_ns);
> @@ -108,10 +112,17 @@ int copy_namespaces(int flags, struct ta
>  	if (err)
>  		goto out_ipc;
>  
> +	err = copy_user_ns(flags, tsk);
> +	if (err)
> +		goto out_user;
> +
>  out:
>  	put_nsproxy(old_ns);
>  	return err;
>  
> +out_user:
> +	if (new_ns->ipc_ns)
> +		put_ipc_ns(new_ns->ipc_ns);
>  out_ipc:
>  	if (new_ns->uts_ns)
>  		put_uts_ns(new_ns->uts_ns);
> @@ -132,5 +143,7 @@ void free_nsproxy(struct nsproxy *ns)
>  			put_uts_ns(ns->uts_ns);
>  		if (ns->ipc_ns)
>  			put_ipc_ns(ns->ipc_ns);
> +		if (ns->user_ns)
> +			put_user_ns(ns->user_ns);
>  		kfree(ns);
>  }
> Index: 2.6.18-rc1-mm1/include/linux/sched.h
> ===================================================================
> --- 2.6.18-rc1-mm1.orig/include/linux/sched.h
> +++ 2.6.18-rc1-mm1/include/linux/sched.h
> @@ -26,6 +26,7 @@
>  #define CLONE_STOPPED		0x02000000	/* Start in stopped state */
>  #define CLONE_NEWUTS		0x04000000	/* New utsname group? */
>  #define CLONE_NEWIPC		0x08000000	/* New ipcs */
> +#define CLONE_NEWUSER		0x10000000	/* New user */
>  
>  /*
>   * Scheduling policies
> @@ -243,6 +244,7 @@ extern signed long schedule_timeout_unin
>  asmlinkage void schedule(void);
>  
>  struct nsproxy;
> +struct user_namespace;
>  
>  /* Maximum number of active map areas.. This is a random (large) number */
>  #define DEFAULT_MAX_MAP_COUNT	65536
> @@ -537,7 +539,7 @@ struct user_struct {
>  	uid_t uid;
>  };
>  
> -extern struct user_struct *find_user(uid_t);
> +extern struct user_struct *find_user(struct user_namespace *, uid_t);
>  
>  extern struct user_struct root_user;
>  #define INIT_USER (&root_user)
> @@ -1204,7 +1206,7 @@ extern void set_special_pids(pid_t sessi
>  extern void __set_special_pids(pid_t session, pid_t pgrp);
>  
>  /* per-UID process charging. */
> -extern struct user_struct * alloc_uid(uid_t);
> +extern struct user_struct * alloc_uid(struct user_namespace *, uid_t);
>  static inline struct user_struct *get_uid(struct user_struct *u)
>  {
>  	atomic_inc(&u->__count);
> Index: 2.6.18-rc1-mm1/init/Kconfig
> ===================================================================
> --- 2.6.18-rc1-mm1.orig/init/Kconfig
> +++ 2.6.18-rc1-mm1/init/Kconfig
> @@ -237,6 +237,14 @@ config UTS_NS
>  	  vservers, to use uts namespaces to provide different
>  	  uts info for different servers.  If unsure, say N.
>  
> +config USER_NS
> +	bool "User Namespaces"
> +	default n
> +	help
> +	  Support user namespaces.  This allows containers, i.e.
> +	  vservers, to use user namespaces to provide different
> +	  user info for different servers.  If unsure, say N.
> +
>  config AUDIT
>  	bool "Auditing support"
>  	depends on NET
> Index: 2.6.18-rc1-mm1/include/linux/init_task.h
> ===================================================================
> --- 2.6.18-rc1-mm1.orig/include/linux/init_task.h
> +++ 2.6.18-rc1-mm1/include/linux/init_task.h
> @@ -8,6 +8,7 @@
>  #include <linux/lockdep.h>
>  #include <linux/notifier.h>
>  #include <linux/ipc.h>
> +#include <linux/user.h>
>  
>  #define INIT_FDTABLE \
>  {							\
> @@ -78,6 +79,7 @@ extern struct nsproxy init_nsproxy;
>  	.uts_ns		= &init_uts_ns,					\
>  	.namespace	= NULL,						\
>  	INIT_IPC_NS(ipc_ns)						\
> +	.user_ns	= &init_user_ns,				\
>  }
>  
>  #define INIT_SIGHAND(sighand) {						\
> Index: 2.6.18-rc1-mm1/fs/ioprio.c
> ===================================================================
> --- 2.6.18-rc1-mm1.orig/fs/ioprio.c
> +++ 2.6.18-rc1-mm1/fs/ioprio.c
> @@ -25,6 +25,7 @@
>  #include <linux/capability.h>
>  #include <linux/syscalls.h>
>  #include <linux/security.h>
> +#include <linux/nsproxy.h>
>  
>  static int set_task_ioprio(struct task_struct *task, int ioprio)
>  {
> @@ -101,7 +102,7 @@ asmlinkage long sys_ioprio_set(int which
>  			if (!who)
>  				user = current->user;
>  			else
> -				user = find_user(who);
> +				user = find_user(current->nsproxy->user_ns, who);
>  
>  			if (!user)
>  				break;
> @@ -171,7 +172,7 @@ asmlinkage long sys_ioprio_get(int which
>  			if (!who)
>  				user = current->user;
>  			else
> -				user = find_user(who);
> +				user = find_user(current->nsproxy->user_ns, who);
>  
>  			if (!user)
>  				break;
> Index: 2.6.18-rc1-mm1/kernel/sys.c
> ===================================================================
> --- 2.6.18-rc1-mm1.orig/kernel/sys.c
> +++ 2.6.18-rc1-mm1/kernel/sys.c
> @@ -544,7 +544,8 @@ asmlinkage long sys_setpriority(int whic
>  			if (!who)
>  				who = current->uid;
>  			else
> -				if ((who != current->uid) && !(user = find_user(who)))
> +				if ((who != current->uid) &&
> +					!(user = find_user(current->nsproxy->user_ns, who)))
>  					goto out_unlock;	/* No processes for this user */
>  
>  			do_each_thread(g, p)
> @@ -602,7 +603,8 @@ asmlinkage long sys_getpriority(int whic
>  			if (!who)
>  				who = current->uid;
>  			else
> -				if ((who != current->uid) && !(user = find_user(who)))
> +				if ((who != current->uid) &&
> +					!(user = find_user(current->nsproxy->user_ns, who)))
>  					goto out_unlock;	/* No processes for this user */
>  
>  			do_each_thread(g, p)
> @@ -935,7 +937,7 @@ static int set_user(uid_t new_ruid, int 
>  {
>  	struct user_struct *new_user;
>  
> -	new_user = alloc_uid(new_ruid);
> +	new_user = alloc_uid(current->nsproxy->user_ns, new_ruid);
>  	if (!new_user)
>  		return -EAGAIN;
>  
> 
> --
> 

