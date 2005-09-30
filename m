Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932545AbVI3C0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932545AbVI3C0i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 22:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932546AbVI3C0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 22:26:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41898 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932545AbVI3CZp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 22:25:45 -0400
Message-Id: <20050930022302.703836000@localhost.localdomain>
References: <20050930022016.640197000@localhost.localdomain>
Date: Thu, 29 Sep 2005 19:20:26 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       "David S. Miller" <davem@davemloft.net>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Chris Wright <chrisw@osdl.org>
Subject: [PATCH 10/10] [TCP]: Dont over-clamp window in tcp_clamp_window()
Content-Disposition: inline; filename=tcp-dont-over-clamp-window-in-tcp_clamp_window.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Handle better the case where the sender sends full sized
frames initially, then moves to a mode where it trickles
out small amounts of data at a time.

This known problem is even mentioned in the comments
above tcp_grow_window() in tcp_input.c, specifically:

..
 * The scheme does not work when sender sends good segments opening
 * window and then starts to feed us spagetti. But it should work
 * in common situations. Otherwise, we have to rely on queue collapsing.
..

When the sender gives full sized frames, the "struct sk_buff" overhead
from each packet is small.  So we'll advertize a larger window.
If the sender moves to a mode where small segments are sent, this
ratio becomes tilted to the other extreme and we start overrunning
the socket buffer space.

tcp_clamp_window() tries to address this, but it's clamping of
tp->window_clamp is a wee bit too aggressive for this particular case.

Fix confirmed by Ion Badulescu.

Signed-off-by: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---
 net/ipv4/tcp_input.c |    2 --
 1 files changed, 2 deletions(-)

Index: linux-2.6.13.y/net/ipv4/tcp_input.c
===================================================================
--- linux-2.6.13.y.orig/net/ipv4/tcp_input.c
+++ linux-2.6.13.y/net/ipv4/tcp_input.c
@@ -350,8 +350,6 @@ static void tcp_clamp_window(struct sock
 			app_win -= tp->ack.rcv_mss;
 		app_win = max(app_win, 2U*tp->advmss);
 
-		if (!ofo_win)
-			tp->window_clamp = min(tp->window_clamp, app_win);
 		tp->rcv_ssthresh = min(tp->window_clamp, 2U*tp->advmss);
 	}
 }

--
