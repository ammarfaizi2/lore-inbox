Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262033AbSJQRtf>; Thu, 17 Oct 2002 13:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262034AbSJQRtf>; Thu, 17 Oct 2002 13:49:35 -0400
Received: from smtp4.vol.cz ([195.250.128.43]:38413 "EHLO majordomo.vol.cz")
	by vger.kernel.org with ESMTP id <S262033AbSJQRtc>;
	Thu, 17 Oct 2002 13:49:32 -0400
Date: Thu, 17 Oct 2002 00:10:10 +0200
From: Stanislav Brabec <utx@penguin.cz>
To: linux-kernel@vger.kernel.org
Subject: ide-floppy & devfs - /dev entry not created if drive is empty (repost)
Message-ID: <20021016221009.GA1219@utx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Accept-Language: cs, sk, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Two months ago I sent following report:

On Sun, Aug 18, 2002 at 08:56:20PM +0200, Stanislav Brabec wrote:

> I have tested ide-floppy on my Linux 2.4.19 with ATAPI ZIP 100. I am
> using devfs.
>
> I found following problem:
>
> If module ide-floppy is loaded and no disc is present in the drive,
> /dev/ide/host0/bus1/target1/lun0/disc entry is not created. Later
> inserted media cannot be checked in any way, because no /dev entry
> exists.
>

Now I have tested 2.4.20-pre10 with the same ugly result. :-(

And got imediatelly answer and patch:

On Mon, Aug 19, 2002 at 05:04:25PM -0700, Kevin P. Fleming wrote:
> There are patches at http://members.cox.net/kpfleming/ide-floppy to
> resolve this.
----- Forwarded message from "Kevin P. Fleming" <kpfleming@cox.net> -----

Date: Mon, 19 Aug 2002 18:12:22 -0700
From: "Kevin P. Fleming" <kpfleming@cox.net>
To: Andre Hedrick <andre@linux-ide.org>
CC: Stanislav Brabec <utx@penguin.cz>, Paul Bristow <paul@paulbristow.net>,
   linux-kernel@vger.kernel.org
Subject: Re: ide-floppy & devfs - /dev entry not created if drive is empty

I'll let Paul handle this, since he is the ide-floppy maintainer and has 
some other changes he wants to make. If you do not get anything from him 
in a week or so, please let me know and I'll updates the patches to the 
latest -ac kernel and send them.

Oh, there is one non-ide-floppy patch, this cleans up a small part of 
ide-probe and ensures that ide-floppy devices are marked as removable 
devices. Last kernel I applied it to was 2.4.20-pre2-ac1, it may have 
problems with the newer ones if you've worked on ide-probe.

diff -X dontdiff -urN linux/drivers/ide/ide-probe.c 
linux-probe/drivers/ide/ide-probe.c
--- linux/drivers/ide/ide-probe.c	Thu Jun  6 10:00:50 2002
+++ linux-probe/drivers/ide/ide-probe.c	Thu Jun  6 10:37:41 2002
@@ -130,31 +130,40 @@
 			goto err_misc;
 		}
 #endif /* CONFIG_BLK_DEV_PDC4030 */
+		/*
+		 * Handle drive type overrides for "unusual" devices
+		 */
 		switch (type) {
-			case ide_floppy:
-				if (!strstr(id->model, "CD-ROM")) {
-					if (!strstr(id->model, "oppy") &&
-					    !strstr(id->model, "poyp") &&
-					    !strstr(id->model, "ZIP"))
-						printk("cdrom or floppy?, 
assuming ");
-					if (drive->media != ide_cdrom) {
-						printk ("FLOPPY");
-						break;
-					}
-				}
+		case ide_floppy:
+			if (strstr(id->model, "CD-ROM")) {
+				type = ide_cdrom;
+				break;
+			}
+			if (!strstr(id->model, "oppy") &&
+			    !strstr(id->model, "poyp") &&
+			    !strstr(id->model, "ZIP"))
+				printk("cdrom or floppy?, assuming ");
+			if (drive->media == ide_cdrom)
 				type = ide_cdrom;	/* Early cdrom 
 				models used zero */
-			case ide_cdrom:
-				drive->removable = 1;
+			break;
 #ifdef CONFIG_PPC
+		case ide_cdrom:
 				/* kludge for Apple PowerBook internal zip */
-				if (!strstr(id->model, "CD-ROM") &&
-				    strstr(id->model, "ZIP")) {
-					printk ("FLOPPY");
-					type = ide_floppy;
-					break;
-				}
+			if (!strstr(id->model, "CD-ROM") &&
+			    strstr(id->model, "ZIP")) {
+				type = ide_floppy;
+				break;
+			}
 #endif
+		}
+		switch (type) {
+ 			case ide_floppy:
+ 				printk ("FLOPPY");
+ 				drive->removable = 1;
+ 				break;
+ 			case ide_cdrom:
 				printk ("CD/DVD-ROM");
+ 				drive->removable = 1;
 				break;
 			case ide_tape:
 				printk ("TAPE");


Andre Hedrick wrote:
>Patch is welcome here.
>
>Drop it on AC and myself please. 
>
>On Mon, 19 Aug 2002, Kevin P. Fleming wrote:
>
>
>>There are patches at http://members.cox.net/kpfleming/ide-floppy to 
>>resolve this.
>>
>>Stanislav Brabec wrote:
>>
>>>Hallo Paul Bristow,
>>>
>>>I have tested ide-floppy on my Linux 2.4.19 with ATAPI ZIP 100. I am
>>>using devfs.
>>>
>>>I found following problem:
>>>
>>>If module ide-floppy is loaded and no disc is present in the drive,
>>>/dev/ide/host0/bus1/target1/lun0/disc entry is not created. Later
>>>inserted media cannot be checked in any way, because no /dev entry
>>>exists.
>>>
>>>Older kernels have also this behavior.
>>>
>>>Fix: Create .../disc entry in all cases, even if no disc is present.
>>>
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>
>
>
>Andre Hedrick
>LAD Storage Consulting Group
>

----- End forwarded message -----

-- 
Stanislav Brabec
http://www.penguin.cz/~utx
