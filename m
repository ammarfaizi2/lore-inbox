Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273870AbRI3SDS>; Sun, 30 Sep 2001 14:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273858AbRI3SDJ>; Sun, 30 Sep 2001 14:03:09 -0400
Received: from lsmls01.we.mediaone.net ([24.130.1.20]:6124 "EHLO
	lsmls01.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S273870AbRI3SC6>; Sun, 30 Sep 2001 14:02:58 -0400
Message-ID: <3BB75EB4.3268D3FC@kegel.com>
Date: Sun, 30 Sep 2001 11:04:36 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] tcp_v4_get_port() and ephemeral ports
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm doing ftp server benchmarking, doing lots of connect()'s.
Since ports aren't supposed to be reused for 2MSL (theoretically 120 seconds),
the absolute limit on connections per second is 64K/120 = 500.
This actually could pose a problem for me.  (Yeah, 2MSL is 
set to 30 seconds in linux, so the problem isn't as severe
as the standard says, but it's still a problem.)

Using ip address aliasing seems like a way around this.
By creating 9 more aliases for eth0 should raise this limit
to 5000 connections per second, which should do nicely.

So far, I've found an implementation of getifaddrs() that makes it
easy to retrieve the list of local IP addresses, and modified my
benchmark to assign a different local ip address to each user;
the users use bind() with that address and a zero port number, 
and expect the system to assign a port.

Sadly, this doesn't have the desired effect, since 
tcp_v4_get_port() in /usr/src/linux/net/tcp_v4.c skips over
a port if there are *any* sockets on that port.

It's tempting to patch tcp_v4_get_port() to check
sk->rcv_saddr, and if it's nonzero, allow the 
same ephemeral port number to be reused on different interfaces.
Kinda like this (untested):

--- net/ipv4/tcp_ipv4.c.orig	Sun Sep 30 10:28:23 2001
+++ net/ipv4/tcp_ipv4.c	Sun Sep 30 10:52:41 2001
@@ -162,6 +162,33 @@
 	local_bh_enable();
 }
 
+/* Return nonzero if the given sock can't bind to the given port */
+static int port_used(struct tcp_bind_bucket *tb, struct sock *sk)
+{
+	struct sock *sk2;
+	int sk_reuse;
+
+	if (!tb || !tb->owners)
+		return 0;
+
+	sk2 = tb->owners;
+	sk_reuse = sk->reuse;
+	for( ; sk2 != NULL; sk2 = sk2->bind_next) {
+		if (sk != sk2 &&
+		    sk->bound_dev_if == sk2->bound_dev_if) {
+			if (!sk_reuse	||
+			    !sk2->reuse	||
+			    sk2->state == TCP_LISTEN) {
+				if (!sk2->rcv_saddr	||
+				    !sk->rcv_saddr	||
+				    (sk2->rcv_saddr == sk->rcv_saddr))
+					return 1;
+			}
+		}
+	}
+	return 0;
+}
+
 /* Obtain a reference to a local port for the given sock,
  * if snum is zero it means select any available local port.
  */
@@ -186,8 +213,10 @@
 			head = &tcp_bhash[tcp_bhashfn(rover)];
 			spin_lock(&head->lock);
 			for (tb = head->chain; tb; tb = tb->next)
-				if (tb->port == rover)
-					goto next;
+				if (tb->port == rover) {
+					if (!sk->rcv_saddr || port_used(tb, sk))
+						goto next;
+				}
 			break;
 		next:
 			spin_unlock(&head->lock);
@@ -216,25 +245,9 @@
 		if (tb->fastreuse != 0 && sk->reuse != 0 && sk->state != TCP_LISTEN) {
 			goto success;
 		} else {
-			struct sock *sk2 = tb->owners;
-			int sk_reuse = sk->reuse;
-
-			for( ; sk2 != NULL; sk2 = sk2->bind_next) {
-				if (sk != sk2 &&
-				    sk->bound_dev_if == sk2->bound_dev_if) {
-					if (!sk_reuse	||
-					    !sk2->reuse	||
-					    sk2->state == TCP_LISTEN) {
-						if (!sk2->rcv_saddr	||
-						    !sk->rcv_saddr	||
-						    (sk2->rcv_saddr == sk->rcv_saddr))
-							break;
-					}
-				}
-			}
-			/* If we found a conflict, fail. */
+			/* If we find a conflict, fail. */
 			ret = 1;
-			if (sk2 != NULL)
+			if (port_used(tb, sk))
 				goto fail_unlock;
 		}
 	}

===============

Can anyone comment on the wisdom of such a change?

Thanks,
Dan
