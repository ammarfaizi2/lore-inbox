Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268100AbUH1BXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268100AbUH1BXV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 21:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268102AbUH1BXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 21:23:21 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:65158 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S268100AbUH1BXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 21:23:11 -0400
Date: Sat, 28 Aug 2004 10:23:07 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Subject: Re: [RFC&PATCH 1/2] PCI Error Recovery (readX_check)
To: Grant Grundler <iod00d@hp.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
Message-id: <412FDE7B.3070609@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: ja, en-us, en
User-Agent: Mozilla Thunderbird 0.7.3 (Windows/20040803)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I couldn't see my last mail posted few days ago in list (kicked?),
  so I send it again...
  Grant, Linus and Benjamin, I'd appreciate it if you could read this mail
  and let me know when you receive it. Of course, new comments are welcome.)

-------- Original Message --------

Grant Grundler wrote:
> Do we only need to determine there was an error in the IO hierarchy
> or do we also need to know which device/driver caused the error?
> 
> If the latter I agree with linus. If the former, then the error recovery
> can support asyncronous errors (like the bad DMA address case) and tell
> all affected (thanks willy) drivers.

What I supposed here is the former.

As Linus said, I also assume that most high-end hardware has enough bridges
and that the number of devices sharing same bridge would be minimized.
(And additionally, I assume that there is no "mixed" bridge - having both of
  device which owned by RAS-aware driver supporting recovery infrastructure
  and one which owned by not-aware driver.  Generally all should be RAS-aware.)

However, my implementation was not designed on the assumption that
"1 bridge = 1 device" like on ppc64, but on "1 bridge = 1 device group."
Of course, there could be some group of only 1 device.
It will depend on the structure of the system which you could configure it.

Devices in same group can run at same time keeping with a certain level of
performance, and not mind being affected(or even killed!) by (PCI bus)error
caused by someone in the group.  They either swim together or sink together.

Fortunately, such error is rare occurrence, and even if it had occurred,
it would be either "recoverable by a retry since it was a usual soft-error"
or "unrecoverable since it was a seldom hard-error."

Without this new recovery infrastructure, system cannot have proper drivers
to retry the transaction to determine whether the error was a soft or a hard,
and also cannot have these drivers not to return the broken data to user.
So now, system will down, last resort comes first.


> Does anyone expect to recover from devices attempting unmapped DMA?
> Ie an IOMMU which services multiple PCI busses getting a bad DMA address
> will cause the next MMIO read by any of the (grandchildren) PCI devices to 
> see an error (MCA on IA64). I'm asking only to determine if this is
> outside the scope of what the PCI error recovery is trying to support.

At present, unmapped DMA is outside of the scope... but alongside I also
trying to possible IA64 specific recovery(with MCA & CPE) using prototypes.


>>> +	bool "PCI device error recovery"
>>> +	depends on PCI
> 
> 	depends on PCI && EXPERIMENTAL
> 
>>> +	---help---
>>> +	By default, the device driver hardly recovers from PCI errors. When
>>> +	this feature is available, the special io interface are provided
>>> +	from the kernel.
> 
> May I suggest an alternate text?
> 	Saying Y provides PCI infrastructure to recover from some PCI errors.
> 	Currently, very few PCI drivers actually implement this.
> 	See Documentation/pci-errors.txt for a description of the
> 	infrastructure provided.

Thank you for good substitution :-D

I understand the needs of Documentation/pci-errors.txt for driver developers,
so I'll write the document and post it asap.


Thanks,
H.Seto
