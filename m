Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274636AbRIYLEu>; Tue, 25 Sep 2001 07:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274633AbRIYLEl>; Tue, 25 Sep 2001 07:04:41 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:8440
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S274634AbRIYLE3>; Tue, 25 Sep 2001 07:04:29 -0400
Date: Tue, 25 Sep 2001 04:04:48 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: broken VM in 2.4.10-pre9
Message-ID: <20010925040448.F8738@mikef-linux.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <Pine.LNX.4.33L.0109200903100.19147-100000@imladris.rielhome.conectiva> <20010921080549Z16344-2758+350@humbolt.nl.linux.org> <20010921112722.A3646@cs.cmu.edu> <20010922070205Z16210-2757+1207@humbolt.nl.linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010922070205Z16210-2757+1207@humbolt.nl.linux.org>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2001 at 09:09:10AM +0200, Daniel Phillips wrote:
> On September 21, 2001 05:27 pm, Jan Harkes wrote:
> > On Fri, Sep 21, 2001 at 10:13:11AM +0200, Daniel Phillips wrote:
> > >   - small inactive list really means large active list (and vice versa)
> > >   - aging increments need to depend on the size of the active list
> > >   - "exponential" aging may be completely bogus
> > 
> > I don't think so, whenever there is sufficient memory pressure, the scan
> > of the active list is not only done by kswapd, but also by the page
> > allocations.
> > 
> > This does have the nice effect that with a large active list on a system
> > that has a working set that fits in memory, pages basically always age
> > up, and we get an automatic used-once/drop-behind behaviour for
> > streaming data because the age of these pages is relatively low.
> > 
> > As soon as the rate of new allocations increases to the point that
> > kswapd can't keep up, which happens if the number of cached used-once
> > pages is too small, or the working set expands so that it doesn't fit in
> > memory. The memory shortage then causes all pages to agressively get
> > aged down, pushing out the less frequently used pages of the working set.
> > 
> > Exponential down aging simply causes us to loop fewer times in
> > do_try_to_free_pages is such situations.
> 
> In such a situation that's a horribly inefficient way to accomplish this and 
> throws away a lot of valuable information.  Consider that we're doing nothing 
> but looping in the vm in this situation, so nobody gets a chance to touch 
> pages, so nothing gets aged up.  So we are really just deactivating all the 
> pages that lie below a given theshold.
> 
> Say that the threshold happens to be 16.  We loop through the active list 5 
> times and now we have not only deactivated the pages we needed but collapsed 
> all ages between 16 and 31 to the same value, and all ages between 32 and 63 
> to just two values, losing most of the relative weighting information.
> 
> Would it not make more sense to go through the active list once, deactivate 
> all pages with age less than some computed threshold, and subtract that 
> threshold from the rest?
> 

If I understand the thread between Rik and the guy from FreeBSD (sorry,
don't remember his name), then what they are doing is they have a computed
swap level that rises as needed, and doesn't modify the aging of any of the
pages.

So, if you have pages ages at 5 7 15 30 45 each loop through
do_try_to_free_pages will raise swap_thresh by whatever increment.

Looping through, you first get the pages at 5, 7, then 15 until you swap out
enough.  While this is happening, you let the normal referencing modify the
aging, not the act of swapping.

I know this is quite simplistic, but it may help.  What do you guys think?
