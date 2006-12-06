Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937016AbWLFSMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937016AbWLFSMS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 13:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937017AbWLFSMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 13:12:18 -0500
Received: from aun.it.uu.se ([130.238.12.36]:53003 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937016AbWLFSMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 13:12:17 -0500
Date: Wed, 6 Dec 2006 19:12:00 +0100 (MET)
Message-Id: <200612061812.kB6IC0Ve004856@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: andersen@codepoet.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make sata_promise PATA ports work
Cc: alan@lxorguk.ukuu.org.uk, jgarzik@pobox.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2006 12:47:37 -0700, Erik Andersen wrote:
>This patch vs 2.6.19, based on the not-actually-working-for-me
>code lurking in libata-dev.git#promise-sata-pata, makes the PATA
>ports on my promise sata card actually work.  Since the plan as
>checked into git, is to drive the PATA ports as if they were
>SATA, we have to teach sata_scr_read() to lie for the PATA ports
>which don't to that, lest the various places that call
>ata_port_offline() and ata_port_online() should fail and leave
>the ports offline and inaccessible.
>
>This patch gets both SATA and PATA working for me with the
>sata_promise driver on a PDC20375.  Performace seems to be about
>what I would expect, so this (or something very much like it)
>should be applied upstream.

This description doesn't match my experience.

The patch in #promise-sata-pata should work for 2037x chips.
It doesn't work on 2057x chips because it doesn't remove
ATA_FLAG_SATA from board_2057x. That omission causes libata
to consider all ports on it as SATA, including the PATA port,
and that's why sata_scr_read() etc get invoked.

Applying the patch below on top of #promise-sata-pata fixes
this, and is all I had to do to get working PATA on my 20575.

/Mikael

--- linux-2.6.19/drivers/ata/sata_promise.c.~1~	2006-12-05 20:42:18.000000000 +0100
+++ linux-2.6.19/drivers/ata/sata_promise.c	2006-12-05 21:01:26.000000000 +0100
@@ -213,7 +213,7 @@ static const struct ata_port_info pdc_po
 	/* board_2057x */
 	{
 		.sht		= &pdc_ata_sht,
-		.flags		= PDC_COMMON_FLAGS | ATA_FLAG_SATA,
+		.flags		= PDC_COMMON_FLAGS /* | ATA_FLAG_SATA*/,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
