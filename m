Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbVEAW4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbVEAW4R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 18:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbVEAW4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 18:56:17 -0400
Received: from fire.osdl.org ([65.172.181.4]:38095 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261297AbVEAW4M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 18:56:12 -0400
Date: Sun, 1 May 2005 15:55:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: stern@rowland.harvard.edu, arvidjaar@mail.ru,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] init 1 kill khubd on 2.6.11
Message-Id: <20050501155535.3855d31f.akpm@osdl.org>
In-Reply-To: <29495f1d050501154625ee7087@mail.gmail.com>
References: <200505012021.56649.arvidjaar@mail.ru>
	<Pine.LNX.4.44L0.0505011659130.19155-100000@netrider.rowland.org>
	<20050501153051.2471294e.akpm@osdl.org>
	<29495f1d050501154625ee7087@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nish Aravamudan <nish.aravamudan@gmail.com> wrote:
>
> > -       /* Send me a signal to get me die (for debugging) */
> >         do {
> >                 hub_events();
> > -               wait_event_interruptible(khubd_wait, !list_empty(&hub_event_list));
> > +               wait_event_interruptible(khubd_wait,
> > +                               !list_empty(&hub_event_list) ||
> > +                               kthread_should_stop());
> >                 try_to_freeze(PF_FREEZE);
> > -       } while (!signal_pending(current));
> > +       } while (!kthread_should_stop() || !list_empty(&hub_event_list));
> 
> Shouldn't this simply be a wait_event(), instead of
> wait_event_interruptible()?

That would cause uninterruptible sleep, which contributes to load average.

> Then the do-while() can be gotten rid of,
> as the only reason it is there currently, I guess, is to ignore
> signals?

Nope, the do-while is a basic part of the daemon's operation: keep doing
stuff until either there's no stuff to do or until we're told to exit.

> Also, the while's conditional should be (!kthread_should_stop() ||
> list_empty(&hub_event_list) to match the negation of wait_event's?
> (wait_event() expects the condition to stop on, while while() expects
> the condition to continue on)

Nope, the wait_event_interruptible test says

  "sleep unless the list is not empty or I am being asked to exit"

the while termination test says

  "loop until the list is empty and I am being asked to stop".

I think.  I had to scratch my head for a while over that code ;)
