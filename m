Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbVA1AoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbVA1AoU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 19:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbVA1Akv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 19:40:51 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:52930
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261352AbVA1Aja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 19:39:30 -0500
Date: Thu, 27 Jan 2005 16:34:44 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Robert.Olsson@data.slu.se, akpm@osdl.org, torvalds@osdl.org,
       alexn@dsv.su.se, kas@fi.muni.cz, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: Memory leak in 2.6.11-rc1?
Message-Id: <20050127163444.1bfb673b.davem@davemloft.net>
In-Reply-To: <20050128001701.D22695@flint.arm.linux.org.uk>
References: <20050123095608.GD16648@suse.de>
	<20050123023248.263daca9.akpm@osdl.org>
	<20050123200315.A25351@flint.arm.linux.org.uk>
	<20050124114853.A16971@flint.arm.linux.org.uk>
	<20050125193207.B30094@flint.arm.linux.org.uk>
	<20050127082809.A20510@flint.arm.linux.org.uk>
	<20050127004732.5d8e3f62.akpm@osdl.org>
	<16888.58622.376497.380197@robur.slu.se>
	<20050127164918.C3036@flint.arm.linux.org.uk>
	<20050127123326.2eafab35.davem@davemloft.net>
	<20050128001701.D22695@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2005 00:17:01 +0000
Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> Yes.  Someone suggested this evening that there may have been a recent
> change to do with some IPv6 refcounting which may have caused this
> problem.  Is that something you can confirm?

Yep, it would be this change below.  Try backing it out and see
if that makes your leak go away.

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/01/14 20:41:55-08:00 herbert@gondor.apana.org.au 
#   [IPV6]: Fix locking in ip6_dst_lookup().
#   
#   The caller does not necessarily have the socket locked
#   (udpv6sendmsg() is one such case) so we have to use
#   sk_dst_check() instead of __sk_dst_check().
#   
#   Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
#   Signed-off-by: David S. Miller <davem@davemloft.net>
# 
# net/ipv6/ip6_output.c
#   2005/01/14 20:41:34-08:00 herbert@gondor.apana.org.au +3 -3
#   [IPV6]: Fix locking in ip6_dst_lookup().
#   
#   The caller does not necessarily have the socket locked
#   (udpv6sendmsg() is one such case) so we have to use
#   sk_dst_check() instead of __sk_dst_check().
#   
#   Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
#   Signed-off-by: David S. Miller <davem@davemloft.net>
# 
diff -Nru a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
--- a/net/ipv6/ip6_output.c	2005-01-27 16:07:21 -08:00
+++ b/net/ipv6/ip6_output.c	2005-01-27 16:07:21 -08:00
@@ -745,7 +745,7 @@
 	if (sk) {
 		struct ipv6_pinfo *np = inet6_sk(sk);
 	
-		*dst = __sk_dst_check(sk, np->dst_cookie);
+		*dst = sk_dst_check(sk, np->dst_cookie);
 		if (*dst) {
 			struct rt6_info *rt = (struct rt6_info*)*dst;
 	
@@ -772,9 +772,9 @@
 			     && (np->daddr_cache == NULL ||
 				 !ipv6_addr_equal(&fl->fl6_dst, np->daddr_cache)))
 			    || (fl->oif && fl->oif != (*dst)->dev->ifindex)) {
+				dst_release(*dst);
 				*dst = NULL;
-			} else
-				dst_hold(*dst);
+			}
 		}
 	}
 
