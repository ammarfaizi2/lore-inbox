Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965192AbVKVVI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965192AbVKVVI3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 16:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965189AbVKVVHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 16:07:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:27550 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965190AbVKVVHS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 16:07:18 -0500
Date: Tue, 22 Nov 2005 13:06:36 -0800
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Harald Welte <laforge@netfilter.org>
Subject: [patch 07/23] [PATCH] [NETFILTER] PPTP helper: Fix endianness bug in GRE key / CallID NAT
Message-ID: <20051122210636.GH28140@shell0.pdx.osdl.net>
References: <20051122205223.099537000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="pptp-helper-fix-endianness-bug-in-gre-key-callid-nat.patch"
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

This endianness bug slipped through while changing the 'gre.key' field in
the conntrack tuple from 32bit to 16bit.

None of my tests caught the problem, since the linux pptp client always has
'0' as call id / gre key.  Only windows clients actually trigger the bug.

Signed-off-by: Harald Welte <laforge@netfilter.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 net/ipv4/netfilter/ip_nat_proto_gre.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.14.2.orig/net/ipv4/netfilter/ip_nat_proto_gre.c
+++ linux-2.6.14.2/net/ipv4/netfilter/ip_nat_proto_gre.c
@@ -139,8 +139,8 @@ gre_manip_pkt(struct sk_buff **pskb,
 			break;
 		case GRE_VERSION_PPTP:
 			DEBUGP("call_id -> 0x%04x\n", 
-				ntohl(tuple->dst.u.gre.key));
-			pgreh->call_id = htons(ntohl(tuple->dst.u.gre.key));
+				ntohs(tuple->dst.u.gre.key));
+			pgreh->call_id = tuple->dst.u.gre.key;
 			break;
 		default:
 			DEBUGP("can't nat unknown GRE version\n");

--
