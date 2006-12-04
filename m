Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936975AbWLDPBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936975AbWLDPBT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 10:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936973AbWLDPAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 10:00:36 -0500
Received: from mail.suse.de ([195.135.220.2]:60283 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936961AbWLDO4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 09:56:04 -0500
Date: Mon, 4 Dec 2006 15:55:52 +0100
From: Nick Piggin <npiggin@suse.de>
To: Mel Gorman <mel@skynet.ie>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [rfc] possible page manipulation simplifications?
Message-ID: <20061204145552.GB14383@wotan.suse.de>
References: <20061202121519.GA20670@wotan.suse.de> <20061204144005.GA22233@skynet.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061204144005.GA22233@skynet.ie>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2006 at 02:40:05PM +0000, Mel Gorman wrote:
> On (02/12/06 13:15), Nick Piggin didst pronounce:
> > Hi,
> > 
> > While working in this area, I noticed a few things we do that may not
> > have a positive payoff under the most common conditions. Untested yet,
> > and probably needs a bit of instrumentation, but it saves about half a
> > K of code, lots of branches, and makes things look nicer. Any thoughts?
> > 
> > Quite a bit of code is used in maintaining these "cached pages" that are
> > probably pretty unlikely to get used.
> > 
> 
> I think you might be leaking now though. More comments below.
> 
> > Also, buffered write path (and others) uses its own LRU pagevec when we should
> > be just using the per-CPU LRU pagevec (which will cut down on both data and
> > code size cacheline footprint).
> > 
> 
> Splitting the patch into two could be nice but it's grand for the
> moment.

Hi Mel,

I think you're right about the leakage, thanks for catching it.

As far as allocating pages twice is concerned, I *strongly* believe
it is the wrong tradeoff to fix this with a "cached_page" because we
have to hit 2 reasonably rare races.

Firstly, we must find no pagecache exists, then we discover a page
has been installed after allocating. This will be rare for most
workloads, but lets say that it comes up in a few because page alloc
may sleep (a busy file server might have several processes reading
the same file, triggering this race in the write path would be even
less common).

However supposing this race is triggered, then we *also* need to
fail the page lookup a few instructions after a similar operation
has succeeded!

Thanks, will post an updated and properly tested version in a while.
