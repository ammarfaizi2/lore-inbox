Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbVKAOt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbVKAOt2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 09:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbVKAOt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 09:49:28 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:27058 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750823AbVKAOt1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 09:49:27 -0500
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
From: Dave Hansen <haveblue@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Mel Gorman <mel@csn.ul.ie>, Nick Piggin <nickpiggin@yahoo.com.au>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
In-Reply-To: <20051101142959.GA9272@elte.hu>
References: <20051030235440.6938a0e9.akpm@osdl.org>
	 <27700000.1130769270@[10.10.2.4]> <4366A8D1.7020507@yahoo.com.au>
	 <Pine.LNX.4.58.0510312333240.29390@skynet> <4366C559.5090504@yahoo.com.au>
	 <Pine.LNX.4.58.0511010137020.29390@skynet> <4366D469.2010202@yahoo.com.au>
	 <Pine.LNX.4.58.0511011014060.14884@skynet> <20051101135651.GA8502@elte.hu>
	 <1130854224.14475.60.camel@localhost>  <20051101142959.GA9272@elte.hu>
Content-Type: text/plain
Date: Tue, 01 Nov 2005 15:49:15 +0100
Message-Id: <1130856555.14475.77.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-01 at 15:29 +0100, Ingo Molnar wrote:
> * Dave Hansen <haveblue@us.ibm.com> wrote:
> > > can you always, under any circumstance hot unplug RAM with these patches 
> > > applied? If not, do you have any expectation to reach 100%?
> > 
> > With these patches, no.  There are currently some very nice, 
> > pathological workloads which will still cause fragmentation.  But, in 
> > the interest of incremental feature introduction, I think they're a 
> > fine first step.  We can effectively reach toward a more comprehensive 
> > solution on top of these patches.
> > 
> > Reaching truly 100% will require some other changes such as being able 
> > to virtually remap things like kernel text.
> 
> then we need to see that 100% solution first - at least in terms of 
> conceptual steps.

I don't think saying "truly 100%" really even makes sense.  There will
always be restrictions of some kind.  For instance, with a 10MB kernel
image, should you be able to shrink the memory in the system below
10MB? ;)  

There is also no precedent in existing UNIXes for a 100% solution.  From
http://publib.boulder.ibm.com/infocenter/pseries/index.jsp?topic=/com.ibm.aix.doc/aixbman/prftungd/dlpar.htm , a seemingly arbitrary restriction:

	A memory region that contains a large page cannot be removed.

What the fragmentation patches _can_ give us is the ability to have 100%
success in removing certain areas: the "user-reclaimable" areas
referenced in the patch.  This gives a customer at least the ability to
plan for how dynamically reconfigurable a system should be.

After these patches, the next logical steps are to increase the
knowledge that the slabs have about fragmentation, and to teach some of
the shrinkers about fragmentation.

After that, we'll need some kind of virtual remapping, breaking the 1:1
kernel virtual mapping, so that the most problematic pages can be
remapped.  These pages would retain their virtual address, but getting a
new physical.  However, this is quite far down the road and will require
some serious evaluation because it impacts how normal devices are able
to to DMA.  The ppc64 proprietary hypervisor has features to work around
these issues, and any new hypervisors wishing to support partition
memory hotplug would likely have to follow suit.

-- Dave

