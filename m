Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751245AbVKWRP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbVKWRP0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 12:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbVKWRP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 12:15:26 -0500
Received: from styx.suse.cz ([82.119.242.94]:8395 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1751245AbVKWRPZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 12:15:25 -0500
Date: Wed, 23 Nov 2005 18:15:23 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Marc Koschewski <marc@osknowledge.org>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>, rmk+lkml@arm.linux.org.uk
Subject: Re: Christmas list for the kernel
Message-ID: <20051123171523.GA3528@ucw.cz>
References: <9e4733910511221313t4a1e3c67wc7b08160937eb5c5@mail.gmail.com> <20051123121726.GA7328@ucw.cz> <9e4733910511230643j64922738p709fecd6c86b4a95@mail.gmail.com> <20051123150349.GA15449@flint.arm.linux.org.uk> <9e4733910511230712y2b394851rc17fa71c6f9c6ecf@mail.gmail.com> <20051123155650.GB6970@stiffy.osknowledge.org> <20051123160520.GH15449@flint.arm.linux.org.uk> <9e4733910511230837v1519d3b3t28176b1fd6017ffc@mail.gmail.com> <20051123164907.GA2981@ucw.cz> <9e4733910511230859y3879e65fp927a7aa4d71d8fee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910511230859y3879e65fp927a7aa4d71d8fee@mail.gmail.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 11:59:27AM -0500, Jon Smirl wrote:
> On 11/23/05, Vojtech Pavlik <vojtech@suse.cz> wrote:
> > On Wed, Nov 23, 2005 at 11:37:23AM -0500, Jon Smirl wrote:
> >
> > > Before everyone gets excited, I realize that all of this has
> > > historical implications. But that doesn't mean we can't discuss
> > > possible future alternative solutions.
> > >
> > > Thinking about this for a while it seems to me that the problem is
> > > that the various apps (init, syslog) etc should not have a tty name as
> > > part of their command line parameters. Instead these apps could use
> > > ptys instead. Ptys would solve all of the race problems too.
> > >
> > > Is there any good reason (other than history) for using a device node
> > > name (tty0, etc) instead of some other naming scheme if names are
> > > needed at all?
> > >
> > > If init, syslog, etc can be converted to ptys, do we need ttys? Xterms
> > > use ptys I don't notice that they aren't connect to a fix tty name.
> > > The virtual consoles would still be 0,1,2 but do they have to be
> > > hooked to tty0, 1, 2 instead of a pty?
> >
> > The basic difference between a pty and tty is that a pty connects to a
> > program (that created it by opening the ptmx node, for example xterm or
> > ssh) on the other end, while a tty connects to the kernel doing all the
> > character drawing in the framebuffer.
> >
> > You can't easily use one instead of the other, they're very different
> > beasts.
> >
> > Of course, a way to use a pty would be to have the console
> > implementation in userspace.
> >
> > The fact that no program is on the other end of a tty is also the reason
> > why they cannot be created dynamically like ptys, there is noone to open
> > a "ttmx" to create the ttys.
> >
> > Hence, the device nodes are pre-created by the kernel, while the real
> > devices are only created on open.
> 
> I forgot about the kernel vs user space termination issue.
> 
> One solution would be to not create the tty nodes and instead modify
> init, syslog to mknod the node before using it.

You'd have to add special treatment to quite a number of programs (all
the different *getty programs, for example), for what benefit? A
slightly cleaner /dev?

> Another would be to have a little user space daemon that listened to
> the pty creation, and then mknod the tty nodes as need and pipe the
> data through.

While we in theory could have hotplug events for pty creation, this is
not a working approach, since it tries to work from the wrong side.

A pty is created when ptmx is opened (by libc). You need to pass a
tty/pty device node to syslog/getty/whatever, and not ptmx.

The daemon would be in the same situation the kernel is now - it would
have to divine when an application will be trying to open a non-existent
device node and create it juste before that.

> That would be a first step to moving to a user space
> console implementation.

No. You don't need all that for a user space console. Xterm works today.
Just specify in a config file for the userspace console which pty VT's
should it create and which programs to pass them to.

> I see now that the 64 tty devices really are there and are provided by
> the kernel. It's just that hardly anyone uses all of them and they
> clutter up /dev.
 
True. It's a tradeoff.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
