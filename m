Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbWGKIFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWGKIFv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 04:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWGKIFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 04:05:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52170 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750726AbWGKIFu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 04:05:50 -0400
Date: Tue, 11 Jul 2006 01:05:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl: Allow /proc/sys without sys_sysctl
Message-Id: <20060711010548.b6e4138e.akpm@osdl.org>
In-Reply-To: <m14pxoh92e.fsf@ebiederm.dsl.xmission.com>
References: <m1u05pkruk.fsf@ebiederm.dsl.xmission.com>
	<20060710211951.7bf8320b.akpm@osdl.org>
	<m1bqrwiq74.fsf@ebiederm.dsl.xmission.com>
	<20060711000434.6c25d9c2.akpm@osdl.org>
	<m14pxoh92e.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2006 01:52:57 -0600
ebiederm@xmission.com (Eric W. Biederman) wrote:

> As far as I can tell we never use sys_sysctl so I never expect to see
> these messages.  But if we do see these it means that there are user
> space applications that need to be fixed before we can safely
> remove sys_sysctl.
> 
> Limited to only 5 messages in case something like glibc is using sys_sysctl.
> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> ---
>  kernel/sysctl.c |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)
> 
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 42610e6..b7f7dcb 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1303,9 +1303,15 @@ int do_sysctl(int __user *name, int nlen
>  
>  asmlinkage long sys_sysctl(struct __sysctl_args __user *args)
>  {
> +	static int msg_count;
>  	struct __sysctl_args tmp;
>  	int error;
>  
> +	if (msg_count++ < 5)
> +		printk(KERN_INFO
> +			"warning: process `%s' used the obsolete sysctl "
> +			"system call\n", current->comm);
> +
>  	if (copy_from_user(&tmp, args, sizeof(tmp)))
>  		return -EFAULT;

That'll print it five times per 4 billion calls ;)

> @@ -2688,6 +2694,12 @@ #else /* CONFIG_SYSCTL_SYSCALL */
>  
>  asmlinkage long sys_sysctl(struct __sysctl_args __user *args)
>  {
> +	static int msg_count;
> +
> +	if (msg_coutn++ < 5)

That'll have trouble compiling.

Go to bed, man.  I'll fix it up.

