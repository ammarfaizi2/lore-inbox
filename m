Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265941AbUFJEPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265941AbUFJEPd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 00:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265995AbUFJEPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 00:15:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1774 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265941AbUFJEPa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 00:15:30 -0400
Date: Thu, 10 Jun 2004 05:15:29 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
Cc: linux-fbdev-devel@lists.sourceforge.net,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: 2.6.7-rc3 drivers/video/fbmem.c: user/kernel pointer bugs
Message-ID: <20040610041529.GD12308@parcelfarce.linux.theplanet.co.uk>
References: <1086821199.32054.111.camel@dooby.cs.berkeley.edu> <20040610012441.GY12308@parcelfarce.linux.theplanet.co.uk> <1086839438.14179.340.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1086839438.14179.340.camel@dooby.cs.berkeley.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2004 at 08:50:33PM -0700, Robert T. Johnson wrote:
> A similar situation arises in tty code, which passes around a flag
> "from_user" to indicate whether another pointer is a user pointer or
> kernel pointer.  See, for example, drivers/char/pty.c:pty_write(). 
> CQual complains about that, too.  How about sparse?

Of course - we have the same pointer passed both to memcpy() and
copy_from_user().  Since they expect different address spaces for
their arguments, no annotaion will avoid tripping a warning.

> static int pty_write(struct tty_struct * tty, int from_user,
> 		       const unsigned char __user   *ubuf, 
>                        const unsigned char __kernel *kbuf,
>                        int count)

Eeek.  You do realize that it doesn't fix the real problem, don't you?
Paper over it, but that's it - and we are trading one constraint for
another ("at most one of those two arguments is non-NULL") and _still_
have locking implications from hell.

That warning is actually a sign of real problem - it is not a false
positive in a sense that tty_driver ->write() is a broken API and
is ripe with e.g. locking bugs.

> The slicker work-around involves passing a function pointer for
> accessing the buffer, like in the example I gave in the other email. 
> This works for cqual, but probably wouldn't help sparse.

<shrug> just pass opaque data around as unsigned long.  Ugly, but will
work.  And no, I'm not happy about the idea of doing polymorphic types -
C is not particulary well suited for that.  It's still papering over
the problem instead of fixing it.

In case of tty ->write() the real question is different - if you take
a look at the actual instances of that method, you'll see that they
have serious code duplication between the kernel/userland cases (not
a surprise) and the only difference besides the way we copy is in the
locking done on these paths.

It's actually worth investigating - I'm fairly sure that we'll find
	a) shitloads of SMP problems on the "kernel" side of things (aka. "we
don't need no stinkin' locking, memcpy won't block")
	b) very distinct possibility of making the locking mechanism used
on "userland" path generic and driven by n_tty.c - along with copying from
userland to kernel.  Note that n_tty.c is the only caller of ->write() with
userland pointers; everything else is kernel-only.

So I suspect that it in the long run the proper fix will be to sanitize
the locking and move all copy_from_user() to the (only) caller.

> > 	FWIW, I think we should reduxe mixing of ioctl and kernel structures.
> > console_font_op is a particulary obnoxious example, but lots of the stuff
> > in drivers/video is not much better.
> 
> I think the key point is to make pointers either be always user pointers
> or always kernel pointers.  Their type shouldn't depend on some other
> flag.
> 
> I fear that completely separating ioctl and kernel data structures would
> result in lots of redundant structure definitions, which will lead to
> code maintainence problems and their own host of bugs.  Would it be
> better to just design a bug finding tool that's capable of keeping track
> of different structure instances separately?

I doubt it.  Most of the ioctl data structures do not survive past the
decoding; fb layer is ugly that way, but that's a local problem and it
can be fixed.

Keep in mind that anything containing userland pointers needs to be explicitly
dealt with on 32/64 platforms - otherwise 32bit code won't be able to issue
that ioctl anyway.

	Besides, kernel data structures should not be tied by ABI stability
requirements - and ioctl arguments have to.  Which leads to far worse bug
potential than explict decoding.
