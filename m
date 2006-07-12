Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751378AbWGLOPB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbWGLOPB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 10:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWGLOPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 10:15:00 -0400
Received: from a83-68-3-130.adsl.cistron.nl ([83.68.3.130]:20696 "EHLO
	mx.wurtel.net") by vger.kernel.org with ESMTP id S1751378AbWGLOPA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 10:15:00 -0400
Date: Wed, 12 Jul 2006 16:14:41 +0200
From: Paul Slootman <paul@wurtel.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] SCSI disk won't spinup, so boot hangs
Message-ID: <20060712141441.GA16473@wurtel.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
X-Scanner: exiscan *1G0fUA-00081l-00*8cKTmcVhLC6*Wurtel
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was recently confronted by a SCSI disk that had crashed somehow
("mechanical positioning error" during the first signs of trouble). The
kernel hung after that, despite the fact that everything was on RAID-1
and the first disk still was working...

I rebooted the system (remote powerboot, as I was 150km away). Now the
SCSI BIOS hung on scanning the SCSI bus. "No problem", I thought, and
disabled the BIOS scan for ID 1. Now grub appeared, and the kernel got
loaded. However, now the "Spinning up disk..." message failed after 100s
with the message "not responding...". The scan proceeded to try to read
the capacity, and that hung indefinitely. Only by driving to the
location and physically pulling the disk could I get the machine up and
running again.

I reasoned that if the spinup fails, it doesn't make much sense to try
and read the capacity, the partition tables, etc..  Hence I came up with
the patch below that sets media_present to 0 when the spinup doesn't
respond. It works for me (TM); there may be a better way, however the
current behaviour sucks big time.

Patch is against 2.6.17.4, although that code doesn't seem to have been
changed much recently.


Paul Slootman

Signed-Off-By: Paul Slootman <paul@wurtel.net>

--- a/drivers/scsi/sd.c.orig	2006-07-06 20:02:28.000000000 +0000
+++ a/drivers/scsi/sd.c	2006-07-12 13:53:26.000000000 +0000
@@ -1139,8 +1139,15 @@
 	if (spintime) {
 		if (scsi_status_is_good(the_result))
 			printk("ready\n");
-		else
+		else {
 			printk("not responding...\n");
+			/*
+			 * if unit is not responding, assume there's no media
+			 * either; this prevents endless delays in reading
+			 * capacity later on (BTDT)
+			 */
+			sdkp->media_present = 0;
+		}
 	}
 }
 
