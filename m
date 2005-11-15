Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbVKOJ3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbVKOJ3E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 04:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbVKOJ3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 04:29:04 -0500
Received: from mail.dvmed.net ([216.237.124.58]:8871 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751404AbVKOJ3C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 04:29:02 -0500
Message-ID: <4379AA5B.1060900@pobox.com>
Date: Tue, 15 Nov 2005 04:28:59 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libata error handling fixes (ATAPI)
References: <20051114195717.GA24373@havoc.gtf.org> <20051115074148.GA17459@htj.dyndns.org>
In-Reply-To: <20051115074148.GA17459@htj.dyndns.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> I've been trying to do about the same thing and here's my version
> which only fixes error/sense handling.  This patch makes ahci's
> eng_timeout act correctly w.r.t ATAPI sense requesting.  libata ATAPI
> request sensing mechanism was not broken.  What's broken was AHCI's
> eng_timeout handler.  And, yes, this problem disappears with request
> sensing via active qc turn-around in your patch.

Yes, that's intentional.  I fixed the problem in AHCI by copying code 
from libata-core's ata_qc_timeout(), similar to what you did.  Didn't 
like that solution at all, so I started over from scratch.


> As I've written several times, I'm not a big fan of sense requesting
> by turning around active qc.  For libata's EH to work any better,
> handing-over failed commands to EH is necessary with or without
> request sensing.  Hmm... It's true that the current implementation
> used for ATAPI request sensing needs improvements.  Remember those
> patches which implement generic failed command handover and perform
> request sensing from EH with proper timeout and synchronization?

We'll see how things shake out in the future.

One of the reasons I haven't responded to your ATA exceptions doc RFC is 
that I don't like to plan.  Linux isn't about roadmaps, it's about 
what's the next-best-step.  I think my current EH fixes are the next 
best step, as it cleans up the error handler a lot, and gets things 
working.  Next step after that?  No idea.  I just go on gut feeling I 
have based on direction.

The current feeling is that we should move away from complex 
dependencies on the SCSI EH layer, and do all our own error handling 
(perhaps in ata_wq).  This will allow use of libata as a block driver.


> Ah.. also, I'm working on sil24 ATAPI support.  However, it seems that
> I need to do a little bit more; unfortunately, I'm not sure which....
> INQUIRY succeeds and then my drive fails the first TUR with SK 6h
> (UNIT ATTENTION) which is probably due to previous phy reset.  Then,
> my drive fails to repsond to following REQUEST SENSE.
> 
> With my patched AHCI, REQUEST SENSE works and after SK 06h and several
> SK 02h's (NOT READY), it comes online and works okay.
> 
> As INQUIRY works okay, my hunch is that I'm not performing TUR
> properly (that is ATAPI command with no data) and the drive locks up
> after it.  I'll fool around with this more and report.

TUR fails for me, too.  It triggers the EH code, which is why I wound up 
needing to fix it :)

Have you dumped the D2H FIS returned by the drive, when the TUR fails? 
What does it look like?  What does the D2H FIS look like after REQUEST 
SENSE?

I bet there is some "clear error" actions we need to take on sil24, 
before it work there.

	Jeff


