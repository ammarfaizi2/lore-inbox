Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266139AbUGZWje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266139AbUGZWje (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 18:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266141AbUGZWjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 18:39:33 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:30572 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S266139AbUGZWjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 18:39:24 -0400
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Tom L Nguyen <tom.l.nguyen@intel.com>
Subject: Re: [PATCH] rename CONFIG_PCI_USE_VECTOR to CONFIG_PCI_MSI
X-Message-Flag: Warning: May contain useful information
References: <200407261615.52261.bjorn.helgaas@hp.com>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 26 Jul 2004 15:39:23 -0700
In-Reply-To: <200407261615.52261.bjorn.helgaas@hp.com> (Bjorn Helgaas's
 message of "Mon, 26 Jul 2004 16:15:52 -0600")
Message-ID: <52llh65r6s.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 26 Jul 2004 22:39:23.0852 (UTC) FILETIME=[664C60C0:01C47361]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Bjorn> Rename CONFIG_PCI_USE_VECTOR to CONFIG_PCI_MSI.  The
    Bjorn> "vector" terminology is architecture-dependent.  The PCI
    Bjorn> MSI interface actually deals with Linux IRQ numbers (i.e.,
    Bjorn> things you can pass to request_irq()), and we shouldn't
    Bjorn> confuse things by calling them "vectors" just because we're
    Bjorn> using MSI rather than an IOSAPIC.

Seems reasonable... however CONFIG_PCI_USE_VECTOR really has two
overloaded meanings (at least on i386).  First of all, as you say, it
does enable drivers to request MSI/MSI-X.  However, on i386
CONFIG_PCI_USE_VECTOR also changes how the APIC is setup (the most
visible effect of which is different interrupt numbers).

I would propose the following course of action:

 1) Merge Long's latest MSI/MSI-X patches (updated patches in
    http://gmane.linux.kernel/218830).  Without the new semantics of
    pci_disable_msi()/pci_disable_msix(), it's very difficult to use
    MSI/MSI-X in a device driver.
 2) Split the config options so we have an i386-specific
    CONFIG_PCI_USE_VECTOR and a generic CONFIG_PCI_MSI (with
    CONFIG_PCI_MSI depending on something like !I386 || CONFIG_PCI_USE_VECTOR)
    This would be an updated version of your patch.
 3) Make the code in drivers/pci/msi.c less Intel-specific -- instead
    of hard-coding Intel-specific addresses for vectors have the
    computation call into arch code.  This would be a fair amount of
    work and depends documentation for non-Intel platforms that
    implement MSI/MSI-X -- should be easier as PCI Express comes out.

 - Roland
