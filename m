Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbUB2Ivm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 03:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbUB2Ivm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 03:51:42 -0500
Received: from witte.sonytel.be ([80.88.33.193]:15519 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262018AbUB2Ivi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 03:51:38 -0500
Date: Sun, 29 Feb 2004 09:50:42 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: Jeff Garzik <jgarzik@pobox.com>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Worrisome IDE PIO transfers...
In-Reply-To: <200402290121.30498.bzolnier@elka.pw.edu.pl>
Message-ID: <Pine.GSO.4.58.0402290943580.7483@waterleaf.sonytel.be>
References: <4041232C.7030305@pobox.com> <200402290121.30498.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Feb 2004, Bartlomiej Zolnierkiewicz wrote:
> [ Geert added to cc: ]
>
> On Sunday 29 of February 2004 00:24, Jeff Garzik wrote:
> > Looking at the function that is used to transfer data when in PIO mode...
> >
> > void taskfile_output_data (ide_drive_t *drive, void *buffer, u32 wcount)
> > {
> >          if (drive->bswap) {
> >                  ata_bswap_data(buffer, wcount);
> >                  HWIF(drive)->ata_output_data(drive, buffer, wcount);
> >                  ata_bswap_data(buffer, wcount);
> >          } else {
> >                  HWIF(drive)->ata_output_data(drive, buffer, wcount);
> >          }
> > }
> >
> > Swapping the data in-place is very, very wrong...   you don't want to be
> > touching the data that userspace might have mmap'd ...  Additionally,
> > byteswapping back and forth for each PIO sector chews unnecessary CPU.
>
> This is used for accessing "normal" disks on beasts with byte-swapped IDE
> bus (Atari/Q40/TiVo) and "byteswapped" disks on normal machines.
>
> [ Hm. actually I don't see how it can be used for accessing "normal" disks,
>   as data is byteswapped by IDE bus and then swapped back by IDE driver. ]

Why not? The only difference between `normal' and `byteswapped' disks is that
the bytes in a 16-bit word are swapped (sic :-), so you can convert in both
directions by swapping the bytes. Normal disks have been used on Atari before,
so it should (still) work.

BTW, the generic tree misses this patch, which was deemed inappropriate before,
but is needed to make sure the drive identification block is correct on those
machines:

--- linux-2.6.3/drivers/ide/ide-iops.c	Mon Sep 16 09:49:17 2002
+++ linux-m68k-2.6.3/drivers/ide/ide-iops.c	Wed Oct  2 23:01:40 2002
@@ -360,6 +360,23 @@
 	int i;
 	u16 *stringcast;

+#ifdef __mc68000__
+	if (!MACH_IS_AMIGA && !MACH_IS_MAC && !MACH_IS_Q40 && !MACH_IS_ATARI)
+		return;
+
+#ifdef M68K_IDE_SWAPW
+	if (M68K_IDE_SWAPW) {	/* fix bus byteorder first */
+		u_char *p = (u_char *)id;
+		u_char t;
+		for (i = 0; i < 512; i += 2) {
+			t = p[i];
+			p[i] = p[i+1];
+			p[i+1] = t;
+		}
+	}
+#endif
+#endif /* __mc68000__ */
+
 	id->config         = __le16_to_cpu(id->config);
 	id->cyls           = __le16_to_cpu(id->cyls);
 	id->reserved2      = __le16_to_cpu(id->reserved2);


Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
