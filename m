Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129926AbRBYHr3>; Sun, 25 Feb 2001 02:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129927AbRBYHrT>; Sun, 25 Feb 2001 02:47:19 -0500
Received: from mx.interplus.ro ([193.231.252.3]:61190 "EHLO mx.interplus.ro")
	by vger.kernel.org with ESMTP id <S129926AbRBYHrE>;
	Sun, 25 Feb 2001 02:47:04 -0500
Message-ID: <3A98B8D7.3F456784@interplus.ro>
Date: Sun, 25 Feb 2001 09:48:39 +0200
From: Mircea Ciocan <mirceac@interplus.ro>
Organization: Home Office
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-ac3 i686)
X-Accept-Language: ro, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: lk <linux-kernel@vger.kernel.org>
Subject: Re: 242-ac3 loop bug
In-Reply-To: <20010224173234.14673.qmail@web1301.mail.yahoo.com> <20010225001427.B420@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Halleluiah ;)!!!

	Finally, it works as is suposed to do :)))), the load on my dual
PIIIx950 is 0.01 three times and I can mount and umonunt ISOs as much I
wish.
	Thank you very much Jens and all that provided usefull feedback, this
patch alone deserves including in an .acX release.
	And Jens if you ever come to Romania give me a call I owe you a lot of
beers and pizzas :).

		Mircea "happy, happy, joy, joy...;)" C.



Jens Axboe wrote:
> 
> On Sat, Feb 24 2001, Mark Swanson wrote:
> > First, good job on the loop device. It's rock stable for me - except
> 
> thanks, glad to hear it.
> 
> > when I try to load the blowfish module which oops the kernel and
> > crashes the loop device:-) No problem, I just use another cipher.
> 
> cipher bug or? never the less, could you ksymoops that and send
> it along?
> 
> > The bug I'm reporting is that when a loop device is in use the load of
> > the machine stays at 1.00 even though nothing is happening. If I umount
> > the loop filesystem the load goes down to 0.00.
> >
> > > ps -aux | grep loop
> > 1674 tty1     DW<   0:00 [loop0]
> >
> > The system is doing nothing to the loop filesystem.
> > Strange that the process isn't logging any cpu usage time. It's
> > definately responsible for the 1.00 load.
> 
> Oops, this slipped by me. Patch should fix it.
> 
> --
> Jens Axboe
> 
>   ------------------------------------------------------------------------
> --- drivers/block/loop.c~       Sat Feb 24 23:08:38 2001
> +++ drivers/block/loop.c        Sat Feb 24 23:11:13 2001
> @@ -507,7 +507,7 @@
>         sprintf(current->comm, "loop%d", lo->lo_number);
> 
>         spin_lock_irq(&current->sigmask_lock);
> -       siginitsetinv(&current->blocked, sigmask(SIGKILL));
> +       sigfillset(&current->blocked);
>         flush_signals(current);
>         spin_unlock_irq(&current->sigmask_lock);
> 
> @@ -525,7 +525,7 @@
>         up(&lo->lo_sem);
> 
>         for (;;) {
> -               down(&lo->lo_bh_mutex);
> +               down_interruptible(&lo->lo_bh_mutex);
>                 if (!atomic_read(&lo->lo_pending))
>                         break;
>
