Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263143AbSKDX7l>; Mon, 4 Nov 2002 18:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263181AbSKDX7h>; Mon, 4 Nov 2002 18:59:37 -0500
Received: from 653277hfc248.tampabay.rr.com ([65.32.77.248]:11538 "EHLO
	bender.davehollis.com") by vger.kernel.org with ESMTP
	id <S263143AbSKDX6k>; Mon, 4 Nov 2002 18:58:40 -0500
Message-ID: <3DC70B31.5090604@davehollis.com>
Date: Mon, 04 Nov 2002 19:05:05 -0500
From: David T Hollis <dhollis@davehollis.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Miquel van Smoorenburg <miquels@cistron.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.46
References: <Pine.LNX.4.44.0211041508020.1832-100000@penguin.transmeta.com> <aq71ie$vce$1@ncc1701.cistron.net>
Content-Type: multipart/mixed;
 boundary="------------030700000601060006060207"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030700000601060006060207
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Miquel van Smoorenburg wrote:

>In article <Pine.LNX.4.44.0211041508020.1832-100000@penguin.transmeta.com>,
>Linus Torvalds  <torvalds@transmeta.com> wrote:
>  
>
>>Ok, our dear master.kernel.org seems to be back from the dead, which means 
>>that I can punish it some more and upload stuff to it again. 
>>    
>>
>
>Netfilter compilation fails:
>
>net/ipv4/netfilter/ipt_TCPMSS.c: In function `ipt_tcpmss_target':
>net/ipv4/netfilter/ipt_TCPMSS.c:88: structure has no member named `pmtu'
>net/ipv4/netfilter/ipt_TCPMSS.c:91: structure has no member named `pmtu'
>net/ipv4/netfilter/ipt_TCPMSS.c:95: structure has no member named `pmtu'
>make[3]: *** [net/ipv4/netfilter/ipt_TCPMSS.o] Error 1
>make[2]: *** [net/ipv4/netfilter] Error 2
>make[1]: *** [net/ipv4] Error 2
>make: *** [net] Error 2
>
>Fortunately, reconfiguring the kernel halfway the compilation
>(turn of TCP MSS netfilter options) and resuming the compile
>actually works.
>
>Mike.
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>
There was a smattering of pmtu probs with 2.5.45 due to the use of a new 
function (dst_pmtu).  Here's a patch from 2.5.45 that will probably 
apply cleanly (haven't gotten the 2.5.46 patch yet myself) that should 
take care of it.


--------------030700000601060006060207
Content-Type: text/plain;
 name="linux-2.4.45-ipt_TCPMSS.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.4.45-ipt_TCPMSS.patch"

--- net/ipv4/netfilter/ipt_TCPMSS.c.orig	2002-10-30 22:59:53.000000000 -0500
+++ net/ipv4/netfilter/ipt_TCPMSS.c	2002-10-30 23:08:58.000000000 -0500
@@ -48,6 +48,7 @@
 	u_int16_t tcplen, newtotlen, oldval, newmss;
 	unsigned int i;
 	u_int8_t *opt;
+	struct rtable *rt;
 
 	/* raw socket (tcpdump) may have clone of incoming skb: don't
 	   disturb it --RR */
@@ -85,14 +86,16 @@
 			return NF_DROP; /* or IPT_CONTINUE ?? */
 		}
 
-		if((*pskb)->dst->pmtu <= (sizeof(struct iphdr) + sizeof(struct tcphdr))) {
+		rt = (struct rtable *)(*pskb)->dst;
+
+		if(dst_pmtu(&rt->u.dst) <= (sizeof(struct iphdr) + sizeof(struct tcphdr))) {
 			if (net_ratelimit())
 				printk(KERN_ERR
-		       			"ipt_tcpmss_target: unknown or invalid path-MTU (%d)\n", (*pskb)->dst->pmtu);
+		       			"ipt_tcpmss_target: unknown or invalid path-MTU (%d)\n", dst_pmtu(&rt->u.dst));
 			return NF_DROP; /* or IPT_CONTINUE ?? */
 		}
 
-		newmss = (*pskb)->dst->pmtu - sizeof(struct iphdr) - sizeof(struct tcphdr);
+		newmss = dst_pmtu(&rt->u.dst) - sizeof(struct iphdr) - sizeof(struct tcphdr);
 	} else
 		newmss = tcpmssinfo->mss;
 

--------------030700000601060006060207--

