Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbVKOKEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbVKOKEK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 05:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbVKOKEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 05:04:09 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:64957 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932332AbVKOKEI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 05:04:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=cAK1iDOHGpqwxz8SXuLNNX/aY1o65PFWC0FDQ9sc06dXYZU5tVuku0np7cvq/+WQbp4iuCjIak0GYzZIaCSJEDwjI2V/Q+zmytt1a4Kth32TgQkgVlw7b9j6kI9wYVXlrlAzPitKgoIzu1nyhQbmFdeDK6+h95B+yJ29f0ZIzMM=
Message-ID: <4379B28E.9070708@gmail.com>
Date: Tue, 15 Nov 2005 19:03:58 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libata error handling fixes (ATAPI)
References: <20051114195717.GA24373@havoc.gtf.org> <20051115074148.GA17459@htj.dyndns.org> <4379AA5B.1060900@pobox.com>
In-Reply-To: <4379AA5B.1060900@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>> I've been trying to do about the same thing and here's my version
>> which only fixes error/sense handling.  This patch makes ahci's
>> eng_timeout act correctly w.r.t ATAPI sense requesting.  libata ATAPI
>> request sensing mechanism was not broken.  What's broken was AHCI's
>> eng_timeout handler.  And, yes, this problem disappears with request
>> sensing via active qc turn-around in your patch.
> 
> 
> Yes, that's intentional.  I fixed the problem in AHCI by copying code 
> from libata-core's ata_qc_timeout(), similar to what you did.  Didn't 
> like that solution at all, so I started over from scratch.
> 
> 
>> As I've written several times, I'm not a big fan of sense requesting
>> by turning around active qc.  For libata's EH to work any better,
>> handing-over failed commands to EH is necessary with or without
>> request sensing.  Hmm... It's true that the current implementation
>> used for ATAPI request sensing needs improvements.  Remember those
>> patches which implement generic failed command handover and perform
>> request sensing from EH with proper timeout and synchronization?
> 
> 
> We'll see how things shake out in the future.
> 
> One of the reasons I haven't responded to your ATA exceptions doc RFC is 
> that I don't like to plan.  Linux isn't about roadmaps, it's about 
> what's the next-best-step.  I think my current EH fixes are the next 
> best step, as it cleans up the error handler a lot, and gets things 
> working.  Next step after that?  No idea.  I just go on gut feeling I 
> have based on direction.

My RFC was written *after* the patches to ease the reviewing/integration 
process.  Well, that was the intention.  I understand your point but I 
think that EH needs some big changes, so it might be beneficial to 
establish some consensus such that other developers can do stuff that 
can be accepted.

> 
> The current feeling is that we should move away from complex 
> dependencies on the SCSI EH layer, and do all our own error handling 
> (perhaps in ata_wq).  This will allow use of libata as a block driver.
> 

For departure of libata from SCSI, I was thinking more of another more 
generic block device framework in which libata can live in.  And I 
thought that it was reasonable to assume that the framework would supply 
a EH mechanism which supports queue stalling/draining and separate 
thread.  So, my EH patches tried to make the same environment for libata 
so that it doesn't have to be changed drastically later.  All those 
glueing codes were separated in one or two functions.

The point I'm trying to make here is not that my EH design should be 
accepted or anything but that without established consensus it's very 
difficult for contributing developers like me to develop substantial 
part for libata.

One more thing that bothers me is that even with splitted patches and 
detailed document, I couldn't get a discussion started on the mailing 
list.  No discussion, no consensus.  I think we need to improve things 
on this front.

> 
>> Ah.. also, I'm working on sil24 ATAPI support.  However, it seems that
>> I need to do a little bit more; unfortunately, I'm not sure which....
>> INQUIRY succeeds and then my drive fails the first TUR with SK 6h
>> (UNIT ATTENTION) which is probably due to previous phy reset.  Then,
>> my drive fails to repsond to following REQUEST SENSE.
>>
>> With my patched AHCI, REQUEST SENSE works and after SK 06h and several
>> SK 02h's (NOT READY), it comes online and works okay.
>>
>> As INQUIRY works okay, my hunch is that I'm not performing TUR
>> properly (that is ATAPI command with no data) and the drive locks up
>> after it.  I'll fool around with this more and report.
> 
> 
> TUR fails for me, too.  It triggers the EH code, which is why I wound up 
> needing to fix it :)
> 
> Have you dumped the D2H FIS returned by the drive, when the TUR fails? 
> What does it look like?  What does the D2H FIS look like after REQUEST 
> SENSE?
> 
> I bet there is some "clear error" actions we need to take on sil24, 
> before it work there.

Working on it, will report soon.

Thanks. :-)

-- 
tejun
