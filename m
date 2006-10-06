Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751355AbWJFPh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbWJFPh7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 11:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbWJFPh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 11:37:59 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:49794 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751355AbWJFPh6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 11:37:58 -0400
Date: Fri, 6 Oct 2006 11:36:29 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Mel Gorman <mel@skynet.ie>
Cc: Steve Fox <drfickle@us.ibm.com>, Andi Kleen <ak@suse.de>,
       Badari Pulavarty <pbadari@us.ibm.com>, Martin Bligh <mbligh@mbligh.org>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org, kmannth@us.ibm.com,
       Andy Whitcroft <apw@shadowen.org>
Subject: Re: 2.6.18-mm2 boot failure on x86-64
Message-ID: <20061006153629.GA19756@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060928014623.ccc9b885.akpm@osdl.org> <200610052105.00359.ak@suse.de> <1160080954.29690.44.camel@flooterbu> <200610052250.55146.ak@suse.de> <1160101394.29690.48.camel@flooterbu> <20061006143312.GB9881@skynet.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061006143312.GB9881@skynet.ie>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2006 at 03:33:12PM +0100, Mel Gorman wrote:
> > Linux version 2.6.18-git22 (root@elm3b239) (gcc version 4.1.0 (SUSE Linux)) #2 SMP Thu Oct 5 19:05:36 PDT 2006
> > Command line: root=/dev/sda1 vga=791  ip=9.47.67.239:9.47.67.50:9.47.67.1:255.255.255.0 resume=/dev/sdb1 showopts earlyprintk=serial,ttyS0,57600 console=tty0 console=ttyS0,57600 autobench_args: root=/dev/sda1 ABAT:1160100417
> > BIOS-provided physical RAM map:
> >  BIOS-e820: 0000000000000000 - 000000000009ac00 (usable)
> >  BIOS-e820: 000000000009ac00 - 00000000000a0000 (reserved)
> >  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
> >  BIOS-e820: 0000000000100000 - 00000000bff764c0 (usable)
> >  BIOS-e820: 00000000bff764c0 - 00000000bff98880 (ACPI data)
> >  BIOS-e820: 00000000bff98880 - 00000000c0000000 (reserved)
> >  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
> >  BIOS-e820: 0000000100000000 - 0000000c00000000 (usable)
> 
> I continued what Steve was doing this morning to see could this be
> pinned down. After placing 'CHECK;' in a few places as suggested by
> Andi's check, the problem code was identified as that following in
> mm/bootmem.c#init_bootmem_core()
> 
>         mapsize = get_mapsize(bdata);
>         memset(bdata->node_bootmem_map, 0xff, mapsize);
> 
> That explains the value in the array at least. A few more printfs around
> this point printed out the following in the boot log
> 
> init_bootmem_core(0, 1909, 0, 12582912)
> init_bootmem_core: Calling memset(0xFFFF810000775000, 1572864)
> AAGH: afinfo corrupted at mm/bootmem.c:121
> 
> where;
> 
> 1909 == mapstart
> 0 == start
> 12582912 == end
> 1572864 == mapsize
> 
> mapstart, start and end being the parameters being passed to
> init_bootmem_core(). This means we are calling memset for the physical
> range 0x775000 -> 0x8F5000 which is in a usable range according to the
> BIOS-e820 map it appears.
> 

Hi Mel,

Where is bss placed in physical memory? I guess bss_start and bss_stop
from System.map will tell us. That will confirm that above memset step is
stomping over bss. Then we have to just find that somewhere probably
we allocated wrong physical memory area for bootmem allocator map.

Thanks
Vivek

