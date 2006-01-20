Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbWATJqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWATJqR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 04:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWATJqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 04:46:17 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:8166 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1750766AbWATJqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 04:46:17 -0500
Date: Fri, 20 Jan 2006 09:44:58 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Joel Schopp <jschopp@austin.ibm.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: Re: [Lhms-devel] Re: [PATCH 0/5] Reducing fragmentation using zones
In-Reply-To: <43D03C24.5080409@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.58.0601200934300.10920@skynet>
References: <20060119190846.16909.14133.sendpatchset@skynet.csn.ul.ie>
 <43CFE77B.3090708@austin.ibm.com> <43D02B3E.5030603@jp.fujitsu.com>
 <Pine.LNX.4.58.0601200102040.15823@skynet> <43D03C24.5080409@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jan 2006, KAMEZAWA Hiroyuki wrote:

> Mel Gorman wrote:
> > > Joel Schopp wrote:
> > > > > Benchmark comparison between -mm+NoOOM tree and with the new zones
> > > > I know you had also previously posted a very simplified version of your
> > > > real
> > > > fragmentation avoidance patches.  I was curious if you could repost
> > > > those
> > > > with the other benchmarks for a 3 way comparison.  The simplified
> > > > version
> > > > got rid of a lot of the complexity people were complaining about and in
> > > > my
> > > > mind still seems like preferable direction.
> > > >
> > > I agree. I think you should try with simplified version again.
> > > Then, we can discuss.
> > >
> >
> > Results from list-based have been posted. The actual patches will be
> > posted tomorrow (in local time, that is in about 12 hours time)
> >
> Thank you.
>
>
> > >  I don't like using bitmap which I removed (T.T
> > >
> > > > Zone based approaches are runtime inflexible and require boot time
> > > > tuning by
> > > > the sysadmin.  There are lots of workloads that "reasonable" defaults
> > > > for a
> > > > zone based approach would cause the system to regress terribly.
> > > >
> > > IMHO, I don't like automatic runtime tuning, you say 'flexible' here.
> > > I think flexibility allows 2^(MAX_ORDER - 1) size fragmentaion.
> > > When SECTION_SIZE > MAX_ORDER, this is terrible.
> > >
> >
> > In an ideal world, we would have both. Zone-based would give guarantees on
> > the availability of reclaimed pages and list-based would give best-effort
> > everywhere.
> >
> > > I love certainty that sysadmin can grap his system at boot-time.
> >
> > It requires careful tuning. For suddenly different workloads, things may
> > go wrong. As with everything else, testing is required from workloads
> > defined by multiple people.
> >
> Yes, we need more test.
>

What sort of tests would you suggest? The tests I have been running to
date are

"kbuild + aim9" for regression testing

"updatedb + 7 -j1 kernel compiles + highorder allocation" for seeing how
easy it was to reclaim contiguous blocks

What tests could be run that would be representative of real-world
workloads?

>
> > > And, for people who want to remove range of memory, list-based approach
> > > will
> > > need some other hook and its flexibility is of no use.
> > > (If list-based approach goes, I or someone will do.)
> > >
> >
> > Will do what?
> >
> add kernelcore= boot option and so on :)
> As you say, "In an ideal world, we would have both".
>

List-based was frowned at for adding complexity to the main path so we may
not get list-based built on top of zone based even though it is certinatly
possible. One reason to do zone-based was to do a comparison between them
in terms of complexity. Hopefully, Nick Piggin (as the first big objector
to the list-based approach) will make some sort of comment on what he
thinks of zone-based in comparison to list-based.

> > > I know zone->zone_start_pfn can be removed very easily.
> > > This means there is possiblity to reconfigure zone on demand and
> > > zone-based approach can be a bit more fliexible.
> > >
> >
> > The obvious concern is that it is very easy to grow ZONE_NORMAL or
> > ZONE_HIGHMEM into the ZONE_EASYRCLM zone but it is hard to do the opposite
> > because you must be able to reclaim the pages at the end of the "awkward"
> > zone.
> Yes, this is weak point of ZONE_EASYRCLM.
>
> By the way, please test this in list-based approach.
> ==
> %ls -lR / (and some commands uses many slabs)
> %do high ordet test
> ==
>

Will set this up and post results after I post patches. The high-order
stress tests are already running updatedb which should have had a similar
effect. However, I never checked when updatedb finished so maybe it
finishes early in the test.

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
