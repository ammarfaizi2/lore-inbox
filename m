Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269333AbUJFS6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269333AbUJFS6t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 14:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269046AbUJFS6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 14:58:49 -0400
Received: from palrel13.hp.com ([156.153.255.238]:1242 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S269333AbUJFS6X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 14:58:23 -0400
Date: Wed, 6 Oct 2004 11:57:39 -0700
From: Grant Grundler <iod00d@hp.com>
To: Patrick Gefre <pfg@sgi.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, cngam@sgi.com,
       Matthew Wilcox <matthew@wil.cx>, Grant Grundler <iod00d@hp.com>,
       Jesse Barnes <jbarnes@engr.sgi.com>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH] 2.6 SGI Altix I/O code reorganization
Message-ID: <20041006185739.GA25773@cup.hp.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F0221C989@scsmsx401.amr.corp.intel.com> <41641007.5020702@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41641007.5020702@sgi.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2004 at 10:32:23AM -0500, Patrick Gefre wrote:
> o added our own pci_ops (Grant/Matthew's request)

Sorry - my bad.
I confused the issue by claiming one should replace pci_root_ops.
It was one possibility but it's not an easy path to take.

Mathew explained replacing the raw_pci_ops pointer is the Right Thing
and I suspect it's easier to properly implement.

Some comments on the implementation:
o sn_pci_fixup_bus() is a confusing name. "pcibios_fixup_bus" is normally
  called by generic PCI code after each bus is walked.
  This code obviously doesn't support that.
  Maybe, sn_init_pci_controller() or something like that would be clearer.

o This bit of code belongs in the pcibios_fixup_bus() call path:
	+       /*
	+        * Generic Linux PCI Layer has created the pci_bus and pci_dev
	+        * structures - time for us to add our SN PLatform specific
	+        * information.
	+        */
	+
	+       while ((pci_dev =
	+               pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pci_dev)) != NULL) {
	+               sn_pci_fixup_slot(pci_dev);
	+       }

  I realize that's not easy to add/maintain in the arch/ia64 port though
  since pcibios_fixup_bus() is common code for multiple platforms.

o sn_pci_fixup_bus() should be called for each PCI root bus controller
  the firmware advertises. The loop in sn_pci_init() is hard coded
  to loop from 0 to 256 busses.
  Is ACPI the only way PCI host controllers are advertised?
  SN2 doesn't use a different method today?

  It means we are telling PCI subsystem to walk root busses that don't
  exist in all configurations. I hope there are no nasty side effects
  from that.

o the BUG() in:

  	+       controller = sn_alloc_pci_sysdata();
	+       if (!controller) {
	+               BUG();
	+       }
  is redundant with the BUG in sn_alloc_pci_sysdata().

sorry for the initial bad advice and I hope this helps,
grant
