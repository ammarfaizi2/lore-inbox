Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965313AbWFAVVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965313AbWFAVVe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 17:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965314AbWFAVVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 17:21:33 -0400
Received: from nz-out-0102.google.com ([64.233.162.195]:63547 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965313AbWFAVVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 17:21:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UBOI/2/IwGdi/sJ1NP4zhb6spaaQ7YYzzoo/F3r7vkuri6qdJYRZuwes8bXCixD7Wdaa6cMMaerGZYjx7LP3jWziwxCC7rssrjem2MuaGa66iXL0a7INtx0yRiv/+5HJP7XmYfmGtVUKsy5LCqhFAcNKsK7+GWoICrNXjpgurrk=
Message-ID: <9e4733910606011421o4334642bh11dd568b3399fcc2@mail.gmail.com>
Date: Thu, 1 Jun 2006 17:21:21 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "D. Hazelton" <dhazelton@enter.net>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "David Lang" <dlang@digitalinsight.com>,
       "Ondrej Zajicek" <santiago@mail.cz>, "Dave Airlie" <airlied@gmail.com>,
       "Pavel Machek" <pavel@ucw.cz>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, adaplas@gmail.com
In-Reply-To: <200606011647.43427.dhazelton@enter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <200606011603.57421.dhazelton@enter.net>
	 <9e4733910606011335q5791997drc02d23f398a2acf5@mail.gmail.com>
	 <200606011647.43427.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/06, D. Hazelton <dhazelton@enter.net> wrote:
> On Thursday 01 June 2006 20:35, Jon Smirl wrote:
> > On 6/1/06, D. Hazelton <dhazelton@enter.net> wrote:
> > > > > 5) The system needs to be robust. Daemons can be killed by the OOM
> > > > > mechanism, you don't want to lose your console in the middle of
> > > > > trying to fix a problem. This also means that you have to be able to
> > > > > display printk's from inside interrupt handles.
> > >
> > > Point of disagreement. Tons of userspace helpers isn't a good choice.
> >
> > Where do you get 'tons'? There will probably be one for initial reset,
> > one for VESA based mode setting and a few more if there is device
> > specific code needed for a specific card.
> >
> > Making console rely on a permanent daemon that is subject to getting
> > killed by the OOM mechanism is not a workable solution.
> >
> > You also need to think about how cursors are handled. A non-root app
> > needs to be able to move the cursor. Actually moving the cursor
> > requires root. The in-kernel console system needs a cursor. It would
> > be much better if cursor control was implemented in the device
> > drivers.
>
> Yes, the basic console will only require a few helpers. I get "tons" because
> that's what it would take to provide all the acceleration features to
> userspace. The daemon is *only* there to provide those acceleration features.
> The kernel itself has it's own minimal interface to drmcon that lets it work
> without userspace. The userspace side is for userspace. (Though the kernel
> will only work in a specific set mode without the userspace helpers for
> setting the mode)

You don't need a ton of helpers for acceleration, Mesa already supports this.

Handling accelerated console is discussed in my paper, but here are
the highlights.

If you examine console you will see that there are two kinds of users,
normal people running emacs/etc and system management needs like
panics and single user mode. Normal users want acceleration, system
management needs absolute robustness. Currently these two uses are
mixed up into a single console,. I think they should be separated
since they clearly have different requirements.

One solution to this split is to build the system management console
in-kernel using the existing fbdev code. A hot key can be used to
access it or it will appear automatically on a panic. The system
management console does not need acceleration, but it always has to
work and work in any context (like interrupt context). Working in any
context forces an implementation that is entirely contained in the
kernel.

For a normal user's accelerated console, build one in user space, use
Mesa or whatever. I'm not going to start a debate on this point. Once
you are in user space you can add Asian language support too.

For people that refuse to use the user space console they can use the
system management mode. If you really want to accelerate this console
you will have to add entry points to the DRM driver; the
implementation of the system management console has to stay entirely
inside the kernel. Since there is only going to be one set of
acceleration code, the entry points have to go in the DRM driver. I
would not recommend doing this because it won't be safe to use the
acceleration hardware in all cases where the system management console
may need to print.

If people are going to whine about the size of Mesa they can implement
OpenGL/ES on top of DRM. Since there is a commercial OpenGL/ES
implementation that is 100K it is proven that this can be done with a
tiny library. All that has to happen is for someone to write the
library. If you really want to whine build a 2D only library on top of
DRM.

Since the system management console can pop up at anytime and in the
context of an unstable system, I really think it should be designed to
use the currently active mode instead of trying to change the mode.
Changing the mode may require a trip to user space and user space may
be dead. The fbdev code already knows how to draw into any framebuffer
format from kernel context.

-- 
Jon Smirl
jonsmirl@gmail.com
