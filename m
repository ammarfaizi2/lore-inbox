Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbWJKKad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWJKKad (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 06:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWJKKad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 06:30:33 -0400
Received: from brick.kernel.dk ([62.242.22.158]:5131 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1751170AbWJKKac (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 06:30:32 -0400
Date: Wed, 11 Oct 2006 12:30:38 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Robert Hancock <hancockr@shaw.ca>
Cc: Allen Martin <AMartin@nvidia.com>, Jeff Garzik <jeff@garzik.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
       prakash@punnoor.de
Subject: Re: [RFC PATCH] nForce4 ADMA with NCQ: It's aliiiive..
Message-ID: <20061011103038.GK6515@kernel.dk>
References: <DBFABB80F7FD3143A911F9E6CFD477B018E8171B@hqemmail02.nvidia.com> <452C7C1D.3040704@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452C7C1D.3040704@shaw.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10 2006, Robert Hancock wrote:
> Allen Martin wrote:
> >>But I really don't think that is necessary.  I will take a 
> >>look at docs and see how things match up, when I am much more 
> >>awake.  Most likely you need to be using another set of 
> >>registers, and be all MMIO, all the time.
> >
> >You shouldn't be touching BM registers when ADMA is enabled, it can
> >cause bad things to happen.
> >
> >You should be using BM registers when doing ATAPI protocol though, as it
> >doesn't work through ADMA.  So I wouldn't say you should be using MMIO
> >all the time.
> >
> >-Allen
> 
> OK, I've updated the code to take this into account, an updated patch is 
> attached. However, this does raise an issue. If we have to fall back to 
> legacy mode to do ATAPI DMA, this means that we can't do 64-bit DMA for 
> such transfers. Since by the time the driver gets a request the SGs have 
> already been created based on the set DMA mask, the only way I can see 
> to handle this is to either allow ATAPI DMA or 64-bit DMA, not both. 
> I've chosen to default to 64-bit DMA in this version, but there is a 
> module parameter which allows overriding this if you care more about 
> using ATAPI devices than efficiency with over 4GB of RAM. I'm open to 
> suggestions on a better way to handle this..

Should be easily fixable - in general, set 64-bit dma mask. Then when
you detect an atapi device, lower the dma mask settings to 32-bit dma
for that device only. So the pci device in question gets a full 64-bit
dma mask, the attached scsi devices can have lower masks if necessary.
I'd suggest doing this off slave config.

-- 
Jens Axboe

