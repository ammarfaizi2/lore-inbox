Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261813AbVDEQtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261813AbVDEQtD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 12:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbVDEQtC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 12:49:02 -0400
Received: from mail.kroah.org ([69.55.234.183]:58777 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261813AbVDEQsg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 12:48:36 -0400
Date: Tue, 5 Apr 2005 09:47:59 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: davem@davemloft.net, shemminger@osdl.org, netdev@oss.sgi.com
Subject: [07/08] [TCP] Fix BIC congestion avoidance algorithm error
Message-ID: <20050405164758.GH17299@kroah.com>
References: <20050405164539.GA17299@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050405164539.GA17299@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------

Since BIC is the default congestion control algorithm
enabled in every 2.6.x kernel out there, fixing errors
in it becomes quite critical.

A flaw in the loss handling caused it to not perform
the binary search regimen of the BIC algorithm
properly.

The fix below from Stephen Hemminger has been heavily
verified.

[TCP]: BIC not binary searching correctly

While redoing BIC for the split up version, I discovered that the existing
2.6.11 code doesn't really do binary search. It ends up being just a slightly
modified version of Reno.  See attached graphs to see the effect over simulated
1mbit environment.

The problem is that BIC is supposed to reset the cwnd to the last loss value
rather than ssthresh when loss is detected.  The correct code (from the BIC
TCP code for Web100) is in this patch.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

--- 1.92/net/ipv4/tcp_input.c	2005-02-22 10:45:31 -08:00
+++ edited/net/ipv4/tcp_input.c	2005-03-23 10:55:18 -08:00
@@ -1653,7 +1653,10 @@
 static void tcp_undo_cwr(struct tcp_sock *tp, int undo)
 {
 	if (tp->prior_ssthresh) {
-		tp->snd_cwnd = max(tp->snd_cwnd, tp->snd_ssthresh<<1);
+		if (tcp_is_bic(tp))
+			tp->snd_cwnd = max(tp->snd_cwnd, tp->bictcp.last_max_cwnd);
+		else
+			tp->snd_cwnd = max(tp->snd_cwnd, tp->snd_ssthresh<<1);
 
 		if (undo && tp->prior_ssthresh > tp->snd_ssthresh) {
 			tp->snd_ssthresh = tp->prior_ssthresh;

