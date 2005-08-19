Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbVHSRVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbVHSRVe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 13:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbVHSRVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 13:21:34 -0400
Received: from pasta.sw.starentnetworks.com ([12.33.234.10]:34482 "EHLO
	pasta.sw.starentnetworks.com") by vger.kernel.org with ESMTP
	id S932345AbVHSRVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 13:21:33 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17158.5404.508348.433079@cortez.sw.starentnetworks.com>
Date: Fri, 19 Aug 2005 13:21:32 -0400
From: Dave Johnson <djohnson+linux-kernel@sw.starentnetworks.com>
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       davem@davemloft.net
Subject: [PATCH] negative timer loop with lots of IPv4 peers
X-Mailer: VM 7.07 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Found this bug while doing some scaling testing that created 500K inet
peers.

peer_check_expire() in net/ipv4/inetpeer.c isn't using
inet_peer_gc_mintime correctly and will end up creating an expire timer
with less than the minimum duration, and even zero/negative if enough
active peers are present.

If >65K peers, the timer will be less than inet_peer_gc_mintime, and
with >70K peers, the timer duration will reach zero and go negative.

The timer handler will continue to schedule another zero/negative
timer in a loop until peers can be aged.  This can continue for
at least a few minutes or even longer if the peers remain active due
to arriving packets while the loop is occurring.

Bug is present in both 2.4 and 2.6. Same patch will apply to both just
fine.

-- 
Dave Johnson
Starent Networks


===== net/ipv4/inetpeer.c 1.12 vs edited =====
--- 1.12/net/ipv4/inetpeer.c	2005-06-24 16:16:59 -04:00
+++ edited/net/ipv4/inetpeer.c	2005-08-19 10:34:00 -04:00
@@ -490,10 +490,13 @@
 	/* Trigger the timer after inet_peer_gc_mintime .. inet_peer_gc_maxtime
 	 * interval depending on the total number of entries (more entries,
 	 * less interval). */
-	peer_periodic_timer.expires = jiffies
-		+ inet_peer_gc_maxtime
-		- (inet_peer_gc_maxtime - inet_peer_gc_mintime) / HZ *
-			peer_total / inet_peer_threshold * HZ;
+	if (peer_total >= inet_peer_threshold)
+		peer_periodic_timer.expires = jiffies + inet_peer_gc_mintime;
+	else
+		peer_periodic_timer.expires = jiffies
+			+ inet_peer_gc_maxtime
+			- (inet_peer_gc_maxtime - inet_peer_gc_mintime) / HZ *
+				peer_total / inet_peer_threshold * HZ;
 	add_timer(&peer_periodic_timer);
 }
 

