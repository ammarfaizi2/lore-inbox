Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266200AbUG0BDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266200AbUG0BDv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 21:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266205AbUG0BDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 21:03:51 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:38531 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S266200AbUG0BDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 21:03:22 -0400
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Tom L Nguyen <tom.l.nguyen@intel.com>
Subject: Re: [PATCH] rename CONFIG_PCI_USE_VECTOR to CONFIG_PCI_MSI
X-Message-Flag: Warning: May contain useful information
References: <200407261615.52261.bjorn.helgaas@hp.com>
	<52llh65r6s.fsf@topspin.com> <200407261734.46494.bjorn.helgaas@hp.com>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 26 Jul 2004 18:03:13 -0700
In-Reply-To: <200407261734.46494.bjorn.helgaas@hp.com> (Bjorn Helgaas's
 message of "Mon, 26 Jul 2004 17:34:46 -0600")
Message-ID: <528yd65kj2.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 27 Jul 2004 01:03:13.0193 (UTC) FILETIME=[7DC95190:01C47375]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Roland> 1) Merge Long's latest MSI/MSI-X patches (updated patches
    Roland> in http://gmane.linux.kernel/218830).  Without the new
    Roland> semantics of pci_disable_msi()/pci_disable_msix(), it's
    Roland> very difficult to use MSI/MSI-X in a device driver.

    Bjorn> That sounds fine to me.  There's nobody really using MSI
    Bjorn> yet, so it can't break too much.

Yup... as far as I can tell there are no in-kernel users, and nobody
noticed that the MSI-X code didn't enable MSI-X properly until my
patch from last month.  My mthca driver:

    https://openib.org/svn/gen2/branches/roland-merge/src/linux-kernel/infiniband/hw/mthca

seems to be one of the first attempts to use MSI/MSI-X.  I have some
uncommitted changes to match Long's patch -- without the patch the
semantics of free_irq() releasing an MSI-X vector make my driver code
very awkward.

    Roland> 2) Split the config options so we have an i386-specific
    Roland> CONFIG_PCI_USE_VECTOR and a generic CONFIG_PCI_MSI (with
    Roland> CONFIG_PCI_MSI depending on something like !I386 ||
    Roland> CONFIG_PCI_USE_VECTOR) This would be an updated version of
    Roland> your patch.

    Bjorn> Yup.  Nothing in MSI has changed since April, so I thought
    Bjorn> my patch would be a reasonable no-risk first step.

I agree... I'd just really, really like to see Long's patch merged
first, since I've been waiting for it for a long time and my driver is
broken without it :)

    Roland> 3) Make the code in drivers/pci/msi.c less Intel-specific
    Roland> -- instead of hard-coding Intel-specific addresses for
    Roland> vectors have the computation call into arch code.  This
    Roland> would be a fair amount of work and depends documentation
    Roland> for non-Intel platforms that implement MSI/MSI-X -- should
    Roland> be easier as PCI Express comes out.

    Bjorn> This is the bit I really want to get to.  In particular, I
    Bjorn> want to support multiple interrupt vector spaces on ia64,
    Bjorn> because we're running out of vectors.  I can't do that as
    Bjorn> long as MSI mucks around with the arch-specific vector
    Bjorn> allocation.  (There's plenty of ia64 code that needs to be
    Bjorn> cleaned up, too; it's not just MSI.)

    Bjorn> I think there needs to be some arch interface to
    Bjorn> allocate/deallocate Linux IRQ numbers (not interrupt
    Bjorn> vectors).  Then MSI can allocate as many as it needs, and
    Bjorn> use yet another arch interface to translate the Linux IRQ
    Bjorn> numbers to the appropriate address/data info to program the
    Bjorn> device.

Sounds good, although I don't know much about the low-level details of
interrupt vectors on either i386 or ia64.  Some way of exposing which
interrupts are "closest" to which CPUs would be a good thing too.

One thing that I would be a little concerned about is making the
numbers in /proc/interrupts too divorced from the underlying platform
interrupt code -- it seems that ACPI debugging is hard enough as it
is.

 - Roland
