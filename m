Return-Path: <linux-kernel-owner+w=401wt.eu-S1750952AbXADSwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbXADSwm (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 13:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbXADSwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 13:52:42 -0500
Received: from wr-out-0506.google.com ([64.233.184.234]:10421 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947AbXADSwl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 13:52:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=V0Z8NnxJzQF+bocy5WUYZ7dLoUqm7q0UGnNHlwKji3+kbbP8R5iPy1ZMNOqNUoxkwBpGSP+samT2bX1AUO8+I5uRhB/+N82E5KKxzF29VuztTzDQxKREtpdT5neIxL+hff63c5OZnq9W62Kti1ZAKx1wS0pVvzcL9CB4aCyJcVs=
Message-ID: <e9c3a7c20701041052u487929c0o2e7c79a5a8355327@mail.gmail.com>
Date: Thu, 4 Jan 2007 11:52:39 -0700
From: "Dan Williams" <dan.j.williams@gmail.com>
To: "Jeff Garzik" <jeff@garzik.org>
Subject: Re: Initial Promise SX4 hw docs opened
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <459C61BB.70205@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <459C61BB.70205@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/07, Jeff Garzik <jeff@garzik.org> wrote:
> The first open hardware docs for the Promise SX4 (sata_sx4) series are
> now available:
> http://gkernel.sourceforge.net/specs/promise/pdc20621-pguide-dimm-1.6.pdf.bz2
> http://gkernel.sourceforge.net/specs/promise/pdc20621-pguide-pll-ata-timing-1.2.pdf.bz2
>
> These are only small, ancillary guides; the main hardware doc should be
> opened soon.
>
> However, I would like to take this opportunity to point hackers looking
> for a project at this hardware.  The Promise SX4 is pretty neat, and it
> needs more attention than I can give, to reach its full potential.
>
> Here's a braindump:
>
> * It's an older chipset/board, probably not actively sold anymore
>
> * ATA programming interface very close to sata_promise (PDC2037x)
>
> * Contains on-board DIMM, to be used for any purpose the driver desires
>
> * Contains on-board RAID5 XOR, also fully programmable
>
> A key problem is that, under Linux, sata_sx4 cannot fully exploit the
> RAID-centric power of this hardware by driving the hardware in "dumb ATA
> mode" as it does.
>
> A better driver would notice when a RAID1 or RAID5 array contains
> multiple components attached to the SX4, and send only a single copy of
> the data to the card (saving PCI bus bandwidth tremendously).
> Similarly, a better driver would take advantage of the RAID5 XOR offload
> capabilities, to offload the entire RAID5 read or write transaction to
> the card.
>
> All this is difficult within either the MD or DM RAID frameworks,
> because optimizing each RAID transaction requires intimate knowledge of
> the hardware.  We have the knowledge...  but I don't have good ideas --
> aside from an SX4-specific RAID 0/1/5/6 driver -- on how to exploit this
> knowledge.
>
Can the XOR engines on the card access host memory or do they only
operate on the card's local memory?  And are there DMA (copy) engines?

> Traditionally the vendor has distributed a SCSI driver that implements
> the necessary RAID stack pieces entirely in the hardware driver itself.
>   That sort of approach definitely works, but is traditionally rejected
> by upstream maintainers because it essentially requires a third (if h/w
> specific) RAID stack.
>
[ brainstorming ]
For the RAID5 case: With the hardware acceleration patches the part of
MD that actually operates on the stripe cache is factored out of
handle_stripe5.  So MD can be used to handle all of the cache state
information and then use a SX4 specific operations routine to handle
the data transfers.  However this assumes that all the members of the
array are behind the SX4 (which is the same assumption the vendor
driver makes so maybe its not so bad).

The part I am lost at it is how do you tell libata and the lldd that
data for a transaction is coming from or headed to device local memory
and not host memory?  It seems there would need to be changes to the
dma api to handle this distinction?

>         Jeff
>

Dan
