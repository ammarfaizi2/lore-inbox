Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266163AbUIJDem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266163AbUIJDem (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 23:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267793AbUIJDcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 23:32:13 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:59405 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S266163AbUIJDbO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 23:31:14 -0400
Date: Fri, 10 Sep 2004 13:30:55 +1000
To: Alex Riesen <fork0@users.sourceforge.net>,
       "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com
Subject: Re: 2.6.9-rc1+bk: assertion tcp_get_pcount failed at net/ipv4/tcp_input.c
Message-ID: <20040910033055.GA26790@gondor.apana.org.au>
References: <20040909111233.GA3987@steel.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <20040909111233.GA3987@steel.home>
User-Agent: Mutt/1.5.6+20040722i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 09, 2004 at 11:12:33AM +0000, Alex Riesen wrote:
> The box froze after being left for some time (some 10 hours) unattended.
> The only thing in I could find in logs was:
> 
> Sep  8 22:30:18 steel kernel: KERNEL: assertion ((int)tcp_get_pcount(&tp->lost_out) >= 0) failed at net/ipv4/tcp_input.c (2422)
> Sep  8 22:30:18 steel kernel: Leak l=4294967295 4

Looks like the factor isn't set early enough.  Can you please check
that you had the changeset titled

[TCP]: Make sure SKB tso factor is setup early enough.

from davem?

If you did, then please apply the following patch and tell us what
the resulting messages.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

===== include/net/tcp.h 1.87 vs edited =====
--- 1.87/include/net/tcp.h	2004-09-10 01:51:02 +10:00
+++ edited/include/net/tcp.h	2004-09-10 13:24:25 +10:00
@@ -30,6 +30,7 @@
 #include <linux/slab.h>
 #include <linux/cache.h>
 #include <linux/percpu.h>
+#include <linux/rtnetlink.h>
 #include <net/checksum.h>
 #include <net/sock.h>
 #include <net/snmp.h>
@@ -1195,6 +1196,7 @@
  */
 static inline int tcp_skb_pcount(struct sk_buff *skb)
 {
+	BUG_TRAP(TCP_SKB_CB(skb)->tso_factor);
 	return TCP_SKB_CB(skb)->tso_factor;
 }
 

--UlVJffcvxoiEqYs2--
