Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263322AbTDCIZo>; Thu, 3 Apr 2003 03:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263323AbTDCIZo>; Thu, 3 Apr 2003 03:25:44 -0500
Received: from [202.109.126.231] ([202.109.126.231]:30822 "HELO
	www.support-smartpc.com.cn") by vger.kernel.org with SMTP
	id <S263322AbTDCIZm>; Thu, 3 Apr 2003 03:25:42 -0500
Message-ID: <3E8BF293.2CC30C1F@mic.com.tw>
Date: Thu, 03 Apr 2003 16:36:35 +0800
From: "rain.wang" <rain.wang@mic.com.tw>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andre Hedrick <andre@linux-ide.org>
Subject: PATCH RFC :ide_do_reset() fix for 2.5.66
References: <Pine.LNX.4.21.0303241129420.855-100000@mars.zaxl.net> <1048514373.25136.4.camel@irongate.swansea.linux.org.uk> <20030324180125.2606b046.alex@ssi.bg> <1048527607.25655.18.camel@irongate.swansea.linux.org.uk> <3E8BDC10.D0195D71@mic.com.tw> <20030403071620.GJ2072@suse.de>
Content-Type: multipart/mixed;
 boundary="------------71983BEDD2F9CD3F3D50627B"
X-OriginalArrivalTime: 03 Apr 2003 08:33:02.0796 (UTC) FILETIME=[A42628C0:01C2F9BB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------71983BEDD2F9CD3F3D50627B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Jens Axboe wrote:

> On Thu, Apr 03 2003, rain.wang wrote:
> > Hi Alan,
> >     I found just changing ide_do_reset() to wait till completion can
> > handle the handler race. can this be enough?
>
> This is buggy for a number of reasons. Firstly, how do you make sure
> that someone else doesn't race with your hwif_data manipulation? This
> looks very suspect. By far the worst problem is that you are assuming
> that ide_do_reset() can sleep, when in fact it cannot (just follow the
> various paths into ide_do_request()). You even grab the ide_lock _and_
> disable interrupts yourself prior calling wait_for_completion(), this is
> incredibly broken.
>
> --
> Jens Axboe

Hi,
    Thank you, I'm too young. I should have put this in RFC.
please help me to replace using 'hwif-data', I mainly mean
to let drive reset wait for its clean up complete.

regards
rain.w

--------------71983BEDD2F9CD3F3D50627B
Content-Type: text/plain; charset=us-ascii;
 name="ide-iops.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-iops.c.diff"

--- /usr/src/linux/drivers/ide/ide-iops.c	Thu Apr  3 14:13:51 2003
+++ ide-iops.c	Thu Apr  3 16:24:31 2003
@@ -1107,6 +1107,10 @@
 	}
 	/* done polling */
 	hwgroup->poll_timeout = 0;
+	
+	/* tell ide_do_reset it complete */
+	complete((struct completion *)hwif->hwif_data);
+
 	return ide_stopped;
 }
 
@@ -1171,6 +1175,10 @@
 		}
 	}
 	hwgroup->poll_timeout = 0;	/* done polling */
+
+	/* tell ide_do_reset it complete */
+	complete((struct completion *)hwif->hwif_data);
+
 	return ide_stopped;
 }
 
@@ -1307,7 +1315,25 @@
 
 ide_startstop_t ide_do_reset (ide_drive_t *drive)
 {
-	return do_reset1(drive, 0);
+	/* 
+	 * Waiting for completion needed.
+	 */
+	ide_hwif_t *hwif;
+	void *old_data;
+	DECLARE_COMPLETION(wait);
+	
+	hwif = HWIF(drive);
+	
+	old_data = hwif->hwif_data;
+	hwif->hwif_data = &wait;
+
+	(void) do_reset1(drive, 0);
+	
+	wait_for_completion(&wait);
+
+	hwif->hwif_data = old_data;
+	
+	return ide_stopped;
 }
 
 EXPORT_SYMBOL(ide_do_reset);

--------------71983BEDD2F9CD3F3D50627B--

