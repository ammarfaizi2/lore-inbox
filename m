Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbTFFQzT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 12:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbTFFQzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 12:55:19 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:19382 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262093AbTFFQyp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 12:54:45 -0400
Subject: [PATCH] add bootmem failure warning
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-/848hQMEu+or68HzIXGQ"
Organization: 
Message-Id: <1054919213.10204.15.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 06 Jun 2003 10:06:53 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/848hQMEu+or68HzIXGQ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

__alloc_bootmem_core() has a couple of BUG_ON()'s.  Since the handlers
aren't set up this early, if you hit it, you just get along stream of
"Unknown Interrupt" messages.  It would be very nice to have a little
bit more information when something has decided to BUG() out this
early.  
-- 
Dave Hansen
haveblue@us.ibm.com

--=-/848hQMEu+or68HzIXGQ
Content-Disposition: attachment; filename=bootmem-core-warn-2.5.70-0.patch
Content-Type: text/plain; name=bootmem-core-warn-2.5.70-0.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

--- linux-2.5.70-clean/mm/bootmem.c	Mon May 26 18:00:27 2003
+++ linux-2.5.70-early/mm/bootmem.c	Fri Jun  6 06:58:46 2003
@@ -151,7 +151,11 @@ __alloc_bootmem_core(struct bootmem_data
 	unsigned long i, start = 0, incr, eidx;
 	void *ret;
 
-	BUG_ON(!size);
+	if(!size) {
+		printk("__alloc_bootmem_core(): zero-sized request\n");
+		dump_stack();
+		BUG();
+	}
 	BUG_ON(align & (align-1));
 
 	eidx = bdata->node_low_pfn - (bdata->node_boot_start >> PAGE_SHIFT);
diff -rup linux-2.5.70-clean/mm/page_alloc.c linux-2.5.70-early/mm/page_alloc.c

--=-/848hQMEu+or68HzIXGQ--

