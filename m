Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273609AbRIVFQp>; Sat, 22 Sep 2001 01:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273619AbRIVFQf>; Sat, 22 Sep 2001 01:16:35 -0400
Received: from mueller.uncooperative.org ([216.254.102.19]:22030 "EHLO
	mueller.datastacks.com") by vger.kernel.org with ESMTP
	id <S273609AbRIVFQR>; Sat, 22 Sep 2001 01:16:17 -0400
Date: Sat, 22 Sep 2001 01:16:39 -0400
From: Crutcher Dunnavant <crutcher@datastacks.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Magic SysRq loglevel fix.
Message-ID: <20010922011639.A9352@mueller.datastacks.com>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3BA8C01D.79FBD7C3@osdlab.org> <20010921170828.J8188@mueller.datastacks.com> <20010921174123.K8188@mueller.datastacks.com> <3BABE86D.BA07774B@osdlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BABE86D.BA07774B@osdlab.org>; from rddunlap@osdlab.org on Fri, Sep 21, 2001 at 06:25:01PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

++ 21/09/01 18:25 -0700 - Randy.Dunlap:
> Crutcher Dunnavant wrote:
> > 
> > Attached is a fix for this part of the sysrq code.
> > 
> > ++ 21/09/01 17:08 -0400 - Crutcher Dunnavant:
> > > ++ 19/09/01 08:56 -0700 - Randy.Dunlap:
> > > > It always sets console_loglevel and then restores
> > > > console_loglevel from orig_log_level, so Alt+SysRq+#
> > > > handling is severely broken.
> > > >
> > > > If someone (Crutcher ?) wants to patch it, that's fine.
> > > > If I patched it, I would just add a
> > > >   next_loglevel = -1;
> > > > at the beginning of __handle_sysrq_nolock() and then
> > > > let the loglevel handler(s) set next_loglevel.
> > > > If next_loglevel != -1 at the end of __handle_sysrq_nolock(),
> > > > set console_loglevel to next_loglevel.
> > >
> > > I'm looking real close at this right now, and there are a couple of
> > > problems, and a simple, but ugly solution.
> > >
> > > The entire reason that console_loglevel is touched _after_ the call to
> > > the second level handler is actually for the loglevel handler's
> > > printout. I was trying to minimize change in the display, but horked it.
> > >
> > > Here is the problem.
> > >
> > > SysRq events use action messages which get printed by the top level
> > > handler before calling the second level handler, the call line is:
> > >
> > >         orig_log_level = console_loglevel;
> > >         console_loglevel = 7;
> > >         printk(KERN_INFO "SysRq : ");
> > >
> > >         op_p = __sysrq_get_key_op(key);
> > >       ...
> > >         printk ("%s", op_p->action_msg);
> > >         op_p->handler(key, pt_regs, kbd, tty);
> > >       ...
> > >         console_loglevel = orig_log_level;
> > >
> > >
> > > The killer here is the fact that the action message format string does
> > > not carry a newline, allowing people to register strings which leave the
> > > printk state open. The loglevel handler then fills in the loglevel, and
> > > closes the printk state.
> 
> /me switches to a decent keyboard to test with.
> 
> No, the killer is that console_loglevel is restored from
> orig_log_level after having been modified in the loglevel
> handler.

But the _reason_ is that the action message does not carry a new line.


> Bottom line:  I don't care which code goes into the sysrq.c,
> but I hope that you (and others) learn to do some basic testing
> before unleashing it.  I don't expect all Linux kernel code
> to be thoroughly tested before it is added to a kernel,
> especially for areas like VM and file systems.
> But some basic level of testing should have been done on it,
> and I can't tell that it was done.

A whole lot of basic testing was done. The locking and the tables and
the registration all work correctly. I screwed up the loglevel stuff,
and it took 6 months for anyone to notice. Some people think that the
registration functions should be valid to call even when
CONFIG_MAGIC_SYSRQ is not defined, but this is a style thing.

Waving your hands and saying "Why wasn't this tested!!!" over and over
is annoying, and doesn't accomplish anything.

> There is still room for some more/small improvements here.  Nothing
> earth-shattering.  For example, go_sync() and do_emergency_sync()
> don't need to save console_loglevel or set it to 7 (they have both
> already been done in __handle_sysrq_nolock()).
> My patch eliminated this cruft.

No. go_sync() and do_emergency_sync() should NOT make assumptions about
the nature of console_loglevel, they should behave as they have been.
The commingling of loglevel settings was wrong in the first place.

-- 
Crutcher        <crutcher@datastacks.com>
GCS d--- s+:>+:- a-- C++++$ UL++++$ L+++$>++++ !E PS+++ PE Y+ PGP+>++++
    R-(+++) !tv(+++) b+(++++) G+ e>++++ h+>++ r* y+>*$
