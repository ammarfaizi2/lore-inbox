Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265376AbUFTNZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265376AbUFTNZJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 09:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265377AbUFTNZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 09:25:08 -0400
Received: from [80.72.36.106] ([80.72.36.106]:12454 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S265376AbUFTNZB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 09:25:01 -0400
Date: Sun, 20 Jun 2004 15:24:56 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: Memory and rsync problem with vanilla 2.6.7
In-Reply-To: <Pine.LNX.4.58.0406191040170.6178@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0406201506500.22369@alpha.polcom.net>
References: <20040426013944.49a105a8.akpm@osdl.org>
 <Pine.LNX.4.58.0404270105200.2304@donald.themaw.net>
 <Pine.LNX.4.58.0404261917120.24825@alpha.polcom.net>
 <Pine.LNX.4.58.0404261102280.19703@ppc970.osdl.org>
 <Pine.LNX.4.58.0404262350450.3003@alpha.polcom.net>
 <Pine.LNX.4.58.0406191841050.6160@alpha.polcom.net>
 <Pine.LNX.4.58.0406191040170.6178@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jun 2004, Linus Torvalds wrote:

> On Sat, 19 Jun 2004, Grzegorz Kulewski wrote:
> > 
> > Is this bug or feature? Is there some wreid memmory leak? Where is my RAM?
> 
> Your memory is apparently in dentry and inode memory:
> 
> 	ext3_inode_cache   62553  62553   4096		(244MB)
> 	dentry_cache       48768  48768   4096		(190MB)
> 
> and it really looks like you have enabled CONFIG_DEBUG_PAGEALLOC, which 
> just eats memory like mad (a dentry is normally ~200 bytes, but then when 
> it is rounded up to page-size, it takes 20 times the memory).
> 
> So don't enable DEBUG_PAGEALLOC unless you really want to debug some 
> strange problem.
> 
> That said, there might be a memory balancing problem too, and
> DEBUG_PAGEALLOC just makes it more obvious.  Nick Piggin reports that an
> "obvious fix" by Andrew potentially causes problems, and if you're a BK
> user, you could try just backing out this cset:
> 
> 	ChangeSet@1.1722.88.2, 2004-06-03 07:58:03-07:00, akpm@osdl.org
> 	  [PATCH] shrink_all_memory() fixes
> 
> 	....
> 
> (check with "bk changes" what the revision is in your tree, and do a
> 
> 	bk cset -xX.XXX.XX.X
> 
> to try reverting it. Quite possibly that fix makes the VM much less likely
> to throw out the VM caches, which would make the debug problem much 
> worse).

Yes, you are right. But something was changed (probably) between 2.6.6 and 
2.7 because I always test new kernels with every debug enabled, just in 
case :). It was slower but never caused such problems.

No, I am currently not bk user (but I will probably learn it during 
holidays). Is there any easy way to produce patch from that changeset?
I want to test it to check if it really is the cause of the problem.


Thanks,

Grzegorz Kulewski

