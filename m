Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269394AbUJFVRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269394AbUJFVRJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 17:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269475AbUJFVIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 17:08:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53951 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269580AbUJFVF2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 17:05:28 -0400
Date: Wed, 6 Oct 2004 22:05:25 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Grant Grundler <iod00d@hp.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Colin Ngam <cngam@sgi.com>,
       Patrick Gefre <pfg@sgi.com>, "Luck, Tony" <tony.luck@intel.com>,
       Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH] 2.6 SGI Altix I/O code reorganization
Message-ID: <20041006210525.GI16153@parcelfarce.linux.theplanet.co.uk>
References: <B8E391BBE9FE384DAA4C5C003888BE6F0221C989@scsmsx401.amr.corp.intel.com> <41644301.9EC028B3@sgi.com> <20041006195424.GF25773@cup.hp.com> <200410061327.28572.jbarnes@engr.sgi.com> <20041006204832.GB26459@cup.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041006204832.GB26459@cup.hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2004 at 01:48:32PM -0700, Grant Grundler wrote:
> Agreed. I'm not real clear on why drivers/acpi didn't do that.
> But apperently ACPI supports many methods to PCI or PCI-Like (can you
> guess I'm not clear on this?) config space. raw_pci_ops supports
> multiple methods in i386. ia64 only happens to use one so far.
> It seems right for SN2 to use this mechanism if it needs a different
> method.
> 
> Willy tried to explain this to me yesterday and I thought I understood
> most of it...apperently that was a transient moment of clarity. :^/

Let's try it again, by email this time.

Fundamentally, there is a huge impedence mismatch between how the ACPI
interpreter wants to access PCI configuration space, and how Linux wants
to access PCI configuration space.  Linux always has at least a pci_bus
around, if not a pci_dev.  So we can use dev->bus->ops to abstract the
architecture-specific implementation of "how do I get to configuration
space for this bus?"

ACPI doesn't have a pci_bus.  It just passes around a struct of { domain,
bus, dev, function } and expects the OS-specific code to determine what
to do with it.  The original hacky code constructed a fake pci_dev on the
stack and called the regular methods.  This broke ia64 because we needed
something else to be valid (I forget what), so as part of the grand "get
ia64 fully merged upstream" effort, I redesigned the OS-specific code.

Fortunately, neither i386 nor ia64 actually need the feature Linux has
to have a per-bus pci_ops -- it's always the same.  I think powerpc is
the only architecture that needs it.  So I introduced a pci_raw_ops that
both ACPI and a generic pci_root_ops could call.

The part I didn't seem to be able to get across to you yesterday was
that pci_root_ops is not just used for the PCI root bridge, it's used
for accessing every PCI device underneath that root bridge.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
