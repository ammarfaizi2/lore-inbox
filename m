Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262838AbSKABxz>; Thu, 31 Oct 2002 20:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265383AbSKABxy>; Thu, 31 Oct 2002 20:53:54 -0500
Received: from 653277hfc248.tampabay.rr.com ([65.32.77.248]:23559 "EHLO
	bender.davehollis.com") by vger.kernel.org with ESMTP
	id <S262838AbSKABwu>; Thu, 31 Oct 2002 20:52:50 -0500
Message-ID: <3DC1DFE4.3020309@davehollis.com>
Date: Thu, 31 Oct 2002 20:59:00 -0500
From: David T Hollis <dhollis@davehollis.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Dieter_N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
CC: Skip Ford <skip.ford@verizon.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.45 ipt_TCPMSS.c syntax error
References: <200211010227.14140.Dieter.Nuetzel@hamburg.de>
Content-Type: multipart/mixed;
 boundary="------------030005080700070805060307"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030005080700070805060307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Dieter Nützel wrote:

>make -f scripts/Makefile.build obj=sound/core/seq/oss
>  gcc -Wp,-MD,net/ipv4/netfilter/.ipt_TCPMSS.o.d -D__KERNEL__ -Iinclude -Wall 
>-Wstrict-prototypes -Wno-trigraphs -O -fomit-frame-pointer 
>-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -mcpu=k6 
>-march=i686 -malign-functions=4 -fschedule-insns2 -fexpensive-optimizations 
>-Iarch/i386/mach-generic -nostdinc -iwithprefix include -DMODULE -include 
>include/linux/modversions.h   -DKBUILD_BASENAME=ipt_TCPMSS   -c -o 
>net/ipv4/netfilter/ipt_TCPMSS.o net/ipv4/netfilter/ipt_TCPMSS.c
>net/ipv4/netfilter/ipt_TCPMSS.c: In function `ipt_tcpmss_target':
>net/ipv4/netfilter/ipt_TCPMSS.c:88: structure has no member named `pmtu'
>net/ipv4/netfilter/ipt_TCPMSS.c:91: structure has no member named `pmtu'
>net/ipv4/netfilter/ipt_TCPMSS.c:95: structure has no member named `pmtu'
>make[3]: *** [net/ipv4/netfilter/ipt_TCPMSS.o] Error 1
>make[2]: *** [net/ipv4/netfilter] Error 2
>make[1]: *** [net/ipv4] Error 2
>make: *** [net] Error 2
>
>On x86 (Athlon)
>
>-Dieter
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>
I sent up a patch on that yesterday:



--------------030005080700070805060307
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
 

--------------030005080700070805060307--

