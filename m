Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030430AbWGMWPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030430AbWGMWPS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 18:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030431AbWGMWPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 18:15:17 -0400
Received: from mx1.suse.de ([195.135.220.2]:43980 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030430AbWGMWOy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 18:14:54 -0400
Date: Thu, 13 Jul 2006 15:10:30 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       aukasz Stelmach <stlman@poczta.fm>,
       YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>,
       "David S. Miller" <davem@davemloft.net>,
       Chris Wright <chrisw@sous-sol.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 1/3] IPV6: Fix source address selection.
Message-ID: <20060713221030.GB13275@kroah.com>
References: <20060713220455.715461301@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="ipv6-fix-source-address-selection.patch"
In-Reply-To: <20060713221008.GA13275@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

From: aukasz Stelmach <stlman@poczta.fm>
    
Two additional labels (RFC 3484, sec. 10.3) for IPv6 addreses
are defined to make a distinction between global unicast
addresses and Unique Local Addresses (fc00::/7, RFC 4193) and
Teredo (2001::/32, RFC 4380). It is necessary to avoid attempts
of connection that would either fail (eg. fec0:: to 2001:feed::)
or be sub-optimal (2001:0:: to 2001:feed::).

Signed-off-by: aukasz Stelmach <stlman@poczta.fm>
Signed-off-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 net/ipv6/addrconf.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- linux-2.6.16.22.orig/net/ipv6/addrconf.c
+++ linux-2.6.16.22/net/ipv6/addrconf.c
@@ -852,6 +852,8 @@ static int inline ipv6_saddr_label(const
   * 	2002::/16		2
   * 	::/96			3
   * 	::ffff:0:0/96		4
+  *	fc00::/7		5
+  * 	2001::/32		6
   */
 	if (type & IPV6_ADDR_LOOPBACK)
 		return 0;
@@ -859,8 +861,12 @@ static int inline ipv6_saddr_label(const
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
