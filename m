Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161087AbVKDHhz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161087AbVKDHhz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 02:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161089AbVKDHhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 02:37:55 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:2519 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1161087AbVKDHhy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 02:37:54 -0500
Date: Fri, 4 Nov 2005 08:37:50 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Paul Jackson <pj@sgi.com>
Cc: torvalds@osdl.org, andy@thermo.lanl.gov, mbligh@mbligh.org, akpm@osdl.org,
       arjan@infradead.org, arjanv@infradead.org, haveblue@us.ibm.com,
       kravetz@us.ibm.com, lhms-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, mel@csn.ul.ie,
       nickpiggin@yahoo.com.au
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Message-ID: <20051104073750.GA21321@elte.hu>
References: <20051104010021.4180A184531@thermo.lanl.gov> <Pine.LNX.4.64.0511032105110.27915@g5.osdl.org> <20051103221037.33ae0f53.pj@sgi.com> <20051104063820.GA19505@elte.hu> <20051103232649.12e58615.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051103232649.12e58615.pj@sgi.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul Jackson <pj@sgi.com> wrote:

> At first glance, this is the sticky point that jumps out at me.
> 
> Andy wrote:
> >    My experience is that after some days or weeks of running have gone
> >    by, there is no possible way short of a reboot to get pages merged
> >    effectively back to any pristine state with the infrastructure that 
> >    exists there.
> 
> I take it, from what Andy writes, and from my other experience with 
> similar customers, that his workload is not "well-behaved" in the 
> sense you hoped for.
> 
> After several diverse jobs are run, we cannot, so far as I know, merge 
> small pages back to big pages.

ok, so the zone solution it has to be. I.e. the moment it's a separate 
special zone, you can boot with most of the RAM being in that zone, and 
you are all set. It can be used both for hugetlb allocations, and for 
other PAGE_SIZE allocations as well, in a highmem-fashion. These HPC 
setups are rarely kernel-intense.

Thus the only dynamic sizing decision that has to be taken is to 
determine the amount of 'generic kernel RAM' that is needed in the 
worst-case. To give an example: say on a 256 GB box, set aside 8 GB for 
generic kernel needs, and have 248 GB in the hugemem zone. This leaves 
us with the following scenario: apps can use up to 97% of all RAM for 
hugemem, and they can use up to 100% of all RAM for PAGE_SIZE 
allocations. 3% of RAM can be used by generic kernel needs. Sounds 
pretty reasonable and straightforward from a system management point of 
view. No runtime resizing, but it wouldnt be needed, unless kernel 
activity needs more than 8GB of RAM.

	Ingo
