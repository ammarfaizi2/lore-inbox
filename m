Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbVHUBMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbVHUBMu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 21:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbVHUBMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 21:12:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29081 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750750AbVHUBMu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 21:12:50 -0400
Date: Sat, 20 Aug 2005 18:11:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: e8607062@student.tuwien.ac.at
Cc: linux-kernel@vger.kernel.org, sopwith@redhat.com
Subject: Re: [PATCH 2.6.13-rc6 1/2] New Syscall: get rlimits of any process
Message-Id: <20050820181102.725a4817.akpm@osdl.org>
In-Reply-To: <1123868902.10923.5.camel@w2>
References: <1123868902.10923.5.camel@w2>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wieland Gmeiner <e8607062@student.tuwien.ac.at> wrote:
>
> +asmlinkage long sys_getprlimit(pid_t pid, unsigned int resource, struct rlimit __user *rlim)
>  +{
>  +        struct rlimit value;
>  +        task_t *p;
>  +        int retval = -EINVAL;
>  +
>  +        if (resource >= RLIM_NLIMITS)
>  +                goto out_nounlock;
>  +
>  +        if (pid < 0)
>  +                goto out_nounlock;
>  +
>  +        retval = -ESRCH;
>  +        if (pid == 0) {
>  +                p = current;
>  +        } else {
>  +                read_lock(&tasklist_lock);
>  +                p = find_task_by_pid(pid);
>  +        }
>  +        if (p) {
>  +                retval = -EPERM;
>  +                if ((current->euid ^ p->suid) && (current->euid ^ p->uid) &&
>  +                    (current->uid ^ p->suid) && (current->uid ^ p->uid) &&
>  +                    !capable(CAP_SYS_RESOURCE))
>  +                        goto out_unlock;
>  +
>  +                task_lock(p->group_leader);
>  +                value = p->signal->rlim[resource];
>  +                task_unlock(p->group_leader);

There isn't much point in taking task_lock() here.  The value can change
after the lock has been dropped anyway.

>  +                retval = copy_to_user(rlim, &value, sizeof(*rlim)) ? -EFAULT : 0;

It's not legal to perform copy_*_user() (which sleeps) inside read_lock(),
write_lock(), spin_lock(), preempt_diable() or, really,
local_irq_disable().

>  +        }
>  +        if (pid == 0)
>  +                goto out_nounlock;
>  +
>  +out_unlock:
>  +        read_unlock(&tasklist_lock);
