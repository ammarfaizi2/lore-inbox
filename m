Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263466AbTK1U4y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 15:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263468AbTK1U4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 15:56:54 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:37295 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S263466AbTK1Uza (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 15:55:30 -0500
Date: Fri, 28 Nov 2003 12:54:28 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: kaos@melbourne.sgi.com, joe.korty@ccur.com, tony.luck@intel.com,
       linux-kernel@vger.kernel.org,
       William Lee Irwin III <wli@holomorphy.com>,
       David Mosberger-Tang <davidm@hpl.hp.com>,
       Christoph Hellwig <hch@infradead.org>, jbarnes@sgi.com,
       Simon.Derr@bull.net
Subject: [PATCH] new /proc/irq cpumask format; consolidate cpumask display
 and input code
Message-Id: <20031128125428.46ec7606.pj@sgi.com>
In-Reply-To: <20031118005637.GI22764@holomorphy.com>
References: <20031118002647.GH22764@holomorphy.com>
	<2173.1069115651@kao2.melbourne.sgi.com>
	<20031118005637.GI22764@holomorphy.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch is a followup to one from Bill Irwin.  On Nov
17, he had consolidated the half-dozen chunks of code
that displayed cpumasks in /proc/irq/prof_cpu_mask and
/proc/irq/<pid>/smp_affinity into a single routine, which he
called format_cpumask().

I believe that Andrew Morton has accepted Bill's patch into
his 2.6.0-test10-mm1 patch set as the "format_cpumask" patch.
I hope that the following patch will replace Bill's patch.
I look forward to Bill's feedback on this patch.

The following patch carries Bill's work further:

 1) It also consolidates the input side (write syscalls).
 2) It adapts a new format, same on input and output.
 3) The core routines work for any multi-word bitmask,
    not just cpumasks.
 4) The core routines avoid overrunning their output
    buffers.

Note esp. for David Mosberger:

    The small patch I sent you and the linux-ia64 list
    yesterday entitled: "check user access ok writing
    /proc/irq/<pid>/smp_affinity" for arch ia64 only is
    _separate_ from the following patch.  Neither presumes the
    other.  However, they do collide on one line.  Last one in
    is a Monkey's Uncle and will need an updated patch from me
    (or otherwise need to resolve the one obvious collision).

Details of the following patch:

Both the display and input of cpumasks on 9 arch's are
consolidated into a single pair of routines, which use the
same format for input and output, as recommended by Tony
Luck.  The two common routines work on any multi-word bitmask
(array of unsigned longs).  A pair of trivial inline wrappers
cpumask_snprintf() and cpumask_parse() hide this generality
for the common case of cpumask input and output.

My real motivation for consolidating this code will become
visible later - when I seek to add a nodemask_t that resembles
cpumask_t (just a different length).  These common underlying
routines will be used there as well, following up on a suggestion
of Christoph Hellwig that I investigate implementing nodemask_t
as an ADT sharing infrastructure with cpumask_t.  However, I
believe that this patch stands on its own merit, consolidating
a couple hundred lines of duplicated code, and making the
cpumask display format usable on very large systems.

There are two exceptions to the consolidation - the alpha and
sparc64 arch's manipulate bare unsigned longs, not cpumask_t's,
on input (write syscall), and do stuff that was more funky than
I could make sense of.  So the input side of these two arch's
was left as-is.  I'd welcome someone with access to either of
these systems to provide additional patches.

The new format consists of multiple 32 bit words, separated by
commas, displayed and input in hex.  The following comment from
this patch describes this format further:


* The ascii representation of multi-word bit masks displays each
* 32bit word in hex (not zero filled), and for masks longer than
* one word, uses a comma separator between words.  Words are
* displayed in big-endian order most significant first.  And hex
* digits within a word are also in big-endian order, of course.
*
* Examples:
*   A mask with just bit 0 set displays as "1".
*   A mask with just bit 127 set displays as "80000000,0,0,0".
*   A mask with just bit 64 set displays as "1,0,0".
*   A mask with bits 0, 1, 2, 4, 8, 16, 32 and 64 set displays
*     as "1,1,10117".  The first "1" is for bit 64, the second
*     for bit 32, the third for bit 16, and so forth, to the
*     "7", which is for bits 2, 1 and 0.
*   A mask with bits 32 through 39 set displays as "ff,0".


