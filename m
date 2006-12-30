Return-Path: <linux-kernel-owner+w=401wt.eu-S1754238AbWL3C7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754238AbWL3C7Q (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 21:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755113AbWL3C7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 21:59:16 -0500
Received: from mga03.intel.com ([143.182.124.21]:22685 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754232AbWL3C7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 21:59:15 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,220,1165219200"; 
   d="scan'208"; a="163612446:sNHT22745513"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andrew Morton'" <akpm@osdl.org>, <zach.brown@oracle.com>
Cc: <linux-aio@kvack.org>, <linux-kernel@vger.kernel.org>,
       "'Benjamin LaHaise'" <bcrl@kvack.org>, <suparna@in.ibm.com>
Subject: [patch] aio: remove spurious ring head index modulo info->nr
Date: Fri, 29 Dec 2006 18:59:14 -0800
Message-ID: <000401c72bbe$7d715b30$d634030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: Accrvn03oVunCq2SSY2aJCNOpa0k+Q==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In aio_read_evt(), the ring->head will never wrap info->nr because
we already does the wrap when updating the ring head index:

        if (head != ring->tail) {
                ...
                head = (head + 1) % info->nr;
                ring->head = head;
        }

This makes the modulo of ring->head into local variable head unnecessary.
This patch removes that bogus code.


Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>


--- ./fs/aio.c.orig	2006-12-24 22:01:36.000000000 -0800
+++ ./fs/aio.c	2006-12-24 22:34:48.000000000 -0800
@@ -1019,7 +1019,7 @@ static int aio_read_evt(struct kioctx *i
 {
 	struct aio_ring_info *info = &ioctx->ring_info;
 	struct aio_ring *ring;
-	unsigned long head;
+	unsigned int head;
 	int ret = 0;
 
 	ring = kmap_atomic(info->ring_pages[0], KM_USER0);
@@ -1032,7 +1032,7 @@ static int aio_read_evt(struct kioctx *i
 
 	spin_lock(&info->ring_lock);
 
-	head = ring->head % info->nr;
+	head = ring->head;
 	if (head != ring->tail) {
 		struct io_event *evp = aio_ring_event(info, head, KM_USER1);
 		*ent = *evp;
