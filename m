Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261656AbVB1Pni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbVB1Pni (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 10:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261658AbVB1Pni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 10:43:38 -0500
Received: from fire.osdl.org ([65.172.181.4]:65213 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261656AbVB1PnX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 10:43:23 -0500
Subject: Re: [PATCH] Fix panic in 2.6 with bounced bio and dm
From: Mark Haverkamp <markh@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, dm-devel@redhat.com
In-Reply-To: <1109604737.30227.3.camel@markh1.pdx.osdl.net>
References: <1109351021.5014.10.camel@markh1.pdx.osdl.net>
	 <20050225161947.5fd6d343.akpm@osdl.org>
	 <Pine.LNX.4.58.0502251640050.9237@ppc970.osdl.org>
	 <20050226123934.GA1254@suse.de>
	 <1109604737.30227.3.camel@markh1.pdx.osdl.net>
Content-Type: text/plain
Date: Mon, 28 Feb 2005 07:43:12 -0800
Message-Id: <1109605392.30227.11.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-02-28 at 07:32 -0800, Mark Haverkamp wrote:
> On Sat, 2005-02-26 at 13:39 +0100, Jens Axboe wrote:
> > On Fri, Feb 25 2005, Linus Torvalds wrote:
> > > 
> > > 
> > > On Fri, 25 Feb 2005, Andrew Morton wrote:
> > > > 
> > > > It seems very weird for dm to be shoving NULL page*'s into the middle of a
> > > > bio's bvec array, so your fix might end up being a workaround pending a
> > > > closer look at what's going on in there.
> > > 
> > > Yes. I don't see how this patch can be anything but bandaid to hide the 
> > > real bug. Where do these "non-page" bvec's originate?
> > 
> > Yep that's the fishy part, there should not be NULL pages in the middle
> > (or empty bios, for that matter) submitted for io.
> > 
> > Mark, what was the bug that triggered you to write this patch?
> 
> It happened when some pages of IO from a dm device were bounced.  It
> looks to me when bio's are cloned in the dm code to split it for
> physical devices that only the pointers to pages that apply to that
> device are copied and th bi_idx is adjusted to point to the start,
> leaving some NULL pointers at the start of the bio_vec.

I don't think that I explained that correctly.  The dm code clones the
bio and sets the bi_idx to point to where the IO should start.  Then
when __blk_queue_bounce gets called, it only fills in its bio starting
at bi_idx (it uses bio_for_each_segment) and since it calls bio_alloc
instead of bio_clone, any pages it doesn't fill in are NULL.  I suppose
we could call bio_clone instead of bio_alloc in __blk_queue_bounce and
fill in the whole bio.

Mark.

> 
> Mark,
> 
> 
> > 
-- 
Mark Haverkamp <markh@osdl.org>

