Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262312AbVHCPUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262312AbVHCPUV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 11:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262310AbVHCPUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 11:20:21 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:15530 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S262312AbVHCPUS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 11:20:18 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] Re: [PATCH] PNPACPI: fix types when decoding ACPI resources [resend]
Date: Wed, 3 Aug 2005 09:20:13 -0600
User-Agent: KMail/1.8.1
Cc: Shaohua Li <shaohua.li@intel.com>, Adam Belay <ambx1@neo.rr.com>,
       Matthieu Castet <castet.matthieu@free.fr>, linux-kernel@vger.kernel.org
References: <200508020955.54844.bjorn.helgaas@hp.com> <1123030861.2937.4.camel@linux-hp.sh.intel.com>
In-Reply-To: <1123030861.2937.4.camel@linux-hp.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508030920.13450.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 August 2005 7:01 pm, Shaohua Li wrote:
> On Tue, 2005-08-02 at 09:55 -0600, Bjorn Helgaas wrote:
> > Any objections to the patch below?  I posted it last Wednesday,
> > but haven't heard anything.  Once we have this fix, 8250_pnp
> > should have sufficient functionality that we can get rid of
> > 8250_acpi.
> > 
> > Use types that match the ACPI resource structures.  Previously
> > the u64 value from an RSTYPE_ADDRESS64 was passed as an int,
> > which corrupts the value.
> > 
> > This is one of the things that prevents 8250_pnp from working
> > on HP ia64 boxes.  After 8250_pnp works, we will be able to
> > remove 8250_acpi.c.
> We might always use 'unsigned long'.

Do you have a reason for preferring 'unsigned long' over the
exact types used in the ACPI resource structures?  I thought
it was useful to use the exact types, because then whatever
conversion needs to happen is all in one place.

In the existing code, there's implicit conversion when you
call "pnpacpi_parse_allocated_memresource(..., int mem, int len)"
and pass u64 values as "mem" and "len".  You have to look both
at the call site and the called code.  And gcc doesn't even
complain about this truncation.

But I guess it doesn't matter much either way.

> Did you have plan to remove other 
> legacy acpi drivers?

No, I didn't -- which ones are you thinking about?  Looking at
the callers of acpi_bus_register_driver(), I see:

	arch/ia64/hp/common/sba_iommu.c
		Probably can't be converted because it needs the
		ACPI handle to extract a vendor-specific data
		item from _CRS.

	drivers/char/hpet.c
		This probably should be converted to PNP.  I'll
		look into doing this.

Then of course, there are a bunch of things in drivers/acpi/
(battery, button, fan, ec, etc).  I expect the reason they are
in drivers/acpi/ is because they need ACPI-specific functionality,
so they probably couldn't be converted to PNP.
