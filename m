Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946285AbWJSSCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946285AbWJSSCt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 14:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946284AbWJSSCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 14:02:48 -0400
Received: from mga01.intel.com ([192.55.52.88]:4141 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1946281AbWJSSCs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 14:02:48 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,330,1157353200"; 
   d="scan'208"; a="149085364:sNHT2149224742"
From: Jesse Barnes <jesse.barnes@intel.com>
To: eiichiro.oiwa.nm@hitachi.com
Subject: Re: pci_fixup_video change blows up on sparc64
Date: Thu, 19 Oct 2006 11:03:11 -0700
User-Agent: KMail/1.9.4
Cc: "David Miller" <davem@davemloft.net>, alan@redhat.com, greg@kroah.com,
       linux-kernel@vger.kernel.org
References: <20061018.233102.74754142.davem@davemloft.net> <20061019.013732.30184567.davem@davemloft.net> <XNM1$9$0$4$$3$3$7$A$9002706U45374cd7@hitachi.com>
In-Reply-To: <XNM1$9$0$4$$3$3$7$A$9002706U45374cd7@hitachi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610191103.16689.jesse.barnes@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, October 19, 2006 3:01 am, eiichiro.oiwa.nm@hitachi.com 
wrote:
> >> If an expansion ROM exists on ATI Radeon or ATY128 card,
> >> pci_map_rom returns the expansion ROM base address instead of
> >> 0xC0000 because fixup_video checks the VGA Enable bit in the
> >> Bridge Control register.
> >
> >It is not valid to expect the bridge control register to return
> >anything meaningful on PCI "host bridge".  The Radeon card here sits
> >on the root, just under the PCI Host Controller.  The code in
> >fixup_video appears to assume that every bus up to the root from
> >the VGA device is a PCI-PCI bridge, which is not a valid assumption.
> >There can be a PCI host bridge at the root.
>
> Have you ever read the PCI-to-PCI Bridge Architecture Specification?
> The default of VGA Enable bit is 0. This mean video ROM doesn't
> forward system RAM at 0xC0000.
>
> There is your VGA card under 0001:00:00.0 Host bridge. The VGA Enable
> bit in this host bridge will return 0 and IORESOURCE_ROM_SHADOW won't
> set.

I don't think that applies to host->pci bridges though, all bets are off 
as to how their bits are defined.  One check that might make this 
feature a bit more robust is to look for a real PCI ROM on the device.  
If present, we probably don't need to bother with the system copy 
(which probably won't be there anyway).

We should probably also check whether the parent bridge of the device to 
be fixed up is a real pci->pci bridge (if possible).  That would remove 
some ambiguity that's likely to cause problems with other platforms 
too.

Jesse
