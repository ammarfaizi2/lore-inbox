Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbWHaRwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbWHaRwa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 13:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWHaRwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 13:52:30 -0400
Received: from nz-out-0102.google.com ([64.233.162.207]:34310 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932417AbWHaRw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 13:52:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bBOlu4J64YmK+K9FAkkK7khIPNz8H30rUligDRzKOK8ktEFSKWqpiJYCcjmQpYX+a9Uj6WBx1+cEPNOwKHMmvJD+5lC8JXQYDmkMahVnlAwxCGuE1NJ9uT/vRUbfmya3s5FpsRdWmKtaqgGwK4C2RkekTkiaSskWPYdaym24kp0=
Message-ID: <a762e240608311052h28843b2ege651e9fa82c49f2a@mail.gmail.com>
Date: Thu, 31 Aug 2006 10:52:28 -0700
From: "Keith Mannthey" <kmannth@gmail.com>
To: "Mel Gorman" <mel@skynet.ie>
Subject: Re: [PATCH 4/6] Have x86_64 use add_active_range() and free_area_init_nodes
Cc: akpm@osdl.org, tony.luck@intel.com, linux-mm@kvack.org, ak@suse.de,
       bob.picco@hp.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
In-Reply-To: <20060831154903.GA7011@skynet.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060821134518.22179.46355.sendpatchset@skynet.skynet.ie>
	 <20060821134638.22179.44471.sendpatchset@skynet.skynet.ie>
	 <a762e240608301357n3915250bk8546dd340d5d4d77@mail.gmail.com>
	 <20060831154903.GA7011@skynet.ie>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/06, Mel Gorman <mel@skynet.ie> wrote:
> On (30/08/06 13:57), Keith Mannthey didst pronounce:
> > On 8/21/06, Mel Gorman <mel@csn.ul.ie> wrote:
> > >

> ok, great. How much physical memory is installed on the machine? I want to
> determine if the "usable" entries in the e820 map contain physical memory
> or not.
Usable entries in the e820 contian memory.  I have about 20-24gb
depending on config.


> When the SRAT is bad, the information is discarded and discovered by an
> alternative method later in the boot process.
>
> In this case, numa_initmem_init() is called after acpi_numa_init(). It
> calls acpi_scan_nodes() which returns -1 because the SRAT is bad. Once
> that happens, either k8_scan_nodes() will be called and the regions
> discovered there or if that is not possible, it'll fall through and
> e820_register_active_regions will be called without any node awareness.

sorry I have missed some of the logic in this patch.

I see now in numa_initmem_init that if no numa setup is found it calls
e820_register_active_regions(0, start_pfn, end_pfn) again.

So if the srat is discard it runs the e820 code again.


> > >diff -rup -X /usr/src/patchset-0.6/bin//dontdiff
> > >linux-2.6.18-rc4-mm2-103-x86_use_init_nodes/arch/x86_64/mm/srat.c
> > >linux-2.6.18-rc4-mm2-104-x86_64_use_init_nodes/arch/x86_64/mm/srat.c
> > >--- linux-2.6.18-rc4-mm2-103-x86_use_init_nodes/arch/x86_64/mm/srat.c
> > >2006-08-21 09:23:50.000000000 +0100
> > >+++ linux-2.6.18-rc4-mm2-104-x86_64_use_init_nodes/arch/x86_64/mm/srat.c
> > >2006-08-21 10:15:58.000000000 +0100
> > >@@ -84,6 +84,7 @@ static __init void bad_srat(void)
> > >                apicid_to_node[i] = NUMA_NO_NODE;
> > >        for (i = 0; i < MAX_NUMNODES; i++)
> > >                nodes_add[i].start = nodes[i].end = 0;
> > >+       remove_all_active_ranges();
> > > }
> >
> > We go back to setup_arch with no active areas?
> >
>
> Yes, and it'll be discovered using an alternative method later. There is
> no point returning to setup_arch with known bad information about active
> areas.

