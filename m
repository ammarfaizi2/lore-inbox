Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262274AbTKRADx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 19:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262308AbTKRADx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 19:03:53 -0500
Received: from holomorphy.com ([199.26.172.102]:27301 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262274AbTKRADS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 19:03:18 -0500
Date: Mon, 17 Nov 2003 16:03:13 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: format_cpumask()
Message-ID: <20031118000313.GG22764@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Luck, Tony" <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
	akpm@osdl.org
References: <B8E391BBE9FE384DAA4C5C003888BE6F0F37B8@scsmsx401.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F0F37B8@scsmsx401.sc.intel.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> I was trying to make it a NR_CPUS -bit integer with the 
>> highest nybbles
>> printed first. What's your favorite alternative?

On Mon, Nov 17, 2003 at 03:56:34PM -0800, Luck, Tony wrote:
> The prettiest output format I can think of would be
> to pretend that we had enough bits for NR_CPUS.  I.e.
> on a 128 cpu system, cpu0 looks like:
>  00000000000000000000000000000001
> and cpu 127 is:
>  80000000000000000000000000000000
> This is probably the messiest to implement :-(
> -Tony

Okay, how far off from what you want am I on this?

akpm, this also includes two things you mentioned in another reply.


-- wli


===== include/linux/cpumask.h 1.1 vs edited =====
--- 1.1/include/linux/cpumask.h	Mon Aug 18 19:46:23 2003
+++ edited/include/linux/cpumask.h	Mon Nov 17 16:01:20 2003
@@ -68,4 +68,23 @@
 		cpu < NR_CPUS;						\
 		cpu = next_online_cpu(cpu,map))
 
+static inline int format_cpumask(char *buf, cpumask_t cpus)
+{
+	int k, len = 0;
+
+	for (k = sizeof(cpumask_t)/sizeof(long) - 1; k >= 0; --k) {
+		int m;
+		cpumask_t tmp;
+
+		cpus_shift_right(tmp, cpus, BITS_PER_LONG*k);
+		if (BITS_PER_LONG == 32)
+			m = sprintf(buf, "%08lx", cpus_coerce(tmp));
+		else /* BITS_PER_LONG == 64 */
+			m = sprintf(buf, "%016lx", cpus_coerce(tmp));
+		len += m;
+		buf += m;
+	}
+	return len;
+}
+
 #endif /* __LINUX_CPUMASK_H */
===== arch/i386/kernel/irq.c 1.45 vs edited =====
--- 1.45/arch/i386/kernel/irq.c	Wed Oct 22 20:26:34 2003
+++ edited/arch/i386/kernel/irq.c	Mon Nov 17 15:51:39 2003
@@ -949,19 +949,13 @@
 static int irq_affinity_read_proc(char *page, char **start, off_t off,
 			int count, int *eof, void *data)
 {
-	int k, len;
-	cpumask_t tmp = irq_affinity[(long)data];
+	int len;
 
 	if (count < HEX_DIGITS+1)
 		return -EINVAL;
 
-	len = 0;
-	for (k = 0; k < sizeof(cpumask_t)/sizeof(u16); ++k) {
-		int j = sprintf(page, "%04hx", (u16)cpus_coerce(tmp));
-		len += j;
-		page += j;
-		cpus_shift_right(tmp, tmp, 16);
-	}
+	len = format_cpumask(page, irq_affinity[(long)data]);
+	page += len;
 	len += sprintf(page, "\n");
 	return len;
 }
@@ -1000,10 +994,16 @@
 static int prof_cpu_mask_read_proc (char *page, char **start, off_t off,
 			int count, int *eof, void *data)
 {
-	unsigned long *mask = (unsigned long *) data;
+	int len;
+	cpumask_t *mask = (cpumask_t *)data;
+
 	if (count < HEX_DIGITS+1)
 		return -EINVAL;
-	return sprintf (page, "%08lx\n", *mask);
+
+	len = format_cpumask(page, *mask);
+	page += len;
+	len += sprintf (page, "\n");
+	return len;
 }
 
 static int prof_cpu_mask_write_proc (struct file *file, const char __user *buffer,
===== arch/ia64/kernel/irq.c 1.31 vs edited =====
--- 1.31/arch/ia64/kernel/irq.c	Tue Nov  4 11:31:16 2003
+++ edited/arch/ia64/kernel/irq.c	Sun Nov 16 19:07:19 2003
@@ -974,19 +974,13 @@
 static int irq_affinity_read_proc (char *page, char **start, off_t off,
 			int count, int *eof, void *data)
 {
-	int k, len;
-	cpumask_t tmp = irq_affinity[(long)data];
+	int len;
 
 	if (count < HEX_DIGITS+1)
 		return -EINVAL;
 
-	len = 0;
-	for (k = 0; k < sizeof(cpumask_t)/sizeof(u16); ++k) {
-		int j = sprintf(page, "%04hx", (u16)cpus_coerce(tmp));
-		len += j;
-		page += j;
-		cpus_shift_right(tmp, tmp, 16);
-	}
+	len = format_cpumask(page, irq_affinity[(long)data]);
+	page += len;
 	len += sprintf(page, "\n");
 	return len;
 }
@@ -1034,17 +1028,13 @@
 			int count, int *eof, void *data)
 {
 	cpumask_t *mask = (cpumask_t *)data;
-	int k, len = 0;
+	int len;
 
 	if (count < HEX_DIGITS+1)
 		return -EINVAL;
 
-	for (k = 0; k < sizeof(cpumask_t)/sizeof(u16); ++k) {
-		int j = sprintf(page, "%04hx", (u16)cpus_coerce(*mask));
-		len += j;
-		page += j;
-		cpus_shift_right(*mask, *mask, 16);
-	}
+	len = format_cpumask(page, *mask);
+	page += len;
 	len += sprintf(page, "\n");
 	return len;
 }
===== arch/mips/kernel/irq.c 1.14 vs edited =====
--- 1.14/arch/mips/kernel/irq.c	Tue Oct  7 19:53:39 2003
+++ edited/arch/mips/kernel/irq.c	Sun Nov 16 19:07:59 2003
@@ -872,17 +872,13 @@
 static int irq_affinity_read_proc (char *page, char **start, off_t off,
 			int count, int *eof, void *data)
 {
-	int len, k;
-	cpumask_t tmp = irq_affinity[(long)data];
+	int len;
 
 	if (count < HEX_DIGITS+1)
 		return -EINVAL;
-	for (k = 0; k < sizeof(cpumask_t)/sizeof(u16); ++k) {
-		int j = sprintf(page, "%04hx", cpus_coerce(tmp));
-		len += j;
-		page += j;
-		cpus_shift_right(tmp, tmp, 16);
-	}
+
+	len = format_cpumask(page, irq_affinity[(long)data]);
+	page += len;
 	len += sprintf(page, "\n");
 	return len;
 }
@@ -918,19 +914,14 @@
 static int prof_cpu_mask_read_proc (char *page, char **start, off_t off,
 			int count, int *eof, void *data)
 {
-	int len, k;
-	cpumask_t *mask = (cpumask_t *)data, tmp;
+	int len;
+	cpumask_t *mask = (cpumask_t *)data;
 
 	if (count < HEX_DIGITS+1)
 		return -EINVAL;
-	tmp = *mask;
 
-	for (k = 0; k < sizeof(cpumask_t)/sizeof(u16); ++k) {
-		int j = sprintf(page, "%04hx", cpus_coerce(tmp));
-		len += j;
-		page += j;
-		cpus_shift_right(tmp, tmp, 16);
-	}
+	len = format_cpumask(page, *mask);
+	page += len;
 	len += sprintf(page, "\n");
 	return len;
 }
===== arch/ppc/kernel/irq.c 1.33 vs edited =====
--- 1.33/arch/ppc/kernel/irq.c	Tue Oct  7 19:53:39 2003
+++ edited/arch/ppc/kernel/irq.c	Sun Nov 16 19:08:36 2003
@@ -574,19 +574,13 @@
 static int irq_affinity_read_proc (char *page, char **start, off_t off,
 			int count, int *eof, void *data)
 {
-	cpumask_t tmp = irq_affinity[(long)data];
-	int k, len = 0;
+	int len;
 
 	if (count < HEX_DIGITS+1)
 		return -EINVAL;
 
-	for (k = 0; k < sizeof(cpumask_t)/sizeof(u16); ++k) {
-		int j = sprintf(page, "%04hx", (u16)cpus_coerce(tmp));
-		len += j;
-		page += j;
-		cpus_shift_right(tmp, tmp, 16);
-	}
-
+	len = format_cpumask(page, irq_affinity[(long)data]);
+	page += len;
 	len += sprintf(page, "\n");
 	return len;
 }
@@ -665,17 +659,13 @@
 			int count, int *eof, void *data)
 {
 	cpumask_t mask = *(cpumask_t *)data;
-	int k, len = 0;
+	int len;
 
 	if (count < HEX_DIGITS+1)
 		return -EINVAL;
 
-	for (k = 0; k < sizeof(cpumask_t)/sizeof(u16); ++k) {
-		int j = sprintf(page, "%04hx", (u16)cpus_coerce(mask));
-		len += j;
-		page += j;
-		cpus_shift_right(mask, mask, 16);
-	}
+	len = format_cpumask(page, mask);
+	page += len;
 	len += sprintf(page, "\n");
 	return len;
 }
