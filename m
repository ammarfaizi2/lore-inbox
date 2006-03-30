Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbWC3AjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbWC3AjJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 19:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWC3AjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 19:39:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:37251 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751305AbWC3AjH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 19:39:07 -0500
Date: Wed, 29 Mar 2006 16:41:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <Trond.Myklebust@netapp.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: fs/locks.c: Fix sys_flock() race
Message-Id: <20060329164125.04c66c6b.akpm@osdl.org>
In-Reply-To: <1143651308.8697.10.camel@lade.trondhjem.org>
References: <1143651308.8697.10.camel@lade.trondhjem.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <Trond.Myklebust@netapp.com> wrote:
>
> -	unlock_kernel();
>  
> -	if (new_fl->fl_type == F_UNLCK)
> -		return 0;
> +	if (request->fl_type == F_UNLCK)
> +		goto out;
>  
> +	new_fl = locks_alloc_lock();
> +	if (new_fl == NULL)
> +		goto out;
>  	/*
>  	 * If a higher-priority process was blocked on the old file lock,
>  	 * give it the opportunity to lock the file.
> @@ -769,26 +772,27 @@ static int flock_lock_file(struct file *
>  	if (found)
>  		cond_resched();
>  
> -	lock_kernel();

hm, you've extended lock_kernel() coverage (why?  Does this help fix the
race??) but we still have a cond_resched() inside the now-newly-locked
region.  If that cond_resched() drops the bkl, is the race reopened?
