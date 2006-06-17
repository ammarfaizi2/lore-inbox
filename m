Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751586AbWFQF06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbWFQF06 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 01:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751597AbWFQF06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 01:26:58 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:62082 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1751570AbWFQF05 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 01:26:57 -0400
Message-ID: <4493929C.6080202@myri.com>
Date: Sat, 17 Jun 2006 01:26:52 -0400
From: Brice Goglin <brice@myri.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: linux-pci@atrey.karlin.mff.cuni.cz, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Whitelist chipsets supporting MSI and check Hyper-transport
 capabilities
References: <4493709A.7050603@myri.com> <20060617050524.GX2387@parisc-linux.org>
In-Reply-To: <20060617050524.GX2387@parisc-linux.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
>> We introduce whitelisting of chipsets that are known to support MSI and
>> keep the existing backlisting to disable MSI for other chipsets. When it
>> is unknown whether the root chipset support MSI or not, we disable MSI
>> by default except if pci=forcemsi was passed.
>
> I think that's a bad idea. Blacklisting is the better idea in the
> long-term.

In this case, we absolutely need an exhaustive list of chipsets that do
not support MSI. And it looks like there are a lot of them in the
non-PCI-E world. Our concern is that trying to enable MSI when it does
not work breaks drivers. While disabling MSI generally keeps drivers
working (except for instance for the Infinipath hardware, but our
whitelisting of the nVidia chipset might help them :)).
For the long term, I hope we'll end up having an exhaustive list of
chipsets that do not support MSI. But in the meantime, our "whitelisting
+ disable when we don't know" might help getting MSI as much as possible
without breaking to many things.

>
>> Bus flags inheritance is dropped since it has been reported to be broken.
>
> I must have missed that report. Please elucidate.
>

It is based on the following thread:
    http://www.ussg.iu.edu/hypermail/linux/kernel/0605.2/0929.html

The amd8131 MSI quirk cannot be EARLY or HEADER because it would be
called before dev->subordinate has been set (then, PCI_BUS_FLAGS_NO_MSI
could not be set in the bus flags). But, flags are inherited while the
PCI hierarchy is scanned, which means the quirk has to be EARLY or HEADER.
To solve this issue, we would need a quirk that is called while the PCI
hierarchy is scanned (ie, before FINAL or ENABLE) and after the pci
child bus of the bridge is created (ie, after EARLY and HEADER). But I
am not sure whether adding a new quirk type for this is a good idea.

Since the MSI is always actually processed on the root chipset, we know
we have to check there. We thought that inheriting bus flags was not
really required. That's why my patch finds the root chipset and checks
bus flags there.

Brice

