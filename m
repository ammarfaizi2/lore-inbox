Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264925AbTBTHmo>; Thu, 20 Feb 2003 02:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264919AbTBTHmo>; Thu, 20 Feb 2003 02:42:44 -0500
Received: from ns.suse.de ([213.95.15.193]:35599 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S264915AbTBTHmm>;
	Thu, 20 Feb 2003 02:42:42 -0500
To: Simon Kirby <sim@netnation.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org, davem@redhat.com
Subject: Re: Longstanding networking / SMP issue? (duplextest)
References: <20030219174757.GA5373@netnation.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 20 Feb 2003 08:52:46 +0100
In-Reply-To: Simon Kirby's message of "19 Feb 2003 18:49:49 +0100"
Message-ID: <p73r8a3xub5.fsf@amdsimf.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Kirby <sim@netnation.com> writes:
> 
> Baffled by this, I did a bunch of testing and tried to narrow down which
> servers were experiencing this problem.  A sweep of some of our server
> blocks showed that only SMP boxes were having the problem; however, not
> all SMP boxes were affected.

That's probably because of the lazy ICMP socket locking used for the
ICMP socket. When an ICMP is already in process the next ICMP triggered
from a softirq (e.g. ECHO-REQUEST) is dropped  
(see net/ipv4/icmp_xmit_lock_bh())

There is also a similar problem with ICMPs getting passed to an TCP socket.
When the socket is already locked it is dropped. You can check for 
the later by looking at the LockDroppedIcmps counter in netstat -s

I guess it would be useful to cover the first drop case in that counter
too, try this untested patch and then check the counter in netstat -s.

--- linux-2.4.20/net/ipv4/icmp.c-o	2002-08-03 02:39:46.000000000 +0200
+++ linux-2.4.20/net/ipv4/icmp.c	2003-02-20 08:51:21.000000000 +0100
@@ -196,8 +196,10 @@
 static int icmp_xmit_lock_bh(void)
 {
 	if (!spin_trylock(&icmp_socket->sk->lock.slock)) {
-		if (icmp_xmit_holder == smp_processor_id())
+		if (icmp_xmit_holder == smp_processor_id()) {
+			NET_INC_STATS_BH(LockDroppedIcmps)
 			return -EAGAIN;
+		}
 		spin_lock(&icmp_socket->sk->lock.slock);
 	}
 	icmp_xmit_holder = smp_processor_id();



-Andi

