Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267534AbTA3QHm>; Thu, 30 Jan 2003 11:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267535AbTA3QHm>; Thu, 30 Jan 2003 11:07:42 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:5075 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S267534AbTA3QHl>; Thu, 30 Jan 2003 11:07:41 -0500
Date: Thu, 30 Jan 2003 08:25:07 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: pci_set_mwi() ... why isn't it used more?
To: Anton Blanchard <anton@samba.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Message-id: <3E3951E3.7060806@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <3E2C42DF.1010006@pacbell.net> <20030120190055.GA4940@gtf.org>
 <3E2C4FFA.1050603@pacbell.net> <20030130135215.GF6028@krispykreme>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard wrote:
>  
> 
>>I suppose the potential for broken PCI devices is exactly why MWI
>>isn't automatically enabled when DMA mastering is enabled, though
>>I don't understand why the cacheline size doesn't get fixed then
>>(unless it's that same issue).  Devices can use the cacheline size
>>to get better Memory Read Line/Read Multiple" throughput; setting
>>it shouldn't be tied exclusively to enabling MWI.
> 
> 
> There are a number of cases where we cant enable MWI either because
> the PCI card doesnt support the CPU cacheline size or we have to set the
> PCI card cacheline size to something smaller due to various bugs.

At least the former case seems like it should be easily detectible.
The cacheline setting "must" be supported (sez the PCI spec) if MWI
can be enabled ... and may be supported in other cases too.


> eg I understand earlier versions of the e100 dont support a 128 byte
> cacheline (and the top bits are read only so setting it up for 128 bytes
> will result in it it being set to 0). Not good for read multiple/line
> and even worse if we decide to enable MWI :)

At least on 2.5.59, the pci_generic_prep_mwi() code doesn't check
for that type of error:  it just writes the cacheline size, and
doesn't verify that setting it worked as expected.  Checking for
that kind of problem would make it safer to call pci_set_mwi() in
such cases ... e.g. using it on a P4 with 128 byte L1 cachelines
would fail cleanly, while on an Athlon (64 byte L1) it might work
(depending in which top bits are unusable).

- Dave


