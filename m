Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbWJLWA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWJLWA6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 18:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWJLWA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 18:00:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53960 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751162AbWJLWA5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 18:00:57 -0400
Date: Thu, 12 Oct 2006 15:00:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/5] oom: don't kill unkillable children or siblings
Message-Id: <20061012150050.ad6e1c8b.akpm@osdl.org>
In-Reply-To: <20061012120111.29671.83152.sendpatchset@linux.site>
References: <20061012120102.29671.31163.sendpatchset@linux.site>
	<20061012120111.29671.83152.sendpatchset@linux.site>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2006 16:09:43 +0200 (CEST)
Nick Piggin <npiggin@suse.de> wrote:

> Abort the kill if any of our threads have OOM_DISABLE set. Having this test
> here also prevents any OOM_DISABLE child of the "selected" process from being
> killed.
> 
> Signed-off-by: Nick Piggin <npiggin@suse.de>
> 
> Index: linux-2.6/mm/oom_kill.c
> ===================================================================
> --- linux-2.6.orig/mm/oom_kill.c
> +++ linux-2.6/mm/oom_kill.c
> @@ -312,15 +312,24 @@ static int oom_kill_task(struct task_str
>  	if (mm == NULL)
>  		return 1;
>  
> +	/*
> +	 * Don't kill the process if any threads are set to OOM_DISABLE
> +	 */
> +	do_each_thread(g, q) {
> +		if (q->mm == mm && p->oomkilladj == OOM_DISABLE)
> +			return 1;
> +	} while_each_thread(g, q);
> +
>  	__oom_kill_task(p, message);
> +
>  	/*
>  	 * kill all processes that share the ->mm (i.e. all threads),
>  	 * but are in a different thread group
>  	 */
> -	do_each_thread(g, q)
> +	do_each_thread(g, q) {
>  		if (q->mm == mm && q->tgid != p->tgid)
>  			__oom_kill_task(q, message);
> -	while_each_thread(g, q);
> +	} while_each_thread(g, q);
>  
>  	return 0;

One wonders whether OOM_DISABLE should be a property of the mm_struct, not
of the task_struct.

