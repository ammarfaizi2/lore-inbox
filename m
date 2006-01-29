Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWA2IgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWA2IgZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 03:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbWA2IgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 03:36:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:42471 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750742AbWA2IgY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 03:36:24 -0500
Date: Sun, 29 Jan 2006 00:36:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exec: Only allow a threaded init to exec from the
 thread_group_leader
Message-Id: <20060129003606.7887ecd9.akpm@osdl.org>
In-Reply-To: <m14q3nh7zi.fsf@ebiederm.dsl.xmission.com>
References: <m14q3nh7zi.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) wrote:
>
> The weird things we do when we exec from a thread group are just ugly.
> Those ugly things do not handle the case of init and I suspect
> extending that code to properly support a threaded init would be just
> hideous, and impossible to maintain. 
> 
> So just in case someone ever threads init return an error for the
> unimplemented case.
> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> 
> 
> ---
> 
>  fs/exec.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> 408dad0f2b7067b23929866150e73b2b2f12d662
> diff --git a/fs/exec.c b/fs/exec.c
> index 055378d..c9d8e31 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -600,6 +600,12 @@ static int de_thread(struct task_struct 
>  	if (thread_group_empty(current))
>  		goto no_thread_group;
>  
> +	/* A threaded init must exec from it's primary thread.
> +	 * As the init task (i.e. child_reaper) may not exit.
> +	 */
> +	if (!thread_group_leader(current) && (current->tgid == 1))
> +		return -EINVAL;
> +	
>  	/*
>  	 * Kill all other threads in the thread group.
>  	 * We must hold tasklist_lock to call zap_other_threads.

hmm, this just looks like overhead.  If sometime someone _does_ try to
thread init, what will happen to them?  If it's something nice and nasty,
they'll just whine at us and stop doing that.  Same net effect, no runtime
cost.
