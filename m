Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbTEUIaa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 04:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262171AbTEUIa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 04:30:29 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:58642 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262170AbTEUIaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 04:30:24 -0400
Date: Wed, 21 May 2003 09:43:17 +0100
From: Christoph Hellwig <hch@infradead.org>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, kaos@ocs.com.au,
       James.Bottomley@steeleye.com, mort@wildopensource.com,
       davidm@napali.hpl.hp.com, jun.nakajima@intel.com, tomita@cinet.co.jp
Subject: Re: [Lse-tech] cpu-2.5.69-bk14-1
Message-ID: <20030521094317.A6612@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
	kaos@ocs.com.au, James.Bottomley@steeleye.com,
	mort@wildopensource.com, davidm@napali.hpl.hp.com,
	jun.nakajima@intel.com, tomita@cinet.co.jp
References: <20030520170331.GK29926@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030520170331.GK29926@holomorphy.com>; from wli@holomorphy.com on Tue, May 20, 2003 at 10:03:31AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 20, 2003 at 10:03:31AM -0700, William Lee Irwin III wrote:
> Extended cpumasks for larger systems. Now featuring bigsmp, Summit,
> and Voyager updates in addition to PC-compatible, NUMA-Q, and SN2
> bits from SGI.

Here's the PPC32 UP bits.  I'll look into SMP once it starts to actually
compile again.


--- 1.26/arch/ppc/kernel/irq.c	Sun Apr 27 13:56:50 2003
+++ edited/arch/ppc/kernel/irq.c	Tue May 20 11:43:43 2003
@@ -44,6 +44,7 @@
 #include <linux/proc_fs.h>
 #include <linux/random.h>
 #include <linux/seq_file.h>
+#include <linux/cpumask.h>
 
 #include <asm/uaccess.h>
 #include <asm/bitops.h>
@@ -567,24 +568,35 @@
 #define DEFAULT_CPU_AFFINITY 0x00000001
 #endif
 
-unsigned int irq_affinity [NR_IRQS] =
-	{ [0 ... NR_IRQS-1] = DEFAULT_CPU_AFFINITY };
+#define HEX_DIGITS (2*sizeof(cpumask_t))
 
-#define HEX_DIGITS 8
+cpumask_t irq_affinity[NR_IRQS] = { [0 ... NR_IRQS-1] = CPU_MASK_ALL };
 
-static int irq_affinity_read_proc (char *page, char **start, off_t off,
+static int irq_affinity_read_proc(char *page, char **start, off_t off,
 			int count, int *eof, void *data)
 {
+	cpumask_t tmp = irq_affinity[(long)data];
+	int k, len = 0;
+
 	if (count < HEX_DIGITS+1)
 		return -EINVAL;
-	return sprintf (page, "%08x\n", irq_affinity[(int)data]);
+
+	for (k = 0; k < sizeof(cpumask_t)/sizeof(unsigned long); ++k) {
+		int j = sprintf(page, "%04hx", (u16)cpus_coerce(tmp));
+		len += j;
+		page += j;
+		cpus_shift_right(tmp, tmp, 16);
+	}
+	
+	len += sprintf(page, "\n");
+	return len;
 }
 
-static unsigned int parse_hex_value (const char *buffer,
+static unsigned int parse_hex_value(const char *buffer,
 		unsigned long count, unsigned long *ret)
 {
-	unsigned char hexnum [HEX_DIGITS];
-	unsigned long value;
+	unsigned char hexnum[HEX_DIGITS];
+	cpumask_t value = CPU_MASK_NONE;
 	int i;
 
 	if (!count)
@@ -598,10 +610,9 @@
 	 * Parse the first 8 characters as a hex string, any non-hex char
 	 * is end-of-string. '00e1', 'e1', '00E1', 'E1' are all the same.
 	 */
-	value = 0;
-
 	for (i = 0; i < count; i++) {
 		unsigned int c = hexnum[i];
+		int k;
 
 		switch (c) {
 			case '0' ... '9': c -= '0'; break;
@@ -610,18 +621,21 @@
 		default:
 			goto out;
 		}
-		value = (value << 4) | c;
+		cpus_shift_left(value, value, 4);
+		for (k = 0; k < 4; ++k)
+			if (test_bit(k, (unsigned long *)&c))
+				cpu_set(k, value);
 	}
 out:
 	*ret = value;
 	return 0;
 }
 
-static int irq_affinity_write_proc (struct file *file, const char *buffer,
+static int irq_affinity_write_proc(struct file *file, const char *buffer,
 					unsigned long count, void *data)
 {
-	int irq = (int) data, full_count = count, err;
-	unsigned long new_value;
+	int irq = (long)data, full_count = count, err;
+	cpumask_t new_value, tmp;
 
 	if (!irq_desc[irq].handler->set_affinity)
 		return -EIO;
@@ -638,29 +652,42 @@
 	 * are actually logical cpu #'s then we have no problem.
 	 *  -- Cort <cort@fsmlabs.com>
 	 */
-	if (!(new_value & cpu_online_map))
+	cpus_and(tmp, new_value, cpu_online_map);
+	if (cpus_empty(tmp))
 		return -EINVAL;
 
 	irq_affinity[irq] = new_value;
-	irq_desc[irq].handler->set_affinity(irq, new_value);
-
+	irq_desc[irq].handler->set_affinity(irq,
+			cpumask_of_cpu(first_cpu(new_value)));
 	return full_count;
 }
 
-static int prof_cpu_mask_read_proc (char *page, char **start, off_t off,
+static int prof_cpu_mask_read_proc(char *page, char **start, off_t off,
 			int count, int *eof, void *data)
 {
-	unsigned long *mask = (unsigned long *) data;
+	cpumask_t *tmp = (cpumask_t *)data;
+	int k, len = 0;
+	
 	if (count < HEX_DIGITS+1)
 		return -EINVAL;
-	return sprintf (page, "%08lx\n", *mask);
+
+	for (k = 0; k < sizeof(cpumask_t)/sizeof(unsigned long); ++k) {
+		int j = sprintf(page, "%04hx", (u16)cpus_coerce(*tmp));
+		len += j;
+		page += j;
+		cpus_shift_right(*tmp, *tmp, 16);
+	}
+
+	len += sprintf(page, "\n");
+	return len;
 }
 
 static int prof_cpu_mask_write_proc (struct file *file, const char *buffer,
 					unsigned long count, void *data)
 {
-	unsigned long *mask = (unsigned long *) data, full_count = count, err;
-	unsigned long new_value;
+	cpumask_t *mask = (cpumask_t *)data;
+	unsigned long full_count = count, err;
+	cpumask_t new_value;
 
 	err = parse_hex_value(buffer, count, &new_value);
 	if (err)
