Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315214AbSIAFRp>; Sun, 1 Sep 2002 01:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315265AbSIAFRo>; Sun, 1 Sep 2002 01:17:44 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3342 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315214AbSIAFRn>; Sun, 1 Sep 2002 01:17:43 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: 2.5.33-bk testing
Date: Sun, 1 Sep 2002 05:24:58 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <aks8ba$1c2$1@penguin.transmeta.com>
References: <Pine.LNX.4.44.0208312209240.1129-100000@dad.molina>
X-Trace: palladium.transmeta.com 1030857716 25348 127.0.0.1 (1 Sep 2002 05:21:56 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 1 Sep 2002 05:21:56 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.44.0208312209240.1129-100000@dad.molina>,
Thomas Molina  <tmolina@cox.net> wrote:
>
>I've beat on the floppy driver and it seems to work well.  I haven't been 
>able to make it hiccup yet.

Really? I was looking at my cleanups, and I'm fairly certain they are
buggy.  I just pushed an update to the BK tree a few minutes ago that I
think should fix it, but since I'm not a floppy user myself I can only
go by the source and trying to imagine everything that could go wrong. 

Anyway, can you please pull the floppy patch from BK or apply this patch
on top of clean 2.5.33 to see if it makes any difference? 

[ Now, in all honesty this should _only_ make a difference in case the
  floppy request queue empties and another proces comes in and adds a
  new request while the previous one is pending, so the timing for the
  bug triggering is probably fairly interesting. Which may explain why
  you find the floppy driver solid even without this.

  Alternatively, I'm just full of crap, and this "fix" is bogus. In
  either case I'd like to know about it ;]

Thanks for testing,

		Linus

----
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/31	torvalds@home.transmeta.com	1.576
# De-queue the floppy request late, so that the higher levels
# know the floppy driver is busy.
# --------------------------------------------
#
diff -Nru a/drivers/block/floppy.c b/drivers/block/floppy.c
--- a/drivers/block/floppy.c	Sat Aug 31 22:25:41 2002
+++ b/drivers/block/floppy.c	Sat Aug 31 22:25:41 2002
@@ -2299,12 +2299,11 @@
 		return;
 	add_blkdev_randomness(major(dev));
 	floppy_off(DEVICE_NR(dev));
+	blkdev_dequeue_request(req);
 	end_that_request_last(req);
 
 	/* Get the next request */
 	req = elv_next_request(QUEUE);
-	if (req)
-		blkdev_dequeue_request(req);
 	CURRENT = req;
 }
 
@@ -2939,7 +2938,6 @@
 				unlock_fdc();
 				return;
 			}
-			blkdev_dequeue_request(req);
 			CURRENT = req;
 		}
 		if (major(CURRENT->rq_dev) != MAJOR_NR)

