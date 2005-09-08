Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751343AbVIHIPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbVIHIPU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 04:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbVIHIPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 04:15:20 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:2569 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751343AbVIHIPT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 04:15:19 -0400
Date: Thu, 8 Sep 2005 10:15:21 +0200
From: Jens Axboe <axboe@suse.de>
To: Giancarlo Formicuccia <giancarlo.formicuccia@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6.13] task_struct->fs_excl, kernel_thread and jffs2
Message-ID: <20050908081520.GH4893@suse.de>
References: <200509080947.58155.giancarlo.formicuccia@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509080947.58155.giancarlo.formicuccia@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08 2005, Giancarlo Formicuccia wrote:
> Hi,
> [please CC me in any reply]
> I'm not sure that dup_task_struct() must copy the fs_excl field. This can leads to
> problems if do_fork() is somehow called while fs_excl!=0.
> For example, the jffs2 code creates a kernel thread (jffs2_garbage_collect_thread)
> in a path where lock_super() is held (i.e. by do_remount_sb, during -o remount,rw).
> When the new thread expires, a badness happens (kernel/exit.c:787). This problem
> was observed by a couple of people and can be easily reproduced:
> http://lists.infradead.org/pipermail/linux-mtd/2005-August/013487.html
> http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2005-September/031109.html
> 
> At first glance, I'd simply set fs_excl to 0 for every new thread in dup_task_struct:
> 
> --- linux-2.6.13/kernel/fork.c	2005-08-29 01:41:01.000000000 +0200
> +++ linux-2.6.13-new/kernel/fork.c	2005-09-07 17:06:23.000000000 +0200
> @@ -173,6 +173,7 @@ static struct task_struct *dup_task_stru
>  	*tsk = *orig;
>  	tsk->thread_info = ti;
>  	ti->task = tsk;
> +	atomic_set(&tsk->fs_excl, 0);
>  
>  	/* One for us, one for whoever does the "release_task()" (usually parent) */
>  	atomic_set(&tsk->usage,2);
> 
> but I've a doubt about the WARN_ON in exit.c being actually here to report these 
> kernel_thread() users (like jffs2)...
> 
> Any comment/suggestion?

Patch is correct, that is definitely an oversight!

Acked-by: Jens Axboe <axboe@suse.de>

-- 
Jens Axboe

