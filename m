Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264450AbUAEONP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 09:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264454AbUAEONP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 09:13:15 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:52120 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264450AbUAEONK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 09:13:10 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Davin McCall <davmac@ozonline.com.au>
Subject: Re: [PATCH] fix issues with loading PCI ide drivers as modules (linux 2.6.0)
Date: Mon, 5 Jan 2004 15:16:03 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
References: <20040103152802.6e27f5c5.davmac@ozonline.com.au> <200401041547.52615.bzolnier@elka.pw.edu.pl> <20040105130939.3cca1648.davmac@ozonline.com.au>
In-Reply-To: <20040105130939.3cca1648.davmac@ozonline.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401051516.03364.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 of January 2004 03:09, Davin McCall wrote:
> Sure, the current code doesn't cause a crash - but it's very, very ugly. It
> generates some confusing error messages, and it makes it look like the
> module has taken control of the IDE interfaces but really the drives
> haven't been re-probed etc.
>
> Is this not worth fixing?

You are right.  Thanks for very good explanation.

> > Ehh, more hwif->chipset crap.
>
> Alright, this newer patch below mostly avoids the "hwif->chipset crap" (it
> doesn't introduce any new chipset types). But it has to export the
> "initializing" variable from ide.c (I changed its name to
> "ide_initializing").

You don't need to export "initializing" variable from ide.c,
just use "pre_init" variable from setup-pci.c :-).

> Plus, everything works as before - including "idex=..." parameters.

Except when using them for IDE PCI modules with non default ports:
- hwif->chipset is set to ide_generic during boot
- main IDE driver initialization
- module load fails (because hwif->chipset == ide_generic && !initializing)

You can fix it by replacing all current occurrences of ide_generic by some
new type (ide_forced).  It will also clear confusion about ide_generic name.

> @@ -1343,6 +1343,7 @@
>  			int unit;
>  			if (!hwif->present)
>  				continue;
> +			if (hwif->chipset == ide_unknown) hwif->chipset = ide_generic;

very minor nitpick:

if (hwif->chipset == ide_unknown)
	hwif->chipset = ide_generic;

Please correct patch and I will merge it.

cheers,
--bart

