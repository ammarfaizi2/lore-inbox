Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130783AbQLJNl1>; Sun, 10 Dec 2000 08:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130984AbQLJNlS>; Sun, 10 Dec 2000 08:41:18 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:39903 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130783AbQLJNlL>; Sun, 10 Dec 2000 08:41:11 -0500
Message-ID: <3A3381BA.E93E025E@uow.edu.au>
Date: Mon, 11 Dec 2000 00:14:34 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: lkml <linux-kernel@vger.kernel.org>, linux-usb-devel@lists.sourceforge.net,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] hotplug fixes
In-Reply-To: <3A337727.FDED61E3@uow.edu.au> <Pine.LNX.4.30.0012101238120.25294-100000@imladris.demon.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> 
> On Sun, 10 Dec 2000, Andrew Morton wrote:
> 
> > - PCMCIA layer calls call_usermodehelper from within keventd.  But
> >   call_usermodehelper blocks until keventd has run the helper! Duh.
> >
> >   This patch special-cases the situation where keventd is calling
> >   call_usermodehelper().
> 
> +       if (current_is_keventd()) {
> +               /* We can't wait on keventd! */
> +               __call_usermodehelper(&sub_info);
> +       } else {
> +               schedule_task(&tqs);
> +               down(&sem);             /* Wait until keventd has started the subprocess */
> +       }
> 
> That's sick. Do we have to? The PCMCIA coded obviously wants an async
> call_usermodehelper() or it wouldn't have been using schedule_task()
> for it in the first place, would it? Can't we pass an 'int async' arg to
> call_usermodehelper() instead of doing it this way?

Well,  call_usermodehelper here _is_ async.  We're just waiting for
acknowledgement that the subprocess has safely taken copies of
our local data (argv, envp, etc).  And waiting to pick up the
return value from execve().

We can't call schedule_task() and then just return from
call_usermodehelper(), unless we take kmalloced copies of
everything (including the tq_struct) and then free them
after the vfork.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
