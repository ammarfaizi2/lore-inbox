Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262927AbVFVJb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262927AbVFVJb3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 05:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262925AbVFVJ2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 05:28:19 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:26372 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S262843AbVFVJXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 05:23:53 -0400
Message-ID: <42B92DFA.7060705@shadowen.org>
Date: Wed, 22 Jun 2005 10:23:06 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-mm1
References: <20050619233029.45dd66b8.akpm@osdl.org> <20050620131451.GA9739@shadowen.org> <20050621225551.GB24289@suse.de>
In-Reply-To: <20050621225551.GB24289@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Mon, Jun 20, 2005 at 02:14:51PM +0100, Andy Whitcroft wrote:

>>Having trouble getting 2.6.12-mm1 to compile on my x86 test
>>boxes other than a basic PC.  I suspect this patch is to 'blame'.
>>
>>>+gregkh-pci-pci-assign-unassigned-resources.patch
>>
>>We seem to need to include setup-bus.o for most x86 architectures
>>regardless of HOTPLUG.  Not sure if this is the right fix, but it
>>seems to work on the systems I have tested.

> Sounds like a NUMA issue, right?  If you don't have HOTPLUG enabled, X86
> should not need setup_bus.  Care to find the real problem here?

Ok.  I've spent some time looking at this and I think my fix is correct
if we assume that the intent of the change in the patch below is correct:

	gregkh-pci-pci-assign-unassigned-resources.patch

This patch adds a call to pci_assign_unassigned_resources() to
pcibios_init().  pcibios_init() is called unconditionally as a
subsys_initcall() from arch/i386/pci/common.c which is an unconditional
link for i386.

@@ -165,6 +165,7 @@
        if ((pci_probe & PCI_BIOS_SORT) && !(pci_probe & PCI_NO_SORT))
                pcibios_sort();
 #endif
+       pci_assign_unassigned_resources();
        return 0;
 }

I am not a PCI guru so I can't comment on whether this call is
reasonable, but if it is then we require setup-bus.o for all i386 platforms.

I will note that in reading the patch the commentry at the top lists
three individual changes which I think I can identify in the patch
itself, I don't feel that the change above falls under any of them?

Ivan, can you shead any light on whether the hunk of your patch above is
one of the three fixes, whether its a fourth fix, and indeed whether its
needed?

-apw

