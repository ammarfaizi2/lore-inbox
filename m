Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbVHWS4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbVHWS4l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 14:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbVHWS4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 14:56:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34724 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932276AbVHWS4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 14:56:40 -0400
Date: Tue, 23 Aug 2005 11:55:21 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: Andi Kleen <ak@suse.de>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.6.13-rc6] i386: fix incorrect FP signal delivery
In-Reply-To: <200508222249_MC3-1-A800-4F7@compuserve.com>
Message-ID: <Pine.LNX.4.58.0508231150490.3317@g5.osdl.org>
References: <200508222249_MC3-1-A800-4F7@compuserve.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Aug 2005, Chuck Ebbert wrote:
>
> i386 floating-point exception handling has a bug that can cause error
> code 0 to be sent instead of the proper code during signal delivery.

Looking at your patch, I think it's too complicated.

The fact is, none of the "switch()" cases even _care_ about bits "0x240" 
from swd. The bug itself seems to be that we even look at it.

Wouldn't this simpler patch result in exactly the same behaviour?

		Linus
---
diff --git a/arch/i386/kernel/traps.c b/arch/i386/kernel/traps.c
--- a/arch/i386/kernel/traps.c
+++ b/arch/i386/kernel/traps.c
@@ -803,15 +803,14 @@ void math_error(void __user *eip)
 	 */
 	cwd = get_fpu_cwd(task);
 	swd = get_fpu_swd(task);
-	switch (((~cwd) & swd & 0x3f) | (swd & 0x240)) {
+	switch (swd & ~cwd & 0x3f) {
 		case 0x000:
 		default:
 			break;
 		case 0x001: /* Invalid Op */
-		case 0x041: /* Stack Fault */
-		case 0x241: /* Stack Fault | Direction */
+			/* swd & 0x240 == 0x040: Stack Fault */
+			/* swd & 0x240 == 0x240: Stack Fault | Direction */
 			info.si_code = FPE_FLTINV;
-			/* Should we clear the SF or let user space do it ???? */
 			break;
 		case 0x002: /* Denormalize */
 		case 0x010: /* Underflow */
