Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932655AbVIMOyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932655AbVIMOyM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 10:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932654AbVIMOyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 10:54:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49293 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932656AbVIMOyL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 10:54:11 -0400
Date: Tue, 13 Sep 2005 07:53:40 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Sripathi Kodi <sripathik@in.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       patrics@interia.pl, Ingo Molnar <mingo@elte.hu>,
       Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH 2.6.13.1] Patch for invisible threads
In-Reply-To: <4326CFE2.6000908@in.ibm.com>
Message-ID: <Pine.LNX.4.58.0509130744070.3351@g5.osdl.org>
References: <4325BEF3.2070901@in.ibm.com> <20050912134954.7bbd15b2.akpm@osdl.org>
 <4326CFE2.6000908@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 13 Sep 2005, Sripathi Kodi wrote:
> 
> Thanks and regards,
> Sripathi.
> 
> Signed-off-by: Sripathi Kodi <sripathik@in.ibm.com>
> 
> --- linux-2.6.13.1/kernel/exit.c	2005-09-13 15:39:48.738542872 -0500
> +++ /home/sripathi/17794/patch_2.6.13.1/exit.c	2005-09-13 15:39:27.367791720 
> -0500
> @@ -463,9 +463,13 @@ static inline void __exit_fs(struct task
>   	struct fs_struct * fs = tsk->fs;
> 
>   	if (fs) {
> -		task_lock(tsk);
> -		tsk->fs = NULL;
> -		task_unlock(tsk);
> +		/* If tsk is thread group leader and if group still has alive
> +		 * threads, those threads may use tsk->fs */
> +		if (!thread_group_leader(tsk) || !atomic_read(&tsk->signal->live)) {
> +			task_lock(tsk);
> +			tsk->fs = NULL;
> +			task_unlock(tsk);
> +		}
>   		__put_fs_struct(fs);
>   	}
>   }

This really is wrong. You "put" the fs without clearing it in that thread, 
which means that now the reference counts no longer match the number of 
pointers to it. This will inevitably result in using stale fs pointers in 
/proc at some point. Not good. In fact, I almost guarantee that you can do 
that by just having a thread group which doesn't share it's file 
descriptors (which is possible, even though no _nice_ program does it. 
Think DoS/security attack).

The sub-threads have a "->fs" of their own, and they'll happily continue 
to use their own versions.

So this patch is _wrong_.

I think the problem is "proc_check_root()", which just refuses to do a lot 
of things without a fs. Many of those things are unnecessary, afaik - we 
should allow it. But allowing it means that some other paths may need more 
checking..

So you can _try_ to just make proc_check_root() return 0 when 
proc_root_link() returns an error...

		Linus
