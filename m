Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130607AbRAGXib>; Sun, 7 Jan 2001 18:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130870AbRAGXiV>; Sun, 7 Jan 2001 18:38:21 -0500
Received: from linuxcare.com.au ([203.29.91.49]:11784 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S130607AbRAGXiN>; Sun, 7 Jan 2001 18:38:13 -0500
From: Rusty Russell <rusty@linuxcare.com.au>
To: safemode <safemode@voicenet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ip_conntrack locks up hard on 2.4.0 after about 10 hours 
In-Reply-To: Your message of "Sat, 06 Jan 2001 10:37:54 CDT."
             <3A573BD2.C7F7771F@voicenet.com> 
Date: Sun, 07 Jan 2001 22:27:29 +1100
Message-Id: <E14FDyz-0004FK-00@halfway>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3A573BD2.C7F7771F@voicenet.com> you write:
> It seems that for one reason or another, ip_conntrack totally locks (not
> removeable) after about 10 hours of continued use.  All i found were
> these messages in my dmesg output

What was the contents of /proc/net/ip_conntrack?

Being unremovable can happen if someone is holding a packet, which the
below fix (by Xuan Baldauf) will often alleviate, but connection
tracking doesn't DROP packets (NAT and packet filtering do).

Hope that helps,
Rusty.
--
http://linux.conf.au The Linux conference Australia needed.

diff -urN -I \$.*\$ -X /tmp/kerndiff.RnRDbE --minimal linux-2.4.0-test13-3/net/ipv4/ip_input.c working-2.4.0-test13-3/net/ipv4/ip_input.c
--- linux-2.4.0-test13-3/net/ipv4/ip_input.c	Tue Dec 12 14:28:06 2000
+++ working-2.4.0-test13-3/net/ipv4/ip_input.c	Mon Dec 18 17:07:06 2000
@@ -225,6 +225,13 @@
 	nf_debug_ip_local_deliver(skb);
 #endif /*CONFIG_NETFILTER_DEBUG*/
 
+#ifdef CONFIG_NETFILTER
+	/* Free reference early: we don't need it any more, and it may
+           hold ip_conntrack module loaded indefinitely. */
+	nf_conntrack_put(skb->nfct);
+	skb->nfct = NULL;
+#endif /*CONFIG_NETFILTER*/
+
         /* Point into the IP datagram, just past the header. */
         skb->h.raw = skb->nh.raw + iph->ihl*4;
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
