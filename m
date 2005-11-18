Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161082AbVKRMc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161082AbVKRMc4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 07:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161098AbVKRMc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 07:32:56 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:60824 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161095AbVKRMcy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 07:32:54 -0500
Date: Fri, 18 Nov 2005 18:02:56 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Morton Andrew Morton <akpm@osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Kdump: powerpc and s390 build failure fix
Message-ID: <20051118123256.GE7217@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

I realized that my recent kdump postings will break powerpc and s390 build if
CONFIG_KEXEC=y. Attached is the patch to fix it. Patch is diffed against
2.6.15-rc1-mm2.

Thanks
Vivek 



o crash_setup_regs() is an architecture dependent function which is called
  in architecture independent section. So every architecture supporting 
  kexec should at least provide a dummy definition of crash_setup_regs() even
  if crash dumping is not implemented yet, to avoid build failures. 

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 linux-2.6.15-rc1-mm2-1M-root/include/asm-powerpc/kexec.h |    6 ++++++
 linux-2.6.15-rc1-mm2-1M-root/include/asm-s390/kexec.h    |    4 ++++
 2 files changed, 10 insertions(+)

diff -puN include/asm-powerpc/kexec.h~kdump-powerpc-s390-build-breakage-fix include/asm-powerpc/kexec.h
--- linux-2.6.15-rc1-mm2-1M/include/asm-powerpc/kexec.h~kdump-powerpc-s390-build-breakage-fix	2005-11-18 16:08:31.000000000 +0530
+++ linux-2.6.15-rc1-mm2-1M-root/include/asm-powerpc/kexec.h	2005-11-18 16:08:31.000000000 +0530
@@ -43,5 +43,11 @@ struct kimage;
 extern void machine_kexec_simple(struct kimage *image);
 #endif
 
+/*
+ * Provide a dummy definition to avoid build failures. Will remain
+ * empty till crash dump support is enabled.
+ */
+static inline void crash_setup_regs(struct pt_regs *newregs,
+					struct pt_regs *oldregs) { }
 #endif /* ! __ASSEMBLY__ */
 #endif /* _ASM_POWERPC_KEXEC_H */
diff -puN include/asm-s390/kexec.h~kdump-powerpc-s390-build-breakage-fix include/asm-s390/kexec.h
--- linux-2.6.15-rc1-mm2-1M/include/asm-s390/kexec.h~kdump-powerpc-s390-build-breakage-fix	2005-11-18 16:08:31.000000000 +0530
+++ linux-2.6.15-rc1-mm2-1M-root/include/asm-s390/kexec.h	2005-11-18 16:08:31.000000000 +0530
@@ -36,4 +36,8 @@
 
 #define MAX_NOTE_BYTES 1024
 
+/* Provide a dummy definition to avoid build failures. */
+static inline void crash_setup_regs(struct pt_regs *newregs,
+					struct pt_regs *oldregs) { }
+
 #endif /*_S390_KEXEC_H */
_
