Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbWAAC7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWAAC7G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 21:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbWAAC7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 21:59:05 -0500
Received: from hera.kernel.org ([140.211.167.34]:2977 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932183AbWAAC6p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 21:58:45 -0500
Date: Sat, 31 Dec 2005 20:12:15 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Marijn Meijles <marijn@bitpit.net>, Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 6/9] clockpro-clockpro.patch
Message-ID: <20051231221215.GA4024@dmt.cnet>
References: <20051230223952.765.21096.sendpatchset@twins.localnet> <20051230224312.765.58575.sendpatchset@twins.localnet> <20051231002417.GA4913@dmt.cnet> <1136026117.17853.46.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136026117.17853.46.camel@twins>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 31, 2005 at 11:48:37AM +0100, Peter Zijlstra wrote:
> On Fri, 2005-12-30 at 22:24 -0200, Marcelo Tosatti wrote:
> > Hi Peter,
> > 
> > _Nice_ work!
> 
> Thanks!
> 
> > IMHO you're going into the right direction, abstracting away page
> > replacement policy from page reclaim. 
> > 
> > I think that final objective should be to abstract it away completly,
> > making it possible to select between different policies, allowing
> > further experimentation and implementations such as energy efficient
> > algorithms.
> > 
> > How hard do you think would it be to enhance your patches to allow for 
> > compile-time selectable policies?
> 
> Not that much more work, it would need abstracing all the usage of the
> list counters (nr_active/nr_inactive vs. nr_resident/nr_cold).

That would be very interesting.

> > For instance, moving "page reclaim scanner" specific information into
> > its own container:
> > 
> >  @@ -140,12 +140,13 @@ struct zone {
> >   	/* Fields commonly accessed by the page reclaim scanner */
> >  -	spinlock_t		lru_lock;	
> >  -	struct list_head	active_list;
> >  -	struct list_head	inactive_list;
> >  -	unsigned long		nr_scan_active;
> >  -	unsigned long		nr_active;
> >  -	unsigned long		nr_inactive;
> >  +	spinlock_t		lru_lock;
> >  +	struct list_head	list_hand[2];
> >  +	unsigned long		nr_resident;
> >  +	unsigned long		nr_cold;
> >  +	unsigned long 		nr_cold_target;
> >  +	unsigned long		nr_nonresident_scale;
> >  +
> > 
> > Such as "struct reclaim_policy_data" or a better name.
> 
> Yes, I have toyed with that idea, rik didn't like it and I didn't spend
> any effort on it, but it could very well be done. 

I'll come up with a proposal for review on top of your work.

> > About CLOCK-Pro itself, I think that a small document with a short
> > introduction would be very useful... explaining that it uses inter
> > reference distance instead of recency for the page replacement criteria,
> > and why this criteria is fundamentally more appropriate for a large set
> > of common access patterns aka "a resume of the CLOCK-Pro paper".
> 
> Ok, I shall give this Documentation/vm/clockpro.txt thing a try.
> 
> 
> > > Implementation wise I use something based on Rik van Riel's nonresident code
> > > which actually aproximates a clock with reduced order. 
> > 
> > I'm curious about hash collisions, would like to know more details about
> > the hash distribution under different loads. 
> > 
> > Would be nice to measure the rate of updates on each hash bucket and
> > confirm that they are approximate.
> 
> I have/had a patch that prints stats on each bucket, I did some stats a
> few months back and the deviation in bucket usage was not very high,
> which would indicate a rather good distribution.
> 
> Could revive that patch so you can have a go at it if you wish.

Please, will give it a try.

> > > The resident clock with two hands is implemented using two lists which are to
> > > be seen as laid head to tail to form the clock. When one hand laps the other
> > > the lists are swapped.
> > 
> > How does that differ from the original CLOCK-Pro algorithm, and why, and what are
> > the expected outcomes? Please make it easier for others to understand why the hands 
> > swap, and when, and why.
> 
> The original clockpro algorithm has one clock with 3 hands. In order to
> make it work with multiple resident zones, the non-resident pages have
> to be isolated.
> 
> I did that by having two clocks, one resident with two hands (per zone)
> and one non-resident with one hand (global), where the non-resident
> clock should be viewed as an overlay on the resident one (imagine the
> single zone case).
> 
> This loses some page order information, ie. the exact position of the
> non-resident pages wrt. the resident pages, however it is a good
> approximation when the rotation speeds of the respective hands are tied
> together such that:
>  when the resident hot hand has made a full revolution so too has the
> non-resident hand.

> > > Each page has 3 state bits:
> > > 
> > > 	hot  -> PageHot()
> > > 	test -> PageTest()
> > > 	ref  -> page_referenced()
> > > 
> > > (PG_active will be renamed to PG_hot in a following patch, since the semantics
> > >  changed also change the name in order to avoid confusion))
> > > 
> > > The HandCold rotation is driven by page reclaim needs. HandCold in turn
> > > drives HandHot, for every page HandCold promotes to hot HandHot needs to
> > > degrade one hot page to cold.
> > 
> > Why do you use only two clock hands and not three (HandHot, HandCold and HandTest)
> > as in the original paper?
> 
> As explanied above, the multi-zone thing requires the non-resident pages
> to be separated.
> 
> > > + * res | h/c | tst | ref || Hcold | Hhot | Htst || Flt
> > > + * ----+-----+-----+-----++-------+------+------++-----
> > > + *  1  |  1  |  0  |  1  ||=1101  | 1100 |=1101 ||
> > > + *  1  |  1  |  0  |  0  ||=1100  | 1000 |=1100 ||
> > > + * ----+-----+-----+-----++-------+------+------++-----
> > > + *  1  |  0  |  1  |  1  || 1100  | 1001 | 1001 ||
> > > + *  1  |  0  |  1  |  0  ||X0010  | 1000 | 1000 ||
> > > + *  1  |  0  |  0  |  1  || 1010  |=1001 |=1001 ||
> > > + *  1  |  0  |  0  |  0  ||X0000  |=1000 |=1000 ||
> > > + * ----+-----+-----+-----++-------+------+------++-----
> > > + * ----+-----+-----+-----++-------+------+------++-----
> > > + *  0  |  0  |  1  |  1  ||       |      |      || 1100
> > > + *  0  |  0  |  1  |  0  ||=0010  |X0000 |X0000 ||
> > > + *  0  |  0  |  0  |  1  ||       |      |      || 1010 
> > 
> > What does this mean? Can you make it easier for ignorant people like
> > myself to understand?
> 
> state table, it describes how (in the original paper) the three hands
> modify the page state. Given the state in the first four columns, the
> next three columns give a new state for each hand; hand cold, hot and
> test. The last column describes the action of a pagefault.
> 
> Ex. given a resident cold page in its test period that is referenced
> (1011):
>  - Hand cold will make it 1100, that is, a resident hot page;
>  - Hand hot will make it 1001, that is, a resident cold page with a
> reference; and
>  - Hand test will also make it 1001.
> 
> (The prefixes '=' and 'X' are used to indicate: not changed, and remove
> from list - that can be either move from resident->non-resident or
> remove altogether).

I see - can you add this info to the patch?
