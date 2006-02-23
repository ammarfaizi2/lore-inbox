Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWBWCgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWBWCgQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 21:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbWBWCgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 21:36:16 -0500
Received: from gate.crashing.org ([63.228.1.57]:34015 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750706AbWBWCgQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 21:36:16 -0500
Subject: Re: [PATCH 0/6] PCI legacy I/O port free driver (take2)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       akpm@osdl.org, greg@kroah.com, ak@suse.de, rmk+lkml@arm.linux.org.uk
In-Reply-To: <43FAB283.8090206@jp.fujitsu.com>
References: <43FAB283.8090206@jp.fujitsu.com>
Content-Type: text/plain
Date: Thu, 23 Feb 2006 13:34:57 +1100
Message-Id: <1140662098.8264.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Here, there are many PCI devices that provide both I/O port and MMIO
> interface, and some of those devices can be handled without using I/O
> port interface. The reason why such devices provide I/O port interface
> is for compatibility to legacy OSs. So this kind of devices should
> work even if enough I/O port resources are not assigned. The "PCI
> Local Bus Specification Revision 3.0" also mentions about this topic
> (Please see p.44, "IMPLEMENTATION NOTE"). On the current linux,
> unfortunately, this kind of devices don't work if I/O port resources
> are not assigned, because pci_enable_device() for those devices fails.

Which is where the real problem is ... I'm afraid you are doing a
workaround for the wrong issue... do we really need to assign all
resources to the device at pci_enable_device() time ? Yeah, I know, that
sounds gross... but think about it... doesn't pci_request_region(s) look
like a better spot ? Or maybe we should change pci_enable_device()
itself to take a mask of BARs that are relevant. That would help dealing
with a couple of other cases of devices where some BARs really need to
be ignored...

The later is probably the best approach without breaking everything, by
having a new pci_enable_resources(mask) that would take a mask of BARs
to enable, with pci_enable_device() becoming just a call to the former
for all BARs ....

Ben.


