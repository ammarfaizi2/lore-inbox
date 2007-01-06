Return-Path: <linux-kernel-owner+w=401wt.eu-S1751102AbXAFC2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbXAFC2k (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 21:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbXAFC2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 21:28:37 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:47945 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751103AbXAFC1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 21:27:53 -0500
Message-Id: <20070106023145.665958000@sous-sol.org>
References: <20070106022753.334962000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 05 Jan 2007 18:28:08 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Roland Dreier <rdreier@cisco.com>,
       Roland Dreier <rolandd@cisco.com>
Subject: [patch 15/50] IB/srp: Fix FMR mapping for 32-bit kernels and addresses above 4G
Content-Disposition: inline; filename=ib-srp-fix-fmr-mapping-for-32-bit-kernels-and-addresses-above-4g.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Roland Dreier <rdreier@cisco.com>

struct srp_device.fmr_page_mask was unsigned long, which means that
the top part of addresses above 4G was being chopped off on 32-bit
architectures.  Of course nothing good happens when data from SRP
targets is DMAed to the wrong place.

Fix this by changing fmr_page_mask to u64, to match the addresses
actually used by IB devices.

Thanks to Brian Cain <Brian.Cain@ge.com> and David McMillen
<davem@systemfabricworks.com> for help diagnosing the bug and testing
the fix.

Signed-off-by: Roland Dreier <rolandd@cisco.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
I just asked Linus to pull this.  It fixes nasty corruption/crash
problems on 32-bit systems with > 4G of memory.

 drivers/infiniband/ulp/srp/ib_srp.c |    2 +-
 drivers/infiniband/ulp/srp/ib_srp.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.19.1.orig/drivers/infiniband/ulp/srp/ib_srp.c
+++ linux-2.6.19.1/drivers/infiniband/ulp/srp/ib_srp.c
@@ -1879,7 +1879,7 @@ static void srp_add_one(struct ib_device
 	 */
 	srp_dev->fmr_page_shift = max(9, ffs(dev_attr->page_size_cap) - 1);
 	srp_dev->fmr_page_size  = 1 << srp_dev->fmr_page_shift;
-	srp_dev->fmr_page_mask  = ~((unsigned long) srp_dev->fmr_page_size - 1);
+	srp_dev->fmr_page_mask  = ~((u64) srp_dev->fmr_page_size - 1);
 
 	INIT_LIST_HEAD(&srp_dev->dev_list);
 
--- linux-2.6.19.1.orig/drivers/infiniband/ulp/srp/ib_srp.h
+++ linux-2.6.19.1/drivers/infiniband/ulp/srp/ib_srp.h
@@ -87,7 +87,7 @@ struct srp_device {
 	struct ib_fmr_pool     *fmr_pool;
 	int			fmr_page_shift;
 	int			fmr_page_size;
-	unsigned long		fmr_page_mask;
+	u64			fmr_page_mask;
 };
 
 struct srp_host {

--
