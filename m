Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262638AbVBCF0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262638AbVBCF0j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 00:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262742AbVBCF0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 00:26:39 -0500
Received: from mx1.redhat.com ([66.187.233.31]:3275 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262638AbVBCF03 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 00:26:29 -0500
Date: Thu, 3 Feb 2005 00:26:26 -0500
From: Dave Jones <davej@redhat.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: ibmveth inlining failure.
Message-ID: <20050203052626.GA10847@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yet another ppc64 build failure..
Move the function before its first usage, and the failure goes away.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.10/drivers/net/ibmveth.c~	2005-01-12 16:03:14.000000000 -0500
+++ linux-2.6.10/drivers/net/ibmveth.c	2005-01-12 16:03:37.000000000 -0500
@@ -260,6 +260,15 @@ static inline int ibmveth_is_replenishin
 		(atomic_read(&adapter->rx_buff_pool[2].available) < adapter->rx_buff_pool[2].threshold));
 }
 
+/* kick the replenish tasklet if we need replenishing and it isn't already running */
+static inline void ibmveth_schedule_replenishing(struct ibmveth_adapter *adapter)
+{
+	if(ibmveth_is_replenishing_needed(adapter) && 
+	   (atomic_dec_if_positive(&adapter->not_replenishing) == 0)) {	
+		schedule_work(&adapter->replenish_task);
+	}
+}
+
 /* replenish tasklet routine */
 static void ibmveth_replenish_task(struct ibmveth_adapter *adapter) 
 {
@@ -276,15 +285,6 @@ static void ibmveth_replenish_task(struc
 	ibmveth_schedule_replenishing(adapter);
 }
 
-/* kick the replenish tasklet if we need replenishing and it isn't already running */
-static inline void ibmveth_schedule_replenishing(struct ibmveth_adapter *adapter)
-{
-	if(ibmveth_is_replenishing_needed(adapter) && 
-	   (atomic_dec_if_positive(&adapter->not_replenishing) == 0)) {	
-		schedule_work(&adapter->replenish_task);
-	}
-}
-
 /* empty and free ana buffer pool - also used to do cleanup in error paths */
 static void ibmveth_free_buffer_pool(struct ibmveth_adapter *adapter, struct ibmveth_buff_pool *pool)
 {

