Return-Path: <linux-kernel-owner+w=401wt.eu-S1161181AbXAMAI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161181AbXAMAI7 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 19:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161180AbXAMAI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 19:08:58 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:4738 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161182AbXAMAI5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 19:08:57 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:from;
        b=UeTKiW5Im7TDEG3T/u2q5ataLDCpf2oo1okHkeg6Bqn1bAdulvj2qtDXUFG7ThKxLFOSY9TtUjjsqIG1WaoBrAjt8JG+XBjVuh4w/iId/mNwznF5oklOmtTPj+2n1Hge1Pj7d8QSy0CXLio+JA+9pz1i9IhGsA9MIZN7BMlJOKs=
Message-ID: <45A8230E.5050600@googlemail.com>
Date: Sat, 13 Jan 2007 01:08:46 +0100
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Frederik Deweerdt <deweerdt@free.fr>, Len Brown <lenb@kernel.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rui.zhang@intel.com, michal.k.k.piotrowski@gmail.com
Subject: Re: Early ACPI lockup (was Re: 2.6.20-rc4-mm1)
References: <20070111222627.66bb75ab.akpm@osdl.org> <20070112102040.GD5941@slug> <200701121753.08710.lenb@kernel.org> <20070112231015.GI5941@slug> <45A81B6C.3030106@gmail.com>
In-Reply-To: <45A81B6C.3030106@gmail.com>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby napisał(a):
> Frederik Deweerdt wrote:
>> On Fri, Jan 12, 2007 at 05:53:08PM -0500, Len Brown wrote:
>>> On Friday 12 January 2007 05:20, Frederik Deweerdt wrote:
>>>> On Thu, Jan 11, 2007 at 10:26:27PM -0800, Andrew Morton wrote:
>>>>>   ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc3/2.6.20-rc4-mm1/
>>>>>
>>>> Hi,
>>>>
>>>> The git-acpi.patch replaces earlier "if(!handler) return -EINVAL" by
>>>> "BUG_ON(!handler)". This locks my machine early at boot with a message
>>>> along the lines of (It's hand copied):
>>>> Int 6: cr2: 00000000 eip: c0570e05 flags: 00010046 cs: 60
>>>> stack: c054ffac c011db2b c04936d0 c054ff68 c054ffc0 c054fff4 c057da2c
>>>>
>>>> Reverting the change as follows, allows booting:
>>>> Any ideas to debug this further?
>>>> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
>>>> index db0c5f6..fba018c 100644
>>>> --- a/drivers/acpi/tables.c
>>>> +++ b/drivers/acpi/tables.c
>>>> @@ -414,7 +414,9 @@ int __init acpi_table_parse(enum acpi_ta
>>>>  	unsigned int index;
>>>>  	unsigned int count = 0;
>>>>  
>>>> -	BUG_ON(!handler);
>>>> +	if (!handler)
>>>> +		return -EINVAL;
>>>> +	/*BUG_ON(!handler);*/
>>>>  
>>>>  	for (i = 0; i < sdt_count; i++) {
>>>>  		if (sdt_entry[i].id != id)
>>> What do you see if on failure you also print out the params, like below?
> 
> I get this:
> 
> ACPI: RSDP (v000 GBT                                   ) @ 0x000f6e80
> ACPI: RSDT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x3fff3000
> ACPI: FADT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x3fff3040
> ACPI: MADT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x3fff7100
> ACPI: DSDT (v001 GBT    AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
> ACPI: PM-Timer IO Port: 0x1008
> ACPI: Local APIC address 0xfee00000
> ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
> Processor #0 15:2 APIC version 20
> ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
> Processor #1 15:2 APIC version 20
> ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
> ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
> ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
> IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
> ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> ACPI: IRQ0 used by override.
> ACPI: IRQ2 used by override.
> ACPI: IRQ9 used by override.
> Enabling APIC mode:  Flat.  Using 1 I/O APICs
> ACPI: acpi_table_parse(17, 00000000) HPET NULL handler!
> Using ACPI (MADT) for SMP configuration information
> 

ACPI: RSDP (v000 ACPIAM                                ) @ 0x000f9e30
ACPI: RSDT (v001 A M I  OEMRSDT  0x10000414 MSFT 0x00000097) @ 0x7ff30000
ACPI: FADT (v002 A M I  OEMFACP  0x10000414 MSFT 0x00000097) @ 0x7ff30200
ACPI: MADT (v001 A M I  OEMAPIC  0x10000414 MSFT 0x00000097) @ 0x7ff30390
ACPI: OEMB (v001 A M I  OEMBIOS  0x10000414 MSFT 0x00000097) @ 0x7ff40040
ACPI: DSDT (v001  P4P81 P4P81104 0x00000104 INTL 0x02002026) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
ACPI: acpi_table_parse(17, 00000000) HPET NULL handler!
Using ACPI (MADT) for SMP configuration information

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/)
