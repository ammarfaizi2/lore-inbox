Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266702AbSLPKHp>; Mon, 16 Dec 2002 05:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266665AbSLPKGq>; Mon, 16 Dec 2002 05:06:46 -0500
Received: from cmailg1.svr.pol.co.uk ([195.92.195.171]:8461 "EHLO
	cmailg1.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S266686AbSLPKGJ>; Mon, 16 Dec 2002 05:06:09 -0500
Date: Mon, 16 Dec 2002 10:14:15 +0000
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 12/19
Message-ID: <20021216101415.GM7407@reti>
References: <20021211121749.GA20782@reti> <Pine.LNX.4.44.0212151649180.2445-100000@home.transmeta.com> <20021216100457.GA7407@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021216100457.GA7407@reti>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dec_pending(): only bother spin locking if io->error is going to be
updated. [Kevin Corry]
--- diff/drivers/md/dm.c	2002-12-16 09:41:12.000000000 +0000
+++ source/drivers/md/dm.c	2002-12-16 09:41:16.000000000 +0000
@@ -238,10 +238,11 @@
 	static spinlock_t _uptodate_lock = SPIN_LOCK_UNLOCKED;
 	unsigned long flags;
 
-	spin_lock_irqsave(&_uptodate_lock, flags);
-	if (error)
+	if (error) {
+		spin_lock_irqsave(&_uptodate_lock, flags);
 		io->error = error;
-	spin_unlock_irqrestore(&_uptodate_lock, flags);
+		spin_unlock_irqrestore(&_uptodate_lock, flags);
+	}
 
 	if (atomic_dec_and_test(&io->io_count)) {
 		if (atomic_dec_and_test(&io->md->pending))
