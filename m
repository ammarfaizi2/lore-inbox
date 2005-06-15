Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261566AbVFOU4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbVFOU4e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 16:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbVFOUzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 16:55:35 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:46535
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261566AbVFOUvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 16:51:16 -0400
Date: Wed, 15 Jun 2005 13:51:14 -0700 (PDT)
Message-Id: <20050615.135114.41634180.davem@davemloft.net>
To: cndougla@purdue.edu
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: TCP prequeue performance
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <BED5FA3B.2A0%cndougla@purdue.edu>
References: <BED5FA3B.2A0%cndougla@purdue.edu>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chase Douglas <cndougla@purdue.edu>
Date: Wed, 15 Jun 2005 15:31:07 -0500

> Note the decreases in the system and real times. These numbers are fairly
> stable through 10 consecutive benchmarks of each. If I change message sizes
> and number of connections, the difference can narrow or widen, but usually
> the non-prequeue beats the prequeue with respect to system and real time.

Please take this discussion to the networking development list,
netdev@vger.kernel.org.  It is an interesting issue, but let's discuss
it in the right place. :-)

Prequeue has many advantages, in that processes are properly charged
for TCP processing overhead, and copying to userspace happens directly
in the TCP input path.

This paces TCP senders, in that ACKs do not come back faster than the
kernel can get the process on the cpu to drain the recvmsg() queue.
ACKs sent immediately (without prequeue) give the sender the illusion
that the system can handle a higher data rate than is actually
feasible.

Unfortunately, if there are bugs or bad heuristics in the process
scheduler, this can impact TCP performance quite a bit.

Also, applications using small messages and which are sensitive to
latency can also be harmed by prequeue, that's why we have the
"tcp_low_latency" sysctl.  It actually has a slight bug, in that one
of the checks (where you placed the "if (0") was missing, which is
fixed by the patch below:

[TCP]: Fix sysctl_tcp_low_latency

When enabled, this should disable UCOPY prequeue'ing altogether,
but it does not due to a missing test.

Signed-off-by: David S. Miller <davem@davemloft.net>

--- 1/net/ipv4/tcp.c.~1~	2005-06-09 12:29:41.000000000 -0700
+++ 2/net/ipv4/tcp.c	2005-06-09 16:39:46.000000000 -0700
@@ -1345,7 +1345,7 @@
 
 		cleanup_rbuf(sk, copied);
 
-		if (tp->ucopy.task == user_recv) {
+		if (!sysctl_tcp_low_latency && tp->ucopy.task == user_recv) {
 			/* Install new reader */
 			if (!user_recv && !(flags & (MSG_TRUNC | MSG_PEEK))) {
 				user_recv = current;
