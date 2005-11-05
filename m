Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbVKEGjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbVKEGjB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 01:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbVKEGjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 01:39:01 -0500
Received: from smtp.osdl.org ([65.172.181.4]:53930 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751267AbVKEGjA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 01:39:00 -0500
Date: Fri, 4 Nov 2005 22:38:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: Simon.Derr@bull.net, ak@suse.de, pj@sgi.com, linux-kernel@vger.kernel.org,
       clameter@sgi.com
Subject: Re: [PATCH 6/5] cpuset: rebind numa vma mempolicy fix
Message-Id: <20051104223810.31355dce.akpm@osdl.org>
In-Reply-To: <20051104082833.8786.5266.sendpatchset@jackhammer.engr.sgi.com>
References: <20051104082833.8786.5266.sendpatchset@jackhammer.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> It's ok to not complete the refresh_mems() operation
>  if we notice we are already holding mmap_sem.  We
>  will try again, next time we allocate memory.

What's the call path? alloc_pages_current() and alloc_page_vma()?

> 
>  --- 2.6.14-rc5-mm1-cpuset-patches.orig/kernel/cpuset.c	2005-11-03 21:18:26.783391082 -0800
>  +++ 2.6.14-rc5-mm1-cpuset-patches/kernel/cpuset.c	2005-11-03 23:11:15.480042373 -0800
>  @@ -656,7 +656,12 @@ static void refresh_mems(void)
>   	if (current->cpuset_mems_generation != my_cpusets_mem_gen) {
>   		struct cpuset *cs;
>   		nodemask_t oldmem = current->mems_allowed;
>  +		struct mm_struct *mm = current->mm;
>   
>  +		/* numa_policy_rebind() needs mmap_sem - don't nest */
>  +		if (!mm || !down_write_trylock(&mm->mmap_sem))
>  +			return;
>  +		up_write(&mm->mmap_sem);

What happens if the task is doing _all_ its allocation under
down_read(mmap_sem)?  Like, memset(malloc(lots))?  Does all that memory end
up in the wrong place, or what?

Something less hacky^W^W more deterministic would be nice.
