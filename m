Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760331AbWLFIxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760331AbWLFIxN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 03:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760333AbWLFIxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 03:53:13 -0500
Received: from aun.it.uu.se ([130.238.12.36]:63429 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760327AbWLFIxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 03:53:11 -0500
Date: Wed, 6 Dec 2006 09:53:00 +0100 (MET)
Message-Id: <200612060853.kB68r0Gg024641@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: htejun@gmail.com, mikpe@it.uu.se
Subject: Re: [PATCH 2.6.19 2/3] sata_promise: new EH conversion
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 03 Dec 2006 22:00:42 +0900, Tejun Heo wrote:
>Mikael Pettersson wrote:
>> +}
>> +
>> +static void pdc_error_handler(struct ata_port *ap)
>> +{
>> +	struct ata_eh_context *ehc = &ap->eh_context;
>> +	ata_reset_fn_t hardreset;
>> +
>> +	/* stop DMA, mask IRQ, don't clobber anything else */
>> +	ata_eh_freeze_port(ap);
>
>Don't freeze port unconditionally.  You'll end up hardresetting on every
>error.  Just make sure DMA engine is stopped and the controller is in a
>sane state.  If that fails, then, the port should be frozen.

I'm looking into this now, but so far it seems only a reset
(what Promise calls software reset, I don't know if libata
considers it a soft or hard reset) of the ATA channel will do.

>> +	hardreset = NULL;
>> +	if (sata_scr_valid(ap)) {
>> +		ehc->i.action |= ATA_EH_HARDRESET;
>
>Why always force HARDRESET?

I based that on sata_sil24:

	if (sil24_init_port(ap)) {
		ata_eh_freeze_port(ap);
		ehc->i.action |= ATA_EH_HARDRESET;
	}

I interpreted the ATA_EH_HARDRESET as being required due to
the ata_eh_freeze_port(), but perhaps it's only there because
sil24_init_port() returned failure?

A different issue, but of practical importance, is which
libata branch I should base the EH conversion on: #upstream
or #ALL? Andrew Morton's -mm kernels include the ALL patches,
but they in turn include the promise-sata-pata patches, and
there is a conflict between the PATA patch and the EH conversion.
Currently my EH conversion is based on #upstream, and I've ported
the PATA patch to apply on top of it.

/Mikael
