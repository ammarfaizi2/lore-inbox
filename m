Return-Path: <linux-kernel-owner+w=401wt.eu-S1755401AbXABUNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755401AbXABUNN (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 15:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755400AbXABUNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 15:13:13 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:43592 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755319AbXABUNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 15:13:10 -0500
Date: Tue, 2 Jan 2007 21:09:31 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, Paul Moore <paul.moore@hp.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [patch] selinux: fix selinux_netlbl_inode_permission() locking
Message-ID: <20070102200931.GA25789@elte.hu>
References: <20061225052124.A10323@freya> <20061224162511.eaac4a89.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061224162511.eaac4a89.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> There's a glaring bug in selinux_netlbl_inode_permission() - taking 
> lock_sock() inside rcu_read_lock().

Note that the bug is still in -rc3, and is easily triggerable via a 
default FC6 bootup. It's fixed by the (slightly modified) patch from 
Parag Warudkar below that i have in the -rt tree.

Note that this bug became visible due to the recent __resched_legal() 
fix, which bug made most of our atomicity debugging checks ineffective. 
About half a dozen separate atomicity bugs triggered in -rt when i fixed 
the __resched_legal() bug, so i'd expect some more to trigger upstream 
too.

	Ingo

------------------------>
Subject: [patch] selinux: fix selinux_netlbl_inode_permission() locking
From: Parag Warudkar <paragw@paragw.zapto.org>

do not call a sleeping lock API in an RCU read section.
lock_sock_nested can sleep, its BH counterpart doesn't. 
selinux_netlbl_inode_permission() needs to use the BH counterpart
unconditionally.

Compile tested.

From: Ingo Molnar <mingo@elte.hu>

added BH disabling, because this function can be called from non-atomic
contexts too, so a naked bh_lock_sock() would be deadlock-prone.

Boot-tested the resulting kernel.

Signed-off-by: Parag Warudkar <paragw@paragw.zapto.org>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 security/selinux/ss/services.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: linux/security/selinux/ss/services.c
===================================================================
--- linux.orig/security/selinux/ss/services.c
+++ linux/security/selinux/ss/services.c
@@ -2660,9 +2660,11 @@ int selinux_netlbl_inode_permission(stru
 		rcu_read_unlock();
 		return 0;
 	}
-	lock_sock(sock->sk);
+	local_bh_disable();
+	bh_lock_sock_nested(sock->sk);
 	rc = selinux_netlbl_socket_setsid(sock, sksec->sid);
-	release_sock(sock->sk);
+	bh_unlock_sock(sock->sk);
+	local_bh_enable();
 	rcu_read_unlock();
 
 	return rc;
