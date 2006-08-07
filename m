Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbWHGT1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWHGT1J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 15:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbWHGT1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 15:27:09 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:36987 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750811AbWHGT1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 15:27:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type;
        b=sz5soy+/eaGYSursNnohOS1TxzJiTWGvw9Miluf3rgx/fhtvnUAA393vhruDIjKYB1jjq0AmKG0pTeP5tR5N6Zb9wQ+lCdf/t0fyQkqnGdwMcmOvd2Qx60ZXcdYU863a8+eRLkZIrZKdURsJ6rmibCSKvBSnExzCduT8/Sd8v1c=
Message-ID: <44D793E6.8010500@gmail.com>
Date: Tue, 08 Aug 2006 04:26:30 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: Harald Dunkel <harald.dunkel@t-online.de>
CC: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       davidsen@tmr.com
Subject: Re: 2.6.18-rc2, problem to wake up spinned down drive?
References: <44CC9F7E.8040807@t-online.de> <44CF7E5A.2010903@gmail.com> <20060805212346.GE5417@ucw.cz> <44D6AE59.6070709@gmail.com> <44D789BA.4010206@t-online.de>
In-Reply-To: <44D789BA.4010206@t-online.de>
Content-Type: multipart/mixed;
 boundary="------------090000040602060707000700"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090000040602060707000700
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Harald Dunkel wrote:
> Tejun Heo wrote:
>> Pavel Machek wrote:
>>>> echo 1 > /sys/bus/scsi/devices/1:0:0:0/power/state
>>> Really? I thought power/state takes 0/3 (for D0 and D3)
>> Yes, of course.  My mistake.  Sorry about the confusion.  The correct
>> command is 'echo -n 3 > /sys/bus/scsi/devices/x:y:z:w/power/state'.
>>
> 
> (Sure?  :-)

The sleeping part is correct.  That will make libata put the disk to sleep.

> Now this did not work at all. The '-n 3' was probably
> correct, but when I tried to access the disk, then it
> did not spin up again (I waited for 5 minutes). There
> was no message on the console, either.
> 
> But I could not reproduce this problem.
> 
> How do I monitor that the disk spins down and up?

But the waking up part isn't.  You need to issue wake up explicitly by 
doing 'echo -n 0 > /sys/...'  I've been a complete idiot in this thread. 
  Please excuse me.  :-(

I think the solution to your problem is adjusting command timeout to 
more reasonable values which should make the problem more bearable. 
It'll take some time to figure out how to make timeouts more intelligent 
without breaking support for slow devices.  I'll work on that.

I'm attaching a temporary patch for the time being.

-- 
tejun

--------------090000040602060707000700
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 98bd3aa..5676388 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -99,7 +99,7 @@ #define SD_MAX_DISKS	(((26 * 26) + 26 + 
 /*
  * Time out in seconds for disks and Magneto-opticals (which are slower).
  */
-#define SD_TIMEOUT		(30 * HZ)
+#define SD_TIMEOUT		(7 * HZ)
 #define SD_MOD_TIMEOUT		(75 * HZ)
 
 /*
diff --git a/include/linux/libata.h b/include/linux/libata.h
index b941670..45686f9 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -200,9 +200,9 @@ enum {
 	ATA_HOST_SIMPLEX	= (1 << 0),	/* Host is simplex, one DMA channel per host_set only */
 	
 	/* various lengths of time */
-	ATA_TMOUT_BOOT		= 30 * HZ,	/* heuristic */
-	ATA_TMOUT_BOOT_QUICK	= 7 * HZ,	/* heuristic */
-	ATA_TMOUT_INTERNAL	= 30 * HZ,
+	ATA_TMOUT_BOOT		= 10 * HZ,	/* heuristic */
+	ATA_TMOUT_BOOT_QUICK	= 5 * HZ,	/* heuristic */
+	ATA_TMOUT_INTERNAL	= 10 * HZ,
 	ATA_TMOUT_INTERNAL_QUICK = 5 * HZ,
 
 	/* ATA bus states */

--------------090000040602060707000700--
