Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280537AbRKSSWq>; Mon, 19 Nov 2001 13:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276424AbRKSSW0>; Mon, 19 Nov 2001 13:22:26 -0500
Received: from mons.uio.no ([129.240.130.14]:8165 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S275990AbRKSSWR>;
	Mon, 19 Nov 2001 13:22:17 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15353.19920.461805.879956@charged.uio.no>
Date: Mon, 19 Nov 2001 19:22:08 +0100
To: Birger Lammering <b.lammering@science-computing.de>
Cc: linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
Subject: more tcpdumpinfo for nfs3 problem: aix-server --- linux 2.4.15pre5 client
In-Reply-To: <15353.13652.591045.916300@stderr.science-computing.de>
In-Reply-To: <15352.56551.709659.146271@stderr.science-computing.de>
	<E165mPr-0006F5-00@the-village.bc.nu>
	<15353.13652.591045.916300@stderr.science-computing.de>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Birger Lammering <b.lammering@science-computing.de> writes:

     > 3133:3289(156) ack 514936 win 60032 16:27:26.282843 >
     > capc25.muc.799 > caes04.muc.nfs: . 514936:514936(0) ack 3289
     > win 8576 (DF)

     > from now on we get lot's of these:

     > 16:27:26.489024 > capc25.muc.576126976 > caes04.muc.nfs: 40
     > null (DF) 16:27:26.489647 < caes04.muc.nfs >
     > capc25.muc.576126976: reply ok 24 null

     > The cp command on the Linux nfs3-client side hangs and cannot
     > be killed. We get:

     > dmesg: nfs: server caes04 not responding, still trying

     > then after a while: dmesg: nfs: server caes04 OK

     > qx09820@capc25 /home/qx09820 > netstat | grep caes04 tcp 0 0
     > capc25.muc:798 caes04.muc:nfs ESTABLISHED

Ho hum... It looks to me as if the problem is that the Linux NFS
client is falling asleep before a write, and then not waking
up. That sort of points at the write_space() callback.

When the socket buffer is full, and we get an EAGAIN response to our
sendmsg() request, we normally put the request to sleep, block the
socket, and rely on write_space() to wake us up when there is enough
memory to proceed.

Assuming that this is the case, there are 2 possible causes:

   1) A bug in the IPV4 TCP layer in which we don't call write_space()
      despite having liberated enough memory to proceed.

   2) I've misunderstood the IPV4 tcp api, and so the check for
      sock_writeable() in net/sunrpc/xprt.c:tcp_write_space() is
      incorrect.

Alexey: Do you have any comments? Is it correct to check for
sock_writeable() on a TCP socket?


Birger: could you try the following patch, that simply removes the
check for sock_writeable()?

Cheers,
  Trond

--- linux-2.4.15-pre6/net/sunrpc/xprt.c.orig	Mon Oct  8 21:36:07 2001
+++ linux-2.4.15-pre6/net/sunrpc/xprt.c	Mon Nov 19 19:07:09 2001
@@ -1071,10 +1071,6 @@
 	if (xprt->shutdown)
 		return;
 
-	/* Wait until we have enough socket memory */
-	if (!sock_writeable(sk))
-		return;
-
 	if (!xprt_test_and_set_wspace(xprt)) {
 		spin_lock(&xprt->sock_lock);
 		if (xprt->snd_task && xprt->snd_task->tk_rpcwait == &xprt->sending)
