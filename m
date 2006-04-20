Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751282AbWDTFEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbWDTFEP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 01:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbWDTFEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 01:04:14 -0400
Received: from [203.2.177.25] ([203.2.177.25]:60429 "EHLO pfeiffer.tusc.com.au")
	by vger.kernel.org with ESMTP id S1751282AbWDTFEN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 01:04:13 -0400
Subject: [PATCH 1/1]x25: fix for spinlock recurse and spinlock lockup with
	timer handler in x25
From: Shaun Pereira <spereira@tusc.com.au>
Reply-To: spereira@tusc.com.au
To: Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       x25 maintainer <eis@baty.hanse.de>,
       linux-x25 <linux-x25@vger.kernel.org>,
       linux-kenel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 20 Apr 2006 15:03:23 +1000
Message-Id: <1145509403.16180.10.camel@spereira05.tusc.com.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: spereira@tusc.com.au

When the sk_timer function x25_heartbeat_expiry() is called by the kernel
in a running/terminating process, spinlock-recursion and spinlock-lockup
locks up the kernel. 
This has happened with testing on some distro's and the patch below fixed it.

Signed-off-by:Shaun Pereira <spereira@tusc.com.au>

diff -uprN -X dontdiff linux-2.6.17-rc2-vanilla/net/x25/x25_timer.c linux-2.6.17-rc2/net/x25/x25_timer.c
--- linux-2.6.17-rc2-vanilla/net/x25/x25_timer.c	2006-04-20 12:00:03.000000000 +1000
+++ linux-2.6.17-rc2/net/x25/x25_timer.c	2006-04-20 12:02:43.000000000 +1000
@@ -114,8 +114,9 @@ static void x25_heartbeat_expiry(unsigne
 			if (sock_flag(sk, SOCK_DESTROY) ||
 			    (sk->sk_state == TCP_LISTEN &&
 			     sock_flag(sk, SOCK_DEAD))) {
+				bh_unlock_sock(sk);
 				x25_destroy_socket(sk);
-				goto unlock;
+				return;
 			}
 			break;
 
@@ -128,7 +129,6 @@ static void x25_heartbeat_expiry(unsigne
 	}
 restart_heartbeat:
 	x25_start_heartbeat(sk);
-unlock:
 	bh_unlock_sock(sk);
 }
 





