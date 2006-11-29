Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967139AbWK2LM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967139AbWK2LM7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 06:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967149AbWK2LM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 06:12:59 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:25878
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S967139AbWK2LM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 06:12:58 -0500
Message-Id: <456D79AB.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Wed, 29 Nov 2006 11:14:35 +0000
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] use probe_kernel_address in Dwarf2 unwinder
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use probe_kernel_address() instead of __get_user() in Dwarf2 unwinder.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

--- linux-2.6.19-rc6/kernel/unwind.c	2006-11-29 10:04:11.000000000 +0100
+++ 2.6.19-rc6-unwind-probe_kernel_address/kernel/unwind.c	2006-11-29 10:22:16.000000000 +0100
@@ -14,8 +14,8 @@
 #include <linux/bootmem.h>
 #include <linux/sort.h>
 #include <linux/stop_machine.h>
+#include <linux/uaccess.h>
 #include <asm/sections.h>
-#include <asm/uaccess.h>
 #include <asm/unaligned.h>
 
 extern char __start_unwind[], __end_unwind[];
@@ -550,7 +550,7 @@ static unsigned long read_pointer(const 
 		return 0;
 	}
 	if ((ptrType & DW_EH_PE_indirect)
-	    && __get_user(value, (unsigned long *)value))
+	    && probe_kernel_address((unsigned long *)value, value))
 		return 0;
 	*pLoc = ptr.p8;
 
@@ -981,18 +981,18 @@ int unwind(struct unwind_frame_info *fra
 		        & (sizeof(unsigned long) - 1))) {
 			unsigned long link;
 
-			if (!__get_user(link,
-			                (unsigned long *)(UNW_FP(frame)
-			                                  + FRAME_LINK_OFFSET))
+			if (!probe_kernel_address((unsigned long *)(UNW_FP(frame)
+			                                            + FRAME_LINK_OFFSET),
+			                          link)
 # if FRAME_RETADDR_OFFSET < 0
 			   && link > bottom && link < UNW_FP(frame)
 # else
 			   && link > UNW_FP(frame) && link < bottom
 # endif
 			   && !(link & (sizeof(link) - 1))
-			   && !__get_user(UNW_PC(frame),
-			                  (unsigned long *)(UNW_FP(frame)
-			                                    + FRAME_RETADDR_OFFSET))) {
+			   && !probe_kernel_address((unsigned long *)(UNW_FP(frame)
+			                                              + FRAME_RETADDR_OFFSET))
+			                            UNW_PC(frame)) {
 				UNW_SP(frame) = UNW_FP(frame) + FRAME_RETADDR_OFFSET
 # if FRAME_RETADDR_OFFSET < 0
 					-
@@ -1103,7 +1103,7 @@ int unwind(struct unwind_frame_info *fra
 					return -EIO;
 				switch(reg_info[i].width) {
 #define CASE(n)     case sizeof(u##n): \
-					__get_user(FRAME_REG(i, u##n), (u##n *)addr); \
+					probe_kernel_address((u##n *)addr, FRAME_REG(i, u##n)); \
 					break
 				CASES;
 #undef CASE


