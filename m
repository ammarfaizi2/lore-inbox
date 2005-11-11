Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbVKKNf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbVKKNf5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 08:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbVKKNf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 08:35:57 -0500
Received: from spc1-leed3-6-0-cust185.seac.broadband.ntl.com ([80.7.68.185]:8081
	"EHLO fentible.pjc.net") by vger.kernel.org with ESMTP
	id S1750753AbVKKNf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 08:35:57 -0500
Date: Fri, 11 Nov 2005 13:35:47 +0000
From: Patrick Caulfield <patrick@tykepenguin.com>
To: davem@davemloft.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] DECnet fix SIGPIPE
Message-ID: <20051111133547.GA28775@tykepenguin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes SIGIPIPE for DECnet. Currently recvmsg generates SIGPIPE
whereas sendmsg does not; for the other stacks it seems to be the other way
round!

It also fixes the bug where reading from a socket whose peer has shutdown
returned -EINVAL rather than 0.



Signed-off-by: Patrick Caulfield <patrick@tykepenguin.com>

diff --git a/net/decnet/af_decnet.c b/net/decnet/af_decnet.c
--- a/net/decnet/af_decnet.c
+++ b/net/decnet/af_decnet.c
@@ -1664,17 +1664,15 @@ static int dn_recvmsg(struct kiocb *iocb
 		goto out;
 	}
 
-	rv = dn_check_state(sk, NULL, 0, &timeo, flags);
-	if (rv)
-		goto out;
-
 	if (sk->sk_shutdown & RCV_SHUTDOWN) {
-		if (!(flags & MSG_NOSIGNAL))
-			send_sig(SIGPIPE, current, 0);
-		rv = -EPIPE;
+		rv = 0;
 		goto out;
 	}
 
+	rv = dn_check_state(sk, NULL, 0, &timeo, flags);
+	if (rv)
+		goto out;
+
 	if (flags & ~(MSG_PEEK|MSG_OOB|MSG_WAITALL|MSG_DONTWAIT|MSG_NOSIGNAL)) {
 		rv = -EOPNOTSUPP;
 		goto out;
@@ -1928,6 +1926,8 @@ static int dn_sendmsg(struct kiocb *iocb
 
 	if (sk->sk_shutdown & SEND_SHUTDOWN) {
 		err = -EPIPE;
+		if (!(flags & MSG_NOSIGNAL))
+			send_sig(SIGPIPE, current, 0);
 		goto out_err;
 	}
 

