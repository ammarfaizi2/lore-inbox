Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261658AbVBHUiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbVBHUiJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 15:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbVBHUhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 15:37:38 -0500
Received: from mailhub2.nextra.sk ([195.168.1.110]:22537 "EHLO toe.nextra.sk")
	by vger.kernel.org with ESMTP id S261539AbVBHUh2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 15:37:28 -0500
Message-ID: <4209237C.4020901@rainbow-software.org>
Date: Tue, 08 Feb 2005 21:39:24 +0100
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
CC: Matthew Wilcox <matthew@wil.cx>, Jean Delvare <khali@linux-fr.org>,
       Enrico Bartky <DOSProfi@web.de>, linux-pci@atrey.karlin.mff.cuni.cz,
       LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Maarten Deprez <maartendeprez@scarlet.be>, Greg KH <gregkh@suse.de>
Subject: Re: M7101
References: <41DC59A4.1070006@web.de> <20050206152615.1ab7498c.khali@linux-fr.org> <20050206150611.GR20386@parcelfarce.linux.theplanet.co.uk> <20050208141322.A2831@jurassic.park.msu.ru>
In-Reply-To: <20050208141322.A2831@jurassic.park.msu.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Kokshaysky wrote:
> On Sun, Feb 06, 2005 at 03:06:11PM +0000, Matthew Wilcox wrote:
> 
>>Looks pretty good to me.  For clarity, I'd change:
>>
>>-	m7101 = pci_scan_single_device(dev->bus, 0x18);
>>+	m7101 = pci_scan_single_device(dev->bus, PCI_DEVFN(3, 0));
> 
> 
> No, it's pretty broken regardless of the change. The integrated devices
> on ALi southbridges (IDE, PMU, USB etc.) have programmable IDSELs,
> so using hardcoded devfn is just dangerous. We must figure out what
> the device number PMU will have before we turn it on.
> Something like this:
> 
> 	// NOTE: These values are for m1543. Someone must verify whether
> 	// they are the same for m1533 or not.
> 	static char pmu_idsels[4] __devinitdata = { 28, 29, 14, 15 };
> 
> 	...
> 
> 	/* Get IDSEL mapping for PMU (bits 2-3 of 0x72). */
> 	pci_read_config_byte(dev, 0x72, &val);
> 	devnum = pmu_idsel[(val >> 2) & 3] - 11;
> 	m7101 = pci_get_slot(dev->bus, PCI_DEVFN(devnum, 0));
> 	if (m7101) {
> 		/* Failure - there is another device with the same number. */
> 		pci_dev_put(m7101);
> 		return;
> 	}
> 
> 	/* Enable PMU. */
> 	...
> 
> 	m7101 = pci_scan_single_device(dev->bus, PCI_DEVFN(devnum, 0));
> 	...

In fact, the patch is completely wrong for M1533 south bridge, it will 
work only with M1543.
M1533 has different PCI config. register layout - the bit 2 of 0x5F 
register is not used for enabling/disabling M7101 but for "on-chip 
arbiter control". M7101 can be enabled/disabled using bit 6 of 0x5D 
register... M1533 has also different M7101 registers.
The best thing about this is that these two M7101s have the same PCI 
device IDs (0x7101).
The south bridges have the same PCI IDs too (0x1533 used by both M1533 
and M1543). But according to the datasheet, M1543 should have revision 
number at least 0xC0.

-- 
Ondrej Zary
