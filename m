Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319127AbSHTBIY>; Mon, 19 Aug 2002 21:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316223AbSHTBIY>; Mon, 19 Aug 2002 21:08:24 -0400
Received: from fed1mtao03.cox.net ([68.6.19.242]:7041 "EHLO fed1mtao03.cox.net")
	by vger.kernel.org with ESMTP id <S319127AbSHTBIX>;
	Mon, 19 Aug 2002 21:08:23 -0400
Message-ID: <3D619776.7010104@cox.net>
Date: Mon, 19 Aug 2002 18:12:22 -0700
From: "Kevin P. Fleming" <kpfleming@cox.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.1b) Gecko/20020721
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: Stanislav Brabec <utx@penguin.cz>, Paul Bristow <paul@paulbristow.net>,
       linux-kernel@vger.kernel.org
Subject: Re: ide-floppy & devfs - /dev entry not created if drive is empty
References: <Pine.LNX.4.10.10208191744570.458-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
-						printk("cdrom or floppy?, assuming ");
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
  				type = ide_cdrom;	/* Early cdrom models used zero */
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
> Patch is welcome here.
> 
> Drop it on AC and myself please. 
> 
> On Mon, 19 Aug 2002, Kevin P. Fleming wrote:
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
> Andre Hedrick
> LAD Storage Consulting Group
> 

