Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937128AbWLDQrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937128AbWLDQrp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 11:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937130AbWLDQrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 11:47:45 -0500
Received: from dev.mellanox.co.il ([194.90.237.44]:34061 "EHLO
	dev.mellanox.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937128AbWLDQro (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 11:47:44 -0500
Date: Mon, 4 Dec 2006 18:44:48 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: stable@kernel.org, openib-general@openib.org,
       Roland Dreier <rolandd@cisco.com>, Sean Hefty <sean.hefty@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH -stable] IB/ucm: Fix deadlock in cleanup
Message-ID: <20061204164448.GA15375@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20060403154741.GB14808@mellanox.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060403154741.GB14808@mellanox.co.il>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ib_ucm_cleanup_events() holds file_mutex while calling ib_destroy_cm_id().
This can deadlock since ib_destroy_cm_id() flushes event handlers, and
ib_ucm_event_handler() needs file_mutex, too.  Therefore, drop the
file_mutex during the call to ib_destroy_cm_id().

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>
Acked-by: Sean Hefty <sean.hefty@intel.com>

---

Hello, -stable team!
This patch backports commit f469b2626f48829c06e40ac799c1edf62b12048e to 2.6.19.
Please consider it for 2.6.19.y - this fixes a deadlock reproduced here at Mellanox.

diff --git a/drivers/infiniband/core/ucm.c b/drivers/infiniband/core/ucm.c
index 1f4f2d2..f15220a 100644
--- a/drivers/infiniband/core/ucm.c
+++ b/drivers/infiniband/core/ucm.c
@@ -161,12 +161,14 @@ static void ib_ucm_cleanup_events(struct ib_ucm_context *ctx)
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
MST
