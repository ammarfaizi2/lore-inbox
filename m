Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267129AbSLKMLe>; Wed, 11 Dec 2002 07:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267130AbSLKMLe>; Wed, 11 Dec 2002 07:11:34 -0500
Received: from cmailm4.svr.pol.co.uk ([195.92.193.211]:45583 "EHLO
	cmailm4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S267129AbSLKMLb>; Wed, 11 Dec 2002 07:11:31 -0500
Date: Wed, 11 Dec 2002 12:19:15 +0000
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: Kevin Corry <corryk@us.ibm.com>, Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lvm-devel@sistina.com
Subject: Re: [PATCH] dm.c  -  device-mapper I/O path fixes
Message-ID: <20021211121915.GB20782@reti>
References: <02121016034706.02220@boiler> <20021211121749.GA20782@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021211121749.GA20782@reti>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dec_pending(): only bother spin locking if io->error is going to be
updated. [Kevin Corry]

--- diff/drivers/md/dm.c	2002-12-11 12:00:29.000000000 +0000
+++ source/drivers/md/dm.c	2002-12-11 12:00:34.000000000 +0000
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
