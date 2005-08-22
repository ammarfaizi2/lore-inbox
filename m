Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbVHVVYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbVHVVYp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 17:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbVHVVYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 17:24:45 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:53997 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751180AbVHVVYo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 17:24:44 -0400
Date: Mon, 22 Aug 2005 10:13:53 -0400
From: Bob Picco <bob.picco@hp.com>
To: akpm@osdl.org
Cc: haveblue@us.ibm.com, linux-kernel@vger.kernel.org, bob.picco@hp.com
Subject: [PATCH] sparsemem fix for sparse_index_init
Message-ID: <20050822141353.GN8919@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew:

After reviewing recent SPARSEMEM+EXTREME changes for -mm, I spotted a memory 
leak issue.  In sparse_index_init we must evaluate whether the root index is
allocated before allocating, acquiring the lock and then checking
whether the root is already allocated. An alternative would be in the error path
doing a free_bootmem_node but this seems the more expensive method for
boot time.

thanks,

bob

Signed-off-by: Bob Picco <bob.picco@hp.com>


 mm/sparse.c |    3 +++
 1 files changed, 3 insertions(+)

Index: linux-2.6.13-rc6-mm1/mm/sparse.c
===================================================================
--- linux-2.6.13-rc6-mm1.orig/mm/sparse.c	2005-08-19 12:47:53.000000000 -0400
+++ linux-2.6.13-rc6-mm1/mm/sparse.c	2005-08-21 13:36:57.000000000 -0400
@@ -45,6 +45,9 @@ static int sparse_index_init(unsigned lo
 	struct mem_section *section;
 	int ret = 0;
 
+	if (mem_section[root])
+		return -EEXIST;
+
 	section = sparse_index_alloc(nid);
 	/*
 	 * This lock keeps two different sections from
