Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263343AbTLDTyN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 14:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263376AbTLDTyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 14:54:13 -0500
Received: from fed1mtao05.cox.net ([68.6.19.126]:37055 "EHLO
	fed1mtao05.cox.net") by vger.kernel.org with ESMTP id S263343AbTLDTyF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 14:54:05 -0500
Date: Thu, 4 Dec 2003 13:04:15 -0700
From: Jesse Allen <the3dfxdude@hotmail.com>
To: Allen Martin <AMartin@nvidia.com>, b@netzentry.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: NForce2 pseudoscience stability testing (2.6.0-test11)
Message-ID: <20031204200415.GA183@tesore.local>
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F874@mail-sc-6.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F874@mail-sc-6.nvidia.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 03, 2003 at 09:11:37PM -0800, Allen Martin wrote:
> I don't think there's any faulty nForce IDE hardware or we would have heard
> about it from windows users (and we haven't).  

Ok.  I have never tested a motherboard driver for a problem like this.  But I'm starting to understand more.

I went ahead and tried more configurations.  I wish I had a pci ide card with 
udma 100, but the one I have is being used =(.  So I just had to make do with 
what I have.  The test is very simple, because it is very simple to trigger it. 
I just grep something very large.  It locks up almost immediately with 2.6 + 
apic + nvidia ide with dma enabled.

I ran grep on these devices:
IDE hard disk at UDMA 100, 100 MB/s, flat cable, 80w.  grep on kernel source.
same IDE hard disk with DMA disabled, 16 MB/s. grep on kernel source.
SCSI hard disk at 20 MB/s. grep on kernel source.
IDE 24x cdrom, 11 MB/s.  grepped whole cd-rom fs, about 300 MB.

During the test runs, I tried:
bios update -- no difference (same results no matter what)
preempt on/off -- no difference (same results)

The results (uniprocessor system):
1. under 2.6.0-test11 with nvidia ide, dma enabled, apic
grep on IDE hard disk at UDMA 100 -- locks nearly immediately
and later attempt, grep on cdrom -- doesn't lock up (still will lock up with 
hard disk though)

2. under 2.6.0-test11 with nvidia ide, dma, pic
grep on IDE hard disk at UDMA 100 -- doesn't lock up

3. under 2.4.23, with nvidia ide, dma enabled, apic
grep on IDE hard disk at UDMA 100 -- doesn't lock up

4. under 2.6.0-test11 with aic7xxx, ide completely disabled, apic
grep on SCSI disk -- doesn't lock up

5. under 2.6.0-test11 with nvidia ide, dma disabled, apic
grep on IDE hard disk at 16 MB/s -- doesn't lock up


So basically, I conclude that UDMA 100 will cause a lockup nearly immediately. 
The slower interfaces speeds don't cause a lockup during the test, but that 
doesn't mean the kernel will never lock up.  So DMA does produce a lockup 
faster.  Either longer stresses are required (which means spending more time =( 
I've only had the board for two days - heh heh), or more preferably, I need to
test with another pci ide controller.  Whatever it is, it seems to be the high
speeds like UDMA 100 or perhaps similarly stressing pci devices that will do it.


> 
> The problem with comparing the nForce IDE driver against the generic IDE
> driver is that the generic IDE driver won't enable DMA, so the interrupt
> rate will be much different.  If there's some interrupt race condition in
> APIC mode, disabling DMA may mask it.
> 

Yep, you're right.


Jesse
