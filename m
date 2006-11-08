Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161098AbWKHQSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161098AbWKHQSk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 11:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161109AbWKHQSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 11:18:40 -0500
Received: from mga01.intel.com ([192.55.52.88]:17190 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1161107AbWKHQSj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 11:18:39 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,401,1157353200"; 
   d="scan'208"; a="13305914:sNHT37325610"
Message-ID: <45520337.2070303@intel.com>
Date: Wed, 08 Nov 2006 08:17:59 -0800
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: John <me@privacy.net>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, hpa@zytor.com,
       saw@saw.sw.com.sg
Subject: Re: Intel 82559 NIC corrupted EEPROM
References: <454B7C3A.3000308@privacy.net> <454BF0F1.5050700@zytor.com> <45506C9A.5010009@privacy.net> <4551B7B8.8080601@privacy.net>
In-Reply-To: <4551B7B8.8080601@privacy.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Nov 2006 16:17:59.0957 (UTC) FILETIME=[755C5C50:01C70351]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John wrote:
> I have a motherboard with three on-board 82559 NICs.
> 
>  o eepro100.ko properly initializes all three NICs
>  o e100.ko fails to initialize one of them
> 
> NOTE: With kernel 2.6.14, e100.ko fails to initialize the NIC with MAC 
> address 00:30:64:04:E6:E4. With kernel 2.6.18 e100.ko fails to 
> initialize the NIC with MAC address 00:30:64:04:E6:E5.
> 
> The problem is not an incorrect checksum. (Donald Becker's dump utility 
> reports a correct checksum for all three NICs.) The problem seems to be 
> that e100.ko fails to read the contents of one of the EEPROMs.

[snip]

> 'insmod e100.ko eeprom_bad_csum_allow=1' reports:
> 
> e100: Intel(R) PRO/100 Network Driver, 3.5.10-k2-NAPI
> e100: Copyright(c) 1999-2005 Intel Corporation
> ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 12
> PCI: setting IRQ 12 as level-triggered
> ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LNKA] -> GSI 12 (level, 
> low) -> IRQ 12
> e100: eth0: e100_probe: addr 0xe5300000, irq 12, MAC addr 00:30:64:04:E6:E4
> ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
> PCI: setting IRQ 10 as level-triggered
> ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKB] -> GSI 10 (level, 
> low) -> IRQ 10
> e100: 0000:00:09.0: e100_eeprom_load: EEPROM corrupted
> e100: 0000:00:09.0: e100_probe: Invalid MAC address from EEPROM, aborting.
> ACPI: PCI interrupt for device 0000:00:09.0 disabled
> e100: probe of 0000:00:09.0 failed with error -11

This is what I was afraid of: even though the code allows you to bypass the EEPROM 
checksum, the probe fails on a further check to see if the MAC address is valid.

Since something with this NIC specifically made the EEPROM return all 0xff's, the MAC 
address is automatically invalid, and thus probe fails.

It seems that the driver has more problems with this NIC than just the eeprom checksum 
being bad. Needless to say this might need fixing.

Can you load the eepro driver and send me the full eeprom dump? Perhaps I can duplicate 
things over here.

[snip]

> On a related note, I am concerned by this message:
> 
>    Sleep mode is enabled.  This is not recommended.
>    Under high load the card may not respond to
>    PCI requests, and thus cause a master abort.
>    To clear sleep mode use the '-G 0 -w -w -f' options.
> 
> Intel 82559 EEPROM Map and Programming Information (AP-394) states:
> http://www.intel.com/design/network/applnots/ap394.htm
> 
> The Standby Enable bit enables the 82559 to enter standby mode. When 
> this bit equals 1b, the 82559 is able to recognize an idle state and can 
> enter standby mode (some internal clocks are stopped for power saving 
> purposes). The 82559 does not require a PCI clock signal in standby 
> mode. If this bit equals 0b, the idle recognition circuit is disabled 
> and the 82559 always remains in an active state. Thus, the 82559 always 
> requests PCI CLK using the Clockrun mechanism.
> 
> Auke, do you agree with Donald Becker's warning?

If you are using the e100 in a performance situation, I would certainly switch it off :)

> If I disable STB, the NICs will waste a bit more power when idle,
> is that correct? Are there other implications?

hm, I don't know the power specs of e100 that well, so I can't say that it saves 
significant amounts of power, but I suspect it would.

Power management on nics is hairy business. As suggested, it can take time before the 
nic powers back up, performance can be impacted, and some commands might return an 
invalid or unknown value. OTOH our labs here test these things pretty well before they 
get send out to customers and resales agents, so Beckers cautious wording catches the 
severity pretty well (recommended).

I would say that under most circumstances, it's safe to enable STB, but you might want 
to disable it for use in routing and other server applications, where most of the time 
the NIC is active anyway.

hth

Auke


> 
> Thanks for reading this far!
> 
> John
