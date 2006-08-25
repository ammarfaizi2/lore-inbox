Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422664AbWHYSZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422664AbWHYSZU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 14:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422782AbWHYSZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 14:25:19 -0400
Received: from mx.pathscale.com ([64.160.42.68]:40578 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1422664AbWHYSZS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 14:25:18 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 3 of 23] IB/ipath - fix for crash on module unload,
	if cfgports < portcnt
X-Mercurial-Node: d7be11387c5ceef00307d43d2d0a5539d097ceed
Message-Id: <d7be11387c5ceef00307.1156530268@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1156530265@eng-12.pathscale.com>
Date: Fri, 25 Aug 2006 11:24:28 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate enough pointers for all possible ports, to avoid problems in
cleanup/unload.

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff --git a/drivers/infiniband/hw/ipath/ipath_init_chip.c b/drivers/infiniband/hw/ipath/ipath_init_chip.c
--- a/drivers/infiniband/hw/ipath/ipath_init_chip.c	Fri Aug 25 11:19:44 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_init_chip.c	Fri Aug 25 11:19:44 2006 -0700
@@ -240,7 +240,11 @@ static int init_chip_first(struct ipath_
 			  "only supports %u\n", ipath_cfgports,
 			  dd->ipath_portcnt);
 	}
-	dd->ipath_pd = kzalloc(sizeof(*dd->ipath_pd) * dd->ipath_cfgports,
+	/*
+	 * Allocate full portcnt array, rather than just cfgports, because
+	 * cleanup iterates across all possible ports.
+	 */
+	dd->ipath_pd = kzalloc(sizeof(*dd->ipath_pd) * dd->ipath_portcnt,
 			       GFP_KERNEL);
 
 	if (!dd->ipath_pd) {
