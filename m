Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269146AbUIRGer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269146AbUIRGer (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 02:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269147AbUIRGer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 02:34:47 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:23000
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S269146AbUIRGep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 02:34:45 -0400
Date: Fri, 17 Sep 2004 23:31:08 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: jonsmirl@gmail.com, david@gibson.dropbear.id.au, akpm@osdl.org,
       trivial@rustcorp.com.au, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [TRIVIAL] Fix recent bug in fib_semantics.c
Message-Id: <20040917233108.561c88d6.davem@davemloft.net>
In-Reply-To: <20040918041627.GA12356@gondor.apana.org.au>
References: <9e47339104091717215e9be08b@mail.gmail.com>
	<E1C8T4t-0006ug-00@gondolin.me.apana.org.au>
	<9e473391040917183726113e91@mail.gmail.com>
	<20040918041627.GA12356@gondor.apana.org.au>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Sep 2004 14:16:28 +1000
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> Thanks.  The following bug is probably your problem.

Good catch on this fix, but really he's hitting the
BUG_ON() in fib_sync_down()  (I hate i386 backtraces,
it's an art to decode them properly)

So if you rmmod() a device before any routes are ever
created in ipv4, this triggers.  I didn't think this
was possible, but it is.

The fix is simple enough.

===== net/ipv4/fib_semantics.c 1.16 vs edited =====
--- 1.16/net/ipv4/fib_semantics.c	2004-09-17 11:11:04 -07:00
+++ edited/net/ipv4/fib_semantics.c	2004-09-17 23:14:44 -07:00
@@ -1040,9 +1040,7 @@
 	if (force)
 		scope = -1;
 
-	BUG_ON(!fib_info_laddrhash);
-
-	if (local) {
+	if (local && fib_info_laddrhash) {
 		unsigned int hash = fib_laddr_hashfn(local);
 		struct hlist_head *head = &fib_info_laddrhash[hash];
 		struct hlist_node *node;
