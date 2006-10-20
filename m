Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946498AbWJTU7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946498AbWJTU7w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 16:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946502AbWJTU7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 16:59:52 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:58381 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1946498AbWJTU7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 16:59:51 -0400
Date: Fri, 20 Oct 2006 21:59:29 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Miller <davem@davemloft.net>, nickpiggin@yahoo.com.au,
       ralf@linux-mips.org, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       anemo@mba.ocn.ne.jp, linux-arch@vger.kernel.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 1/3] Fix COW D-cache aliasing on fork
Message-ID: <20061020205929.GE8894@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	David Miller <davem@davemloft.net>, nickpiggin@yahoo.com.au,
	ralf@linux-mips.org, Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	anemo@mba.ocn.ne.jp, linux-arch@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
References: <Pine.LNX.4.64.0610200846260.3962@g5.osdl.org> <20061020.123635.95058911.davem@davemloft.net> <Pine.LNX.4.64.0610201251440.3962@g5.osdl.org> <20061020.125851.115909797.davem@davemloft.net> <Pine.LNX.4.64.0610201302090.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610201302090.3962@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2006 at 01:10:59PM -0700, Linus Torvalds wrote:
> On Fri, 20 Oct 2006, David Miller wrote:
> > I did some more digging, here's what I think the hardware actually
> > does:
> 
> Ok, this sounds sane.
> 
> What should we do about this? How does this patch look to people?
> 
> (Totally untested, and I'm not sure we should even do that whole 
> "oldmm->mm_users" test, but I'm throwing it out here for discussion, in 
> case it matters for performance. The second D$ flush should obviously be 
> unnecessary for the common unthreaded case, which is why none of this has 
> mattered historically, I think).
> 
> Comments? We need ARM, MIPS, sparc and S390 at the very least to sign off 
> on this, and somebody to write a nice explanation for the changelog (and 
> preferably do this through -mm too).

Well, looking at do_wp_page() I'm now quite concerned about ARM and COW.
I can't see how this code could _possibly_ work with a virtually indexed
cache as it stands.  Yet, the kernel does appear to work.

I'm afraid I'm utterly confused with the Linux MM in this day and age, so
I don't think I can even consider commenting on this change.

The majority of ARM caches are VIVT, so data read via the kernel mappings
definitely does not hit the same cache lines as data accessed via the user
mappings.

Our copy_user_page() function merely copies between the two kernel mappings
of the pages so with VIVT caches the kernel mappings - as it always has done
since it's original invention.

However, when I look at this code now, I see _no where_ where we synchronise
the cache between the userspace mapping and the kernel space mapping before
copying a COW page.

So I'm afraid I'm going to have to hold up my hand and say "I don't
understand the Linux MM anymore".

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
