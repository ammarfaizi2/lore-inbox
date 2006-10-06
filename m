Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751422AbWJFRfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbWJFRfW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 13:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWJFRfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 13:35:22 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:22150 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751260AbWJFRfT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 13:35:19 -0400
Date: Fri, 6 Oct 2006 13:34:41 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Mel Gorman <mel@skynet.ie>
Cc: Steve Fox <drfickle@us.ibm.com>, Andi Kleen <ak@suse.de>,
       Badari Pulavarty <pbadari@us.ibm.com>, Martin Bligh <mbligh@mbligh.org>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org, kmannth@us.ibm.com,
       Andy Whitcroft <apw@shadowen.org>
Subject: Re: 2.6.18-mm2 boot failure on x86-64
Message-ID: <20061006173441.GC19756@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060928014623.ccc9b885.akpm@osdl.org> <200610052105.00359.ak@suse.de> <1160080954.29690.44.camel@flooterbu> <200610052250.55146.ak@suse.de> <1160101394.29690.48.camel@flooterbu> <20061006143312.GB9881@skynet.ie> <20061006153629.GA19756@in.ibm.com> <20061006171105.GC9881@skynet.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061006171105.GC9881@skynet.ie>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2006 at 06:11:05PM +0100, Mel Gorman wrote:
> On (06/10/06 11:36), Vivek Goyal didst pronounce:
> > On Fri, Oct 06, 2006 at 03:33:12PM +0100, Mel Gorman wrote:
> > > > Linux version 2.6.18-git22 (root@elm3b239) (gcc version 4.1.0 (SUSE Linux)) #2 SMP Thu Oct 5 19:05:36 PDT 2006
> > > > Command line: root=/dev/sda1 vga=791  ip=9.47.67.239:9.47.67.50:9.47.67.1:255.255.255.0 resume=/dev/sdb1 showopts earlyprintk=serial,ttyS0,57600 console=tty0 console=ttyS0,57600 autobench_args: root=/dev/sda1 ABAT:1160100417
> > > > BIOS-provided physical RAM map:
> > > >  BIOS-e820: 0000000000000000 - 000000000009ac00 (usable)
> > > >  BIOS-e820: 000000000009ac00 - 00000000000a0000 (reserved)
> > > >  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
> > > >  BIOS-e820: 0000000000100000 - 00000000bff764c0 (usable)
> > > >  BIOS-e820: 00000000bff764c0 - 00000000bff98880 (ACPI data)
> > > >  BIOS-e820: 00000000bff98880 - 00000000c0000000 (reserved)
> > > >  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
> > > >  BIOS-e820: 0000000100000000 - 0000000c00000000 (usable)
> > > 
> > > I continued what Steve was doing this morning to see could this be
> > > pinned down. After placing 'CHECK;' in a few places as suggested by
> > > Andi's check, the problem code was identified as that following in
> > > mm/bootmem.c#init_bootmem_core()
> > > 
> > >         mapsize = get_mapsize(bdata);
> > >         memset(bdata->node_bootmem_map, 0xff, mapsize);
> > > 
> > > That explains the value in the array at least. A few more printfs around
> > > this point printed out the following in the boot log
> > > 
> > > init_bootmem_core(0, 1909, 0, 12582912)
> > > init_bootmem_core: Calling memset(0xFFFF810000775000, 1572864)
> > > AAGH: afinfo corrupted at mm/bootmem.c:121
> > > 
> > > where;
> > > 
> > > 1909 == mapstart
> > > 0 == start
> > > 12582912 == end
> > > 1572864 == mapsize
> > > 
> > > mapstart, start and end being the parameters being passed to
> > > init_bootmem_core(). This means we are calling memset for the physical
> > > range 0x775000 -> 0x8F5000 which is in a usable range according to the
> > > BIOS-e820 map it appears.
> > > 
> > 
> > Hi Mel,
> > 
> 
> Hi.
> 
> > Where is bss placed in physical memory? I guess bss_start and bss_stop
> > from System.map will tell us. That will confirm that above memset step is
> > stomping over bss. Then we have to just find that somewhere probably
> > we allocated wrong physical memory area for bootmem allocator map.
> > 
> 
> BSS is at 0x643000 -> 0x777BC4
> init_bootmem wipes from 0x777000 -> 0x8F7000
> 
> So the BSS bytes from 0x777000 ->0x777BC4 (which looks very suspiciously
> pile a page alignment of addr & PAGE_MASK) gets set to 0xFF. One possible
> fix is below. It adds a check in bad_addr() to see if the BSS section is
> about to be used for bootmap. It Seems To Work For Me (tm) and illustrates
> the source of the problem even if it's not the 100% correct fix.
> 
> diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.18-git22-clean/arch/x86_64/kernel/e820.c linux-2.6.18-git22-bss_relocate_fix/arch/x86_64/kernel/e820.c
> --- linux-2.6.18-git22-clean/arch/x86_64/kernel/e820.c	2006-10-05 20:42:07.000000000 +0100
> +++ linux-2.6.18-git22-bss_relocate_fix/arch/x86_64/kernel/e820.c	2006-10-06 17:39:51.000000000 +0100
> @@ -51,6 +51,7 @@ extern struct resource code_resource, da
>  static inline int bad_addr(unsigned long *addrp, unsigned long size)
>  { 
>  	unsigned long addr = *addrp, last = addr + size; 
> +	unsigned long bss_start, bss_end;
>  
>  	/* various gunk below that needed for SMP startup */
>  	if (addr < 0x8000) { 
> @@ -77,6 +78,14 @@ static inline int bad_addr(unsigned long
>  		*addrp = __pa_symbol(&_end);
>  		return 1;
>  	}
> +	
> +	/* bss section */
> +	bss_start = __pa_symbol(&__bss_start);
> +	bss_end = PAGE_ALIGN(__pa_symbol(&__bss_stop));
> +	if (addr >= bss_start && addr < bss_end) {
> +		*addrp = bss_end;
> +		return 1;
> +	}
>  

Surprising, the kernel code check just before this should have taken care
of it.

 /* kernel code */
	if (last >= __pa_symbol(&_text) && last < __pa_symbol(&_end)) {
		*addrp = __pa_symbol(&_end);
		return 1;
	}
May be it can be changed to 
	if (last >= __pa_symbol(&_text) && last < PAGE_ALIGN(__pa_symbol(&_end))) {

But all this seem to be a stopgap fix. Still the real puzzle is exactly
where did it slip out and should be fixed there.

May be some more printks will help us.

Thanks
Vivek
