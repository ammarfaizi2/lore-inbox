Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263886AbUDPWMe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 18:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263846AbUDPWDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 18:03:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:31158 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263887AbUDPWBo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 18:01:44 -0400
Date: Fri, 16 Apr 2004 15:01:32 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Jones <davej@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, mingo@redhat.com,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: fix __exit_mm() dereference before check.
In-Reply-To: <20040416210828.GK20937@redhat.com>
Message-ID: <Pine.LNX.4.58.0404161458510.3947@ppc970.osdl.org>
References: <20040416210828.GK20937@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 16 Apr 2004, Dave Jones wrote:
>
> From a quick look, it appears passing NULL mm's down to mm_release()
> isn't a good idea.

Hmm.. Where's the dereference? I don't disagree with the patch per se, but 
I don't see any real problem.

The mm->mm_users check is protected by "tsk->clear_child_tid", and that 
will have been cleared already if we ever happen to call __exit_mm() 
twice, so that one is safe.

So this patch might be a cleanup, but not a "fix" per se.

			Linus

> --- linux-2.6.5/kernel/exit.c~	2004-04-16 22:06:00.000000000 +0100
> +++ linux-2.6.5/kernel/exit.c	2004-04-16 22:06:51.000000000 +0100
> @@ -482,9 +482,10 @@
>  {
>  	struct mm_struct *mm = tsk->mm;
>  
> -	mm_release(tsk, mm);
>  	if (!mm)
>  		return;
> +	mm_release(tsk, mm);
> +
>  	/*
>  	 * Serialize with any possible pending coredump.
>  	 * We must hold mmap_sem around checking core_waiters
> 
