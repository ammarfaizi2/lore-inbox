Return-Path: <linux-kernel-owner+willy=40w.ods.org-S272435AbVBEU4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272435AbVBEU4S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 15:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268456AbVBEUzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 15:55:55 -0500
Received: from smtp-106-saturday.noc.nerim.net ([62.4.17.106]:10253 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S268423AbVBEUzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 15:55:36 -0500
Date: Sat, 5 Feb 2005 21:55:35 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Prarit Bhargava <prarit@sgi.com>
Subject: Re: 2.6.11-rc3-bk1: ide1: failed to initialize IDE interface
Message-Id: <20050205215535.43ff8cb9.khali@linux-fr.org>
In-Reply-To: <58cb370e050204154155cafb20@mail.gmail.com>
References: <20050204234422.4a9c6fd0.khali@linux-fr.org>
	<58cb370e050204154155cafb20@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartlomiej & all,

> > I would tend to think that this is *not* an error, so we shouldn't
> > display an error message in this case. Maybe init_hwif() should
> > return 1 instead of 0 in this case.
> 
> Yep this is the simplest fix - interface without a drives should
> return success value.  Care to make a patch?

That would be as simple as this, I guess:

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.11-rc3-bk2/drivers/ide/ide-probe.c.orig	2005-02-05 19:41:01.000000000 +0100
+++ linux-2.6.11-rc3-bk2/drivers/ide/ide-probe.c	2005-02-05 19:42:46.000000000 +0100
@@ -1248,8 +1248,9 @@
 {
 	int old_irq, unit;
 
+	/* Return success if no device is connected */
 	if (!hwif->present)
-		return 0;
+		return 1;
 
 	if (!hwif->irq) {
 		if (!(hwif->irq = ide_default_irq(hwif->io_ports[IDE_DATA_OFFSET])))


There's another thing I noticed about IDE and thought I might report as
well. It seems that, when an IDE interface has no device connected, it
ends up being probed twice. From dmesg:

ICH3M: chipset revision 1
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: HITACHI_DK23CA-15, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...

Notice how ide1, which happens to have no device attached, is listed
twice. I can reproduce this on my second system as well (i386 too, but
otherwise completely different). I guess it doesn't cause any trouble,
but looks suboptimal.

While we're at it, I also wonder why ide2-ide5 are probed, when neither
of my systems has them.

Thanks,
-- 
Jean Delvare
