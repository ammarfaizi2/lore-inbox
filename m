Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317369AbSFCLIh>; Mon, 3 Jun 2002 07:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317370AbSFCLIg>; Mon, 3 Jun 2002 07:08:36 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:37062 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S317369AbSFCLIe>;
	Mon, 3 Jun 2002 07:08:34 -0400
Date: Mon, 3 Jun 2002 13:08:16 +0200
From: Jens Axboe <axboe@suse.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: suspend.c: This is broken, fixme
Message-ID: <20020603110816.GI820@suse.de>
In-Reply-To: <20020603095507.GA3030@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03 2002, Pavel Machek wrote:
> Hi!
> 
> I found this in 2.5.20...
> 
> --- a/kernel/suspend.c  Sun Jun  2 18:44:56 2002
> +++ b/kernel/suspend.c  Sun Jun  2 18:44:56 2002
> @@ -64,6 +64,7 @@
>  #include <asm/mmu_context.h>
>  #include <asm/pgtable.h>
>  #include <asm/io.h>
> +#include <linux/swapops.h>
> 
>  unsigned char software_suspend_enabled = 0;
> 
> @@ -300,7 +301,8 @@
>  static void do_suspend_sync(void)
>  {
>         while (1) {
> -               run_task_queue(&tq_disk);
> +               blk_run_queues();
> +#error this is broken, FIXME
>                 if (!TQ_ACTIVE(tq_disk))
>                         break;
> 
> . Why is it broken?

Hey, I even cc'ed you on the patch when it went to Linus... Lets look at
what happened before: run tq_disk, then check if it is active. What
prevents tq_disk from being active right after you issue the TQ_ACTIVE
check? Nothing. And I'm not sure exactly what semantics you think
running tq_disk has. I suspect you are looking for a 'start any pending
i/o and return when it has completed', which is far from what happens.
Running tq_disk will _try_ to start _some_ I/O, and eventually, in time,
the currently pending requests will have completed. In the mean time,
more I/O could have been added though.

-- 
Jens Axboe

