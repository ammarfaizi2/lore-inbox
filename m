Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262420AbVAJSsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262420AbVAJSsH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 13:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbVAJSp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 13:45:27 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:13978 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262405AbVAJSXs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 13:23:48 -0500
Date: Mon, 10 Jan 2005 10:23:41 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: kj <kernel-janitors@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [UPDATE PATCH] scsi/osst: replace schedule_timeout() with msleep()
Message-ID: <20050110182341.GG3099@us.ibm.com>
References: <20050110164703.GD14307@nd47.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050110164703.GD14307@nd47.coderock.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, forgot signed-off-by line....

On Mon, Jan 10, 2005 at 05:47:03PM +0100, Domen Puncer wrote:
> Patchset of 171 patches is at http://coderock.org/kj/2.6.10-bk13-kj/
> 
> Quick patch summary: about 30 new, 30 merged, 30 dropped.
> Seems like most external trees are merged in -linus, so i'll start
> (re)sending old patches.

<snip>

> all patches:
> ------------

<snip>

> msleep-drivers_scsi_osst.patch

Consider replacing with the following patch, as signals are not dealt with in
the existing code:

Description: Use msleep() instead of schedule_timeout() to guarantee the task
delays as expected. Although TASK_INTERRUPTIBLE is used in the current code,
there is no code dealing with an early return / signals_pending().

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

--- 2.6.10-v/drivers/scsi/osst.c	2004-12-24 13:34:45.000000000 -0800
+++ 2.6.10/drivers/scsi/osst.c	2005-01-05 14:23:05.000000000 -0800
@@ -1488,8 +1488,7 @@ static int osst_reposition_and_retry(OS_
 			osst_set_frame_position(STp, aSRpnt, frame + skip, 1);
 			flag = 0;
 			attempts--;
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(HZ / 10);
+			msleep(100);
 		}
 		if (osst_get_frame_position(STp, aSRpnt) < 0) {		/* additional write error */
 #if DEBUG
@@ -1550,7 +1549,7 @@ static int osst_reposition_and_retry(OS_
 			debugging = 0;
 		}
 #endif
-		schedule_timeout(HZ / 10);
+		msleep(100);
 	}
 	printk(KERN_ERR "%s:E: Failed to find valid tape media\n", name);
 #if DEBUG
