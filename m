Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263221AbTJZPn2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 10:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263222AbTJZPn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 10:43:28 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:25540 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263221AbTJZPnV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 10:43:21 -0500
Date: Sun, 26 Oct 2003 16:43:13 +0100 (MET)
Message-Id: <200310261543.h9QFhDWW029273@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: netdev@oss.sgi.com
Subject: 2.6.0-test8-bk3 net/ipv4/tcp.c change broken?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 2.6.0-test8-bk3 change to delay pending signals checking in
net/ipv4/tcp.c appears to be broken.

On machine A I run X and an xterm. Within that xterm I rlogin to
machine B. On machine B I start emacs in text mode (emacs -nw).

When machine A runs 2.6.0-test8-bk2 or older, emacs works as usual:
it uses the xterm's entire size, and responds correctly and instantly
to control characters like ^S (I-search, not xoff) and ^G (Quit).

When machine A runs 2.6.0-test8-bk3 or later, emacs starts in a
tiny 24 rows by 80 columns mode, ^S incorrectly sends xoff, ^G
isn't seen by emacs until after a one second delay, and similarly
there is a one second delay between exiting emacs and getting the
next shell prompt. While running emacs, if I beat on it with ^G
and ^L it eventually (after about 5-10 seconds) goes into the
xterm's full rows/columns mode.

Reverting 2.6.0-test8-bk3's net/ipv4/tcp.c patch (included below)
fixes these problems.

/Mikael

diff -ruN linux-2.6.0-test8-bk2/net/ipv4/tcp.c linux-2.6.0-test8-bk3/net/ipv4/tcp.c
--- linux-2.6.0-test8-bk2/net/ipv4/tcp.c	2003-10-26 15:52:26.000000000 +0100
+++ linux-2.6.0-test8-bk3/net/ipv4/tcp.c	2003-10-26 15:51:58.000000000 +0100
@@ -1540,17 +1540,6 @@
 		if (copied && tp->urg_data && tp->urg_seq == *seq)
 			break;
 
-		/* We need to check signals first, to get correct SIGURG
-		 * handling. FIXME: Need to check this doesn't impact 1003.1g
-		 * and move it down to the bottom of the loop
-		 */
-		if (signal_pending(current)) {
-			if (copied)
-				break;
-			copied = timeo ? sock_intr_errno(timeo) : -EAGAIN;
-			break;
-		}
-
 		/* Next get a buffer. */
 
 		skb = skb_peek(&sk->sk_receive_queue);
@@ -1587,6 +1576,7 @@
 			    sk->sk_state == TCP_CLOSE ||
 			    (sk->sk_shutdown & RCV_SHUTDOWN) ||
 			    !timeo ||
+			    signal_pending(current) ||
 			    (flags & MSG_PEEK))
 				break;
 		} else {
@@ -1616,6 +1606,11 @@
 				copied = -EAGAIN;
 				break;
 			}
+
+			if (signal_pending(current)) {
+				copied = sock_intr_errno(timeo);
+				break;
+			}
 		}
 
 		cleanup_rbuf(sk, copied);
