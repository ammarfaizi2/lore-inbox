Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbWDTXXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbWDTXXP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 19:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbWDTXXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 19:23:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8114 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932130AbWDTXXO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 19:23:14 -0400
Date: Thu, 20 Apr 2006 16:21:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Claudio Scordino" <cloud.of.andor@gmail.com>
Cc: linux-kernel@vger.kernel.org, luto@myrealbox.com, alan@lxorguk.ukuu.org.uk,
       torvalds@osdl.org, kernel-janitors@lists.osdl.org
Subject: Re: [PATCH] Extending getrusage
Message-Id: <20060420162140.0a03e227.akpm@osdl.org>
In-Reply-To: <d0191dad0604200821l3fa0ed70ga2faabe79d7718ec@mail.gmail.com>
References: <d0191dad0604200821l3fa0ed70ga2faabe79d7718ec@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Claudio Scordino" <cloud.of.andor@gmail.com> wrote:
>
> For the people who missed the beginning of the discussion, the
> following patch is an extension of the existing getrusage syscall()
> and it applies to the 2.6.16.9 kernel.
> 
> It allows a task to read usage information about another task. The argument
> who can be equal to RUSAGE_SELF, to RUSAGE_CHILDREN or to a valid pid.
> 
> The permissions are checked through security_ptrace() as suggested by Andy.
> 

Bit hacky, but given the chosen values of RUSAGE_*, it seems solid enough.

There is no way of doing getrusage of another process and its children.

> --- sys.old.c	2006-04-19 02:10:14.000000000 -0400
> +++ sys.c	2006-04-20 10:53:16.000000000 -0400

Please prepare patches in `patch -p1' form, as per
http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt.

> @@ -1765,11 +1765,30 @@ int getrusage(struct task_struct *p, int
>  	return copy_to_user(ru, &r, sizeof(r)) ? -EFAULT : 0;
>  }
> 
> +/* who can be RUSAGE_SELF, RUSAGE_CHILDREN or a valid pid */
>  asmlinkage long sys_getrusage(int who, struct rusage __user *ru)
>  {
> -	if (who != RUSAGE_SELF && who != RUSAGE_CHILDREN)
> -		return -EINVAL;
> -	return getrusage(current, who, ru);
> +	struct rusage r;
> +	struct task_struct* tsk = current;

should be

	struct task_struct *tsk = current;

> +	read_lock(&tasklist_lock);
> +	if ((who != RUSAGE_SELF) && (who != RUSAGE_CHILDREN)) {

The parenthesisation is perhaps a little excessive.

> +		if (who <= 0)
> +			goto bad;
> +		tsk = find_task_by_pid(who);
> +		if (tsk == NULL)
> +			goto bad;
> +		if ((tsk != current) && security_ptrace(current, tsk))
> +			goto bad;
> +		/* current can get info about tsk */
> +		who = RUSAGE_SELF;
> +	}
> +	k_getrusage(tsk, who, &r);
> +	read_unlock(&tasklist_lock);
> +	return copy_to_user(ru, &r, sizeof(r)) ? -EFAULT : 0;
> +
> +bad:
> +	read_unlock(&tasklist_lock);
> +	return tsk ? -EPERM : -EINVAL;
>  }
> 

This patch changes sys_getrusage() but not getrusage().  But there are
several callers of getrusage() in various dark corners of the kernel.  Why
do they not also want the extended functionality?

I'd be reluctant to support this change without a compelling description of
why we actually want it.

