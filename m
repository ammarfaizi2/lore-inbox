Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261572AbVAGTn2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbVAGTn2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 14:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbVAGTlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 14:41:22 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:29576 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261560AbVAGTkS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 14:40:18 -0500
Date: Fri, 7 Jan 2005 11:40:13 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: kj <kernel-janitors@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>
Cc: axboe@suse.de
Subject: [UPDATE PATCH] ide/ide-cd: use ssleep() instead of schedule_timeout()
Message-ID: <20050107194013.GB2924@us.ibm.com>
References: <20041225004846.GA19373@nd47.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041225004846.GA19373@nd47.coderock.org>
X-Operating-System: Linux 2.6.10 (i686)
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 25, 2004 at 01:48:46AM +0100, Domen Puncer wrote:
> Hi.
> 
> Santa brought another present :-)
> 
> I'll start mailing new patches these days, and after external trees get
> merged, I'll be bugging you with the old ones.
> 
> 
> Patchset is at http://coderock.org/kj/2.6.10-kj/

<snip>

> msleep-drivers_ide_ide-cd.patch

Please consider updating to the following patch:

Description: Uses ssleep() in place of cdrom_sleep() to guarantee the task
delays as expected. Remove cdrom_sleep() definition, as this is the only place
where it is called.

Signed-off-by: Nishanth Aravamudan


--- 2.6.10-v/drivers/ide/ide-cd.c	2004-12-24 13:34:33.000000000 -0800
+++ 2.6.10/drivers/ide/ide-cd.c	2005-01-05 14:23:05.000000000 -0800
@@ -1520,19 +1520,6 @@ static ide_startstop_t cdrom_do_packet_c
 }
 
 
-/* Sleep for TIME jiffies.
-   Not to be called from an interrupt handler. */
-static
-void cdrom_sleep (int time)
-{
-	int sleep = time;
-
-	do {
-		set_current_state(TASK_INTERRUPTIBLE);
-		sleep = schedule_timeout(sleep);
-	} while (sleep);
-}
-
 static
 int cdrom_queue_packet_command(ide_drive_t *drive, struct request *rq)
 {
@@ -1567,7 +1554,7 @@ int cdrom_queue_packet_command(ide_drive
 				/* The drive is in the process of loading
 				   a disk.  Retry, but wait a little to give
 				   the drive time to complete the load. */
-				cdrom_sleep(2 * HZ);
+				ssleep(2);
 			} else {
 				/* Otherwise, don't retry. */
 				retries = 0;
