Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269734AbRHDBAx>; Fri, 3 Aug 2001 21:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269733AbRHDBAn>; Fri, 3 Aug 2001 21:00:43 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:65011 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S269731AbRHDBAc>; Fri, 3 Aug 2001 21:00:32 -0400
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesc@sequent.com>
Reply-To: jamesc@sequent.com
Organization: IBM NUMA
To: linux-kernel@vger.kernel.org
Subject: [RFC] Buffer overflow in cpuinfo_read_proc()/get_cpuinfo()
Date: Fri, 3 Aug 2001 18:00:33 -0700
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <0108031800330E.14814@w-jamesc.des.beaverton.ibm.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

When testing a 12 CPU i386 box, mbligh found a buffer overflow in
/proc/cpuinfo that would do nasty things like clobber page tables, etc.
While the generic procfs read routine is careful to pass buffer sizes to
called functions, cpuinfo_read_proc() doesn't pass them on to the
arch-specific get_cpuinfo() functions.  These funcs blindly fill the
buffer (one page) with info on all CPUs.

Proposed solution:  Make get_cpuinfo() only return info on one CPU at a
time.  Add an extra pointer argument for the CPU number in/out of it.
Enhance cpuinfo_read_proc() to pay attention to buffer sizes.  Also,
comment some of the implied limits on procfs read functions.

An example conversion of get_cpuinfo() for i386 is enclosed.  Sorry
about the size of the setup.c patch.  Removing the loop changed the
indentation one tab stop.

What do you think?

				    Thanks,

				James Cleverdon

PS:  I just was tapped for a business trip, so my email coverage will be 
spotty for the next couple of days.


--- arch/i386/kernel/setup.c.df	Fri May 25 17:07:09 2001
+++ arch/i386/kernel/setup.c	Fri Aug  3 15:07:42 2001
@@ -2342,12 +2342,25 @@
 }
 
 /*
- *	Get CPU information for use by the procfs.
+ * get_cpuinfo - Get information on one CPU for use by the procfs.
+ *
+ *	Prints info on the next CPU into buffer.  Beware, doesn't check for
+ *	buffer overflow.  Current implementation of procfs assumes that the
+ *	resulting data is <= 1K.
+ *
+ * Args:
+ *	buffer	-- you guessed it, the data buffer
+ *	cpu_np	-- Input: next cpu to get (start at 0).  Output: Updated.
+ *
+ *	Returns number of bytes written to buffer.
  */
 
-int get_cpuinfo(char * buffer)
+int get_cpuinfo(char *buffer, unsigned *cpu_np)
 {
 	char *p = buffer;
+	struct cpuinfo_x86 *c;
+	unsigned n;
+	int i, fpu_exception;
 
 	/* 
 	 * These flag bits must match the definitions in <asm/cpufeature.h>.
@@ -2382,70 +2395,73 @@
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 	};
-	struct cpuinfo_x86 *c = cpu_data;
-	int i, n;
 
-	for (n = 0; n < NR_CPUS; n++, c++) {
-		int fpu_exception;
-#ifdef CONFIG_SMP
-		if (!(cpu_online_map & (1<<n)))
-			continue;
-#endif
-		p += sprintf(p,"processor\t: %d\n"
-			"vendor_id\t: %s\n"
-			"cpu family\t: %d\n"
-			"model\t\t: %d\n"
-			"model name\t: %s\n",
-			n,
-			c->x86_vendor_id[0] ? c->x86_vendor_id : "unknown",
-			c->x86,
-			c->x86_model,
-			c->x86_model_id[0] ? c->x86_model_id : "unknown");
-
-		if (c->x86_mask || c->cpuid_level >= 0)
-			p += sprintf(p, "stepping\t: %d\n", c->x86_mask);
-		else
-			p += sprintf(p, "stepping\t: unknown\n");
-
-		if ( test_bit(X86_FEATURE_TSC, &c->x86_capability) ) {
-			p += sprintf(p, "cpu MHz\t\t: %lu.%03lu\n",
-				cpu_khz / 1000, (cpu_khz % 1000));
-		}
-
-		/* Cache size */
-		if (c->x86_cache_size >= 0)
-			p += sprintf(p, "cache size\t: %d KB\n", c->x86_cache_size);
-		
-		/* We use exception 16 if we have hardware math and we've either seen it 
or the CPU claims it is internal */
-		fpu_exception = c->hard_math && (ignore_irq13 || cpu_has_fpu);
-		p += sprintf(p, "fdiv_bug\t: %s\n"
-			        "hlt_bug\t\t: %s\n"
-			        "f00f_bug\t: %s\n"
-			        "coma_bug\t: %s\n"
-			        "fpu\t\t: %s\n"
-			        "fpu_exception\t: %s\n"
-			        "cpuid level\t: %d\n"
-			        "wp\t\t: %s\n"
-			        "flags\t\t:",
-			     c->fdiv_bug ? "yes" : "no",
-			     c->hlt_works_ok ? "no" : "yes",
-			     c->f00f_bug ? "yes" : "no",
-			     c->coma_bug ? "yes" : "no",
-			     c->hard_math ? "yes" : "no",
-			     fpu_exception ? "yes" : "no",
-			     c->cpuid_level,
-			     c->wp_works_ok ? "yes" : "no");
-
-		for ( i = 0 ; i < 32*NCAPINTS ; i++ )
-			if ( test_bit(i, &c->x86_capability) &&
-			     x86_cap_flags[i] != NULL )
-				p += sprintf(p, " %s", x86_cap_flags[i]);
-
-		p += sprintf(p, "\nbogomips\t: %lu.%02lu\n\n",
-			     c->loops_per_jiffy/(500000/HZ),
-			     (c->loops_per_jiffy/(5000/HZ)) % 100);
+	n = *cpu_np;
+	while (n < NR_CPUS && (cpu_online_map & (1 << n)) == 0) {
+		++n;
 	}
-	return p - buffer;
+	if (n >= NR_CPUS) {
+		*cpu_np = NR_CPUS;
+		return (0);
+	}
+	*cpu_np = n + 1;
+	c = &cpu_data[n];
+
+	p += sprintf(p, "processor\t: %d\n"
+		"vendor_id\t: %s\n"
+		"cpu family\t: %d\n"
+		"model\t\t: %d\n"
+		"model name\t: %s\n",
+		n,
+		c->x86_vendor_id[0] ? c->x86_vendor_id : "unknown",
+		c->x86,
+		c->x86_model,
+		c->x86_model_id[0] ? c->x86_model_id : "unknown");
+
+	if (c->x86_mask || c->cpuid_level >= 0)
+		p += sprintf(p, "stepping\t: %d\n", c->x86_mask);
+	else
+		p += sprintf(p, "stepping\t: unknown\n");
+
+	if ( test_bit(X86_FEATURE_TSC, &c->x86_capability) ) {
+		p += sprintf(p, "cpu MHz\t\t: %lu.%03lu\n",
+			cpu_khz / 1000, (cpu_khz % 1000));
+	}
+
+	/* Cache size */
+	if (c->x86_cache_size >= 0)
+		p += sprintf(p, "cache size\t: %d KB\n", c->x86_cache_size);
+	
+	/* We use exception 16 if we have hardware math and we've either seen it or 
the CPU claims it is internal */
+	fpu_exception = c->hard_math && (ignore_irq13 || cpu_has_fpu);
+	p += sprintf(p, "fdiv_bug\t: %s\n"
+			"hlt_bug\t\t: %s\n"
+			"f00f_bug\t: %s\n"
+			"coma_bug\t: %s\n"
+			"fpu\t\t: %s\n"
+			"fpu_exception\t: %s\n"
+			"cpuid level\t: %d\n"
+			"wp\t\t: %s\n"
+			"flags\t\t:",
+		     c->fdiv_bug ? "yes" : "no",
+		     c->hlt_works_ok ? "no" : "yes",
+		     c->f00f_bug ? "yes" : "no",
+		     c->coma_bug ? "yes" : "no",
+		     c->hard_math ? "yes" : "no",
+		     fpu_exception ? "yes" : "no",
+		     c->cpuid_level,
+		     c->wp_works_ok ? "yes" : "no");
+
+	for ( i = 0 ; i < 32*NCAPINTS ; i++ )
+		if ( test_bit(i, &c->x86_capability) &&
+		     x86_cap_flags[i] != NULL )
+			p += sprintf(p, " %s", x86_cap_flags[i]);
+
+	p += sprintf(p, "\nbogomips\t: %lu.%02lu\n\n",
+		     c->loops_per_jiffy/(500000/HZ),
+		     (c->loops_per_jiffy/(5000/HZ)) % 100);
+
+	return (p - buffer);
 }
 
 static unsigned long cpu_initialized __initdata = 0;
