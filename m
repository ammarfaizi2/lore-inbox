Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264805AbUEKRtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264805AbUEKRtt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 13:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264873AbUEKRtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 13:49:49 -0400
Received: from cfcafw.sgi.com ([198.149.23.1]:39468 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S264805AbUEKRtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 13:49:47 -0400
Date: Tue, 11 May 2004 12:49:45 -0500
To: linux-kernel@vger.kernel.org
Cc: thockin@sun.com
Subject: [PATCH] calculate NGROUPS_PER_BLOCK from PAGE_SIZE
Message-ID: <20040511174944.GA26708@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
From: edwardsg@sgi.com (Greg Edwards)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On ia64, EXEC_PAGESIZE (max page size) is 65536, but the default page
size is 16k.  This results in NGROUPS_PER_BLOCK in include/linux/sched.h
being calculated incorrectly when the page size is anything other than
64k.  For example, on a 16k page size kernel, a setgroups() call with a
gidsetsize of 65536 will end up walking over memory since only 1/4 of
the needed pages were allocated for the blocks[] array in the group_info
struct.

Patch below calculates NGROUPS_PER_BLOCK from PAGE_SIZE instead.

Greg


===== include/linux/sched.h 1.210 vs edited =====
--- 1.210/include/linux/sched.h	Mon May 10 06:25:34 2004
+++ edited/include/linux/sched.h	Tue May 11 11:45:29 2004
@@ -352,7 +352,7 @@
 void exit_io_context(void);
 
 #define NGROUPS_SMALL		32
-#define NGROUPS_PER_BLOCK	((int)(EXEC_PAGESIZE / sizeof(gid_t)))
+#define NGROUPS_PER_BLOCK	((int)(PAGE_SIZE / sizeof(gid_t)))
 struct group_info {
 	int ngroups;
 	atomic_t usage;
