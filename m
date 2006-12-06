Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760357AbWLFJNp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760357AbWLFJNp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 04:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760353AbWLFJNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 04:13:45 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:53456 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760350AbWLFJNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 04:13:44 -0500
Message-ID: <457689C5.5030201@garzik.org>
Date: Wed, 06 Dec 2006 04:13:41 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@it.uu.se>
CC: htejun@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19 2/3] sata_promise: new EH conversion
References: <200612060853.kB68r0Gg024641@harpo.it.uu.se>
In-Reply-To: <200612060853.kB68r0Gg024641@harpo.it.uu.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> On Sun, 03 Dec 2006 22:00:42 +0900, Tejun Heo wrote:
>> Mikael Pettersson wrote:
>>> +}
>>> +
>>> +static void pdc_error_handler(struct ata_port *ap)
>>> +{
>>> +	struct ata_eh_context *ehc = &ap->eh_context;
>>> +	ata_reset_fn_t hardreset;
>>> +
>>> +	/* stop DMA, mask IRQ, don't clobber anything else */
>>> +	ata_eh_freeze_port(ap);
>> Don't freeze port unconditionally.  You'll end up hardresetting on every
>> error.  Just make sure DMA engine is stopped and the controller is in a
>> sane state.  If that fails, then, the port should be frozen.
> 
> I'm looking into this now, but so far it seems only a reset
> (what Promise calls software reset, I don't know if libata
> considers it a soft or hard reset) of the ATA channel will do.
> 
>>> +	hardreset = NULL;
>>> +	if (sata_scr_valid(ap)) {
>>> +		ehc->i.action |= ATA_EH_HARDRESET;
>> Why always force HARDRESET?
> 
> I based that on sata_sil24:
> 
> 	if (sil24_init_port(ap)) {
> 		ata_eh_freeze_port(ap);
> 		ehc->i.action |= ATA_EH_HARDRESET;
> 	}
> 
> I interpreted the ATA_EH_HARDRESET as being required due to
> the ata_eh_freeze_port(), but perhaps it's only there because
> sil24_init_port() returned failure?
> 
> A different issue, but of practical importance, is which
> libata branch I should base the EH conversion on: #upstream
> or #ALL? Andrew Morton's -mm kernels include the ALL patches,
> but they in turn include the promise-sata-pata patches, and
> there is a conflict between the PATA patch and the EH conversion.
> Currently my EH conversion is based on #upstream, and I've ported
> the PATA patch to apply on top of it.

It's a tiered system ;-)

* if at all possible, provide patches against the latest linux-2.6.git

* if there are dependencies in #upstream-fixes or #upstream (i.e. I 
already applied some of your patches), provide patches against 
#upstream-fixes or #upstream

#ALL is a branch that is blown away at will, and is really more of a 
testing and akpm sync point.  Don't worry about conflicts with 
promise-sata-pata, I take care of those when I merge the #ALL branch 
together.

	Jeff



