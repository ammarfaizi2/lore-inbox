Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWB1DC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWB1DC2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 22:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWB1DC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 22:02:28 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:34515 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932161AbWB1DC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 22:02:28 -0500
Message-ID: <4403BCA2.4050901@jp.fujitsu.com>
Date: Tue, 28 Feb 2006 11:59:46 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Kenji Kaneshige <kaneshige.kenji@soft.fujitsu.com>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Andi Kleen <ak@suse.de>,
       benh@kernel.crashing.org
Subject: Re: [PATCH 0/4] PCI legacy I/O port free driver (take 3)
References: <44028502.4000108@soft.fujitsu.com> <44033A2D.9000902@pobox.com>
In-Reply-To: <44033A2D.9000902@pobox.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Kenji Kaneshige wrote:
> 
>>Hi,
>>
>>Here is an updated set of patches for PCI legacy I/O port free drivers
>>which incorporates feedbacks. Summary of changes from the previous
>>version are:
>>
>>    - Removed the device_flags field from struct pci_device_id, which
>>      was introduced in the previous version of patch
>>
>>    - Changed e1000 driver to use the driver_data field in struct
>>      pci_device_id to see if the device needs I/O port regions.
>>
>>    - Added proper messages instead of WARN_ON() at the error.
>>
>>    - Updated the Documentation/pci.txt
>>
>>I'm attaching the following four patches:
>>
>>    [patch 1/4] Add no_ioport flag into pci_dev
>>    [patch 2/4] Update Documentation/pci.txt
>>    [patch 3/4] Make Intel e1000 driver legacy I/O port free
>>    [patch 4/4] Make Emulex lpfc driver legacy I/O port free
>>
>>I'm attaching the brief description below about what the problem I'm
>>trying to solve is.
>>
>>Thanks,
>>Kenji Kaneshige
>>
>>
>>Brief Description
>>~~~~~~~~~~~~~~~~~
>>I encountered a problem that some PCI devices don't work on my system
>>which have huge number of PCI devices.
>>
>>It is mandatory for all PCI device drivers to enable the device by
>>calling pci_enable_device() which enables all regions probed from the
>>device's BARs. If pci_enable_device() failes to enable any regions
>>probed from BARs, it returns as error. On the large servers, I/O port
>>resource could not be assigned to all PCI devices because it is
>>limited (64KB on Intel Architecture[1]) and it would be fragmented
>>(I/O base register of PCI-to-PCI bridge will usually be aligned to a
>>4KB boundary[2]). In this case, the devices which have no I/O port
>>resource assigned don't work because pci_enable_device() for those
>>devices failes. This is what happened on my machine.
> 
> 
> This series still leaves a lot to be desired, and creates unnecessary
> driver churn.  The better solution is:
> 
> 1) pci_enable_device() enables what it can
> 

I guess your idea is changing pci_enable_device() not to return as error
even if it fails to enable some regions. Is it correct? If yes, we need
to change all architecture dependent code (e.g. pcibios_enable_device())
to do that, and it would need much bigger change.


> 2) Drivers, as they already do, will fail if they cannot map the desired
> memory or IO resources that are needed.
> 
> Thus, the PCI layer needs only to do #1, and existing driver code
> handles the rest of the situation as one currently expects.
> 

Many driver uses pci_request_regions() instead of calling pci_request_region()
for each region. That is, we need to consider the same problem at
pci_request_regions() time. Converting drivers to use pci_request_region()
instead of pci_request_regions() requires many changes and it would be
troublesome for driver writers.

Thanks,
Kenji Kaneshige
