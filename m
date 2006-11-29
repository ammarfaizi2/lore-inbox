Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758244AbWK2WCC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758244AbWK2WCC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 17:02:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758231AbWK2WBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 17:01:40 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:46001 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1758239AbWK2WBg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 17:01:36 -0500
Message-Id: <20061129220308.793603000@sous-sol.org>
References: <20061129220111.137430000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 29 Nov 2006 14:00:13 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Patrick McHardy <kaber@trash.net>,
       davem@davemloft.net,
       =?ISO-8859-15?q?Bj=C3=B6rn=20Steinbrink?= <B.Steinbrink@gmx.de>
Subject: [patch 02/23] NETFILTER: Missing check for CAP_NET_ADMIN in iptables compat layer 
Content-Disposition: inline; filename=netfilter-missing-check-for-cap_net_admin-in-iptables-compat-layer.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Patrick McHardy <kaber@trash.net>

The 32bit compatibility layer has no CAP_NET_ADMIN check in
compat_do_ipt_get_ctl, which for example allows to list the current
iptables rules even without having that capability (the non-compat
version requires it). Other capabilities might be required to exploit
the bug (eg. CAP_NET_RAW to get the nfnetlink socket?), so a plain user
can't exploit it, but a setup actually using the posix capability system
might very well hit such a constellation of granted capabilities.

Signed-off-by: Björn Steinbrink <B.Steinbrink@gmx.de>
Signed-off-by: Patrick McHardy <kaber@trash.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
commit 4410392a8258fd972fc08a336278b14c82b2774f
tree 567261d003b2a8fb08c2d89d0d708dd06f357f49
parent b4d854665eafe32b48e0eecadb91a73f6eea0055
author Patrick McHardy <kaber@trash.net> Fri, 17 Nov 2006 06:22:07 +0100
committer Patrick McHardy <kaber@trash.net> Fri, 17 Nov 2006 06:22:07 +0100

 net/ipv4/netfilter/ip_tables.c |    3 +++
 1 file changed, 3 insertions(+)

--- linux-2.6.18.4.orig/net/ipv4/netfilter/ip_tables.c
+++ linux-2.6.18.4/net/ipv4/netfilter/ip_tables.c
@@ -1994,6 +1994,9 @@ compat_do_ipt_get_ctl(struct sock *sk, i
 {
 	int ret;
 
+	if (!capable(CAP_NET_ADMIN))
+		return -EPERM;
+
 	switch (cmd) {
 	case IPT_SO_GET_INFO:
 		ret = get_info(user, len, 1);

--
