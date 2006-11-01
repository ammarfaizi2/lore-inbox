Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946535AbWKAFuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946535AbWKAFuD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946542AbWKAFnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:43:49 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:15836 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946538AbWKAFne
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:43:34 -0500
Message-Id: <20061101054231.472027000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:34:20 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Herbert Xu <herbert@gondor.apana.org.au>,
       David S Miller <davem@davemloft.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 40/61] SCTP: Always linearise packet on input
Content-Disposition: inline; filename=sctp-always-linearise-packet-on-input.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Herbert Xu <herbert@gondor.apana.org.au>

I was looking at a RHEL5 bug report involving Xen and SCTP
(https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=212550).
It turns out that SCTP wasn't written to handle skb fragments at
all.  The absence of any calls to skb_may_pull is testament to
that.

It just so happens that Xen creates fragmented packets more often
than other scenarios (header & data split when going from domU to
dom0).  That's what caused this bug to show up.

Until someone has the time sits down and audits the entire net/sctp
directory, here is a conservative and safe solution that simply
linearises all packets on input.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 net/sctp/input.c |    3 +++
 1 file changed, 3 insertions(+)

--- linux-2.6.18.1.orig/net/sctp/input.c
+++ linux-2.6.18.1/net/sctp/input.c
@@ -135,6 +135,9 @@ int sctp_rcv(struct sk_buff *skb)
 
 	SCTP_INC_STATS_BH(SCTP_MIB_INSCTPPACKS);
 
+	if (skb_linearize(skb))
+		goto discard_it;
+
 	sh = (struct sctphdr *) skb->h.raw;
 
 	/* Pull up the IP and SCTP headers. */

--
