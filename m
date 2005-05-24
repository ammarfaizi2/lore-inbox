Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262007AbVEXMFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbVEXMFi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 08:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbVEXMFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 08:05:37 -0400
Received: from ns2.suse.de ([195.135.220.15]:37783 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262007AbVEXMF2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 08:05:28 -0400
Date: Tue, 24 May 2005 14:05:27 +0200
From: Andi Kleen <ak@suse.de>
To: Rajesh Shah <rajesh.shah@intel.com>
Cc: Andi Kleen <ak@suse.de>, len.brown@intel.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       acpi-devel@lists.sourceforge.net
Subject: Re: [patch 2/2] x86_64: Collect host bridge resources
Message-ID: <20050524120527.GB15326@wotan.suse.de>
References: <20050521004239.581618000@csdlinux-1> <20050521004506.842235000@csdlinux-1> <20050523161507.GN16164@wotan.suse.de> <20050523175706.A12032@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050523175706.A12032@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2005 at 05:57:08PM -0700, Rajesh Shah wrote:
> On Mon, May 23, 2005 at 06:15:07PM +0200, Andi Kleen wrote:
> > On Fri, May 20, 2005 at 05:42:41PM -0700, rajesh.shah@intel.com wrote:
> > > This patch reads and stores host bridge resources reported by
> > > ACPI BIOS for x86_64 systems. This is needed since ACPI hotplug
> > > code now uses the PCI core for resource management. This patch
> > > simply adds the boot parameter (acpi=root_resources) to enable
> > > the functionality that is implemented in arch/i386.
> > > 
> > 
> > This means all hot plug users have to pass this strange parameter?
> > That does not sound very user friendly. Especially since you usually
> > only need pci hotplug in emergencies, and then you likely didnt pass it.
> > 
> > Cant you find a way to do this without parameters? Any reason
> > to not make it default?
> > 
> I found several systems in which the host bridge was decoding 6+
> resource ranges. In the pci_bus structure, I only have room for 4,
> so I'm forced to drop some ranges that are in fact being passed

How about you allocate an extended structure with kmalloc in this case?
Or if it is only 6 ranges max (it is not, is it?) you could extend
the array.

I doubt this information will need *that* much memory, so it should
be reasonable to just teach the PCI subsystem about it.

> Another option I'd thought of but never really pursued was to
> implement this as a late_initcall. I'll look into that some more.
> In that case, we'd continue to think that all host bridges decode
> all unclaimed resources at boot time and depend on BIOS to program
> resources for boot time devices correctly. Later, we'd collect the
> more accurate host bridge resource picture to make hotplug work
> correctly. Kind of hackish, but I can't think of another way to
> avoid the boot parameter.

It sounds preferable to me to just give PCI the full picture from
the beginning instead of using such hacks which will likely
come back later to hurt us.

-Andi
