Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932570AbVLMIcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932570AbVLMIcz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 03:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932555AbVLMIcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 03:32:45 -0500
Received: from mail.kroah.org ([69.55.234.183]:34947 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932543AbVLMIYo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 03:24:44 -0500
Date: Tue, 13 Dec 2005 00:23:52 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       linux@rainbow-software.org, bzolnier@gmail.com
Subject: [patch 23/26] ide-floppy: software eject not working with LS-120 drive
Message-ID: <20051213082352.GX5823@kroah.com>
References: <20051213073430.558435000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="ide-floppy-software-eject-not-working-with-ls-120-drive.patch"
In-Reply-To: <20051213082143.GA5823@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Ondrej Zary <linux@rainbow-software.org>

The problem (eject not working on ATAPI LS-120 drive) is caused by
idefloppy_ioctl() function which *first* tries generic_ide_ioctl()
and *only* if it fails with -EINVAL, proceeds with the specific ioctls.
The generic eject command fails with something other than -EINVAL
and the specific one is never executed.

This patch fixes it by first going through the internal ioctls
and only trying generic_ide_ioctl() if none of them matches.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index e83f54d..f615ab7 100644
---
 drivers/ide/ide-floppy.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- linux-2.6.14.3.orig/drivers/ide/ide-floppy.c
+++ linux-2.6.14.3/drivers/ide/ide-floppy.c
@@ -2038,11 +2038,9 @@ static int idefloppy_ioctl(struct inode 
 	struct ide_floppy_obj *floppy = ide_floppy_g(bdev->bd_disk);
 	ide_drive_t *drive = floppy->drive;
 	void __user *argp = (void __user *)arg;
-	int err = generic_ide_ioctl(drive, file, bdev, cmd, arg);
+	int err;
 	int prevent = (arg) ? 1 : 0;
 	idefloppy_pc_t pc;
-	if (err != -EINVAL)
-		return err;
 
 	switch (cmd) {
 	case CDROMEJECT:
@@ -2094,7 +2092,7 @@ static int idefloppy_ioctl(struct inode 
 	case IDEFLOPPY_IOCTL_FORMAT_GET_PROGRESS:
 		return idefloppy_get_format_progress(drive, argp);
 	}
- 	return -EINVAL;
+	return generic_ide_ioctl(drive, file, bdev, cmd, arg);
 }
 
 static int idefloppy_media_changed(struct gendisk *disk)

--
