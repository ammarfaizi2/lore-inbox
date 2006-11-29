Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758355AbWK2WEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758355AbWK2WEg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 17:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758303AbWK2WEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 17:04:33 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:1237 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1758295AbWK2WER
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 17:04:17 -0500
Message-Id: <20061129220554.699139000@sous-sol.org>
References: <20061129220111.137430000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 29 Nov 2006 14:00:28 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, maks@sternwelten.at,
       "Ira W. Snyder" <kernel@irasnyder.com>,
       David S Miller <davem@davemloft.net>
Subject: [patch 17/23] TG3: Add missing unlock in tg3_open() error path.
Content-Disposition: inline; filename=tg3-add-missing-unlock-in-tg3_open-error-path.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Ira W. Snyder <kernel@irasnyder.com>

Sparse noticed a locking imbalance in tg3_open(). This patch adds an
unlock to one of the error paths, so that tg3_open() always exits
without the lock held.

Signed-off-by: Ira W. Snyder <kernel@irasnyder.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 drivers/net/tg3.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.18.4.orig/drivers/net/tg3.c
+++ linux-2.6.18.4/drivers/net/tg3.c
@@ -6889,8 +6889,10 @@ static int tg3_open(struct net_device *d
 	tg3_full_lock(tp, 0);
 
 	err = tg3_set_power_state(tp, PCI_D0);
-	if (err)
+	if (err) {
+		tg3_full_unlock(tp);
 		return err;
+	}
 
 	tg3_disable_ints(tp);
 	tp->tg3_flags &= ~TG3_FLAG_INIT_COMPLETE;

--
