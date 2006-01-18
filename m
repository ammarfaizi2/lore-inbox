Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932537AbWARCds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932537AbWARCds (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 21:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932541AbWARCds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 21:33:48 -0500
Received: from ns2.suse.de ([195.135.220.15]:6584 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932532AbWARCdr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 21:33:47 -0500
From: Andi Kleen <ak@suse.de>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 2.6.15] ia64: use i386 dmi_scan.c
Date: Wed, 18 Jan 2006 03:32:19 +0100
User-Agent: KMail/1.8
Cc: Matt Domsch <Matt_Domsch@dell.com>, linux-ia64@vger.kernel.org,
       openipmi-developer@lists.sourceforge.net, akpm@osdl.org,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       linux-kernel@vger.kernel.org
References: <20060104221627.GA26064@lists.us.dell.com> <200601131724.42054.bjorn.helgaas@hp.com> <200601171717.03192.bjorn.helgaas@hp.com>
In-Reply-To: <200601171717.03192.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601180332.19692.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 January 2006 01:17, Bjorn Helgaas wrote:
> On Friday 13 January 2006 17:24, Bjorn Helgaas wrote:
> > ... the
> > DMI stuff crashes HP sx2000 (and probably sx1000) boxes, probably
> > because of some memory attribute problem.  So I'll have more
> > feedback after I debug that ;-)
>
> It *is* a memory attribute problem.  The current code always calls
> ioremap() on efi.smbios.  The first problem is that this is a
> physical address on x86, but a virtual address on ia64.
>
> The second problem is that we don't check the supported attributes
> for the SMBIOS table.  On HP sx1000/sx2000, these tables are in system
> memory, which doesn't support uncacheable access, so iorem
> ap() does the wrong thing.

At least on x86-64/i386 the ioremap is actually cached unless a MTRR
changes it, but it normally doesn't here. If one wants to force uncached
access one has to use ioremap_uncached(). You're saying IA64 ioremap
forces uncached access? That seems weird.

> +	if (efi_enabled) {
> +		if (efi_mem_attributes(base & EFI_MEMORY_WB)) {
> +			iomem = 0;
> +			buf = (u8 *) phys_to_virt(base);
> +		} else if (efi_mem_attributes(base & EFI_MEMORY_UC))
> +			buf = dmi_ioremap(base, len);
> +		else
> +			buf = NULL;

I would expect your ioremap to already do such a lookup. That is at least
how MTRRs on i386/x86-64 work.  If it does not how about you fix
ioremap()? Or provide a suitable ia64 dmi_ioremap, but it's likely
better to do it generally.

Regarding physical vs virtual efi.smbios -- it sounds nasty to have such
a difference in the EFI support for different architectures. Matthew, do
you have a suggestion how this can be unified?

-Andi
