Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264722AbUEaSMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264722AbUEaSMG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 14:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264725AbUEaSMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 14:12:06 -0400
Received: from no-access-servers.fe.up.pt ([193.136.33.243]:32210 "EHLO
	relay2.fe.up.pt") by vger.kernel.org with ESMTP id S264722AbUEaSMC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 14:12:02 -0400
Subject: new compile problem on linux-2.4.27-pre4 and his solution
From: =?ISO-8859-1?Q?S=E9rgio?= "M. Basto" <sergiomb@netcabo.pt>
Reply-To: sergiomb@netcabo.pt
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1086027120.4097.13.camel@rh10.fe.up.pt>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 31 May 2004 19:12:00 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi this happens on pre4 and not happen on pre3

tcp_input.c: In function `tcp_rcv_space_adjust':
tcp_input.c:479: structure has no member named `sk_rcvbuf'
tcp_input.c:480: structure has no member named `sk_rcvbuf'
make[3]: *** [tcp_input.o] Error 1
make bzImage error !

find  . -exec grep "sk_rcvbuf" {} \; -print
results:
#define sk_rcvbuf rcvbuf
./include/net/sctp/compat.h
        newsk->sk_rcvbuf = oldsk->sk_rcvbuf;
./net/sctp/socket.c
        if (sk->sk_rcvbuf < SCTP_DEFAULT_MINWINDOW)
                asoc->rwnd = sk->sk_rcvbuf;
                     min_t(__u32, (asoc->base.sk->sk_rcvbuf >> 1),
asoc->pmtu)))
./net/sctp/associola.c
                        if (space > sk->sk_rcvbuf)
                                sk->sk_rcvbuf = space;
./net/ipv4/tcp_input.c

So #define sk_rcvbuf rcvbuf
and I feel free to do this and resolve the compile problem.
--- linux-2.4.27-pre4/net/ipv4/tcp_input.c.orig        2004-05-31 18:45:06.000000000 +0100
+++ linux-2.4.27-pre4/net/ipv4/tcp_input.c     2004-05-31 18:54:11.000000000 +0100
@@ -476,8 +476,8 @@
                                  16 + sizeof(struct sk_buff));
                        space *= rcvmem;
                        space = min(space, sysctl_tcp_rmem[2]);
-                       if (space > sk->sk_rcvbuf)
-                               sk->sk_rcvbuf = space;
+                       if (space > sk->rcvbuf)
+                               sk->rcvbuf = space;
                }
        }


thanks,
Sergio M. B.

