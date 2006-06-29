Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751595AbWF2A4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595AbWF2A4p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 20:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751848AbWF2A4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 20:56:45 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:5345 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751595AbWF2A4o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 20:56:44 -0400
Subject: [PATCH] irda: Fix RCU lock pairing on error path
From: Josh Triplett <josht@vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Paul McKenney <paulmck@us.ibm.com>, Dipkanar Sarma <dipankar@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Samuel Ortiz <samuel@sortiz.org>
Content-Type: text/plain
Date: Wed, 28 Jun 2006 17:56:41 -0700
Message-Id: <1151542602.18723.19.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

irlan_client_discovery_indication calls rcu_read_lock and rcu_read_unlock, but
returns without unlocking in an error case.  Fix that by replacing the return
with a goto so that the rcu_read_unlock always gets executed.

Signed-off-by: Josh Triplett <josh@freedesktop.org>

---

 net/irda/irlan/irlan_client.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

e20ab96944814489277c3bfd4e69133854ab01e9
diff --git a/net/irda/irlan/irlan_client.c b/net/irda/irlan/irlan_client.c
index f8e6cb0..5ce7d2e 100644
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
+out:
 	rcu_read_unlock();
 }
 	


