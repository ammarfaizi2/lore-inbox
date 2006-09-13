Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030456AbWIMEFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030456AbWIMEFm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 00:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751540AbWIMEFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 00:05:41 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:8072 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751536AbWIMEFk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 00:05:40 -0400
Message-ID: <45078390.7010901@garzik.org>
Date: Wed, 13 Sep 2006 00:05:36 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Dan Williams <dan.j.williams@gmail.com>
CC: NeilBrown <neilb@suse.de>, linux-raid@vger.kernel.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, christopher.leech@intel.com
Subject: Re: [PATCH 00/19] Hardware Accelerated MD RAID5: Introduction
References: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com>	 <4505F358.3040204@garzik.org>	 <e9c3a7c20609111653v29cd4609hd0584ae300b735b7@mail.gmail.com>	 <45061E63.6010901@garzik.org> <e9c3a7c20609112247u30685133kc84f094ce7854776@mail.gmail.com>
In-Reply-To: <e9c3a7c20609112247u30685133kc84f094ce7854776@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams wrote:
> On 9/11/06, Jeff Garzik <jeff@garzik.org> wrote:
>> Dan Williams wrote:
>> > This is a frequently asked question, Alan Cox had the same one at OLS.
>> > The answer is "probably."  The only complication I currently see is
>> > where/how the stripe cache is maintained.  With the IOPs its easy
>> > because the DMA engines operate directly on kernel memory.  With the
>> > Promise card I believe they have memory on the card and it's not clear
>> > to me if the XOR engines on the card can deal with host memory.  Also,
>> > MD would need to be modified to handle a stripe cache located on a
>> > device, or somehow synchronize its local cache with card in a manner
>> > that is still able to beat software only MD.
>>
>> sata_sx4 operates through [standard PC] memory on the card, and you use
>> a DMA engine to copy memory to/from the card.
>>
>> [select chipsets supported by] sata_promise operates directly on host
>> memory.
>>
>> So, while sata_sx4 is farther away from your direct-host-memory model,
>> it also has much more potential for RAID acceleration:  ideally, RAID1
>> just copies data to the card once, then copies the data to multiple
>> drives from there.  Similarly with RAID5, you can eliminate copies and
>> offload XOR, presuming the drives are all connected to the same card.
> In the sata_promise case its straight forward, all that is needed is
> dmaengine drivers for the xor and memcpy engines.  This would be
> similar to the current I/OAT model where dma resources are provided by
> a PCI function.  The sata_sx4 case would need a different flavor of
> the dma_do_raid5_block_ops routine, one that understands where the
> cache is located.  MD would also need the capability to bypass the
> block layer since the data will have already been transferred to the
> card by a stripe cache operation
> 
> The RAID1 case give me pause because it seems any work along these
> lines requires that the implementation work for both MD and DM, which
> then eventually leads to being tasked with merging the two.

RAID5 has similar properties.  If all devices in a RAID5 array are 
attached to a single SX4 card, then a high level write to the RAID5 
array is passed directly to the card, which then performs XOR, striping, 
etc.

	Jeff



