Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262974AbUEBMBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262974AbUEBMBZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 08:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbUEBMBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 08:01:25 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:16771 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S262974AbUEBMBU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 08:01:20 -0400
Date: Sun, 2 May 2004 14:01:05 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Andrew Morton <akpm@osdl.org>, cw@f00f.org, koke@amedias.org,
       linux-kernel@vger.kernel.org
Subject: Re: strange delays on console logouts (tty != 1)
Message-ID: <20040502120105.GA20038@vana.vc.cvut.cz>
References: <20040430195351.GA1837@amedias.org> <20040501214617.GA6446@taniwha.stupidest.org> <20040501232448.GA4707@vana.vc.cvut.cz> <20040501180347.31f85764.akpm@osdl.org> <20040502090059.A9605@flint.arm.linux.org.uk> <20040502011337.2b0b3ca3.akpm@osdl.org> <20040502091751.B9605@flint.arm.linux.org.uk> <20040502103721.C9605@flint.arm.linux.org.uk> <20040502111729.D9605@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040502111729.D9605@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 02, 2004 at 11:17:29AM +0100, Russell King wrote:
> On Sun, May 02, 2004 at 10:37:21AM +0100, Russell King wrote:
> > On Sun, May 02, 2004 at 09:17:51AM +0100, Russell King wrote:
> > > > If so, how is tty_hangup() getting involved?
> > > 
> > > The only way it could be invoked is via SAK, which obviously isn't
> > > happening here.
> > > 
> > > However, login _does_ call sys_vhangup() which in turn calls tty_vhangup()
> > > so I suspect that the statement "tty hangup is scheduled for work_queue"
> > > is based on the _assumption_ that sys_vhangup() calls tty_hangup()
> > > rather than the function it actually does.
> > 
> > Ok, the VT_OPENQRY crap is a debian modification to agetty.  As far as
> > I can see, there is no code in agetty which calls sys_vhangup().
> 
> And a further follow-up...

Yes, I was wrong. It was not race with descriptor closing. It was my looking
at agetty which broke things: if you do not watch logout, login prompt
will come up immediately.

Problem is even more stupid: agetty will not come up while you are watching
that terminal. It opens /dev/console so it has some handle on which it
can issue VT_OPENQRY, but if you have /dev/console configured to use just
currently visible tty, it finds itself using that tty (daca4000 is tty3's
tty and da9c4000 is tty2's tty).

Another problem with this is that some daemons do not detach from tty you
start them on - currently vmnet-natd is one I catched (but it was first
daemon I looked at, so there can be other too). So when you do
'/etc/init.d/vmware restart' on some tty, that tty will not come back after
logout until you'll kill vmnet-natd (I'll fix that ASAP).

And third problem is that agetty's loop around VT_OPENQRY has small problem:
When agetty finds that some tty below one it needs is not opened, it opens it.
Later it finds that tty it wants is busy - so it calls error(), but without
closing lower ttys, which are now kept opened during 10 seconds timeout in
agetty's error(). This effectively blocks all lower-numbered agettys from
their terminals until this one succeeds (or until it is stopped by init).

					Best regards,
						Petr Vandrovec
 
/* Watch TTY3 */

init(3062): Opening tty daca4000, use count 1
getty(3062): Opening tty daca4000, use count 2
getty(3062): VT_OPENQRY issued, returning 11
getty(3062): Releasing tty daca4000, use count 2
Call Trace:
 [<c01fe46b>] con_close+0x51/0xce
 [<c01ed85d>] release_dev+0x670/0x684
 [<c0150331>] unmap_page_range+0x3d/0x63
 [<c0165171>] filp_dtor+0x0/0x158
 [<c0155a93>] exit_mmap+0x1d2/0x27f
 [<c01edcef>] tty_release+0x7/0xa
 [<c016550b>] __fput+0xc8/0xd9
 [<c0163c97>] filp_close+0x4f/0x7a
 [<c0121eda>] put_files_struct+0x7c/0xd0
 [<c0123065>] do_exit+0x27a/0x871
 [<c01236e1>] do_group_exit+0x3a/0x1e0
 [<c0129821>] sys_nanosleep+0xa3/0x11d
 [<c0104567>] syscall_call+0x7/0xb

getty(3062): Releasing tty daca4000, use count 1
Call Trace:
 [<c01fe46b>] con_close+0x51/0xce
 [<c01ed85d>] release_dev+0x670/0x684
 [<c0150331>] unmap_page_range+0x3d/0x63
 [<c0165171>] filp_dtor+0x0/0x158
 [<c017dcef>] dput+0x1b/0x5ef
 [<c0155a93>] exit_mmap+0x1d2/0x27f
 [<c01654cc>] __fput+0x89/0xd9
 [<c01edcef>] tty_release+0x7/0xa
 [<c016550b>] __fput+0xc8/0xd9
 [<c0163c97>] filp_close+0x4f/0x7a
 [<c0121eda>] put_files_struct+0x7c/0xd0
 [<c0123065>] do_exit+0x27a/0x871
 [<c01236e1>] do_group_exit+0x3a/0x1e0
 [<c0129821>] sys_nanosleep+0xa3/0x11d
 [<c0104567>] syscall_call+0x7/0xb

/* 10sec delay in agetty, switch to TTY2 */

init(3067): Opening tty da9c4000, use count 2
getty(3067): Opening tty da9c4000, use count 3
getty(3067): VT_OPENQRY issued, returning 3
getty(3067): Releasing tty da9c4000, use count 3
Call Trace:
 [<c01fe46b>] con_close+0x51/0xce
 [<c01ed85d>] release_dev+0x670/0x684
 [<c0174d5a>] permission+0x36/0x38
 [<c016531e>] get_empty_filp+0x55/0xc1
 [<c0119e29>] recalc_task_prio+0x8c/0x19e
 [<c02f7bf2>] schedule+0x356/0x6c6
 [<c01edcef>] tty_release+0x7/0xa
 [<c016550b>] __fput+0xc8/0xd9
 [<c0163c97>] filp_close+0x4f/0x7a
 [<c0104567>] syscall_call+0x7/0xb

getty(3067): Releasing tty da9c4000, use count 2
Call Trace:
 [<c01fe46b>] con_close+0x51/0xce
 [<c01ed85d>] release_dev+0x670/0x684
 [<c0174d5a>] permission+0x36/0x38
 [<c0119e29>] recalc_task_prio+0x8c/0x19e
 [<c02f7bf2>] schedule+0x356/0x6c6
 [<c017dcef>] dput+0x1b/0x5ef
 [<c01654cc>] __fput+0x89/0xd9
 [<c01edcef>] tty_release+0x7/0xa
 [<c016550b>] __fput+0xc8/0xd9
 [<c0163c97>] filp_close+0x4f/0x7a
 [<c0104567>] syscall_call+0x7/0xb

getty(3067): Opening tty daca4000, use count 1

/* Voila, agetty on tty3 came up */