The essential reason for adding the comma breaks was to make
the long masks from our (SGI's) big 512 CPU systems parsable by
humans.  An unbroken string of 128 hex digits is pretty difficult
to read.  For those who are compiling systems with CONFIG_NR_CPUS
of 32 or less, there should be no visible change in format.

There are of course a thousand possible output formats that
meet similar criteria.  If someone wants to lobby for and seek
consensus behind another such format, that's fine.  Now that
the format is consolidated into a single pair of routines,
it should be easy to adapt whatever we choose.

Internally, the display routine uses snprintf to track the
remaining space in its output buffer, to avoid the risk of
overrunning it.

A new file, lib/mask.c, is added to the lib directory, to
hold the two common routines.  I anticipate adding a few more
common routines for generic support of multi-word bit masks to
lib/mask.c, in subsequent patches that will add a nodemask_t
type as an ADT sharing implementation with cpumask_t.

This patch is against v2.6.0-test11 (test10 seems fine too).

The diffstat output for this patch is:

 arch/alpha/kernel/irq.c             |   13 +-
 arch/i386/kernel/irq.c              |   69 +------------
 arch/ia64/kernel/irq.c              |   76 +--------------
 arch/mips/kernel/irq.c              |   73 +-------------
 arch/ppc/kernel/irq.c               |   76 +--------------
 arch/ppc64/kernel/irq.c             |   68 +------------
 arch/sparc64/kernel/irq.c           |   12 +-
 arch/um/kernel/irq.c                |   66 +------------
 arch/x86_64/kernel/irq.c            |   76 +--------------
 drivers/base/node.c                 |   16 +--
 include/asm-generic/cpumask_arith.h |    1
 include/asm-generic/cpumask_array.h |    1
 include/asm-generic/cpumask_up.h    |    1
 include/linux/cpumask.h             |   12 ++
 lib/Makefile                        |    2
 lib/mask.c                          |  178 ++++++++++++++++++++++++++++++++++++
 16 files changed, 277 insertions(+), 463 deletions(-)


And without further ado - the patch:


# --------------------------------------------
# 03/11/28	pj@sgi.com	1.1498
# cpumask input/output code consolidation, 32 bit comma separated format
# --------------------------------------------
#
diff -Nru a/arch/alpha/kernel/irq.c b/arch/alpha/kernel/irq.c
--- a/arch/alpha/kernel/irq.c	Fri Nov 28 09:00:39 2003
+++ b/arch/alpha/kernel/irq.c	Fri Nov 28 09:00:39 2003
@@ -252,9 +252,11 @@
 irq_affinity_read_proc (char *page, char **start, off_t off,
 			int count, int *eof, void *data)
 {
-	if (count < HEX_DIGITS+1)
+	int len = cpumask_snprintf(page, count, irq_affinity[(long)data]);
+	if (count - len < 2)
 		return -EINVAL;
-	return sprintf (page, "%016lx\n", irq_affinity[(long)data]);
+	len += sprintf(page + len, "\n");
+	return len;
 }
 
 static unsigned int
@@ -331,10 +333,11 @@
 prof_cpu_mask_read_proc(char *page, char **start, off_t off,
 			int count, int *eof, void *data)
 {
-	unsigned long *mask = (unsigned long *) data;
-	if (count < HEX_DIGITS+1)
+	int len = cpumask_snprintf(page, count, *(cpumask_t *)data);
+	if (count - len < 2)
 		return -EINVAL;
-	return sprintf (page, "%016lx\n", *mask);
+	len += sprintf(page + len, "\n");
+	return len;
 }
 
 static int
diff -Nru a/arch/i386/kernel/irq.c b/arch/i386/kernel/irq.c
--- a/arch/i386/kernel/irq.c	Fri Nov 28 09:00:38 2003
+++ b/arch/i386/kernel/irq.c	Fri Nov 28 09:00:38 2003
@@ -898,48 +898,6 @@
 static struct proc_dir_entry * root_irq_dir;
 static struct proc_dir_entry * irq_dir [NR_IRQS];
 
-#define HEX_DIGITS (2*sizeof(cpumask_t))
-
-static unsigned int parse_hex_value(const char __user *buffer,
-		unsigned long count, cpumask_t *ret)
-{
-	unsigned char hexnum[HEX_DIGITS];
-	cpumask_t value = CPU_MASK_NONE;
-	int i;
-
-	if (!count)
-		return -EINVAL;
-	if (count > HEX_DIGITS)
-		count = HEX_DIGITS;
-	if (copy_from_user(hexnum, buffer, count))
-		return -EFAULT;
-
-	/*
-	 * Parse the first HEX_DIGITS characters as a hex string, any non-hex char
-	 * is end-of-string. '00e1', 'e1', '00E1', 'E1' are all the same.
-	 */
-
-	for (i = 0; i < count; i++) {
-		unsigned int c = hexnum[i];
-		int k;
-
-		switch (c) {
-			case '0' ... '9': c -= '0'; break;
-			case 'a' ... 'f': c -= 'a'-10; break;
-			case 'A' ... 'F': c -= 'A'-10; break;
-		default:
-			goto out;
-		}
-		cpus_shift_left(value, value, 4);
-		for (k = 0; k < 4; ++k)
-			if (test_bit(k, (unsigned long *)&c))
-				cpu_set(k, value);
-	}
-out:
-	*ret = value;
-	return 0;
-}
-
 #ifdef CONFIG_SMP
 
 static struct proc_dir_entry *smp_affinity_entry[NR_IRQS];
@@ -949,20 +907,10 @@
 static int irq_affinity_read_proc(char *page, char **start, off_t off,
 			int count, int *eof, void *data)
 {
-	int k, len;
-	cpumask_t tmp = irq_affinity[(long)data];
-
-	if (count < HEX_DIGITS+1)
+	int len = cpumask_snprintf(page, count, irq_affinity[(long)data]);
+	if (count - len < 2)
 		return -EINVAL;
-
-	len = 0;
-	for (k = 0; k < sizeof(cpumask_t)/sizeof(u16); ++k) {
-		int j = sprintf(page, "%04hx", (u16)cpus_coerce(tmp));
-		len += j;
-		page += j;
-		cpus_shift_right(tmp, tmp, 16);
-	}
-	len += sprintf(page, "\n");
+	len += sprintf(page + len, "\n");
 	return len;
 }
 
@@ -975,7 +923,7 @@
 	if (!irq_desc[irq].handler->set_affinity)
 		return -EIO;
 
-	err = parse_hex_value(buffer, count, &new_value);
+	err = cpumask_parse(buffer, count, new_value);
 	if (err)
 		return err;
 
@@ -1000,10 +948,11 @@
 static int prof_cpu_mask_read_proc (char *page, char **start, off_t off,
 			int count, int *eof, void *data)
 {
-	unsigned long *mask = (unsigned long *) data;
-	if (count < HEX_DIGITS+1)
+	int len = cpumask_snprintf(page, count, *(cpumask_t *)data);
+	if (count - len < 2)
 		return -EINVAL;
-	return sprintf (page, "%08lx\n", *mask);
+	len += sprintf(page + len, "\n");
+	return len;
 }
 
 static int prof_cpu_mask_write_proc (struct file *file, const char __user *buffer,
@@ -1013,7 +962,7 @@
 	unsigned long full_count = count, err;
 	cpumask_t new_value;
 
-	err = parse_hex_value(buffer, count, &new_value);
+	err = cpumask_parse(buffer, count, new_value);
 	if (err)
 		return err;
 
diff -Nru a/arch/ia64/kernel/irq.c b/arch/ia64/kernel/irq.c
--- a/arch/ia64/kernel/irq.c	Fri Nov 28 09:00:39 2003
+++ b/arch/ia64/kernel/irq.c	Fri Nov 28 09:00:39 2003
@@ -910,47 +910,6 @@
 static struct proc_dir_entry * root_irq_dir;
 static struct proc_dir_entry * irq_dir [NR_IRQS];
 
-#define HEX_DIGITS (2*sizeof(cpumask_t))
-
-static unsigned int parse_hex_value(const char *buffer,
-		unsigned long count, cpumask_t *ret)
-{
-	unsigned char hexnum[HEX_DIGITS];
-	cpumask_t value = CPU_MASK_NONE;
-	unsigned long i;
-
-	if (!count)
-		return -EINVAL;
-	if (count > HEX_DIGITS)
-		count = HEX_DIGITS;
-	if (copy_from_user(hexnum, buffer, count))
-		return -EFAULT;
-
-	/*
-	 * Parse the first 8 characters as a hex string, any non-hex char
-	 * is end-of-string. '00e1', 'e1', '00E1', 'E1' are all the same.
-	 */
-	for (i = 0; i < count; i++) {
-		unsigned int c = hexnum[i];
-		int k;
-
-		switch (c) {
-			case '0' ... '9': c -= '0'; break;
-			case 'a' ... 'f': c -= 'a'-10; break;
-			case 'A' ... 'F': c -= 'A'-10; break;
-		default:
-			goto out;
-		}
-		cpus_shift_left(value, value, 4);
-		for (k = 0; k < 4; ++k)
-			if (test_bit(k, (unsigned long *)&c))
-				cpu_set(k, value);
-	}
-out:
-	*ret = value;
-	return 0;
-}
-
 #ifdef CONFIG_SMP
 
 static struct proc_dir_entry * smp_affinity_entry [NR_IRQS];
@@ -974,20 +933,10 @@
 static int irq_affinity_read_proc (char *page, char **start, off_t off,
 			int count, int *eof, void *data)
 {
-	int k, len;
-	cpumask_t tmp = irq_affinity[(long)data];
-
-	if (count < HEX_DIGITS+1)
+	int len = cpumask_snprintf(page, count, irq_affinity[(long)data]);
+	if (count - len < 2)
 		return -EINVAL;
-
-	len = 0;
-	for (k = 0; k < sizeof(cpumask_t)/sizeof(u16); ++k) {
-		int j = sprintf(page, "%04hx", (u16)cpus_coerce(tmp));
-		len += j;
-		page += j;
-		cpus_shift_right(tmp, tmp, 16);
-	}
-	len += sprintf(page, "\n");
+	len += sprintf(page + len, "\n");
 	return len;
 }
 
@@ -1011,7 +960,7 @@
 	} else
 		redir = 0;
 
-	err = parse_hex_value(buf, count, &new_value);
+	err = cpumask_parse(buf, count - (buf-buffer), new_value);
 	if (err)
 		return err;
 
@@ -1033,19 +982,10 @@
 static int prof_cpu_mask_read_proc (char *page, char **start, off_t off,
 			int count, int *eof, void *data)
 {
-	cpumask_t *mask = (cpumask_t *)data;
-	int k, len = 0;
-
-	if (count < HEX_DIGITS+1)
+	int len = cpumask_snprintf(page, count, *(cpumask_t *)data);
+	if (count - len < 2)
 		return -EINVAL;
-
-	for (k = 0; k < sizeof(cpumask_t)/sizeof(u16); ++k) {
-		int j = sprintf(page, "%04hx", (u16)cpus_coerce(*mask));
-		len += j;
-		page += j;
-		cpus_shift_right(*mask, *mask, 16);
-	}
-	len += sprintf(page, "\n");
+	len += sprintf(page + len, "\n");
 	return len;
 }
 
@@ -1056,7 +996,7 @@
 	unsigned long full_count = count, err;
 	cpumask_t new_value;
 
-	err = parse_hex_value(buffer, count, &new_value);
+	err = cpumask_parse(buffer, count, new_value);
 	if (err)
 		return err;
 
diff -Nru a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
--- a/arch/mips/kernel/irq.c	Fri Nov 28 09:00:39 2003
+++ b/arch/mips/kernel/irq.c	Fri Nov 28 09:00:39 2003
@@ -825,45 +825,6 @@
 static struct proc_dir_entry * root_irq_dir;
 static struct proc_dir_entry * irq_dir [NR_IRQS];
 
-#define HEX_DIGITS 8
-
-static unsigned int parse_hex_value (const char *buffer,
-		unsigned long count, unsigned long *ret)
-{
-	unsigned char hexnum [HEX_DIGITS];
-	unsigned long value;
-	int i;
-
-	if (!count)
-		return -EINVAL;
-	if (count > HEX_DIGITS)
-		count = HEX_DIGITS;
-	if (copy_from_user(hexnum, buffer, count))
-		return -EFAULT;
-
-	/*
-	 * Parse the first 8 characters as a hex string, any non-hex char
-	 * is end-of-string. '00e1', 'e1', '00E1', 'E1' are all the same.
-	 */
-	value = 0;
-
-	for (i = 0; i < count; i++) {
-		unsigned int c = hexnum[i];
-
-		switch (c) {
-			case '0' ... '9': c -= '0'; break;
-			case 'a' ... 'f': c -= 'a'-10; break;
-			case 'A' ... 'F': c -= 'A'-10; break;
-		default:
-			goto out;
-		}
-		value = (value << 4) | c;
-	}
-out:
-	*ret = value;
-	return 0;
-}
-
 #ifdef CONFIG_SMP
 
 static struct proc_dir_entry * smp_affinity_entry [NR_IRQS];
@@ -872,18 +833,10 @@
 static int irq_affinity_read_proc (char *page, char **start, off_t off,
 			int count, int *eof, void *data)
 {
-	int len, k;
-	cpumask_t tmp = irq_affinity[(long)data];
-
-	if (count < HEX_DIGITS+1)
+	int len = cpumask_snprintf(page, count, irq_affinity[(long)data]);
+	if (count - len < 2)
 		return -EINVAL;
-	for (k = 0; k < sizeof(cpumask_t)/sizeof(u16); ++k) {
-		int j = sprintf(page, "%04hx", cpus_coerce(tmp));
-		len += j;
-		page += j;
-		cpus_shift_right(tmp, tmp, 16);
-	}
-	len += sprintf(page, "\n");
+	len += sprintf(page + len, "\n");
 	return len;
 }
 
@@ -896,7 +849,7 @@
 	if (!irq_desc[irq].handler->set_affinity)
 		return -EIO;
 
-	err = parse_hex_value(buffer, count, &new_value);
+	err = cpumask_parse(buffer, count, new_value);
 
 	/*
 	 * Do not allow disabling IRQs completely - it's a too easy
@@ -918,20 +871,10 @@
 static int prof_cpu_mask_read_proc (char *page, char **start, off_t off,
 			int count, int *eof, void *data)
 {
-	int len, k;
-	cpumask_t *mask = (cpumask_t *)data, tmp;
-
-	if (count < HEX_DIGITS+1)
+	int len = cpumask_snprintf(page, count, *(cpumask_t *)data);
+	if (count - len < 2)
 		return -EINVAL;
-	tmp = *mask;
-
-	for (k = 0; k < sizeof(cpumask_t)/sizeof(u16); ++k) {
-		int j = sprintf(page, "%04hx", cpus_coerce(tmp));
-		len += j;
-		page += j;
-		cpus_shift_right(tmp, tmp, 16);
-	}
-	len += sprintf(page, "\n");
+	len += sprintf(page + len, "\n");
 	return len;
 }
 
@@ -941,7 +884,7 @@
 	cpumask_t *mask = (cpumask_t *)data, new_value;
 	unsigned long full_count = count, err;
 
-	err = parse_hex_value(buffer, count, &new_value);
+	err = cpumask_parse(buffer, count, new_value);
 	if (err)
 		return err;
 
diff -Nru a/arch/ppc/kernel/irq.c b/arch/ppc/kernel/irq.c
--- a/arch/ppc/kernel/irq.c	Fri Nov 28 09:00:39 2003
+++ b/arch/ppc/kernel/irq.c	Fri Nov 28 09:00:39 2003
@@ -569,67 +569,16 @@
 
 cpumask_t irq_affinity [NR_IRQS];
 
-#define HEX_DIGITS (2*sizeof(cpumask_t))
-
 static int irq_affinity_read_proc (char *page, char **start, off_t off,
 			int count, int *eof, void *data)
 {
-	cpumask_t tmp = irq_affinity[(long)data];
-	int k, len = 0;
-
-	if (count < HEX_DIGITS+1)
+	int len = cpumask_snprintf(page, count, irq_affinity[(long)data]);
+	if (count - len < 2)
 		return -EINVAL;
-
-	for (k = 0; k < sizeof(cpumask_t)/sizeof(u16); ++k) {
-		int j = sprintf(page, "%04hx", (u16)cpus_coerce(tmp));
-		len += j;
-		page += j;
-		cpus_shift_right(tmp, tmp, 16);
-	}
-
-	len += sprintf(page, "\n");
+	len += sprintf(page + len, "\n");
 	return len;
 }
 
-static unsigned int parse_hex_value (const char __user *buffer,
-		unsigned long count, cpumask_t *ret)
-{
-	unsigned char hexnum [HEX_DIGITS];
-	cpumask_t value = CPU_MASK_NONE;
-	int i;
-
-	if (!count)
-		return -EINVAL;
-	if (count > HEX_DIGITS)
-		count = HEX_DIGITS;
-	if (copy_from_user(hexnum, buffer, count))
-		return -EFAULT;
-
-	/*
-	 * Parse the first 8 characters as a hex string, any non-hex char
-	 * is end-of-string. '00e1', 'e1', '00E1', 'E1' are all the same.
-	 */
-	for (i = 0; i < count; i++) {
-		unsigned int c = hexnum[i];
-		int k;
-
-		switch (c) {
-			case '0' ... '9': c -= '0'; break;
-			case 'a' ... 'f': c -= 'a'-10; break;
-			case 'A' ... 'F': c -= 'A'-10; break;
-		default:
-			goto out;
-		}
-		cpus_shift_left(value, value, 4);
-		for (k = 0; k < 4; ++k)
-			if (c & (1 << k))
-				cpu_set(k, value);
-	}
-out:
-	*ret = value;
-	return 0;
-}
-
 static int irq_affinity_write_proc (struct file *file, const char __user *buffer,
 					unsigned long count, void *data)
 {
@@ -639,7 +588,7 @@
 	if (!irq_desc[irq].handler->set_affinity)
 		return -EIO;
 
-	err = parse_hex_value(buffer, count, &new_value);
+	err = cpumask_parse(buffer, count, new_value);
 
 	/*
 	 * Do not allow disabling IRQs completely - it's a too easy
@@ -664,19 +613,10 @@
 static int prof_cpu_mask_read_proc (char *page, char **start, off_t off,
 			int count, int *eof, void *data)
 {
-	cpumask_t mask = *(cpumask_t *)data;
-	int k, len = 0;
-
-	if (count < HEX_DIGITS+1)
+	int len = cpumask_snprintf(page, count, *(cpumask_t *)data);
+	if (count - len < 2)
 		return -EINVAL;
-
-	for (k = 0; k < sizeof(cpumask_t)/sizeof(u16); ++k) {
-		int j = sprintf(page, "%04hx", (u16)cpus_coerce(mask));
-		len += j;
-		page += j;
-		cpus_shift_right(mask, mask, 16);
-	}
-	len += sprintf(page, "\n");
+	len += sprintf(page + len, "\n");
 	return len;
 }
 
@@ -686,7 +626,7 @@
 	cpumask_t *mask = (cpumask_t *)data, full_count = count, err;
 	cpumask_t new_value;
 
-	err = parse_hex_value(buffer, count, &new_value);
+	err = cpumask_parse(buffer, count, new_value);
 	if (err)
 		return err;
 
diff -Nru a/arch/ppc64/kernel/irq.c b/arch/ppc64/kernel/irq.c
--- a/arch/ppc64/kernel/irq.c	Fri Nov 28 09:00:39 2003
+++ b/arch/ppc64/kernel/irq.c	Fri Nov 28 09:00:39 2003
@@ -652,67 +652,16 @@
 cpumask_t irq_affinity [NR_IRQS] = { [0 ... NR_IRQS-1] = CPU_MASK_NONE };
 #endif /* CONFIG_IRQ_ALL_CPUS */
 
-#define HEX_DIGITS (2*sizeof(cpumask_t))
-
 static int irq_affinity_read_proc (char *page, char **start, off_t off,
 			int count, int *eof, void *data)
 {
-	int k, len;
-	cpumask_t tmp = irq_affinity[(long)data];
-
-	if (count < HEX_DIGITS+1)
+	int len = cpumask_snprintf(page, count, irq_affinity[(long)data]);
+	if (count - len < 2)
 		return -EINVAL;
-
-	for (k = 0; k < sizeof(cpumask_t) / sizeof(u16); ++k) {
-		int j = sprintf(page, "%04hx", (u16)cpus_coerce(tmp));
-		len += j;
-		page += j;
-		cpus_shift_right(tmp, tmp, 16);
-	}
-	len += sprintf(page, "\n");
+	len += sprintf(page + len, "\n");
 	return len;
 }
 
-static unsigned int parse_hex_value (const char *buffer,
-		unsigned long count, cpumask_t *ret)
-{
-	unsigned char hexnum[HEX_DIGITS];
-	cpumask_t value = CPU_MASK_NONE;
-	int i;
-
-	if (!count)
-		return -EINVAL;
-	if (count > HEX_DIGITS)
-		count = HEX_DIGITS;
-	if (copy_from_user(hexnum, buffer, count))
-		return -EFAULT;
-
-	/*
-	 * Parse the first HEX_DIGITS characters as a hex string, any non-hex char
-	 * is end-of-string. '00e1', 'e1', '00E1', 'E1' are all the same.
-	 */
-
-	for (i = 0; i < count; i++) {
-		unsigned int c = hexnum[i];
-		int k;
-
-		switch (c) {
-			case '0' ... '9': c -= '0'; break;
-			case 'a' ... 'f': c -= 'a'-10; break;
-			case 'A' ... 'F': c -= 'A'-10; break;
-		default:
-			goto out;
-		}
-		cpus_shift_left(value, value, 4);
-		for (k = 0; k < 4; ++k)
-			if (test_bit(k, (unsigned long *)&c))
-				cpu_set(k, value);
-	}
-out:
-	*ret = value;
-	return 0;
-}
-
 static int irq_affinity_write_proc (struct file *file, const char *buffer,
 					unsigned long count, void *data)
 {
@@ -722,7 +671,7 @@
 	if (!irq_desc[irq].handler->set_affinity)
 		return -EIO;
 
-	err = parse_hex_value(buffer, count, &new_value);
+	err = cpumask_parse(buffer, count, new_value);
 	if (err)
 		return err;
 
@@ -744,10 +693,11 @@
 static int prof_cpu_mask_read_proc (char *page, char **start, off_t off,
 			int count, int *eof, void *data)
 {
-	unsigned long *mask = (unsigned long *) data;
-	if (count < HEX_DIGITS+1)
+	int len = cpumask_snprintf(page, count, *(cpumask_t *)data);
+	if (count - len < 2)
 		return -EINVAL;
-	return sprintf (page, "%08lx\n", *mask);
+	len += sprintf(page + len, "\n");
+	return len;
 }
 
 static int prof_cpu_mask_write_proc (struct file *file, const char __user *buffer,
@@ -757,7 +707,7 @@
 	unsigned long full_count = count, err;
 	cpumask_t new_value;
 
-	err = parse_hex_value(buffer, count, &new_value);
+	err = cpumask_parse(buffer, count, new_value);
 	if (err)
 		return err;
 
diff -Nru a/arch/sparc64/kernel/irq.c b/arch/sparc64/kernel/irq.c
--- a/arch/sparc64/kernel/irq.c	Fri Nov 28 09:00:39 2003
+++ b/arch/sparc64/kernel/irq.c	Fri Nov 28 09:00:39 2003
@@ -1204,11 +1204,17 @@
 {
 	struct ino_bucket *bp = ivector_table + (long)data;
 	struct irqaction *ap = bp->irq_info;
-	unsigned long mask = get_smpaff_in_irqaction(ap);
+	cpumask_t mask = get_smpaff_in_irqaction(ap);
+	int len;
 
-	if (count < HEX_DIGITS+1)
+	if (cpus_empty(mask))
+		mask = cpu_online_map;
+
+	len = cpumask_snprintf(page, count, mask);
+	if (count - len < 2)
 		return -EINVAL;
-	return sprintf (page, "%016lx\n", mask == 0 ? ~0UL : mask);
+	len += sprintf(page + len, "\n");
+	return len;
 }
 
 static inline void set_intr_affinity(int irq, unsigned long hw_aff)
diff -Nru a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
--- a/arch/um/kernel/irq.c	Fri Nov 28 09:00:39 2003
+++ b/arch/um/kernel/irq.c	Fri Nov 28 09:00:39 2003
@@ -572,53 +572,14 @@
  */
 static cpumask_t irq_affinity [NR_IRQS] = { [0 ... NR_IRQS-1] = CPU_MASK_ALL };
 
-#define HEX_DIGITS (2*sizeof(cpumask_t))
-
 static int irq_affinity_read_proc (char *page, char **start, off_t off,
 			int count, int *eof, void *data)
 {
-	if (count < HEX_DIGITS+1)
+	int len = cpumask_snprintf(page, count, irq_affinity[(long)data]);
+	if (count - len < 2)
 		return -EINVAL;
-	return sprintf (page, "%08lx\n", irq_affinity[(long)data]);
-}
-
-static unsigned int parse_hex_value (const char *buffer,
-		unsigned long count, cpumask_t *ret)
-{
-	unsigned char hexnum [HEX_DIGITS];
-	cpumask_t value = CPU_MASK_NONE;
-	int i;
-
-	if (!count)
-		return -EINVAL;
-	if (count > HEX_DIGITS)
-		count = HEX_DIGITS;
-	if (copy_from_user(hexnum, buffer, count))
-		return -EFAULT;
-
-	/*
-	 * Parse the first 8 characters as a hex string, any non-hex char
-	 * is end-of-string. '00e1', 'e1', '00E1', 'E1' are all the same.
-	 */
-
-	for (i = 0; i < count; i++) {
-		unsigned int k, c = hexnum[i];
-
-		switch (c) {
-			case '0' ... '9': c -= '0'; break;
-			case 'a' ... 'f': c -= 'a'-10; break;
-			case 'A' ... 'F': c -= 'A'-10; break;
-		default:
-			goto out;
-		}
-		cpus_shift_left(value, value, 16);
-		for (k = 0; k < 4; ++k)
-			if (c & (1 << k))
-				cpu_set(k, value);
-	}
-out:
-	*ret = value;
-	return 0;
+	len += sprintf(page + len, "\n");
+	return len;
 }
 
 static int irq_affinity_write_proc (struct file *file, const char *buffer,
@@ -630,7 +591,7 @@
 	if (!irq_desc[irq].handler->set_affinity)
 		return -EIO;
 
-	err = parse_hex_value(buffer, count, &new_value);
+	err = cpumask_parse(buffer, count, new_value);
 
 #ifdef CONFIG_SMP
 	/*
@@ -652,19 +613,10 @@
 static int prof_cpu_mask_read_proc (char *page, char **start, off_t off,
 			int count, int *eof, void *data)
 {
-	cpumask_t tmp, *mask = (cpumask_t *) data;
-	int k, len = 0;
-
-	if (count < HEX_DIGITS+1)
+	int len = cpumask_snprintf(page, count, *(cpumask_t *)data);
+	if (count - len < 2)
 		return -EINVAL;
-	tmp = *mask;
-	for (k = 0; k < sizeof(cpumask_t)/sizeof(u16); ++k) {
-		int j = sprintf(page, "%04hx", cpus_coerce(tmp));
-		len += j;
-		page += j;
-		cpus_shift_right(tmp, tmp, 16);
-	}
-	len += sprintf(page, "\n");
+	len += sprintf(page + len, "\n");
 	return len;
 }
 
@@ -674,7 +626,7 @@
 	cpumask_t *mask = (cpumask_t *)data, new_value;
 	unsigned long full_count = count, err;
 
-	err = parse_hex_value(buffer, count, &new_value);
+	err = cpumask_parse(buffer, count, new_value);
 	if (err)
 		return err;
 
diff -Nru a/arch/x86_64/kernel/irq.c b/arch/x86_64/kernel/irq.c
--- a/arch/x86_64/kernel/irq.c	Fri Nov 28 09:00:39 2003
+++ b/arch/x86_64/kernel/irq.c	Fri Nov 28 09:00:39 2003
@@ -801,47 +801,6 @@
 static struct proc_dir_entry * root_irq_dir;
 static struct proc_dir_entry * irq_dir [NR_IRQS];
 
-#define HEX_DIGITS (2*sizeof(cpumask_t))
-
-static unsigned int parse_hex_value (const char *buffer,
-		unsigned long count, cpumask_t *ret)
-{
-	unsigned char hexnum [HEX_DIGITS];
-	cpumask_t value = CPU_MASK_NONE;
-	unsigned i;
-
-	if (!count)
-		return -EINVAL;
-	if (count > HEX_DIGITS)
-		count = HEX_DIGITS;
-	if (copy_from_user(hexnum, buffer, count))
-		return -EFAULT;
-
-	/*
-	 * Parse the first 8 characters as a hex string, any non-hex char
-	 * is end-of-string. '00e1', 'e1', '00E1', 'E1' are all the same.
-	 */
-
-	for (i = 0; i < count; i++) {
-		unsigned int k, c = hexnum[i];
-
-		switch (c) {
-			case '0' ... '9': c -= '0'; break;
-			case 'a' ... 'f': c -= 'a'-10; break;
-			case 'A' ... 'F': c -= 'A'-10; break;
-		default:
-			goto out;
-		}
-		cpus_shift_left(value, value, 4);
-		for (k = 0; k < 4; ++k)
-			if (c & (1 << k))
-				cpu_set(k, value);
-	}
-out:
-	*ret = value;
-	return 0;
-}
-
 #ifdef CONFIG_SMP
 
 static struct proc_dir_entry * smp_affinity_entry [NR_IRQS];
@@ -850,19 +809,10 @@
 static int irq_affinity_read_proc (char *page, char **start, off_t off,
 			int count, int *eof, void *data)
 {
-	int k, len;
-	cpumask_t tmp = irq_affinity[(long)data];
-
-	if (count < HEX_DIGITS+1)
+	int len = cpumask_snprintf(page, count, irq_affinity[(long)data]);
+	if (count - len < 2)
 		return -EINVAL;
-
-	for (k = len = 0; k < sizeof(cpumask_t)/sizeof(u16); ++k) {
-		int j = sprintf(page, "%04hx", (u16)cpus_coerce(tmp));
-		len += j;
-		page += j;
-		cpus_shift_right(tmp, tmp, 16);
-	}
-	len += sprintf(page, "\n");
+	len += sprintf(page + len, "\n");
 	return len;
 }
 
@@ -875,7 +825,7 @@
 	if (!irq_desc[irq].handler->set_affinity)
 		return -EIO;
 
-	err = parse_hex_value(buffer, count, &new_value);
+	err = cpumask_parse(buffer, count, new_value);
 
 	/*
 	 * Do not allow disabling IRQs completely - it's a too easy
@@ -897,20 +847,10 @@
 static int prof_cpu_mask_read_proc (char *page, char **start, off_t off,
 			int count, int *eof, void *data)
 {
-	cpumask_t tmp, *mask = (cpumask_t *) data;
-	int k, len;
-
-	if (count < HEX_DIGITS+1)
+	int len = cpumask_snprintf(page, count, *(cpumask_t *)data);
+	if (count - len < 2)
 		return -EINVAL;
-
-	tmp = *mask;
-	for (k = len = 0; k < sizeof(cpumask_t)/sizeof(u16); ++k) {
-		int j = sprintf(page, "%04hx", (u16)cpus_coerce(tmp));
-		len += j;
-		page += j;
-		cpus_shift_right(tmp, tmp, 16);
-	}
-	len += sprintf(page, "\n");
+	len += sprintf(page + len, "\n");
 	return len;
 }
 
@@ -920,7 +860,7 @@
 	unsigned long full_count = count, err;
 	cpumask_t new_value, *mask = (cpumask_t *)data;
 
-	err = parse_hex_value(buffer, count, &new_value);
+	err = cpumask_parse(buffer, count, new_value);
 	if (err)
 		return err;
 
diff -Nru a/drivers/base/node.c b/drivers/base/node.c
--- a/drivers/base/node.c	Fri Nov 28 09:00:39 2003
+++ b/drivers/base/node.c	Fri Nov 28 09:00:39 2003
@@ -18,18 +18,16 @@
 static ssize_t node_read_cpumap(struct sys_device * dev, char * buf)
 {
 	struct node *node_dev = to_node(dev);
-	cpumask_t tmp = node_dev->cpumap;
-	int k, len = 0;
+	cpumask_t mask = node_dev->cpumap;
+	int len;
 
-	for (k = 0; k < sizeof(cpumask_t)/sizeof(u16); ++k) {
-		int j = sprintf(buf, "%04hx", (u16)cpus_coerce(tmp));
-		len += j;
-		buf += j;
-		cpus_shift_right(tmp, tmp, 16);
-	}
-        len += sprintf(buf, "\n");
+	/* FIXME - someone should pass us a buffer size (count) or
+	 * use seq_file or something to avoid buffer overrun risk. */
+	len = cpumask_snprintf(buf, 99 /* XXX FIXME */, mask);
+	len += sprintf(buf + len, "\n");
 	return len;
 }
+
 static SYSDEV_ATTR(cpumap,S_IRUGO,node_read_cpumap,NULL);
 
 #define K(x) ((x) << (PAGE_SHIFT - 10))
diff -Nru a/include/asm-generic/cpumask_arith.h b/include/asm-generic/cpumask_arith.h
--- a/include/asm-generic/cpumask_arith.h	Fri Nov 28 09:00:39 2003
+++ b/include/asm-generic/cpumask_arith.h	Fri Nov 28 09:00:39 2003
@@ -17,6 +17,7 @@
 #define cpus_complement(map)		do { map = ~(map); } while (0)
 #define cpus_equal(map1, map2)		((map1) == (map2))
 #define cpus_empty(map)			((map) == 0)
+#define cpus_addr(map)			(&(map))
 
 #if BITS_PER_LONG == 32
 #define cpus_weight(map)		hweight32(map)
diff -Nru a/include/asm-generic/cpumask_array.h b/include/asm-generic/cpumask_array.h
--- a/include/asm-generic/cpumask_array.h	Fri Nov 28 09:00:39 2003
+++ b/include/asm-generic/cpumask_array.h	Fri Nov 28 09:00:39 2003
@@ -20,6 +20,7 @@
 #define cpus_complement(map)	bitmap_complement((map).mask, NR_CPUS)
 #define cpus_equal(map1, map2)	bitmap_equal((map1).mask, (map2).mask, NR_CPUS)
 #define cpus_empty(map)		bitmap_empty(map.mask, NR_CPUS)
+#define cpus_addr(map)		((map).mask)
 #define cpus_weight(map)		bitmap_weight((map).mask, NR_CPUS)
 #define cpus_shift_right(d, s, n)	bitmap_shift_right((d).mask, (s).mask, n, NR_CPUS)
 #define cpus_shift_left(d, s, n)	bitmap_shift_left((d).mask, (s).mask, n, NR_CPUS)
diff -Nru a/include/asm-generic/cpumask_up.h b/include/asm-generic/cpumask_up.h
--- a/include/asm-generic/cpumask_up.h	Fri Nov 28 09:00:39 2003
+++ b/include/asm-generic/cpumask_up.h	Fri Nov 28 09:00:39 2003
@@ -33,6 +33,7 @@
 
 #define cpus_equal(map1, map2)		(cpus_coerce(map1) == cpus_coerce(map2))
 #define cpus_empty(map)			(cpus_coerce(map) == 0UL)
+#define cpus_addr(map)			(&(map))
 #define cpus_weight(map)		(cpus_coerce(map) ? 1UL : 0UL)
 #define cpus_shift_right(d, s, n)	do { cpus_coerce(d) = 0UL; } while (0)
 #define cpus_shift_left(d, s, n)	do { cpus_coerce(d) = 0UL; } while (0)
diff -Nru a/include/linux/cpumask.h b/include/linux/cpumask.h
--- a/include/linux/cpumask.h	Fri Nov 28 09:00:39 2003
+++ b/include/linux/cpumask.h	Fri Nov 28 09:00:39 2003
@@ -68,4 +68,16 @@
 		cpu < NR_CPUS;						\
 		cpu = next_online_cpu(cpu,map))
 
+extern int __mask_snprintf_len(char *buf, unsigned int buflen,
+		const unsigned long *maskp, unsigned int maskbytes);
+
+#define cpumask_snprintf(buf, buflen, map)				\
+	__mask_snprintf_len(buf, buflen, cpus_addr(map), sizeof(map))
+
+extern int __mask_parse_len(const char __user *ubuf, unsigned int ubuflen,
+	unsigned long *maskp, unsigned int maskbytes);
+
+#define cpumask_parse(buf, buflen, map)					\
+	__mask_parse_len(buf, buflen, cpus_addr(map), sizeof(map))
+
 #endif /* __LINUX_CPUMASK_H */
diff -Nru a/lib/Makefile b/lib/Makefile
--- a/lib/Makefile	Fri Nov 28 09:00:38 2003
+++ b/lib/Makefile	Fri Nov 28 09:00:38 2003
@@ -5,7 +5,7 @@
 
 lib-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
-	 kobject.o idr.o div64.o parser.o
+	 kobject.o idr.o div64.o parser.o mask.o
 
 lib-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
 lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
diff -Nru a/lib/mask.c b/lib/mask.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/lib/mask.c	Fri Nov 28 09:00:39 2003
@@ -0,0 +1,178 @@
+/*
+ * lib/mask.c
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2003 Silicon Graphics, Inc.  All Rights Reserved.
+ */
+
+/*
+ * Routines to manipulate multi-word bit masks, such as cpumasks.
+ *
+ * The ascii representation of multi-word bit masks displays each
+ * 32bit word in hex (not zero filled), and for masks longer than
+ * one word, uses a comma separator between words.  Words are
+ * displayed in big-endian order most significant first.  And hex
+ * digits within a word are also in big-endian order, of course.
+ *
+ * Examples:
+ *   A mask with just bit 0 set displays as "1".
+ *   A mask with just bit 127 set displays as "80000000,0,0,0".
+ *   A mask with just bit 64 set displays as "1,0,0".
+ *   A mask with bits 0, 1, 2, 4, 8, 16, 32 and 64 set displays
+ *     as "1,1,10117".  The first "1" is for bit 64, the second
+ *     for bit 32, the third for bit 16, and so forth, to the
+ *     "7", which is for bits 2, 1 and 0.
+ *   A mask with bits 32 through 39 set displays as "ff,0".
+ *
+ * The internal binary representation of masks is as one or
+ * an array of unsigned longs, perhaps wrapped in a struct for
+ * convenient use as an lvalue.  The following code doesn't know
+ * about any such struct details, relying on inline macros in
+ * files such as cpumask.h to pass in an unsigned long pointer
+ * and a length (in bytes), describing the mask contents.
+ * The 32bit words in the array are in little-endian order,
+ * low order word first.  Beware that this is the reverse order
+ * of the ascii representation.
+ *
+ * Even though the size of the input mask is provided in bytes,
+ * the following code may assume that the mask is a multiple of
+ * 32 or 64 bit words long, and ignore any fractional portion
+ * of a word at the end.  The main reason the size is passed in
+ * bytes is because it is so easy to write 'sizeof(somemask_t)'
+ * in the macros.
+ *
+ * Masks are not a single,simple type, like classic 'C'
+ * nul-term strings.  Rather they are a family of types, one
+ * for each different length.  Inline macros are used to pick
+ * up the actual length, where it is known to the compiler, and
+ * pass it down to these routines, which work on any specified
+ * length array of unsigned longs.  Poor man's templates.
+ *
+ * Many of the inline macros don't call into the following
+ * routines.  Some of them call into other kernel routines,
+ * such as memset(), set_bit() or ffs().  Some of them can
+ * accomplish their task right inline, such as returning the
+ * size or address of the unsigned long array, or optimized
+ * versions of the macros for the most common case of an array
+ * of a single unsigned long.
+ */
+
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/ctype.h>
+#include <linux/slab.h>
+#include <linux/errno.h>
+#include <linux/gfp.h>
+#include <asm/uaccess.h>
+
+#define MAX_HEX_PER_BYTE 4	/* dont need > 4 hex chars to encode byte */
+#define BASE 16			/* masks are input in hex (base 16) */
+#define NUL ((char)'\0')	/* nul-terminator */
+
+/**
+ * __mask_snprintf_len - represent multi-word bit mask as string.
+ * @buf: The buffer to place the result into
+ * @buflen: The size of the buffer, including the trailing null space
+ * @maskp: Points to beginning of multi-word bit mask.
+ * @maskbytes: Number of bytes in bit mask at maskp.
+ *
+ * This routine is expected to be called from a macro such as:
+ *
+ * #define cpumask_snprintf(buf, buflen, mask) \
+ *   __mask_snprintf_len(buf, buflen, cpus_addr(mask), sizeof(mask))
+ */
+
+int __mask_snprintf_len(char *buf, unsigned int buflen,
+	const unsigned long *maskp, unsigned int maskbytes)
+{
+	u32 *wordp = (u32 *)maskp;
+	int i = maskbytes/sizeof(u32) - 1;
+	int len = 0;
+	char *sep = "";
+
+	while (i >= 1 && wordp[i] == 0)
+		i--;
+	while (i >= 0) {
+		len += snprintf(buf+len, buflen-len, "%s%x", sep, wordp[i]);
+		sep = ",";
+		i--;
+	}
+	return len;
+}
+
+/**
+ * __mask_parse_len - parse user string into maskbytes mask at maskp
+ * @ubuf: The user buffer from which to take the string
+ * @ubuflen: The size of this buffer, including the terminating char
+ * @maskp: Place resulting mask (array of unsigned longs) here
+ * @masklen: Construct mask at @maskp to have exactly @masklen bytes
+ *
+ * @masklen is a multiple of sizeof(unsigned long).  A mask of
+ * @masklen bytes is constructed starting at location @maskp.
+ * The value of this mask is specified by the user provided
+ * string starting at address @ubuf.  Only bytes in the range
+ * [@ubuf, @ubuf+@ubuflen) can be read from user space, and
+ * reading will stop after the first byte that is not a comma
+ * or valid hex digit in the characters [,0-9a-fA-F], or at
+ * the point @ubuf+@ubuflen, whichever comes first.
+ *
+ * Since the user only needs about 2.25 chars per byte to encode
+ * a mask (one char per nibble plus one comma separator or nul
+ * terminator per byte), we blow them off with -EINVAL if they
+ * claim a @ubuflen more than 4 (MAX_HEX_PER_BYTE) times maskbytes.
+ * An empty word (delimited by two consecutive commas, for example)
+ * is taken as zero.  If @buflen is zero, the entire @maskp is set
+ * to zero.
+ *
+ * If the user provides fewer comma-separated ascii words
+ * than there are 32 bit words in maskbytes, we zero fill the
+ * remaining high order words.  If they provide more, they fail
+ * with -EINVAL.  Each comma-separate ascii word is taken as
+ * a hex representation; leading zeros are ignored, and do not
+ * imply octal.  '00e1', 'e1', '00E1', 'E1' are all the same.
+ * If user passes a word that is larger than fits in a u32,
+ * they fail with -EOVERFLOW.
+ */
+
+int __mask_parse_len(const char __user *ubuf, unsigned int ubuflen,
+	unsigned long *maskp, unsigned int maskbytes)
+{
+	char buf[maskbytes * MAX_HEX_PER_BYTE + sizeof(NUL)];
+	char *bp = buf;
+	u32 *wordp = (u32 *)maskp;
+	char *p;
+	int i, j;
+
+	if (ubuflen > maskbytes * MAX_HEX_PER_BYTE)
+		return -EINVAL;
+	if (copy_from_user(buf, ubuf, ubuflen))
+		return -EFAULT;
+	buf[ubuflen] = NUL;
+
+	/*
+	 * Put the words into wordp[] in big-endian order,
+	 * then go back and reverse them.
+	 */
+	memset(wordp, 0, maskbytes);
+	i = j = 0;
+	while ((p = strsep(&bp, ",")) != NULL) {
+		unsigned long long t;
+		if (j == maskbytes/sizeof(u32))
+			return -EINVAL;
+		t = simple_strtoull(p, 0, BASE);
+		if (t != (u32)t)
+			return -EOVERFLOW;
+		wordp[j++] = t;
+	}
+	--j;
+	while (i < j) {
+		u32 t = wordp[i];
+		wordp[i] = wordp[j];
+		wordp[j] = t;
+		i++, --j;
+	}
+	return 0;
+}


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
