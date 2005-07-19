Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261354AbVGSNyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbVGSNyZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 09:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbVGSNyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 09:54:25 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:14534 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261354AbVGSNyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 09:54:23 -0400
Date: Tue, 19 Jul 2005 15:54:25 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Convert refrigerator() to try_to_freeze()
Message-ID: <20050719135425.GA2410@elf.ucw.cz>
References: <1121659148.13493.58.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121659148.13493.58.camel@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch removes the few remaining direct invocations of the
> refrigerator in 2.6.13-rc3. In drivers/media/video/msp3400.c, it also
> shifts the call to after the remove_wait_queue; this seems to be the
> more appropriate place.


> diff -ruNp 230-refrigerator-to-try_to_freeze.patch-old/fs/jbd/journal.c 230-refrigerator-to-try_to_freeze.patch-new/fs/jbd/journal.c
> --- 230-refrigerator-to-try_to_freeze.patch-old/fs/jbd/journal.c	2005-07-18 06:36:59.000000000 +1000
> +++ 230-refrigerator-to-try_to_freeze.patch-new/fs/jbd/journal.c	2005-07-18 13:54:47.000000000 +1000
> @@ -175,7 +175,7 @@ loop:
>  		 */
>  		jbd_debug(1, "Now suspending kjournald\n");
>  		spin_unlock(&journal->j_state_lock);
> -		refrigerator();
> +		try_to_freeze();
>  		spin_lock(&journal->j_state_lock);
>  	} else {
>  		/*

They probably tested it before, why test again?

> diff -ruNp 230-refrigerator-to-try_to_freeze.patch-old/fs/jfs/jfs_logmgr.c 230-refrigerator-to-try_to_freeze.patch-new/fs/jfs/jfs_logmgr.c
> --- 230-refrigerator-to-try_to_freeze.patch-old/fs/jfs/jfs_logmgr.c	2005-07-18 06:36:59.000000000 +1000
> +++ 230-refrigerator-to-try_to_freeze.patch-new/fs/jfs/jfs_logmgr.c	2005-07-18 13:54:47.000000000 +1000
> @@ -2361,7 +2361,7 @@ int jfsIOWait(void *arg)
>  		}
>  		if (freezing(current)) {
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  			spin_unlock_irq(&log_redrive_lock);
> -			refrigerator();
> +			try_to_freeze();
>  		} else {
>  			add_wait_queue(&jfs_IO_thread_wait, &wq);
>  			set_current_state(TASK_INTERRUPTIBLE);

See? You are needlessly testing condition twice.

							Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
