Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263415AbUECBTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263415AbUECBTn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 21:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263407AbUECBTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 21:19:43 -0400
Received: from bsnelson14.august.net ([216.87.134.14]:62226 "HELO
	bsnelson14.august.net") by vger.kernel.org with SMTP
	id S263413AbUECBT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 21:19:27 -0400
Message-ID: <40959E1C.6040205@bsnelson.com>
Date: Sun, 02 May 2004 20:19:24 -0500
From: Brad Nelson <lkmldd001@bsnelson.com>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Turning off LBA48
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running kernel 2.4.26, and I have a specific need to be able to turn 
off LBA48 support on a per-device basis. Specifically, I need such 
drives to appear with a capacity of ~137GB as they would if there were 
no LBA48 support. Below is a small patch that I applied to this kernel 
to accomplish the goal. Some cursory tests indicate that it works in my 
configuration, but I may have broken some taboos. I didn't know if there 
were non-obvious side effects to increasing the size of the ide_drive_t 
struct, so I renamed an existing and (apparently) unused flag. I also 
exposed a new kernel command line option ("hdx=nolba48"); this seems to 
add to a very small list, so obviously additions aren't taken lightly.

Does anyone else see value (or danger!) in this or a similar patch? The 
reason I need it: I use this machine to manipulate hard drives for other 
machines that aren't LBA48 aware. In the case of a >137GB, it's fine to 
let the machine (TiVo) just see the first 137GB.

Thanks!

Brad

diff -ru -X /root/Xkernel linux-2.4.26.stock/drivers/ide/ide-disk.c 
linux-2.4.26/drivers/ide/ide-disk.c
--- linux-2.4.26.stock/drivers/ide/ide-disk.c   2004-04-30 
18:29:50.000000000 -0500
+++ linux-2.4.26/drivers/ide/ide-disk.c 2004-05-01 12:20:42.000000000 -0500
@@ -1567,6 +1567,9 @@
        if (HWIF(drive)->addressing)
                return 0;

+       if (drive->nolba48)
+               return 0;
+
        if (!(drive->id->cfs_enable_2 & 0x0400))
                 return -EIO;
        drive->addressing = arg;
diff -ru -X /root/Xkernel linux-2.4.26.stock/drivers/ide/ide.c 
linux-2.4.26/drivers/ide/ide.c
--- linux-2.4.26.stock/drivers/ide/ide.c        2004-04-30 
18:29:50.000000000 -0500
+++ linux-2.4.26/drivers/ide/ide.c      2004-05-01 00:50:48.000000000 -0500
@@ -1821,7 +1821,7 @@

                case HDIO_GET_NICE:
                        return put_user(drive->dsc_overlap      <<      
IDE_NICE_DSC_OVERLAP    |
-                                       drive->atapi_overlap    <<      
IDE_NICE_ATAPI_OVERLAP  |
+                                       /* drive->atapi_overlap <<      
IDE_NICE_ATAPI_OVERLAP  | */
                                        drive->nice0            <<      
IDE_NICE_0              |
                                        drive->nice1            <<      
IDE_NICE_1              |
                                        drive->nice2            <<      
IDE_NICE_2,
@@ -2070,6 +2070,7 @@
  * "hdx=cdrom"         : drive is present, and is a cdrom drive
  * "hdx=cyl,head,sect" : disk drive is present, with specified geometry
  * "hdx=noremap"       : do not remap 0->1 even though EZD was detected
+ * "hdx=nolba48"       : do not use lba48 even if hardware supports it
  * "hdx=autotune"      : driver will attempt to tune interface speed
  *                             to the fastest PIO mode supported,
  *                             if possible for this drive only.
@@ -2188,7 +2189,7 @@
                const char *hd_words[] = {"none", "noprobe", "nowerr", 
"cdrom",
                                "serialize", "autotune", "noautotune",
                                "slow", "swapdata", "bswap", "flash",
-                               "remap", "noremap", "scsi", NULL};
+                               "remap", "noremap", "scsi", "nolba48", 
NULL};
                unit = s[2] - 'a';
                hw   = unit / MAX_DRIVES;
                unit = unit % MAX_DRIVES;
@@ -2254,6 +2255,9 @@
                        case -14: /* "scsi" */
                                drive->scsi = 1;
                                goto done;
+                       case -15: /* "nolba48" */
+                               drive->nolba48 = 1;
+                               goto done;
                        case 3: /* cyl,head,sect */
                                drive->media    = ide_disk;
                                drive->cyl      = drive->bios_cyl  = 
vals[0];
diff -ru -X /root/Xkernel linux-2.4.26.stock/include/linux/ide.h 
linux-2.4.26/include/linux/ide.h
--- linux-2.4.26.stock/include/linux/ide.h      2004-04-30 
20:33:22.000000000 -0500
+++ linux-2.4.26/include/linux/ide.h    2004-05-01 12:58:13.000000000 -0500
@@ -738,7 +738,7 @@
        unsigned no_io_32bit    : 1;    /* disallow enabling 32bit I/O */
        unsigned nobios         : 1;    /* do not probe bios for drive */
        unsigned revalidate     : 1;    /* request revalidation */
-       unsigned atapi_overlap  : 1;    /* ATAPI overlap (not supported) */
+       unsigned nolba48        : 1;    /* force lba48 off even if 
hardware supports it */
        unsigned nice0          : 1;    /* give obvious excess bandwidth */
        unsigned nice2          : 1;    /* give a share in our own 
bandwidth */
        unsigned doorlocking    : 1;    /* for removable only: door 
lock/unlock works */

