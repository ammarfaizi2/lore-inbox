Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272690AbTHKOGi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 10:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272616AbTHKNmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 09:42:38 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:38539 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272615AbTHKNlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 09:41:03 -0400
To: torvalds@transmeta.com
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 
Message-Id: <E19mCuO-0003dL-00@tetrachloride>
Date: Mon, 11 Aug 2003 14:40:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Dave Richards (drichards@mahinetworks.com)

While diagnosing an MMX/FPU problem I found a minor problem in the code
which diagnoses and generates signals for FPU exceptions. On x86 Stack
Fault Exception are a subclass of Invalid Operation. Thus, the FPU status
register will have both the SF and IF bits set when a stack fault occurs.
The code which turns FPU exceptions into signals was assuming IF would be
clear:

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/kernel/traps.c linux-2.5/arch/i386/kernel/traps.c
--- bk-linus/arch/i386/kernel/traps.c	2003-06-26 19:49:20.000000000 +0100
+++ linux-2.5/arch/i386/kernel/traps.c	2003-06-26 20:11:29.000000000 +0100
@@ -629,9 +629,10 @@ void math_error(void *eip)
 		default:
 			break;
 		case 0x001: /* Invalid Op */
-		case 0x040: /* Stack Fault */
-		case 0x240: /* Stack Fault | Direction */
+		case 0x041: /* Stack Fault */
+		case 0x241: /* Stack Fault | Direction */
 			info.si_code = FPE_FLTINV;
+			/* Should we clear the SF or let user space do it ???? */
 			break;
 		case 0x002: /* Denormalize */
 		case 0x010: /* Underflow */
