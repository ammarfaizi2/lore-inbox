Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312380AbSDEI1X>; Fri, 5 Apr 2002 03:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312384AbSDEI1O>; Fri, 5 Apr 2002 03:27:14 -0500
Received: from mail.sonytel.be ([193.74.243.200]:42369 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S312380AbSDEI04>;
	Fri, 5 Apr 2002 03:26:56 -0500
Date: Fri, 5 Apr 2002 10:26:29 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE/SUPPORT_VLB_SYNC in 2.5.x
In-Reply-To: <3CAC68B5.2040505@evision-ventures.com>
Message-ID: <Pine.GSO.4.21.0204051023070.10408-100000@lisianthus.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Apr 2002, Martin Dalecki wrote:
> Geert Uytterhoeven wrote:
> > SUPPORT_VLB_SYNC is now unconditionally hardcoded to 1 in
> > drivers/ide/ide-taskfile.c.

> > Wouldn't it be better to enable it on architectures which can have a VESA local
> > bus (ia32 only?) only?
> 
> Thank you for pointing it out. Of course it just shouldn't be enabled
> unconditionally there. Apparently it "slipped in" during some
> compiling for "code coverage". My appologies for the inconvenience.
> It will be disabled in the next patch round.

OK.

BTW, this one kills a warning on machines were ide_ioreg_t is not unsigned
short (cfr. the printout at the end of init_irq()).

--- linux-2.5.8-pre1/drivers/ide/ide-probe.c	Thu Apr  4 09:49:47 2002
+++ linux-m68k-2.5.8-pre1/drivers/ide/ide-probe.c	Thu Apr  4 18:02:35 2002
@@ -461,7 +461,13 @@
 {
 	/* Register this hardware interface within the global device tree.
 	 */
+#if !defined(__mc68000__) && !defined(CONFIG_APUS) && !defined(__sparc__)
 	sprintf(hwif->dev.bus_id, "%04x", hwif->io_ports[IDE_DATA_OFFSET]);
+#elif defined(__sparc__)
+	sprintf(hwif->dev.bus_id, "%04lx", hwif->io_ports[IDE_DATA_OFFSET]);
+#else
+	sprintf(hwif->dev.bus_id, "%p", hwif->io_ports[IDE_DATA_OFFSET]);
+#endif /* __mc68000__ && CONFIG_APUS */
 	sprintf(hwif->dev.name, "ide");
 	hwif->dev.driver_data = hwif;
 #ifdef CONFIG_BLK_DEV_IDEPCI

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

