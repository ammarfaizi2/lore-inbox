Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbVEXBHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbVEXBHG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 21:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbVEXBEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 21:04:35 -0400
Received: from fmr24.intel.com ([143.183.121.16]:9709 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S261289AbVEXA5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 20:57:48 -0400
Date: Mon, 23 May 2005 17:57:08 -0700
From: Rajesh Shah <rajesh.shah@intel.com>
To: Andi Kleen <ak@suse.de>
Cc: rajesh.shah@intel.com, len.brown@intel.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       acpi-devel@lists.sourceforge.net
Subject: Re: [patch 2/2] x86_64: Collect host bridge resources
Message-ID: <20050523175706.A12032@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <20050521004239.581618000@csdlinux-1> <20050521004506.842235000@csdlinux-1> <20050523161507.GN16164@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050523161507.GN16164@wotan.suse.de>; from ak@suse.de on Mon, May 23, 2005 at 06:15:07PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2005 at 06:15:07PM +0200, Andi Kleen wrote:
> On Fri, May 20, 2005 at 05:42:41PM -0700, rajesh.shah@intel.com wrote:
> > This patch reads and stores host bridge resources reported by
> > ACPI BIOS for x86_64 systems. This is needed since ACPI hotplug
> > code now uses the PCI core for resource management. This patch
> > simply adds the boot parameter (acpi=root_resources) to enable
> > the functionality that is implemented in arch/i386.
> > 
> 
> This means all hot plug users have to pass this strange parameter?
> That does not sound very user friendly. Especially since you usually
> only need pci hotplug in emergencies, and then you likely didnt pass it.
> 
> Cant you find a way to do this without parameters? Any reason
> to not make it default?
> 
I found several systems in which the host bridge was decoding 6+
resource ranges. In the pci_bus structure, I only have room for 4,
so I'm forced to drop some ranges that are in fact being passed
down. For such cases, if I enable this by default, I see boot time
failures for devices that attempted to claim these dropped resources.
These devices were otherwise properly configured by BIOS, and work
fine with today's (incorrect) assumption that all host bridges
decode all unclaimed resources. I didn't want the patch to break
existing systems, hence the boot parameter.

Another option I'd thought of but never really pursued was to
implement this as a late_initcall. I'll look into that some more.
In that case, we'd continue to think that all host bridges decode
all unclaimed resources at boot time and depend on BIOS to program
resources for boot time devices correctly. Later, we'd collect the
more accurate host bridge resource picture to make hotplug work
correctly. Kind of hackish, but I can't think of another way to
avoid the boot parameter.

Rajesh

