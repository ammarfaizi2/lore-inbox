Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbVHYSnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbVHYSnI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 14:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbVHYSnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 14:43:08 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:26592 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S932333AbVHYSnH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 14:43:07 -0400
Subject: Re: Need better is_better_time_interpolator() algorithm
From: Alex Williamson <alex.williamson@hp.com>
To: john stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1124991406.20820.188.camel@cog.beaverton.ibm.com>
References: <1124988269.5331.49.camel@tdi>
	 <1124991406.20820.188.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Organization: LOSL
Date: Thu, 25 Aug 2005 12:43:25 -0600
Message-Id: <1124995405.5331.90.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-25 at 10:36 -0700, john stultz wrote:
> On Thu, 2005-08-25 at 10:44 -0600, Alex Williamson wrote:
> > How can we munge these all together to come up with a single goodness
> > factor for comparison?  There's probably a thesis covering algorithms to
> > handle this.  Anyone know of one or have some good ideas?  Thanks,
> 
> With my timeofday rework code, the timesource structure (which was
> influenced by the time interpolators) just uses a fixed "priority" vale.
...
> Realistically I don't think too many systems will have multiple out of
> tree timesources, so assigning the correct priority value shouldn't be
> too difficult.
> 
> This just seemed a bit more straight forward then sorting out some
> weighting algorithm for their properties to select the best timesource. 

   I don't know that it's that uncommon.  Simply having one non-arch
specific timer is enough to need to decided whether it's better than a
generic timer.  I assume pretty much every arch has a cycle timer.  For
smaller boxes, this might be the preferred timer given it's latency even
if something like an hpet exists (mmio access are expensive).  How do
you hard code a value that can account for that?  I agree, we could
easily go too far and produce some bloated algorithm, but maybe it's
simply a weighted product of a few variables.

To start with, what would this do:

(frequency) * (1/drift) * (1/latency) * (1/(jitter_factor * cpus))

Something this simple at least starts to dynamically bring the factors
together.  All else being equal (and with no weighting), this would give
the 1.5GHz/750ppm timer a higher priority than the 250MHz/500ppm timer.
Is that good?  I like your idea to make this user tunable after boot,
but I still think there has to be a way to make a smarter decision up
front.  Thanks,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab

