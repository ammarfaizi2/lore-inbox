Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292917AbSBQKUj>; Sun, 17 Feb 2002 05:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292918AbSBQKUa>; Sun, 17 Feb 2002 05:20:30 -0500
Received: from holomorphy.com ([216.36.33.161]:3715 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S292917AbSBQKUV>;
	Sun, 17 Feb 2002 05:20:21 -0500
Date: Sun, 17 Feb 2002 02:20:13 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: riel@surriel.com
Subject: [PATCH] [rmap] upper limit on wait table size
Message-ID: <20020217102013.GG832@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, riel@surriel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: attachment; filename="waitq_bound.patch"
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Long-term Linux VM development
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.201   ->        
#	     mm/page_alloc.c	1.60    -> 1.61   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/02/17	wli@holomorphy.com	1.202
# Set upper limits on the maximum number of waitqueue table entries.
# --------------------------------------------
#
diff -Nru a/mm/page_alloc.c b/mm/page_alloc.c
--- a/mm/page_alloc.c	Sun Feb 17 02:15:31 2002
+++ b/mm/page_alloc.c	Sun Feb 17 02:15:31 2002
@@ -825,6 +825,22 @@
 	while(size < pages)
 		size <<= 1;
 
+	/*
+	 * 16384 blocked kernel threads seems like a reasonable
+	 * number and this throttles the growth of the wait table
+	 * to something bounded above by something resembling
+	 * approximately the maximum number of kernel threads
+	 * expected. This limit will trigger at 16K*4K*256 = 16GB
+	 * on i386. The hard upper bound for i386 is then
+	 * 16K*12B = 192KB, which is large but acceptable. For
+	 * uniprocessor machines 4096 threads is a more likely
+	 * number. i386 UP triggers this at 4GB for a 48KB table.
+	 */
+	if (NR_CPUS > 1)
+		size = min(size, 16384UL);
+	else
+		size = min(size, 4096UL);
+
 	return size;
 }
 
