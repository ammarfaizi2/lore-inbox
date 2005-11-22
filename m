Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965191AbVKVVI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965191AbVKVVI2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 16:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965190AbVKVVH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 16:07:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32926 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965194AbVKVVHc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 16:07:32 -0500
Date: Tue, 22 Nov 2005 13:06:40 -0800
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Harald Welte <laforge@netfilter.org>,
       Rusty Rusty <rusty@rustcorp.com.au>
Subject: [patch 08/23] [PATCH] [NETFILTER] NAT: Fix module refcount dropping too far
Message-ID: <20051122210640.GI28140@shell0.pdx.osdl.net>
References: <20051122205223.099537000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="nat-fix-module-refcount-droppoing-too-far.patch"
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

The unknown protocol is used as a fallback when a protocol isn't known.
Hence we cannot handle it failing, so don't set ".me".  It's OK, since we
only grab a reference from within the same module (iptable_nat.ko), so we
never take the module refcount from 0 to 1.

Also, remove the "protocol is NULL" test: it's never NULL.

Signed-off-by: Rusty Rusty <rusty@rustcorp.com.au>
Signed-off-by: Harald Welte <laforge@netfilter.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 net/ipv4/netfilter/ip_nat_core.c          |    6 ++----
 net/ipv4/netfilter/ip_nat_proto_unknown.c |    2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

--- linux-2.6.14.2.orig/net/ipv4/netfilter/ip_nat_core.c
+++ linux-2.6.14.2/net/ipv4/netfilter/ip_nat_core.c
@@ -66,10 +66,8 @@ ip_nat_proto_find_get(u_int8_t protonum)
 	 * removed until we've grabbed the reference */
 	preempt_disable();
 	p = __ip_nat_proto_find(protonum);
-	if (p) {
-		if (!try_module_get(p->me))
-			p = &ip_nat_unknown_protocol;
-	}
+	if (!try_module_get(p->me))
+		p = &ip_nat_unknown_protocol;
 	preempt_enable();
 
 	return p;
--- linux-2.6.14.2.orig/net/ipv4/netfilter/ip_nat_proto_unknown.c
+++ linux-2.6.14.2/net/ipv4/netfilter/ip_nat_proto_unknown.c
@@ -62,7 +62,7 @@ unknown_print_range(char *buffer, const 
 
 struct ip_nat_protocol ip_nat_unknown_protocol = {
 	.name			= "unknown",
-	.me			= THIS_MODULE,
+	/* .me isn't set: getting a ref to this cannot fail. */
 	.manip_pkt		= unknown_manip_pkt,
 	.in_range		= unknown_in_range,
 	.unique_tuple		= unknown_unique_tuple,

--
