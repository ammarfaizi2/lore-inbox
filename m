Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136134AbRD0RbL>; Fri, 27 Apr 2001 13:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136132AbRD0Raw>; Fri, 27 Apr 2001 13:30:52 -0400
Received: from patan.Sun.COM ([192.18.98.43]:21754 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S136134AbRD0Ram>;
	Fri, 27 Apr 2001 13:30:42 -0400
Message-ID: <3AE9AC84.B0D8682A@sun.com>
Date: Fri, 27 Apr 2001 10:29:40 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Panetta <mpanetta@applianceware.com>, linux-kernel@vger.kernel.org
Subject: Re: HPT366 IDE DMA error question.
In-Reply-To: <20010426131846.A29148@tetsuo.applianceware.com>
Content-Type: multipart/mixed;
 boundary="------------48F7C81BEBB7F1A3CC6EAEFE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------48F7C81BEBB7F1A3CC6EAEFE
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Mike Panetta wrote:

> hdi: timeout waiting for DMA
> ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> hdi: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
> hdi: DMA disabled
> ide4: reset: success
> 
> I get this message on all my off board HPT366 based controller
> cards.  I am using these cards with seagate Barracuda ATA III
> Model ST320414A 20GB drives.  Are there any known issues with
> these drives and the HPT366 based controllers?  Are there any

we have a system with hpt 370's (366 driver) that we found the following
obvious bug in.  If you read the spec carefuly, it is obviously correct. 
You have to set DMA up for read vs. write.  Does this make your problems go
away?  DIff against 2.4.3


-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------48F7C81BEBB7F1A3CC6EAEFE
Content-Type: text/plain; charset=us-ascii;
 name="hpt.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hpt.diff"

diff -u dist-2.4.3/drivers/ide/hpt366.c linux-2.4/drivers/ide/hpt366.c
--- dist-2.4.3/drivers/ide/hpt366.c	Sat Jan 27 08:45:58 2001
+++ linux-2.4/drivers/ide/hpt366.c	Thu Apr 26 20:15:17 2001
@@ -523,9 +638,11 @@
 
 void hpt370_rw_proc (ide_drive_t *drive, ide_dma_action_t func)
 {
-	if ((func != ide_dma_write) || (func != ide_dma_read))
+	if ((func != ide_dma_write && func != ide_dma_read)
+	 || drive->rwproc_cache == (void *)func)
 		return;
 	hpt370_tune_chipset(drive, drive->current_speed, (func == ide_dma_write));
+	drive->rwproc_cache = (void *)func;
 }
 
 static int config_drive_xfer_rate (ide_drive_t *drive)
diff -u dist-2.4.3/include/linux/ide.h linux-2.4/include/linux/ide.h
--- dist-2.4.3/include/linux/ide.h	Mon Jan 29 23:25:32 2001
+++ linux-2.4/include/linux/ide.h	Thu Apr 26 20:16:00 2001
@@ -284,6 +284,7 @@
 	unsigned long service_time;	/* service time of last request */
 	unsigned long timeout;		/* max time to wait for irq */
 	special_t	special;	/* special action flags */
+	void	 *rwproc_cache;		/* last rwproc update */
 	byte     keep_settings;		/* restore settings after drive reset */
 	byte     using_dma;		/* disk is using dma for read/write */
 	byte     waiting_for_dma;	/* dma currently in progress */
 
 

--------------48F7C81BEBB7F1A3CC6EAEFE--

