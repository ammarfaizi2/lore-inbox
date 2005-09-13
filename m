Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932451AbVIMI64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbVIMI64 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 04:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbVIMI64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 04:58:56 -0400
Received: from liaag2ad.mx.compuserve.com ([149.174.40.155]:39888 "EHLO
	liaag2ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932451AbVIMI6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 04:58:55 -0400
Date: Tue, 13 Sep 2005 04:55:41 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch 2.6.13] i386: Ignore masked FPU exceptions
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Ondrej Zary <linux@rainbow-software.org>
Message-ID: <200509130458_MC3-1-AA03-D8AA@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think ignoring masked FPU exceptions on i386 is the right thing to do.
Although there is no documentation available for Cyrix MII, I did find
erratum F-7 for Winchip C6, "FPU instruction may result in spurious
exception under certain conditions" which seems to indicate that this can
happen.

Ondrej, this patch on top of 2.6.13 should fix your Cyrix problems.
Can you confirm?  There was another bug which was already fixed,
so this should be all that's needed now.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

 arch/i386/kernel/traps.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

--- 2.6.13a.orig/arch/i386/kernel/traps.c
+++ 2.6.13a/arch/i386/kernel/traps.c
@@ -804,8 +804,9 @@ void math_error(void __user *eip)
 	cwd = get_fpu_cwd(task);
 	swd = get_fpu_swd(task);
 	switch (swd & ~cwd & 0x3f) {
-		case 0x000:
-		default:
+		case 0x000: /* No unmasked exception */
+			return;
+		default:    /* Multiple exceptions */
 			break;
 		case 0x001: /* Invalid Op */
 			/*
__
Chuck
