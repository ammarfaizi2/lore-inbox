Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264906AbUF1Jzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264906AbUF1Jzg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 05:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264908AbUF1Jzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 05:55:36 -0400
Received: from outmx020.isp.belgacom.be ([195.238.2.201]:49623 "EHLO
	outmx020.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S264906AbUF1JzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 05:55:21 -0400
Subject: [PATCH 2.6.7-mm3] cpuflags reviewed
From: FabF <fabian.frederick@skynet.be>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-f3xbstVYLFJwbZfFsLAX"
Message-Id: <1088416506.2395.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 28 Jun 2004 11:55:06 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-f3xbstVYLFJwbZfFsLAX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Andrew,

	Here's cpuflags v2 (x86 version) :

[/proc/cpuflags snippet]
no  sse2
no  ss
no  ht
no  tm
no  ia64
no  pbe
yes syscall
yes mp
no  nx
yes mmxext
no  lm
yes 3dnowext

Regards,
FabF

--=-f3xbstVYLFJwbZfFsLAX
Content-Disposition: attachment; filename=cpuflags2.diff
Content-Type: text/x-patch; name=cpuflags2.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Naur orig~cpuflags/arch/i386/kernel/cpu/proc.c edited~cpuflags/arch/i386/kernel/cpu/proc.c
--- orig~cpuflags/arch/i386/kernel/cpu/proc.c	2004-06-25 00:52:24.000000000 +0200
+++ edited~cpuflags/arch/i386/kernel/cpu/proc.c	2004-06-28 10:47:42.000000000 +0200
@@ -4,57 +4,57 @@
 #include <asm/semaphore.h>
 #include <linux/seq_file.h>
 
+/* 
+ * These flag bits must match the definitions in <asm/cpufeature.h>.
+ * NULL means this bit is undefined or reserved; either way it doesn't
+ * have meaning as far as Linux is concerned.  Note that it's important
+ * to realize there is a difference between this table and CPUID -- if
+ * applications want to get the raw CPUID data, they should access
+ * /dev/cpu/<cpu_nr>/cpuid instead.
+ */
+static char *x86_cap_flags[] = {
+	/* Intel-defined */
+        "fpu", "vme", "de", "pse", "tsc", "msr", "pae", "mce",
+        "cx8", "apic", NULL, "sep", "mtrr", "pge", "mca", "cmov",
+        "pat", "pse36", "pn", "clflush", NULL, "dts", "acpi", "mmx",
+        "fxsr", "sse", "sse2", "ss", "ht", "tm", "ia64", "pbe",
+
+	/* AMD-defined */
+	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+	NULL, NULL, NULL, "syscall", NULL, NULL, NULL, NULL,
+	NULL, NULL, NULL, "mp", "nx", NULL, "mmxext", NULL,
+	NULL, NULL, NULL, NULL, NULL, "lm", "3dnowext", "3dnow",
+
+	/* Transmeta-defined */
+	"recovery", "longrun", NULL, "lrti", NULL, NULL, NULL, NULL,
+	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+
+	/* Other (Linux-defined) */
+	"cxmmx", "k6_mtrr", "cyrix_arr", "centaur_mcr",
+	NULL, NULL, NULL, NULL,
+	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+
+	/* Intel-defined (#2) */
+	"pni", NULL, NULL, "monitor", "ds_cpl", NULL, NULL, "tm2",
+	"est", NULL, "cid", NULL, NULL, NULL, NULL, NULL,
+	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+
+	/* VIA/Cyrix/Centaur-defined */
+	NULL, NULL, "rng", "rng_en", NULL, NULL, "ace", "ace_en",
+	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+};
 /*
  *	Get CPU information for use by the procfs.
  */
 static int show_cpuinfo(struct seq_file *m, void *v)
 {
-	/* 
-	 * These flag bits must match the definitions in <asm/cpufeature.h>.
-	 * NULL means this bit is undefined or reserved; either way it doesn't
-	 * have meaning as far as Linux is concerned.  Note that it's important
-	 * to realize there is a difference between this table and CPUID -- if
-	 * applications want to get the raw CPUID data, they should access
-	 * /dev/cpu/<cpu_nr>/cpuid instead.
-	 */
-	static char *x86_cap_flags[] = {
-		/* Intel-defined */
-	        "fpu", "vme", "de", "pse", "tsc", "msr", "pae", "mce",
-	        "cx8", "apic", NULL, "sep", "mtrr", "pge", "mca", "cmov",
-	        "pat", "pse36", "pn", "clflush", NULL, "dts", "acpi", "mmx",
-	        "fxsr", "sse", "sse2", "ss", "ht", "tm", "ia64", "pbe",
-
-		/* AMD-defined */
-		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
-		NULL, NULL, NULL, "syscall", NULL, NULL, NULL, NULL,
-		NULL, NULL, NULL, "mp", "nx", NULL, "mmxext", NULL,
-		NULL, NULL, NULL, NULL, NULL, "lm", "3dnowext", "3dnow",
-
-		/* Transmeta-defined */
-		"recovery", "longrun", NULL, "lrti", NULL, NULL, NULL, NULL,
-		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
-		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
-		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
-
-		/* Other (Linux-defined) */
-		"cxmmx", "k6_mtrr", "cyrix_arr", "centaur_mcr",
-		NULL, NULL, NULL, NULL,
-		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
-		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
-		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
-
-		/* Intel-defined (#2) */
-		"pni", NULL, NULL, "monitor", "ds_cpl", NULL, NULL, "tm2",
-		"est", NULL, "cid", NULL, NULL, NULL, NULL, NULL,
-		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
-		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
-
-		/* VIA/Cyrix/Centaur-defined */
-		NULL, NULL, "rng", "rng_en", NULL, NULL, "ace", "ace_en",
-		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
-		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
-		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
-	};
 	struct cpuinfo_x86 *c = v;
 	int i, n = c - cpu_data;
 	int fpu_exception;
@@ -144,3 +144,15 @@
 	.stop	= c_stop,
 	.show	= show_cpuinfo,
 };
+int show_cpuflags(char *page)
+{
+	int i,len=0;
+	for ( i = 0 ; i < 32*NCAPINTS ; i++ )
+		if ( x86_cap_flags[i] != NULL ){
+			if ( test_bit(i, cpu_data[0].x86_capability) )
+				len+=sprintf(page+len, "yes");
+			  else  len+=sprintf(page+len, "no ");	
+			len+=sprintf(page+len, " %s\n", x86_cap_flags[i]);
+		}
+	return len;
+}
diff -Naur orig~cpuflags/fs/proc/proc_misc.c edited~cpuflags/fs/proc/proc_misc.c
--- orig~cpuflags/fs/proc/proc_misc.c	2004-06-25 00:53:20.000000000 +0200
+++ edited~cpuflags/fs/proc/proc_misc.c	2004-06-26 13:54:22.000000000 +0200
@@ -66,6 +66,7 @@
 extern int get_exec_domain_list(char *);
 extern int get_dma_list(char *);
 extern int get_locks_status (char *, char **, off_t, int);
+extern int show_cpuflags (char *);
 
 static int proc_calc_metrics(char *page, char **start, off_t off,
 				 int count, int *eof, int len)
@@ -149,6 +150,18 @@
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
 
+static int cpuflags_read_proc(char *page, char **start, off_t off,
+				 int count, int *eof, void *data)
+{
+	int len;
+#ifdef CONFIG_X86
+	len=show_cpuflags(page);
+	return proc_calc_metrics(page, start, off, count, eof, len);
+#endif
+	return 0;
+
+}
+
 static int meminfo_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
@@ -677,6 +690,7 @@
 		{"loadavg",     loadavg_read_proc},
 		{"uptime",	uptime_read_proc},
 		{"meminfo",	meminfo_read_proc},
+		{"cpuflags",	cpuflags_read_proc},
 		{"version",	version_read_proc},
 #ifdef CONFIG_PROC_HARDWARE
 		{"hardware",	hardware_read_proc},

--=-f3xbstVYLFJwbZfFsLAX--

