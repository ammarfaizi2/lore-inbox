Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271167AbUJVCUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271167AbUJVCUl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 22:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271192AbUJVCUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 22:20:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:6037 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271167AbUJVCSH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 22:18:07 -0400
Date: Thu, 21 Oct 2004 19:16:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jay Lan <jlan@engr.sgi.com>
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       guillaume.thouvenin@bull.net
Subject: Re: [Lse-tech] [PATCH 2.6.9 1/2] enhanced accounting data
 collection
Message-Id: <20041021191608.06b74417.akpm@osdl.org>
In-Reply-To: <41786344.9070504@engr.sgi.com>
References: <41785FE3.806@engr.sgi.com>
	<41786344.9070504@engr.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay Lan <jlan@engr.sgi.com> wrote:
>
> 1/2: acct_io
> 
> Enahanced I/O accounting data collection.
> 

It's nice to use `diff -p' so people can see what functions you're hitting.

> +			current->syscr++;

Should these metrics be per-thread or per-heavyweight process?

> +	if (ret > 0) {
> +		current->rchar += ret;
> +	}

It's conventional to omit the braces if there is only one statement in the
block.

> ===================================================================
> --- linux.orig/include/linux/sched.h	2004-10-01 17:01:21.412848229 -0700
> +++ linux/include/linux/sched.h	2004-10-01 17:09:42.723482260 -0700
> @@ -591,6 +591,9 @@
>  	struct rw_semaphore pagg_sem;

There is no `pagg_sem' in the kernel, so this will spit a reject.

>  #endif
>  
> +/* i/o counters(bytes read/written, #syscalls */
> +	unsigned long rchar, wchar, syscr, syscw;
> +

These will overflow super-quick.  Shouldn't they be 64-bit?

> --- linux.orig/kernel/fork.c	2004-10-01 17:01:21.432379595 -0700
> +++ linux/kernel/fork.c	2004-10-01 17:09:42.732271376 -0700
> @@ -995,6 +995,7 @@
>  	p->real_timer.data = (unsigned long) p;
>  
>  	p->utime = p->stime = 0;
> +	p->rchar = p->wchar = p->syscr = p->syscw = 0;

We generally prefer

	p->rchar = 0;
	p->wchar = 0;
	etc.

yes, the code which is there has already sinned - feel free to clean it up
while you're there ;)

