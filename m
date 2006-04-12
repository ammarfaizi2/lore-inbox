Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbWDLG7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbWDLG7f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 02:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbWDLG7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 02:59:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34179 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932089AbWDLG7f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 02:59:35 -0400
Date: Tue, 11 Apr 2006 23:59:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, clameter@engr.sgi.com,
       riel@redhat.com, dgc@sgi.com
Subject: Re: [PATCH] support for panic at OOM
Message-Id: <20060411235907.6a59ecba.akpm@osdl.org>
In-Reply-To: <20060412155301.10d611ca.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060412155301.10d611ca.kamezawa.hiroyu@jp.fujitsu.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
>
> This patch adds a feature to panic at OOM, oom_die.

Makes sense I guess.

> ===================================================================
> --- linux-2.6.17-rc1-mm2.orig/kernel/sysctl.c
> +++ linux-2.6.17-rc1-mm2/kernel/sysctl.c
> @@ -60,6 +60,7 @@ extern int proc_nr_files(ctl_table *tabl
>  extern int C_A_D;
>  extern int sysctl_overcommit_memory;
>  extern int sysctl_overcommit_ratio;
> +extern int sysctl_oom_die;
>  extern int max_threads;
>  extern int sysrq_enabled;
>  extern int core_uses_pid;

One day we should create a header file for all these.

> @@ -718,6 +719,14 @@ static ctl_table vm_table[] = {
>  		.proc_handler	= &proc_dointvec,
>  	},
>  	{
> +		.ctl_name	= VM_OOM_DIE,
> +		.procname	= "oom_die",

I'd suggest it be called "panic_on_oom".  Like the current panic_on_oops.

> +int sysctl_oom_die = 0;

The initialisation is unneeded.

> +static void oom_die(void)
> +{
> +	panic("Panic: out of memory: oom_die is selected.");
> +}
> +
>  /**
>   * oom_kill - kill the "best" process when we run out of memory
>   *
> @@ -331,6 +337,8 @@ void out_of_memory(struct zonelist *zone
>  
>  	case CONSTRAINT_NONE:
>  retry:
> +		if (sysctl_oom_die)
> +			oom_die();

I don't think we need a separate function for this?

Please document the new sysctl in Documentation/sysctl/.
