Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947533AbWLIAGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947533AbWLIAGp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 19:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947532AbWLHX7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 18:59:33 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:37471 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947533AbWLHX7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 18:59:12 -0500
Message-Id: <20061209000056.481276000@sous-sol.org>
References: <20061208235751.890503000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 08 Dec 2006 15:58:07 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       Roland Dreier <rolandd@cisco.com>, Sean Hefty <sean.hefty@intel.com>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Michael S Tsirkin <mst@mellanox.co.il>
Subject: [patch 16/32] IB/ucm: Fix deadlock in cleanup
Content-Disposition: inline; filename=ib-ucm-fix-deadlock-in-cleanup.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Michael S Tsirkin <mst@mellanox.co.il>

ib_ucm_cleanup_events() holds file_mutex while calling ib_destroy_cm_id().
This can deadlock since ib_destroy_cm_id() flushes event handlers, and
ib_ucm_event_handler() needs file_mutex, too.  Therefore, drop the
file_mutex during the call to ib_destroy_cm_id().

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>
Acked-by: Sean Hefty <sean.hefty@intel.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

Hello, -stable team!
This patch backports commit f469b2626f48829c06e40ac799c1edf62b12048e to 2.6.19.
Please consider it for 2.6.19.y - this fixes a deadlock reproduced here at Mellanox.

 drivers/infiniband/core/ucm.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-2.6.19.orig/drivers/infiniband/core/ucm.c
+++ linux-2.6.19/drivers/infiniband/core/ucm.c
@@ -161,12 +161,14 @@ static void ib_ucm_cleanup_events(struct
 				    struct ib_ucm_event, ctx_list);
 		list_del(&uevent->file_list);
 		list_del(&uevent->ctx_list);
+		mutex_unlock(&ctx->file->file_mutex);
 
 		/* clear incoming connections. */
 		if (ib_ucm_new_cm_id(uevent->resp.event))
 			ib_destroy_cm_id(uevent->cm_id);
 
 		kfree(uevent);
+		mutex_lock(&ctx->file->file_mutex);
 	}
 	mutex_unlock(&ctx->file->file_mutex);
 }

--
