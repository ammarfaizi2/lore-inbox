Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311059AbSCHThk>; Fri, 8 Mar 2002 14:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311066AbSCHThb>; Fri, 8 Mar 2002 14:37:31 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:65279 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S311059AbSCHThZ>; Fri, 8 Mar 2002 14:37:25 -0500
Date: Fri, 08 Mar 2002 11:36:31 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] stop null ptr deference in __alloc_pages
Message-ID: <7730000.1015616191@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary: Avoid null ptr defererence in __alloc_pages
This exists in 2.4. and 2.5

Configuration: a NUMA (ia32) system which only has highmem 
on one or more nodes.

Action to create: Try to allocate ZONE_NORMAL memory 
from a node which only has highmem. What we should do
is fall back to another node, looking for ZONE_NORMAL
memory.

In looking at the specified zonelist, we panic because that zonelist
is NULL. The simple patch below avoids the null deference, and 
returns failure. alloc_pages will continue looking through the nodes
until it finds one with some ZONE_NORMAL memory. We actually
panic at the moment a few lines later when we do,
classzone->need_balance = 1; thus dereferencing the pointer.

--- linux-2.4.18-memalloc/mm/page_alloc.c.old	Fri Mar  8 18:21:41 2002
+++ linux-2.4.18-memalloc/mm/page_alloc.c	Fri Mar  8 18:23:27 2002
@@ -317,6 +317,8 @@
 
 	zone = zonelist->zones;
 	classzone = *zone;
+	if (classzone == NULL)
+		return NULL;
 	min = 1UL << order;
 	for (;;) {
 		zone_t *z = *(zone++);

