Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbWCBBB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbWCBBB5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 20:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWCBBB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 20:01:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:51899 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751246AbWCBBBy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 20:01:54 -0500
From: Andi Kleen <ak@suse.de>
To: Michael Monnerie <m.monnerie@zmi.at>
Subject: Re: PCI-DMA: Out of IOMMU space on x86-64 (Athlon64x2), with solution
Date: Thu, 2 Mar 2006 02:03:48 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, suse-linux-e@suse.com
References: <200603020023.21916@zmi.at>
In-Reply-To: <200603020023.21916@zmi.at>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603020203.49128.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 March 2006 00:23, Michael Monnerie wrote:
> Hello, I use SUSE 10.0 with all updates and actual kernel 2.6.13-15.8 as
> provided from SUSE (just self compiled to optimize for Athlon64, SMP,
> and HZ=100), with an Asus A8N-E motherboard, and an Athlon64x2 CPU.
> This host is used with VMware GSX server running 6 Linux client and one
> Windows client host. There's a SW-RAID1 using 2 SATA HDs.

Nvidia hardware SATA cannot directly DMA to > 4GB, so it 
has to go through the IOMMU. And in that kernel the Nforce
ethernet driver also didn't do >4GB access, although the ethernet HW 
is theoretically capable.

Maybe VMware pins unusually much IO memory in flight (e.g. by using
a lot of O_DIRECT). That could potentially cause the IOMMU to fill up.
The RAID-1 probably also makes it worse because it will double the IO
mapping requirements.

Or you have a leak in some driver, but if the problem goes away
after enlarging the IOMMU that's unlikely.

What would probably help is to get a new SATA controller that can 
access >4GB natively and at some point update to a newer kernel
with newer forcedeth driver. Or just run with the enlarged IOMMU.

-Andi
