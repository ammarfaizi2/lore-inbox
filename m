Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932628AbVJCQsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932628AbVJCQsy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 12:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932619AbVJCQsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 12:48:52 -0400
Received: from fmr14.intel.com ([192.55.52.68]:54169 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S932617AbVJCQsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 12:48:50 -0400
Subject: Re: [PATCH]: Clean up of __alloc_pages
From: Rohit Seth <rohit.seth@intel.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: akpm@osdl.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0510030828400.7812@schroedinger.engr.sgi.com>
References: <20051001120023.A10250@unix-os.sc.intel.com>
	 <Pine.LNX.4.62.0510030828400.7812@schroedinger.engr.sgi.com>
Content-Type: text/plain
Organization: Intel 
Date: Mon, 03 Oct 2005 09:55:58 -0700
Message-Id: <1128358558.8472.13.camel@akash.sc.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Oct 2005 16:48:29.0744 (UTC) FILETIME=[4859F300:01C5C83A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-03 at 08:34 -0700, Christoph Lameter wrote:
> On Sat, 1 Oct 2005, Seth, Rohit wrote:
> 
> > -				goto zone_reclaim_retry;
> > -			}
> > +	if (order == 0) {
> > +		for (i = 0; (z = zones[i]) != NULL; i++) {
> > +			page = buffered_rmqueue(z, 0, gfp_mask, 0);
> > +			if (page) 
> > +				goto got_pg;
> >  		}
> > -
> 
> This is checking all zones for pages on the pcp before going the more 
> expensive route?
> 

That is right.

> Seems that this removes the logic intended to prefer local 
> allocations over remote pages present in the existing alloc_pages? There 
> is the danger that this modification will lead to the allocation of remote 
> pages even if local pages are available. Thus reducing performance.
> 

Good catch.  I will up level the cpuset check in buffered_rmqueue rather
then doing it in get_page_from_freelist.  That should retain the current
preferences for local pages.

> I would suggest to just check the first zone's pcp instead of all zones.
> 

Na. This for most cases will be ZONE_DMA pcp list having nothing much
most of the time.  And picking any other zone randomly will be exposed
to faulty behavior.

Thanks,
-rohit