Totally agreeded! I just didn't the the fallback path.
>
> > > static __init inline int srat_disabled(void)
> > >@@ -166,7 +167,7 @@ static int hotadd_enough_memory(struct b
> > >
> > >        if (mem < 0)
> > >                return 0;
> > >-       allowed = (end_pfn - e820_hole_size(0, end_pfn)) * PAGE_SIZE;
> > >+       allowed = (end_pfn - absent_pages_in_range(0, end_pfn)) *
> > >PAGE_SIZE;
> > >        allowed = (allowed / 100) * hotadd_percent;
> > >        if (allocated + mem > allowed) {
> > >                unsigned long range;
> > >@@ -238,7 +239,7 @@ static int reserve_hotadd(int node, unsi
> > >        }
> > >
> > >        /* This check might be a bit too strict, but I'm keeping it for
> > >        now. */
> > >-       if (e820_hole_size(s_pfn, e_pfn) != e_pfn - s_pfn) {
> > >+       if (absent_pages_in_range(s_pfn, e_pfn) != e_pfn - s_pfn) {
> > >                printk(KERN_ERR "SRAT: Hotplug area has existing
> > >                memory\n");
> > >                return -1;
> > >        }
> > We really do want to to compare against the e820 map at it contains
> > the memory that is really present (this info was blown away before
> > acpi_numa)
>
> The information used by absent_pages_in_range() should match what was
> available to e820_hole_size().

Is absent_pages_in_range a check against the e820 or the
add_pages_to_range calls?

> > Anyway I fixed up to have the current chunk added
> > (e820_register_active_regions) after calling this code so it logicaly
> > makes sense but it still trip over the check.
> > I am not sure what you
> > are printing out in you debug code but dosen't look like pfns or
> > phys_addresses but maybe it can tell us why the check fails.
> >
>
> My debug code for add_active_range() printing out pfns but I spotted one
> case where absent_pages_in_range(I) does not do what one would expect.
> Lets say the ranges with physical memory was 0->1000 and 2000-3000 (in
> pfns).  absent_pages_in_range(0, 3000) would return 1000 as you'd expect but
> absent_pages_in_range(5000-6000) would return 0! I have a patch that might
> fix this at the end of the mail but I'm not sure it's the problem you are
> hitting. In the bootlog, I see;
>
> SRAT: Node 0 PXM 0 0-80000000
> Entering add_active_range(0, 0, 152) 0 entries of 3200 used
> Entering add_active_range(0, 256, 524165) 1 entries of 3200 used
> SRAT: Node 0 PXM 0 0-470000000
> Entering add_active_range(0, 0, 152) 2 entries of 3200 used
> Entering add_active_range(0, 256, 524165) 2 entries of 3200 used
> Entering add_active_range(0, 1048576, 4653056) 2 entries of 3200 used
> SRAT: Node 0 PXM 0 0-1070000000
> SRAT: Hotplug area has existing memory
>

> The last part (0-1070000000) is checked as a hotplug area but it's clear
> that memory exists in that range.  As reserve_hotadd() requires that the
> whole range be a hole, I'm having trouble seeing how it ever successfully
> reserved unless the ranges going into reserve_hotadd() are something other
> than the pfn range for 0-1070000000). The patch later will print out the
> range used by reserve_hotadd() so we can see.

No the whole node is 0-1070000000 the hot add range is 470000000-1070000000
reserve_hotadd is called with start and end not nd->start nd->end.
470000000-1070000000 sould be empty.


> > >@@ -329,6 +330,8 @@ acpi_numa_memory_affinity_init(struct ac
> > >
> > >        printk(KERN_INFO "SRAT: Node %u PXM %u %Lx-%Lx\n", node, pxm,
> > >               nd->start, nd->end);
> > >+       e820_register_active_regions(node, nd->start >> PAGE_SHIFT,
> > >+                                               nd->end >> PAGE_SHIFT);
> >
> > A node chunk in this section of code may be a hot-pluggable zone. With
> > MEMORY_HOTPLUG_SPARSE we don't want to register these regions.
> >
>
> The ranges should not get registered as active memory by
> e820_register_active_regions() unless they are marked E820_RAM. My
> understanding is that the regions for hotadd would be marked "reserved"
> in the e820 map. Is that wrong?

This is wrong.  In a mult-node system that last node add area will not
be marked reserved by the e820.  The e820 only defines memory <
end_pfn. the last node add area is > end_pfn.

With RESERVE based add-memory you want the add-areas repored by the
srat to be setup during boot like all the other pages.

> > >        if (ma->flags.hot_pluggable && !reserve_hotadd(node, start, end) <
> > >        0) {
> > >                /* Ignore hotadd region. Undo damage */
> >
> >  I have but the e820_register_active_regions as a else to this
> > statment the absent pages check fails.
> >
>
> The patch below omits this change because I think
> e820_register_active_regions() will still have got called by the time
> you encounter a hotplug area.

called but then removed in setup arch.
> > Also nodes_cover_memory and alot of these check were based against
> > comparing the srat data against the e820.  Now all this code is
> > comparing SRAT against SRAT....
> >
>
> I don't see why. The SRAT table passes a range to
> e820_register_active_regions() so should be comparing SRAT to e820

let me go off and look at e820_register_active_regions() some more.

> > I am willing to help here but we should compare the SRAT against to
> > e820. Table v. Table.
> >
> > What to you think should be done?
> >
>
> Can you read through this patch and see does it address the problem in any
> way? If it doesn't, can you send a complete bootlog so I can see what is
> being sent to reserve_hotadd()? Thanks

Sure thing.  It is just the hot-add area I am guessing it is an off by
one error of some sort.

What is all this code buying us?  Since this code dosen't appear to do
anything to help the arch out (just increases it's vm boot code
complexity a little) maybe insead of weaving
e820_register_active_regions() calls throught out the boot process you
should just waint untill things are sorted out and do a quick scan of
node data that has been setup at the end?

What are the future plans for this api?

Thanks,
  Keith u
