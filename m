Return-Path: <linux-kernel-owner+w=401wt.eu-S1030223AbWL3DP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030223AbWL3DP6 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 22:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030229AbWL3DP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 22:15:58 -0500
Received: from mga03.intel.com ([143.182.124.21]:5978 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030223AbWL3DP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 22:15:57 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,220,1165219200"; 
   d="scan'208"; a="163614884:sNHT19360761"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andrew Morton'" <akpm@osdl.org>, <zach.brown@oracle.com>
Cc: <linux-aio@kvack.org>, <linux-kernel@vger.kernel.org>,
       "'Benjamin LaHaise'" <bcrl@kvack.org>, <suparna@in.ibm.com>
Subject: [patch] aio: make aio_ring_info->nr_pages an unsigned int
Date: Fri, 29 Dec 2006 19:15:56 -0800
Message-ID: <000501c72bc0$d286bff0$d634030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AccrwNJLrs7gVVU7TgCJMNlQ10fmsg==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The number of io_event in AIO event queue allowed currently is no more
than 2^32-1, because the syscall defines:

	asmlinkage long sys_io_setup(unsigned nr_events, aio_context_t __user *ctxp)

We internally allocate a ring buffer for nr_events and keeps tracks of
page descriptors for each of these ring buffer pages.  Since page size
is significantly larger than AIO event size (4096 versus 32), I don't
think it is ever possible to overflow nr_pages in 32-bit quantity.

This patch changes nr_pages to unsigned int. on 64-bit arch, changing
it to unsigned int also allows better packing of aio_ring_info structure.


Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>

--- ./include/linux/aio.h.orig	2006-12-24 22:31:55.000000000 -0800
+++ ./include/linux/aio.h	2006-12-24 22:41:28.000000000 -0800
@@ -165,7 +165,7 @@ struct aio_ring_info {
 
 	struct page		**ring_pages;
 	spinlock_t		ring_lock;
-	long			nr_pages;
+	unsigned		nr_pages;
 
 	unsigned		nr, tail;
 
