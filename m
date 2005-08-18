Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbVHRBRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbVHRBRu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 21:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbVHRBRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 21:17:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16821 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932072AbVHRBRu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 21:17:50 -0400
Date: Wed, 17 Aug 2005 18:17:28 -0700
From: Chris Wright <chrisw@osdl.org>
To: Wieland Gmeiner <e8607062@student.tuwien.ac.at>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Elliot Lee <sopwith@redhat.com>
Subject: Re: [PATCH 2.6.13-rc6 1/2] New Syscall: get rlimits of any process (update)
Message-ID: <20050818011728.GP7991@shell0.pdx.osdl.net>
References: <1124326652.8359.3.camel@w2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124326652.8359.3.camel@w2>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Wieland Gmeiner (e8607062@student.tuwien.ac.at) wrote:
> diff -uprN -X linux-2.6.13-rc6-vanilla/Documentation/dontdiff linux-2.6.13-rc6-vanilla/kernel/sys.c linux-2.6.13-rc6-getprlimit/kernel/sys.c
> --- linux-2.6.13-rc6-vanilla/kernel/sys.c	2005-08-09 16:03:21.000000000 +0200
> +++ linux-2.6.13-rc6-getprlimit/kernel/sys.c	2005-08-17 23:56:40.000000000 +0200
> @@ -1604,6 +1604,63 @@ asmlinkage long sys_setrlimit(unsigned i
>  }
>  
>  /*
> + * As ptrace implies the ability to execute arbitrary code in the given
> + * process, which means that the calling process could obtain and set
> + * rlimits for that process without getprlimit/setprlimit anyways,
> + * we use the same permission checks as ptrace.
> + */
> +
> +static inline int prlim_check_perm(task_t *task)
> +{
> +	return ((current->uid == task->euid) &&
> +		(current->uid == task->suid) &&
> +		(current->uid == task->uid) &&
> +		(current->gid == task->egid) &&
> +		(current->gid == task->sgid) &&
> +		(current->gid == task->gid)) || capable(CAP_SYS_RESOURCE);
> +}

This comment and the code aren't matching.  CAP_SYS_RESOUCE now means
effective on any other process, which it never did before.  That should
be given careful thought.  CAP_SYS_PTRACE indeed would let you call
get/setrlimit in traced task, perhaps that what you meant?

> +
> +asmlinkage long sys_getprlimit(pid_t pid, unsigned int resource,
> +			       struct rlimit __user *rlim)
> +{
> +	struct rlimit value;
> +	task_t *p;
> +	int retval = -EINVAL;
> +
> +	if (resource >= RLIM_NLIMITS)
> +		goto out_nounlock;
> +
> +	if (pid < 0)
> +		goto out_nounlock;
> +
> +	retval = -ESRCH;
> +	if (pid == 0) {
> +		p = current;
> +	} else {
> +		read_lock(&tasklist_lock);
> +		p = find_task_by_pid(pid);
> +	}
> +	if (p) {
> +		retval = -EPERM;
> +		if (!prlim_check_perm(p))
> +			goto out_unlock;
> +
> +		task_lock(p->group_leader);
> +		value = p->signal->rlim[resource];
> +		task_unlock(p->group_leader);
> +		retval = copy_to_user(rlim, &value, sizeof(*rlim)) ? -EFAULT : 0;

Do not call copy_to_user() with tasklist_lock held.  Also, this is the
same basic code as sys_getrlimit().  So they should share code. (IOW,
sys_getrlimit() is now really sys_getprlimit(0,...))

thanks,
-chris
