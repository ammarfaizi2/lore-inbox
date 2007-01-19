Return-Path: <linux-kernel-owner+w=401wt.eu-S964784AbXASXhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbXASXhW (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 18:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932872AbXASXhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 18:37:22 -0500
Received: from mga03.intel.com ([143.182.124.21]:23079 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932869AbXASXhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 18:37:20 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.13,213,1167638400"; 
   d="scan'208"; a="170924532:sNHT20329036"
Message-ID: <45B1562C.8070503@intel.com>
Date: Fri, 19 Jan 2007 15:37:16 -0800
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.9 (X11/20061228)
MIME-Version: 1.0
To: Adam Kropelin <akropel1@rochester.rr.com>
CC: Allen Parker <parker@isohunt.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: intel 82571EB gigabit fails to see link on 2.6.20-rc5 in-tree
 e1000 driver (regression)
References: <20070117190448.A20184@mail.kroptech.com> <45AEB79B.2010205@intel.com> <00d701c73c1f$b2bb2390$84163e05@kroptech.com>
In-Reply-To: <00d701c73c1f$b2bb2390$84163e05@kroptech.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Jan 2007 23:37:17.0185 (UTC) FILETIME=[C13C2F10:01C73C22]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Kropelin wrote:
> Auke Kok wrote:
>> Adam Kropelin wrote:
>>> I am experiencing the no-link issue on a 82572EI single port copper
>>> PCI-E card. I've only tried 2.6.20-rc5, so I cannot tell if this is a
>>> regression or not yet. Will test older kernel soon.
>>>
>>> Can provide details/logs if you want 'em.
>>
>> we've already established that Allen's issue is not due to the driver
>> and caused by interrupts being mal-assigned on his system, possibly a
>> pci subsystem bug. You also have a completely different board
>> (82572EI instead of 82571EB), so I'd like to see the usual debugging
>> info as well as hearing from you whether 2.6.19.any works correctly.
> 
> On 2.6.19 the link status is working (follows cable plug/unplug), but no 
> tx or rx packets get thru. Attempts to transmit occasionally result in 
> tx timed out errors in dmesg, but I cannot seem to generate these at will.
> 
> On 2.6.20-rc5, the link status does not work (link is always down), and 
> as expected no tx or rx. No tx timed out errors this time, presumably 
> because it thinks the link is down. Note that both the switch and the 
> LEDs on the NIC  indicate a good 1000 Mbps link.
> 
> dmesg, 'cat /proc/interrupts', and 'lspci -vvv' attached for 2.6.20-rc5. 
> The data from 2.6.19 is essentially the same.

at least your interrupts look sane. I see you are using MSI, but no interrupts arrive at 
neither OS nor driver.

>> On top of that I posted a patch to rc5-mm yesterday that fixes a few
>> significant bugs in the rc5-mm driver, so please apply that patch too
>> before trying, so we're not wasting our time finding old bugs ;)
> 
> I haven't been able to test rc5-mm yet because it won't boot on this 
> box. Applying git-e1000 directly to -rc4 or -rc5 results in a number of 
> rejects that I'm not sure how to fix. Some are obvious, but the others 
> I'm unsure of.

that won't work. You either need to start with 2.6.20-rc5 (and pull the changes pending 
merge in netdev-2.6 from Jeff Garzik), or start with 2.6.20-rc4-mm1 and manually apply 
that patch I sent out on monday. A different combination of either of these two will not 
work, as they are completely different drivers.

can you include `ethtool ethX` output of the link down message and `ethtool -d ethX` as 
well? I'll need to dig up an 82572 and see what's up with that, I've not seen that 
problem before.

More importantly, I suspect that *again* the issue is caused by interrupts not arriving 
or getting lost. Can you try running with MSI disabled in your kernel config?

FYI the driver gives an interrupt to signal to the driver that link is up. no interrupt 
== no link detected. So that explains the symptom.

Auke
