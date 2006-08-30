Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751572AbWH3U52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbWH3U52 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 16:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751573AbWH3U51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 16:57:27 -0400
Received: from nz-out-0102.google.com ([64.233.162.195]:13707 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751570AbWH3U51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 16:57:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZonAgXA4vKqEaASoF5LTy5bRbVjkj24q2P6Hf6GW3Ulr9BLfG3ZzEQtqixoX8lY7qJwYJwfqx3pv3m6Y1PXz/VyVYDeecJVi/KqNF1AqbqQRS64wF+OUTgoqZwCyNfiIMBlooRw6tmRHfdLlcQHr6WJoBEz2Ocnqar5MKlkpEV8=
Message-ID: <a762e240608301357n3915250bk8546dd340d5d4d77@mail.gmail.com>
Date: Wed, 30 Aug 2006 13:57:25 -0700
From: "Keith Mannthey" <kmannth@gmail.com>
To: "Mel Gorman" <mel@csn.ul.ie>
Subject: Re: [PATCH 4/6] Have x86_64 use add_active_range() and free_area_init_nodes
Cc: akpm@osdl.org, tony.luck@intel.com, linux-mm@kvack.org, ak@suse.de,
       bob.picco@hp.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
In-Reply-To: <20060821134638.22179.44471.sendpatchset@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060821134518.22179.46355.sendpatchset@skynet.skynet.ie>
	 <20060821134638.22179.44471.sendpatchset@skynet.skynet.ie>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/06, Mel Gorman <mel@csn.ul.ie> wrote:
>
> Size zones and holes in an architecture independent manner for x86_64.


Hey Mel,
  I am having some trouble with the srat.c changes.  I keep running into
"SRAT: Hotplug area has existing memory" so am am taking more throught
look at this patch.
  I am working on 2.6.18-rc4-mm3 x86_64.

   srat.c is doing some sanity checking against the e820 and hot-add
memory ranges.  BIOS folk aren't to be trusted with the SRAT.  Calling
 remove_all_active_ranges before acpi_numa_init leaves nothing to fall
back onto if the SRAT is bad.  (see bad_srat()). What should happen
when we discard the srat info?

  i386 code may have similar fallback logic (haven't been there in a while)

also

> diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.18-rc4-mm2-103-x86_use_init_nodes/arch/x86_64/mm/srat.c linux-2.6.18-rc4-mm2-104-x86_64_use_init_nodes/arch/x86_64/mm/srat.c
> --- linux-2.6.18-rc4-mm2-103-x86_use_init_nodes/arch/x86_64/mm/srat.c   2006-08-21 09:23:50.000000000 +0100
> +++ linux-2.6.18-rc4-mm2-104-x86_64_use_init_nodes/arch/x86_64/mm/srat.c        2006-08-21 10:15:58.000000000 +0100
> @@ -84,6 +84,7 @@ static __init void bad_srat(void)
>                 apicid_to_node[i] = NUMA_NO_NODE;
>         for (i = 0; i < MAX_NUMNODES; i++)
>                 nodes_add[i].start = nodes[i].end = 0;
> +       remove_all_active_ranges();
>  }

We go back to setup_arch with no active areas?

>  static __init inline int srat_disabled(void)
> @@ -166,7 +167,7 @@ static int hotadd_enough_memory(struct b
>
>         if (mem < 0)
>                 return 0;
> -       allowed = (end_pfn - e820_hole_size(0, end_pfn)) * PAGE_SIZE;
> +       allowed = (end_pfn - absent_pages_in_range(0, end_pfn)) * PAGE_SIZE;
>         allowed = (allowed / 100) * hotadd_percent;
>         if (allocated + mem > allowed) {
>                 unsigned long range;
> @@ -238,7 +239,7 @@ static int reserve_hotadd(int node, unsi
>         }
>
>         /* This check might be a bit too strict, but I'm keeping it for now. */
> -       if (e820_hole_size(s_pfn, e_pfn) != e_pfn - s_pfn) {
> +       if (absent_pages_in_range(s_pfn, e_pfn) != e_pfn - s_pfn) {
>                 printk(KERN_ERR "SRAT: Hotplug area has existing memory\n");
>                 return -1;
>         }
We really do want to to compare against the e820 map at it contains
the memory that is really present (this info was blown away before
acpi_numa)  Anyway I fixed up to have the current chunk added
(e820_register_active_regions) after calling this code so it logicaly
makes sense but it still trip over the check.   I am not sure what you
are printing out in you debug code but dosen't look like pfns or
phys_addresses but maybe it can tell us why the check fails.

> @@ -329,6 +330,8 @@ acpi_numa_memory_affinity_init(struct ac
>
>         printk(KERN_INFO "SRAT: Node %u PXM %u %Lx-%Lx\n", node, pxm,
>                nd->start, nd->end);
> +       e820_register_active_regions(node, nd->start >> PAGE_SHIFT,
> +                                               nd->end >> PAGE_SHIFT);

A node chunk in this section of code may be a hot-pluggable zone. With
MEMORY_HOTPLUG_SPARSE we don't want to register these regions.

>         if (ma->flags.hot_pluggable && !reserve_hotadd(node, start, end) < 0) {
>                 /* Ignore hotadd region. Undo damage */

  I have but the e820_register_active_regions as a else to this
statment the absent pages check fails.

Also nodes_cover_memory and alot of these check were based against
comparing the srat data against the e820.  Now all this code is
comparing SRAT against SRAT....

I am willing to help here but we should compare the SRAT against to
e820. Table v. Table.

What to you think should be done?

Thanks,
  Keith

Linux version 2.6.18-rc4-mm3-smp (root@elm3a153) (gcc version 4.1.0
(SUSE Linux)) #3 SMP Wed Aug 30 15:17:13 EDT 2006
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
SRAT: Hotplug area has existing memory
Entering add_active_range(0, 0, 152) 3 entries of 3200 used
Entering add_active_range(0, 256, 524165) 3 entries of 3200 used
Entering add_active_range(0, 1048576, 4653056) 3 entries of 3200 used
SRAT: Node 1 PXM 1 1070000000-1160000000
Entering add_active_range(1, 17235968, 18219008) 3 entries of 3200 used
SRAT: Node 1 PXM 1 1070000000-3200000000
SRAT: Hotplug area has existing memory
Entering add_active_range(1, 17235968, 18219008) 4 entries of 3200 used
NUMA: Using 28 for the hash shift.
Bootmem setup node 0 0000000000000000-0000001070000000
Bootmem setup node 1 0000001070000000-0000001160000000
