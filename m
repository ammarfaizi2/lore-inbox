Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262677AbVAJVfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262677AbVAJVfR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 16:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262645AbVAJVe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 16:34:28 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:10900 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262671AbVAJV1D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 16:27:03 -0500
Date: Mon, 10 Jan 2005 13:27:00 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: kj <kernel-janitors@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [UPDATE PATCH] cdrom/sonycd535: replace schedule_timeout() with msleep()
Message-ID: <20050110212700.GH9186@us.ibm.com>
References: <20050110164703.GD14307@nd47.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050110164703.GD14307@nd47.coderock.org>
X-Operating-System: Linux 2.6.10 (i686)
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 05:47:03PM +0100, Domen Puncer wrote:
> Patchset of 171 patches is at http://coderock.org/kj/2.6.10-bk13-kj/
> 
> Quick patch summary: about 30 new, 30 merged, 30 dropped.
> Seems like most external trees are merged in -linus, so i'll start
> (re)sending old patches.

<snip>

> msleep_interruptible-drivers_cdrom_sonycd535.patch

> msleep_interruptible-drivers_cdrom_sonycd535_2.patch

These two patches are combined in the following, please replace.

Description: Use msleep() instead of schedule_timeout() to guarantee the task
delays as expected. Although TASK_INTERRUPTIBLE is used in the original code,
the schedule_timeout() return conditions for such a state are not checked
appropriately; therefore, TASK_UNINTERRUPTIBLE should be ok (and, hence,
msleep()).

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

--- 2.6.10-v/drivers/cdrom/sonycd535.c	2004-12-24 13:35:50.000000000 -0800
+++ 2.6.10/drivers/cdrom/sonycd535.c	2005-01-06 10:18:47.000000000 -0800
@@ -129,6 +129,7 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/init.h>
+#include <linux/delay.h>
 
 #define REALLY_SLOW_IO
 #include <asm/system.h>
@@ -896,9 +897,8 @@ do_cdu535_request(request_queue_t * q)
 					}
 					if (readStatus == BAD_STATUS) {
 						/* Sleep for a while, then retry */
-						set_current_state(TASK_INTERRUPTIBLE);
 						spin_unlock_irq(&sonycd535_lock);
-						schedule_timeout(RETRY_FOR_BAD_STATUS*HZ/10);
+						msleep(RETRY_FOR_BAD_STATUS*100);
 						spin_lock_irq(&sonycd535_lock);
 					}
 #if DEBUG > 0
@@ -1478,8 +1478,7 @@ static int __init sony535_init(void)
 	/* look for the CD-ROM, follows the procedure in the DOS driver */
 	inb(select_unit_reg);
 	/* wait for 40 18 Hz ticks (reverse-engineered from DOS driver) */
-	set_current_state(TASK_INTERRUPTIBLE);
-	schedule_timeout((HZ+17)*40/18);
+	msleep(2222);
 	inb(result_reg);
 
 	outb(0, read_status_reg);	/* does a reset? */
