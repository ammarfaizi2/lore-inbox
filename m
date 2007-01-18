Return-Path: <linux-kernel-owner+w=401wt.eu-S932471AbXART5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471AbXART5l (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 14:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbXART5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 14:57:41 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:52324 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932471AbXART5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 14:57:39 -0500
Date: Thu, 18 Jan 2007 11:56:45 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Nikita Danilov <nikita@clusterfs.com>
cc: Paul Menage <menage@google.com>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Paul Jackson <pj@sgi.com>,
       Dave Chinner <dgc@sgi.com>
Subject: Re: [RFC 7/8] Exclude unreclaimable pages from dirty ration calculation
In-Reply-To: <17839.38576.779132.455963@gargle.gargle.HOWL>
Message-ID: <Pine.LNX.4.64.0701181152020.11639@schroedinger.engr.sgi.com>
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
 <20070116054819.15358.37282.sendpatchset@schroedinger.engr.sgi.com>
 <17839.38576.779132.455963@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jan 2007, Nikita Danilov wrote:

> I think that simpler solution of this problem is to use only potentially
> reclaimable pages (that is, active, inactive, and free pages) to
> calculate writeout threshold. This way there is no need to maintain
> counters for unreclaimable pages. Below is a patch implementing this
> idea, it got some testing.

Hmmm... the problem is that it is expensive to calculate these numbers on 
larger systems. In order to calculate active and inactive pages we 
have to first go through all the zones of the system. In a NUMA system 
there could be many zones.

> +/* Maximal number of pages that can be consumed by pageable caches. */
> +static unsigned long total_pageable_pages(void)
> +{
> +	unsigned long active;
> +	unsigned long inactive;
> +	unsigned long free;
> +
> +	get_zone_counts(&active, &inactive, &free);
> +	/* +1 to never return 0. */
> +	return active + inactive + free + 1;
> +}

An expensive function. And we need to call it whenever we calculate dirty 
limits.

Maybe could create ZVC counters that allow an inexpensive determination of 
these numbers? Then we first need to make sure that the counters are not 
assumed to be accurate at all times.


