Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964923AbWGJLF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964923AbWGJLF4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 07:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbWGJLF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 07:05:56 -0400
Received: from mxl145v66.mxlogic.net ([208.65.145.66]:58056 "EHLO
	p02c11o143.mxlogic.net") by vger.kernel.org with ESMTP
	id S964863AbWGJLFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 07:05:55 -0400
Date: Mon, 10 Jul 2006 14:06:18 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, openib-general@openib.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] IB/mthca: fix static rate returned by mthca_ah_query
Message-ID: <20060710110618.GC24705@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 10 Jul 2006 11:10:55.0890 (UTC) FILETIME=[83C71720:01C6A411]
X-Spam: [F=0.0100000000; S=0.010(2006062901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,
this has been out for a couple of days - could you drop this into -mm /
push this along to Linus, please?

----- Forwarded message from "Michael S. Tsirkin" <mst@mellanox.co.il> -----

Please review:

git://www.mellanox.co.il/~git/infiniband  mst-for-2.6.18

This has the following patch:

IB/mthca: fix static rate returned by mthca_ah_query

--

commit 8b9395d3b67af87ce4c218af06a259a8af246d75
Author: Jack Morgenstein <jackm@mellanox.co.il>
Date:   Thu Jul 6 19:33:25 2006 +0300

    mthca_ah_query returs the static rate of the address handle in internal mthc
    format. fix it to use rate encoding from enum ib_rate, which is what users
    expect.

    Signed-off-by: Jack Morgenstein <jackm@mellanox.co.il>
    Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>

Index: latest/drivers/infiniband/hw/mthca/mthca_av.c
===================================================================
--- latest.orig/drivers/infiniband/hw/mthca/mthca_av.c	2006-07-02 18:00:34.000000000 +0300
+++ latest/drivers/infiniband/hw/mthca/mthca_av.c	2006-07-05 13:50:06.000000000 +0300
@@ -303,9 +303,10 @@ int mthca_ah_query(struct ib_ah *ibah, s
 	memset(attr, 0, sizeof *attr);
 	attr->dlid          = be16_to_cpu(ah->av->dlid);
 	attr->sl            = be32_to_cpu(ah->av->sl_tclass_flowlabel) >> 28;
-	attr->static_rate   = ah->av->msg_sr & 0x7;
-	attr->src_path_bits = ah->av->g_slid & 0x7F;
 	attr->port_num      = be32_to_cpu(ah->av->port_pd) >> 24;
+	attr->static_rate   = mthca_rate_to_ib(dev, ah->av->msg_sr & 0x7,
+					       attr->port_num);
+	attr->src_path_bits = ah->av->g_slid & 0x7F;
 	attr->ah_flags      = mthca_ah_grh_present(ah) ? IB_AH_GRH : 0;
 
 	if (attr->ah_flags) {


-- 
MST
