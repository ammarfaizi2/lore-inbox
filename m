Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264147AbUENBUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbUENBUk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 21:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264186AbUENBUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 21:20:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:32723 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264147AbUENBUM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 21:20:12 -0400
Date: Thu, 13 May 2004 18:20:10 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andy Lutomirski <luto@myrealbox.com>
Cc: akpm@osdl.org, chrisw@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] capabilites, take 2
Message-ID: <20040513182010.L21045@build.pdx.osdl.net>
References: <200405131308.40477.luto@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200405131308.40477.luto@myrealbox.com>; from luto@myrealbox.com on Thu, May 13, 2004 at 01:08:40PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Lutomirski (luto@myrealbox.com) wrote:
> Implement optional working capability support.  Try to avoid giving Andrew
> a heart attack. ;)

I think it still needs more work.  Default behavoiur is changed, like
Inheritble is full rather than clear, setpcap is enabled, etc.  Also,
why do you change from Posix the way exec() updates capabilities?  Sure,
there is no filesystem bits present, so this changes the calculation,
but I'm not convinced it's as secure this way.  At least with newcaps=0.

I believe we can get something functional with fewer changes, hence
easier to understand the ramifications.  In a nutshell, I'm still not
comfortable with this.

Also, it breaks my tests which try to drop privs and keep caps across
execve() which is really the only issue we're trying to solve ATM.


> --- linux-2.6.6-mm2/fs/exec.c~caps	2004-05-13 11:42:26.000000000 -0700
> +++ linux-2.6.6-mm2/fs/exec.c	2004-05-13 12:15:20.000000000 -0700
> @@ -882,8 +882,10 @@
>  
>  	if(!(bprm->file->f_vfsmnt->mnt_flags & MNT_NOSUID)) {
>  		/* Set-uid? */
> -		if (mode & S_ISUID)
> +		if (mode & S_ISUID) {
>  			bprm->e_uid = inode->i_uid;
> +			bprm->secflags |= BINPRM_SEC_SETUID;
> +		}
>  
>  		/* Set-gid? */
>  		/*
> @@ -891,10 +893,19 @@
>  		 * is a candidate for mandatory locking, not a setgid
>  		 * executable.
>  		 */
> -		if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP))
> +		if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
>  			bprm->e_gid = inode->i_gid;
> +			bprm->secflags |= BINPRM_SEC_SETGID;
> +		}
>  	}
>  
> +	/* Pretend we have VFS capabilities */
> +	cap_set_full(bprm->cap_inheritable);

This looks sketchy.

> +	if((bprm->secflags & BINPRM_SEC_SETUID) && bprm->e_uid == 0)

CodingStyle:  add space after keyword 'if'
	if ((...))

> +		cap_set_full(bprm->cap_permitted);
> +	else
> +		cap_clear(bprm->cap_permitted);
> +
>  	/* fill in binprm security blob */
>  	retval = security_bprm_set(bprm);
>  	if (retval)
> @@ -1089,6 +1100,7 @@
>  	bprm.loader = 0;
>  	bprm.exec = 0;
>  	bprm.security = NULL;
> +	bprm.secflags = 0;
>  	bprm.mm = mm_alloc();
>  	retval = -ENOMEM;
>  	if (!bprm.mm)
> --- linux-2.6.6-mm2/security/commoncap.c~caps	2004-05-13 11:42:26.000000000 -0700
> +++ linux-2.6.6-mm2/security/commoncap.c	2004-05-13 12:59:32.934690092 -0700
> @@ -24,6 +24,11 @@
>  #include <linux/xattr.h>
>  #include <linux/hugetlb.h>
>  
> +int newcaps = 0;

make this:
  static int newcaps;

