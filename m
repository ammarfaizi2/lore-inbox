Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932503AbVJZAU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbVJZAU0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 20:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932508AbVJZAU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 20:20:26 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:16650 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932503AbVJZAUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 20:20:24 -0400
Date: Wed, 26 Oct 2005 01:20:16 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Nicolas Pitre <nico@cam.org>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/9] mm: arm ready for split ptlock
Message-ID: <20051026002016.GB25420@flint.arm.linux.org.uk>
Mail-Followup-To: Nicolas Pitre <nico@cam.org>,
	Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0510221716380.18047@goblin.wat.veritas.com> <Pine.LNX.4.61.0510221719370.18047@goblin.wat.veritas.com> <20051022170240.GA10631@flint.arm.linux.org.uk> <Pine.LNX.4.64.0510241922040.5288@localhost.localdomain> <20051025075555.GA25020@flint.arm.linux.org.uk> <Pine.LNX.4.64.0510251056380.5288@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510251056380.5288@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2005 at 11:00:09AM -0400, Nicolas Pitre wrote:
> On Tue, 25 Oct 2005, Russell King wrote:
> 
> > On Mon, Oct 24, 2005 at 10:45:04PM -0400, Nicolas Pitre wrote:
> > > On Sat, 22 Oct 2005, Russell King wrote:
> > > > Please contact Nicolas Pitre about that - that was my suggestion,
> > > > but ISTR apparantly the overhead is too high.
> > > 
> > > Going through a kernel buffer will simply double the overhead.  Let's 
> > > suppose it should not be a big enough issue to stop the patch from being 
> > > merged though (and it looks cleaner that way). However I'd like for the 
> > > WARN_ON((unsigned long)frame & 7) to remain as both the kernel and user 
> > > buffers should be 64-bit aligned.
> > 
> > The WARN_ON is pointless because we guarantee that the stack is always
> > 64-bit aligned on signal handler setup and return.
> 
> Sure, but the iWMMXt context is stored after the standard sigcontext 
> which also must be 64 bits in size (which might not be always the case 
> if things change in the structure or in its padding).
> 
> > > I don't see how standard COW could not happen.  The only difference with 
> > > a true write fault as if we used put_user() is that we bypassed the data 
> > > abort vector and the code to get the FAR value.  Or am I missing 
> > > something?
> > 
> > pte_write() just says that the page _may_ be writable.  It doesn't say
> > that the MMU is programmed to allow writes.  If pte_dirty() doesn't
> > return true, that means that the page is _not_ writable from userspace.
> 
> Argh...  So only suffice to s/pte_write/pte_dirty/ I'd guess?

No.  If we're emulating a cmpxchg() on a clean BSS page, this code
as it stands today will write to the zero page making it a page which
is mostly zero.  Bad news when it's mapped into other processes BSS
pages.

Changing this for pte_dirty() means that we'll refuse to do a cmpxchg()
on a clean BSS page.  The data may compare correctly, but because it
isn't already dirty, you'll fail.

If we still had it, I'd say you need to use verify_area() to tell the
kernel to pre-COW the pages.  However, that got removed a while back.

For the benefit of others, this is a bit of a bugger since you can't
use put_user() - the read + compare + write needs to be 100% atomic
and put_user() isn't - it may fault and hence we may switch contexts.

I don't have any ideas at present, but maybe that's because it's
getting on for 1:30am. 8/

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
