Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274793AbRIVB1E>; Fri, 21 Sep 2001 21:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274885AbRIVB04>; Fri, 21 Sep 2001 21:26:56 -0400
Received: from air-1.osdlab.org ([65.201.151.5]:5395 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S274793AbRIVB0h>;
	Fri, 21 Sep 2001 21:26:37 -0400
Message-ID: <3BABE86D.BA07774B@osdlab.org>
Date: Fri, 21 Sep 2001 18:25:01 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Crutcher Dunnavant <crutcher@datastacks.com>
CC: lkml <linux-kernel@vger.kernel.org>, Alan <alan@lxorguk.ukuu.org.uk>,
        Linus <torvalds@transmeta.com>
Subject: Re: [PATCH] Magic SysRq loglevel fix.
In-Reply-To: <3BA8C01D.79FBD7C3@osdlab.org> <20010921170828.J8188@mueller.datastacks.com> <20010921174123.K8188@mueller.datastacks.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Crutcher Dunnavant wrote:
> 
> Attached is a fix for this part of the sysrq code.
> 
> ++ 21/09/01 17:08 -0400 - Crutcher Dunnavant:
> > ++ 19/09/01 08:56 -0700 - Randy.Dunlap:
> > > It always sets console_loglevel and then restores
> > > console_loglevel from orig_log_level, so Alt+SysRq+#
> > > handling is severely broken.
> > >
> > > If someone (Crutcher ?) wants to patch it, that's fine.
> > > If I patched it, I would just add a
> > >   next_loglevel = -1;
> > > at the beginning of __handle_sysrq_nolock() and then
> > > let the loglevel handler(s) set next_loglevel.
> > > If next_loglevel != -1 at the end of __handle_sysrq_nolock(),
> > > set console_loglevel to next_loglevel.
> >
> > I'm looking real close at this right now, and there are a couple of
> > problems, and a simple, but ugly solution.
> >
> > The entire reason that console_loglevel is touched _after_ the call to
> > the second level handler is actually for the loglevel handler's
> > printout. I was trying to minimize change in the display, but horked it.
> >
> > Here is the problem.
> >
> > SysRq events use action messages which get printed by the top level
> > handler before calling the second level handler, the call line is:
> >
> >         orig_log_level = console_loglevel;
> >         console_loglevel = 7;
> >         printk(KERN_INFO "SysRq : ");
> >
> >         op_p = __sysrq_get_key_op(key);
> >       ...
> >         printk ("%s", op_p->action_msg);
> >         op_p->handler(key, pt_regs, kbd, tty);
> >       ...
> >         console_loglevel = orig_log_level;
> >
> >
> > The killer here is the fact that the action message format string does
> > not carry a newline, allowing people to register strings which leave the
> > printk state open. The loglevel handler then fills in the loglevel, and
> > closes the printk state.

/me switches to a decent keyboard to test with.

No, the killer is that console_loglevel is restored from
orig_log_level after having been modified in the loglevel
handler.

> > There was a time when I thought that was a good idea.
> >
> > Go ahead, laugh.

Nah, I don't want to laugh at it.  More like cry at it.
It's set me back from other work by too many hours already.

> > Anyway, that sort of unresolved state is bad, and is the source of all
> > of this song and dance. I think the right answer is to force handlers to
> > open their own calls to printk, and to keep whats going on with the
> > console_loglevel and printk buffer nice and clean.
> >
> > The cost is that messages like this:
> >
> > SysRq : Loglevel switched to X
> >
> > will have to become more like this:
> >
> > SysRq : Loglevel
> > Loglevel switched to X

Yes, that's ugly and shouldn't be done.

I made an OK state machine (previous and next states) of it.
Your patch moves restoring console_loglevel to a place
that makes sense.

Bottom line:  I don't care which code goes into the sysrq.c,
but I hope that you (and others) learn to do some basic testing
before unleashing it.  I don't expect all Linux kernel code
to be thoroughly tested before it is added to a kernel,
especially for areas like VM and file systems.
But some basic level of testing should have been done on it,
and I can't tell that it was done.

There is still room for some more/small improvements here.  Nothing
earth-shattering.  For example, go_sync() and do_emergency_sync()
don't need to save console_loglevel or set it to 7 (they have both
already been done in __handle_sysrq_nolock()).
My patch eliminated this cruft.

~Randy
