Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964875AbWIDPgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbWIDPgR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 11:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964877AbWIDPgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 11:36:17 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:54190 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S964876AbWIDPgP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 11:36:15 -0400
Date: Mon, 4 Sep 2006 16:36:13 +0100
To: Keith Mannthey <kmannth@gmail.com>
Cc: akpm@osdl.org, tony.luck@intel.com,
       Linux Memory Management List <linux-mm@kvack.org>, ak@suse.de,
       bob.picco@hp.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 4/6] Have x86_64 use add_active_range() and free_area_init_nodes
Message-ID: <20060904153613.GA14263@skynet.ie>
References: <20060821134518.22179.46355.sendpatchset@skynet.skynet.ie> <20060821134638.22179.44471.sendpatchset@skynet.skynet.ie> <a762e240608301357n3915250bk8546dd340d5d4d77@mail.gmail.com> <20060831154903.GA7011@skynet.ie> <a762e240608311052h28843b2ege651e9fa82c49f2a@mail.gmail.com> <Pine.LNX.4.64.0608311906300.13392@skynet.skynet.ie> <a762e240608312008v3e35b63ay46c95fbb6c3f15ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <a762e240608312008v3e35b63ay46c95fbb6c3f15ec@mail.gmail.com>
User-Agent: Mutt/1.5.9i
From: mel@skynet.ie (Mel Gorman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On (31/08/06 20:08), Keith Mannthey didst pronounce:
> >So, do you actally expect a lot of unused mem_map to be allocated with
> >struct pages that are inactive until memory is hot-added in an
> >x86_64-specific manner? The arch-independent stuff currently will not do
> >that. It sets up memmap for where memory really exists. If that is not
> >what you expect, it will hit issues at hotadd time which is not the
> >current issue but one that can be fixed.
> 
> Yes. RESERVED based is a big waste of mem_map space.  The add areas
> are marked as RESERVED during boot and then later onlined during add.
> It might be ok.  I will play with tomorrow.  I might just need to
> call add_active_range in the right spot :)
> 

Following this mail should be two patches that may address the problem
with reserved memory hot-add. One assumption made by arch-independent
zone-sizing was that the only memory holes of interest were those before the
end of physical memory.  Another assumption was that mem_map should only be
allocated for memory that was physically present in the machine.

With MEMORY_HOTPLUG_RESERVE on x86_64, these assumptions do not hold. This
feature expects that mem_map is allocated at boot time and later activated
on a memory hot-add event. To determine if the region is usable for hot-add
in the future, holes are calculated beyond the end of physical memory.

The following two patches fix these two assumptions. They have been boot-tested
on a range of hardware (x86, ppc64, ia64 and x86_64) so there should be no
new regressions.

I don't have access to hardware that can use MEMORY_HOTPLUG_RESERVE so I'd
appreciate hearing if the patches work. I wrote a test program that simulated
the input from the machine the problem was reported on.  It registers active
memory and simulates the check made by reserve_hotadd(). push_node_boundaries()
is called to push the end of the node out by 100 pages like what SRAT would
do for reserve hot-add and it appears to do the right thing. Output is below.

mel@arnold:~/patches/brokenout/zonesizing/driver_test$ gcc driver_test.c -o
driver_test && ./driver_test | grep -v "active with" | grep -v
account_node_boundary
Stage 1: Registering active ranges
Entering add_active_range(0, 0, 152) 0 entries of 96 used
Entering add_active_range(0, 256, 524165) 1 entries of 96 used
Entering add_active_range(0, 1048576, 4653056) 2 entries of 96 used
Entering add_active_range(1, 17235968, 18219008) 3 entries of 96 used

Dumping active map
0: 0  0 -> 152
1: 0  256 -> 524165
2: 0  1048576 -> 4653056
3: 1  17235968 -> 18219008
Entering push_node_boundaries(0, 0, 4653156)

Checking reserve-hotadd
  absent_pages_in_range(4653056, 17235968) == 17235968 - 4653056 == 12582912
  absent_pages_in_range(18219008, 52428800) == 52428800 - 18219008 == 34209792

Stage 2: Calculating zone sizes and holes

Stage 3: Dumping zone sizes and holes
zone_size[0][0] =     4096 zone_holes[0][0] =      104
zone_size[0][1] =  1044480 zone_holes[0][1] =   524411
zone_size[0][2] =  3604580 zone_holes[0][2] =      100
zone_size[1][2] =   983040 zone_holes[1][2] =        0

Stage 4: Printing present pages
On node 0, 4128541 pages
 zone 0 present_pages = 3992
 zone 1 present_pages = 520069
 zone 2 present_pages = 3604480
On node 1, 983040 pages
 zone 2 present_pages = 983040

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
