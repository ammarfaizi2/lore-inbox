Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268794AbUHTXIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268794AbUHTXIm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 19:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268796AbUHTXIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 19:08:42 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:5343 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268794AbUHTXIi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 19:08:38 -0400
Subject: Re: [PATCH] shows Active/Inactive on per-node meminfo
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, amgta@yacht.ocn.ne.jp,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20040820152551.03a4aee7.akpm@osdl.org>
References: <200408210302.25053.amgta@yacht.ocn.ne.jp>
	 <200408201448.22566.jbarnes@engr.sgi.com>
	 <200408201501.31542.jbarnes@engr.sgi.com>
	 <20040820152551.03a4aee7.akpm@osdl.org>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1093043306.22894.72.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 20 Aug 2004 16:08:26 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-20 at 15:25, Andrew Morton wrote:
> Jesse Barnes <jbarnes@engr.sgi.com> wrote:
> >
> > On Friday, August 20, 2004 2:48 pm, Jesse Barnes wrote:
> > > On Friday, August 20, 2004 2:02 pm, mita akinobu wrote:
> > > > +	for (i = 0; i < MAX_NR_ZONES; i++) {
> > > > +		*active += zones[i].nr_active;
> > > > +		*inactive += zones[i].nr_inactive;
> > > > +		*free += zones[i].free_pages;
> > > > +	}
> > > > +}
> > > > +
> > > > -		*free += zone->free_pages;
> > > > +	for_each_pgdat(pgdat) {
> > > > +		unsigned long l, m, n;
> > > > +		__get_zone_counts(&l, &m, &n, pgdat);
> > > > +		*active += l;
> > > > +		*inactive += m;
> > > > +		*free += n;
> > > >  	}
> > >
> > > Just FYI, loops like this are going to be very slow on a large machine.
> > > Iterating over every node in the system involves a TLB miss on every
> > > iteration along with an offnode reference and possibly cacheline demotion.
> > 
> > ...but I see that you're just adding the info to the per-node meminfo files, 
> > so it should be ok as long as people access a node's meminfo file from a 
> > local cpu.  /proc/meminfo will still hurt a lot though.
> > 
> > I bring this up because I ran into it once.  I created a file 
> > called /proc/discontig which printed out detailed per-node memory stats, one 
> > node per line.  On a large system it would literally take several seconds to 
> > cat the file due to the overhead of looking at all the pages and zone 
> > structures.
> > 
> 
> So was that an ack, a nack or a quack?
> 
> I'll queue the patch up so it doesn't get lost - could you please take a
> closer look at the performance implications sometime, let me know?

It doesn't look like it will have any real impact.  The only function
(besides reading /proc/meminfo and
/sys/devices/system/node/node%d/meminfo files) that is affect by this is
get_zone_counts().  get_zone_counts() is already looping over all zones
on all nodes in the system anyway, this new code does exactly that. 
for_each_zone() loops over all the zones by looping through each pgdat
in the system, which is what the new code does, but more explicitly.  We
might do a little better by inlining __get_zone_counts()?

That said, I haven't run any benchmarks or anything... :)

-Matt

