Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbWERP47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWERP47 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 11:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbWERP47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 11:56:59 -0400
Received: from andromeda.dapyr.net ([69.45.6.104]:40410 "EHLO
	andromeda.dapyr.net") by vger.kernel.org with ESMTP
	id S1751359AbWERP45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 11:56:57 -0400
Date: Thu, 18 May 2006 11:56:42 -0400
From: Konrad Rzeszutek <konradr@us.ibm.com>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, konradr@redhat.com
Subject: Re: [patch] Ignore MCFG if the mmconfig area isn't reserved in the e820 table.
Message-ID: <20060518155642.GC7617@andromeda.dapyr.net>
References: <200605172153.35878.konradr@us.ibm.com> <446C70A8.5050909@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <446C70A8.5050909@linux.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2006 at 06:03:36AM -0700, Arjan van de Ven wrote:
> Konrad Rzeszutek wrote:
> >>Hi,
> >>There have been several machines that don't have a working MMCONFIG,
> >>often because of a buggy MCFG table in the ACPI bios. This patch adds a
> >>simple sanity check that detects a whole bunch of these cases, and when
> >>it detects it, linux now boots rather than crash-and-burns. 
> >>[snip]
> >
> >Arjan,
> >
> >I am not sure if your analysis and your solution to the problem is 
> >correct. It was my understanding that any memory NOT defined in the E820 
> >tables is NOT considered system memory. Therefore memory addresses defined 
> >in the ACPI MCFG table do not have to show up in the E820 table.
> 
> the problem is that Linux considers these 'free game' and will happily put
> something like IO windows for cardbus cards there.

I can see this being a definite problem. I do not have machines with
ACPI MCFG and PCMCIA capability so I cannot reproduce this behavior.
Interestingly enough, somebody had a similar thought on their mind and
implemented a function 'clear_kernel_mapping'  which, well, unmaps the
pages from the addresses that ACPI MCFG points to -  so that it would not
be used as 'free game'. 

This does not inhibit PCMCIA drivers from using other memory addresses
that are not in E820 and not in ACPI MCFG. However, those are reserved 
during boot up (for example the EBDA). Also, the ACPI marks many memory
segments as reserved (which are not neccesarily marked reserved in
E820) to help the OS.

As I mentioned earlier, I do not have a machine with PCMCIA capability
and ACPI MCFG - but if you have access to such a machine, I would be
happy to look with you into creating a more comprehensive solution.

> 
> >Also the ACPI spec v3.0 (pg 405 of PDF, section 14.2, titled:
> >"E820 Assumptions and Limitations") agrees with this:
> >
> >"The BIOS does not return a range description for the memory mapping
> >of PCI devices, ISA Option ROMs, and the ISA PNP cards because the OS
> >has mechanisms available to detect them."
> 
> MCFG is none of these...

This is a bit of gray area. The end result of MCFG or 0xCF8/0xCFF is to
configure PCI devices and retrieve PCI memory mapped addresses (IO MMU).
0xCF8/0xCFF is limited in what it can do (only 256 bytes of
configuration date can be controlled), while MMCONFIG allows to
configure advanced features of the PCI-X and PCI Express (4KB of conf
data). Neither of these addresses - IO MMU or MCFG _has_ to show up in 
the E820 tables. 

Sometimes the IO MMU reserved memory shows up in the E820 as reserved.
The reason for this was to make life for the OS easier.  Some OSes mark 
256MB the IOMMU as reserved without bothering to check what is in there 
(which can be done via querying the PCI devices and constructing a memory
table of PCI devices memory mapped addresses and how they fall in that
256MB).

The PCI Express and PCI-X configuration data can (but not always depending 
on how much IOMMU the machine has set) be in the 256MB segment that the OS
reserves for IO MMU.  The MMCONFIG is usually next to the start of IOMMU
memory address. On some machines that segment starts at 0xE0000000 and shows 
up in the E820 tables as reserved. On other machines, this IOMMU segment is 
in 0xF4000000, while MMCFG is in 0xF0000000 (64MB for MCFG, and 192MB for IOMMU).
And that memory segment (0xF0000000) does not show up in E820 table.
(FYI: No need to set up the full 256MB for MCFG as there isn't enought
PCI slots to need so much).

If the MMCONFIG falls in that assumed memory mapped 256MB - then 
the quote from section 14.2 can apply to that particular situation 
"The BIOS does not return a range for the memory mapping of PCI devices ...";

The end result is that the MCFG and IOMMU can point to memory ranges
reserved in E820, but do not neccesarily have to. 

> 
> >If this is not a specification issue, I was wondering if perhaps for the 
> >machines you refer to, their BIOS bug is that the E820 have memory ranges
> >which also encompass what MMCONF points to?
> 
> no their bug is mostly that MCFG is garbage in those bioses. It points 
> plain to
> the wrong place. They even reserved the correct range, just pointed mcfg at 
> the
> wrong place.
> 

That is definitely a problem - and the "sanity-check" can definitly bail
out on those BIOSes and not crash Linux. The other side of the coin is that 
BIOSes that do implement the MCFG/E820 correctly are penalized: the 
MMCONFIG capability on those machines is turned off when using Linux
2.6.17. 

Could you provide more details on the BIOS? Did the vendor released an updated BIOS? 

