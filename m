Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751657AbWCCDT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657AbWCCDT3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 22:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751658AbWCCDT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 22:19:28 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:39370 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751586AbWCCDT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 22:19:28 -0500
Message-ID: <4407B564.7000303@jp.fujitsu.com>
Date: Fri, 03 Mar 2006 12:17:56 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Grant Grundler <grundler@parisc-linux.org>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 0/4] PCI legacy I/O port free driver (take4)
References: <44070B62.3070608@jp.fujitsu.com> <20060302155056.GB28895@flint.arm.linux.org.uk> <20060302172436.GC22711@colo.lackof.org> <20060302193441.GG28895@flint.arm.linux.org.uk>
In-Reply-To: <20060302193441.GG28895@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Thu, Mar 02, 2006 at 10:24:36AM -0700, Grant Grundler wrote:
> 
>>On Thu, Mar 02, 2006 at 03:50:57PM +0000, Russell King wrote:
>>
>>>I've been wondering whether this "no_ioport" flag is the correct approach,
>>>or whether it's adding to complexity when it isn't really required.
>>
>>I think it's the simplest solution to allowing a driver
>>to indicate which resources it wants to use. It solves
>>the problem of I/O Port resource allocation sufficiently
>>well.
> 
> 
> I have another question (brought up by someone working on a series of
> ARM machines which make heavy use of MMIO.)
> 
> Why isn't pci_enable_device_bars() sufficient - why do we have to
> have another interface to say "we don't want BARs XXX" ?
> 
> Let's say that we have a device driver which does this sequence (with,
> of course, error checking):
> 
> 	pci_enable_device_bars(dev, 1<<1);
> 	pci_request_regions(dev);
> 
> (a) should PCI remember that only BAR 1 has been requested to be enabled,
>     and as such shouldn't pci_request_regions() ignore BAR 0?
> 
> (b) should the PCI driver pass into pci_request_regions() (or even
>     pci_request_regions_bars()) a bitmask of the BARs it wants to have
>     requested, and similarly for pci_release_regions().
> 
> Basically, if BAR0 hasn't been enabled, has pci_request_regions() got
> any business requesting it from the resource tree?
> 

Hmm, pci_enable_device_bars() approach looks better and better to me.
If we use this approach, we need to consider which (a) and (b) we
should use, as you said.

The (b) option looks natural to me because pci_enable_device_bars() and
pci_request_regions_bars() becomes a pair. But the (b) option would have
a problem at resume time. If the driver doesn't have .resume() method,
default resume routine (i.e. pci_default_resume()) will be called, and
it calls pci_enable_device().

The (a) option doesn't have this kind of problem. But it looks a little
strange to me that we use pci_enable_device_bars() at probe time while
we use pci_enable_device() at resume time, though I might be too anxious.

To tell the truth, I've considered this before. I could not come up with
which is better between (a) and (b), and then I posted another approach
which introduce a new API. Now I came back to this approach again. Maybe
I'm being caught by the endless loop...

I would very much appreciate giving me any comments about (a) and (b).

Thanks,
Kenji Kaneshige
