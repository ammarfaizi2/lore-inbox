Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964852AbWEOPET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbWEOPET (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 11:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbWEOPES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 11:04:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55466 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751471AbWEOPER (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 11:04:17 -0400
Date: Mon, 15 May 2006 08:00:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ide_dma_speed() fixes
Message-Id: <20060515080053.296c4c55.akpm@osdl.org>
In-Reply-To: <446885BE.4090404@ru.mvista.com>
References: <4463F4C8.9080608@ru.mvista.com>
	<20060514050548.5399e3f4.akpm@osdl.org>
	<446885BE.4090404@ru.mvista.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
>
> Hello.
> 
> Andrew Morton wrote:
> 
> >>    ide_dma_speed() fails to actually honor the IDE drivers' mode support 
> >> masks) because of the bogus checks -- thus, selecting the DMA transfer mode 
> >> that the driver explicitly refuses to support is possible. Additionally, there 
> >> is no check for validity of the UltraDMA mode data in the drive ID, and the 
> >> function is misdocumented.
> 
> > drivers/ide/ide-lib.c: In function `ide_dma_speed':
> > drivers/ide/ide-lib.c:86: warning: `ultra_mask' might be used uninitialized in this function
> 
> > Looks like a real bug to me - it depends up on the values of `mode' and
> > id->field_value.
> 
> > Anyway, I'll drop it, please review and fix.  I assume that warning was
> > occurring for you as well - please spend more time over these things. 
> > Especially when working on IDE, where bugs are slow to show themselves and
> > have particularly bad consequences.
> 
>     That's what gcc thinks. The code is 100% correct -- it will never reach 
> the switch statement with mode > 0 (in which case ultra_mask isn't used) and 
> ultra_mask unitialized.

hm, OK.

> I may add an explicit initializer in the declaration if you like...

Opinions vary.  I think that's less bad than spitting a warning at all
developers for all time.

But we can redo things like below and save a little code in the process. 
Look OK?

--- devel/drivers/ide/ide-lib.c~ide_dma_speed-fixes-warning-fix	2006-05-15 07:56:28.000000000 -0700
+++ devel-akpm/drivers/ide/ide-lib.c	2006-05-15 08:00:12.000000000 -0700
@@ -90,9 +90,9 @@ u8 ide_dma_speed(ide_drive_t *drive, u8 
 		return 0;
 
 	/* Capable of UltraDMA modes? */
-	if (id->field_valid & 4)
-		ultra_mask = id->dma_ultra & hwif->ultra_mask;
-	else
+	ultra_mask = id->dma_ultra & hwif->ultra_mask;
+
+	if (!(id->field_valid & 4))
 		mode = 0;	/* fallback to MW/SW DMA if no UltraDMA */
 
 	switch (mode) {
_

