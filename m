Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129908AbQLKXyi>; Mon, 11 Dec 2000 18:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131156AbQLKXy2>; Mon, 11 Dec 2000 18:54:28 -0500
Received: from adsl-209-182-168-213.value.net ([209.182.168.213]:44557 "EHLO
	draco.foogod.com") by vger.kernel.org with ESMTP id <S131063AbQLKXyL>;
	Mon, 11 Dec 2000 18:54:11 -0500
Date: Mon, 11 Dec 2000 15:23:31 -0800
From: alex@foogod.com
To: linux-kernel@vger.kernel.org
Subject: [patch] I-Opener fix (again)
Message-ID: <20001211152331.M10618@draco.foogod.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="JYK4vJDZwFMowpUq"
X-Mailer: Mutt 1.0pre3us
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii

It's been a few months (and a couple of kernel releases) since I mentioned this
before and it doesn't look like it's made it in, and I haven't seen any more
comments on it in the list archives, so I'm bringing it up again in case it
just got forgotten about somewhere along the line..

As I remember, Andre Hedrick had asked for clarification on my original post,
and I sent a followup message in response, but now I can't seem to find it
anywhere in the archives, so I don't know whether it never made it out of my
mailer or..

In any case, attached is a patch (against 2.4.0pre11) which fixes the bug which
causes disk detection issues on I-Opener (and possibly other unusual) hardware.

The problem is that the code assumes that a flash-disk will always be the
primary disk on an interface, but on the I-Opener this is not always the case.
If a traditional disk is primary, and a flashdisk is secondary, the detection
code (wrongly) disables the primary disk that it had already previously
detected.

I would like to see this make it into the official source as it's a very small
change that fixes some obviously wrong behavior..

-alex

--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="iopener.patch"

--- drivers/ide/ide-probe.c.orig	Mon Dec 11 14:59:08 2000
+++ drivers/ide/ide-probe.c	Mon Dec 11 15:00:13 2000
@@ -161,8 +161,8 @@
 	 * Prevent long system lockup probing later for non-existant
 	 * slave drive if the hwif is actually a flash memory card of some variety:
 	 */
-	if (drive_is_flashcard(drive)) {
-		ide_drive_t *mate = &HWIF(drive)->drives[1^drive->select.b.unit];
+	if (!drive->select.b.unit && drive_is_flashcard(drive)) {
+		ide_drive_t *mate = &HWIF(drive)->drives[1];
 		if (!mate->ata_flash) {
 			mate->present = 0;
 			mate->noprobe = 1;

--JYK4vJDZwFMowpUq--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
