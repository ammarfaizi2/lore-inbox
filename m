Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129026AbQJ3Wd4>; Mon, 30 Oct 2000 17:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129170AbQJ3Wdq>; Mon, 30 Oct 2000 17:33:46 -0500
Received: from smtp2.Mountain.Net ([198.77.1.5]:49867 "EHLO
	nabiki.mountain.net") by vger.kernel.org with ESMTP
	id <S129026AbQJ3Wda>; Mon, 30 Oct 2000 17:33:30 -0500
Message-ID: <39FDF518.A9F1204D@mountain.net>
Date: Mon, 30 Oct 2000 17:24:24 -0500
From: Tom Leete <tleete@mountain.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18pre13 i486)
X-Accept-Language: en-US,en-GB,en,fr,es,it,de,ru
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org, netdev <netdev@oss.sgi.com>
Subject: [PATCH] ipv4 skbuff locking scope
Content-Type: multipart/mixed;
 boundary="------------F7235E45F57BA24361EDD4C3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F7235E45F57BA24361EDD4C3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello,

This fixes tests of a socket buffer done without holding the
lock. tcp_data_wait() and wait_for_tcp_memory() both had
unguarded refs in their sleep conditionals.

Tom
--------------F7235E45F57BA24361EDD4C3
Content-Type: text/plain; charset=us-ascii;
 name="tcp.lock.scope.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tcp.lock.scope.patch"

--- linux-2.4.0-test10-pre5/net/ipv4/tcp.c~	Sun Oct 29 01:21:09 2000
+++ linux/net/ipv4/tcp.c	Mon Oct 30 16:53:19 2000
@@ -204,6 +204,9 @@
  *		Andi Kleen 	:	Make poll agree with SIGIO
  *	Salvatore Sanfilippo	:	Support SO_LINGER with linger == 1 and
  *					lingertime == 0 (RFC 793 ABORT Call)
+ *              Tom Leete       :       Fix locking scope in
+ *                                      wait_for_tcp_memory, tcp_data_wait
+ *
  *					
  *		This program is free software; you can redistribute it and/or
  *		modify it under the terms of the GNU General Public License
@@ -871,10 +874,11 @@
 			break;
 		if (sk->err)
 			break;
-		release_sock(sk);
-		if (!tcp_memory_free(sk) || vm_wait)
+		if (!tcp_memory_free(sk) || vm_wait) {
+			release_sock(sk);
 			current_timeo = schedule_timeout(current_timeo);
-		lock_sock(sk);
+			lock_sock(sk);
+		}
 		if (vm_wait) {
 			if (timeo != MAX_SCHEDULE_TIMEOUT &&
 			    (timeo -= vm_wait-current_timeo) < 0)
@@ -1273,12 +1277,12 @@
 	__set_current_state(TASK_INTERRUPTIBLE);
 
 	set_bit(SOCK_ASYNC_WAITDATA, &sk->socket->flags);
-	release_sock(sk);
 
-	if (skb_queue_empty(&sk->receive_queue))
+	if (skb_queue_empty(&sk->receive_queue)){
+		release_sock(sk);
 		timeo = schedule_timeout(timeo);
-
-	lock_sock(sk);
+		lock_sock(sk);
+	}
 	clear_bit(SOCK_ASYNC_WAITDATA, &sk->socket->flags);
 
 	remove_wait_queue(sk->sleep, &wait);

--------------F7235E45F57BA24361EDD4C3--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
