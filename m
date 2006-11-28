Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935965AbWK1Rkd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935965AbWK1Rkd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 12:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935971AbWK1Rkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 12:40:32 -0500
Received: from extu-mxob-1.symantec.com ([216.10.194.28]:60314 "EHLO
	extu-mxob-1.symantec.com") by vger.kernel.org with ESMTP
	id S935965AbWK1Rka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 12:40:30 -0500
X-AuditID: d80ac21c-a6306bb00000557e-0c-456c748eaa9d 
Date: Tue, 28 Nov 2006 17:40:50 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Mingming Cao <cmm@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, Mel Gorman <mel@skynet.ie>,
       "Martin J. Bligh" <mbligh@mbligh.org>, linux-kernel@vger.kernel.org,
       "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: [PATCH 2/6] ext2 balloc: reset windowsz when full
In-Reply-To: <Pine.LNX.4.64.0611281659190.29701@blonde.wat.veritas.com>
Message-ID: <Pine.LNX.4.64.0611281740110.29701@blonde.wat.veritas.com>
References: <20061114014125.dd315fff.akpm@osdl.org>  <20061114184919.GA16020@skynet.ie>
  <Pine.LNX.4.64.0611141858210.11956@blonde.wat.veritas.com> 
 <20061114113120.d4c22b02.akpm@osdl.org>  <Pine.LNX.4.64.0611142111380.19259@blonde.wat.veritas.com>
  <Pine.LNX.4.64.0611151404260.11929@blonde.wat.veritas.com> 
 <20061115214534.72e6f2e8.akpm@osdl.org> <455C0B6F.7000201@us.ibm.com> 
 <20061115232228.afaf42f2.akpm@osdl.org>  <1163666960.4310.40.camel@localhost.localdomain>
  <20061116011351.1401a00f.akpm@osdl.org>  <1163708116.3737.12.camel@dyn9047017103.beaverton.ibm.com>
  <20061116132724.1882b122.akpm@osdl.org>  <Pine.LNX.4.64.0611201544510.16530@blonde.wat.veritas.com>
  <1164073652.20900.34.camel@dyn9047017103.beaverton.ibm.com> 
 <Pine.LNX.4.64.0611210508270.22957@blonde.wat.veritas.com>
 <1164156193.3804.48.camel@dyn9047017103.beaverton.ibm.com>
 <Pine.LNX.4.64.0611281659190.29701@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 28 Nov 2006 17:40:30.0264 (UTC) FILETIME=[4C3C4380:01C71314]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ext2_new_blocks should reset the reservation window size to 0 when squeezing
the last blocks out of an almost full filesystem, so the retry doesn't skip
any groups with less than half that free, reporting ENOSPC too soon.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 fs/ext2/balloc.c |    1 +
 1 file changed, 1 insertion(+)

--- 2.6.19-rc6-mm2/fs/ext2/balloc.c	2006-11-24 08:18:02.000000000 +0000
+++ linux/fs/ext2/balloc.c	2006-11-27 19:28:41.000000000 +0000
@@ -1292,6 +1292,7 @@ retry_alloc:
 	 */
 	if (my_rsv) {
 		my_rsv = NULL;
+		windowsz = 0;
 		group_no = goal_group;
 		goto retry_alloc;
 	}
