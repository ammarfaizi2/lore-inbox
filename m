Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261955AbVBXIWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261955AbVBXIWq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 03:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261964AbVBXIWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 03:22:46 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:62919 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261955AbVBXIWl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 03:22:41 -0500
Subject: [PATCH] Fix for broken kexec on panic
From: Vivek Goyal <vgoyal@in.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>, fastboot <fastboot@lists.osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>,
       haveblue@us.ibm.com
Content-Type: multipart/mixed; boundary="=-VpoxkbGvoO2Ozye7tyJl"
Organization: 
Message-Id: <1109236432.5148.192.camel@terminator.in.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 24 Feb 2005 14:43:53 +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-VpoxkbGvoO2Ozye7tyJl
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

Kexec on panic is broken on i386 in 2.6.11-rc3-mm2 because of
re-organization of boot memory allocator initialization code.  Primary
kernel does not boot if kexec is enabled and crashkernel=X@Y command
line parameter is passed. After re-organization, kexec is trying to call
reserve_bootmem before boot memory allocator has initialized.

This patch fixes the problem. I have moved the call to
reserved_bootmem() for kexec for both discontig and contig memory into
new setup_bootmem_allocator().

This patch has been generated against 2.6.11-rc4-mm1

Thanks
Vivek


--=-VpoxkbGvoO2Ozye7tyJl
Content-Disposition: attachment; filename=kexec-reserve-bootmem-fix.patch
Content-Type: text/plain; name=kexec-reserve-bootmem-fix.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit


Kexec on panic is broken on i386 in 2.6.11-rc3-mm2 because of re-organisation 
of boot memory allocator code.  Primary kernel does not boot if kexec is enabled
and crashkernel=X@Y command line parameter is passed. After re-organization,
kexec is trying to call reserve_bootmem before boot memory allocator has
initialized.
This patch fixes the problem. I have moved the call to reserved_bootmem() for
kexec for both discontig and contig memory into new setup_bootmem_allocator().


Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 linux-2.6.11-rc4-mm1-root/arch/i386/kernel/setup.c |   10 +++++-----
 linux-2.6.11-rc4-mm1-root/arch/i386/mm/discontig.c |    5 -----
 2 files changed, 5 insertions(+), 10 deletions(-)

diff -puN arch/i386/kernel/setup.c~kexec-reserve-bootmem-fix arch/i386/kernel/setup.c
--- linux-2.6.11-rc4-mm1/arch/i386/kernel/setup.c~kexec-reserve-bootmem-fix	2005-02-23 15:13:03.000000000 +0530
+++ linux-2.6.11-rc4-mm1-root/arch/i386/kernel/setup.c	2005-02-23 15:13:03.000000000 +0530
@@ -987,11 +987,6 @@ unsigned long __init find_max_low_pfn(vo
 			printk(KERN_ERR "ignoring highmem size on non-highmem kernel!\n");
 #endif
 	}
-#ifdef CONFIG_KEXEC
-	if (crashk_res.start != crashk_res.end)
-		reserve_bootmem(crashk_res.start,
-			crashk_res.end - crashk_res.start + 1);
-#endif
 	return max_low_pfn;
 }
 
@@ -1174,6 +1169,11 @@ void __init setup_bootmem_allocator(void
 		}
 	}
 #endif
+#ifdef CONFIG_KEXEC
+	if (crashk_res.start != crashk_res.end)
+		reserve_bootmem(crashk_res.start,
+			crashk_res.end - crashk_res.start + 1);
+#endif
 }
 
 /*
diff -puN arch/i386/mm/discontig.c~kexec-reserve-bootmem-fix arch/i386/mm/discontig.c
--- linux-2.6.11-rc4-mm1/arch/i386/mm/discontig.c~kexec-reserve-bootmem-fix	2005-02-23 15:13:03.000000000 +0530
+++ linux-2.6.11-rc4-mm1-root/arch/i386/mm/discontig.c	2005-02-23 15:13:03.000000000 +0530
@@ -265,11 +265,6 @@ unsigned long __init setup_memory(void)
 		find_max_pfn_node(nid);
 
 	NODE_DATA(0)->bdata = &node0_bdata;
-#ifdef CONFIG_KEXEC
-	if (crashk_res.start != crashk_res.end)
-		reserve_bootmem(crashk_res.start,
-			crashk_res.end - crashk_res.start + 1);
-#endif
 	setup_bootmem_allocator();
 	return max_low_pfn;
 }
_

--=-VpoxkbGvoO2Ozye7tyJl--

