Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751065AbVIQLJ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbVIQLJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 07:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbVIQLJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 07:09:26 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:34391 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751065AbVIQLJZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 07:09:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=pAmSj9q//gO1hYzZ+wtDcVcY6STfh904vVInkzMelIxT9fBafhy4m1p7HIS2spozTMKm/i5aOXAhGf2QnBE8nPT0+nVR7dGihcdsU04wsmapq4n6Up5DZlx3BCYYOkz+AdQQzwrzjwvBiG7K12eHyftTrDj0E7d2on6jeyxhYqs=
Date: Sat, 17 Sep 2005 15:19:45 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Jens Axboe <axboe@suse.de>
Cc: Nishanth Aravamudan <nacc@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] sonycd535: replace schedule_timeout() with msleep()
Message-ID: <20050917111944.GA2768@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nishanth Aravamudan <nacc@us.ibm.com>

Use msleep() instead of schedule_timeout() to guarantee the task
delays as expected. Although TASK_INTERRUPTIBLE is used in the
original code, schedule_timeout() return conditions for such a state
are not checked appropriately; therefore, TASK_UNINTERRUPTIBLE should
be ok (and, hence, msleep()).

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/cdrom/sonycd535.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/cdrom/sonycd535.c
+++ b/drivers/cdrom/sonycd535.c
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

