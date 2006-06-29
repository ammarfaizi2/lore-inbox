Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932976AbWF2V7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932976AbWF2V7G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932878AbWF2V6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:58:33 -0400
Received: from mx.pathscale.com ([64.160.42.68]:33423 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932867AbWF2VoJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:44:09 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 10 of 39] IB/ipath - fix some memory leaks on failure paths
X-Mercurial-Node: 160e5cf91761a2daf6db07548d67d1a39b93a621
Message-Id: <160e5cf91761a2daf6db.1151617261@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1151617251@eng-12.pathscale.com>
Date: Thu, 29 Jun 2006 14:41:01 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org, rdreier@cisco.com, mst@mellanox.co.il
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Robert Walsh <robert.walsh@qlogic.com>
Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r ac81d2563bba -r 160e5cf91761 drivers/infiniband/hw/ipath/ipath_init_chip.c
--- a/drivers/infiniband/hw/ipath/ipath_init_chip.c	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_init_chip.c	Thu Jun 29 14:33:25 2006 -0700
@@ -115,6 +115,7 @@ static int create_port0_egr(struct ipath
 				      "eager TID %u\n", e);
 			while (e != 0)
 				dev_kfree_skb(skbs[--e]);
+			vfree(skbs);
 			ret = -ENOMEM;
 			goto bail;
 		}
diff -r ac81d2563bba -r 160e5cf91761 drivers/infiniband/hw/ipath/ipath_qp.c
--- a/drivers/infiniband/hw/ipath/ipath_qp.c	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_qp.c	Thu Jun 29 14:33:25 2006 -0700
@@ -692,6 +692,7 @@ struct ib_qp *ipath_create_qp(struct ib_
 	case IB_QPT_GSI:
 		qp = kmalloc(sizeof(*qp), GFP_KERNEL);
 		if (!qp) {
+			vfree(swq);
 			ret = ERR_PTR(-ENOMEM);
 			goto bail;
 		}
@@ -702,6 +703,7 @@ struct ib_qp *ipath_create_qp(struct ib_
 		qp->r_rq.wq = vmalloc(qp->r_rq.size * sz);
 		if (!qp->r_rq.wq) {
 			kfree(qp);
+			vfree(swq);
 			ret = ERR_PTR(-ENOMEM);
 			goto bail;
 		}
