Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbUAZSI4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 13:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbUAZSI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 13:08:56 -0500
Received: from mail4-141.ewetel.de ([212.6.122.141]:15542 "EHLO
	mail4.ewetel.de") by vger.kernel.org with ESMTP id S262078AbUAZSIx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 13:08:53 -0500
Date: Mon, 26 Jan 2004 19:08:49 +0100 (CET)
From: Pascal Schmidt <der.eremit@email.de>
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: MO: opening for write in cdrom.c
In-Reply-To: <Pine.LNX.4.44.0401261826340.1102-100000@neptune.local>
Message-ID: <Pine.LNX.4.44.0401261900460.855-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jan 2004, Pascal Schmidt wrote:

[short summary for l-k: this is about finding out whether an MO is 
write-protected or not, code that is yet missing from cdrom.c]

> I'll try to implement the fallback that sd.c uses next. That code
> tries several mode senses with different page and length.

Okay, I got it working with the exact method that sd.c uses. I've put
a few printk's in to see where it fails a mode sense. It's actually
inconsistent:

	a) insert a writable disc first after boot, method 1 works
	b) then insert a non-writable disc once - suddenly method 1
	   stops working, even on writable discs, instead method 2
	   works
	c) insert a non-writable disc first after boot, method 1
	   never works, but method 2 does

There's a third method in sd.c. I've also left that in since I suspect
it might be necessary under some circumstances, too.

>From my testing, I get the impression that this Fujitsu drive only
has mode page 0, meaning that only 0x00 and 0x3F make sense, and that
mode page 0x00 also only contains very few bytes of information -
because asking for 16 bytes from 0x3F didn't work, but 4 bytes does.
What's weird is that asking for all pages can also stop suddenly, after
which only page 0x00 is accessible. And when that happens, we only get
a meaningless request sense of 00/00/00 back.

Oh well, strange hardware indeed.

Here's the patch that works for me, please consider applying and
pushing to Linus/Andrew:


--- linux-2.6.2-rc1/include/linux/cdrom.h.orig	Sun Jan 25 23:21:19 2004
+++ linux-2.6.2-rc1/include/linux/cdrom.h	Mon Jan 26 18:46:54 2004
@@ -496,6 +496,7 @@ struct cdrom_generic_command
 #define GPCMD_GET_MEDIA_STATUS		    0xda
 
 /* Mode page codes for mode sense/set */
+#define GPMODE_VENDOR_PAGE		0x00
 #define GPMODE_R_W_ERROR_PAGE		0x01
 #define GPMODE_WRITE_PARMS_PAGE		0x05
 #define GPMODE_AUDIO_CTL_PAGE		0x0e
--- linux-2.6.2-rc1/drivers/cdrom/cdrom.c.orig	Sat Jan 24 01:23:30 2004
+++ linux-2.6.2-rc1/drivers/cdrom/cdrom.c	Mon Jan 26 18:52:00 2004
@@ -696,6 +696,34 @@ static int cdrom_mrw_open_write(struct c
 	return ret;
 }
 
+static int mo_open_write(struct cdrom_device_info *cdi)
+{
+	struct cdrom_generic_command cgc;
+	char buffer[255];
+	int ret;
+	
+	init_cdrom_command(&cgc, &buffer, 4, CGC_DATA_READ);
+	cgc.quiet = 1;
+
+	/*
+	 * obtain write protect information as per
+	 * drivers/scsi/sd.c:sd_read_write_protect_flag
+	 */
+
+	ret = cdrom_mode_sense(cdi, &cgc, GPMODE_ALL_PAGES, 0);
+	if (ret)
+		ret = cdrom_mode_sense(cdi, &cgc, GPMODE_VENDOR_PAGE, 0);
+	if (ret) {
+		cgc.buflen = 255;
+		ret = cdrom_mode_sense(cdi, &cgc, GPMODE_ALL_PAGES, 0);
+	}
+
+	if (ret)
+		return 1;
+	
+	return (buffer[3] & 0x80) != 0;
+}
+
 /*
  * returns 0 for ok to open write, non-0 to disallow
  */
@@ -707,11 +735,8 @@ static int cdrom_open_write(struct cdrom
 		ret = cdrom_mrw_open_write(cdi);
 	else if (CDROM_CAN(CDC_DVD_RAM))
 		ret = cdrom_dvdram_open_write(cdi);
-	/*
-	 * needs to really check whether media is writeable
-	 */
 	else if (CDROM_CAN(CDC_MO_DRIVE))
-		ret = 0;
+		ret = mo_open_write(cdi);
 
 	return ret;
 }


-- 
Ciao,
Pascal

