Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268238AbUHQNvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268238AbUHQNvb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 09:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268245AbUHQNu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 09:50:57 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:53190 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S268238AbUHQNuq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 09:50:46 -0400
Date: Tue, 17 Aug 2004 15:51:06 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390: core changes.
Message-ID: <20040817135106.GA3192@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: core changes.

From: Jan Glauber <jan.glauber@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>

s390 core changes:
 - Use copy_siginfo_from_user32 instead of copy_from_user to get the
   siginfo structure in sys32_rt_sigqueueinfo.
 - Remove prototype for non-existant stop_timers function.
 - Regenerate default configuration.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/defconfig             |    4 ++--
 arch/s390/kernel/compat_linux.c |    3 +--
 arch/s390/kernel/vtime.c        |    2 +-
 include/asm-s390/timer.h        |    2 --
 4 files changed, 4 insertions(+), 7 deletions(-)

diff -urN linux-2.6/arch/s390/defconfig linux-2.6-s390/arch/s390/defconfig
--- linux-2.6/arch/s390/defconfig	Sat Aug 14 12:56:00 2004
+++ linux-2.6-s390/arch/s390/defconfig	Tue Aug 17 14:38:19 2004
@@ -419,7 +419,6 @@
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
-# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
 # CONFIG_CRAMFS is not set
 # CONFIG_VXFS_FS is not set
 # CONFIG_HPFS_FS is not set
@@ -511,11 +510,12 @@
 # CONFIG_CRYPTO_BLOWFISH is not set
 # CONFIG_CRYPTO_TWOFISH is not set
 # CONFIG_CRYPTO_SERPENT is not set
-# CONFIG_CRYPTO_AES_GENERIC is not set
+# CONFIG_CRYPTO_AES is not set
 # CONFIG_CRYPTO_CAST5 is not set
 # CONFIG_CRYPTO_CAST6 is not set
 # CONFIG_CRYPTO_TEA is not set
 # CONFIG_CRYPTO_ARC4 is not set
+# CONFIG_CRYPTO_KHAZAD is not set
 # CONFIG_CRYPTO_DEFLATE is not set
 # CONFIG_CRYPTO_MICHAEL_MIC is not set
 # CONFIG_CRYPTO_CRC32C is not set
diff -urN linux-2.6/arch/s390/kernel/compat_linux.c linux-2.6-s390/arch/s390/kernel/compat_linux.c
--- linux-2.6/arch/s390/kernel/compat_linux.c	Sat Aug 14 12:55:59 2004
+++ linux-2.6-s390/arch/s390/kernel/compat_linux.c	Tue Aug 17 14:38:19 2004
@@ -725,8 +725,7 @@
 	int ret;
 	mm_segment_t old_fs = get_fs();
 	
-	if (copy_from_user (&info, uinfo, 3*sizeof(int)) ||
-	    copy_from_user (info._sifields._pad, uinfo->_sifields._pad, SI_PAD_SIZE))
+	if (copy_siginfo_from_user32(&info, uinfo))
 		return -EFAULT;
 	set_fs (KERNEL_DS);
 	ret = sys_rt_sigqueueinfo(pid, sig, &info);
diff -urN linux-2.6/arch/s390/kernel/vtime.c linux-2.6-s390/arch/s390/kernel/vtime.c
--- linux-2.6/arch/s390/kernel/vtime.c	Sat Aug 14 12:56:22 2004
+++ linux-2.6-s390/arch/s390/kernel/vtime.c	Tue Aug 17 14:38:19 2004
@@ -21,7 +21,7 @@
 #include <asm/s390_ext.h>
 #include <asm/timer.h>
 
-#define VTIMER_MAGIC (0x4b87ad6e + 1)
+#define VTIMER_MAGIC (TIMER_MAGIC + 1)
 static ext_int_info_t ext_int_info_timer;
 DEFINE_PER_CPU(struct vtimer_queue, virt_cpu_timer);
 
diff -urN linux-2.6/include/asm-s390/timer.h linux-2.6-s390/include/asm-s390/timer.h
--- linux-2.6/include/asm-s390/timer.h	Sat Aug 14 12:54:51 2004
+++ linux-2.6-s390/include/asm-s390/timer.h	Tue Aug 17 14:38:19 2004
@@ -45,6 +45,4 @@
 extern int mod_virt_timer(struct vtimer_list *timer, __u64 expires);
 extern int del_virt_timer(struct vtimer_list *timer);
 
-int stop_timers(void);
-
 #endif
