Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbWACFrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbWACFrv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 00:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWACFrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 00:47:51 -0500
Received: from [203.2.177.25] ([203.2.177.25]:57674 "EHLO pfeiffer.tusc.com.au")
	by vger.kernel.org with ESMTP id S1751166AbWACFru (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 00:47:50 -0500
Subject: [PATCH - 2.6.14.5]x25: fix for broken x25 module
From: Shaun Pereira <spereira@tusc.com.au>
Reply-To: spereira@tusc.com.au
To: linux-kenel <linux-kernel@vger.kernel.org>
Cc: linux-x25 <linux-x25@vger.kernel.org>, x25 maintainer <eis@baty.hanse.de>,
       Andrew Morton <akpm@osdl.org>, linux netdev <netdev@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 03 Jan 2006 16:48:27 +1100
Message-Id: <1136267307.11486.44.camel@spereira05.tusc.com.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
Have included a patch fix for the x25 module in the latest stable
version of the kernel. 

Problem:
When a user-space server application calls bind on a socket, then
in kernel space this bound socket is considered 'x25-linked' and the 
SOCK_ZAPPED flag is unset.(As in x25_bind()/af_x25.c).

Now when a user-space client application attempts to connect to the
server on the listening socket, if the kernel accepts this in-coming
call, then it returns a new socket to userland and attempts to reply to
the caller.  

The reply/x25_sendmsg() will fail, because the new socket created on
call-accept has its SOCK_ZAPPED flag set by x25_make_new().
(sock_init_data() called by x25_alloc_socket() called by x25_make_new()
sets the flag to SOCK_ZAPPED)).
Fix:
Using the sock_copy_flag() routine available in sock.h fixes this. 

Tested on 32 and 64 bit kernels with x25 over tcp. 

I hope this fix can be applied to the next release of the kernel.
Many Thanks
Shaun

Signed-off-by:Shaun Pereira <pereira.shaun@gmail.com>

diff -uprN -X dontdiff linux-2.6.14.5-vanilla/net/x25/af_x25.c
linux-2.6.14.5/net/x25/af_x25.c
--- linux-2.6.14.5-vanilla/net/x25/af_x25.c 2005-12-27
11:26:33.000000000 +1100
+++ linux-2.6.14.5/net/x25/af_x25.c 2006-01-03 10:25:39.000000000 +1100
@@ -540,12 +540,7 @@ static struct sock *x25_make_new(struct 
sk->sk_state       = TCP_ESTABLISHED;
sk->sk_sleep       = osk->sk_sleep;
sk->sk_backlog_rcv = osk->sk_backlog_rcv;
-
- if (sock_flag(osk, SOCK_ZAPPED))
- sock_set_flag(sk, SOCK_ZAPPED);
- 
- if (sock_flag(osk, SOCK_DBG))
- sock_set_flag(sk, SOCK_DBG);
+ sock_copy_flags(sk, osk);

ox25 = x25_sk(osk);
x25->t21        = ox25->t21;

