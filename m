Return-Path: <linux-kernel-owner+w=401wt.eu-S1161141AbXAMArV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161141AbXAMArV (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 19:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161144AbXAMArV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 19:47:21 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:38473 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161141AbXAMArU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 19:47:20 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent:sender;
        b=LUhwIIvy+1RVlydx+3NcmBq94Yxyt9k8dqY/rl6gDP13OpwhUbD1zhu+EP39q7MPbpgKkstDQkvWSJ9YmGxLUWCjvCYZ9p4JZy9/fOBJkRJqs5hMfKc5Rjr69hNu8Izxturi+lwOUxx63XW7MkePjBjoQg9ETwI/yIwVomHnq3k=
Date: Sat, 13 Jan 2007 00:45:03 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Len Brown <lenb@kernel.org>
Cc: Jiri Slaby <jirislaby@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, rui.zhang@intel.com,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: Re: Early ACPI lockup (was Re: 2.6.20-rc4-mm1)
Message-ID: <20070113004502.GJ5941@slug>
References: <20070111222627.66bb75ab.akpm@osdl.org> <20070112102040.GD5941@slug> <200701121753.08710.lenb@kernel.org> <20070112231015.GI5941@slug> <45A81B6C.3030106@gmail.com> <45A8230E.5050600@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45A8230E.5050600@googlemail.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 13, 2007 at 01:08:46AM +0100, Michal Piotrowski wrote:
> Jiri Slaby napisał(a):
> > Frederik Deweerdt wrote:
> >> On Fri, Jan 12, 2007 at 05:53:08PM -0500, Len Brown wrote:
> >>> On Friday 12 January 2007 05:20, Frederik Deweerdt wrote:
> >>>> On Thu, Jan 11, 2007 at 10:26:27PM -0800, Andrew Morton wrote:
> >>>>>   ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc3/2.6.20-rc4-mm1/
> >>>>>
> >>>> Hi,
> >>>>
> >>>> The git-acpi.patch replaces earlier "if(!handler) return -EINVAL" by
> >>>> "BUG_ON(!handler)". This locks my machine early at boot with a message
> >>>> along the lines of (It's hand copied):
> >>>> Int 6: cr2: 00000000 eip: c0570e05 flags: 00010046 cs: 60
> >>>> stack: c054ffac c011db2b c04936d0 c054ff68 c054ffc0 c054fff4 c057da2c
> >>>>
> >>>> Reverting the change as follows, allows booting:
> >>>> Any ideas to debug this further?
> >>>> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> >>>> index db0c5f6..fba018c 100644
> >>>> --- a/drivers/acpi/tables.c
> >>>> +++ b/drivers/acpi/tables.c
> >>>> @@ -414,7 +414,9 @@ int __init acpi_table_parse(enum acpi_ta
> >>>>  	unsigned int index;
> >>>>  	unsigned int count = 0;
> >>>>  
> >>>> -	BUG_ON(!handler);
> >>>> +	if (!handler)
> >>>> +		return -EINVAL;
> >>>> +	/*BUG_ON(!handler);*/
> >>>>  
> >>>>  	for (i = 0; i < sdt_count; i++) {
> >>>>  		if (sdt_entry[i].id != id)
> >>> What do you see if on failure you also print out the params, like below?
> > 
> > I get this:
> > 
> > ACPI: RSDP (v000 GBT                                   ) @ 0x000f6e80
> > ACPI: RSDT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x3fff3000
> > ACPI: FADT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x3fff3040
> > ACPI: MADT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x3fff7100
> > ACPI: DSDT (v001 GBT    AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
> > ACPI: PM-Timer IO Port: 0x1008
> > ACPI: Local APIC address 0xfee00000
> > ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
> > Processor #0 15:2 APIC version 20
> > ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
> > Processor #1 15:2 APIC version 20
> > ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
> > ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
> > ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
> > IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
> > ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> > ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> > ACPI: IRQ0 used by override.
> > ACPI: IRQ2 used by override.
> > ACPI: IRQ9 used by override.
> > Enabling APIC mode:  Flat.  Using 1 I/O APICs
> > ACPI: acpi_table_parse(17, 00000000) HPET NULL handler!
> > Using ACPI (MADT) for SMP configuration information
> > 
> 
> ACPI: acpi_table_parse(17, 00000000) HPET NULL handler!
So the BUG_ON is triggered by CONFIG_HPET_TIMER not being defined,
causing acpi_parse_hpet to be NULL.
Should the acpi_table_parse() called be ifdef'ed of is the previous
behaviour (returning -EINVAL) just OK?

Regards,
Frederik