===== arch/ppc64/kernel/irq.c 1.36 vs edited =====
--- 1.36/arch/ppc64/kernel/irq.c	Wed Oct 15 18:43:36 2003
+++ edited/arch/ppc64/kernel/irq.c	Sun Nov 16 19:11:59 2003
@@ -657,18 +657,13 @@
 static int irq_affinity_read_proc (char *page, char **start, off_t off,
 			int count, int *eof, void *data)
 {
-	int k, len;
-	cpumask_t tmp = irq_affinity[(long)data];
+	int len;
 
 	if (count < HEX_DIGITS+1)
 		return -EINVAL;
 
-	for (k = 0; k < sizeof(cpumask_t) / sizeof(u16); ++k) {
-		int j = sprintf(page, "%04hx", (u16)cpus_coerce(tmp));
-		len += j;
-		page += j;
-		cpus_shift_right(tmp, tmp, 16);
-	}
+	len = format_cpumask(page, irq_affinity[(long)data]);
+	page += len;
 	len += sprintf(page, "\n");
 	return len;
 }
@@ -744,10 +739,16 @@
 static int prof_cpu_mask_read_proc (char *page, char **start, off_t off,
 			int count, int *eof, void *data)
 {
-	unsigned long *mask = (unsigned long *) data;
+	int len;
+	cpumask_t *mask = (cpumask_t *) data;
+
 	if (count < HEX_DIGITS+1)
 		return -EINVAL;
-	return sprintf (page, "%08lx\n", *mask);
+
+	len = format_cpumask(page, *mask);
+	page += len;
+	len += sprintf (page, "\n");
+	return len;
 }
 
 static int prof_cpu_mask_write_proc (struct file *file, const char __user *buffer,
===== arch/um/kernel/irq.c 1.11 vs edited =====
--- 1.11/arch/um/kernel/irq.c	Tue Oct  7 19:53:41 2003
+++ edited/arch/um/kernel/irq.c	Sun Nov 16 19:09:06 2003
@@ -577,9 +577,15 @@
 static int irq_affinity_read_proc (char *page, char **start, off_t off,
 			int count, int *eof, void *data)
 {
+	int len;
+
 	if (count < HEX_DIGITS+1)
 		return -EINVAL;
-	return sprintf (page, "%08lx\n", irq_affinity[(long)data]);
+
+	len = format_cpumask(page, irq_affinity[(long)data]);
+	page += len;
+	len += sprinf(page, "\n");
+	return len;
 }
 
 static unsigned int parse_hex_value (const char *buffer,
@@ -652,18 +658,14 @@
 static int prof_cpu_mask_read_proc (char *page, char **start, off_t off,
 			int count, int *eof, void *data)
 {
-	cpumask_t tmp, *mask = (cpumask_t *) data;
-	int k, len = 0;
+	cpumask_t *mask = (cpumask_t *)data;
+	int len;
 
 	if (count < HEX_DIGITS+1)
 		return -EINVAL;
-	tmp = *mask;
-	for (k = 0; k < sizeof(cpumask_t)/sizeof(u16); ++k) {
-		int j = sprintf(page, "%04hx", cpus_coerce(tmp));
-		len += j;
-		page += j;
-		cpus_shift_right(tmp, tmp, 16);
-	}
+
+	len = format_cpumask(page, *mask);
+	page += len;
 	len += sprintf(page, "\n");
 	return len;
 }
===== arch/x86_64/kernel/irq.c 1.18 vs edited =====
--- 1.18/arch/x86_64/kernel/irq.c	Tue Oct  7 19:53:42 2003
+++ edited/arch/x86_64/kernel/irq.c	Sun Nov 16 19:12:18 2003
@@ -850,18 +850,13 @@
 static int irq_affinity_read_proc (char *page, char **start, off_t off,
 			int count, int *eof, void *data)
 {
-	int k, len;
-	cpumask_t tmp = irq_affinity[(long)data];
+	int len;
 
 	if (count < HEX_DIGITS+1)
 		return -EINVAL;
 
-	for (k = len = 0; k < sizeof(cpumask_t)/sizeof(u16); ++k) {
-		int j = sprintf(page, "%04hx", (u16)cpus_coerce(tmp));
-		len += j;
-		page += j;
-		cpus_shift_right(tmp, tmp, 16);
-	}
+	len = format_cpumask(page, irq_affinity[(long)data]);
+	page += len;
 	len += sprintf(page, "\n");
 	return len;
 }
@@ -897,19 +892,14 @@
 static int prof_cpu_mask_read_proc (char *page, char **start, off_t off,
 			int count, int *eof, void *data)
 {
-	cpumask_t tmp, *mask = (cpumask_t *) data;
-	int k, len;
+	cpumask_t *mask = (cpumask_t *)data;
+	int len;
 
 	if (count < HEX_DIGITS+1)
 		return -EINVAL;
 
-	tmp = *mask;
-	for (k = len = 0; k < sizeof(cpumask_t)/sizeof(u16); ++k) {
-		int j = sprintf(page, "%04hx", (u16)cpus_coerce(tmp));
-		len += j;
-		page += j;
-		cpus_shift_right(tmp, tmp, 16);
-	}
+	len = format_cpumask(page, *mask);
+	page += len;
 	len += sprintf(page, "\n");
 	return len;
 }
===== drivers/base/node.c 1.15 vs edited =====
--- 1.15/drivers/base/node.c	Mon Aug 18 19:46:23 2003
+++ edited/drivers/base/node.c	Sun Nov 16 19:20:29 2003
@@ -19,15 +19,11 @@
 {
 	struct node *node_dev = to_node(dev);
 	cpumask_t tmp = node_dev->cpumap;
-	int k, len = 0;
+	int len = 0;
 
-	for (k = 0; k < sizeof(cpumask_t)/sizeof(u16); ++k) {
-		int j = sprintf(buf, "%04hx", (u16)cpus_coerce(tmp));
-		len += j;
-		buf += j;
-		cpus_shift_right(tmp, tmp, 16);
-	}
-        len += sprintf(buf, "\n");
+	len = format_cpumask(buf, node_dev->cpumap);
+	buf += len;
+	len += sprintf(buf, "\n");
 	return len;
 }
 static SYSDEV_ATTR(cpumap,S_IRUGO,node_read_cpumap,NULL);
