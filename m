Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947524AbWLIAIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947524AbWLIAIH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 19:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947532AbWLIAHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 19:07:18 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:37515 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947535AbWLHX7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 18:59:33 -0500
Message-Id: <20061208235911.897400000@sous-sol.org>
References: <20061208235751.890503000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 08 Dec 2006 15:57:56 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, David Miller <davem@davemloft.net>,
       bunk@stusta.de, Al Viro <viro@zeniv.linux.org.uk>
Subject: [patch 05/32] EBTABLES: Deal with the worst-case behaviour in loop checks.
Content-Disposition: inline; filename=ebtables-deal-with-the-worst-case-behaviour-in-loop-checks.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Al Viro <viro@zeniv.linux.org.uk>

No need to revisit a chain we'd already finished with during
the check for current hook.  It's either instant loop (which
we'd just detected) or a duplicate work.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 net/bridge/netfilter/ebtables.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.19.orig/net/bridge/netfilter/ebtables.c
+++ linux-2.6.19/net/bridge/netfilter/ebtables.c
@@ -717,7 +717,9 @@ static int check_chainloops(struct ebt_e
 				BUGPRINT("loop\n");
 				return -1;
 			}
-			/* this can't be 0, so the above test is correct */
+			if (cl_s[i].hookmask & (1 << hooknr))
+				goto letscontinue;
+			/* this can't be 0, so the loop test is correct */
 			cl_s[i].cs.n = pos + 1;
 			pos = 0;
 			cl_s[i].cs.e = ((void *)e + e->next_offset);

--
