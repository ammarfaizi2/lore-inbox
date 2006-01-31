Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbWAaNmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWAaNmx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 08:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbWAaNms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 08:42:48 -0500
Received: from emulex.emulex.com ([138.239.112.1]:44164 "EHLO
	emulex.emulex.com") by vger.kernel.org with ESMTP id S1750837AbWAaNmh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 08:42:37 -0500
Message-ID: <43DF691E.1020008@emulex.com>
Date: Tue, 31 Jan 2006 08:41:50 -0500
From: James Smart <James.Smart@Emulex.Com>
Reply-To: James.Smart@Emulex.Com
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Doug Maxey <dwm@maxeymade.com>
CC: Olof Johansson <olof@lixom.net>, Mark Haverkamp <markh@osdl.org>,
       "linuxppc64-dev@ozlabs.org" <linuxppc64-dev@ozlabs.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
Subject: Re: iommu_alloc failure and panic
References: <200601310118.k0V1Il7Z018408@falcon30.maxeymade.com>
In-Reply-To: <200601310118.k0V1Il7Z018408@falcon30.maxeymade.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Jan 2006 13:41:52.0167 (UTC) FILETIME=[17A54B70:01C6266C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> 2) The emulex driver has been prone to problems in the past where it's
>> been very aggressive at starting DMA operations, and I think it can
>> be avoided with tuning. What I don't know is if it's because of this,
>> or simply because of the large number of targets you have. Cc:ing James
>> Smart.

I don't have data points for the 2.6 kernel, but I can comment on what I
have seen on the 2.4 kernel.

The issue that I saw on the 2.4 kernel was that the pci dma alloc routine
was inappropriately allocating from the dma s/g maps. On systems with less
than 4Gig of memory, or on those with no iommmu (emt64), the checks around
adapter-supported dma masks were off (I'm going to be loose in terms to not
describe it in detail). The result was, although the adapter could support
a fully 64bit address and/or although the physical dma address would be under
32-bits, the logic forced allocation from the mapped dma pool. On some
systems, this pool was originally only 16MB. Around 2.4.30, the swiotlb was
introduced, which reduced issue, but unfortunately, still never solved the
allocation logic. It fails less as the swiotlb simply had more space.
As far as I know, this problem doesn't exist in the 2.6 kernel. I'd have to
go look at the dma map functions to make sure.

Why was the lpfc driver prone to the dma map exhaustion failures ? Due to the
default # of commands per lun and max sg segments reported by the driver to
the scsi midlayer, the scsi mid-layer's preallocation of dma maps for commands
for each lun, and the fact that our FC configs were usually large, had lots
of luns, and replicated the resources for each path to the same storage.

Ultimately, what I think is the real issue here is the way the scsi mid-layer
is preallocating dma maps for the luns. 16000 luns is a huge number.
Multiply this by a max sg segment count of 64 by the driver, and a number
between 3 and 30 commands per lun, and you can see the numbers. Scsi does do
some interesting allocation algorithms once it hits an allocation failure.
One side effect of this is that it is fairly efficient at allocating the
bulk of the dma pool.

-- james s

