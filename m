Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964877AbVJaWuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964877AbVJaWuT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 17:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbVJaWuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 17:50:19 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17679 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932166AbVJaWuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 17:50:18 -0500
Date: Mon, 31 Oct 2005 22:50:11 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Nicolas Pitre <nico@cam.org>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/9] mm: arm ready for split ptlock
Message-ID: <20051031225011.GH20452@flint.arm.linux.org.uk>
Mail-Followup-To: Jesper Juhl <jesper.juhl@gmail.com>,
	Nicolas Pitre <nico@cam.org>, Hugh Dickins <hugh@veritas.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0510221716380.18047@goblin.wat.veritas.com> <Pine.LNX.4.61.0510221719370.18047@goblin.wat.veritas.com> <20051022170240.GA10631@flint.arm.linux.org.uk> <Pine.LNX.4.64.0510241922040.5288@localhost.localdomain> <20051025075555.GA25020@flint.arm.linux.org.uk> <Pine.LNX.4.64.0510251056380.5288@localhost.localdomain> <20051026002016.GB25420@flint.arm.linux.org.uk> <9a8748490510311419o7c4cc615qa7123d7aa124e3df@mail.gmail.com> <20051031222731.GE20452@flint.arm.linux.org.uk> <9a8748490510311434m1803851bpad0225feff037e6b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490510311434m1803851bpad0225feff037e6b@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2005 at 11:34:39PM +0100, Jesper Juhl wrote:
> On 10/31/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > On Mon, Oct 31, 2005 at 11:19:21PM +0100, Jesper Juhl wrote:
> > > Yes, I removed verify_area() since it was just a wrapper for access_ok().
> > > If verify_area() was/is needed, then access_ok() should be just fine
> > > as a replacement as far as I can see.
> >
> > Except verify_area() would pre-fault the pages in whereas access_ok()
> > just verifies that the address is a user page.  That's quite important
> > in this case because in order to fault the page in, we need to use
> > put_user() to get the permission checking correct.
> >
> > However, we can't use put_user() because then the cmpxchg emulation
> > becomes completely non-atomic.
> >
> Colour me stupid, but I don't see how that can be.
> 
> Looking at verify_area() from 2.6.13 - the arm version (
> http://sosdg.org/~coywolf/lxr/source/include/asm-arm/uaccess.h?v=2.6.13#L81
> ) :
> 
> static inline int __deprecated verify_area(int type, const void __user
> *addr, unsigned long size)
> {
>         return access_ok(type, addr, size) ? 0 : -EFAULT;
> }
> 
> How will this cause pre-faulting if a call to access_ok() will not?
> Please enlighten me.

This is true because we haven't had this requirement up until the
introduction of this.  I am referring to some functionality which
was present a while back in the kernel - the old version of
verify_area which, when passed a VERIFY_WRITE argument, would
prefault the pages... as required for some i386 CPUs.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
