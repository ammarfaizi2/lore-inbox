Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932343AbVKOLDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbVKOLDH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 06:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbVKOLDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 06:03:06 -0500
Received: from mail.dvmed.net ([216.237.124.58]:45479 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751423AbVKOLDF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 06:03:05 -0500
Message-ID: <4379C062.3010302@pobox.com>
Date: Tue, 15 Nov 2005 06:02:58 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] libata error handling fixes (ATAPI)
References: <20051114195717.GA24373@havoc.gtf.org> <20051115074148.GA17459@htj.dyndns.org> <4379AA5B.1060900@pobox.com> <4379B28E.9070708@gmail.com>
In-Reply-To: <4379B28E.9070708@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> My RFC was written *after* the patches to ease the reviewing/integration 
> process.  Well, that was the intention.  I understand your point but I 
> think that EH needs some big changes, so it might be beneficial to 

Agreed, libata EH still needs a lot of work.  ATA device error handling 
could better, ATA bus and PCI bus errors need to be handled a lot 
better, etc.


> establish some consensus such that other developers can do stuff that 
> can be accepted.
> 
>>
>> The current feeling is that we should move away from complex 
>> dependencies on the SCSI EH layer, and do all our own error handling 
>> (perhaps in ata_wq).  This will allow use of libata as a block driver.
>>
> 
> For departure of libata from SCSI, I was thinking more of another more 
> generic block device framework in which libata can live in.  And I 
> thought that it was reasonable to assume that the framework would supply 
> a EH mechanism which supports queue stalling/draining and separate 
> thread.  So, my EH patches tried to make the same environment for libata 

A big reason why libata uses the SCSI layer is infrastructure like this. 
  It would certainly be nice to see timeouts and EH at the block layer. 
  The block layer itself already supports queue stalling/draining.


> so that it doesn't have to be changed drastically later.  All those 
> glueing codes were separated in one or two functions.
> 
> The point I'm trying to make here is not that my EH design should be 
> accepted or anything but that without established consensus it's very 
> difficult for contributing developers like me to develop substantial 
> part for libata.
> 
> One more thing that bothers me is that even with splitted patches and 
> detailed document, I couldn't get a discussion started on the mailing 
> list.  No discussion, no consensus.  I think we need to improve things 
> on this front.

Honestly there isn't a ton of discussion beforehand about anything in 
libata :)  It's mainly just like Linux itself...  no roadmap, its more 
just about what patches are accepted.  The consensus is the code.  I 
have a general idea of where I want libata to go, in my mind, but that 
picture is very rough and fuzzy :)  I let evolution sort out the details.

Speaking specifically, changes to libata's error handling should have 
very practical, observable effects.  Error handling code paths are 
travelled so infrequently by users, that changes for the general purpose 
of "improve something ugly" are not interesting.  Changes which address 
problems people are seeing in the field are top priority:

* kicking the device with SRST, if it continues to signal BSY.  If that 
fails, do a hard reset with SATA COMRESET or <some hardware-specific 
method>.  Note we really really really want to prefer SRST to other 
methods of reset, as SRST is much nicer to the device, and gives the 
device the opportunity to flush its writeback cache.

Note that some hardware may prefer that you use a hardware-specific 
method of issuing SRST, so that it can reset internal state machines 
along with actually issuing the SRST to the device.  This probably means 
a new protocol, ATA_PROT_SRST (which aligns nicely with SCSI SAT spec).

* retrying rather than cancelling commands that fail due to pci/dma/crc 
error.  some hardware (PCI IDE BMDMA) indicates DMA/PCI errors via 
timeout.  Other hardware is nicer, and indicates such via interrupt.

This may involve exporting scsi_eh_finish_cmd() and 
scsi_eh_flush_done_q(), and un-exporting scsi_finish_command().  Hence 
my reluctance to expand the use of scsi_finish_command(), which is 
really inadequate for our purposes.

This is also necessary for NCQ error handling.

* better use of SError.  some vendor drivers read+write SError on every 
disk transaction, but I think that's overkill.  Reading SError to check 
for errors, against a stored mask, might not be a bad idea.

* longer term:  add logic to "downshift" UDMA mode and/or SATA speed, if 
CRC/DMA errors persist.

I'm much less inclined to take patches which don't make progress towards 
any of these IMO critical areas of EH importance.

	Jeff


