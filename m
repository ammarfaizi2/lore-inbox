Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <154434-19608>; Mon, 25 Jan 1999 12:02:33 -0500
Received: by vger.rutgers.edu id <154040-19608>; Mon, 25 Jan 1999 11:52:45 -0500
Received: from dax.scot.redhat.com ([195.89.149.242]:1382 "EHLO dax.scot.redhat.com" ident: "sct") by vger.rutgers.edu with ESMTP id <154069-19607>; Mon, 25 Jan 1999 11:48:32 -0500
Date: Mon, 25 Jan 1999 16:55:50 GMT
Message-Id: <199901251655.QAA04607@dax.scot.redhat.com>
From: "Stephen C. Tweedie" <sct@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Heinz Mauelshagen <mauelsha@ez-darmstadt.telekom.de>
Cc: andrea@e-mind.com, linux-kernel@vger.rutgers.edu, mge@ts1.ez-darmstadt.telekom.de, Stephen Tweedie <sct@redhat.com>
Subject: Re: [patch] dynamic buffer cache hash table size
In-Reply-To: <9901222301.AA13563@mailgate99.telekom.de>
References: <Pine.LNX.3.96.990122204549.961E-100000@laser.bogus> <9901222301.AA13563@mailgate99.telekom.de>
Sender: owner-linux-kernel@vger.rutgers.edu

Hi,

On Sat, 23 Jan 1999 0:00:23 MET, Heinz Mauelshagen
<mauelsha@ez-darmstadt.telekom.de> said:

> Have to do that test run later, but have a look at the already existing
> one below.

> Ingo Molnar asked me just today for a profile.
> Most of the time is wasted in sync_buffers.

I am not surprised.  Currently we have no way to flush completed
writeback buffers off the LOCKED list and back onto the CLEAN list.
sync() is therefore wandering over clean buffers all the time.

Could you try the following patch (against 2.2.0-pre9)?  It allows both
sync and bdflush to refile such completed buffers back to the CLEAN
list.

--Stephen

----------------------------------------------------------------
--- fs/buffer.c.~1~	Wed Jan 20 13:35:22 1999
+++ fs/buffer.c	Mon Jan 25 15:39:28 1999
@@ -247,6 +248,9 @@
 				}
 				wait_on_buffer (bh);
 				goto repeat2;
+			} else {
+				refile_buffer(bh);
+				goto repeat2;
 			}
 		}
 
@@ -1752,7 +1788,7 @@
 #ifdef DEBUG
 		for(nlist = 0; nlist < NR_LIST; nlist++)
 #else
-		for(nlist = BUF_DIRTY; nlist <= BUF_DIRTY; nlist++)
+		for(nlist = BUF_LOCKED; nlist <= BUF_DIRTY; nlist++)
 #endif
 		 {
 			 ndirty = 0;
@@ -1772,6 +1808,13 @@
 					  
 					  /* Clean buffer on dirty list?  Refile it */
 					  if (nlist == BUF_DIRTY && !buffer_dirty(bh) && !buffer_locked(bh))
+					   {
+						   refile_buffer(bh);
+						   continue;
+					   }
+					  
+					  /* Unlocked buffer on locked list?  Refile it */
+					  if (nlist == BUF_LOCKED && !buffer_locked(bh))
 					   {
 						   refile_buffer(bh);
 						   continue;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
