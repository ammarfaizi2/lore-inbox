Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268836AbTBZREz>; Wed, 26 Feb 2003 12:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268832AbTBZRD7>; Wed, 26 Feb 2003 12:03:59 -0500
Received: from cmailm5.svr.pol.co.uk ([195.92.193.21]:37134 "EHLO
	cmailm5.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S268831AbTBZRDP>; Wed, 26 Feb 2003 12:03:15 -0500
Date: Wed, 26 Feb 2003 17:12:49 +0000
To: Linus Torvalds <torvalds@transmeta.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/8] dm: __LOW macro fix no. 2
Message-ID: <20030226171249.GG8369@fib011235813.fsnet.co.uk>
References: <20030226170537.GA8289@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030226170537.GA8289@fib011235813.fsnet.co.uk>
User-Agent: Mutt/1.5.3i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another fix for the __LOW macro.

When dm_table and dm_target structures are initialized, the "limits" fields 
(struct io_restrictions) are initialized to zero (e.g. in dm_table_add_target()
in dm-table.c). However, zero is not a useable value in these fields. The
request queue will never let an I/O through, regardless of how small it might
be, if max_sectors is set to zero (see generic_make_request in ll_rw_blk.c).
This change to the __LOW() macro sets these fields correctly when they are
first initialized.  [Kevin Corry]

--- diff/drivers/md/dm-table.c	2003-02-26 16:10:02.000000000 +0000
+++ source/drivers/md/dm-table.c	2003-02-26 16:10:19.000000000 +0000
@@ -79,7 +79,7 @@
 }
 
 #define __HIGH(l, r) if (*(l) < (r)) *(l) = (r)
-#define __LOW(l, r) if (*(l) > (r)) *(l) = (r)
+#define __LOW(l, r) if (*(l) == 0 || *(l) > (r)) *(l) = (r)
 
 /*
  * Combine two io_restrictions, always taking the lower value.
