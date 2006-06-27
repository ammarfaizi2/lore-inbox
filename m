Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161272AbWF0URS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161272AbWF0URS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 16:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161278AbWF0URR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 16:17:17 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:62848 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1161277AbWF0URO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 16:17:14 -0400
Message-Id: <20060627201451.032282000@sous-sol.org>
References: <20060627200745.771284000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 27 Jun 2006 00:00:16 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       David Miller <davem@davemloft.net>,
       =?ISO-8859-15?q?=C5=81ukasz=20Stelmach?= <stlman@poczta.fm>,
       YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
Subject: [PATCH 16/25] IPV6: Fix source address selection.
Content-Disposition: inline; filename=ipv6-fix-source-address-selection.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Łukasz Stelmach <stlman@poczta.fm>

    
Two additional labels (RFC 3484, sec. 10.3) for IPv6 addreses
are defined to make a distinction between global unicast
addresses and Unique Local Addresses (fc00::/7, RFC 4193) and
Teredo (2001::/32, RFC 4380). It is necessary to avoid attempts
of connection that would either fail (eg. fec0:: to 2001:feed::)
or be sub-optimal (2001:0:: to 2001:feed::).

Signed-off-by: Łukasz Stelmach <stlman@poczta.fm>
Signed-off-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 net/ipv6/addrconf.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- linux-2.6.17.1.orig/net/ipv6/addrconf.c
+++ linux-2.6.17.1/net/ipv6/addrconf.c
@@ -862,6 +862,8 @@ static int inline ipv6_saddr_label(const
   * 	2002::/16		2
   * 	::/96			3
   * 	::ffff:0:0/96		4
+  *	fc00::/7		5
+  * 	2001::/32		6
   */
 	if (type & IPV6_ADDR_LOOPBACK)
 		return 0;
@@ -869,8 +871,12 @@ static int inline ipv6_saddr_label(const
 		return 3;
 	else if (type & IPV6_ADDR_MAPPED)
 		return 4;
+	else if (addr->s6_addr32[0] == htonl(0x20010000))
+		return 6;
 	else if (addr->s6_addr16[0] == htons(0x2002))
 		return 2;
+	else if ((addr->s6_addr[0] & 0xfe) == 0xfc)
+		return 5;
 	return 1;
 }
 

--
