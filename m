Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280771AbRK1Viz>; Wed, 28 Nov 2001 16:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280776AbRK1Vip>; Wed, 28 Nov 2001 16:38:45 -0500
Received: from vti01.vertis.nl ([145.66.4.26]:50701 "EHLO vti01.vertis.nl")
	by vger.kernel.org with ESMTP id <S280771AbRK1Vic>;
	Wed, 28 Nov 2001 16:38:32 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Rolf Fokkens <fokkensr@linux06.vertis.nl>
To: Stephan von Krawczynski <skraw@ithnet.com>
Subject: [PATCH] vanilla 2.4.15 iptables/REDIRECT kernel oops
Date: Wed, 28 Nov 2001 22:30:20 -0800
X-Mailer: KMail [version 1.2]
In-Reply-To: <20011128165224.5f3dcd8e.skraw@ithnet.com>
In-Reply-To: <20011128165224.5f3dcd8e.skraw@ithnet.com>
Cc: linux-kernel@vger.kernel.org, netfilter-devel@lists.samba.org
MIME-Version: 1.0
Message-Id: <01112822302000.01349@home01>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 November 2001 07:52, Stephan von Krawczynski wrote:
> The safe patch would look like this:
>
...
>
> Can you check out?
>
I took your patch, and added an obvious change to ip_output.c as well. It's 
below. The patch seems to work fine on my PC, will try tomorrow on the server 
that had the problems initially.

Still don't understand why skb->sk suddenly is NULL after nf_hook_slow. Maybe 
the gurus finally pay attention to this (after all, there's a patch now!!) 
and look into this.

Rolf

diff -ruN linux/include/net/ip.h.orig linux/include/net/ip.h
--- linux/include/net/ip.h.orig  Wed Nov 28 20:40:33 2001
+++ linux/include/net/ip.h       Wed Nov 28 20:47:20 2001
@@ -181,9 +181,9 @@
 static inline
 int ip_dont_fragment(struct sock *sk, struct dst_entry *dst)
 {
-        return (sk->protinfo.af_inet.pmtudisc == IP_PMTUDISC_DO ||
-                (sk->protinfo.af_inet.pmtudisc == IP_PMTUDISC_WANT &&
-                !(dst->mxlock&(1<<RTAX_MTU))));
+        return (sk && (sk->protinfo.af_inet.pmtudisc == IP_PMTUDISC_DO ||
+                     (sk->protinfo.af_inet.pmtudisc == IP_PMTUDISC_WANT &&
+                     !(dst->mxlock&(1<<RTAX_MTU)))));
 }
 
 extern void __ip_select_ident(struct iphdr *iph, struct dst_entry *dst);
diff -ruN linux/net/ipv4/ip_output.c.orig linux/net/ipv4/ip_output.c
--- linux/net/ipv4/ip_output.c.orig      Wed Nov 28 20:51:02 2001
+++ linux/net/ipv4/ip_output.c   Wed Nov 28 20:52:31 2001
@@ -315,7 +315,9 @@
         /* Add an IP checksum. */
         ip_send_check(iph);
 
-        skb->priority = sk->priority;
+        if (sk)
+                skb->priority = sk->priority;
+
         return skb->dst->output(skb);
 
 fragment:

> Can any ip-stack guru comment?
>
> Regards,
> Stephan
>
> PS: ip_select_ident looks clean in terms of sk==NULL, BTW.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
