Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265054AbUF1QWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265054AbUF1QWs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 12:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265055AbUF1QWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 12:22:48 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:50852 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S265054AbUF1QWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 12:22:45 -0400
Date: Mon, 28 Jun 2004 09:22:27 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Matt Sexton <sexton@mc.com>
Cc: Matt Porter <mporter@kernel.crashing.org>, linux-kernel@vger.kernel.org
Subject: Re: DRAM and PCI devices at same physical address
Message-ID: <20040628092227.A17917@home.com>
References: <1088198580.29697.62.camel@dhcp_client-120-140> <20040626202648.B29650@home.com> <1088437874.3292.95.camel@dhcp_client-120-140>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1088437874.3292.95.camel@dhcp_client-120-140>; from sexton@mc.com on Mon, Jun 28, 2004 at 11:51:14AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2004 at 11:51:14AM -0400, Matt Sexton wrote:
> On Sat, 2004-06-26 at 23:26, Matt Porter wrote:
> > On Fri, Jun 25, 2004 at 05:23:00PM -0400, Matt Sexton wrote:
> > > I have a dual Xeon system with the Lindenhurst (E7710) chip set and 1 GB
> > > of memory.  In order to reserve a very large block of memory for a
> > > (user-space) device driver I am writing, I pass "mem=XX" to the kernel
> > > at boot time.  Unfortunately, /proc/pci shows two devices now appearing
> > > in the reserved upper memory range.  
> > 
> > <snip>
> >  
> > > The devices always appear right after the limit I specify on the kernel
> > > boot line.  If I specify "mem=512M", then the first device appears at
> > > 0x20000000.  If I specify nothing, then it appears at 0x40000000.  All
> > > other PCI devices show up at addresses of 0xDD000000 and above.
> > > 
> > > Is there any way to prevent these devices from showing up in the
> > > physical address range of my reserved memory?
> > 
> > You could try using reserve_bootmem() to reserve your driver memory.
> > 
> 
> But then I'd have to modify the kernel.  I'd rather just use a loadable
> module or user-space driver.

Yes, but this is the most reliable way to do your large allocation.
This reminds me that it would be handy to have a "bootmem=" cmdline
parameter.

Alternatively, set CONFIG_FORCE_MAX_ZONEORDER to an order that allows
your huge allocation using __get_free_pages().  However, there's no
guarantees it will succeed after things are fragmented.

> > > Should they be appearing there at all?  Does Linux make any guarantees
> > > when there is more physical memory than specified by "mem=" ?
> > 
> 
> The problem appears to be that the BIOS did not assign PCI addresses to
> the two devices.  Linux (2.6.3-4mdkenterprise) then did so, but it
> starts assigning at either 256MB, or the first 1MB aligned page after
> the end of DRAM, whichever is higher.  On my 1GB system with "mem=768M",
> this the region of my "reserved" DRAM.
> 
> So, using "mem=" to reserve DRAM and having Linux assign PCI addresses
> are not compatible.

Yes.  It's going to call pci_assign_resource() which uses
PCIBIOS_MIN_[IO|MEM] to determine the allowed range of resource
assignment for a given resource type.  On i386, PCIBIOS_MIN_MEM
is defined as pci_mem_start. In arch/i386/setup.c this is configured as:

    if (low_mem_size > pci_mem_start)
        pci_mem_start = low_mem_size;

So you can see that using "mem=" isn't compatible with the assignment
methodology.

-Matt
