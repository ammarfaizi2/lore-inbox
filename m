Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262109AbVF0XPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbVF0XPV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 19:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbVF0XL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 19:11:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62137 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261999AbVF0XGf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 19:06:35 -0400
Date: Mon, 27 Jun 2005 16:05:12 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: akpm@osdl.org, "Theodore Ts'o" <tytso@mit.edu>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Justin Forbes <jmforbes@linuxtx.org>,
       Randy Dunlap <rdunlap@xenotime.net>, torvalds@osdl.org,
       Chuck Wolber <chuckw@quantumlinux.com>, alan@lxorguk.ukuu.org.uk,
       davem@davemloft.net
Subject: [07/07] [NETLINK]: Fix two socket hashing bugs.
Message-ID: <20050627230512.GP9046@shell0.pdx.osdl.net>
References: <20050627224651.GI9046@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050627224651.GI9046@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------


1) netlink_release() should only decrement the hash entry
   count if the socket was actually hashed.

   This was causing hash->entries to underflow, which
   resulting in all kinds of troubles.

   On 64-bit systems, this would cause the following
   conditional to erroneously trigger:

	err = -ENOMEM;
	if (BITS_PER_LONG > 32 && unlikely(hash->entries >= UINT_MAX))
		goto err;

2) netlink_autobind() needs to propagate the error return from
   netlink_insert().  Otherwise, callers will not see the error
   as they should and thus try to operate on a socket with a zero pid,
   which is very bad.

   However, it should not propagate -EBUSY.  If two threads race
   to autobind the socket, that is fine.  This is consistent with the
   autobind behavior in other protocols.

   So bug #1 above, combined with this one, resulted in hangs
   on netlink_sendmsg() calls to the rtnetlink socket.  We'd try
   to do the user sendmsg() with the socket's pid set to zero,
   later we do a socket lookup using that pid (via the value we
   stashed away in NETLINK_CB(skb).pid), but that won't give us the
   user socket, it will give us the rtnetlink socket.  So when we
   try to wake up the receive queue, we dive back into rtnetlink_rcv()
   which tries to recursively take the rtnetlink semaphore.

Thanks to Jakub Jelink for providing backtraces.  Also, thanks to
Herbert Xu for supplying debugging patches to help track this down,
and also finding a mistake in an earlier version of this fix.

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---

--- 1/net/netlink/af_netlink.c.~1~	2005-06-26 15:30:20.000000000 -0700
+++ 2/net/netlink/af_netlink.c	2005-06-26 15:30:46.000000000 -0700
@@ -315,8 +315,8 @@
 static void netlink_remove(struct sock *sk)
 {
 	netlink_table_grab();
-	nl_table[sk->sk_protocol].hash.entries--;
-	sk_del_node_init(sk);
+	if (sk_del_node_init(sk))
+		nl_table[sk->sk_protocol].hash.entries--;
 	if (nlk_sk(sk)->groups)
 		__sk_del_bind_node(sk);
 	netlink_table_ungrab();
@@ -429,7 +429,12 @@
 	err = netlink_insert(sk, pid);
 	if (err == -EADDRINUSE)
 		goto retry;
-	return 0;
+
+	/* If 2 threads race to autobind, that is fine.  */
+	if (err == -EBUSY)
+		err = 0;
+
+	return err;
 }
 
 static inline int netlink_capable(struct socket *sock, unsigned int flag) 

