Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263969AbUDGVSe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 17:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264041AbUDGVSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 17:18:33 -0400
Received: from mx1.actcom.net.il ([192.114.47.13]:4777 "EHLO
	smtp1.actcom.co.il") by vger.kernel.org with ESMTP id S263969AbUDGVS1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 17:18:27 -0400
Date: Thu, 8 Apr 2004 00:18:15 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>
Subject: [PATCH] remove %n printf format specifier support from vsprintf.c
Message-ID: <20040407211814.GV28202@mulix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

This patch removes support for the %n format specifier from
vsprintf, remove the sole use of %n in the kernel, fixes seq_printf to
return the number of characters written rather than 0 on success
(thus getting rid of %n), and fixes the only two callers of seq_printf
who bothered to look at the return value.  

The printf man page has this to say about '%n': 

"The number of characters written so far is stored into the integer
indicated by the int * (or variant) pointer argument.  No argument is
converted." 

Very little code actually uses %n for that. These days, %n has a much
more common use - in printf format string exploits. Since there's only
one user of %n in the kernel, this patch removes support for it and
fixes the user. To preempt the obvious argument, I agree that printk
should look and behave as much as possible as printf - except where
it's harmful. We don't support floating point, for example, and I
doubt we should support %n - although I don't strongly care one way or
another. 

The patch is a bit more intrusive than I would've
liked. fs/proc/task_mmu.c:show_map() called seq_printf with %n, in
order to calculate the proper number of spaces to add in each line in
the /proc/$PID/map output for named maps. I changed seq_printf to
return the number of characters written (not including the final \0)
as returned from vcnsprintf. This required two changes to the only two
callers of seq_printf who bothered to check the return value. One of
them (cris/arch-v10/kernel/setup.c) was trivial, and the other
(arch/i386/kernel/cpu/mtrr/if.c) didn't do anything with the return
value anyway. 

Patch is against 2.6.5-rc3, compiles and tested. Please apply if you
consider it appropriate.. 

diff -Naurb -X /home/muli/w/dontdiff linux-2.5/arch/cris/arch-v10/kernel/setup.c 2.6.5-rc3-pn/arch/cris/arch-v10/kernel/setup.c
--- linux-2.5/arch/cris/arch-v10/kernel/setup.c	2003-07-10 20:33:07.000000000 +0300
+++ 2.6.5-rc3-pn/arch/cris/arch-v10/kernel/setup.c	2004-04-06 11:09:15.000000000 +0200
@@ -52,6 +52,7 @@
 {
 	unsigned long revision;
 	struct cpu_info *info;
+	int i;
 
 	/* read the version register in the CPU and print some stuff */
 
@@ -62,7 +63,7 @@
 	else
 		info = &cpu_info[revision];
 
-	return seq_printf(m,
+	i = seq_printf(m,
 		       "processor\t: 0\n" 
 		       "cpu\t\t: CRIS\n"
 		       "cpu revision\t: %lu\n"
@@ -91,6 +92,7 @@
 		       info->flags & HAS_USB ? "yes" : "no",
 		       (loops_per_jiffy * HZ + 500) / 500000,
 		       ((loops_per_jiffy * HZ + 500) / 5000) % 100);
+	return (i < 0) ? i : 0;
 }
 
 #endif /* CONFIG_PROC_FS */
diff -Naurb -X /home/muli/w/dontdiff linux-2.5/arch/i386/kernel/cpu/mtrr/if.c 2.6.5-rc3-pn/arch/i386/kernel/cpu/mtrr/if.c
--- linux-2.5/arch/i386/kernel/cpu/mtrr/if.c	2004-01-31 19:45:38.000000000 +0200
+++ 2.6.5-rc3-pn/arch/i386/kernel/cpu/mtrr/if.c	2004-04-06 11:10:08.000000000 +0200
@@ -320,12 +320,11 @@
 static int mtrr_seq_show(struct seq_file *seq, void *offset)
 {
 	char factor;
-	int i, max, len;
+	int i, max;
 	mtrr_type type;
 	unsigned long base;
 	unsigned int size;
 
-	len = 0;
 	max = num_var_ranges;
 	for (i = 0; i < max; i++) {
 		mtrr_if->get(i, &base, &size, &type);
@@ -341,7 +340,7 @@
 				size >>= 20 - PAGE_SHIFT;
 			}
 			/* RED-PEN: base can be > 32bit */ 
-			len += seq_printf(seq, 
+			seq_printf(seq,
 				   "reg%02i: base=0x%05lx000 (%4liMB), size=%4i%cB: %s, count=%d\n",
 			     i, base, base >> (20 - PAGE_SHIFT), size, factor,
 			     mtrr_attrib_to_str(type), usage_table[i]);
diff -Naurb -X /home/muli/w/dontdiff linux-2.5/fs/proc/task_mmu.c 2.6.5-rc3-pn/fs/proc/task_mmu.c
--- linux-2.5/fs/proc/task_mmu.c	2004-01-20 19:20:25.000000000 +0200
+++ 2.6.5-rc3-pn/fs/proc/task_mmu.c	2004-04-06 11:11:33.000000000 +0200
@@ -91,7 +91,7 @@
 		ino = inode->i_ino;
 	}
 
-	seq_printf(m, "%08lx-%08lx %c%c%c%c %08lx %02x:%02x %lu %n",
+	len = seq_printf(m, "%08lx-%08lx %c%c%c%c %08lx %02x:%02x %lu ",
 			map->vm_start,
 			map->vm_end,
 			flags & VM_READ ? 'r' : '-',
@@ -99,7 +99,9 @@
 			flags & VM_EXEC ? 'x' : '-',
 			flags & VM_MAYSHARE ? 's' : 'p',
 			map->vm_pgoff << PAGE_SHIFT,
-			MAJOR(dev), MINOR(dev), ino, &len);
+			MAJOR(dev), MINOR(dev), ino);
+	if (len < 0)
+		return 0;
 
 	if (map->vm_file) {
 		len = 25 + sizeof(void*) * 6 - len;
diff -Naurb -X /home/muli/w/dontdiff linux-2.5/fs/seq_file.c 2.6.5-rc3-pn/fs/seq_file.c
--- linux-2.5/fs/seq_file.c	2003-10-02 02:26:24.000000000 +0300
+++ 2.6.5-rc3-pn/fs/seq_file.c	2004-04-06 11:11:10.000000000 +0200
@@ -290,6 +290,16 @@
 
 EXPORT_SYMBOL(seq_escape);
 
+/**
+ *	seq_printf -	Format a string and place it in a buffer
+ *	@m:	Target buffer
+ *	@f:	Printf format string
+ *      @...:   Arguments for the format string
+ *
+ * The return value is the number of characters which have been written into
+ * the buffer @m not including the trailing '\0'. If the buffer is too small,
+ * -1 is returned.
+ */
 int seq_printf(struct seq_file *m, const char *f, ...)
 {
 	va_list args;
@@ -297,11 +307,11 @@
 
 	if (m->count < m->size) {
 		va_start(args, f);
-		len = vsnprintf(m->buf + m->count, m->size - m->count, f, args);
+		len = vscnprintf(m->buf + m->count, m->size - m->count, f, args);
 		va_end(args);
 		if (m->count + len < m->size) {
 			m->count += len;
-			return 0;
+			return len;
 		}
 	}
 	m->count = m->size;
diff -Naurb -X /home/muli/w/dontdiff linux-2.5/lib/vsprintf.c 2.6.5-rc3-pn/lib/vsprintf.c
--- linux-2.5/lib/vsprintf.c	2004-04-06 11:34:50.000000000 +0200
+++ 2.6.5-rc3-pn/lib/vsprintf.c	2004-04-06 11:36:23.000000000 +0200
@@ -14,6 +14,9 @@
  * - changed to provide snprintf and vsnprintf functions
  * So Feb  1 16:51:32 CET 2004 Juergen Quade <quade@hsnr.de>
  * - scnprintf and vscnprintf
+ * Sat Mar 20 22:38:09 2004 Muli Ben-Yehuda <mulix@mulix.org>
+ * - remove '%n' support from vsnprintf, as nothing is using it, and it 
+ *   has very few legitimate uses (and many many illegitimate ones)
  */
 
 #include <stdarg.h>
@@ -401,22 +404,6 @@
 						16, field_width, precision, flags);
 				continue;
 
-
-			case 'n':
-				/* FIXME:
-				* What does C99 say about the overflow case here? */
-				if (qualifier == 'l') {
-					long * ip = va_arg(args, long *);
-					*ip = (str - buf);
-				} else if (qualifier == 'Z' || qualifier == 'z') {
-					size_t * ip = va_arg(args, size_t *);
-					*ip = (str - buf);
-				} else {
-					int * ip = va_arg(args, int *);
-					*ip = (str - buf);
-				}
-				continue;
-
 			case '%':
 				if (str <= end)
 					*str = '%';
-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

