Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262290AbVAUHE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262290AbVAUHE6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 02:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbVAUHE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 02:04:57 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:25781 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262290AbVAUHEP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 02:04:15 -0500
Subject: [PATCH] Reserving backup region for kexec based crashdumps.
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: fastboot <fastboot@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Hariprasad Nellitheertha <hari@in.ibm.com>,
       Maneesh Soni <maneesh@in.ibm.com>
In-Reply-To: <overview-11061198973484@ebiederm.dsl.xmission.com>
References: <overview-11061198973484@ebiederm.dsl.xmission.com>
Content-Type: multipart/mixed; boundary="=-jl27kn/fL7AFJ7exZAjR"
Organization: 
Message-Id: <1106294155.26219.26.camel@2fwv946.in.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 21 Jan 2005 13:25:55 +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jl27kn/fL7AFJ7exZAjR
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Andrew,

Following patch is against 2.6.11-rc1-mm2. 

As mentioned by following note from Eric, crashdump code is currently
broken.
> 
> The crashdump code is currently slightly broken.  I have attempted to
> minimize the breakage so things can quick be made to work again.

We have started doing changes to make crashdump up and running again.
Following are few identified items to be done.

1. Reserve the backup region (640k) during kernel bootup. 
2. Copy the data to backup region during crash.(moved to kexec user
space code, patch posted in separate mail)
3. Prepare elf headers while loading kexec panic kernel and store in
reserved memory area.
4. Pass required information to crashdump kernel, which parses it and
exports through /proc/vmcore. (may be user space utility, open to
discussion)

Following patch implements item 1) in the list. Soon we shall be rolling
out the patches for rest.

Thanks
Vivek



--=-jl27kn/fL7AFJ7exZAjR
Content-Description: 
Content-Disposition: attachment; filename=crashdump-x86-reserve-640k-memory.patch
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


This patch adds support for reserving 640k memory as backup region as required
by crashdump kernel for x86. 
---


Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 linux-2.6.11-rc1-mm2-kexec-eric-root/arch/i386/kernel/setup.c |    8 ++++++++
 linux-2.6.11-rc1-mm2-kexec-eric-root/include/linux/kexec.h    |    6 +++++-
 linux-2.6.11-rc1-mm2-kexec-eric-root/kernel/kexec.c           |    8 ++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff -puN arch/i386/kernel/setup.c~crashdump-x86-reserve-640k-memory arch/i386/kernel/setup.c
--- linux-2.6.11-rc1-mm2-kexec-eric/arch/i386/kernel/setup.c~crashdump-x86-reserve-640k-memory	2005-01-20 13:55:33.000000000 +0530
+++ linux-2.6.11-rc1-mm2-kexec-eric-root/arch/i386/kernel/setup.c	2005-01-20 13:55:33.000000000 +0530
@@ -1159,6 +1159,13 @@ static unsigned long __init setup_memory
 #ifdef CONFIG_KEXEC
 	if (crashk_res.start != crashk_res.end) {
 		reserve_bootmem(crashk_res.start, crashk_res.end - crashk_res.start + 1);
+
+#define CRASH_DUMP_BACKUP 0xa0000
+		/* Reserve another 640Kb for crashdump backup. */
+		crashdumpk_res.start = crashk_res.end + 1;
+		crashdumpk_res.end = crashdumpk_res.start +
+					CRASH_DUMP_BACKUP -1;
+		reserve_bootmem(crashdumpk_res.start, CRASH_DUMP_BACKUP);
 	}
 #endif
 	return max_low_pfn;
@@ -1202,6 +1209,7 @@ legacy_init_iomem_resources(struct resou
 			request_resource(res, data_resource);
 #ifdef CONFIG_KEXEC
 			request_resource(res, &crashk_res);
+			request_resource(res, &crashdumpk_res);
 #endif
 		}
 	}
diff -puN include/linux/kexec.h~crashdump-x86-reserve-640k-memory include/linux/kexec.h
--- linux-2.6.11-rc1-mm2-kexec-eric/include/linux/kexec.h~crashdump-x86-reserve-640k-memory	2005-01-20 13:55:33.000000000 +0530
+++ linux-2.6.11-rc1-mm2-kexec-eric-root/include/linux/kexec.h	2005-01-20 13:55:33.000000000 +0530
@@ -79,7 +79,7 @@ struct kimage {
 	unsigned long control_page;
 
 	/* Flags to indicate special processing */
-	int type : 1;
+	unsigned int type : 1;
 #define KEXEC_TYPE_DEFAULT 0
 #define KEXEC_TYPE_CRASH   1
 };
@@ -122,6 +122,10 @@ extern struct kimage *kexec_crash_image;
  */
 extern struct resource crashk_res;
 
+/* Location of backup region to hold the crashdump kernel data.
+ */
+extern struct resource crashdumpk_res;
+
 #else /* !CONFIG_KEXEC */
 static inline void crash_kexec(void) { }
 #endif /* CONFIG_KEXEC */
diff -puN kernel/kexec.c~crashdump-x86-reserve-640k-memory kernel/kexec.c
--- linux-2.6.11-rc1-mm2-kexec-eric/kernel/kexec.c~crashdump-x86-reserve-640k-memory	2005-01-20 13:55:33.000000000 +0530
+++ linux-2.6.11-rc1-mm2-kexec-eric-root/kernel/kexec.c	2005-01-20 13:55:33.000000000 +0530
@@ -32,6 +32,14 @@ struct resource crashk_res = {
 	.flags = IORESOURCE_BUSY | IORESOURCE_MEM
 };
 
+/* Location of the backup area for the crash dump kernel */
+struct resource crashdumpk_res = {
+	.name  = "Crash Dump Backup",
+	.start = 0,
+	.end   = 0,
+	.flags = IORESOURCE_BUSY | IORESOURCE_MEM
+};
+
 /*
  * When kexec transitions to the new kernel there is a one-to-one
  * mapping between physical and virtual addresses.  On processors
_

--=-jl27kn/fL7AFJ7exZAjR--

