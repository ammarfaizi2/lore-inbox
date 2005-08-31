Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964775AbVHaOuR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbVHaOuR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 10:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932380AbVHaOuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 10:50:17 -0400
Received: from dgate2.fujitsu-siemens.com ([217.115.66.36]:35976 "EHLO
	dgate2.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S932349AbVHaOuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 10:50:16 -0400
X-SBRSScore: None
Message-ID: <4315C3A5.7080200@fujitsu-siemens.com>
Date: Wed, 31 Aug 2005 16:50:13 +0200
From: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Organization: Fujitsu Siemens Computers
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       "Wichert, Gerhard" <Gerhard.Wichert@fujitsu-siemens.com>
Subject: Re: APIC version and 8-bit APIC IDs
References: <42FC8461.2040102@fujitsu-siemens.com.suse.lists.linux.kernel> <p73pssj2xdz.fsf@verdi.suse.de> <4315AD07.2020500@fujitsu-siemens.com> <Pine.LNX.4.61L.0508311417110.10940@blysk.ds.pg.gda.pl> <4315B2D9.6080700@fujitsu-siemens.com> <Pine.LNX.4.61L.0508311450020.10940@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.61L.0508311450020.10940@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Putting everyone cc again and leaving maciej's reply intact for 
reference ]

Maciej W. Rozycki wrote:

>>The ID is 0x14 for Intel. But that is wrong for AMD CPUs. The actual Dual-Core
> 
> 
>  Why can't hw designers ever get such things right?  Sigh...
> 
> 
>>Athlon CPUs we have report an APIC version of 0x10. Please refer to the start
>>of this thread.
> 
> 
>  Frankly, such a change implies a change to the inter-APIC communication 
> protocol, so the major revision should have been bumped, like it happened 
> for the I/O APIC (0x20); I hope they do not worry of changing the design 
> so many times they run out of numbers!  Thus none of the implementers has 
> done their job properly, but for Intel there is at least some change, 
> while for AMD there seems no generic way of determining that -- 0x10 
> implies a "traditional" integrated APIC as implemented in Pentium in 1995, 
> using a three-wire serial bus for communication...
> 
>  Perhaps a variable should be added holding the "architectural revision" 
> of the APIC subsystem, set up by the early CPU/APIC initialization code 
> and used from there on instead of direct references to the version 
> register as implemented in the hardware.  It does not have to be based on 
> what hardware uses, e.g.:
> 
> - 0: no APIC,
> 
> - 1: 82489DX -- communication using a five-wire inter-APIC bus, 8-bit 
>      physical ID, 32-bit logical ID, etc.,
> 
> - 2: Pentium-style -- communication using a three-wire inter-APIC bus, 
>      4-bit physical ID, 8-bit logical ID, etc.,
> 
> - 3: P4-style -- communication using the system bus, 8-bit physical ID, 
>      8-bit logical ID, etc.

AMD has their HyperTransport bus, which is yet a different thing.

According to what AMD told us, all K8 CPUs support 8-bit APIC IDs 
("extended APIC IDs" in their speak), but they are only enabled
"when both ApicExtId and ApicExtBrdCst in the HyperTransport Transaction 
Control Register are set".

As we cannot read PCI config space at APIC configuration time, my 
suggestion would be something like

unsigned char phys_apic_id_mask(int apic_version)
         if (apic_version < 0x10 || apic_version >= 0x14 ||
		(boot_cpu_data.vendor == X86_VENDOR_AMD &&
          	 boot_cpu_data.family >= 0x0f))
		return 0xff;
	else
		return 0x0f;
}

That would assume that no BIOS is so stupid to set APIC IDs >0xf and at 
the same time forget to enable the respective bits in the HyperTransport 
Transaction Control Register.

I do not oversee whether boot_cpu_data is initialized when the APIC IDs 
need to be tested/masked, but somebody else certainly does.

> 
> 
>>Anyway, I understand that you agree this does not belong into the subarch
>>code?
> 
> 
>  That's CPU/chipset specific indeed.  It shouldn't really depend on the 
> platform these are used in.  Exceptions, if any, can be handled on a case 
> by case basis.
> 
>   Maciej

Regards
Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1        mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy
