Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129213AbRBTP7k>; Tue, 20 Feb 2001 10:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129216AbRBTP7b>; Tue, 20 Feb 2001 10:59:31 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:11023 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129213AbRBTP7P>; Tue, 20 Feb 2001 10:59:15 -0500
Date: Tue, 20 Feb 2001 17:00:00 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: __lock_page calls run_task_queue(&tq_disk) unecessarily?
Message-ID: <20010220170000.J26544@athlon.random>
In-Reply-To: <Pine.LNX.4.21.0102192051150.3008-100000@freak.distro.conectiva> <Pine.LNX.4.21.0102192302290.3338-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0102192302290.3338-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Mon, Feb 19, 2001 at 11:05:23PM -0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2001 at 11:05:23PM -0200, Marcelo Tosatti wrote:
> --- linux/mm/filemap.c.orig     Mon Feb 19 23:51:02 2001
> +++ linux/mm/filemap.c  Mon Feb 19 23:51:33 2001
> @@ -611,11 +611,11 @@
>  
>         add_wait_queue(&page->wait, &wait);
>         do {
> -               sync_page(page);
>                 set_task_state(tsk, TASK_UNINTERRUPTIBLE);
>                 if (!PageLocked(page))
>                         break;
> -               run_task_queue(&tq_disk);
> +
> +               sync_page(page);
>                 schedule();
>         } while (PageLocked(page));
>         tsk->state = TASK_RUNNING;
> @@ -633,10 +633,9 @@
>  
>         add_wait_queue_exclusive(&page->wait, &wait);
>         for (;;) {
> -               sync_page(page);
>                 set_task_state(tsk, TASK_UNINTERRUPTIBLE);
>                 if (PageLocked(page)) {
> -                       run_task_queue(&tq_disk);
> +                       sync_page(page);
>                         schedule();
>                         continue;
			  ^^^^^^^^
>                 }

Looks perfect. I'd also remove the `continue' from __lock_page, it's wake-one
so it should get the wakeup only when it's time to lock the page down.

Andrea
