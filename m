Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbTIKWot (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 18:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbTIKWos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 18:44:48 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:33699 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261573AbTIKWor
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 18:44:47 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Andries.Brouwer@cwi.nl
Subject: Re: [PATCH] Re: [PATCH][IDE] update qd65xx driver
Date: Fri, 12 Sep 2003 00:46:58 +0200
User-Agent: KMail/1.5
References: <UTC200309112151.h8BLpcb14069.aeb@smtp.cwi.nl>
In-Reply-To: <UTC200309112151.h8BLpcb14069.aeb@smtp.cwi.nl>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309120046.58467.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 of September 2003 23:51, Andries.Brouwer@cwi.nl wrote:
> That reminds me, did I ever send you this?
>
> Andries

No, only similar patch for hpt366.c.

I think the (almost) correct scheme is following (some drivers get it wrong):

config_chipset_pio() style functions are used for driver auto-tuning
and  "255, pio" is used to find best PIO mode supported by device.
"pio" argument should be set to highest mode allowed by controller.

tune_proc()/tune_drive() style functions are used for direct mode setting
and "pio, max_pio" is used to set desired mode.
"pio" is desired mode, "max_pio" is max mode supported by controller.

It's almost correct because we should also check if desired PIO mode
is supported by device, currently we let user shoot herself/himself.

IDE driver itself calls ->tuneproc() with argument == 255, so always
highest supported PIO mode is chosen.  User-space can call ->tuneproc()
with smaller argument.  With you patch smaller than highest possible
PIO mode can't be chosen.

Your patch for hpt366.c has also this side effect that you can now only
set highest possible PIO mode.  You should revert this change
and fix hpt3xx_tune_drive() call inside hpt366_config_drive_xfer_rate()
to pass 255 instead of 5.

--bartlomiej

> diff -u --recursive --new-file -X /linux/dontdiff
> a/drivers/ide/legacy/qd65xx.c b/drivers/ide/legacy/qd65xx.c ---
> a/drivers/ide/legacy/qd65xx.c	Mon Sep  8 23:44:59 2003
> +++ b/drivers/ide/legacy/qd65xx.c	Thu Sep 11 23:20:26 2003
> @@ -261,7 +261,7 @@
>  	int recovery_time = 415; /* worst case values from the dos driver */
>
>  	if (drive->id && !qd_find_disk_type(drive, &active_time, &recovery_time))
> { -		pio = ide_get_best_pio_mode(drive, pio, 255, &d);
> +		pio = ide_get_best_pio_mode(drive, 255, pio, &d);
>  		pio = IDE_MIN(pio,4);
>
>  		switch (pio) {

