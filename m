Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751508AbWJMDSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbWJMDSm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 23:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751579AbWJMDSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 23:18:42 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:61891 "EHLO
	pd5mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751508AbWJMDSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 23:18:41 -0400
Date: Thu, 12 Oct 2006 21:17:15 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [RFC PATCH] nForce4 ADMA with NCQ: It's aliiiive..
In-reply-to: <20061011103038.GK6515@kernel.dk>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Allen Martin <AMartin@nvidia.com>, Jeff Garzik <jeff@garzik.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
       prakash@punnoor.de
Message-id: <452F053B.2000906@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <DBFABB80F7FD3143A911F9E6CFD477B018E8171B@hqemmail02.nvidia.com>
 <452C7C1D.3040704@shaw.ca> <20061011103038.GK6515@kernel.dk>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Tue, Oct 10 2006, Robert Hancock wrote:
>> Allen Martin wrote:
>>>> But I really don't think that is necessary.  I will take a 
>>>> look at docs and see how things match up, when I am much more 
>>>> awake.  Most likely you need to be using another set of 
>>>> registers, and be all MMIO, all the time.
>>> You shouldn't be touching BM registers when ADMA is enabled, it can
>>> cause bad things to happen.
>>>
>>> You should be using BM registers when doing ATAPI protocol though, as it
>>> doesn't work through ADMA.  So I wouldn't say you should be using MMIO
>>> all the time.
>>>
>>> -Allen
>> OK, I've updated the code to take this into account, an updated patch is 
>> attached. However, this does raise an issue. If we have to fall back to 
>> legacy mode to do ATAPI DMA, this means that we can't do 64-bit DMA for 
>> such transfers. Since by the time the driver gets a request the SGs have 
>> already been created based on the set DMA mask, the only way I can see 
>> to handle this is to either allow ATAPI DMA or 64-bit DMA, not both. 
>> I've chosen to default to 64-bit DMA in this version, but there is a 
>> module parameter which allows overriding this if you care more about 
>> using ATAPI devices than efficiency with over 4GB of RAM. I'm open to 
>> suggestions on a better way to handle this..
> 
> Should be easily fixable - in general, set 64-bit dma mask. Then when
> you detect an atapi device, lower the dma mask settings to 32-bit dma
> for that device only. So the pci device in question gets a full 64-bit
> dma mask, the attached scsi devices can have lower masks if necessary.
> I'd suggest doing this off slave config.
> 

I think that should be feasible.. However, one problem is that 
slave_config only has access to the struct scsi_device and the 
ata_scsi_find_dev function to turn that into a struct ata_device isn't 
exported, which it would need to be in order to do anything useful 
inside the driver for slave_config. We could export it, or I suppose the 
other place we could do this handling would be postreset, as at that 
point we should know what kind of device is attached.. any comments?

Also, how is the driver supposed to be setting the DMA mask for the SCSI 
device? I suppose blk_queue_bounce_limit would work, but it seems a bit 
odd to use block layer calls at the libata driver level.

I also noticed that I'm still using the default 64KB libata dma_boundary 
value, this should be 4GB for ADMA mode (but fixed up back to the 
default if an ATAPI device is connected, same as with the DMA mask).

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/
