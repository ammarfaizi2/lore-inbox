Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268102AbTGQTfB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 15:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268736AbTGQTfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 15:35:01 -0400
Received: from mailg.telia.com ([194.22.194.26]:52974 "EHLO mailg.telia.com")
	by vger.kernel.org with ESMTP id S268102AbTGQTe7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 15:34:59 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>
Subject: Software suspend testing in 2.6.0-test1
From: Peter Osterlund <petero2@telia.com>
Date: 17 Jul 2003 21:46:32 +0200
Message-ID: <m2wueh2axz.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have done some testing of the software suspend function in
2.6.0-test1. It works mostly very well, but I have found two problems.

The first problem is that software suspend fails if a process is
stopped before you invoke suspend. (For example, by starting cat from
the shell and pressing ctrl-z.) When the processes are woken up again,
the cat process is stuck in the schedule loop in refrigerator(),
sucking up all available cpu time.

The second problem is that freeing memory seems to be much slower than
it has to be. It appears to be caused by the call to
blk_congestion_wait() in balance_pgdat(). The patch below makes page
freeing much faster, although I'm quite sure the patch is not correct.

How can we fix this properly? The disk is mostly idle during page
freeing, but it looks like blk_congestion_wait still doesn't return
until the timeout expires. I tried HZ/2 and that made the page freeing
extremely slow.

--- linux/mm/vmscan.c.old	Thu Jul 17 21:30:09 2003
+++ linux/mm/vmscan.c	Thu Jul 17 21:29:58 2003
@@ -930,7 +930,7 @@
 		}
 		if (all_zones_ok)
 			break;
-		blk_congestion_wait(WRITE, HZ/10);
+		blk_congestion_wait(WRITE, HZ/50);
 	}
 	return nr_pages - to_free;
 }

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
