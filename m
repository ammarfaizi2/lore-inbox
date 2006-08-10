Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWHJUCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWHJUCk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbWHJUC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:02:28 -0400
Received: from stinky.trash.net ([213.144.137.162]:45788 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S932161AbWHJUCF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 16:02:05 -0400
Message-ID: <44DB90BB.7050302@trash.net>
Date: Thu, 10 Aug 2006 22:02:03 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Andrew Morton <akpm@osdl.org>, davem@davemloft.net,
       Thomas Graf <tgraf@suug.ch>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: 2.6.18-rc3-mm2 - IPV6_MULTIPLE_TABLES borked....
References: <20060806030809.2cfb0b1e.akpm@osdl.org> <200608101738.k7AHcx9V004680@turing-police.cc.vt.edu>
In-Reply-To: <200608101738.k7AHcx9V004680@turing-police.cc.vt.edu>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/mixed;
 boundary="------------000109090601030905050201"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000109090601030905050201
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Valdis.Kletnieks@vt.edu wrote:
> On Sun, 06 Aug 2006 03:08:09 PDT, Andrew Morton said:
> 
>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/
> 
> 
> Building a kernel with IPV6_MULTIPLE_TABLES=y breaks my IPv6 connectivity
> quite badly.  It basically totally refuses to answer an IPv6 Neighbor Solicit
> packet or IPv6 Echo Request packet.  I run a 'tcpdump -n ipv6', and I see the
> requests come in, and no packets leaving.  Interestingly enough, if I try to
> ping6 *out* of the box, it's totally willing to send a Neighbor Solicit outbound
> (although it appears to totally ignore the Neighbor Advert packet that comes
> back). Of course, things don't work very well at all with busticated Neighbor
> Solicit.
> 
> A kernel built with IPV6_MULTIPLE_TABLES=n works just fine.

It should be fixed by this patch (already contained in net-2.6.19).



--------------000109090601030905050201
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

[IPV6]: Fix policy routing lookup

When the lookup in a table returns ip6_null_entry the policy routing lookup
returns it instead of continuing in the next table, which effectively means
it only searches the local table.

Signed-off-by: Patrick McHardy <kaber@trash.net>
Signed-off-by: David S. Miller <davem@davemloft.net>

---
commit 2b885e76c2b2c74d2dfe86a8140f0b41149f327c
tree 767711f03ea3e990ce02b3720718b77490027793
parent 5bd721a145d02a89a9b69adf3ede9d0b3647ae8b
author Patrick McHardy <kaber@trash.net> Sun, 06 Aug 2006 22:24:08 -0700
committer David S. Miller <davem@davemloft.net> Sun, 06 Aug 2006 22:24:08 -0700

 net/ipv6/fib6_rules.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/net/ipv6/fib6_rules.c b/net/ipv6/fib6_rules.c
index c3c8195..94a46ec 100644
--- a/net/ipv6/fib6_rules.c
+++ b/net/ipv6/fib6_rules.c
@@ -94,8 +94,10 @@ int fib6_rule_action(struct fib_rule *ru
 
 	if (rt != &ip6_null_entry)
 		goto out;
-
 	dst_release(&rt->u.dst);
+	rt = NULL;
+	goto out;
+
 discard_pkt:
 	dst_hold(&rt->u.dst);
 out:

--------------000109090601030905050201--
