Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268177AbUIBALK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268177AbUIBALK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 20:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268190AbUIAXVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 19:21:37 -0400
Received: from baikonur.stro.at ([213.239.196.228]:55481 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S268177AbUIAXQs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 19:16:48 -0400
Subject: [patch 12/14]  message/mptscsih: replace 	schedule_timeout() with msleep()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Thu, 02 Sep 2004 01:16:44 +0200
Message-ID: <E1C2eLN-0002sn-0R@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org







I would appreciate any comments from the janitor@sternweltens list. This is one (of
many) cases where I made a decision about replacing

set_current_state(TASK_INTERRUPTIBLE);
schedule_timeout(some_time);

with

msleep(jiffies_to_msecs(some_time));

msleep() is not exactly the same as the previous code, but I only did
this replacement where I thought long delays were *desired*. If this is
not the case here, then just disregard this patch. 

Thanks,
Nish



Description: Replace schedule_timeout() with msleep() to guarantee the
task delays for the desired time.

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.9-rc1-bk7-max/drivers/message/fusion/mptscsih.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff -puN drivers/message/fusion/mptscsih.c~msleep-drivers_message_fusion_mptscsih drivers/message/fusion/mptscsih.c
--- linux-2.6.9-rc1-bk7/drivers/message/fusion/mptscsih.c~msleep-drivers_message_fusion_mptscsih	2004-09-01 19:35:24.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/drivers/message/fusion/mptscsih.c	2004-09-01 19:35:24.000000000 +0200
@@ -2623,8 +2623,7 @@ mptscsih_tm_pending_wait(MPT_SCSI_HOST *
 			break;
 		}
 		spin_unlock_irqrestore(&hd->ioc->FreeQlock, flags);
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(HZ/4);
+		msleep(250);
 	} while (--loop_count);
 
 	return status;
@@ -4788,8 +4787,7 @@ mptscsih_domainValidation(void *arg)
 			}
 			spin_unlock_irqrestore(&dvtaskQ_lock, flags);
 
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(HZ/4);
+			msleep(250);
 
 			/* DV only to SCSI adapters */
 			if ((int)ioc->chip_type <= (int)FC929)
@@ -4837,8 +4835,7 @@ mptscsih_domainValidation(void *arg)
 					hd->ioc->spi_data.dvStatus[id] |= MPT_SCSICFG_DV_PENDING;
 					hd->ioc->spi_data.dvStatus[id] &= ~MPT_SCSICFG_NEED_DV;
 
-					set_current_state(TASK_INTERRUPTIBLE);
-					schedule_timeout(HZ/4);
+					msleep(250);
 
 					/* If hidden phys disk, block IO's to all
 					 *	raid volumes

_
