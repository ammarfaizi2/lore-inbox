Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266170AbUGZXe4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266170AbUGZXe4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 19:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266173AbUGZXe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 19:34:56 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:35236 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S266170AbUGZXex (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 19:34:53 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Roland Dreier <roland@topspin.com>
Subject: Re: [PATCH] rename CONFIG_PCI_USE_VECTOR to CONFIG_PCI_MSI
Date: Mon, 26 Jul 2004 17:34:46 -0600
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Tom L Nguyen <tom.l.nguyen@intel.com>
References: <200407261615.52261.bjorn.helgaas@hp.com> <52llh65r6s.fsf@topspin.com>
In-Reply-To: <52llh65r6s.fsf@topspin.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407261734.46494.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 July 2004 4:39 pm, Roland Dreier wrote:
> I would propose the following course of action:
> 
>  1) Merge Long's latest MSI/MSI-X patches (updated patches in
>     http://gmane.linux.kernel/218830).  Without the new semantics of
>     pci_disable_msi()/pci_disable_msix(), it's very difficult to use
>     MSI/MSI-X in a device driver.

That sounds fine to me.  There's nobody really using MSI yet, so
it can't break too much.

>  2) Split the config options so we have an i386-specific
>     CONFIG_PCI_USE_VECTOR and a generic CONFIG_PCI_MSI (with
>     CONFIG_PCI_MSI depending on something like !I386 || CONFIG_PCI_USE_VECTOR)
>     This would be an updated version of your patch.\

Yup.  Nothing in MSI has changed since April, so I thought my patch
would be a reasonable no-risk first step.

>  3) Make the code in drivers/pci/msi.c less Intel-specific -- instead
>     of hard-coding Intel-specific addresses for vectors have the
>     computation call into arch code.  This would be a fair amount of
>     work and depends documentation for non-Intel platforms that
>     implement MSI/MSI-X -- should be easier as PCI Express comes out.

This is the bit I really want to get to.  In particular, I want to
support multiple interrupt vector spaces on ia64, because we're
running out of vectors.  I can't do that as long as MSI mucks
around with the arch-specific vector allocation.  (There's plenty
of ia64 code that needs to be cleaned up, too; it's not just MSI.)

I think there needs to be some arch interface to allocate/deallocate
Linux IRQ numbers (not interrupt vectors).  Then MSI can allocate
as many as it needs, and use yet another arch interface to translate
the Linux IRQ numbers to the appropriate address/data info to program
the device.

(A side note on this -- the MSI code in the tree uses "vector" where
it should use "irq".  For example, msi_alloc_vectors() really allocates
Linux IRQs, not vectors, because you can pass them to request_irq() and
friends.  Maybe Long's latest patch cleans this up a bit.)
