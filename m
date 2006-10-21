Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992756AbWJUAqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992756AbWJUAqR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 20:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992762AbWJUAqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 20:46:17 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:25748 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S2992761AbWJUAqR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 20:46:17 -0400
Date: Sat, 21 Oct 2006 01:46:27 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linus Torvalds <torvalds@osdl.org>, David Miller <davem@davemloft.net>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, anemo@mba.ocn.ne.jp
Subject: Re: [PATCH 1/3] Fix COW D-cache aliasing on fork
Message-ID: <20061021004627.GA32044@linux-mips.org>
References: <1161275748231-git-send-email-ralf@linux-mips.org> <4537B9FB.7050303@yahoo.com.au> <20061019181346.GA5421@linux-mips.org> <20061019.155939.48528489.davem@davemloft.net> <4538DFAC.1090206@yahoo.com.au> <Pine.LNX.4.64.0610200846260.3962@g5.osdl.org> <4538F1EC.1020806@yahoo.com.au> <Pine.LNX.4.64.0610200935290.3962@g5.osdl.org> <4538FDBC.6070301@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4538FDBC.6070301@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2006 at 02:47:56AM +1000, Nick Piggin wrote:

> >So maybe the COW D$ aliasing patch-series is just the right thing to do. 
> >Not worry about D$ at _all_ when doing the actual fork, and only worry 
> >about it on an actual COW event. Hmm?
> 
> Well if we have the calls in there, we should at least make them work
> right for the architectures there now. At the moment the flush_cache_mm
> before the copy_page_range wouldn't seem to do anything if you can still
> have threads dirty the cache again through existing TLB entries.

If you're talking about getting 2.6.19 out of the door without risking
too much wreckage, I'm all for it.

> I don't think that flushing on COW is exactly right though, because dirty
> data can remain invisible if you're only doing reads (no write, no flush).
> And if that cache gets written back at some point, you're going to see
> supposedly RO data change underneath you. I think?

You will not be able to avoid aliases at COW breaking time by any kind of
cache flush.  In a VIPT cache the userspace page is living at it's
userspace address but the current implemention of copy_user_page will
try to copy it at it's kernel space address and those two may not live
at the same cache index.

So, when breaking a COW mapping you have two options:

 1) copying involves touch a userspace mapped page at it's kernel address.
    This may result in an alias so apropriate cache flushing will be
    needed.  On a MIPS system this flush itself is like 1,000 cycles but
    could easily several times as much.  Add the cost of bringing all the
    data that was blown away from the cache back later on.
 2) try to be smart and avoid the creation of aliases by creating proper
    temporary aliases.  Creating and tearing down a TLB mapping is dirt
    cheap.

The current strategy is #1 which happens to work for MIPS because there
is at most an alias between clean lines which is harmless on MIPS but will
blow up on PA8800 - without overkill flushing.

It is possible to implement the common sequence of fork + exec such that
the child never ever breaks a COW page, not even a stack page.  So why
should a PIPT or VIPT cache be flushed in such a case?  We can do better
than that.

  Ralf