--- fs/proc/proc_misc.c.df	Fri Apr 13 20:26:07 2001
+++ fs/proc/proc_misc.c	Fri Aug  3 14:47:24 2001
@@ -49,7 +49,7 @@
  * have a way to deal with that gracefully. Right now I used straightforward
  * wrappers, but this needs further analysis wrt potential overflows.
  */
-extern int get_cpuinfo(char *);
+extern int get_cpuinfo(char *, unsigned *);
 extern int get_hardware_list(char *);
 extern int get_stram_list(char *);
 #ifdef CONFIG_DEBUG_MALLOC
@@ -208,11 +208,52 @@
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
 
+/*
+ * cpuinfo_read_proc -- do /proc/cpuinfo
+ *
+ * Notes:
+ * 1) All procfs read functions are called with a count <= PAGE_SIZE - 1024.
+ *    We assume that get_cpuinfo() will add no more than 1K to the buffer per
+ *    call, else it will overflow the page and all is lost.
+ *
+ * 2) Yes, this routine is very inefficient if called with a small buffer or 
a
+ *    large number of CPUs, since subsequent calls will fast-forward through
+ *    all previous cpuinfos to get to the current one.  Since we're using
+ *    sprintf in the arch-specific get_cpuinfo functions, I can't see how
+ *    performance is a major criterion.
+ */
 static int cpuinfo_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
-	int len = get_cpuinfo(page);
-	return proc_calc_metrics(page, start, off, count, eof, len);
+	unsigned cpu_num = 0;
+	off_t	my_off = 0;	/* Page window's "offset". */
+	int	len, cnt;
+	char	*p;
+	char	fast_forward;	/* If true, skip previously returned data. */
+
+	fast_forward = (char)(off > 0);
+	*start = p = page;
+	cnt = count;
+
+	while ((len = get_cpuinfo(p, &cpu_num)) > 0) {
+		my_off += len;
+		if (my_off <= off)
+			continue;			/* Skip this one. */
+		if (fast_forward) {
+			fast_forward = 0;
+			*start = page + (off - (my_off - len));
+		}
+		p += len;
+		cnt -= len;
+		if (cnt <= 0)
+			break;				/* Done. */
+	}
+	if (len == 0)
+		*eof = 1;
+	len = (p - *start);
+	if (len > count)
+		len = count;
+	return len;
 }
 
 #ifdef CONFIG_PROC_HARDWARE


-- 
James Cleverdon, IBM xSeries Platform (NUMA), Beaverton
jamesc@sequent.com  |  cleverdj@us.ibm.com

