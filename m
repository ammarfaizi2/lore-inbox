Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266295AbUHWRtj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266295AbUHWRtj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 13:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266306AbUHWRti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 13:49:38 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:484 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S266295AbUHWRsF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 13:48:05 -0400
Subject: [PATCH] reduce casting in sysenter.c
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-ENv+0792SJgk/Yrj7UTL"
Message-Id: <1093283274.3153.958.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 23 Aug 2004 10:47:54 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ENv+0792SJgk/Yrj7UTL
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Ran across this because it's another place where an unsigned long is
passed directly to __pa().  Making the "page" variable a void* seems a
bit more natural than an unsigned long and reduces the net number of
casts by 1.  Without it, we probably need another (void *) cast in the
__pa() call. 

For more explanation as to why this was probably done originally, see
this post:
http://marc.theaimsgroup.com/?l=linux-mm&m=109155379124628&w=2

-- Dave

--=-ENv+0792SJgk/Yrj7UTL
Content-Disposition: attachment; filename=sysenter-types.patch
Content-Type: text/x-patch; name=sysenter-types.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit



---

 memhotplug-dave/arch/i386/kernel/sysenter.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -puN arch/i386/kernel/sysenter.c~sysenter-types arch/i386/kernel/sysenter.c
--- memhotplug/arch/i386/kernel/sysenter.c~sysenter-types	2004-08-23 10:38:24.000000000 -0700
+++ memhotplug-dave/arch/i386/kernel/sysenter.c	2004-08-23 10:38:24.000000000 -0700
@@ -43,18 +43,18 @@ extern const char vsyscall_sysenter_star
 
 static int __init sysenter_setup(void)
 {
-	unsigned long page = get_zeroed_page(GFP_ATOMIC);
+	void *page = (void *)get_zeroed_page(GFP_ATOMIC);
 
 	__set_fixmap(FIX_VSYSCALL, __pa(page), PAGE_READONLY_EXEC);
 
 	if (!boot_cpu_has(X86_FEATURE_SEP)) {
-		memcpy((void *) page,
+		memcpy(page,
 		       &vsyscall_int80_start,
 		       &vsyscall_int80_end - &vsyscall_int80_start);
 		return 0;
 	}
 
-	memcpy((void *) page,
+	memcpy(page,
 	       &vsyscall_sysenter_start,
 	       &vsyscall_sysenter_end - &vsyscall_sysenter_start);
 
_

--=-ENv+0792SJgk/Yrj7UTL--

