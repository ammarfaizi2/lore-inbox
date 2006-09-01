Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbWIAXKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbWIAXKP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 19:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWIAXKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 19:10:14 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:4318 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751154AbWIAXKN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 19:10:13 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.18-rc5-mm1 (IDE resume regression)
Date: Sat, 2 Sep 2006 01:13:23 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
References: <20060901015818.42767813.akpm@osdl.org>
In-Reply-To: <20060901015818.42767813.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609020113.23965.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 September 2006 10:58, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc5/2.6.18-rc5-mm1/
> 
> 
> - CONFIG_BLOCK=n is bust due to
>   writeback_congestion_end()/blk_congestion_end() snafu.  We'll fix it later.

I need the appended patch to prevent my box from crashing during suspend to
disk (in the resume-during-suspend phase).

Apparently, the pointer returned by to_ide_driver() in generic_ide_resume()
is completely bogous, although it's nonzero, and a NULL pointer dereference
occurs when drv->resume is evaluated (100% of the time on my box).

---
 drivers/ide/ide.c |    9 +--------
 1 files changed, 1 insertion(+), 8 deletions(-)

Index: linux-2.6.18-rc5-mm1/drivers/ide/ide.c
===================================================================
--- linux-2.6.18-rc5-mm1.orig/drivers/ide/ide.c
+++ linux-2.6.18-rc5-mm1/drivers/ide/ide.c
@@ -1235,11 +1235,9 @@ static int generic_ide_suspend(struct de
 static int generic_ide_resume(struct device *dev)
 {
 	ide_drive_t *drive = dev->driver_data;
-	ide_driver_t *drv = to_ide_driver(dev->driver);
 	struct request rq;
 	struct request_pm_state rqpm;
 	ide_task_t args;
-	int err;
 
 	memset(&rq, 0, sizeof(rq));
 	memset(&rqpm, 0, sizeof(rqpm));
@@ -1250,12 +1248,7 @@ static int generic_ide_resume(struct dev
 	rqpm.pm_step = ide_pm_state_start_resume;
 	rqpm.pm_state = PM_EVENT_ON;
 
-	err = ide_do_drive_cmd(drive, &rq, ide_head_wait);
-
-	if (err == 0 && drv->resume)
-		drv->resume(drive);
-
-	return err;
+	return ide_do_drive_cmd(drive, &rq, ide_head_wait);
 }
 
 int generic_ide_ioctl(ide_drive_t *drive, struct file *file, struct block_device *bdev,

-- 
VGER BF report: H 0.0771048
