Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261265AbVDZFdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbVDZFdt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 01:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVDZFdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 01:33:49 -0400
Received: from gate.crashing.org ([63.228.1.57]:28103 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261265AbVDZFdp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 01:33:45 -0400
Subject: pci-sysfs resource mmap broken
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linux-pci@atrey.karlin.mff.cuni.cz
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Content-Type: text/plain
Date: Tue, 26 Apr 2005 15:33:29 +1000
Message-Id: <1114493609.7183.55.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

While chasing an interesting bug in ppc/ppc64 implementation of pci
mmap, I discovered that the pci sysfs code is in fact broken and cannot
be made to work on those archs (well, at least for IO space). In fact,
it can, but then, it would break the /proc code :)

The problem is that they are both calling the same arch routine
(pci_mmap_page_range) with the offset argument having a different
semantic.

In the /proc code, it comes from userland directly, and is supposedly,
the raw BAR value.

In sysfs, it's passing the device resource[]->start value.

The problem is that can only work ... on architectures where the
resources contain the same thing as the BAR values. On ppc, where this
is not the case, it will not work. On ppc, resources are "fixed up" in
various ways (for example, PReP adds a fixed offset to all memory
resources to match the HW translation since PCI isn't 1:1 on those, and
all PPCs with more than one domain play tricks with IO resources).

What would be the proper fix here ? Having pci_mmap_resource() actually
read the BAR value for the resource ?

In a similar vein, the "resource" is exposing directly to userland the
content of "struct resource". This doesn't mean anything. The kernel is
internally playing all sort of offset tricks on these values, so they
can't be used for anything useful, either via /dev/mem, or for io port
accesses, or whatever.

Shouldn't we expose the BAR values & size rather here ? That is,
reconsitutes non-offset'd resources, possibly with arch help, or just
reading BAR to get base, and apply resource size & flags ?

Unless you are on x86 of course ...

There is some serious brokenness in there, it needs to be fixed if we
want things like X.org to be ever properly adapted (and we'll have to
deal with existing broken kernels, gack).

Ben.


