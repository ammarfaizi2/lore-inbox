Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbUCKP0H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 10:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbUCKP0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 10:26:04 -0500
Received: from holomorphy.com ([207.189.100.168]:55568 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261422AbUCKPXw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 10:23:52 -0500
Date: Thu, 11 Mar 2004 07:23:46 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1
Message-ID: <20040311152346.GV655@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040310233140.3ce99610.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040310233140.3ce99610.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2004 at 11:31:40PM -0800, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.4/2.6.4-mm1/
> - The CPU scheduler changes in -mm (sched-domains) have been hanging about
>   for too long.  I had been hoping that the people who care about SMT and
>   NUMA performance would have some results by now but all seems to be silent.

Looks like some ppl punted on arch code sweeps. Results of one-off
fixing for a box with a couple of spindles in its boot bay to check
out the writeback and unplug goodies below.


-- wli


diff -urpN mm1-2.6.4-2/arch/sparc64/kernel/process.c mm1-2.6.4-3/arch/sparc64/kernel/process.c
--- mm1-2.6.4-2/arch/sparc64/kernel/process.c	2004-03-11 04:57:42.631636000 -0800
+++ mm1-2.6.4-3/arch/sparc64/kernel/process.c	2004-03-11 06:13:09.250485000 -0800
@@ -41,6 +41,7 @@
 #include <asm/fpumacro.h>
 #include <asm/head.h>
 #include <asm/cpudata.h>
+#include <asm/unistd.h>
 
 /* #define VERBOSE_SHOWREGS */
 
diff -urpN mm1-2.6.4-2/fs/compat_ioctl.c mm1-2.6.4-3/fs/compat_ioctl.c
--- mm1-2.6.4-2/fs/compat_ioctl.c	2004-03-10 18:55:45.000000000 -0800
+++ mm1-2.6.4-3/fs/compat_ioctl.c	2004-03-11 06:32:16.431087000 -0800
@@ -1604,7 +1604,7 @@ static int vt_check(struct file *file)
 	 * To have permissions to do most of the vt ioctls, we either have
 	 * to be the owner of the tty, or super-user.
 	 */
-	if (current->tty == tty || capable(CAP_SYS_ADMIN))
+	if (current->signal->tty == tty || capable(CAP_SYS_ADMIN))
 		return 1;
 	return 0;                                                    
 }
diff -urpN mm1-2.6.4-2/fs/proc/proc_misc.c mm1-2.6.4-3/fs/proc/proc_misc.c
--- mm1-2.6.4-2/fs/proc/proc_misc.c	2004-03-11 04:58:08.151756000 -0800
+++ mm1-2.6.4-3/fs/proc/proc_misc.c	2004-03-11 06:37:27.426809000 -0800
@@ -383,13 +383,13 @@ int show_stat(struct seq_file *p, void *
 	}
 
 	seq_printf(p, "cpu  %llu %llu %llu %llu %llu %llu %llu\n",
-		jiffies_64_to_clock_t(user),
-		jiffies_64_to_clock_t(nice),
-		jiffies_64_to_clock_t(system),
-		jiffies_64_to_clock_t(idle),
-		jiffies_64_to_clock_t(iowait),
-		jiffies_64_to_clock_t(irq),
-		jiffies_64_to_clock_t(softirq));
+		(unsigned long long)jiffies_64_to_clock_t(user),
+		(unsigned long long)jiffies_64_to_clock_t(nice),
+		(unsigned long long)jiffies_64_to_clock_t(system),
+		(unsigned long long)jiffies_64_to_clock_t(idle),
+		(unsigned long long)jiffies_64_to_clock_t(iowait),
+		(unsigned long long)jiffies_64_to_clock_t(irq),
+		(unsigned long long)jiffies_64_to_clock_t(softirq));
 	for_each_cpu(i) {
 		/* two separate calls here to work around gcc-2.95.3 ICE */
 		seq_printf(p, "cpu%d %llu %llu %llu ",
@@ -410,7 +410,7 @@ int show_stat(struct seq_file *p, void *
 			(unsigned long long)
 			  jiffies_64_to_clock_t(kstat_cpu(i).cpustat.softirq));
 	}
-	seq_printf(p, "intr %llu", sum);
+	seq_printf(p, "intr %llu", (unsigned long long)sum);
 
 #if !defined(CONFIG_PPC64) && !defined(CONFIG_ALPHA)
 	for (i = 0; i < NR_IRQS; i++)
diff -urpN mm1-2.6.4-2/fs/udf/super.c mm1-2.6.4-3/fs/udf/super.c
--- mm1-2.6.4-2/fs/udf/super.c	2004-03-11 04:58:08.573692000 -0800
+++ mm1-2.6.4-3/fs/udf/super.c	2004-03-11 06:10:50.507577000 -0800
@@ -57,6 +57,7 @@
 #include <linux/smp_lock.h>
 #include <linux/buffer_head.h>
 #include <linux/vfs.h>
+#include <linux/vmalloc.h>
 #include <asm/byteorder.h>
 
 #include <linux/udf_fs.h>
diff -urpN mm1-2.6.4-2/include/asm-sparc64/compat.h mm1-2.6.4-3/include/asm-sparc64/compat.h
--- mm1-2.6.4-2/include/asm-sparc64/compat.h	2004-03-10 18:55:34.000000000 -0800
+++ mm1-2.6.4-3/include/asm-sparc64/compat.h	2004-03-11 06:11:53.214045000 -0800
@@ -29,6 +29,7 @@ typedef s32		compat_int_t;
 typedef s32		compat_long_t;
 typedef u32		compat_uint_t;
 typedef u32		compat_ulong_t;
+typedef u32		compat_timer_t;
 
 struct compat_timespec {
 	compat_time_t	tv_sec;
diff -urpN mm1-2.6.4-2/include/asm-sparc64/pgtable.h mm1-2.6.4-3/include/asm-sparc64/pgtable.h
--- mm1-2.6.4-2/include/asm-sparc64/pgtable.h	2004-03-10 18:55:21.000000000 -0800
+++ mm1-2.6.4-3/include/asm-sparc64/pgtable.h	2004-03-11 06:27:40.704004000 -0800
@@ -322,9 +322,16 @@ static inline pte_t mk_pte_io(unsigned l
 
 /* File offset in PTE support. */
 #define pte_file(pte)		(pte_val(pte) & _PAGE_FILE)
-#define pte_to_pgoff(pte)	(pte_val(pte) >> PAGE_SHIFT)
-#define pgoff_to_pte(off)	(__pte(((off) << PAGE_SHIFT) | _PAGE_FILE))
-#define PTE_FILE_MAX_BITS	(64UL - PAGE_SHIFT - 1UL)
+#define __pte_to_pgprot(pte) \
+		__pgprot(pte_val(pte) & (_PAGE_READ|_PAGE_WRITE))
+#define __file_pte_to_pgprot(pte) \
+		__pgprot(((pte_val(pte) >> PAGE_SHIFT) & 0x3UL) << 8)
+#define pte_to_pgprot(pte) \
+	(pte_file(pte) ? __file_pte_to_pgprot(pte) : __pte_to_pgprot(pte))
+#define pte_to_pgoff(pte)	(pte_val(pte) >> (PAGE_SHIFT+2))
+#define pgoff_prot_to_pte(off, prot) \
+	(__pte(((off) << (PAGE_SHIFT+2)) | _PAGE_FILE | ((prot >> 8) & 0x3UL)))
+#define PTE_FILE_MAX_BITS	(64UL - PAGE_SHIFT - 3UL)
 
 extern unsigned long prom_virt_to_phys(unsigned long, int *);
 
