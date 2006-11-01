Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946558AbWKAFsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946558AbWKAFsi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946538AbWKAFsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:48:15 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:29097 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946558AbWKAFsG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:48:06 -0500
Message-Id: <20061101054603.261289000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:34:39 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, David Miller <davem@davemloft.net>,
       bunk@stusta.de, James Morris <jmorris@namei.org>
Subject: [PATCH 59/61] IPV6: fix lockup via /proc/net/ip6_flowlabel [CVE-2006-5619]
Content-Disposition: inline; filename=ipv6-fix-lockup-via-proc-net-ip6_flowlabel.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: James Morris <jmorris@namei.org>

There's a bug in the seqfile handling for /proc/net/ip6_flowlabel, where, 
after finding a flowlabel, the code will loop forever not finding any 
further flowlabels, first traversing the rest of the hash bucket then just 
looping.

This patch fixes the problem by breaking after the hash bucket has been 
traversed.

Note that this bug can cause lockups and oopses, and is trivially invoked 
by an unpriveleged user.

Signed-off-by: James Morris <jmorris@namei.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 net/ipv6/ip6_flowlabel.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-2.6.18.1.orig/net/ipv6/ip6_flowlabel.c
+++ linux-2.6.18.1/net/ipv6/ip6_flowlabel.c
@@ -587,6 +587,8 @@ static struct ip6_flowlabel *ip6fl_get_n
 	while (!fl) {
 		if (++state->bucket <= FL_HASH_MASK)
 			fl = fl_ht[state->bucket];
+		else
+			break;
 	}
 	return fl;
 }

--
