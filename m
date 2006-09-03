Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbWIBSAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWIBSAV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 14:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWIBSAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 14:00:21 -0400
Received: from smtp5.pp.htv.fi ([213.243.153.39]:55754 "EHLO smtp5.pp.htv.fi")
	by vger.kernel.org with ESMTP id S1751262AbWIBSAU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 14:00:20 -0400
Date: Sun, 3 Sep 2006 04:14:12 +0300
From: Samuel Ortiz <samuel@sortiz.org>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dag Brattli <dag@brattli.net>, irda-users@lists.sourceforge.net
Subject: Re: General protection fault with aborted ircomm FIR connection
Message-ID: <20060903011412.GA3992@sortiz.org>
Reply-To: Samuel Ortiz <samuel@sortiz.org>
References: <44F4CA96.6060607@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44F4CA96.6060607@gmx.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 30, 2006 at 01:15:34AM +0200, Carl-Daniel Hailfinger wrote:
> Hi,
> 
> first of all, no proprietary modules have ever been loaded. The "Tainted"
> refers to "SUSE unsupported" modules. Machine is a Samsung P35 laptop (x86).
> Kernel is 2.6.16.21 with SUSE patches (which don't touch IRDA afaics).
> FIR chipset is served by nsc-ircc dongle_id=0x08.
> 
> The crash happened when I used gammu to connect to my nokia mobile phone
> over /dev/ircomm0. I moved the phone out of the IR beam by accident and
> then killed gammu with Ctrl-C while it still had the connection open.
> At that moment, the kernel spewed a general protection fault on me.
I think I managed to reproduce (and maybe fix) this bug.
Could you please check if the following patch fixes it for you as it does
for me:

diff --git a/net/irda/af_irda.c b/net/irda/af_irda.c
index 17699ee..7b7cd5b 100644
--- a/net/irda/af_irda.c
+++ b/net/irda/af_irda.c
@@ -132,13 +132,14 @@ static void irda_disconnect_indication(v
 
 	/* Prevent race conditions with irda_release() and irda_shutdown() */
 	if (!sock_flag(sk, SOCK_DEAD) && sk->sk_state != TCP_CLOSE) {
+		lock_sock(sk);
 		sk->sk_state     = TCP_CLOSE;
 		sk->sk_err       = ECONNRESET;
 		sk->sk_shutdown |= SEND_SHUTDOWN;
 
 		sk->sk_state_change(sk);
-		/* Uh-oh... Should use sock_orphan ? */
-                sock_set_flag(sk, SOCK_DEAD);
+                sock_orphan(sk);
+		release_sock(sk);
 
 		/* Close our TSAP.
 		 * If we leave it open, IrLMP put it back into the list of
@@ -1212,6 +1213,7 @@ static int irda_release(struct socket *s
         if (sk == NULL)
 		return 0;
 
+	lock_sock(sk);
 	sk->sk_state       = TCP_CLOSE;
 	sk->sk_shutdown   |= SEND_SHUTDOWN;
 	sk->sk_state_change(sk);
@@ -1221,6 +1223,7 @@ static int irda_release(struct socket *s
 
 	sock_orphan(sk);
 	sock->sk   = NULL;
+	release_sock(sk);
 
 	/* Purge queues (see sock_init_data()) */
 	skb_queue_purge(&sk->sk_receive_queue);
@@ -1353,6 +1356,7 @@ static int irda_recvmsg_dgram(struct kio
 	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	IRDA_ASSERT(self != NULL, return -1;);
+	IRDA_ASSERT(!sock_error(sk), return -1;);
 
 	skb = skb_recv_datagram(sk, flags & ~MSG_DONTWAIT,
 				flags & MSG_DONTWAIT, &err);
@@ -1405,6 +1409,7 @@ static int irda_recvmsg_stream(struct ki
 	IRDA_DEBUG(3, "%s()\n", __FUNCTION__);
 
 	IRDA_ASSERT(self != NULL, return -1;);
+	IRDA_ASSERT(!sock_error(sk), return -1;);
 
 	if (sock->flags & __SO_ACCEPTCON)
 		return(-EINVAL);

-- 
VGER BF report: U 0.499581
