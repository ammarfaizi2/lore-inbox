Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947553AbWLIACB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947553AbWLIACB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 19:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947541AbWLIABj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 19:01:39 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:37610 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947547AbWLIABT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 19:01:19 -0500
Message-Id: <20061209000130.257871000@sous-sol.org>
References: <20061208235751.890503000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 08 Dec 2006 15:58:12 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, David Miller <davem@davemloft.net>,
       bunk@stusta.de
Subject: [patch 21/32] IPSEC: Fix inetpeer leak in ipv4 xfrm dst entries.
Content-Disposition: inline; filename=ipsec-fix-inetpeer-leak-in-ipv4-xfrm-dst-entries.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: David Miller <davem@davemloft.net>

We grab a reference to the route's inetpeer entry but
forget to release it in xfrm4_dst_destroy().

Bug discovered by Kazunori MIYAZAWA <kazunori@miyazawa.org>

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
commit 26db167702756d0022f8ea5f1f30cad3018cfe31
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Wed Dec 6 23:45:15 2006 -0800

 net/ipv4/xfrm4_policy.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-2.6.19.orig/net/ipv4/xfrm4_policy.c
+++ linux-2.6.19/net/ipv4/xfrm4_policy.c
@@ -273,6 +273,8 @@ static void xfrm4_dst_destroy(struct dst
 
 	if (likely(xdst->u.rt.idev))
 		in_dev_put(xdst->u.rt.idev);
+	if (likely(xdst->u.rt.peer))
+		inet_putpeer(xdst->u.rt.peer);
 	xfrm_dst_destroy(xdst);
 }
 

--
