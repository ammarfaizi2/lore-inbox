Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbUFJRA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbUFJRA3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 13:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbUFJRA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 13:00:29 -0400
Received: from mail.kroah.org ([65.200.24.183]:52716 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262062AbUFJRAV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 13:00:21 -0400
Date: Thu, 10 Jun 2004 09:58:21 -0700
From: Greg KH <greg@kroah.com>
To: viro@parcelfarce.linux.theplanet.co.uk,
       David Brownell <david-b@pacbell.net>
Cc: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>,
       Al Viro <viro@math.psu.edu>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Finding user/kernel pointer bugs [no html]
Message-ID: <20040610165821.GB32577@kroah.com>
References: <1086838266.32059.320.camel@dooby.cs.berkeley.edu> <20040610044903.GE12308@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040610044903.GE12308@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2004 at 05:49:03AM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> > bugs in drivers/usb/core/devio.c:proc_control() even though that
> > function has been annotated (this is not the first time cqual has found
> > bugs in code audited by sparse).   I didn't write any annotations in any
> 
> sparse gives warnings on lines 272, 293, 561, 581, 976, 979, 982, 989, 992.

Ick, sorry, I haven't run sparse on the usb tree in a while, I'll do
that today and fix it all up.

> 293 is assignment in conditional.

Now fixed.

> 561 and 581 are dereferencing userland pointers (proc_control())

Now fixed with Robert's provided patch.

> 976 -- 992 are in processcompl() - missing annotations; since ->userurb
> is a void __user *, we should kill those casts and just do
> 	struct usbdevfs_urb __user *userurb = as->userurb;
> 
> and use
> 	if (put_user(urb->status, &userurb->status))
> etc. instead of the current mess.

Good idea, now done, thanks.

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

I really don't know.  I think David added that code.  David, any ideas?

thanks,

greg k-h
