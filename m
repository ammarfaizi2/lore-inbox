Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262670AbVCWAwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262670AbVCWAwK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 19:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262673AbVCWAwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 19:52:09 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:17249 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262670AbVCWAwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 19:52:00 -0500
Date: Wed, 23 Mar 2005 00:51:02 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "David S. Miller" <davem@davemloft.net>
cc: akpm@osdl.org, nickpiggin@yahoo.com.au, tony.luck@intel.com,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] freepgt: free_pgtables use vma list
In-Reply-To: <20050322144151.5b08b047.davem@davemloft.net>
Message-ID: <Pine.LNX.4.61.0503230040210.10858@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503212048040.1970@goblin.wat.veritas.com> 
    <20050322034053.311b10e6.akpm@osdl.org> 
    <Pine.LNX.4.61.0503221617440.8666@goblin.wat.veritas.com> 
    <20050322110144.3a3002d9.davem@davemloft.net> 
    <20050322112125.0330c4ee.davem@davemloft.net> 
    <20050322112329.70bde057.davem@davemloft.net> 
    <Pine.LNX.4.61.0503221931150.9348@goblin.wat.veritas.com> 
    <20050322123301.090cbfa6.davem@davemloft.net> 
    <Pine.LNX.4.61.0503222142280.9761@goblin.wat.veritas.com> 
    <20050322144151.5b08b047.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2005, David S. Miller wrote:
> On Tue, 22 Mar 2005 21:51:39 +0000 (GMT)
> Hugh Dickins <hugh@veritas.com> wrote:
> 
> > I still can't see what's wrong with the code that's already
> > there.  My brain is seizing up, I'm taking a break.
> 
> Ok, meanwhile I'll do a brain dump of what I think this
> code should be doing.
> 
> Let's take an example free_pgd_range() call.  Say the
> address parameters are:
> 
> addr	0x10000
> end	0xa4000
> floor	0x00000
> ceiling	0xb2000

This actual example helped to focus my mind a lot, thank you.

> (This example comes from my exit_mmap() VMA dump earlier
>  in this thread.  If you disable the VMA skipping optimization
>  the first call to free_pgd_range() has these parameters.)
> 
> What ought this free_pgd_range() call do?  This range of
> addresses, from floor to ceiling, is smaller than a PMD_SIZE
> (which on sparc64 is 1 << 23).  Therefore it should clear
> no PGD or PUD entries.

Yup, it ought to decide at the beginning of free_pgd_range
that it simply has no work to do.

> Yet, it does clear them, specifically:
> 
> free_pgd_range():
> 	1) mask addr (0x10000) to PMD_MASK, addr is now 0
> 	2) addr < floor (0x00000) test does not pass
> 	3) mask ceiling (0xb2000) to PMD_MASK, ceiling is now 0 too
> 	4) end - 1 > ceiling - 1 test does not pass
> 	5) addr > end - 1 test does not pass either

And now we've gone wrong, yes.

> The source of the problems seems to be how ceiling began
> at the top of the call chain as 0xb2000, but when we
> masked it with PMD_MASK that set it to zero, which means
> "top of address space" in these functions.  That's not
> what we want.
> 
> I added a quick hack to the simulator I posted, where
> we mask ceiling in free_pgd_range(), I do it like this:
> 
> 	if (ceiling) {
> 		ceiling &= PMD_MASK;
> 		if (!ceiling)
> 			return;
> 	}

At first that just looked like a hack to me.  But on reflection,
no, you're doing exactly what I had to do with addr above: in the
case where we arrive at 0 from non-0 value, have to get out quick
to avoid confusion with the "other" 0.  These wrap issues are hard.

And in other mail I see you found more such checks were needed.
I believe you've got it, thank you so much!

Though frankly, by now, I'm sure of nothing:
will review in the morning.

> and things seem to behave.  I'll try to analyze things
> further and test this out on a real kernel, but all of
> these adjustments at the top of free_pgd_range() really
> start to look like pure spaghetti. :-)

Well, it's trying to decide in reasonably few steps that it's not
worth wasting time going down to the deeper levels.  Lots of
"return"s as it eliminates cases, yes.

Hugh
