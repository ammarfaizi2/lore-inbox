Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314138AbSF2Tfp>; Sat, 29 Jun 2002 15:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314096AbSF2Tfo>; Sat, 29 Jun 2002 15:35:44 -0400
Received: from macker.loria.fr ([152.81.1.70]:39074 "EHLO macker.loria.fr")
	by vger.kernel.org with ESMTP id <S314085AbSF2Tfn>;
	Sat, 29 Jun 2002 15:35:43 -0400
X-Amavix: Anti-spam check done by SpamAssassin
X-Amavix: Anti-virus check done by McAfee
X-Amavix: Scanned by Amavix
Date: Sat, 29 Jun 2002 00:33:33 +0200 (CEST)
From: Samuel Thibault <Samuel.Thibault@ens-lyon.fr>
X-X-Sender: samy@localhost.localdomain
Reply-To: Samuel Thibault <samuel.thibault@fnac.net>
To: Alan.Cox@linux.org, <linux-net@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
Subject: recv(...,MSG_TRUNC)
In-Reply-To: <Pine.LNX.4.44.0206102330510.11239-200000@youpi>
Message-ID: <Pine.LNX.4.44.0206290031260.298-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Previous mail seemed to be garbaged by mime attachment)

Hello,

man recv says, about flags :

       MSG_TRUNC
              Return  the real length of the packet, even when it
              was longer than the passed buffer. Only  valid  for
              packet sockets.

But it is neither implemented in ipv4/udp.c, nor in ipv6/udp.c, although
it is in tcp.c, for instance !

By searching with google, I could read old manpages where it didn't exist,
but I find it very useful, especially in conjunction with MSG_PEEK, for
trying to read a packet with a little buffer, and then really get it with
an appropriate buffer.

So here's a patch which cures 2.4.18, and also works on 2.5 kernels.

Best regards,

Samuel Thibault

diff -urN linux-2.4.18/net/ipv4/udp.c linux-2.4.18-cor/net/ipv4/udp.c
--- linux-2.4.18/net/ipv4/udp.c	Mon Jun 10 23:34:59 2002
+++ linux-2.4.18-cor/net/ipv4/udp.c	Mon Jun 10 23:35:31 2002
@@ -680,7 +680,7 @@
   	}
 	if (sk->protinfo.af_inet.cmsg_flags)
 		ip_cmsg_recv(msg, skb);
-	err = copied;
+	err = (flags&MSG_TRUNC) ? skb->len - sizeof(struct udphdr) : copied;

 out_free:
   	skb_free_datagram(sk, skb);
diff -urN linux-2.4.18/net/ipv6/udp.c linux-2.4.18-cor/net/ipv6/udp.c
--- linux-2.4.18/net/ipv6/udp.c	Mon Jun 10 23:35:07 2002
+++ linux-2.4.18-cor/net/ipv6/udp.c	Mon Jun 10 23:35:36 2002
@@ -432,7 +432,7 @@
 			}
 		}
   	}
-	err = copied;
+	err = (flags&MSG_TRUNC) ? skb->len - sizeof(struct udphdr) : copied;

 out_free:
 	skb_free_datagram(sk, skb);

