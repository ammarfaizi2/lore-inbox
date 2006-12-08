Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425326AbWLHKdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425326AbWLHKdo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 05:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425337AbWLHKdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 05:33:43 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:58432 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1425326AbWLHKdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 05:33:43 -0500
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: davej@codemonkey.org.uk,
       "Myaskouvskey, Artiom" <artiom.myaskouvskey@intel.com>,
       Randy Dunlap <randy.dunlap@oracle.com>, shai.satt@intel.com,
       Andi Kleen <ak@suse.de>, hpa@zytor.com, Paul Jackson <pj@sgi.com>
Date: Fri, 08 Dec 2006 02:33:36 -0800
Message-Id: <20061208103336.4644.96389.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH] efi is_memory_available ia64 hack build fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Jackson <pj@sgi.com>

The addition of an is_available_memory() routine to some arch i386
code, along with an extern for it in efi.h, caused the ia64 build
to fail, which has the apparently identical routine, marked 'static'.

The ia64 build fails with:

arch/ia64/kernel/efi.c:229: error: static declaration of 'is_available_memory' follows non-static declaration
include/linux/efi.h:305: error: previous declaration of 'is_available_memory' was here              

Removing the static modifier from the ia64 definition of this
routine lets it build.

But it still doesn't seem right - as now we have two apparently
identical copies of is_available_memory() defined, in:

  arch/i386/kernel/efi.c
  arch/ia64/kernel/efi.c

However, I don't know what to do about that.
At least the build gets past this point now.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 arch/ia64/kernel/efi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 2.6.19-rc6-mm2.orig/arch/ia64/kernel/efi.c	2006-12-08 02:05:57.190745630 -0800
+++ 2.6.19-rc6-mm2/arch/ia64/kernel/efi.c	2006-12-08 02:07:38.256082124 -0800
@@ -224,7 +224,7 @@ efi_gettimeofday (struct timespec *ts)
 	ts->tv_nsec = tm.nanosecond;
 }
 
-static int
+int
 is_available_memory (efi_memory_desc_t *md)
 {
 	if (!(md->attribute & EFI_MEMORY_WB))

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
