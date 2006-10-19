Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161374AbWJSKB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161374AbWJSKB2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 06:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161376AbWJSKB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 06:01:28 -0400
Received: from mail4.hitachi.co.jp ([133.145.228.5]:9404 "EHLO
	mail4.hitachi.co.jp") by vger.kernel.org with ESMTP
	id S1161374AbWJSKB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 06:01:27 -0400
Message-Type: Multiple Part
MIME-Version: 1.0
Message-ID: <XNM1$9$0$4$$3$3$7$A$9002706U45374cd7@hitachi.com>
Content-Type: text/plain; charset="us-ascii"
To: "David Miller" <davem@davemloft.net>
From: <eiichiro.oiwa.nm@hitachi.com>
Cc: <alan@redhat.com>, <jesse.barnes@intel.com>, <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>
Date: Thu, 19 Oct 2006 19:01:06 +0900
References: <20061018.233102.74754142.davem@davemloft.net> 
    <XNM1$9$0$4$$3$3$7$A$9002705U45372f1d@hitachi.com> 
    <20061019.013732.30184567.davem@davemloft.net>
Importance: normal
Subject: Re[2]: pci_fixup_video change blows up on sparc64
X400-Content-Identifier: X45374CD700000M
X400-MTS-Identifier: [/C=JP/ADMD=HITNET/PRMD=HITACHI/;gmml160610191900552OU]
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> If an expansion ROM exists on ATI Radeon or ATY128 card, pci_map_rom returns
>> the expansion ROM base address instead of 0xC0000 because fixup_video checks
>> the VGA Enable bit in the Bridge Control register.
>
>It is not valid to expect the bridge control register to return
>anything meaningful on PCI "host bridge".  The Radeon card here sits
>on the root, just under the PCI Host Controller.  The code in
>fixup_video appears to assume that every bus up to the root from
>the VGA device is a PCI-PCI bridge, which is not a valid assumption.
>There can be a PCI host bridge at the root.

Have you ever read the PCI-to-PCI Bridge Architecture Specification?
The default of VGA Enable bit is 0. This mean video ROM doesn't forward
system RAM at 0xC0000. 

There is your VGA card under 0001:00:00.0 Host bridge. The VGA Enable bit
in this host bridge will return 0 and IORESOURCE_ROM_SHADOW won't set.

>Also, and more importantly, you cannot use the 0xc0000 address in a
>raw way like this.  There are multiple PCI domains possible in a
>given system, and the 0xc0000 address you wish to use must be relative
>to that PCI domain.
>
>Therefore, in the presence of multiple PCI domains:
>
>	x = ioremap(0xc0000, ...);
>
>doesn't make any sense, is extremely non-portable, and will crash
>on many non-x86 systems.

It's impossible that multiple VGA cards, which have not the expansion
ROM, exist in a system regardless of multiple PCI domain system.

>All of this pci_fixup_video code was perfectly fine when it was only
>used on x86, where assumptions like this happened to work, but it is
>not possible to continue making these assumptions if this code will
>now run on every single architecture.

pci_fixup_video is also perfectly fine on IA64. And VGA is historical
device of x86 platform.
