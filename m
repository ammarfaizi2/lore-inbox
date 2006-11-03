Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753168AbWKCHAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753168AbWKCHAl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 02:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753172AbWKCHAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 02:00:41 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:48616 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1753168AbWKCHAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 02:00:40 -0500
Date: Fri, 3 Nov 2006 12:28:24 +0530
From: Ankita Garg <ankita@in.ibm.com>
To: torvalds@osdl.org
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix for LKDTM MEM_SWAPOUT crashpoint
Message-ID: <20061103065824.GA6790@in.ibm.com>
Reply-To: ankita@in.ibm.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wzJLGUyc3ArbnUjN"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

The MEM_SWAPOUT crashpoint in LKDTM could be broken as some compilers inline the call to shrink_page_list() and symbol lookup for this function name fails.
Replacing it with the function shrink_inactive_list(), which is the only 
function calling shrink_page_list().

Regards,
-- 
Ankita Garg (ankigarg@in.ibm.com)
Linux Technology Center
IBM India Systems & Technology Labs, 
Bangalore, India   

--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lkdtm-mem-swapout-fix.patch"

o Fix for MEM_SWAPOUT crashpoint as some compilers inline the call to 
  shrink_page_list() and symbol lookup for this function name fails. 

Signed-off-by: Ankita Garg <ankita@in.ibm.com>
---
 lkdtm.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

Index: linux-2.6.19-rc4-mm2/drivers/misc/lkdtm.c
===================================================================
--- linux-2.6.19-rc4-mm2.orig/drivers/misc/lkdtm.c	2006-11-03 06:20:07.000000000 +0530
+++ linux-2.6.19-rc4-mm2/drivers/misc/lkdtm.c	2006-11-03 06:23:59.000000000 +0530
@@ -157,8 +157,7 @@
 
 struct scan_control;
 
-unsigned long jp_shrink_page_list(struct list_head *page_list,
-                                        struct scan_control *sc)
+unsigned long jp_shrink_inactive_list(unsigned long max_scan, struct zone *zone,				struct scan_control *sc)
 {
 	lkdtm_handler();
 	jprobe_return();
@@ -297,8 +296,8 @@
 		lkdtm.entry = (kprobe_opcode_t*) jp_ll_rw_block;
 		break;
 	case MEM_SWAPOUT:
-		lkdtm.kp.symbol_name = "shrink_page_list";
-		lkdtm.entry = (kprobe_opcode_t*) jp_shrink_page_list;
+		lkdtm.kp.symbol_name = "shrink_inactive_list";
+		lkdtm.entry = (kprobe_opcode_t*) jp_shrink_inactive_list;
 		break;
 	case TIMERADD:
 		lkdtm.kp.symbol_name = "hrtimer_start";

--wzJLGUyc3ArbnUjN--
