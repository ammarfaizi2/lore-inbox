Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266012AbUFJEts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266012AbUFJEts (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 00:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266113AbUFJEtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 00:49:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45954 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266012AbUFJEtM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 00:49:12 -0400
Date: Thu, 10 Jun 2004 05:49:03 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
Cc: Al Viro <viro@math.psu.edu>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Finding user/kernel pointer bugs [no html]
Message-ID: <20040610044903.GE12308@parcelfarce.linux.theplanet.co.uk>
References: <1086838266.32059.320.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1086838266.32059.320.camel@dooby.cs.berkeley.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2004 at 08:31:02PM -0700, Robert T. Johnson wrote:
> Despite that, I found numerous bugs in seven drivers.  Only one of these
> drivers had any __user annotations, so sparse isn't able to provide any
> meaningful results on these source files yet.  Even worse, sparse missed

But it does - they _all_ tripped warnings in sparse exactly due to the lack
of __user.

As soon as you have get_user()/put_user()/copy_from_user()/copy_to_user()
applied to a pointer (or related pointer) - that's it, it will be caught.

What sparse does _NOT_ do is tainting analysis.  IOW, yes, you can get
a code that reads long from userland, casts it to pointer and dereferences
the damn thing directly.  

It's a different problem and a different class of bugs.  Note that casts
between userland and kernel pointers _do_ trip a warning, so we are really
talking about either a non-user pointer in structure copied from userland
(and for some reason not annotated, even though it is a part of userland
ABI) *or* direct cast from integer type.

These do happen, all right, but note that in all cases you've posted to
l-k sparse _does_ warn - either on the line in question or near it about
improper use of what it's told is a kernel pointer.

> bugs in drivers/usb/core/devio.c:proc_control() even though that
> function has been annotated (this is not the first time cqual has found
> bugs in code audited by sparse).   I didn't write any annotations in any

sparse gives warnings on lines 272, 293, 561, 581, 976, 979, 982, 989, 992.
293 is assignment in conditional.
561 and 581 are dereferencing userland pointers (proc_control())
976 -- 992 are in processcompl() - missing annotations; since ->userurb
is a void __user *, we should kill those casts and just do
	struct usbdevfs_urb __user *userurb = as->userurb;

and use
	if (put_user(urb->status, &userurb->status))
etc. instead of the current mess.

272 is interesting - it's in
static void async_completed(struct urb *urb, struct pt_regs *regs)
{
        struct async *as = (struct async *)urb->context;
        struct dev_state *ps = as->ps;
        struct siginfo sinfo;

        spin_lock(&ps->lock);
        list_move_tail(&as->asynclist, &ps->async_completed);
        spin_unlock(&ps->lock);
        if (as->signr) {
                sinfo.si_signo = as->signr;
                sinfo.si_errno = as->urb->status;
                sinfo.si_code = SI_ASYNCIO;
                sinfo.si_addr = (void *)as->userurb;
                send_sig_info(as->signr, &sinfo, as->task);
        }
        wake_up(&ps->wait);
}
and it brings two questions:
	a) shouldn't ->si_addr be a __user pointer (in all contexts I see
it is one)
	b) WTF is usb doing messing with it directly?
Note that drivers/usb/core/{devio,inode}.c are the only users of that animal
outside of arch/*.  Looks fishy...

> driver files -- just a few header files under include.  I've already
> submitted patches to fix these bugs.  This is 1 1/2 days work, with
> _very_ incomplete annotations.

> > the taint analysis is nowhere near "if it gives no warnings, we are
> > guaranteed to have no user/kernel pointer mixed".
> 
> I overstated this point.  Like sparse, cqual can be fooled by certain
> types of code:
>   - inline asm
>   - misuse of unions
>   - buffer overflows
>   - certain really nasty casts
>   - incomplete or incorrect annotations
>   - cqual may have implementation bugs, of course
> But besides these cases, it doesn't miss bugs.  It's just like the
> regular C type checker -- you can't trick it without doing something
> explicitly nasty.

You would be surprised at just what sorts of nasty some drivers are doing
(and that was a great source of amusement and triggering bugs in sparse).

> > The real questions are
> > 	a) how large subset of tree can $FOO survive?
> 
> In my experiment above, I did
>   $ make menuconfig # Turn on every driver and feature I could

make allmodconfig

sparse survives that if you turn CONFIG_SKFP off.

> > 	d) how fast $FOO is (it _is_ important, if you hope to get a decent
> > code coverage, especially on non-x86 platforms).
> 
> ~1 to 2 seconds per file.

Erm...  On what kind of box? ;-)

More interesting measurement is how much time out of the build is spend in
gcc and how much in your code.

> - no casts are needed to check this code.  This is important since casts
>   can prevent a bug-finding tool from finding real bugs.
 
Casts from numbers to pointers are needed anyway if you want cc(1) to eat
it; casts between userland and kernel pointers trigger a warning in sparse.
