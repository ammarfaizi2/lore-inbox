Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269116AbUIREQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269116AbUIREQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 00:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269117AbUIREQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 00:16:57 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:2322 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S269116AbUIREQy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 00:16:54 -0400
Date: Sat, 18 Sep 2004 14:16:28 +1000
To: Jon Smirl <jonsmirl@gmail.com>
Cc: davem@davemloft.net, david@gibson.dropbear.id.au, akpm@osdl.org,
       trivial@rustcorp.com.au, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [TRIVIAL] Fix recent bug in fib_semantics.c
Message-ID: <20040918041627.GA12356@gondor.apana.org.au>
References: <9e47339104091717215e9be08b@mail.gmail.com> <E1C8T4t-0006ug-00@gondolin.me.apana.org.au> <9e473391040917183726113e91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <9e473391040917183726113e91@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040722i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 17, 2004 at 09:37:15PM -0400, Jon Smirl wrote:
> Call stack at failure:
> e1000_exit_module
> ...pci calls...
> e1000_remove
> unregister_netdev
> unregister_netdevice
> notifier_call_chain
> fib_netdev_event
> fib_disable_ip
> error_code

Thanks.  The following bug is probably your problem.

> Rest of the info has scrolled off the screen.

You should be able to hit Shift-PageUp to scroll up.

There is a thinko in the allocation for the devindex hash.  We're
only giving it 8 elements when it should be 1<<8 elements.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

===== net/ipv4/fib_semantics.c 1.16 vs edited =====
--- 1.16/net/ipv4/fib_semantics.c	2004-09-18 04:11:04 +10:00
+++ edited/net/ipv4/fib_semantics.c	2004-09-18 14:08:55 +10:00
@@ -52,7 +52,8 @@
 static unsigned int fib_info_cnt;
 
 #define DEVINDEX_HASHBITS 8
-static struct hlist_head fib_info_devhash[DEVINDEX_HASHBITS];
+#define DEVINDEX_HASHSIZE (1U << DEVINDEX_HASHBITS)
+static struct hlist_head fib_info_devhash[DEVINDEX_HASHSIZE];
 
 #ifdef CONFIG_IP_ROUTE_MULTIPATH
 
@@ -229,7 +230,7 @@
 
 static inline unsigned int fib_devindex_hashfn(unsigned int val)
 {
-	unsigned int mask = ((1U << DEVINDEX_HASHBITS) - 1);
+	unsigned int mask = DEVINDEX_HASHSIZE - 1;
 
 	return (val ^
 		(val >> DEVINDEX_HASHBITS) ^

--9amGYk9869ThD9tj--
