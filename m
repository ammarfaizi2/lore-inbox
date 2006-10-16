Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422740AbWJPSQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422740AbWJPSQr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 14:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422747AbWJPSQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 14:16:47 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:43431 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1422740AbWJPSQq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 14:16:46 -0400
Date: Mon, 16 Oct 2006 14:16:13 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Morton Andrew Morton <akpm@osdl.org>
Cc: Steve Fox <drfickle@us.ibm.com>, Andi Kleen <ak@suse.de>,
       Badari Pulavarty <pbadari@us.ibm.com>, Martin Bligh <mbligh@mbligh.org>,
       lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
       kmannth@us.ibm.com, Andy Whitcroft <apw@shadowen.org>,
       Adrian Bunk <bunk@stusta.de>, Mel Gorman <mel@csn.ul.ie>
Subject: Re: 2.6.18-mm2 boot failure on x86-64
Message-ID: <20061016181613.GA30090@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <200610052105.00359.ak@suse.de> <1160080954.29690.44.camel@flooterbu> <200610052250.55146.ak@suse.de> <1160101394.29690.48.camel@flooterbu> <20061006143312.GB9881@skynet.ie> <20061006153629.GA19756@in.ibm.com> <20061006171105.GC9881@skynet.ie> <1160157830.29690.66.camel@flooterbu> <20061006200436.GG19756@in.ibm.com> <Pine.LNX.4.64.0610091049390.30765@skynet.skynet.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610091049390.30765@skynet.skynet.ie>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2006 at 10:53:58AM +0100, Mel Gorman wrote:
> On Fri, 6 Oct 2006, Vivek Goyal wrote:
> 
> >On Fri, Oct 06, 2006 at 01:03:50PM -0500, Steve Fox wrote:
> >>On Fri, 2006-10-06 at 18:11 +0100, Mel Gorman wrote:
> >>>On (06/10/06 11:36), Vivek Goyal didst pronounce:
> >>>>Where is bss placed in physical memory? I guess bss_start and bss_stop
> >>>>from System.map will tell us. That will confirm that above memset step 
> >>>>is
> >>>>stomping over bss. Then we have to just find that somewhere probably
> >>>>we allocated wrong physical memory area for bootmem allocator map.
> >>>>
> >>>
> >>>BSS is at 0x643000 -> 0x777BC4
> >>>init_bootmem wipes from 0x777000 -> 0x8F7000
> >>>
> >>>So the BSS bytes from 0x777000 ->0x777BC4 (which looks very suspiciously
> >>>pile a page alignment of addr & PAGE_MASK) gets set to 0xFF. One possible
> >>>fix is below. It adds a check in bad_addr() to see if the BSS section is
> >>>about to be used for bootmap. It Seems To Work For Me (tm) and 
> >>>illustrates
> >>>the source of the problem even if it's not the 100% correct fix.
> >>
> >>I was able to boot the machine with Mel's patch applied on top of
> >>-git22.
> >
> >
> >Please have a look at the attached patch. Does it make some sense.
> >
> 
> It makes some sense. As you state, it wastes memory but that is better 
> than breaking.
> 
> >Steve, can you please give this patch a try if it fixes the problem?
> >
> 
> I boottested the patch on the same machine as Steve was using and it 
> completed successfully.
>

Hi Andrew,

Can you please have a look at the attached patch and include it in -mm.
This fixes the issue for steve. It also figures in the list of Adrian Bunk
of known regressions.

Subject    : oops in xfrm_register_mode
References : http://lkml.org/lkml/2006/10/4/170
Submitter  : Steve Fox <drfickle@us.ibm.com>
Handled-By : Vivek Goyal <vgoyal@in.ibm.com>
Status     : patch available



o Currently some code pieces assume that address returned by find_e820_area()
  are page aligned. But looks like find_e820_area() had no such intention
  and hence one might end up stomping over some of the data. One such
  case is bootmem allocator initialization code stomped over bss.

o This patch modified find_e820_area() to return page aligned address. This
  might be little wasteful of memory but at the same time probably it is
  easier to handle page aligned memory. 

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/x86_64/kernel/e820.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff -puN arch/x86_64/kernel/e820.c~x86_64-return-page-aligned-phy-addr-from-find-e820-area arch/x86_64/kernel/e820.c
--- linux-2.6.19-rc1-1M/arch/x86_64/kernel/e820.c~x86_64-return-page-aligned-phy-addr-from-find-e820-area	2006-10-06 15:28:13.000000000 -0400
+++ linux-2.6.19-rc1-1M-root/arch/x86_64/kernel/e820.c	2006-10-06 15:44:45.000000000 -0400
@@ -54,13 +54,13 @@ static inline int bad_addr(unsigned long
 
 	/* various gunk below that needed for SMP startup */
 	if (addr < 0x8000) { 
-		*addrp = 0x8000;
+		*addrp = PAGE_ALIGN(0x8000);
 		return 1; 
 	}
 
 	/* direct mapping tables of the kernel */
 	if (last >= table_start<<PAGE_SHIFT && addr < table_end<<PAGE_SHIFT) { 
-		*addrp = table_end << PAGE_SHIFT; 
+		*addrp = PAGE_ALIGN(table_end << PAGE_SHIFT);
 		return 1;
 	} 
 
@@ -68,18 +68,18 @@ static inline int bad_addr(unsigned long
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (LOADER_TYPE && INITRD_START && last >= INITRD_START && 
 	    addr < INITRD_START+INITRD_SIZE) { 
-		*addrp = INITRD_START + INITRD_SIZE; 
+		*addrp = PAGE_ALIGN(INITRD_START + INITRD_SIZE);
 		return 1;
 	} 
 #endif
 	/* kernel code */
-	if (last >= __pa_symbol(&_text) && last < __pa_symbol(&_end)) {
-		*addrp = __pa_symbol(&_end);
+	if (last >= __pa_symbol(&_text) && addr < __pa_symbol(&_end)) {
+		*addrp = PAGE_ALIGN(__pa_symbol(&_end));
 		return 1;
 	}
 
 	if (last >= ebda_addr && addr < ebda_addr + ebda_size) {
-		*addrp = ebda_addr + ebda_size;
+		*addrp = PAGE_ALIGN(ebda_addr + ebda_size);
 		return 1;
 	}
 
@@ -152,7 +152,7 @@ unsigned long __init find_e820_area(unsi
 			continue; 
 		while (bad_addr(&addr, size) && addr+size <= ei->addr+ei->size)
 			;
-		last = addr + size;
+		last = PAGE_ALIGN(addr) + size;
 		if (last > ei->addr + ei->size)
 			continue;
 		if (last > end) 
_
