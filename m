Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268484AbTGIRiK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 13:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268485AbTGIRiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 13:38:10 -0400
Received: from imag.imag.fr ([129.88.30.1]:38571 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S268484AbTGIRiE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 13:38:04 -0400
Date: Wed, 9 Jul 2003 19:52:37 +0200
From: Jean-Luc Richier <Jean-Luc.Richier@imag.fr>
To: pekkas@netcore.fi
Cc: linux-kernel@vger.kernel.org
Subject: Bug in Linux 2.5.74 IPv6 routing
Message-ID: <20030709195237.A8550@horus.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre2us
X-MailScanner: Found to be clean
X-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a bug in IPv6 route calculation since kernel 2.5.71. It affects
all routes with prefix length != 0 (mod 8)
The bug is as follows:
do:	ip -6 route add 2000::/3 via 2001:688:121:10::1
	ip -6 route
It shows a route for ::/3, not for 2000::/3

The bug was introduced when changing function ipv6_addr_prefix to inline
status (and moving it from net/ipv6/route.c to include/net/ipv6.h).

At the same time the = and the memset in the function have been swapped.
(cf patch 1 below). With the new code, with a prefix length = 3, the
function first sets the correct value in pfx->s6_addr[0] and AFTER does a
memset(pfx->s6_addr + 0, 0, 16 - 0) which overwrites pfx->s6_addr[0].
The previous was doing the memset first.

There are 2 solutions to correct this bug:
- The first solution is to restore the order between = and memset (see patch 1).
  But I suppose that there is a reason for this swap. In fact the old code does
  not work if the 2 addr arguments are equal, the new code (corrected) works.
- So I suggest an other solution (see patch 2): if the prefix length is not
  0 mod 8, increase o, as pfx->s6_addr[o) is already set.


PATCH 1: (reverse to previous code)
--- linux-2.5.74/include/net/ipv6.h.DIST	2003-07-02 22:53:44.000000000 +0200
+++ linux-2.5.74/include/net/ipv6.h	2003-07-09 19:03:13.195128011 +0200
@@ -276,10 +276,10 @@
 	    b = plen & 0x7;
 
 	memcpy(pfx->s6_addr, addr, o);
-	if (b != 0)
-		pfx->s6_addr[o] = addr->s6_addr[o] & (0xff00 >> b);
 	if (o < 16)
 		memset(pfx->s6_addr + o, 0, 16 - o);
+	if (b != 0)
+		pfx->s6_addr[o] = addr->s6_addr[o] & (0xff00 >> b);
 }
 
 #ifndef __HAVE_ARCH_ADDR_SET

PATCH 2: avoid overwriting the set value
--- linux-2.5.74/include/net/ipv6.h.DIST	2003-07-02 22:53:44.000000000 +0200
+++ linux-2.5.74/include/net/ipv6.h	2003-07-09 18:51:25.000000000 +0200
@@ -276,8 +276,10 @@
 	    b = plen & 0x7;
 
 	memcpy(pfx->s6_addr, addr, o);
-	if (b != 0)
+	if (b != 0) {
 		pfx->s6_addr[o] = addr->s6_addr[o] & (0xff00 >> b);
+		o++;
+	}
 	if (o < 16)
 		memset(pfx->s6_addr + o, 0, 16 - o);
 }


-- 
Jean-Luc RICHIER (Jean-Luc.Richier@Imag.Fr  richier@imag.fr)
Laboratoire Logiciels, Systemes et Reseaux (LSR-IMAG)
IMAG-CAMPUS, BP 72, F-38402 St Martin d'Heres Cedex
Tel : +33 4 76 82 72 32 Fax : +33 4 76 82 72 87
