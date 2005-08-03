Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262126AbVHCHCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbVHCHCG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 03:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262121AbVHCG7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 02:59:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47581 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262126AbVHCG6F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 02:58:05 -0400
Date: Tue, 2 Aug 2005 23:57:33 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Patrick McHardy <kaber@trash.net>,
       "David S. Miller" <davem@davemloft.net>
Subject: [07/13] [NETFILTER]: Fix potential memory corruption in NAT code (aka memory NAT)
Message-ID: <20050803065733.GV7762@shell0.pdx.osdl.net>
References: <20050803064439.GO7762@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050803064439.GO7762@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

[NETFILTER]: Fix potential memory corruption in NAT code (aka memory NAT)

The portptr pointing to the port in the conntrack tuple is declared static,
which could result in memory corruption when two packets of the same
protocol are NATed at the same time and one conntrack goes away.

Signed-off-by: Patrick McHardy <kaber@trash.net>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 net/ipv4/netfilter/ip_nat_proto_tcp.c |    3 ++-
 net/ipv4/netfilter/ip_nat_proto_udp.c |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

--- linux-2.6.12.3.orig/net/ipv4/netfilter/ip_nat_proto_tcp.c	2005-07-28 11:17:01.000000000 -0700
+++ linux-2.6.12.3/net/ipv4/netfilter/ip_nat_proto_tcp.c	2005-07-28 11:17:15.000000000 -0700
@@ -40,7 +40,8 @@
 		 enum ip_nat_manip_type maniptype,
 		 const struct ip_conntrack *conntrack)
 {
-	static u_int16_t port, *portptr;
+	static u_int16_t port;
+	u_int16_t *portptr;
 	unsigned int range_size, min, i;
 
 	if (maniptype == IP_NAT_MANIP_SRC)
--- linux-2.6.12.3.orig/net/ipv4/netfilter/ip_nat_proto_udp.c	2005-07-28 11:17:01.000000000 -0700
+++ linux-2.6.12.3/net/ipv4/netfilter/ip_nat_proto_udp.c	2005-07-28 11:17:15.000000000 -0700
@@ -41,7 +41,8 @@
 		 enum ip_nat_manip_type maniptype,
 		 const struct ip_conntrack *conntrack)
 {
-	static u_int16_t port, *portptr;
+	static u_int16_t port;
+	u_int16_t *portptr;
 	unsigned int range_size, min, i;
 
 	if (maniptype == IP_NAT_MANIP_SRC)
