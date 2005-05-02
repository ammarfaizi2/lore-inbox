Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261759AbVEBUXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbVEBUXW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 16:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbVEBUXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 16:23:21 -0400
Received: from pat.uio.no ([129.240.130.16]:171 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261765AbVEBUWF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 16:22:05 -0400
Subject: Re: [PATCH] xprt.c use after free of work_structs
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0504302142460.9467@montezuma.fsmlabs.com>
References: <Pine.LNX.4.61.0504302142460.9467@montezuma.fsmlabs.com>
Content-Type: multipart/mixed; boundary="=-1T65yhkRzWo+qjBzUq5C"
Date: Mon, 02 May 2005 16:21:54 -0400
Message-Id: <1115065314.11854.27.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.696, required 12,
	autolearn=disabled, AWL 1.30, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1T65yhkRzWo+qjBzUq5C
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

su den 01.05.2005 Klokka 00:02 (-0600) skreiv Zwane Mwaikambo:
> This bug was first observed in 2.6.11-rc1-mm2 but i couldn't find the 
> exact patch which would unmask it. The work_structs embedded in rpc_xprt 
> are freed in xprt_destroy without waiting for all scheduled work to be 
> completed, resulting in quite a kerfuffle. Since xprt->timer callback can 
> schedule new work, flush the workqueue after killing the timer.

Hi Zwane,

  Thanks, I fully agree that this is needed.

 Chuck proposed a similar patch to me a couple of days ago, however he
also pointed out that we need to call cancel_delayed_work() on
xprt->sock_connect in the same code section in order to avoid trouble
with the TCP reconnect code causing the same type of race. I've attached
his mail.

Cheers,
  Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

--=-1T65yhkRzWo+qjBzUq5C
Content-Disposition: inline
Content-Description: Vedlagt melding - [PATCH 2/2] RPC: kick off socket
	connect operations faster
Content-Type: message/rfc822

Return-Path: <cel@citi.umich.edu>
Received: from mail-imap5.uio.no ([unix socket]) by mail-imap5.uio.no
	(Cyrus v2.2.10) with LMTPA; Fri, 29 Apr 2005 21:46:09 +0200
X-Sieve: CMU Sieve 2.2
Delivery-date: Fri, 29 Apr 2005 21:46:09 +0200
Received: from mail-mx6.uio.no ([129.240.10.47]) by mail-imap5.uio.no with
	esmtp (Exim 4.43) id 1DRbRB-0001CZ-8Q for trond.myklebust@fys.uio.no; Fri,
	29 Apr 2005 21:46:09 +0200
Received: from climax.citi.umich.edu ([141.211.133.71]) by mail-mx6.uio.no
	with esmtps (TLSv1:AES256-SHA:256) (Exim 4.43) id 1DRbR7-0002vq-JL for
	trond.myklebust@fys.uio.no; Fri, 29 Apr 2005 21:46:05 +0200
Received: from climax.citi.umich.edu (localhost.localdomain [127.0.0.1]) by
	climax.citi.umich.edu (8.12.11/8.12.11) with ESMTP id j3TJk4V3009302 for
	<trond.myklebust@fys.uio.no>; Fri, 29 Apr 2005 15:46:04 -0400
Received: (from cel@localhost) by climax.citi.umich.edu
	(8.12.11/8.12.11/Submit) id j3TJk4qo009300 for trond.myklebust@fys.uio.no;
	Fri, 29 Apr 2005 15:46:04 -0400
Date: Fri, 29 Apr 2005 15:46:04 -0400
From: Chuck Lever <cel@citi.umich.edu>
Message-Id: <200504291946.j3TJk4qo009300@climax.citi.umich.edu>
To: trond.myklebust@fys.uio.no
Subject: [PATCH 2/2] RPC: kick off socket connect operations faster
X-MailScanner-Information: This message has been scanned for viruses/spam.
	Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0.001, required 12,
	autolearn=disabled, AWL 0.00)
X-Evolution-Source: imap://trondmy@imap.uio.no/
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

 Make the socket transport kick the event queue to start socket connects
 immediately.  This should improve responsiveness of applications that are
 sensitive to slow mount operations (like automounters).

 We are now also careful to cancel the connect worker before destroying
 the xprt.  This eliminates a race where xprt_destroy can finish before
 the connect worker is even allowed to run.

 Test-plan:
 Destructive testing (unplugging the network temporarily).  Connectathon
 with UDP and TCP.  Hard-code impossibly small connect timeout.

 Version: Fri, 29 Apr 2005 15:32:01 -0400
 
 Signed-off-by: Chuck Lever <cel@netapp.com>
---
 
 net/sunrpc/xprt.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletion(-)
 
 
diff -X /home/cel/src/linux/dont-diff -Naurp 10-rpc-reconnect/net/sunrpc/xprt.c 11-xprt-flush-connects/net/sunrpc/xprt.c
--- 10-rpc-reconnect/net/sunrpc/xprt.c	2005-04-29 15:18:47.677108000 -0400
+++ 11-xprt-flush-connects/net/sunrpc/xprt.c	2005-04-29 15:29:36.637250000 -0400
@@ -569,8 +569,11 @@ void xprt_connect(struct rpc_task *task)
 		if (xprt->sock != NULL)
 			schedule_delayed_work(&xprt->sock_connect,
 					RPC_REESTABLISH_TIMEOUT);
-		else
+		else {
 			schedule_work(&xprt->sock_connect);
+			if (!RPC_IS_ASYNC(task))
+				flush_scheduled_work();
+		}
 	}
 	return;
  out_write:
@@ -1666,6 +1669,10 @@ xprt_shutdown(struct rpc_xprt *xprt)
 	rpc_wake_up(&xprt->backlog);
 	wake_up(&xprt->cong_wait);
 	del_timer_sync(&xprt->timer);
+
+	/* synchronously wait for connect worker to finish */
+	cancel_delayed_work(&xprt->sock_connect);
+	flush_scheduled_work();
 }
 
 /*

--=-1T65yhkRzWo+qjBzUq5C--

