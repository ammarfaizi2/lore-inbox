Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbVIXTul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbVIXTul (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 15:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbVIXTul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 15:50:41 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:24582 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750722AbVIXTul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 15:50:41 -0400
Date: Sat, 24 Sep 2005 21:47:43 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Davide Libenzi <davidel@xmailserver.org>, Andrew Morton <akpm@osdl.org>
Cc: Nishanth Aravamudan <nacc@us.ibm.com>,
       Nish Aravamudan <nish.aravamudan@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] 2.6.14-rc2-mm1: fixes for overflow in epoll()
Message-ID: <20050924194743.GD26197@alpha.home.local>
References: <Pine.LNX.4.63.0509231108140.10222@localhost.localdomain> <20050924040534.GB18716@alpha.home.local> <29495f1d05092321447417503@mail.gmail.com> <20050924061500.GA24628@alpha.home.local> <20050924171928.GF3950@us.ibm.com> <Pine.LNX.4.63.0509241120380.31327@localhost.localdomain> <20050924193839.GB26197@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050924193839.GB26197@alpha.home.local>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the potential timeout overflow in ep_poll(), tries to get
the best timeout and also removes the /1000 divide whenever possible. It
mostly ensures that timeout computation is uniform with other places in the
kernel.

This patch applies both to 2.6.14-rc2-mm1 and 2.6.14-rc2.

Please review and apply.

Signed-off-by: Willy Tarreau <willy@w.ods.org>

- Willy

diff -purN linux-2.6.14-rc2-mm1/fs/eventpoll.c linux-2.6.14-rc2-mm1-epoll/fs/eventpoll.c
--- linux-2.6.14-rc2-mm1/fs/eventpoll.c	Sat Sep 24 21:11:49 2005
+++ linux-2.6.14-rc2-mm1-epoll/fs/eventpoll.c	Sat Sep 24 21:20:10 2005
@@ -1502,12 +1502,11 @@ static int ep_poll(struct eventpoll *ep,
 	wait_queue_t wait;
 
 	/*
-	 * Calculate the timeout by checking for the "infinite" value ( -1 )
-	 * and the overflow condition. The passed timeout is in milliseconds,
-	 * that why (t * HZ) / 1000.
+	 * Calculate the timeout by checking for the "infinite" value ( < 0 )
+	 * and the overflow condition. The passed timeout is in milliseconds.
 	 */
-	jtimeout = timeout == -1 || timeout > (MAX_SCHEDULE_TIMEOUT - 1000) / HZ ?
-		MAX_SCHEDULE_TIMEOUT: (timeout * HZ + 999) / 1000;
+	jtimeout = (timeout < 0) ?
+	    MAX_SCHEDULE_TIMEOUT : msecs_to_jiffies(timeout);
 
 retry:
 	write_lock_irqsave(&ep->lock, flags);


