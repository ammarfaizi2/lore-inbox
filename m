Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbVEBAmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbVEBAmQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 20:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261591AbVEBAmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 20:42:16 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:16476 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261582AbVEBAmM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 20:42:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KP0UddOiY3QPkTk0Y6p9Qjd2mnLj1E761UAhpivP/O7TwQKc+tSpQUhP4jAzvrtzE0SAN4SocF+VkWJDI2gTwlq1LqW4zuTryzGVrFG/1ePCc/HmEBQZ8thNpnZlBnaHLya+Bj3PwX7KVlsXSTkXd0gPcXNVvAgJqjlOii20pHQ=
Message-ID: <29495f1d050501174225504b72@mail.gmail.com>
Date: Sun, 1 May 2005 17:42:12 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [linux-usb-devel] init 1 kill khubd on 2.6.11
Cc: stern@rowland.harvard.edu, arvidjaar@mail.ru,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20050501155535.3855d31f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200505012021.56649.arvidjaar@mail.ru>
	 <Pine.LNX.4.44L0.0505011659130.19155-100000@netrider.rowland.org>
	 <20050501153051.2471294e.akpm@osdl.org>
	 <29495f1d050501154625ee7087@mail.gmail.com>
	 <20050501155535.3855d31f.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/1/05, Andrew Morton <akpm@osdl.org> wrote:
> Nish Aravamudan <nish.aravamudan@gmail.com> wrote:
> >
> > > -       /* Send me a signal to get me die (for debugging) */
> > >         do {
> > >                 hub_events();
> > > -               wait_event_interruptible(khubd_wait, !list_empty(&hub_event_list));
> > > +               wait_event_interruptible(khubd_wait,
> > > +                               !list_empty(&hub_event_list) ||
> > > +                               kthread_should_stop());
> > >                 try_to_freeze(PF_FREEZE);
> > > -       } while (!signal_pending(current));
> > > +       } while (!kthread_should_stop() || !list_empty(&hub_event_list));
> >
> > Shouldn't this simply be a wait_event(), instead of
> > wait_event_interruptible()?
> 
> That would cause uninterruptible sleep, which contributes to load average.

True, and this is the argument I face(d) with a lot of the msleep()
changes I made. I guess I would like a comment for this case, where
we're using wait_event_interruptible(), but actually are ignoring the
signals that might make us return early.
 
> > Then the do-while() can be gotten rid of,
> > as the only reason it is there currently, I guess, is to ignore
> > signals?
> 
> Nope, the do-while is a basic part of the daemon's operation: keep doing
> stuff until either there's no stuff to do or until we're told to exit.

I see that now, thanks.

> > Also, the while's conditional should be (!kthread_should_stop() ||
> > list_empty(&hub_event_list) to match the negation of wait_event's?
> > (wait_event() expects the condition to stop on, while while() expects
> > the condition to continue on)
> 
> Nope, the wait_event_interruptible test says
> 
>   "sleep unless the list is not empty or I am being asked to exit"
> 
> the while termination test says
> 
>   "loop until the list is empty and I am being asked to stop".
> 
> I think.  I had to scratch my head for a while over that code ;)

You're right again -- sorry for the noise, I must have been reading it
wrong. Rewriting it as !(kthread_should_stop() &&
list_empty(&hub_event_list)) helped me :)

Thanks!
Nish
