Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750889AbWIADJA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbWIADJA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 23:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbWIADJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 23:09:00 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:11111 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750867AbWIADI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 23:08:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ET2pcpZPbtOdCc3CCAMzturJ1lIGn8ffjYp2c/SjMHALxlPyfrFaorjJr9QZBAMVR9Czi9+8KMFa4bkdakmtavo0ppykaQAwLsV95ghh2SCv7lnbA/F5uT7/zC6KEjkOsRH0/wrEqzTan3U839dqhXDsZ2KMP7ZlUjN5UDJ60Kw=
Message-ID: <a762e240608312008v3e35b63ay46c95fbb6c3f15ec@mail.gmail.com>
Date: Thu, 31 Aug 2006 20:08:58 -0700
From: "Keith Mannthey" <kmannth@gmail.com>
To: "Mel Gorman" <mel@csn.ul.ie>
Subject: Re: [PATCH 4/6] Have x86_64 use add_active_range() and free_area_init_nodes
Cc: akpm@osdl.org, tony.luck@intel.com,
       "Linux Memory Management List" <linux-mm@kvack.org>, ak@suse.de,
       bob.picco@hp.com,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       linuxppc-dev@ozlabs.org
In-Reply-To: <Pine.LNX.4.64.0608311906300.13392@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060821134518.22179.46355.sendpatchset@skynet.skynet.ie>
	 <20060821134638.22179.44471.sendpatchset@skynet.skynet.ie>
	 <a762e240608301357n3915250bk8546dd340d5d4d77@mail.gmail.com>
	 <20060831154903.GA7011@skynet.ie>
	 <a762e240608311052h28843b2ege651e9fa82c49f2a@mail.gmail.com>
	 <Pine.LNX.4.64.0608311906300.13392@skynet.skynet.ie>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/06, Mel Gorman <mel@csn.ul.ie> wrote:
> On Thu, 31 Aug 2006, Keith Mannthey wrote:
> > On 8/31/06, Mel Gorman <mel@skynet.ie> wrote:
> >> On (30/08/06 13:57), Keith Mannthey didst pronounce:
> >> > On 8/21/06, Mel Gorman <mel@csn.ul.ie> wrote:
> >> > >

> Can you confirm that happens by applying the patch I sent to you and
> checking the output? When the reserve fails, it should print out what
> range it actually checked. I want to be sure it's not checking the
> addresses 0->0x1070000000

See below

> >> > >@@ -329,6 +330,8 @@ acpi_numa_memory_affinity_init(struct ac
> >> > >
> >> > >        printk(KERN_INFO "SRAT: Node %u PXM %u %Lx-%Lx\n", node, pxm,
> >> > >               nd->start, nd->end);
> >> > >+       e820_register_active_regions(node, nd->start >> PAGE_SHIFT,
> >> > >+                                               nd->end >> PAGE_SHIFT);
> >> >
> >> > A node chunk in this section of code may be a hot-pluggable zone. With
> >> > MEMORY_HOTPLUG_SPARSE we don't want to register these regions.
> >> >
> >>
> >> The ranges should not get registered as active memory by
> >> e820_register_active_regions() unless they are marked E820_RAM. My
> >> understanding is that the regions for hotadd would be marked "reserved"
> >> in the e820 map. Is that wrong?
> >
> > This is wrong.  In a mult-node system that last node add area will not
> > be marked reserved by the e820.  The e820 only defines memory <
> > end_pfn. the last node add area is > end_pfn.
> >
>
> ok, that should still be fine. As long as the ranges are not marked
> "usable", add_active_range() will not be called and the holes should be
> counted correctly with the patch I sent you.
>
> > With RESERVE based add-memory you want the add-areas repored by the
> > srat to be setup during boot like all the other pages.
> >
>
> So, do you actally expect a lot of unused mem_map to be allocated with
> struct pages that are inactive until memory is hot-added in an
> x86_64-specific manner? The arch-independent stuff currently will not do
> that. It sets up memmap for where memory really exists. If that is not
> what you expect, it will hit issues at hotadd time which is not the
> current issue but one that can be fixed.

Yes. RESERVED based is a big waste of mem_map space.  The add areas
are marked as RESERVED during boot and then later onlined during add.
 It might be ok.  I will play with tomorrow.  I might just need to
call add_active_range in the right spot :)

> >> > >        if (ma->flags.hot_pluggable && !reserve_hotadd(node, start, end)
> >> <
> >> > >        0) {
> >> > >                /* Ignore hotadd region. Undo damage */
> >> >
> >> >  I have but the e820_register_active_regions as a else to this
> >> > statment the absent pages check fails.
> >> >
> >>
> >> The patch below omits this change because I think
> >> e820_register_active_regions() will still have got called by the time
> >> you encounter a hotplug area.
> >
> > called but then removed in setup arch.
>
> By "removed", I assume you mean the active regions removed by the call
> to remove_all_active_regions() in setup_arch(). Before reserve_hotadd() is
> called, e820_register_active_regions() will have reregistered the active
> regions with the NUMA node id.

I see e820_register_active_regions is acting as a filter against the e820

> >> > Also nodes_cover_memory and alot of these check were based against
> >> > comparing the srat data against the e820.  Now all this code is
> >> > comparing SRAT against SRAT....
> >> >
> >>
> >> I don't see why. The SRAT table passes a range to
> >> e820_register_active_regions() so should be comparing SRAT to e820
> >
> > let me go off and look at e820_register_active_regions() some more.
Things get clear :)

Should be ok.

> > Sure thing.  It is just the hot-add area I am guessing it is an off by
> > one error of some sort.
> >
See below. I do my e820_register_active_area as an else to to if
(hotplug.....!reserve) and the prink is easy to sort out.

