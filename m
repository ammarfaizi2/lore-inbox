Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263752AbUC3Pbs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 10:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263728AbUC3P3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 10:29:14 -0500
Received: from witte.sonytel.be ([80.88.33.193]:62686 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263721AbUC3P2U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 10:28:20 -0500
Date: Tue, 30 Mar 2004 17:28:12 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: =?ISO-8859-15?Q?Andr=E9_Hedrick?= <andre@linux-ide.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: Lionel Bergeret <lbergeret@swing.be>, JunHyeok Heo <jhheo@idis.co.kr>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH] Bogus LBA48 drives
In-Reply-To: <Pine.GSO.4.58.0403301654300.9765@waterleaf.sonytel.be>
Message-ID: <Pine.GSO.4.58.0403301726540.9767@waterleaf.sonytel.be>
References: <Pine.GSO.4.58.0403301654300.9765@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2004, Geert Uytterhoeven wrote:
> Apparently some IDE drives (e.g. a pile of 80 GB ST380020ACE drives I have
> access to) advertise to support LBA48, but don't, causing kernels that support
> LBA48 (i.e. anything newer than 2.4.18, including 2.4.25 and 2.6.4) to fail on
> them.  Older kernels (including 2.2.20 on the Debian woody CDs) work fine.
>
> One problem with those drives is that the lba_capacity_2 field in their drive
> identification is set to 0, making the IDE driver think the disk is 0 bytes
> large. At first I tried modifying the driver to use lba_capacity if
> lba_capacity_2 is set to 0, but this caused disk errors. So it looks like those
> drives don't support the increased transfer size of LBA48 neither.
>
> I added a workaround for these drives to both 2.4.25 and 2.6.4. I'll send
> patches in follow-up emails.

Patch for 2.6.4 (and 2.6.5-rc3):
  - Check for lba_capacity_2 being non-zero in idedisk_supports_lba48()

--- linux-2.6.4/drivers/ide/ide-disk.c.orig	2004-03-12 12:02:53.000000000 +0100
+++ linux-2.6.4/drivers/ide/ide-disk.c	2004-03-26 13:54:39.000000000 +0100
@@ -1058,7 +1058,8 @@
  */
 static inline int idedisk_supports_lba48(const struct hd_driveid *id)
 {
-	return (id->command_set_2 & 0x0400) && (id->cfs_enable_2 & 0x0400);
+	return (id->command_set_2 & 0x0400) && (id->cfs_enable_2 & 0x0400)
+	       && id->lba_capacity_2;
 }

 static inline void idedisk_check_hpa(ide_drive_t *drive)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
