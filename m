Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262039AbVANXyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262039AbVANXyT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 18:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbVANXyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 18:54:19 -0500
Received: from [81.2.110.250] ([81.2.110.250]:20201 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262039AbVANXyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 18:54:06 -0500
Subject: Re: already locked by net/netrom/af_netrom.c/176
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: kevin@gw1ngl.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAUKBFAOX3R0uYt0ctsIT4Y8KAAAAQAAAArX3UysCVykSb7sy0XnIbmAEAAAAA@gw1ngl.com>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAUKBFAOX3R0uYt0ctsIT4Y8KAAAAQAAAArX3UysCVykSb7sy0XnIbmAEAAAAA@gw1ngl.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105742967.9838.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 14 Jan 2005 22:49:29 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-01-14 at 21:42, gw1ngl wrote:
> How do I fix this?
> 
> Linux gw.w1ngl.ampr.org 2.6.10RadioAX25.1-1.2005 #8 Sun Jan 2 01:23:11 PST
> 2005 i686 i686 i386 GNU/Linux

Its showing up some kind of netrom locking bug. That requires someone
actually fix NetROM for 2.6.10 I guess. (Be careful with 2.6 and AX.25
stuff the AX.25 stack in 2.6.9/10 is very badly broken at the protocol
level because someone added a nasty flexnet type hack without thinking
about real AX.25 - That mess is reverted in 2.6.9/10-ac).

The important trace is the first one

kernel: net/netrom/nr_in.c:77: spin_lock(net/core/sock.c:ca9f2860)
already
locked by net/netrom/af_netrom.c/176

We took a look twice.

When a frame arrives we follow the following path:

	nr_rx_frame
		nr_find_socket (locks it)
	nr_process_rx_frame (still locked)
	nr_state{n]_machine - bang

Please try the following. The AX.25 patch fixes the AX.25 mess by
reverting back to 2.6.8. If you are using the -ac tree you don't need
it. The netrom patch should fix the locking. I'd appreciate if you could
test that and confirm for me that the problems go away.

Alan



--- net/netrom/nr_in.c~	2005-01-14 23:49:12.758910136 +0000
+++ net/netrom/nr_in.c	2005-01-14 23:49:12.758910136 +0000
@@ -74,7 +74,6 @@
 static int nr_state1_machine(struct sock *sk, struct sk_buff *skb,
 	int frametype)
 {
-	bh_lock_sock(sk);
 	switch (frametype) {
 	case NR_CONNACK: {
 		nr_cb *nr = nr_sk(sk);
@@ -103,8 +102,6 @@
 	default:
 		break;
 	}
-	bh_unlock_sock(sk);
-
 	return 0;
 }
 
@@ -116,7 +113,6 @@
 static int nr_state2_machine(struct sock *sk, struct sk_buff *skb,
 	int frametype)
 {
-	bh_lock_sock(sk);
 	switch (frametype) {
 	case NR_CONNACK | NR_CHOKE_FLAG:
 		nr_disconnect(sk, ECONNRESET);
@@ -132,8 +128,6 @@
 	default:
 		break;
 	}
-	bh_unlock_sock(sk);
-
 	return 0;
 }
 
@@ -154,7 +148,6 @@
 	nr = skb->data[18];
 	ns = skb->data[17];
 
-	bh_lock_sock(sk);
 	switch (frametype) {
 	case NR_CONNREQ:
 		nr_write_internal(sk, NR_CONNACK);
@@ -265,12 +258,10 @@
 	default:
 		break;
 	}
-	bh_unlock_sock(sk);
-
 	return queued;
 }
 
-/* Higher level upcall for a LAPB frame */
+/* Higher level upcall for a LAPB frame - called with sk locked */
 int nr_process_rx_frame(struct sock *sk, struct sk_buff *skb)
 {
 	nr_cb *nr = nr_sk(sk);
diff -u --new-file --recursive --exclude-from /usr/src/exclude
linux.vanilla-2.6.10/net/ax25/af_ax25.c linux-2.6.10/net/ax25/af_ax25.c
--- linux.vanilla-2.6.10/net/ax25/af_ax25.c	2004-12-25
21:15:46.000000000 +0000
+++ linux-2.6.10/net/ax25/af_ax25.c	2004-12-26 22:07:44.000000000 +0000
@@ -207,8 +207,16 @@
 			continue;
 		if (s->ax25_dev == NULL)
 			continue;
-		if (ax25cmp(&s->source_addr, src_addr) == 0 &&
-		    ax25cmp(&s->dest_addr, dest_addr) == 0) {
+		if (ax25cmp(&s->source_addr, src_addr) == 0 && ax25cmp(&s->dest_addr,
dest_addr) == 0 && s->ax25_dev->dev == dev) {
+			if (digi != NULL && digi->ndigi != 0) {
+				if (s->digipeat == NULL)
+					continue;
+				if (ax25digicmp(s->digipeat, digi) != 0)
+					continue;
+			} else {
+				if (s->digipeat != NULL && s->digipeat->ndigi != 0)
+					continue;
+			}
 			ax25_cb_hold(s);
 			spin_unlock_bh(&ax25_list_lock);
 


