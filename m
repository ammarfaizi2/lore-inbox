Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264412AbUFJFU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264412AbUFJFU6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 01:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265972AbUFJFU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 01:20:58 -0400
Received: from relay2.EECS.Berkeley.EDU ([169.229.60.28]:45477 "EHLO
	relay2.EECS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S264412AbUFJFUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 01:20:53 -0400
Subject: Re: Finding user/kernel pointer bugs [no html]
From: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040610044903.GE12308@parcelfarce.linux.theplanet.co.uk>
References: <1086838266.32059.320.camel@dooby.cs.berkeley.edu> 
	<20040610044903.GE12308@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 09 Jun 2004 22:20:51 -0700
Message-Id: <1086844851.32052.411.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-09 at 21:49, viro@parcelfarce.linux.theplanet.co.uk
wrote:
> On Wed, Jun 09, 2004 at 08:31:02PM -0700, Robert T. Johnson wrote:
> > Despite that, I found numerous bugs in seven drivers.  Only one of these
> > drivers had any __user annotations, so sparse isn't able to provide any
> > meaningful results on these source files yet.  Even worse, sparse missed
> 
> But it does - they _all_ tripped warnings in sparse exactly due to the lack
> of __user.

Yeah, Linus pointed this stuff out.  Sorry for my mistake.

> It's a different problem and a different class of bugs.  Note that casts
> between userland and kernel pointers _do_ trip a warning, so we are really

I'm very glad to hear that.  Casting between __user and __kernel is one
of my main concerns about sparse giving a false sense of security.  Now
I can stop worrying.

> talking about either a non-user pointer in structure copied from userland
> (and for some reason not annotated, even though it is a part of userland
> ABI) *or* direct cast from integer type.

I just mentioned this scenario in my mail to Linus...

> 272 is interesting - it's in
> static void async_completed(struct urb *urb, struct pt_regs *regs)
> {
>         struct async *as = (struct async *)urb->context;
>         struct dev_state *ps = as->ps;
>         struct siginfo sinfo;
> 
>         spin_lock(&ps->lock);
>         list_move_tail(&as->asynclist, &ps->async_completed);
>         spin_unlock(&ps->lock);
>         if (as->signr) {
>                 sinfo.si_signo = as->signr;
>                 sinfo.si_errno = as->urb->status;
>                 sinfo.si_code = SI_ASYNCIO;
>                 sinfo.si_addr = (void *)as->userurb;
>                 send_sig_info(as->signr, &sinfo, as->task);
>         }
>         wake_up(&ps->wait);
> }
> and it brings two questions:
> 	a) shouldn't ->si_addr be a __user pointer (in all contexts I see
> it is one)
> 	b) WTF is usb doing messing with it directly?
> Note that drivers/usb/core/{devio,inode}.c are the only users of that animal
> outside of arch/*.  Looks fishy...

Looks right. PATCH:

--- linux-2.6.7-rc3-full/include/asm-generic/siginfo.h.orig	Wed Jun  9 22:09:49 2004
+++ linux-2.6.7-rc3-full/include/asm-generic/siginfo.h	Wed Jun  9 22:09:52 2004
@@ -78,7 +78,7 @@ typedef struct siginfo {
 
 		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
 		struct {
-			void *_addr; /* faulting insn/memory ref. */
+			void __user *_addr; /* faulting insn/memory ref. */
 #ifdef __ARCH_SI_TRAPNO
 			int _trapno;	/* TRAP # which caused the signal */
 #endif


> > In my experiment above, I did
> >   $ make menuconfig # Turn on every driver and feature I could
> 
> make allmodconfig

Thanks!

> > > 	d) how fast $FOO is (it _is_ important, if you hope to get a decent
> > > code coverage, especially on non-x86 platforms).
> > 
> > ~1 to 2 seconds per file.
> 
> Erm...  On what kind of box? ;-)

1GHz Pentium III.

> More interesting measurement is how much time out of the build is spend in
> gcc and how much in your code.

Rough estimate: 66% - 80% of time is cqual. I just did a quick
experiment that came out about 68%.  So it takes about 3-4x as long as
it takes to just build.

Best,
Rob


