Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbVKAKL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbVKAKL2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 05:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbVKAKL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 05:11:28 -0500
Received: from main.gmane.org ([80.91.229.2]:24269 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750703AbVKAKL1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 05:11:27 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Norbert Kiesel <nk@iname.com>
Subject: Re: [PATCH consolidate sys_ptrace
Date: Tue, 01 Nov 2005 01:51:51 -0800
Message-ID: <pan.2005.11.01.09.51.40.860720@iname.com>
References: <20051101050900.GA25793@lst.de> <20051101051221.GA26017@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp-71-139-205-74.dsl.snfc21.pacbell.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Nov 2005 06:12:21 +0100, Christoph Hellwig wrote:

<snip>

> Index: linux-2.6/kernel/ptrace.c
> ===================================================================
> --- linux-2.6.orig/kernel/ptrace.c	2005-10-31 13:15:52.000000000 +0100
> +++ linux-2.6/kernel/ptrace.c	2005-10-31 17:30:43.000000000 +0100
> @@ -406,3 +406,85 @@
>  
>  	return ret;
>  }
> +
> +#ifndef __ARCH_SYS_PTRACE
> +static int ptrace_get_task_struct(long request, long pid,
> +		struct task_struct **childp)
> +{
> +	struct task_struct *child;
> +	int ret;
This "ret" is basically unused and should go away

> +
> +	/*
> +	 * Callers use child == NULL as an indication to exit early even
> +	 * when the return value is 0, so make sure it is non-NULL here.
> +	 */
> +	*childp = NULL;
> +
> +	if (request == PTRACE_TRACEME) {
> +		/*
> +		 * Are we already being traced?
> +		 */
> +		if (current->ptrace & PT_PTRACED)
> +			return -EPERM;
> +		ret = security_ptrace(current->parent, current);
> +		if (ret)
	if (security_ptrace(current->parent, current))

> +			return -EPERM;
> +		/*
> +		 * Set the ptrace bit in the process ptrace flags.
> +		 */
> +		current->ptrace |= PT_PTRACED;
> +		return 0;
> +	}
> +
> +	/*
> +	 * You may not mess with init
> +	 */
> +	if (pid == 1)
> +		return -EPERM;
> +
> +	ret = -ESRCH;
Not needed (anymore)

> +	read_lock(&tasklist_lock);
> +	child = find_task_by_pid(pid);
> +	if (child)
> +		get_task_struct(child);
> +	read_unlock(&tasklist_lock);
> +	if (!child)
> +		return -ESRCH;
> +
> +	*childp = child;
> +	return 0;
> +}
> +


Best,
  Norbert


