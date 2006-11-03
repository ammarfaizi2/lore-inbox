Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753503AbWKCTtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753503AbWKCTtO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 14:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753504AbWKCTtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 14:49:14 -0500
Received: from usea-naimss2.unisys.com ([192.61.61.104]:14092 "EHLO
	usea-naimss2.unisys.com") by vger.kernel.org with ESMTP
	id S1753503AbWKCTtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 14:49:13 -0500
Subject: Re: [RFC] [PATCH 2.6.19-rc4] kdump panics early in boot when  
	reserving MP Tables located in high memory
From: Amul Shah <amul.shah@unisys.com>
To: vgoyal@in.ibm.com
Cc: Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>
In-Reply-To: <20061103171757.GC9371@in.ibm.com>
References: <1162506272.19677.33.camel@ustr-linux-shaha1.unisys.com>
	 <200611030340.55952.ak@suse.de>
	 <1162565722.19677.68.camel@ustr-linux-shaha1.unisys.com>
	 <200611031751.04056.ak@suse.de>  <20061103171757.GC9371@in.ibm.com>
Content-Type: text/plain
Date: Fri, 03 Nov 2006 14:47:57 -0500
Message-Id: <1162583277.19677.108.camel@ustr-linux-shaha1.unisys.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Nov 2006 19:48:55.0643 (UTC) FILETIME=[18AC0AB0:01C6FF81]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-03 at 12:17 -0500, Vivek Goyal wrote:
> On Fri, Nov 03, 2006 at 05:51:03PM +0100, Andi Kleen wrote:
> > 
> > [Finally dropping that annoying fastboot list from cc. Please never include any closed 
> > mailing lists in l-k posts. Thanks]
> > 
> > >   That won't worked because in arch/86_64/kernel/e820.c, the exactmap
> > > parsing clobbers end_pfn_map.
> > 
> > That's a bug imho. It shouldn't do that.
> > 
> > end_pfn_map should be always the highest address in e820 so that we 
> > can access all firmware tables safely.
> > 
> 
> Hi Andi,
> 
> end_pfn_map still contins the highest address in e820. The only difference
> is that it is reset and recalculated based on new memory map passed
> with the help of memmap= options. 

Andi, Vivek is right.  We can use end_pfn_map.  My observation is wrong.

> Actually with mempmap=exactmap, we are overriding the BIOS provided 
> memory map with a User defined memory map so we reset the end_pfn_map
> to zero and it will be calculated again based on new memory map passed
> with the help of memmap= options.
> 
> So to access all the firmware tables safely, one has to make sure that
> right memmap= options have been passed to the kernel.
> 
> That's why IMHO, the right way to fix this problem is not doing
> some special condition checks in kernel, instead, passing the right
> memmap= options. To do that kexec-tools has to know where the firmware
> tables are and that's why location of MP tables should be exported to 
> user space.

Vivek, the problem condition is in generic reserve_bootmem_core
(mm/bootmem.c), where this
	BUG_ON(PFN_DOWN(addr) >= bdata->node_low_pfn);
checks the target address against the top of that node's memory.

When I said:
> The ACPI tables and MP Tables reside higher in memory.  When reserving
> memory with reserve_bootmem_generic, the function has a BUG panic if the
> memory location to reserve is above the top of memory.  The MP table is
> above the top of memory in a user defined memory map.
I wasn't accurate.  I should have said that the top of memory as seen in
that function is the top of the memory for the node of usable memory.

Since the user defined map as passed in the kexec tools is accurate, we
do need the conditional check to avoid this problem.  I'm more than
happy to work in a second patch to export the MP table location to user
space for the kexec tools (the ES7000 will be a special case even for
that feature since the MP tables already reside in a reserved area).

thanks,
Amul

