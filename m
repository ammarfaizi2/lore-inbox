Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263210AbUKTXoy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263210AbUKTXoy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 18:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263192AbUKTXob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 18:44:31 -0500
Received: from ozlabs.org ([203.10.76.45]:14760 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263230AbUKTXTq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 18:19:46 -0500
Date: Sun, 21 Nov 2004 10:16:36 +1100
From: Anton Blanchard <anton@samba.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: Bad IPC shared memory defaults
Message-ID: <20041120231636.GE11932@krispykreme.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Ive debugged a number of problems which have turned out to be bad shmmax
and shmall settings. The default for shmmax of 32MB is way too low these
days.

To further complicate matters, shmmax is in bytes but shmall is in
pages. Considering some architectures (eg ia64) has a variable base page
size, an interface in pages is a bad idea. Too late now.

Is there a reason we set the defaults so low? Cant our VM handle shared
memory just fine? If so we should just initialise these defaults to
something sane. In this patch I set it to cover all of memory which
means we should never see one of these fails again.

Anton

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -puN include/linux/shm.h~shm_fixes include/linux/shm.h
--- gr_work/include/linux/shm.h~shm_fixes	2004-11-20 16:56:29.972061609 -0600
+++ gr_work-anton/include/linux/shm.h	2004-11-20 16:56:30.013054658 -0600
@@ -6,14 +6,14 @@
 #include <asm/page.h>
 
 /*
- * SHMMAX, SHMMNI and SHMALL are upper limits are defaults which can
- * be increased by sysctl
+ * SHMMNI sets the maximum number of shared memory segments and can be
+ * increased via the shmmni sysctl. Both shmmax (which specifies the maximum
+ * amount of memory in bytes per shared memory segment) and shmall (which
+ * specifiies the maximum amount of shared memory in pages across all
+ * processes) is sized at runtime based on total memory.
  */
-
-#define SHMMAX 0x2000000		 /* max shared seg size (bytes) */
 #define SHMMIN 1			 /* min shared seg size (bytes) */
 #define SHMMNI 4096			 /* max num of segs system wide */
-#define SHMALL (SHMMAX/PAGE_SIZE*(SHMMNI/16)) /* max shm system wide (pages) */
 #define SHMSEG SHMMNI			 /* max shared segs per process */
 
 #include <asm/shmparam.h>
diff -puN ipc/shm.c~shm_fixes ipc/shm.c
--- gr_work/ipc/shm.c~shm_fixes	2004-11-20 16:56:30.003056354 -0600
+++ gr_work-anton/ipc/shm.c	2004-11-20 16:58:13.334244383 -0600
@@ -27,6 +27,7 @@
 #include <linux/shmem_fs.h>
 #include <linux/security.h>
 #include <linux/syscalls.h>
+#include <linux/bootmem.h>
 #include <asm/uaccess.h>
 
 #include "util.h"
@@ -51,14 +52,17 @@ static void shm_close (struct vm_area_st
 static int sysvipc_shm_read_proc(char *buffer, char **start, off_t offset, int length, int *eof, void *data);
 #endif
 
-size_t	shm_ctlmax = SHMMAX;
-size_t 	shm_ctlall = SHMALL;
+size_t	shm_ctlmax;
+size_t 	shm_ctlall;
 int 	shm_ctlmni = SHMMNI;
 
 static int shm_tot; /* total number of shared memory pages */
 
 void __init shm_init (void)
 {
+	shm_ctlmax = nr_all_pages * PAGE_SIZE;
+	shm_ctlall = nr_all_pages;
+
 	ipc_init_ids(&shm_ids, 1);
 #ifdef CONFIG_PROC_FS
 	create_proc_read_entry("sysvipc/shm", 0, NULL, sysvipc_shm_read_proc, NULL);
_

