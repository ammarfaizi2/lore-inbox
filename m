Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbWBOKdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWBOKdg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 05:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbWBOKdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 05:33:36 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:46225 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751103AbWBOKdf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 05:33:35 -0500
Date: Wed, 15 Feb 2006 16:08:13 +0530
From: Bharata B Rao <bharata@in.ibm.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Andi Kleen <ak@suse.de>, Ray Bryant <raybry@mpdtxmail.amd.com>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] mmap, mbind and write to mmap'ed memory crashes 2.6.16-rc1[2] on 2 node X86_64
Message-ID: <20060215103813.GD2966@in.ibm.com>
Reply-To: bharata@in.ibm.com
References: <20060205163618.GB21972@in.ibm.com> <200602081706.26853.ak@suse.de> <20060209043933.GA2986@in.ibm.com> <200602091058.26811.ak@suse.de> <Pine.LNX.4.64.0602141131280.14488@schroedinger.engr.sgi.com> <20060215054620.GA2966@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060215054620.GA2966@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2006 at 11:16:20AM +0530, Bharata B Rao wrote:
> On Tue, Feb 14, 2006 at 11:33:00AM -0800, Christoph Lameter wrote:
> > I just took another look at this issue and I cannot see anything wrong. An 
> > empty zone should be ignored by the page allocator since nr_free == 0. My 
> > patch should not be needed.
> 
> There is a check for list_empty(&area->free_list) in __rmqueue(), which
> I think is one of the points in the page allocator where the emptiness of
> the free_area list is checked. The current zone(when the crash happens)
> bypasses this test leading to this crash.
> 

We don't initialize the free_area list for all zones. Instead,
free_area_init_core() does that only for zones which are non-empty.

But in __rmqueue(), we depend on these free_area lists to be intialized
correctly for all zones, which is not true in the present case we
are discussing.

I think we either need to initialize free_area lists for all zones
or check for !zone->free_area->nr_free in __rmqueue().

Even with this, mbind still needs to be fixed. Even though it
can't get a conforming zone in the node (MPOL_BIND case), right now,
it goes ahead with the "bind"ing of the memory area. This causes the
application to crash (assuming we have fixed the __rmqueue kernel crash)
(Haven't yet figured our why exactly the application dies)

Regards,
Bharata.
