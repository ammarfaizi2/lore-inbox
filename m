Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265085AbSKJTBv>; Sun, 10 Nov 2002 14:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265086AbSKJTBv>; Sun, 10 Nov 2002 14:01:51 -0500
Received: from eik.ii.uib.no ([129.177.16.3]:6027 "EHLO smtp.ii.uib.no")
	by vger.kernel.org with ESMTP id <S265085AbSKJTBu>;
	Sun, 10 Nov 2002 14:01:50 -0500
Date: Sun, 10 Nov 2002 20:08:34 +0100
From: Jan-Frode Myklebust <janfrode@parallab.no>
To: linux-kernel@vger.kernel.org
Message-ID: <20021110200834.A15624@ii.uib.no>
Mime-Version: 1.0
Content-Disposition: inline
Subject: 2.5.46-bk minor fix
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The current 2.5.46-bk failes to build for me. Ends up with:

 gcc -Wp,-MD,net/ipv4/netfilter/.ipt_TCPMSS.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon -Iarch/i386/mach-generic -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=ipt_TCPMSS   -c -o net/ipv4/netfilter/ipt_TCPMSS.o net/ipv4/netfilter/ipt_TCPMSS.c
 net/ipv4/netfilter/ipt_TCPMSS.c: In function `ipt_tcpmss_target':
 net/ipv4/netfilter/ipt_TCPMSS.c:95: structure has no member named
`pmtu'
 make[4]: *** [net/ipv4/netfilter/ipt_TCPMSS.o] Error 1
 make[3]: *** [net/ipv4/netfilter] Error 2
 make[2]: *** [net/ipv4] Error 2
 make[1]: *** [net] Error 2
 make: *** [modules] Error 2


The following patch seemingly fixes it, but I don't know if it's correct:


===== net/ipv4/netfilter/ipt_TCPMSS.c 1.6 vs ? (writable without lock!)  =====
--- 1.6/net/ipv4/netfilter/ipt_TCPMSS.c	Sat Nov  2 11:25:59 2002
+++ ?/net/ipv4/netfilter/ipt_TCPMSS.c	Sun Nov 10 20:04:34 2002
@@ -92,7 +92,7 @@
 			return NF_DROP; /* or IPT_CONTINUE ?? */
 		}
 
-		newmss = dst_pmtu((*pskb)->dst->pmtu) - sizeof(struct iphdr) - sizeof(struct tcphdr);
+		newmss = dst_pmtu((*pskb)->dst) - sizeof(struct iphdr) - sizeof(struct tcphdr);
 	} else
 		newmss = tcpmssinfo->mss;
 


  -jf
