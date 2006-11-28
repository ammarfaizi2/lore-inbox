Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935138AbWK1OK5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935138AbWK1OK5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 09:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935217AbWK1OK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 09:10:57 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:51761
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S935138AbWK1OK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 09:10:56 -0500
Message-Id: <456C51D8.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Tue, 28 Nov 2006 14:12:24 +0000
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] work around gcc4 issue with -Os in Dwarf2 stack unwind
	code
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a problem with gcc4 mis-compiling the stack unwind code under
-Os, which resulted in 'stuck' messages whenever an assembly routine was
encountered.

(The second hunk is trivial cleanup.)

Signed-off-by: Jan Beulich <jbeulich@novell.com>

--- linux-2.6.19-rc6/kernel/unwind.c	2006-11-22 14:54:10.000000000 +0100
+++ 2.6.19-rc6-unwind-stuck/kernel/unwind.c	2006-11-28 15:02:15.000000000 +0100
@@ -938,8 +938,11 @@ int unwind(struct unwind_frame_info *fra
 		else {
 			retAddrReg = state.version <= 1 ? *ptr++ : get_uleb128(&ptr, end);
 			/* skip augmentation */
-			if (((const char *)(cie + 2))[1] == 'z')
-				ptr += get_uleb128(&ptr, end);
+			if (((const char *)(cie + 2))[1] == 'z') {
+				uleb128_t augSize = get_uleb128(&ptr, end);
+
+				ptr += augSize;
+			}
 			if (ptr > end
 			   || retAddrReg >= ARRAY_SIZE(reg_info)
 			   || REG_INVALID(retAddrReg)
@@ -963,9 +966,7 @@ int unwind(struct unwind_frame_info *fra
 	if (cie == NULL || fde == NULL) {
 #ifdef CONFIG_FRAME_POINTER
 		unsigned long top, bottom;
-#endif
 
-#ifdef CONFIG_FRAME_POINTER
 		top = STACK_TOP(frame->task);
 		bottom = STACK_BOTTOM(frame->task);
 # if FRAME_RETADDR_OFFSET < 0


