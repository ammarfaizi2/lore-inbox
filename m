Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933103AbWF2XoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933103AbWF2XoR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 19:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933104AbWF2XoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 19:44:16 -0400
Received: from smtp1.pp.htv.fi ([213.243.153.37]:4002 "EHLO smtp1.pp.htv.fi")
	by vger.kernel.org with ESMTP id S933103AbWF2XoO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 19:44:14 -0400
Date: Fri, 30 Jun 2006 09:55:34 +0300
From: Samuel Ortiz <samuel@sortiz.org>
To: "Paul E. McKenney" <paulmck@us.ibm.com>,
       "David S. Miller" <davem@davemloft.net>,
       Josh Triplett <josht@vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, Dipkanar Sarma <dipankar@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, netdev@vger.kernel.org,
       irda-users@lists.sourceforge.net
Subject: [PATCH 1/2] [IrDA] Fix RCU lock pairing on error path
Message-ID: <20060630065534.GA4729@sortiz.org>
Reply-To: Samuel Ortiz <samuel@sortiz.org>
References: <1151542602.18723.19.camel@josh-work.beaverton.ibm.com> <20060629142741.GA1294@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060629142741.GA1294@us.ibm.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

irlan_client_discovery_indication calls rcu_read_lock and rcu_read_unlock, but
returns without unlocking in an error case.  Fix that by replacing the return
with a goto so that the rcu_read_unlock always gets executed.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
Acked-by: Paul E. McKenney <paulmck@us.ibm.com>
Signed-off-by: Samuel Ortiz samuel@sortiz.org <>
---
 net/irda/irlan/irlan_client.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/net/irda/irlan/irlan_client.c b/net/irda/irlan/irlan_client.c
index f8e6cb0..95cf123 100644
--- a/net/irda/irlan/irlan_client.c
+++ b/net/irda/irlan/irlan_client.c
@@ -173,13 +173,14 @@ void irlan_client_discovery_indication(d
 	rcu_read_lock();
 	self = irlan_get_any();
 	if (self) {
-		IRDA_ASSERT(self->magic == IRLAN_MAGIC, return;);
+		IRDA_ASSERT(self->magic == IRLAN_MAGIC, goto out;);
 
 		IRDA_DEBUG(1, "%s(), Found instance (%08x)!\n", __FUNCTION__ ,
 		      daddr);
 		
 		irlan_client_wakeup(self, saddr, daddr);
 	}
+IRDA_ASSERT_LABEL(out:)
 	rcu_read_unlock();
 }
 	
-- 
1.4.0

