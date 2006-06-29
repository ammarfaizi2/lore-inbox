Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751830AbWF2AQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830AbWF2AQn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 20:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751836AbWF2AQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 20:16:43 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:4995 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751830AbWF2AQm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 20:16:42 -0400
Date: Wed, 28 Jun 2006 17:16:28 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: James Morris <jmorris@namei.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>, Chris Wright <chrisw@sous-sol.org>,
       David Quigley <dpquigl@tycho.nsa.gov>
Subject: Re: [PATCH 1/3] SELinux: Extend task_kill hook to handle signals sent by AIO completion
Message-ID: <20060629001628.GQ11588@sequoia.sous-sol.org>
References: <Pine.LNX.4.64.0606281943240.17149@d.namei>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606281943240.17149@d.namei>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* James Morris (jmorris@namei.org) wrote:
> From: David Quigley <dpquigl@tycho.nsa.gov>
> 
> This patch extends the security_task_kill hook to handle signals sent by 
> AIO completion.  In this case, the secid of the task responsible for the 
> signal needs to be obtained and saved earlier, so a 
> security_task_getsecid() hook is added, and then this saved value is 
> passed subsequently to the extended task_kill hook for use in checking.
> 
> Signed-Off-By: David Quigley <dpquigl@tycho.nsa.gov>
> Signed-off-by: James Morris <jmorris@namei.org>
> 
> 
> Please apply.
> 
> ---
> 
>  include/linux/security.h |   23 +++++++++++++++++++----
>  security/dummy.c         |    6 +++++-
>  security/selinux/hooks.c |   21 +++++++++++++++++----
>  3 files changed, 41 insertions(+), 9 deletions(-)
> 
> diff -uprN -X /home/dpquigl/dontdiff linux-2.6.17-mm3/include/linux/security.h linux-2.6.17-mm3-kill/include/linux/security.h
> --- linux-2.6.17-mm3/include/linux/security.h	2006-06-28 13:58:59.000000000 -0400
> +++ linux-2.6.17-mm3-kill/include/linux/security.h	2006-06-28 15:24:54.000000000 -0400
> @@ -567,6 +567,9 @@ struct swap_info_struct;
>   *	@p.
>   *	@p contains the task_struct for the process.
>   *	Return 0 if permission is granted.
> + * @task_getsecid:
> + *	Retrieve the security identifier of the process @p.
> + *	@p contains the task_struct for the process and place is into @secid.
>   * @task_setgroups:
>   *	Check permission before setting the supplementary group set of the
>   *	current process.
> @@ -615,6 +618,7 @@ struct swap_info_struct;
>   *	@p contains the task_struct for process.
>   *	@info contains the signal information.
>   *	@sig contains the signal value.
> + *	@secid contains the sid of the process where the signal originated
>   *	Return 0 if permission is granted.
>   * @task_wait:
>   *	Check permission before allowing a process to reap a child process @p
> @@ -1218,6 +1222,7 @@ struct security_operations {
>  	int (*task_setpgid) (struct task_struct * p, pid_t pgid);
>  	int (*task_getpgid) (struct task_struct * p);
>  	int (*task_getsid) (struct task_struct * p);
> +	void (*task_getsecid) (struct task_struct * p, u32 * secid);

Why not just:
	u32 (*task_getsecid) (struct task_struct *p);

>  	int (*task_setgroups) (struct group_info *group_info);
>  	int (*task_setnice) (struct task_struct * p, int nice);
>  	int (*task_setioprio) (struct task_struct * p, int ioprio);
> @@ -1227,7 +1232,7 @@ struct security_operations {
>  	int (*task_getscheduler) (struct task_struct * p);
>  	int (*task_movememory) (struct task_struct * p);
>  	int (*task_kill) (struct task_struct * p,
> -			  struct siginfo * info, int sig);
> +			  struct siginfo * info, int sig, u32 secid);

This breaks the build, which breaks bisection.  Be nice to avoid that
since there's no reason the patches couldn't split that way.

> diff -uprN -X /home/dpquigl/dontdiff linux-2.6.17-mm3/security/selinux/hooks.c linux-2.6.17-mm3-kill/security/selinux/hooks.c
> --- linux-2.6.17-mm3/security/selinux/hooks.c	2006-06-28 13:58:59.000000000 -0400
> +++ linux-2.6.17-mm3-kill/security/selinux/hooks.c	2006-06-28 14:40:00.000000000 -0400
> @@ -45,6 +45,7 @@
>  #include <linux/kd.h>
>  #include <linux/netfilter_ipv4.h>
>  #include <linux/netfilter_ipv6.h>
> +#include <linux/selinux.h>

It's already included.

thanks,
