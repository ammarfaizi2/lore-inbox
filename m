Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbWH0CtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWH0CtW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 22:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWH0CtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 22:49:22 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:9860
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751127AbWH0CtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 22:49:21 -0400
Date: Sat, 26 Aug 2006 19:49:12 -0700 (PDT)
Message-Id: <20060826.194912.45512897.davem@davemloft.net>
To: bunk@stusta.de
Cc: akpm@osdl.org, yoshfuji@linux-ipv6.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, coreteam@netfilter.org
Subject: Re: 2.6.18-rc4-mm3: NF_CONNTRACK_FTP=y compile error
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060827024219.GO4765@stusta.de>
References: <20060826160922.3324a707.akpm@osdl.org>
	<20060827024219.GO4765@stusta.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Sun, 27 Aug 2006 04:42:19 +0200

>   CC      net/netfilter/nf_conntrack_ftp.o
> /home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm3/net/netfilter/nf_conntrack_ftp.c: In function $,1rx(Bget_ipv6_addr$,1ry(B:
> /home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm3/net/netfilter/nf_conntrack_ftp.c:117: warning: implicit declaration of function $,1rx(Bin6_pton$,1ry(B
> /home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm3/net/netfilter/nf_conntrack_ftp.c:117: error: $,1rx(Bend$,1ry(B undeclared (first use in this function)
> /home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm3/net/netfilter/nf_conntrack_ftp.c:117: error: (Each undeclared identifier is reported only once
> /home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm3/net/netfilter/nf_conntrack_ftp.c:117: error: for each function it appears in.)
> make[3]: *** [net/netfilter/nf_conntrack_ftp.o] Error 1

So the one single place where we call this new in6_pton() thing,
it doesn't even compile.

Yoshifuji, what tree are you testing your builds against?  This
is the second build failure introduced by this in6_pton()
changeset.

I'm going to butcher it like this so at least it builds.

commit 32677088bc145cf7d45466e39286f1a8c7bf2d67
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Sat Aug 26 19:48:49 2006 -0700

    [NETFILTER]: Fix nf_conntrack_ftp.c build.
    
    Noticed by Adrian Bunk.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/net/netfilter/nf_conntrack_ftp.c b/net/netfilter/nf_conntrack_ftp.c
index 9dccb40..0c17a5b 100644
--- a/net/netfilter/nf_conntrack_ftp.c
+++ b/net/netfilter/nf_conntrack_ftp.c
@@ -21,6 +21,7 @@ #include <linux/netfilter.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
 #include <linux/ctype.h>
+#include <linux/inet.h>
 #include <net/checksum.h>
 #include <net/tcp.h>
 
@@ -114,7 +115,8 @@ static struct ftp_search {
 static int
 get_ipv6_addr(const char *src, size_t dlen, struct in6_addr *dst, u_int8_t term)
 {
-	int ret = in6_pton(src, min_t(size_t, dlen, 0xffff), dst, term, &end);
+	const char *end;
+	int ret = in6_pton(src, min_t(size_t, dlen, 0xffff), (u8 *)dst, term, &end);
 	if (ret > 0)
 		return (int)(end - src);
 	return 0;
