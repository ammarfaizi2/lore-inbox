Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266660AbSLPKFM>; Mon, 16 Dec 2002 05:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266487AbSLPKFG>; Mon, 16 Dec 2002 05:05:06 -0500
Received: from cmailg3.svr.pol.co.uk ([195.92.195.173]:21005 "EHLO
	cmailg3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S266548AbSLPKE2>; Mon, 16 Dec 2002 05:04:28 -0500
Date: Mon, 16 Dec 2002 10:12:36 +0000
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 10/19
Message-ID: <20021216101236.GK7407@reti>
References: <20021211121749.GA20782@reti> <Pine.LNX.4.44.0212151649180.2445-100000@home.transmeta.com> <20021216100457.GA7407@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021216100457.GA7407@reti>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dm_suspend(): Stop holding the read lock around the while loop that
waits for pending io to complete.
--- diff/drivers/md/dm.c	2002-12-16 09:41:03.000000000 +0000
+++ source/drivers/md/dm.c	2002-12-16 09:41:08.000000000 +0000
@@ -715,15 +715,13 @@
 	}
 
 	set_bit(DMF_BLOCK_IO, &md->flags);
+	add_wait_queue(&md->wait, &wait);
 	up_write(&md->lock);
 
 	/*
 	 * Then we wait for the already mapped ios to
 	 * complete.
 	 */
-	down_read(&md->lock);
-
-	add_wait_queue(&md->wait, &wait);
 	while (1) {
 		set_current_state(TASK_INTERRUPTIBLE);
 
@@ -734,11 +732,11 @@
 	}
 
 	current->state = TASK_RUNNING;
-	remove_wait_queue(&md->wait, &wait);
-	up_read(&md->lock);
 
-	/* set_bit is atomic */
+	down_write(&md->lock);
+	remove_wait_queue(&md->wait, &wait);
 	set_bit(DMF_SUSPENDED, &md->flags);
+	up_write(&md->lock);
 
 	return 0;
 }