I see your pfn are in base 10.  Looks like it considers the last
addres to be a present page. (off by one thing).

Thanks,
  Keith

Output below
disabling early console
Linux version 2.6.18-rc4-mm3-smp (root@elm3a153) (gcc version 4.1.0
(SUSE Linux)) #6 SMP Thu Aug 31 22:06:00 EDT 2006
Command line: root=/dev/sda3
ip=9.47.66.153:9.47.66.169:9.47.66.1:255.255.255.0 resume=/dev/sda2
showopts earlyprintk=ttyS0,115200 console=ttyS0,115200 console=tty0
debug numa=hotadd=100
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 0000000000098400 (usable)
 BIOS-e820: 0000000000098400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ff85e00 (usable)
 BIOS-e820: 000000007ff85e00 - 000000007ff98880 (ACPI data)
 BIOS-e820: 000000007ff98880 - 0000000080000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000470000000 (usable)
 BIOS-e820: 0000001070000000 - 0000001160000000 (usable)
Entering add_active_range(0, 0, 152) 0 entries of 3200 used
Entering add_active_range(0, 256, 524165) 1 entries of 3200 used
Entering add_active_range(0, 1048576, 4653056) 2 entries of 3200 used
Entering add_active_range(0, 17235968, 18219008) 3 entries of 3200 used
end_pfn_map = 18219008
DMI 2.3 present.
ACPI: RSDP (v000 IBM                                   ) @ 0x00000000000fdcf0
ACPI: RSDT (v001 IBM    EXA01ZEU 0x00001000 IBM  0x45444f43) @
0x000000007ff98800
ACPI: FADT (v001 IBM    EXA01ZEU 0x00001000 IBM  0x45444f43) @
0x000000007ff98780
ACPI: MADT (v001 IBM    EXA01ZEU 0x00001000 IBM  0x45444f43) @
0x000000007ff98600
ACPI: SRAT (v001 IBM    EXA01ZEU 0x00001000 IBM  0x45444f43) @
0x000000007ff983c0
ACPI: HPET (v001 IBM    EXA01ZEU 0x00001000 IBM  0x45444f43) @
0x000000007ff98380
ACPI: SSDT (v001 IBM    VIGSSDT0 0x00001000 INTL 0x20030122) @
0x000000007ff90780
ACPI: SSDT (v001 IBM    VIGSSDT1 0x00001000 INTL 0x20030122) @
0x000000007ff88bc0
ACPI: DSDT (v001 IBM    EXA01ZEU 0x00001000 INTL 0x20030122) @
0x0000000000000000
SRAT: PXM 0 -> APIC 0 -> Node 0
SRAT: PXM 0 -> APIC 1 -> Node 0
SRAT: PXM 0 -> APIC 2 -> Node 0
SRAT: PXM 0 -> APIC 3 -> Node 0
SRAT: PXM 0 -> APIC 38 -> Node 0
SRAT: PXM 0 -> APIC 39 -> Node 0
SRAT: PXM 0 -> APIC 36 -> Node 0
SRAT: PXM 0 -> APIC 37 -> Node 0
SRAT: PXM 1 -> APIC 64 -> Node 1
SRAT: PXM 1 -> APIC 65 -> Node 1
SRAT: PXM 1 -> APIC 66 -> Node 1
SRAT: PXM 1 -> APIC 67 -> Node 1
SRAT: PXM 1 -> APIC 102 -> Node 1
SRAT: PXM 1 -> APIC 103 -> Node 1
SRAT: PXM 1 -> APIC 100 -> Node 1
SRAT: PXM 1 -> APIC 101 -> Node 1
SRAT: Node 0 PXM 0 0-80000000
Entering add_active_range(0, 0, 152) 0 entries of 3200 used
Entering add_active_range(0, 256, 524165) 1 entries of 3200 used
SRAT: Node 0 PXM 0 0-470000000
Entering add_active_range(0, 0, 152) 2 entries of 3200 used
Entering add_active_range(0, 256, 524165) 2 entries of 3200 used
Entering add_active_range(0, 1048576, 4653056) 2 entries of 3200 used
SRAT: Node 0 PXM 0 0-1070000000
reserve_hotadd called with node 0 sart 470000000 end 1070000000
SRAT: Hotplug area has existing memory
Entering add_active_range(0, 0, 152) 3 entries of 3200 used
Entering add_active_range(0, 256, 524165) 3 entries of 3200 used
Entering add_active_range(0, 1048576, 4653056) 3 entries of 3200 used
SRAT: Node 1 PXM 1 1070000000-1160000000
Entering add_active_range(1, 17235968, 18219008) 3 entries of 3200 used
SRAT: Node 1 PXM 1 1070000000-3200000000
reserve_hotadd called with node 1 sart 1160000000 end 3200000000
SRAT: Hotplug area has existing memory
Entering add_active_range(1, 17235968, 18219008) 4 entries of 3200 used
NUMA: Using 28 for the hash shift.
Bootmem setup node 0 0000000000000000-0000001070000000
Bootmem setup node 1 0000001070000000-0000001160000000
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 -> 18219008
early_node_map[4] active PFN ranges
    0:        0 ->      152
    0:      256 ->   524165
    0:  1048576 ->  4653056
    1: 17235968 -> 18219008
On node 0 totalpages: 4128541
0 pages used for SPARSE memmap
1149 pages DMA reserved
  DMA zone: 2843 pages, LIFO batch:0
0 pages used for SPARSE memmap
  DMA32 zone: 520069 pages, LIFO batch:31
0 pages used for SPARSE memmap
  Normal zone: 3604480 pages, LIFO batch:31
On node 1 totalpages: 983040
0 pages used for SPARSE memmap
0 pages used for SPARSE memmap
0 pages used for SPARSE memmap
  Normal zone: 983040 pages, LIFO batch:31
