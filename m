Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262742AbVCPSji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262742AbVCPSji (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 13:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262733AbVCPShs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 13:37:48 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:28510
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S262738AbVCPShI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 13:37:08 -0500
Date: Wed, 16 Mar 2005 19:37:01 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: noahm@csail.mit.edu, linux-kernel@vger.kernel.org
Subject: Re: OOM problems with 2.6.11-rc4
Message-ID: <20050316183701.GB21597@opteron.random>
References: <20050315204413.GF20253@csail.mit.edu> <20050316003134.GY7699@opteron.random> <20050316040435.39533675.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050316040435.39533675.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2005 at 04:04:35AM -0800, Andrew Morton wrote:
> > +			if (!reclaim_state->reclaimed_slab &&
> > +			    zone->pages_scanned >= (zone->nr_active +
> > +						    zone->nr_inactive) * 4)
> >  				zone->all_unreclaimable = 1;
> 
> That might not change anything because we clear ->all_unreclaimable in
> free_page_bulk().  [..]

Really? free_page_bulk is called inside shrink_slab, and so it's overwritten
later by all_unreclaimable. Otherwise how could all_unreclaimable be set
in the first place if a single page freed by shrink_slab would be enough
to clear it?

	shrink_slab
	all_unreclaimable = 0
	zone->pages_scanned >= (zone->nr_active [..]
	all_unreclaimable = 1

							try_to_free_pages
							all_unreclaimable == 1
							oom

I also considering changing shrink_slab to return a progress retval, but
then I noticed I could get away with a one liner fix ;).

Your fix is better but it should be mostly equivalent in pratcie. I
liked the dontrylock not risking to go oom, the one liner couldn't
handle that ;).

thanks!
