Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbVHXBjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbVHXBjj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 21:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbVHXBjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 21:39:39 -0400
Received: from siaag2ah.compuserve.com ([149.174.40.141]:26162 "EHLO
	siaag2ah.compuserve.com") by vger.kernel.org with ESMTP
	id S1751334AbVHXBji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 21:39:38 -0400
Date: Tue, 23 Aug 2005 21:36:40 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch 2.6.13-rc6] i386: fix incorrect FP signal delivery
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>, Andi Kleen <ak@suse.de>
Message-ID: <200508232138_MC3-1-A814-1599@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Aug 2005 11:55:21 -0700 (PDT), Linus Torvalds wrote:

> Wouldn't this simpler patch result in exactly the same behaviour?

 I thought the extra code would be good documentation, but the comments
work just as well.  This is a little clearer (hand edited patch:)

--- a/arch/i386/kernel/traps.c
+++ b/arch/i386/kernel/traps.c
@@ -803,15 +803,17 @@ void math_error(void __user *eip)
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
+			/*
+			 * swd & 0x240 == 0x040: Stack Underflow
+			 * swd & 0x240 == 0x240: Stack Overflow
+			 * User must clear the SF bit (0x40) if set
+			 */
 			info.si_code = FPE_FLTINV;
-			/* Should we clear the SF or let user space do it ???? */
 			break;
 		case 0x002: /* Denormalize */
 		case 0x010: /* Underflow */
__
Chuck
