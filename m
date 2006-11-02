Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbWKBSlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbWKBSlM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 13:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752015AbWKBSlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 13:41:12 -0500
Received: from junsun.net ([66.29.16.26]:53260 "EHLO junsun.net")
	by vger.kernel.org with ESMTP id S1751257AbWKBSlL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 13:41:11 -0500
Date: Thu, 2 Nov 2006 10:40:53 -0800
From: Jun Sun <jsun@junsun.net>
To: Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org
Subject: Re: reserve memory in low physical address - possible?
Message-ID: <20061102184053.GA8842@srv.junsun.net>
References: <20061031072203.GA10744@srv.junsun.net> <20061031081239.GA9539@linux-sh.org> <20061031150612.GA14272@srv.junsun.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061031150612.GA14272@srv.junsun.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 07:06:12AM -0800, Jun Sun wrote:
> On Tue, Oct 31, 2006 at 05:12:39PM +0900, Paul Mundt wrote:
> > On Mon, Oct 30, 2006 at 11:22:03PM -0800, Jun Sun wrote:
> > > I understand it is possible to reserve some memory at the end by
> > > specifying "mem=xxxM" option in kernel command line.  I looked into
> > > "memmap=xxxM" option but it appears not helpful for what I want.
> > > 
> > memmap takes multiple arguments, including the start address for the
> > memory map. You could also bump min_low_pfn manually if memmap= isn't
> > suitable for you, something like:
> > 
> > 	magic_space = PFN_UP(init_pg_tables_end);
> > 	min_low_pfn = magic_space + magic_size;
> > 
> > (assuming magic_size is rounded up already), should work fine. Though
> > memmap= already takes care of most of this for you, could you explain why
> > it's unsuitable?
> 
> That is fair question. I got that conclusion by a quick test with
> "memmap=" and kernel did not boot. :)
> 
> Now think about it, it could be because the loader  (or the real-mode
> part of kernel) has not been modified to deal with the initial gap.
> Can someone confirm that and give some hints on how to do this?
>

I finally managed to boot a kernel only uses the second 256MB memory
on a 512MB system.  In case someone wants to do the same in the future,
I post my solution here.

http://junsun.net/linux/patches/generic/hacks/061102-reserve-low-memory.patch
http://junsun.net/linux/patches/generic/hacks/061102-vmplayer-no-module-2.6.16.config

The objective is to reserve the first 256MB staring from 0 and hide it from
kernel in a 512MB system.  In other words, kernel only uses the second
256MB memory.

Several notes related to this hack:

* In the config, I set CONFIG_PHYSICAL_START to 0x10000000 (256MB)
  See the .config file in the same directory.  My target is vmplayer.
  (BTW, this config disables module and is quite useful for fast devel)

* The patch will change __PAGE_OFFSET from 0xC0000000 to 0xB0000000 so that
  the virtual address of kernel would still start from 0xC0000000 region.
  (This may be necessary?  Pro's and Con's?)

* Since we lose out the first 16MB DMA zone, many drivers will complain.
  The patch increase MAX_DMA_ADDRESS to 1GB, which effectively cover
  all memory area.  If you have floppy or other ISA devices doing DMA,
  this change may break your system.

* Specify the memory map through kernel command line:
        memmap=exactmap memmap=0x0fef0000@0x10000000
  Note
        . the memory region must include the kernel itself
        . also, grub does not seem to understand memmap option (BUG!!). It
          would still load initrd to the end of memory.  So you better
          specify the size of memory to cover (almost) end of the second
          256MB.  Otherwise, you will see complains about not finding
          "LABEL=/" root device.
        . Tricky enough, you cannot specify the whole 256MB as the size
          because the first  0x1000 block in the last 1M+ is used for ACPI
	  data and NVS.  (What are they for anyway?)  When I tried to
	  include them in memmap spec, the system failed to start (BusLogic
	  driver errors)

Jun

 
