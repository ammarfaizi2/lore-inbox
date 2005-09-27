Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbVI0WUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbVI0WUU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 18:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbVI0WUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 18:20:20 -0400
Received: from packet.digeo.com ([12.110.80.53]:52223 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id S1751099AbVI0WUU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 18:20:20 -0400
Message-ID: <4339C595.3080308@namesys.com>
Date: Tue, 27 Sep 2005 15:20:05 -0700
From: Nate Diller <nate@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: axboe@suse.de, akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] block cleanups: Fix iosched module refcount leak
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Sep 2005 22:20:00.0465 (UTC) FILETIME=[99AA9C10:01C5C3B1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the requested I/O scheduler is already in place, elevator_switch simply leaves the queue 
alone, and returns.  However, it forgets to call elevator_put, so

'echo [current_sched] > /sys/block/[dev]/queue/scheduler'

will leak a reference, causing the current_sched module to be permanently pinned in memory.

This patchset is against 2.6.14-rc2-mm1, but should apply to anything recent.

NATE

Signed-off-by: Nate Diller <nate@namesys.com>

--- a/drivers/block/elevator.c	2005-09-26 19:17:59.000000000 -0700
+++ b/drivers/block/elevator.c	2005-09-27 11:13:15.000000000 -0700
@@ -692,8 +692,10 @@ ssize_t elv_iosched_store(request_queue_
  		return -EINVAL;
  	}

-	if (!strcmp(elevator_name, q->elevator->elevator_type->elevator_name))
+	if (!strcmp(elevator_name, q->elevator->elevator_type->elevator_name)) {
+		elevator_put(e);
  		return count;
+	}

  	elevator_switch(q, e);
  	return count;
