Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbVCYAyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbVCYAyw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 19:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbVCYAwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 19:52:30 -0500
Received: from fire.osdl.org ([65.172.181.4]:33207 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261334AbVCYAol (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 19:44:41 -0500
Date: Thu, 24 Mar 2005 16:44:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: coywolf@gmail.com
Cc: coywolf@sosdg.org, linux-kernel@vger.kernel.org, james4765@cwazy.co.uk
Subject: Re: [patch] oom-killer sysrq-f fix
Message-Id: <20050324164435.4286ac5f.akpm@osdl.org>
In-Reply-To: <20050325003316.GA31352@everest.sosdg.org>
References: <20050325003316.GA31352@everest.sosdg.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt <coywolf@sosdg.org> wrote:
>
> Recent make-sysrq-f-call-oom_kill.patch calls oom-killer in interrupt context,
> thus results into panic. This patch fixes out_of_memory() to avoid schedule
> when in interrupt context.
> 
> 	Coywolf
> 
> 
> Signed-off-by: Coywolf Qi Hunt <coywolf@lovecn.org>
> 
> diff -pruN 2.6.12-rc1-mm2/mm/oom_kill.c 2.6.12-rc1-mm2-cy/mm/oom_kill.c
> --- 2.6.12-rc1-mm2/mm/oom_kill.c	2005-03-03 17:12:18.000000000 +0800
> +++ 2.6.12-rc1-mm2-cy/mm/oom_kill.c	2005-03-25 08:07:19.000000000 +0800
> @@ -20,6 +20,7 @@
>  #include <linux/swap.h>
>  #include <linux/timex.h>
>  #include <linux/jiffies.h>
> +#include <linux/hardirq.h>
>  
>  /* #define DEBUG */
>  
> @@ -283,6 +284,9 @@ retry:
>  	if (mm)
>  		mmput(mm);
>  
> +	if (in_interrupt())
> +		return;

That'll make the whole feature a no-op, won't it?

The thing needs to be moved into process context via schedule_work().  I
haven't got around to it yet.

