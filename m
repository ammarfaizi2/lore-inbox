Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267754AbUIBHZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267754AbUIBHZa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 03:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267767AbUIBHZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 03:25:30 -0400
Received: from gate.crashing.org ([63.228.1.57]:46477 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267754AbUIBHZ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 03:25:26 -0400
Subject: [PATCH] Quick fix for AUXV problem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Message-Id: <1094109526.2579.39.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 02 Sep 2004 17:18:47 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 ... but a better solution should probably be found, that's saved_auxv
in struct mm_struct is ... hrm... disgusting at least ;)

So the problem is that we currently do

	unsigned long saved_auxv[40];

That is we assume that all archs will have an AUXV entry of no more than
2 unsigned longs and we'll have no more than 20 entries in the table.

Unfortunately, this is wrong.

PPC/PPC64 adds 5 platform entries. then we add 14 in the common code,
and then we have 

	if (k_platform) {
		NEW_AUX_ENT(AT_PLATFORM, (elf_addr_t)(unsigned long)u_platform);
	}
	if (bprm->interp_flags & BINPRM_FLAGS_EXECFD) {
		NEW_AUX_ENT(AT_EXECFD, (elf_addr_t) bprm->interp_data);
	}

which may add a 20th entry... which means we are already out of room for
the terminating AT_NULL entry... bad bad bad.

Now I'm adding AT_SYSINFO_EHDR to ppc/ppc64 and it breaks all the time.

The quick fix is to bump the number of entries in struct mm_struct to 42,
though that's worth a big BOLD comment in binfmt_elf in case anybody adds
a new entry in there. (Patch below). I wonder if we shouldn't add a
ARCH_MAX_AUXV_ENTRIES macro to the asm-arch/elf.h though to get the max
amount of entry the arch may add to the normal count, and have the mm
struct array use that plus the number of "normal" entries...

Ben.

This patch increase the max amount of auxv entries in struct mm_struct
to 42 so that ppc & ppc64 don't get a chance to blow the array up.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

===== include/linux/sched.h 1.245 vs edited =====
--- 1.245/include/linux/sched.h	2004-08-26 10:37:26 +10:00
+++ edited/include/linux/sched.h	2004-09-02 17:17:31 +10:00
@@ -227,7 +227,7 @@
 	unsigned long rss, total_vm, locked_vm;
 	unsigned long def_flags;
 
-	unsigned long saved_auxv[40]; /* for /proc/PID/auxv */
+	unsigned long saved_auxv[42]; /* for /proc/PID/auxv */
 
 	unsigned dumpable:1;
 	cpumask_t cpu_vm_mask;
  

