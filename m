Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264418AbTIIVRX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 17:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264434AbTIIVRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 17:17:23 -0400
Received: from unsol-intbg.internet-bg.net ([212.124.67.226]:60683 "HELO
	ns.unixsol.org") by vger.kernel.org with SMTP id S264418AbTIIVRF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 17:17:05 -0400
Message-ID: <3F5E434D.6080801@unixsol.org>
Date: Wed, 10 Sep 2003 00:17:01 +0300
From: Georgi Chorbadzhiyski <gf@unixsol.org>
Organization: Unix Solutions Ltd. (http://unixsol.org)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030811
X-Accept-Language: en, en-us, bg
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: Matthew Dharm <mdharm-usb@one-eyed-alien.net>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] [2.6-test] Bug in usb-storage or scsi?
References: <Pine.LNX.4.44L0.0309091639580.643-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0309091639580.643-100000@ida.rowland.org>
Content-Type: multipart/mixed;
 boundary="------------040400000203080104000703"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040400000203080104000703
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Alan Stern wrote:
> On Tue, 9 Sep 2003, Georgi Chorbadzhiyski wrote:
>>I was able to access my Music Pen mp3 player using usb-storage driver
>>in 2.4 without any problems. After updating to 2.6 this was not possible
>>anymore. It seems that usb-storage driver in 2.6 detect the device but
>>I was unable to access /dev/sda1. "mount -t vfat /dev/sda1 /mnt" returns
>>this error: "mount: /dev/sda1 is not a valid block device"
>>
>>Under 2.4.21-ck3, sda1 is corectly registered.
>>
>>Please see the attached files containing dmesg snippets from 2.4 and 2.6
>>kerneles as well as 2.6 config. If you need more information I'll be glad
>>to provide it.
>>
>>The 2.4 kernel that I tested was 2.4.21-ck3
>>The 2.6 kernel that I tested was 2.6.0-test5-mm1, 2.6.0-test4 and 2.6.0-test1
> 
> 
> More problems with that stupid MODE-SENSE cache page!  There are so many 
> USB storage devices that have problems with that -- I wonder if it's worth 
> the effort to try to continue supporting it?
> 
> Georgi, the problem is with your mp3 player, not usb-storage or SCSI.  
> It's crashing when given a perfectly legal SCSI command.  Linux 2.4
> doesn't issue the command; that's why it works okay.

Well it probably is tested only with windows, so it's no suprise that
device's USB implementation is buggy.

> If you want a temporary fix for 2.6.0, you can do this:  Edit the 
> routine sd_read_cache_type in the file drivers/scsi/sd.c (near line 1100).  
> Get rid of (or #ifdef out) most of the function; just leave the last few 
> lines where it does:
> 
> 		printk(KERN_ERR "%s: assuming drive cache: write through\n",
> 		       diskname);
> 		sdkp->WCE = 0;
> 		sdkp->RCD = 0;
> 
> You might want to change the KERN_ERR to KERN_NOTICE.

Thanks a lot! That worked fine! Now the device is detected and working.

Ugly patch is attached for reference. I hope some workaround for this kind
of buggy devices is developed in the future. Thank again.

> However, you might also want to think twice before doing this if you have 
> any other SCSI disks, because making this change will affect all of them.

-- 
Georgi Chorbadzhiyski
http://georgi.cybcom.net/

--------------040400000203080104000703
Content-Type: text/plain;
 name="mpen_fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mpen_fix.diff"

--- linux-2.6.0-test5/drivers/scsi/sd-org.c	2003-09-09 23:58:43.000000000 +0300
+++ linux-2.6.0-test5/drivers/scsi/sd.c	2003-09-10 00:11:21.000000000 +0300
@@ -1098,6 +1098,7 @@
 static void
 sd_read_cache_type(struct scsi_disk *sdkp, char *diskname,
 		   struct scsi_request *SRpnt, unsigned char *buffer) {
+#if 0
 	int len = 0, res;
 
 	const int dbd = 0;	   /* DBD */
@@ -1150,6 +1151,11 @@
 		sdkp->WCE = 0;
 		sdkp->RCD = 0;
 	}
+#endif
+	printk(KERN_NOTICE "%s: assuming drive cache: write through\n",
+	       diskname);
+	sdkp->WCE = 0;
+	sdkp->RCD = 0;
 }
 
 /**

--------------040400000203080104000703--

