Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292485AbSCEWfO>; Tue, 5 Mar 2002 17:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292293AbSCEWfK>; Tue, 5 Mar 2002 17:35:10 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:18381 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S292485AbSCEWee>;
	Tue, 5 Mar 2002 17:34:34 -0500
Date: Tue, 5 Mar 2002 14:34:31 -0800
To: Linus Torvalds <torvalds@transmeta.com>, irda-users@lists.sourceforge.net,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] : ir256_sock_connect_cli.diff
Message-ID: <20020305143431.C1254@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir256_sock_connect_cli.diff :
---------------------------
	o [CRITICA] Fix socket connect to remove dangerous cli()
	<Tested on SMP>


--- linux/net/irda/af_irda.d4.c	Mon Mar  4 14:54:38 2002
+++ linux/net/irda/af_irda.c	Mon Mar  4 17:07:45 2002
@@ -1022,28 +1022,26 @@ static int irda_connect(struct socket *s
 	/* Now the loop */
 	if (sk->state != TCP_ESTABLISHED && (flags & O_NONBLOCK))
 		return -EINPROGRESS;
-		
-	cli();	/* To avoid races on the sleep */
-	
-	/* A Connect Ack with Choke or timeout or failed routing will go to
-	 * closed.  */
+
+	/* Here, there is a race condition : the state may change between
+	 * our test and the sleep, via irda_connect_confirm().
+	 * The way to workaround that is to sleep with a timeout, so that
+	 * we don't sleep forever and check the state when waking up.
+	 * 50ms is plenty good enough, because the LAP is already connected.
+	 * Jean II */
 	while (sk->state == TCP_SYN_SENT) {
-		interruptible_sleep_on(sk->sleep);
+		interruptible_sleep_on_timeout(sk->sleep, HZ/20);
 		if (signal_pending(current)) {
-			sti();
 			return -ERESTARTSYS;
 		}
 	}
 	
 	if (sk->state != TCP_ESTABLISHED) {
-		sti();
 		sock->state = SS_UNCONNECTED;
 		return sock_error(sk);	/* Always set at this point */
 	}
 	
 	sock->state = SS_CONNECTED;
-	
-	sti();
 	
 	/* At this point, IrLMP has assigned our source address */
 	self->saddr = irttp_get_saddr(self->tsap);
