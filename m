Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751576AbWI1QBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576AbWI1QBX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 12:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751884AbWI1QBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 12:01:23 -0400
Received: from mx.pathscale.com ([64.160.42.68]:57525 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751576AbWI1QBW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 12:01:22 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 2 of 28] IB/ipath - fix memory leak if allocation fails
X-Mercurial-Node: 45079acba20851290d1f024b16c85a2ae525ad7d
Message-Id: <45079acba20851290d1f.1159459198@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1159459196@eng-12.pathscale.com>
Date: Thu, 28 Sep 2006 08:59:58 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the second allocation failed, the first structure allocated in this
routine was not freed.

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r c46292ccb0f5 -r 45079acba208 drivers/infiniband/hw/ipath/ipath_driver.c
--- a/drivers/infiniband/hw/ipath/ipath_driver.c	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c	Thu Sep 28 08:57:12 2006 -0700
@@ -1326,6 +1326,9 @@ int ipath_create_rcvhdrq(struct ipath_de
 				      "for port %u rcvhdrqtailaddr failed\n",
 				      pd->port_port);
 			ret = -ENOMEM;
+			dma_free_coherent(&dd->pcidev->dev, amt,
+					  pd->port_rcvhdrq, pd->port_rcvhdrq_phys);
+			pd->port_rcvhdrq = NULL;
 			goto bail;
 		}
 		pd->port_rcvhdrqtailaddr_phys = phys_hdrqtail;
