Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269477AbTCDRzR>; Tue, 4 Mar 2003 12:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269479AbTCDRzR>; Tue, 4 Mar 2003 12:55:17 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:25302 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S269477AbTCDRzQ>; Tue, 4 Mar 2003 12:55:16 -0500
Date: Tue, 04 Mar 2003 10:15:44 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: PCI and MWI
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Message-id: <3E64ED50.2030305@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <3E4622B0.7040201@pobox.com>
 <20030210151813.B12043@jurassic.park.msu.ru> <3E47DF75.20801@pacbell.net>
 <3E5B1C08.6030906@pacbell.net> <3E5C2368.6010502@pobox.com>
 <20030226160403.A15729@jurassic.park.msu.ru> <3E600281.2050805@pacbell.net>
 <20030302192215.A645@localhost.park.msu.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Kokshaysky wrote:
> David Brownell wrote:
> 
>> I wonder if it might not be best to
>>have cpuinfo_x86 store that value; people don't really expect
>>to see cpu-specific logic in the pci code.
> 
> 
> Don't know. The cpuinfo_x86 is per-CPU thing, while pci_cache_line_size
> is definitely system-wide.

So pci_cache_line_size = max (all L1 cacheline sizes in the system)
with some possible fudging (that i486 issue, etc).  But your patch
would seem to handle most archs correctly already.


>>One minor curiousity:  a multifunction device seemed to share
>>PCI_CACHE_LINE_SIZE between the enabled/active function and ones
>>without a driver.  Makes sense, the values can never legally
>>differ, but some more troublesome devices don't do that...
> 
> 
> Hmm, we treat each function as an independent PCI device, as per PCI
> spec. Sharing the config space between functions sounds like a severe
> hardware bug. Do you have any examples?

I just happened to notice _this specific case_ which as I mentioned
sure doesn't feel like a hardware bug to me!  The specific device
was a Philips ISP 1561 USB 2.0 controller (two OHCI one EHCI), and
the two more troublesome (less forgiving) devices were from VIA.

So that machine had quite a few high speed USB controllers (including
a NetChip 2280 :) running Linux, all using MWI and no particular
problems being visible ... and no messages about broken BIOS setup.


>>Re Jeff's suggestion to merge this to 2.5 ASAP, sounds right
>>to me if all the arch code gets worked out up front.  I have
>>no problem with the idea of enabling it as done here (when
>>the device is enabled) rather than waiting to enable DMA,
>>though I'd certainly pay attention to people who know about
>>devices broken enough to get indigestion that way.
> 
> 
> Well, in 2.4 on Alpha and ARM we still have pdev_enable_device() thing
> which is the mostly __init-only variant of the pci_enable_device(),
> but it also forces correct cacheline size and reasonable (more or less)
> latency timer for *all* devices. Nobody had problems with it over the last
> 2 years, so I believe that setting cacheline size in pci_enable_device()
> rather than in pci_set_master() is the right thing (and agrees with the
> spec better).

Sounds good to me then.

- Dave



