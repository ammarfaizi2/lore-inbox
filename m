Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263300AbTDCGt4>; Thu, 3 Apr 2003 01:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263301AbTDCGt4>; Thu, 3 Apr 2003 01:49:56 -0500
Received: from [202.109.126.231] ([202.109.126.231]:24418 "HELO
	www.support-smartpc.com.cn") by vger.kernel.org with SMTP
	id <S263300AbTDCGty>; Thu, 3 Apr 2003 01:49:54 -0500
Message-ID: <3E8BDC10.D0195D71@mic.com.tw>
Date: Thu, 03 Apr 2003 15:00:32 +0800
From: "rain.wang" <rain.wang@mic.com.tw>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andre Hedrick <andre@linux-ide.org>
Subject: PATCH:ide_do_reset() fix for 2.5.66
References: <Pine.LNX.4.21.0303241129420.855-100000@mars.zaxl.net>
		 <1048514373.25136.4.camel@irongate.swansea.linux.org.uk>
		 <20030324180125.2606b046.alex@ssi.bg> <1048527607.25655.18.camel@irongate.swansea.linux.org.uk>
Content-Type: multipart/mixed;
 boundary="------------7A69D4B11A11DD3808DCF944"
X-OriginalArrivalTime: 03 Apr 2003 06:57:01.0062 (UTC) FILETIME=[39E35260:01C2F9AE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------7A69D4B11A11DD3808DCF944
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi Alan,
    I found just changing ide_do_reset() to wait till completion can
handle the handler race. can this be enough?

regards
rain.w



--------------7A69D4B11A11DD3808DCF944
Content-Type: text/plain; charset=us-ascii;
 name="ide-iops.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-iops.c.diff"

--- /usr/src/linux/drivers/ide/ide-iops.c	Thu Apr  3 14:13:51 2003
+++ ide-iops.c	Thu Apr  3 14:29:47 2003
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
 
@@ -1307,7 +1315,27 @@
 
 ide_startstop_t ide_do_reset (ide_drive_t *drive)
 {
-	return do_reset1(drive, 0);
+	/* 
+	 * Waiting for completion needed.
+	 */
+	unsigned long flags;
+	ide_hwif_t *hwif;
+	void *old_data;
+	DECLARE_COMPLETION(wait);
+	
+	spin_lock_irqsave(&ide_lock, flags);
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
+	spin_unlock_irqrestore(&ide_lock, flags);
+	return ide_stopped;
 }
 
 EXPORT_SYMBOL(ide_do_reset);

--------------7A69D4B11A11DD3808DCF944
Content-Type: text/plain; charset=us-ascii;
 name="ide.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide.c.diff"

--- /usr/src/linux/drivers/ide/ide.c	Tue Apr  1 17:26:45 2003
+++ ide.c	Thu Apr  3 14:31:38 2003
@@ -1586,8 +1586,6 @@
 			spin_lock_irqsave(&ide_lock, flags);
 			
 			DRIVER(drive)->abort(drive, "drive reset");
-			if(HWGROUP(drive)->handler)
-				BUG();
 				
 			/* Ensure nothing gets queued after we
 			   drop the lock. Reset will clear the busy */

--------------7A69D4B11A11DD3808DCF944--

