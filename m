Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751923AbWI1QCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923AbWI1QCy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 12:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751801AbWI1QCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 12:02:48 -0400
Received: from mx.pathscale.com ([64.160.42.68]:3510 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751923AbWI1QBY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 12:01:24 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 19 of 28] IB/ipath - call mtrr_del with correct arguments
X-Mercurial-Node: 858280e8cbab089eab005a5985831e9867a5ef93
Message-Id: <858280e8cbab089eab00.1159459215@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1159459196@eng-12.pathscale.com>
Date: Thu, 28 Sep 2006 09:00:15 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We were passing 0 for base and length, which worked on older kernels,
but it doesn't seem to any longer.

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r de99d6fb2d1d -r 858280e8cbab drivers/infiniband/hw/ipath/ipath_kernel.h
--- a/drivers/infiniband/hw/ipath/ipath_kernel.h	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_kernel.h	Thu Sep 28 08:57:12 2006 -0700
@@ -336,6 +336,8 @@ struct ipath_devdata {
 	u8 ipath_ht_slave_off;
 	/* for write combining settings */
 	unsigned long ipath_wc_cookie;
+	unsigned long ipath_wc_base;
+	unsigned long ipath_wc_len;
 	/* ref count for each pkey */
 	atomic_t ipath_pkeyrefs[4];
 	/* shadow copy of all exptids physaddr; used only by funcsim */
diff -r de99d6fb2d1d -r 858280e8cbab drivers/infiniband/hw/ipath/ipath_wc_x86_64.c
--- a/drivers/infiniband/hw/ipath/ipath_wc_x86_64.c	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_wc_x86_64.c	Thu Sep 28 08:57:12 2006 -0700
@@ -123,6 +123,8 @@ int ipath_enable_wc(struct ipath_devdata
 			ipath_cdbg(VERBOSE, "Set mtrr for chip to WC, "
 				   "cookie is %d\n", cookie);
 			dd->ipath_wc_cookie = cookie;
+			dd->ipath_wc_base = (unsigned long) pioaddr;
+			dd->ipath_wc_len = (unsigned long) piolen;
 		}
 	}
 
@@ -136,9 +138,16 @@ void ipath_disable_wc(struct ipath_devda
 void ipath_disable_wc(struct ipath_devdata *dd)
 {
 	if (dd->ipath_wc_cookie) {
+		int r;
 		ipath_cdbg(VERBOSE, "undoing WCCOMB on pio buffers\n");
-		mtrr_del(dd->ipath_wc_cookie, 0, 0);
-		dd->ipath_wc_cookie = 0;
+		r = mtrr_del(dd->ipath_wc_cookie, dd->ipath_wc_base,
+			     dd->ipath_wc_len);
+		if (r < 0)
+			dev_info(&dd->pcidev->dev,
+				 "mtrr_del(%lx, %lx, %lx) failed: %d\n",
+				 dd->ipath_wc_cookie, dd->ipath_wc_base,
+				 dd->ipath_wc_len, r);
+		dd->ipath_wc_cookie = 0; // even on failure
 	}
 }
 