> +
> +module_param(newcaps, int, 444);
> +MODULE_PARM_DESC(newcaps, "Set newcaps=1 to enable experimental capabilities");
> +
>  int cap_capable (struct task_struct *tsk, int cap)
>  {
>  	/* Derived from include/linux/sched.h:capable. */
> @@ -36,6 +41,11 @@
>  int cap_ptrace (struct task_struct *parent, struct task_struct *child)
>  {
>  	/* Derived from arch/i386/kernel/ptrace.c:sys_ptrace. */
> +	/* CAP_SYS_PTRACE still can't bypass inheritable restrictions */
> +	if (newcaps &&
> +	    !cap_issubset (child->cap_inheritable, current->cap_inheritable))
> +		return -EPERM;

Why no capable() override?  In fact, is this check really necessary?

> +
>  	if (!cap_issubset (child->cap_permitted, current->cap_permitted) &&
>  	    !capable (CAP_SYS_PTRACE))
>  		return -EPERM;
> @@ -76,6 +86,11 @@
>  		return -EPERM;
>  	}
>  
> +	/* verify the _new_Permitted_ is a subset of the _new_Inheritable_ */
> +	if (newcaps && !cap_issubset (*permitted, *inheritable)) {
> +		return -EPERM;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -89,6 +104,8 @@
>  
>  int cap_bprm_set_security (struct linux_binprm *bprm)
>  {
> +	if (newcaps) return 0;

CodingStyle:
	if (newcaps)
		return 0;

> +
>  	/* Copied from fs/exec.c:prepare_binprm. */
>  
>  	/* We don't have VFS support for capabilities yet */
> @@ -115,10 +132,11 @@
>  	return 0;
>  }
>  
> -void cap_bprm_apply_creds (struct linux_binprm *bprm, int unsafe)
> +static void cap_bprm_apply_creds_compat (struct linux_binprm *bprm, int unsafe)
>  {
> -	/* Derived from fs/exec.c:compute_creds. */
> +	/* This function will hopefully die in 2.7. */
>  	kernel_cap_t new_permitted, working;
> +	static int fixed_init = 0;
>  
>  	new_permitted = cap_intersect (bprm->cap_permitted, cap_bset);
>  	working = cap_intersect (bprm->cap_inheritable,
> @@ -151,6 +169,15 @@
>  		current->cap_permitted = new_permitted;
>  		current->cap_effective =
>  		    cap_intersect (new_permitted, bprm->cap_effective);
> +	} else if (!fixed_init) {
> +		/* This is not strictly correct, as it gives linuxrc more
> +		 * permissions than it used to have.  It was the only way I
> +		 * could think of to keep the resulting disaster contained,
> +		 * though.
> +		 */
> +		current->cap_effective = CAP_OLD_INIT_EFF_SET;
> +		current->cap_inheritable = CAP_OLD_INIT_INH_SET;
> +		fixed_init = 1;

Hrm...

>  	}
>  
>  	/* AUD: Audit candidate if current->cap_effective is set */
> @@ -158,15 +185,103 @@
>  	current->keep_capabilities = 0;
>  }
>  
> +/*
> + * The rules of Linux capabilities (not POSIX!)
> + *
> + * What the masks mean:
> + *  pI = capabilities that this process or its children may have
> + *  pP = capabilities that this process has
> + *  pE = capabilities that this process has and are enabled
> + * (so pE <= pP <= pI)
> + *
> + * The capability evolution rules are:
> + *
> + *  pI' = pI & fI
> + *  pP' = ((fP & cap_bset) | pP) & pI' & Y
> + *  pE' = (setuid ? pP' : (pE & pP'))
> + *
> + *  X = cap_bset
> + *  Y is zero if uid!=0, euid==0, and setuid non-root
> + *
> + * Caveat: if (fP & ~pI'), there is no _theoretical_ problem, but
> + * this could introduce exploits in buggy programs.  Since programs
> + * that aren't capability-aware are insecure _anyway_ if pP!=0, this
> + * is OK.
> + *
> + * To allow pI != ~0 to be secure in the presence of buggy programs,
> + * we require full pI for setuid.
> + *
> + * The moral is that, if file capabilities are introduced, programs
> + * that are granted fP > 0 need to be aware of how to deal with it.
> + * Because the effective set is left alone on non-setuid fP>0,
> + * such a program should drop capabilities that were not in its initial
> + * effective set before running untrusted code.
> + *
> + */
> +void cap_bprm_apply_creds (struct linux_binprm *bprm, int unsafe)
> +{
> +	kernel_cap_t new_pI, new_pP;
> +	kernel_cap_t fI, fP;
> +	int is_setuid, is_setgid;
> +
> +	if(!newcaps) {
> +		cap_bprm_apply_creds_compat(bprm, unsafe);
> +		return;
> +	}
> +
> +	fI = bprm->cap_inheritable;
> +	fP = bprm->cap_permitted;
> +	is_setuid = (bprm->secflags & BINPRM_SEC_SETUID);
> +	is_setgid = (bprm->secflags & BINPRM_SEC_SETGID);
> +
> +	new_pI = cap_intersect(current->cap_inheritable, fI);
> +
> +	/* Check that it's safe to elevate privileges */
> +	if (unsafe & ~LSM_UNSAFE_PTRACE_CAP)
> +		bprm->secflags |= BINPRM_SEC_NOELEVATE;
> +
> +	/* FIXME: Is this overly harsh on setgid? */
> +	if ((bprm->secflags & (BINPRM_SEC_SETUID | BINPRM_SEC_SETGID)) &&
> +	    new_pI != CAP_FULL_SET)
> +			bprm->secflags |= BINPRM_SEC_NOELEVATE;
> +
> +	if (bprm->secflags & BINPRM_SEC_NOELEVATE) {
> +		is_setuid = is_setgid = 0;
> +		cap_clear(fP);
> +	}
> +
> +	new_pP = cap_intersect(fP, cap_bset);
> +	new_pP = cap_combine(new_pP, current->cap_permitted);
> +	cap_mask(new_pP, new_pI);
> +
> +	/* setuid-nonroot is special. */
> +	if (is_setuid && bprm->e_uid != 0 && current->uid != 0 &&
> +	    current->euid == 0)
> +		cap_clear(new_pP);
> +
> +	if(!cap_issubset(new_pP, current->cap_permitted))
> +		bprm->secflags |= BINPRM_SEC_SECUREEXEC;
> +
> +	/* Apply new security state */
> +	if (is_setuid) {
> +	        current->suid = current->euid = current->fsuid = bprm->e_uid;
> +		current->cap_effective = new_pP;
> +	}
> +	if (is_setgid)
> +	        current->sgid = current->egid = current->fsgid = bprm->e_gid;
> +
> +	current->cap_inheritable = new_pI;
> +	current->cap_permitted = new_pP;
> +	cap_mask(current->cap_effective, new_pP);
> +
> +	current->keep_capabilities = 0;
> +}
> +
>  int cap_bprm_secureexec (struct linux_binprm *bprm)
>  {
> -	/* If/when this module is enhanced to incorporate capability
> -	   bits on files, the test below should be extended to also perform a 
> -	   test between the old and new capability sets.  For now,
> -	   it simply preserves the legacy decision algorithm used by
> -	   the old userland. */
>  	return (current->euid != current->uid ||
> -		current->egid != current->gid);
> +		current->egid != current->gid ||
> +		(bprm->secflags & BINPRM_SEC_SECUREEXEC));
>  }
>  
>  int cap_inode_setxattr(struct dentry *dentry, char *name, void *value,
> @@ -280,9 +395,15 @@
>  
>  void cap_task_reparent_to_init (struct task_struct *p)
>  {
> -	p->cap_effective = CAP_INIT_EFF_SET;
> -	p->cap_inheritable = CAP_INIT_INH_SET;
> -	p->cap_permitted = CAP_FULL_SET;
> +	if (newcaps) {
> +		cap_set_full(p->cap_inheritable);
> +		cap_set_full(p->cap_permitted);
> +		cap_set_full(p->cap_effective);
> +	} else {
> +		p->cap_effective = CAP_OLD_INIT_EFF_SET;
> +		p->cap_inheritable = CAP_OLD_INIT_INH_SET;
> +		p->cap_permitted = CAP_FULL_SET;
> +	}
>  	p->keep_capabilities = 0;
>  	return;
>  }
> @@ -367,6 +488,16 @@
>  	return -ENOMEM;
>  }
>  
> +static int __init commoncap_init (void)
> +{
> +	if (newcaps) {
> +		printk(KERN_NOTICE "Experimental capability support is on\n");
> +		cap_bset = CAP_FULL_SET;
> +	}
> +
> +	return 0;
> +}
> +
>  EXPORT_SYMBOL(cap_capable);
>  EXPORT_SYMBOL(cap_ptrace);
>  EXPORT_SYMBOL(cap_capget);
> @@ -382,5 +513,7 @@
>  EXPORT_SYMBOL(cap_syslog);
>  EXPORT_SYMBOL(cap_vm_enough_memory);
>  
> +module_init(commoncap_init);
> +
>  MODULE_DESCRIPTION("Standard Linux Common Capabilities Security Module");
>  MODULE_LICENSE("GPL");
> --- linux-2.6.6-mm2/kernel/capability.c~caps	2004-05-13 11:42:26.000000000 -0700
> +++ linux-2.6.6-mm2/kernel/capability.c	2004-05-13 11:42:51.000000000 -0700
> @@ -13,7 +13,7 @@
>  #include <asm/uaccess.h>
>  
>  unsigned securebits = SECUREBITS_DEFAULT; /* systemwide security settings */
> -kernel_cap_t cap_bset = CAP_INIT_EFF_SET;
> +kernel_cap_t cap_bset = CAP_OLD_INIT_EFF_SET;
>  int sysctl_mlock_group;
>  
>  EXPORT_SYMBOL(securebits);
> --- linux-2.6.6-mm2/include/linux/capability.h~caps	2004-05-13 11:42:26.000000000 -0700
> +++ linux-2.6.6-mm2/include/linux/capability.h	2004-05-13 11:42:51.000000000 -0700
> @@ -308,8 +308,10 @@
>  
>  #define CAP_EMPTY_SET       to_cap_t(0)
>  #define CAP_FULL_SET        to_cap_t(~0)
> -#define CAP_INIT_EFF_SET    to_cap_t(~0 & ~CAP_TO_MASK(CAP_SETPCAP))
> -#define CAP_INIT_INH_SET    to_cap_t(0)
> +
> +/* For old-style capabilities, we use these. */
> +#define CAP_OLD_INIT_EFF_SET    to_cap_t(~0 & ~CAP_TO_MASK(CAP_SETPCAP))
> +#define CAP_OLD_INIT_INH_SET    to_cap_t(0)
>  
>  #define CAP_TO_MASK(x) (1 << (x))
>  #define cap_raise(c, flag)   (cap_t(c) |=  CAP_TO_MASK(flag))
> --- linux-2.6.6-mm2/include/linux/binfmts.h~caps	2004-05-13 11:42:26.000000000 -0700
> +++ linux-2.6.6-mm2/include/linux/binfmts.h	2004-05-13 11:44:02.000000000 -0700
> @@ -20,6 +20,10 @@
>  /*
>   * This structure is used to hold the arguments that are used when loading binaries.
>   */
> +#define BINPRM_SEC_SETUID	1
> +#define BINPRM_SEC_SETGID	2
> +#define BINPRM_SEC_SECUREEXEC	4
> +#define BINPRM_SEC_NOELEVATE	8
>  struct linux_binprm{
>  	char buf[BINPRM_BUF_SIZE];
>  	struct page *page[MAX_ARG_PAGES];
> @@ -28,7 +32,9 @@
>  	int sh_bang;
>  	struct file * file;
>  	int e_uid, e_gid;
> -	kernel_cap_t cap_inheritable, cap_permitted, cap_effective;
> +	int secflags;
> +	kernel_cap_t cap_inheritable, cap_permitted;
> +	kernel_cap_t cap_effective; /* old caps -- do NOT use in new code */
>  	void *security;
>  	int argc, envc;
>  	char * filename;	/* Name of binary as seen by procps */
> --- linux-2.6.6-mm2/include/linux/init_task.h~caps	2004-05-13 11:42:26.000000000 -0700
> +++ linux-2.6.6-mm2/include/linux/init_task.h	2004-05-13 11:42:51.000000000 -0700
> @@ -92,8 +92,8 @@
>  		.function	= it_real_fn				\
>  	},								\
>  	.group_info	= &init_groups,					\
> -	.cap_effective	= CAP_INIT_EFF_SET,				\
> -	.cap_inheritable = CAP_INIT_INH_SET,				\
> +	.cap_effective	= CAP_FULL_SET,				\
> +	.cap_inheritable = CAP_FULL_SET,				\

This was made unconditional.  And how are you convinced it's safe?

>  	.cap_permitted	= CAP_FULL_SET,					\
>  	.keep_capabilities = 0,						\
>  	.rlim		= INIT_RLIMITS,					\


thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
