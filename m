Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263438AbTIBC4z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 22:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263436AbTIBC4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 22:56:55 -0400
Received: from ns.aratech.co.kr ([61.34.11.200]:2262 "EHLO ns.aratech.co.kr")
	by vger.kernel.org with ESMTP id S263429AbTIBC4y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 22:56:54 -0400
Date: Tue, 2 Sep 2003 11:59:27 +0900
From: Tejun Huh <tejun@aratech.co.kr>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Race condition in del_timer_sync (2.5)
Message-ID: <20030902025927.GA12121@atj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello,

 This patch fixes a race between del_timer_sync and recursive timers.
Current implementation allows the value of timer->base that is used
for timer_pending test to be fetched before finishing running_timer
test, so it's possible for a recursive time to be pending after
del_timer_sync.  Adding smp_rmb before timer_pending removes the race.

 The patch is against the latest 2.5 bk tree.  Please point out if I
got something wrong.  TIA.

-- 
tejun

diff -Nru a/kernel/timer.c b/kernel/timer.c
--- a/kernel/timer.c	Tue Sep  2 11:56:58 2003
+++ b/kernel/timer.c	Tue Sep  2 11:56:58 2003
@@ -338,6 +338,7 @@
 			break;
 		}
 	}
+	smp_rmb();
 	if (timer_pending(timer))
 		goto del_again;
 
