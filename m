Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265289AbUFTOSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265289AbUFTOSX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 10:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265291AbUFTOSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 10:18:23 -0400
Received: from [80.72.36.106] ([80.72.36.106]:31398 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S265289AbUFTOSN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 10:18:13 -0400
Date: Sun, 20 Jun 2004 16:18:07 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Memory and rsync problem with vanilla 2.6.7
In-Reply-To: <40D508E8.2050407@yahoo.com.au>
Message-ID: <Pine.LNX.4.58.0406201543520.22369@alpha.polcom.net>
References: <20040426013944.49a105a8.akpm@osdl.org>
 <Pine.LNX.4.58.0404270105200.2304@donald.themaw.net>
 <Pine.LNX.4.58.0404261917120.24825@alpha.polcom.net>
 <Pine.LNX.4.58.0404261102280.19703@ppc970.osdl.org>
 <Pine.LNX.4.58.0404262350450.3003@alpha.polcom.net>
 <Pine.LNX.4.58.0406191841050.6160@alpha.polcom.net>
 <Pine.LNX.4.58.0406191040170.6178@ppc970.osdl.org> <40D508E8.2050407@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jun 2004, Nick Piggin wrote:

> Linus Torvalds wrote:
> > 
> > On Sat, 19 Jun 2004, Grzegorz Kulewski wrote:
> > 
> >>Is this bug or feature? Is there some wreid memmory leak? Where is my RAM?
> > 
> > 
> > Your memory is apparently in dentry and inode memory:
> > 
> > 	ext3_inode_cache   62553  62553   4096		(244MB)
> > 	dentry_cache       48768  48768   4096		(190MB)
> > 
> > and it really looks like you have enabled CONFIG_DEBUG_PAGEALLOC, which 
> > just eats memory like mad (a dentry is normally ~200 bytes, but then when 
> > it is rounded up to page-size, it takes 20 times the memory).
> > 
> > So don't enable DEBUG_PAGEALLOC unless you really want to debug some 
> > strange problem.
> > 
> 
> This could be it. But can you check whether your previous well-behaving
> kernel also has CONFIG_DEBUG_PAGEALLOC on? If so, then it is possible
> that VM behaviour has regressed.

I always test new kernels with all debug enabled just in case. If 
everything is ok I recompile them without debuging. And sometimes I use 
rsync before I recompile and I never experienced such problems so I think 
something was changed.


> Of course, DEBUG_PAGEALLOC is the wrong target to attempt to tune for:
> without it, those above two items would take up a combined 40 megs.

Yes, of course. Maybe there should be bigger warning in make config about 
this option? Btw. many debug options have very short help (if any) not 
saying how bad they interract with speed and memory. Maybe there should be 
some submenu with "mad" debug options only for insane people :)?


> > That said, there might be a memory balancing problem too, and
> > DEBUG_PAGEALLOC just makes it more obvious.  Nick Piggin reports that an
> > "obvious fix" by Andrew potentially causes problems, and if you're a BK
> > user, you could try just backing out this cset:
> > 
> > 	ChangeSet@1.1722.88.2, 2004-06-03 07:58:03-07:00, akpm@osdl.org
> > 	  [PATCH] shrink_all_memory() fixes
> > 
> > 	....
> > 
> > (check with "bk changes" what the revision is in your tree, and do a
> > 
> > 	bk cset -xX.XXX.XX.X
> > 
> > to try reverting it. Quite possibly that fix makes the VM much less likely
> > to throw out the VM caches, which would make the debug problem much 
> > worse).
> 
> Well it doesn't seem to have caused too much trouble as yet... But it
> is the obvious candidate if your problems continue. If you are not a
> bk user, the attached patch will also revert that change.

Thanks, I will test it soon and I will report results. But I am not saying 
it is a bug - maybe it is simply change that can lead to problems with 
insane debug options but itself is good?


Thanks,

Grzegorz Kulewski 

