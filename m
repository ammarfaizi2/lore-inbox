Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131429AbQLRJbp>; Mon, 18 Dec 2000 04:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131617AbQLRJbf>; Mon, 18 Dec 2000 04:31:35 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:43525 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S131429AbQLRJbZ>; Mon, 18 Dec 2000 04:31:25 -0500
Date: Mon, 18 Dec 2000 03:00:54 -0600
To: Alex Buell <alex.buell@tahallah.clara.co.uk>
Cc: Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.18 ide-scsi & scsi generic modules
Message-ID: <20001218030054.D3199@cadcamlab.org>
In-Reply-To: <Pine.LNX.4.30.0012171937290.275-100000@tahallah.clara.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0012171937290.275-100000@tahallah.clara.co.uk>; from alex.buell@tahallah.clara.co.uk on Sun, Dec 17, 2000 at 07:41:03PM +0000
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Alex Buell]
> I can confirm that this is true for 2.2.x, with "hdx=ide-scsi". Once
> I compiled both statically into the kernel, it works.
> 
> Perhaps somone can backport the fixes? It would be nice to change 2.2
> so it can accept "hdx=scsi" for compatiblity with 2.4.

I'm confused.  I just looked through the probing code and it appears
that "hdx=ide-scsi" should work the same whether ide-scsi is compiled
in or a module.

If you want "hdx=scsi" to be a synonym for "hdx=ide-scsi", that is easy
enough....

Peter

diff -urk~ 2.2.18/drivers/block/ide.c
--- 2.2.18/drivers/block/ide.c~	Fri Nov  3 19:20:34 2000
+++ 2.2.18/drivers/block/ide.c	Mon Dec 18 02:57:45 2000
@@ -2509,7 +2509,7 @@
 	if (s[0] == 'h' && s[1] == 'd' && s[2] >= 'a' && s[2] <= max_drive) {
 		const char *hd_words[] = {"none", "noprobe", "nowerr", "cdrom",
 				"serialize", "autotune", "noautotune",
-				"slow", "swapdata", "bswap", NULL};
+				"slow", "swapdata", "bswap", "scsi", NULL};
 		unit = s[2] - 'a';
 		hw   = unit / MAX_DRIVES;
 		unit = unit % MAX_DRIVES;
@@ -2549,6 +2549,9 @@
 			case -9: /* swapdata or bswap */
 			case -10:
 				drive->bswap = 1;
+				goto done;
+			case -11: /* "scsi" */
+				strcpy (drive->driver_req, "ide-scsi");
 				goto done;
 			case 3: /* cyl,head,sect */
 				drive->media	= ide_disk;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
