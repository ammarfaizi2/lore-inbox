Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbUENOMD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbUENOMD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 10:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbUENOMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 10:12:03 -0400
Received: from aun.it.uu.se ([130.238.12.36]:34280 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261181AbUENOJl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 10:09:41 -0400
Date: Fri, 14 May 2004 16:09:30 +0200 (MEST)
Message-Id: <200405141409.i4EE9Uhd018397@alkaid.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][1/7] perfctr-2.7.2 for 2.6.6-mm2: core
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

perfctr-2.7.2 for 2.6.6-mm2, part 1/7:

- core driver files and kernel changes

 drivers/Makefile               |    1 
 drivers/perfctr/Kconfig        |   60 ++++
 drivers/perfctr/Makefile       |   21 +
 drivers/perfctr/cpumask.h      |   24 +
 drivers/perfctr/init.c         |  131 +++++++++
 drivers/perfctr/marshal.c      |   51 +++
 drivers/perfctr/marshal.h      |   16 +
 drivers/perfctr/marshal_core.c |  560 +++++++++++++++++++++++++++++++++++++++++
 drivers/perfctr/marshal_core.h |   79 +++++
 drivers/perfctr/version.h      |    1 
 include/linux/perfctr.h        |  211 +++++++++++++++
 kernel/sched.c                 |    3 
 kernel/sys.c                   |    1 
 kernel/timer.c                 |    2 
 14 files changed, 1161 insertions(+)

diff -ruN linux-2.6.6-mm2/drivers/Makefile linux-2.6.6-mm2.perfctr-2.7.2.core/drivers/Makefile
--- linux-2.6.6-mm2/drivers/Makefile	2004-04-04 13:49:10.000000000 +0200
+++ linux-2.6.6-mm2.perfctr-2.7.2.core/drivers/Makefile	2004-05-14 14:32:54.708042034 +0200
@@ -49,4 +49,5 @@
 obj-$(CONFIG_MCA)		+= mca/
 obj-$(CONFIG_EISA)		+= eisa/
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
+obj-$(CONFIG_PERFCTR)		+= perfctr/
 obj-y				+= firmware/
diff -ruN linux-2.6.6-mm2/drivers/perfctr/Kconfig linux-2.6.6-mm2.perfctr-2.7.2.core/drivers/perfctr/Kconfig
--- linux-2.6.6-mm2/drivers/perfctr/Kconfig	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.6-mm2.perfctr-2.7.2.core/drivers/perfctr/Kconfig	2004-05-14 14:32:54.708042034 +0200
@@ -0,0 +1,60 @@
+# $Id: Kconfig,v 1.9 2004/05/13 23:32:49 mikpe Exp $
+# Performance-monitoring counters driver configuration
+#
+
+menu "Performance-monitoring counters support"
+
+config PERFCTR
+	bool "Performance monitoring counters support"
+	help
+	  This driver provides access to the performance-monitoring counter
+	  registers available in some (but not all) modern processors.
+	  These special-purpose registers can be programmed to count low-level
+	  performance-related events which occur during program execution,
+	  such as cache misses, pipeline stalls, etc.
+
+	  You can safely say Y here, even if you intend to run the kernel
+	  on a processor without performance-monitoring counters.
+
+config PERFCTR_INIT_TESTS
+	bool "Init-time hardware tests"
+	depends on PERFCTR
+	help
+	  This option makes the driver perform additional hardware tests
+	  during initialisation, and log their results in the kernel's
+	  message buffer. For most supported processors, these tests simply
+	  measure the runtime overheads of performance counter operations.
+
+	  If you have a less well-known processor (one not listed in the
+	  etc/costs/ directory in the user-space package), you should enable
+	  this option and email the results to the perfctr developers.
+
+	  If unsure, say N.
+
+config PERFCTR_VIRTUAL
+	bool "Virtual performance counters support"
+	depends on PERFCTR
+	help
+	  The processor's performance-monitoring counters are special-purpose
+	  global registers. This option adds support for virtual per-process
+	  performance-monitoring counters which only run when the process
+	  to which they belong is executing. This improves the accuracy of
+	  performance measurements by reducing "noise" from other processes.
+
+	  Say Y.
+
+config PERFCTR_GLOBAL
+	bool "Global performance counters support"
+	depends on PERFCTR
+	help
+	  This option adds driver support for global-mode (system-wide)
+	  performance-monitoring counters. In this mode, the driver allows
+	  each performance-monitoring counter on each processor to be
+	  controlled and read. The driver provides a sampling timer to
+	  maintain 64-bit accumulated event counts.
+
+	  Global-mode performance counters cannot be used if some process
+	  is currently using virtual-mode performance counters, and vice versa.
+
+	  Say Y.
+endmenu
diff -ruN linux-2.6.6-mm2/drivers/perfctr/Makefile linux-2.6.6-mm2.perfctr-2.7.2.core/drivers/perfctr/Makefile
--- linux-2.6.6-mm2/drivers/perfctr/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.6-mm2.perfctr-2.7.2.core/drivers/perfctr/Makefile	2004-05-14 14:32:54.708042034 +0200
@@ -0,0 +1,21 @@
+# $Id: Makefile,v 1.23 2004/05/13 23:32:49 mikpe Exp $
+# Makefile for the Performance-monitoring counters driver.
+
+perfctr-objs-$(CONFIG_X86) := x86.o
+tests-objs-$(CONFIG_X86) := x86_tests.o
+
+# Braindamage alert! x86_64 defines _both_ CONFIG_X86_64 and CONFIG_X86.
+# These assignments need to override those above.
+perfctr-objs-$(CONFIG_X86_64) := x86_64.o
+tests-objs-$(CONFIG_X86_64) := x86_tests.o
+
+perfctr-objs-$(CONFIG_PPC32) := ppc.o
+tests-objs-$(CONFIG_PPC32) := ppc_tests.o
+
+perfctr-objs-y += init.o marshal.o
+perfctr-objs-$(CONFIG_PERFCTR_INIT_TESTS) += $(tests-objs-y)
+perfctr-objs-$(CONFIG_PERFCTR_VIRTUAL) += virtual.o
+perfctr-objs-$(CONFIG_PERFCTR_GLOBAL) += global.o
+
+perfctr-objs		:= $(perfctr-objs-y)
+obj-$(CONFIG_PERFCTR)	:= perfctr.o
diff -ruN linux-2.6.6-mm2/drivers/perfctr/cpumask.h linux-2.6.6-mm2.perfctr-2.7.2.core/drivers/perfctr/cpumask.h
--- linux-2.6.6-mm2/drivers/perfctr/cpumask.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.6-mm2.perfctr-2.7.2.core/drivers/perfctr/cpumask.h	2004-05-14 14:32:54.718042192 +0200
@@ -0,0 +1,24 @@
+/* $Id: cpumask.h,v 1.7 2004/05/12 19:59:01 mikpe Exp $
+ * Performance-monitoring counters driver.
+ * Partial simulation of cpumask_t on non-cpumask_t kernels.
+ * Extension to allow inspecting a cpumask_t as array of ulong.
+ * Appropriate definition of perfctr_cpus_forbidden_mask.
+ *
+ * Copyright (C) 2003-2004  Mikael Pettersson
+ */
+
+#ifdef CPU_ARRAY_SIZE
+#define PERFCTR_CPUMASK_NRLONGS	CPU_ARRAY_SIZE
+#else
+#define PERFCTR_CPUMASK_NRLONGS	1
+#endif
+
+/* `perfctr_cpus_forbidden_mask' used to be defined in <asm/perfctr.h>,
+   but cpumask_t compatibility issues forced it to be moved here. */
+#if PERFCTR_CPUS_FORBIDDEN_MASK_NEEDED
+extern cpumask_t perfctr_cpus_forbidden_mask;
+#define perfctr_cpu_is_forbidden(cpu)	cpu_isset((cpu), perfctr_cpus_forbidden_mask)
+#else
+#define perfctr_cpus_forbidden_mask	CPU_MASK_NONE
+#define perfctr_cpu_is_forbidden(cpu)	0 /* cpu_isset() needs an lvalue :-( */
+#endif
diff -ruN linux-2.6.6-mm2/drivers/perfctr/init.c linux-2.6.6-mm2.perfctr-2.7.2.core/drivers/perfctr/init.c
--- linux-2.6.6-mm2/drivers/perfctr/init.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.6-mm2.perfctr-2.7.2.core/drivers/perfctr/init.c	2004-05-14 14:32:54.718042192 +0200
@@ -0,0 +1,131 @@
+/* $Id: init.c,v 1.71 2004/05/13 23:32:49 mikpe Exp $
+ * Performance-monitoring counters driver.
+ * Top-level initialisation code.
+ *
+ * Copyright (C) 1999-2004  Mikael Pettersson
+ */
+#include <linux/config.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/perfctr.h>
+
+#include <asm/uaccess.h>
+
+#include "cpumask.h"
+#include "virtual.h"
+#include "global.h"
+#include "version.h"
+#include "marshal.h"
+
+struct perfctr_info perfctr_info = {
+	.abi_version = PERFCTR_ABI_VERSION,
+	.driver_version = VERSION,
+};
+
+char *perfctr_cpu_name __initdata;
+
+static int sys_perfctr_abi(unsigned int *argp)
+{
+	if( put_user(PERFCTR_ABI_VERSION, argp) )
+		return -EFAULT;
+	return 0;
+}
+
+static int sys_perfctr_info(struct perfctr_struct_buf *argp)
+{
+	return perfctr_copy_to_user(argp, &perfctr_info, &perfctr_info_sdesc);
+}
+
+static int cpus_copy_to_user(const cpumask_t *cpus, struct perfctr_cpu_mask *argp)
+{
+	const unsigned int k_nrwords = PERFCTR_CPUMASK_NRLONGS*(sizeof(long)/sizeof(int));
+	unsigned int u_nrwords;
+	unsigned int ui, ki, j;
+
+	if( get_user(u_nrwords, &argp->nrwords) )
+		return -EFAULT;
+	if( put_user(k_nrwords, &argp->nrwords) )
+		return -EFAULT;
+	if( u_nrwords < k_nrwords )
+		return -EOVERFLOW;
+	for(ui = 0, ki = 0; ki < PERFCTR_CPUMASK_NRLONGS; ++ki) {
+		unsigned long mask = cpus_addr(*cpus)[ki];
+		for(j = 0; j < sizeof(long)/sizeof(int); ++j) {
+			if( put_user((unsigned int)mask, &argp->mask[ui]) )
+				return -EFAULT;
+			++ui;
+			mask = (mask >> (8*sizeof(int)-1)) >> 1;
+		}
+	}
+	return 0;
+}
+
+static int sys_perfctr_cpus(struct perfctr_cpu_mask *argp)
+{
+	cpumask_t cpus = cpu_online_map;
+	return cpus_copy_to_user(&cpus, argp);
+}
+
+static int sys_perfctr_cpus_forbidden(struct perfctr_cpu_mask *argp)
+{
+	cpumask_t cpus = perfctr_cpus_forbidden_mask;
+	return cpus_copy_to_user(&cpus, argp);
+}
+
+static int init_done;
+
+asmlinkage int sys_perfctr(unsigned int cmd, int whom, unsigned long arg)
+{
+	if( !init_done )
+		return -ENODEV;
+	if( cmd >= GPERFCTR_CONTROL )
+		return sys_gperfctr(cmd, arg);
+	if( cmd >= VPERFCTR_READ_SUM )
+		return sys_vperfctr(cmd, whom, arg);
+	switch( cmd ) {
+	case PERFCTR_ABI:
+		return sys_perfctr_abi((unsigned int*)arg);
+	case PERFCTR_INFO:
+		return sys_perfctr_info((struct perfctr_struct_buf*)arg);
+	case PERFCTR_CPUS:
+		return sys_perfctr_cpus((struct perfctr_cpu_mask*)arg);
+	case PERFCTR_CPUS_FORBIDDEN:
+		return sys_perfctr_cpus_forbidden((struct perfctr_cpu_mask*)arg);
+	case VPERFCTR_CREAT:
+		return vperfctr_attach(whom, 1);
+	case VPERFCTR_OPEN:
+		return vperfctr_attach(whom, 0);
+	}
+	return -EINVAL;
+}
+
+int __init perfctr_init(void)
+{
+	int err;
+
+	err = perfctr_cpu_init();
+	if( err ) {
+		printk(KERN_INFO "perfctr: not supported by this processor\n");
+		return err;
+	}
+	err = vperfctr_init();
+	if( err )
+		return err;
+	gperfctr_init();
+	printk(KERN_INFO "perfctr: driver %s, cpu type %s at %u kHz\n",
+	       perfctr_info.driver_version,
+	       perfctr_cpu_name,
+	       perfctr_info.cpu_khz);
+	init_done = 1;
+	return 0;
+}
+
+void __exit perfctr_exit(void)
+{
+	vperfctr_exit();
+	perfctr_cpu_exit();
+}
+
+module_init(perfctr_init)
+module_exit(perfctr_exit)
diff -ruN linux-2.6.6-mm2/drivers/perfctr/marshal.c linux-2.6.6-mm2.perfctr-2.7.2.core/drivers/perfctr/marshal.c
--- linux-2.6.6-mm2/drivers/perfctr/marshal.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.6-mm2.perfctr-2.7.2.core/drivers/perfctr/marshal.c	2004-05-14 14:32:54.718042192 +0200
@@ -0,0 +1,51 @@
+/* $Id: marshal.c,v 1.8 2004/05/13 17:48:59 mikpe Exp $
+ * Performance-monitoring counters driver.
+ * Structure marshalling support, kernel-level code.
+ *
+ * Copyright (C) 2003-2004  Mikael Pettersson
+ */
+#include <linux/config.h>
+struct inode;
+#include <linux/sched.h>
+#include <linux/perfctr.h>
+#include <linux/errno.h>
+#include <linux/stddef.h>
+#include <linux/string.h>
+#include <asm/uaccess.h>
+
+#include "marshal.h"
+#include "marshal_core.c"
+
+int perfctr_copy_from_user(void *struct_address,
+			   struct perfctr_struct_buf *argp,
+			   const struct perfctr_struct_desc *sdesc)
+{
+	struct perfctr_marshal_stream stream;
+
+	if( get_user(stream.size, &argp->rdsize) )
+		return -EFAULT;
+	stream.buffer = argp->buffer;
+	stream.pos = 0;
+	stream.error = 0;
+	memset(struct_address, 0, sdesc->total_sizeof);
+	return perfctr_decode_struct(struct_address, sdesc, &stream);
+}
+
+int perfctr_copy_to_user(struct perfctr_struct_buf *argp,
+			 void *struct_address,
+			 const struct perfctr_struct_desc *sdesc)
+{
+	struct perfctr_marshal_stream stream;
+
+	if( get_user(stream.size, &argp->wrsize) )
+		return -EFAULT;
+	stream.buffer = argp->buffer;
+	stream.pos = 0;
+	stream.error = 0;
+	perfctr_encode_struct(struct_address, sdesc, &stream);
+	if( stream.error )
+		return stream.error;
+	if( put_user(stream.pos, &argp->rdsize) )
+		return -EFAULT;
+	return 0;
+}
diff -ruN linux-2.6.6-mm2/drivers/perfctr/marshal.h linux-2.6.6-mm2.perfctr-2.7.2.core/drivers/perfctr/marshal.h
--- linux-2.6.6-mm2/drivers/perfctr/marshal.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.6-mm2.perfctr-2.7.2.core/drivers/perfctr/marshal.h	2004-05-14 14:32:54.718042192 +0200
@@ -0,0 +1,16 @@
+/* $Id: marshal.h,v 1.2 2004/05/13 17:48:59 mikpe Exp $
+ * Performance-monitoring counters driver.
+ * Structure marshalling support, kernel-level declarations.
+ *
+ * Copyright (C) 2003-2004  Mikael Pettersson
+ */
+
+#include "marshal_core.h"
+
+int perfctr_copy_to_user(struct perfctr_struct_buf *argp,
+			 void *struct_address,
+			 const struct perfctr_struct_desc *sdesc);
+
+int perfctr_copy_from_user(void *struct_address,
+			   struct perfctr_struct_buf *argp,
+			   const struct perfctr_struct_desc *sdesc);
diff -ruN linux-2.6.6-mm2/drivers/perfctr/marshal_core.c linux-2.6.6-mm2.perfctr-2.7.2.core/drivers/perfctr/marshal_core.c
--- linux-2.6.6-mm2/drivers/perfctr/marshal_core.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.6-mm2.perfctr-2.7.2.core/drivers/perfctr/marshal_core.c	2004-05-14 14:32:54.718042192 +0200
@@ -0,0 +1,560 @@
+/* $Id: marshal_core.c,v 1.1 2004/05/13 17:48:59 mikpe Exp $
+ * Performance-monitoring counters driver.
+ * Structure marshalling support, common core code.
+ *
+ * Copyright (C) 2003-2004  Mikael Pettersson
+ */
+
+/****************************************************************
+ *								*
+ * Struct encoding support.					*
+ *								*
+ ****************************************************************/
+
+static void stream_write(struct perfctr_marshal_stream *stream, unsigned int word)
+{
+	if( !stream->error ) {
+		if( stream->pos >= stream->size )
+			stream->error = -EOVERFLOW;
+		else if( put_user(word, &stream->buffer[stream->pos]) )
+			stream->error = -EFAULT;
+	}
+	++stream->pos;
+}
+
+static void encode_field(const void *address,
+			 const struct perfctr_field_desc *field,
+			 struct perfctr_marshal_stream *stream)
+{
+	unsigned int base_type = PERFCTR_TYPE_BASE(field->type);
+	unsigned int nr_items = PERFCTR_TYPE_NRITEMS(field->type);
+	unsigned int tag = field->tag;
+	const char *pointer = (const char*)address + field->offset;
+	unsigned int uint32_val;
+	union {
+		unsigned long long ull;
+		unsigned int ui[2];
+	} uint64_val;
+	unsigned int i = 0;
+
+	do {
+		if( base_type == PERFCTR_TYPE_UINT64 ) {
+			uint64_val.ull = *(unsigned long long*)pointer;
+			pointer += sizeof(long long);
+			if( !uint64_val.ull )
+				continue;
+			stream_write(stream, PERFCTR_HEADER(PERFCTR_HEADER_UINT64, tag, i));
+			stream_write(stream, uint64_val.ui[0]);
+			stream_write(stream, uint64_val.ui[1]);
+		} else {		/* PERFCTR_TYPE_BYTES4 */
+			memcpy(&uint32_val, pointer, sizeof(int));
+			pointer += sizeof(int);	
+			if( !uint32_val )
+				continue;
+			stream_write(stream, PERFCTR_HEADER(PERFCTR_HEADER_UINT32, tag, i));
+			stream_write(stream, uint32_val);
+		}
+	} while( ++i < nr_items );
+}
+
+static void perfctr_encode_struct(const void *address,
+				  const struct perfctr_struct_desc *sdesc,
+				  struct perfctr_marshal_stream *stream)
+{
+	unsigned int i;
+
+	for(i = 0; i < sdesc->nrfields; ++i)
+		encode_field(address, &sdesc->fields[i], stream);
+	for(i = 0; i < sdesc->nrsubs; ++i) {
+		const struct perfctr_sub_struct_desc *sub = &sdesc->subs[i];
+		perfctr_encode_struct((char*)address + sub->offset, sub->sdesc, stream);
+	}
+}
+
+/****************************************************************
+ *								*
+ * Struct decoding support.					*
+ *								*
+ ****************************************************************/
+
+static int stream_read(struct perfctr_marshal_stream *stream, unsigned int *word)
+{
+	if( stream->pos >= stream->size )
+		return 0;
+	if( get_user(*word, &stream->buffer[stream->pos]) )
+		return -EFAULT;
+	++stream->pos;
+	return 1;
+}
+
+static const struct perfctr_field_desc*
+find_field(unsigned int *struct_offset,
+	   const struct perfctr_struct_desc *sdesc,
+	   unsigned int tag)
+{
+	unsigned int low, high, mid, i;
+	const struct perfctr_field_desc *field;
+	const struct perfctr_sub_struct_desc *sub;
+
+	low = 0;
+	high = sdesc->nrfields;	/* [low,high[ */
+	while( low < high ) {
+		mid = (low + high) / 2;
+		field = &sdesc->fields[mid];
+		if( field->tag == tag )
+			return field;
+		if( field->tag < tag )
+			low = mid + 1;
+		else
+			high = mid;
+	}
+	for(i = 0; i < sdesc->nrsubs; ++i) {
+		sub = &sdesc->subs[i];
+		field = find_field(struct_offset, sub->sdesc, tag);
+		if( field ) {
+			*struct_offset += sub->offset;
+			return field;
+		}
+	}
+	return 0;
+}
+
+static int perfctr_decode_struct(void *address,
+				 const struct perfctr_struct_desc *sdesc,
+				 struct perfctr_marshal_stream *stream)
+{
+	unsigned int header;
+	int err;
+	const struct perfctr_field_desc *field;
+	unsigned int struct_offset;
+	union {
+		unsigned long long ull;
+		unsigned int ui[2];
+	} val;
+	char *target;
+	unsigned int itemnr;
+
+	for(;;) {
+		err = stream_read(stream, &header);
+		if( err <= 0 )
+			return err;
+		struct_offset = 0;
+		field = find_field(&struct_offset, sdesc, PERFCTR_HEADER_TAG(header));
+		if( !field )
+			goto err_eproto;
+		/* a 64-bit datum must have a 64-bit target field */
+		if( PERFCTR_HEADER_TYPE(header) != PERFCTR_HEADER_UINT32 &&
+		    PERFCTR_TYPE_BASE(field->type) != PERFCTR_TYPE_UINT64 )
+			goto err_eproto;
+		err = stream_read(stream, &val.ui[0]);
+		if( err <= 0 )
+			goto err_err;
+		target = (char*)address + struct_offset + field->offset;
+		itemnr = PERFCTR_HEADER_ITEMNR(header);
+		if( itemnr >= PERFCTR_TYPE_NRITEMS(field->type) )
+			goto err_eproto;
+		if( PERFCTR_TYPE_BASE(field->type) == PERFCTR_TYPE_UINT64 ) {
+			/* a 64-bit field must have a 64-bit datum */
+			if( PERFCTR_HEADER_TYPE(header) == PERFCTR_HEADER_UINT32 )
+				goto err_eproto;
+			err = stream_read(stream, &val.ui[1]);
+			if( err <= 0 )
+				goto err_err;
+			((unsigned long long*)target)[itemnr] = val.ull;
+		} else
+			memcpy(&((unsigned int*)target)[itemnr], &val.ui[0], sizeof(int));
+	}
+ err_err:	/* err ? err : -EPROTO */
+	if( err )
+		return err;
+ err_eproto:	/* saves object code over inlining it */
+	return -EPROTO;
+}
+
+/****************************************************************
+ *								*
+ * Structure descriptors.					*
+ *								*
+ ****************************************************************/
+
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+#define STRUCT_ARRAY_SIZE(TYPE, MEMBER) ARRAY_SIZE(((TYPE*)0)->MEMBER)
+
+#if defined(__i386__) || defined(__x86_64__)
+
+#define PERFCTR_TAG_CPU_CONTROL_TSC_ON	32
+#define PERFCTR_TAG_CPU_CONTROL_NRACTRS	33
+#define PERFCTR_TAG_CPU_CONTROL_NRICTRS	34
+#define PERFCTR_TAG_CPU_CONTROL_PMC_MAP	35
+#define PERFCTR_TAG_CPU_CONTROL_EVNTSEL	36
+#define PERFCTR_TAG_CPU_CONTROL_IRESET	37
+#define PERFCTR_TAG_CPU_CONTROL_P4_ESCR	38
+#define PERFCTR_TAG_CPU_CONTROL_P4_PE	39
+#define PERFCTR_TAG_CPU_CONTROL_P4_PMV	40
+#define PERFCTR_TAG_CPU_CONTROL_RSVD1	41
+#define PERFCTR_TAG_CPU_CONTROL_RSVD2	42
+#define PERFCTR_TAG_CPU_CONTROL_RSVD3	43
+#define PERFCTR_TAG_CPU_CONTROL_RSVD4	44
+#define PERFCTR_CPU_CONTROL_NRFIELDS_0	(7 + STRUCT_ARRAY_SIZE(struct perfctr_cpu_control, pmc_map) + STRUCT_ARRAY_SIZE(struct perfctr_cpu_control, evntsel) + STRUCT_ARRAY_SIZE(struct perfctr_cpu_control, ireset))
+#ifdef __x86_64__
+#define PERFCTR_CPU_CONTROL_NRFIELDS_1	0
+#else
+#define PERFCTR_CPU_CONTROL_NRFIELDS_1	(2 + STRUCT_ARRAY_SIZE(struct perfctr_cpu_control, p4.escr))
+#endif
+#define PERFCTR_CPU_CONTROL_NRFIELDS	(PERFCTR_CPU_CONTROL_NRFIELDS_0 + PERFCTR_CPU_CONTROL_NRFIELDS_1)
+
+#define PERFCTR_TAG_SUM_CTRS_TSC	48
+#define PERFCTR_TAG_SUM_CTRS_PMC	49
+#define PERFCTR_SUM_CTRS_NRFIELDS	(1 + STRUCT_ARRAY_SIZE(struct perfctr_sum_ctrs, pmc))
+
+static const struct perfctr_field_desc perfctr_sum_ctrs_fields[] = {
+	{ .offset = offsetof(struct perfctr_sum_ctrs, tsc),
+	  .tag = PERFCTR_TAG_SUM_CTRS_TSC,
+	  .type = PERFCTR_TYPE_UINT64 },
+	{ .offset = offsetof(struct perfctr_sum_ctrs, pmc),
+	  .tag = PERFCTR_TAG_SUM_CTRS_PMC,
+	  .type = PERFCTR_TYPE_ARRAY(STRUCT_ARRAY_SIZE(struct perfctr_sum_ctrs,pmc),
+				     PERFCTR_TYPE_UINT64) },
+};
+
+const struct perfctr_struct_desc perfctr_sum_ctrs_sdesc = {
+	.total_sizeof = sizeof(struct perfctr_sum_ctrs),
+	.total_nrfields = PERFCTR_SUM_CTRS_NRFIELDS,
+	.nrfields = ARRAY_SIZE(perfctr_sum_ctrs_fields),
+	.fields = perfctr_sum_ctrs_fields,
+};
+
+static const struct perfctr_field_desc perfctr_cpu_control_fields[] = {
+	{ .offset = offsetof(struct perfctr_cpu_control, tsc_on),
+	  .tag = PERFCTR_TAG_CPU_CONTROL_TSC_ON,
+	  .type = PERFCTR_TYPE_BYTES4 },
+	{ .offset = offsetof(struct perfctr_cpu_control, nractrs),
+	  .tag = PERFCTR_TAG_CPU_CONTROL_NRACTRS,
+	  .type = PERFCTR_TYPE_BYTES4 },
+	{ .offset = offsetof(struct perfctr_cpu_control, nrictrs),
+	  .tag = PERFCTR_TAG_CPU_CONTROL_NRICTRS,
+	  .type = PERFCTR_TYPE_BYTES4 },
+	{ .offset = offsetof(struct perfctr_cpu_control, pmc_map),
+	  .tag = PERFCTR_TAG_CPU_CONTROL_PMC_MAP,
+	  .type = PERFCTR_TYPE_ARRAY(STRUCT_ARRAY_SIZE(struct perfctr_cpu_control,pmc_map),
+				     PERFCTR_TYPE_BYTES4) },
+	{ .offset = offsetof(struct perfctr_cpu_control, evntsel),
+	  .tag = PERFCTR_TAG_CPU_CONTROL_EVNTSEL,
+	  .type = PERFCTR_TYPE_ARRAY(STRUCT_ARRAY_SIZE(struct perfctr_cpu_control,evntsel),
+				     PERFCTR_TYPE_BYTES4) },
+	{ .offset = offsetof(struct perfctr_cpu_control, ireset),
+	  .tag = PERFCTR_TAG_CPU_CONTROL_IRESET,
+	  .type = PERFCTR_TYPE_ARRAY(STRUCT_ARRAY_SIZE(struct perfctr_cpu_control,ireset),
+				     PERFCTR_TYPE_BYTES4) },
+#ifndef __x86_64__
+	{ .offset = offsetof(struct perfctr_cpu_control, p4.escr),
+	  .tag = PERFCTR_TAG_CPU_CONTROL_P4_ESCR,
+	  .type = PERFCTR_TYPE_ARRAY(STRUCT_ARRAY_SIZE(struct perfctr_cpu_control,p4.escr),
+				     PERFCTR_TYPE_BYTES4) },
+	{ .offset = offsetof(struct perfctr_cpu_control, p4.pebs_enable),
+	  .tag = PERFCTR_TAG_CPU_CONTROL_P4_PE,
+	  .type = PERFCTR_TYPE_BYTES4 },
+	{ .offset = offsetof(struct perfctr_cpu_control, p4.pebs_matrix_vert),
+	  .tag = PERFCTR_TAG_CPU_CONTROL_P4_PMV,
+	  .type = PERFCTR_TYPE_BYTES4 },
+#endif	/* __x86_64__ */
+	{ .offset = offsetof(struct perfctr_cpu_control, _reserved1),
+	  .tag = PERFCTR_TAG_CPU_CONTROL_RSVD1,
+	  .type = PERFCTR_TYPE_BYTES4 },
+	{ .offset = offsetof(struct perfctr_cpu_control, _reserved2),
+	  .tag = PERFCTR_TAG_CPU_CONTROL_RSVD2,
+	  .type = PERFCTR_TYPE_BYTES4 },
+	{ .offset = offsetof(struct perfctr_cpu_control, _reserved3),
+	  .tag = PERFCTR_TAG_CPU_CONTROL_RSVD3,
+	  .type = PERFCTR_TYPE_BYTES4 },
+	{ .offset = offsetof(struct perfctr_cpu_control, _reserved4),
+	  .tag = PERFCTR_TAG_CPU_CONTROL_RSVD4,
+	  .type = PERFCTR_TYPE_BYTES4 },
+};
+
+const struct perfctr_struct_desc perfctr_cpu_control_sdesc = {
+	.total_sizeof = sizeof(struct perfctr_cpu_control),
+	.total_nrfields = PERFCTR_CPU_CONTROL_NRFIELDS,
+	.nrfields = ARRAY_SIZE(perfctr_cpu_control_fields),
+	.fields = perfctr_cpu_control_fields,
+};
+
+#endif	/* __i386__ || __x86_64__ */
+
+#if defined(__powerpc__)	/* XXX: can be merged with x86/amd64 */
+
+#define PERFCTR_TAG_CPU_CONTROL_TSC_ON	32
+#define PERFCTR_TAG_CPU_CONTROL_NRACTRS	33
+#define PERFCTR_TAG_CPU_CONTROL_NRICTRS	34
+#define PERFCTR_TAG_CPU_CONTROL_PMC_MAP	35
+#define PERFCTR_TAG_CPU_CONTROL_EVNTSEL	36
+#define PERFCTR_TAG_CPU_CONTROL_IRESET	37
+#define PERFCTR_TAG_CPU_CONTROL_PPC_MMCR0	38
+#define PERFCTR_TAG_CPU_CONTROL_PPC_MMCR2	39
+/* 40: unused */
+#define PERFCTR_TAG_CPU_CONTROL_RSVD1	41
+#define PERFCTR_TAG_CPU_CONTROL_RSVD2	42
+#define PERFCTR_TAG_CPU_CONTROL_RSVD3	43
+#define PERFCTR_TAG_CPU_CONTROL_RSVD4	44
+#define PERFCTR_CPU_CONTROL_NRFIELDS_0	(7 + STRUCT_ARRAY_SIZE(struct perfctr_cpu_control, pmc_map) + STRUCT_ARRAY_SIZE(struct perfctr_cpu_control, evntsel) + STRUCT_ARRAY_SIZE(struct perfctr_cpu_control, ireset))
+#ifdef __powerpc__
+#define PERFCTR_CPU_CONTROL_NRFIELDS_1	2
+#endif
+#define PERFCTR_CPU_CONTROL_NRFIELDS	(PERFCTR_CPU_CONTROL_NRFIELDS_0 + PERFCTR_CPU_CONTROL_NRFIELDS_1)
+
+#define PERFCTR_TAG_SUM_CTRS_TSC	48
+#define PERFCTR_TAG_SUM_CTRS_PMC	49
+#define PERFCTR_SUM_CTRS_NRFIELDS	(1 + STRUCT_ARRAY_SIZE(struct perfctr_sum_ctrs, pmc))
+
+static const struct perfctr_field_desc perfctr_sum_ctrs_fields[] = {
+	{ .offset = offsetof(struct perfctr_sum_ctrs, tsc),
+	  .tag = PERFCTR_TAG_SUM_CTRS_TSC,
+	  .type = PERFCTR_TYPE_UINT64 },
+	{ .offset = offsetof(struct perfctr_sum_ctrs, pmc),
+	  .tag = PERFCTR_TAG_SUM_CTRS_PMC,
+	  .type = PERFCTR_TYPE_ARRAY(STRUCT_ARRAY_SIZE(struct perfctr_sum_ctrs,pmc),
+				     PERFCTR_TYPE_UINT64) },
+};
+
+const struct perfctr_struct_desc perfctr_sum_ctrs_sdesc = {
+	.total_sizeof = sizeof(struct perfctr_sum_ctrs),
+	.total_nrfields = PERFCTR_SUM_CTRS_NRFIELDS,
+	.nrfields = ARRAY_SIZE(perfctr_sum_ctrs_fields),
+	.fields = perfctr_sum_ctrs_fields,
+};
+
+static const struct perfctr_field_desc perfctr_cpu_control_fields[] = {
+	{ .offset = offsetof(struct perfctr_cpu_control, tsc_on),
+	  .tag = PERFCTR_TAG_CPU_CONTROL_TSC_ON,
+	  .type = PERFCTR_TYPE_BYTES4 },
+	{ .offset = offsetof(struct perfctr_cpu_control, nractrs),
+	  .tag = PERFCTR_TAG_CPU_CONTROL_NRACTRS,
+	  .type = PERFCTR_TYPE_BYTES4 },
+	{ .offset = offsetof(struct perfctr_cpu_control, nrictrs),
+	  .tag = PERFCTR_TAG_CPU_CONTROL_NRICTRS,
+	  .type = PERFCTR_TYPE_BYTES4 },
+	{ .offset = offsetof(struct perfctr_cpu_control, pmc_map),
+	  .tag = PERFCTR_TAG_CPU_CONTROL_PMC_MAP,
+	  .type = PERFCTR_TYPE_ARRAY(STRUCT_ARRAY_SIZE(struct perfctr_cpu_control,pmc_map),
+				     PERFCTR_TYPE_BYTES4) },
+	{ .offset = offsetof(struct perfctr_cpu_control, evntsel),
+	  .tag = PERFCTR_TAG_CPU_CONTROL_EVNTSEL,
+	  .type = PERFCTR_TYPE_ARRAY(STRUCT_ARRAY_SIZE(struct perfctr_cpu_control,evntsel),
+				     PERFCTR_TYPE_BYTES4) },
+	{ .offset = offsetof(struct perfctr_cpu_control, ireset),
+	  .tag = PERFCTR_TAG_CPU_CONTROL_IRESET,
+	  .type = PERFCTR_TYPE_ARRAY(STRUCT_ARRAY_SIZE(struct perfctr_cpu_control,ireset),
+				     PERFCTR_TYPE_BYTES4) },
+#ifdef __powerpc__
+	{ .offset = offsetof(struct perfctr_cpu_control, ppc.mmcr0),
+	  .tag = PERFCTR_TAG_CPU_CONTROL_PPC_MMCR0,
+	  .type = PERFCTR_TYPE_BYTES4 },
+	{ .offset = offsetof(struct perfctr_cpu_control, ppc.mmcr2),
+	  .tag = PERFCTR_TAG_CPU_CONTROL_PPC_MMCR2,
+	  .type = PERFCTR_TYPE_BYTES4 },
+#endif	/* __powerpc__ */
+	{ .offset = offsetof(struct perfctr_cpu_control, _reserved1),
+	  .tag = PERFCTR_TAG_CPU_CONTROL_RSVD1,
+	  .type = PERFCTR_TYPE_BYTES4 },
+	{ .offset = offsetof(struct perfctr_cpu_control, _reserved2),
+	  .tag = PERFCTR_TAG_CPU_CONTROL_RSVD2,
+	  .type = PERFCTR_TYPE_BYTES4 },
+	{ .offset = offsetof(struct perfctr_cpu_control, _reserved3),
+	  .tag = PERFCTR_TAG_CPU_CONTROL_RSVD3,
+	  .type = PERFCTR_TYPE_BYTES4 },
+	{ .offset = offsetof(struct perfctr_cpu_control, _reserved4),
+	  .tag = PERFCTR_TAG_CPU_CONTROL_RSVD4,
+	  .type = PERFCTR_TYPE_BYTES4 },
+};
+
+const struct perfctr_struct_desc perfctr_cpu_control_sdesc = {
+	.total_sizeof = sizeof(struct perfctr_cpu_control),
+	.total_nrfields = PERFCTR_CPU_CONTROL_NRFIELDS,
+	.nrfields = ARRAY_SIZE(perfctr_cpu_control_fields),
+	.fields = perfctr_cpu_control_fields,
+};
+
+#endif	/* __powerpc__ */
+
+#define PERFCTR_TAG_INFO_ABI_VERSION		0
+#define PERFCTR_TAG_INFO_DRIVER_VERSION		1
+#define PERFCTR_TAG_INFO_CPU_TYPE		2
+#define PERFCTR_TAG_INFO_CPU_FEATURES		3
+#define PERFCTR_TAG_INFO_CPU_KHZ		4
+#define PERFCTR_TAG_INFO_TSC_TO_CPU_MULT	5
+#define PERFCTR_TAG_INFO_RSVD2			6
+#define PERFCTR_TAG_INFO_RSVD3			7
+#define PERFCTR_TAG_INFO_RSVD4			8
+#define PERFCTR_INFO_NRFIELDS	(8 + sizeof(((struct perfctr_info*)0)->driver_version)/sizeof(int))
+
+#define VPERFCTR_TAG_CONTROL_SIGNO		9
+#define VPERFCTR_TAG_CONTROL_PRESERVE		10
+#define VPERFCTR_TAG_CONTROL_RSVD1		11
+#define VPERFCTR_TAG_CONTROL_RSVD2		12
+#define VPERFCTR_TAG_CONTROL_RSVD3		13
+#define VPERFCTR_TAG_CONTROL_RSVD4		14
+#define VPERFCTR_CONTROL_NRFIELDS		(6 + PERFCTR_CPU_CONTROL_NRFIELDS)
+
+#define GPERFCTR_TAG_CPU_CONTROL_CPU		15
+#define GPERFCTR_TAG_CPU_CONTROL_RSVD1		16
+#define GPERFCTR_TAG_CPU_CONTROL_RSVD2		17
+#define GPERFCTR_TAG_CPU_CONTROL_RSVD3		18
+#define GPERFCTR_TAG_CPU_CONTROL_RSVD4		19
+#define GPERFCTR_CPU_CONTROL_NRFIELDS		(5 + PERFCTR_CPU_CONTROL_NRFIELDS)
+
+#define GPERFCTR_TAG_CPU_STATE_CPU		20
+#define GPERFCTR_TAG_CPU_STATE_RSVD1		21
+#define GPERFCTR_TAG_CPU_STATE_RSVD2		22
+#define GPERFCTR_TAG_CPU_STATE_RSVD3		23
+#define GPERFCTR_TAG_CPU_STATE_RSVD4		24
+#define GPERFCTR_CPU_STATE_ONLY_CPU_NRFIELDS	5
+#define GPERFCTR_CPU_STATE_NRFIELDS	(GPERFCTR_CPU_STATE_ONLY_CPU_NRFIELDS + PERFCTR_CPU_CONTROL_NRFIELDS + PERFCTR_SUM_CTRS_NRFIELDS)
+
+static const struct perfctr_field_desc perfctr_info_fields[] = {
+	{ .offset = offsetof(struct perfctr_info, abi_version),
+	  .tag = PERFCTR_TAG_INFO_ABI_VERSION,
+	  .type = PERFCTR_TYPE_BYTES4 },
+	{ .offset = offsetof(struct perfctr_info, driver_version),
+	  .tag = PERFCTR_TAG_INFO_DRIVER_VERSION,
+	  .type = PERFCTR_TYPE_ARRAY(sizeof(((struct perfctr_info*)0)->driver_version)/sizeof(int), PERFCTR_TYPE_BYTES4) },
+	{ .offset = offsetof(struct perfctr_info, cpu_type),
+	  .tag = PERFCTR_TAG_INFO_CPU_TYPE,
+	  .type = PERFCTR_TYPE_BYTES4 },
+	{ .offset = offsetof(struct perfctr_info, cpu_features),
+	  .tag = PERFCTR_TAG_INFO_CPU_FEATURES,
+	  .type = PERFCTR_TYPE_BYTES4 },
+	{ .offset = offsetof(struct perfctr_info, cpu_khz),
+	  .tag = PERFCTR_TAG_INFO_CPU_KHZ,
+	  .type = PERFCTR_TYPE_BYTES4 },
+	{ .offset = offsetof(struct perfctr_info, tsc_to_cpu_mult),
+	  .tag = PERFCTR_TAG_INFO_TSC_TO_CPU_MULT,
+	  .type = PERFCTR_TYPE_BYTES4 },
+	{ .offset = offsetof(struct perfctr_info, _reserved2),
+	  .tag = PERFCTR_TAG_INFO_RSVD2,
+	  .type = PERFCTR_TYPE_BYTES4 },
+	{ .offset = offsetof(struct perfctr_info, _reserved3),
+	  .tag = PERFCTR_TAG_INFO_RSVD3,
+	  .type = PERFCTR_TYPE_BYTES4 },
+	{ .offset = offsetof(struct perfctr_info, _reserved4),
+	  .tag = PERFCTR_TAG_INFO_RSVD4,
+	  .type = PERFCTR_TYPE_BYTES4 },
+};
+
+const struct perfctr_struct_desc perfctr_info_sdesc = {
+	.total_sizeof = sizeof(struct perfctr_info),
+	.total_nrfields = PERFCTR_INFO_NRFIELDS,
+	.nrfields = ARRAY_SIZE(perfctr_info_fields),
+	.fields = perfctr_info_fields,
+};
+
+#if defined(CONFIG_PERFCTR_VIRTUAL)
+static const struct perfctr_field_desc vperfctr_control_fields[] = {
+	{ .offset = offsetof(struct vperfctr_control, si_signo),
+	  .tag = VPERFCTR_TAG_CONTROL_SIGNO,
+	  .type = PERFCTR_TYPE_BYTES4 },
+	{ .offset = offsetof(struct vperfctr_control, preserve),
+	  .tag = VPERFCTR_TAG_CONTROL_PRESERVE,
+	  .type = PERFCTR_TYPE_BYTES4 },
+	{ .offset = offsetof(struct vperfctr_control, _reserved1),
+	  .tag = VPERFCTR_TAG_CONTROL_RSVD1,
+	  .type = PERFCTR_TYPE_BYTES4 },
+	{ .offset = offsetof(struct vperfctr_control, _reserved2),
+	  .tag = VPERFCTR_TAG_CONTROL_RSVD2,
+	  .type = PERFCTR_TYPE_BYTES4 },
+	{ .offset = offsetof(struct vperfctr_control, _reserved3),
+	  .tag = VPERFCTR_TAG_CONTROL_RSVD3,
+	  .type = PERFCTR_TYPE_BYTES4 },
+	{ .offset = offsetof(struct vperfctr_control, _reserved4),
+	  .tag = VPERFCTR_TAG_CONTROL_RSVD4,
+	  .type = PERFCTR_TYPE_BYTES4 },
+};
+
+static const struct perfctr_sub_struct_desc vperfctr_control_subs[] = {
+	{ .offset = offsetof(struct vperfctr_control, cpu_control),
+	  .sdesc = &perfctr_cpu_control_sdesc },
+};
+
+const struct perfctr_struct_desc vperfctr_control_sdesc = {
+	.total_sizeof = sizeof(struct vperfctr_control),
+	.total_nrfields = VPERFCTR_CONTROL_NRFIELDS,
+	.nrfields = ARRAY_SIZE(vperfctr_control_fields),
+	.fields = vperfctr_control_fields,
+	.nrsubs = ARRAY_SIZE(vperfctr_control_subs),
+	.subs = vperfctr_control_subs,
+};
+#endif	/* CONFIG_PERFCTR_VIRTUAL */
+
+#if defined(CONFIG_PERFCTR_GLOBAL)
+static const struct perfctr_field_desc gperfctr_cpu_control_fields[] = {
+	{ .offset = offsetof(struct gperfctr_cpu_control, cpu),
+	  .tag = GPERFCTR_TAG_CPU_CONTROL_CPU,
+	  .type = PERFCTR_TYPE_BYTES4 },
+	{ .offset = offsetof(struct gperfctr_cpu_control, _reserved1),
+	  .tag = GPERFCTR_TAG_CPU_CONTROL_RSVD1,
+	  .type = PERFCTR_TYPE_BYTES4 },
+	{ .offset = offsetof(struct gperfctr_cpu_control, _reserved2),
+	  .tag = GPERFCTR_TAG_CPU_CONTROL_RSVD2,
+	  .type = PERFCTR_TYPE_BYTES4 },
+	{ .offset = offsetof(struct gperfctr_cpu_control, _reserved3),
+	  .tag = GPERFCTR_TAG_CPU_CONTROL_RSVD3,
+	  .type = PERFCTR_TYPE_BYTES4 },
+	{ .offset = offsetof(struct gperfctr_cpu_control, _reserved4),
+	  .tag = GPERFCTR_TAG_CPU_CONTROL_RSVD4,
+	  .type = PERFCTR_TYPE_BYTES4 },
+};
+
+static const struct perfctr_sub_struct_desc gperfctr_cpu_control_subs[] = {
+	{ .offset = offsetof(struct gperfctr_cpu_control, cpu_control),
+	  .sdesc = &perfctr_cpu_control_sdesc },
+};
+
+const struct perfctr_struct_desc gperfctr_cpu_control_sdesc = {
+	.total_sizeof = sizeof(struct gperfctr_cpu_control),
+	.total_nrfields = GPERFCTR_CPU_CONTROL_NRFIELDS,
+	.nrfields = ARRAY_SIZE(gperfctr_cpu_control_fields),
+	.fields = gperfctr_cpu_control_fields,
+	.nrsubs = ARRAY_SIZE(gperfctr_cpu_control_subs),
+	.subs = gperfctr_cpu_control_subs,
+};
+
+static const struct perfctr_field_desc gperfctr_cpu_state_fields[] = {
+	{ .offset = offsetof(struct gperfctr_cpu_state, cpu),
+	  .tag = GPERFCTR_TAG_CPU_STATE_CPU,
+	  .type = PERFCTR_TYPE_BYTES4 },
+	{ .offset = offsetof(struct gperfctr_cpu_state, _reserved1),
+	  .tag = GPERFCTR_TAG_CPU_STATE_RSVD1,
+	  .type = PERFCTR_TYPE_BYTES4 },
+	{ .offset = offsetof(struct gperfctr_cpu_state, _reserved2),
+	  .tag = GPERFCTR_TAG_CPU_STATE_RSVD2,
+	  .type = PERFCTR_TYPE_BYTES4 },
+	{ .offset = offsetof(struct gperfctr_cpu_state, _reserved3),
+	  .tag = GPERFCTR_TAG_CPU_STATE_RSVD3,
+	  .type = PERFCTR_TYPE_BYTES4 },
+	{ .offset = offsetof(struct gperfctr_cpu_state, _reserved4),
+	  .tag = GPERFCTR_TAG_CPU_STATE_RSVD4,
+	  .type = PERFCTR_TYPE_BYTES4 },
+};
+
+static const struct perfctr_sub_struct_desc gperfctr_cpu_state_subs[] = {
+	{ .offset = offsetof(struct gperfctr_cpu_state, cpu_control),
+	  .sdesc = &perfctr_cpu_control_sdesc },
+	{ .offset = offsetof(struct gperfctr_cpu_state, sum),
+	  .sdesc = &perfctr_sum_ctrs_sdesc },
+};
+
+const struct perfctr_struct_desc gperfctr_cpu_state_only_cpu_sdesc = {
+	.total_sizeof = sizeof(struct gperfctr_cpu_state),
+	.total_nrfields = GPERFCTR_CPU_STATE_ONLY_CPU_NRFIELDS,
+	.nrfields = ARRAY_SIZE(gperfctr_cpu_state_fields),
+	.fields = gperfctr_cpu_state_fields,
+};
+
+const struct perfctr_struct_desc gperfctr_cpu_state_sdesc = {
+	.total_sizeof = sizeof(struct gperfctr_cpu_state),
+	.total_nrfields = GPERFCTR_CPU_STATE_NRFIELDS,
+	.nrfields = ARRAY_SIZE(gperfctr_cpu_state_fields),
+	.fields = gperfctr_cpu_state_fields,
+	.nrsubs = ARRAY_SIZE(gperfctr_cpu_state_subs),
+	.subs = gperfctr_cpu_state_subs,
+};
+#endif	/* CONFIG_PERFCTR_GLOBAL */
diff -ruN linux-2.6.6-mm2/drivers/perfctr/marshal_core.h linux-2.6.6-mm2.perfctr-2.7.2.core/drivers/perfctr/marshal_core.h
--- linux-2.6.6-mm2/drivers/perfctr/marshal_core.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.6-mm2.perfctr-2.7.2.core/drivers/perfctr/marshal_core.h	2004-05-14 14:32:54.718042192 +0200
@@ -0,0 +1,79 @@
+/* $Id: marshal_core.h,v 1.1 2004/05/13 17:48:59 mikpe Exp $
+ * Performance-monitoring counters driver.
+ * Structure marshalling support, common core declarations.
+ *
+ * Copyright (C) 2003-2004  Mikael Pettersson
+ */
+
+/*
+ * Each encoded datum starts with a 32-bit header word, containing
+ * the datum's type (1 bit: UINT32 or UINT64), the target's field
+ * tag (16 bits), and the target field's array index (15 bits).
+ *
+ * After the header follows the datum's value, in one (for UINT32)
+ * or two (for UINT64) words. Multi-word values are emitted in
+ * native word order.
+ *
+ * To encode a struct, encode each field with a non-zero value,
+ * and place the encodings in sequence. The field order is arbitrary.
+ *
+ * To decode an encoded struct, first memset() the target struct
+ * to zero. Then decode each encoded field in the sequence and
+ * update the corresponding field in the target struct.
+ */
+#define PERFCTR_HEADER(TYPE,TAG,ITEMNR) (((TAG)<<16)|((ITEMNR)<<1)|(TYPE))
+#define PERFCTR_HEADER_TYPE(H)		((H) & 0x1)
+#define PERFCTR_HEADER_ITEMNR(H)	(((H) >> 1) & 0x7FFF)
+#define PERFCTR_HEADER_TAG(H)		((H) >> 16)
+
+#define PERFCTR_HEADER_UINT32		0
+#define PERFCTR_HEADER_UINT64		1
+
+/*
+ * A field descriptor describes a struct field to the
+ * encoding and decoding procedures.
+ *
+ * To keep the descriptors small, field tags and array sizes
+ * are currently restricted to 8 and 7 bits, respectively.
+ * This does not change the encoded format.
+ */
+struct perfctr_field_desc {
+	unsigned short offset;	/* offsetof() for this field */
+	unsigned char tag;	/* identifying tag in encoded format */
+	unsigned char type;	/* base type (1 bit), array size - 1 (7 bits) */
+};
+
+#define PERFCTR_TYPE_ARRAY(N,T)	((((N) - 1) << 1) | (T))
+#define PERFCTR_TYPE_BASE(T)	((T) & 0x1)
+#define PERFCTR_TYPE_NRITEMS(T)	(((T) >> 1) + 1)
+
+#define PERFCTR_TYPE_BYTES4	0	/* uint32 or char[4] */
+#define PERFCTR_TYPE_UINT64	1	/* long long */
+
+struct perfctr_struct_desc {
+	unsigned short total_sizeof;	/* for buffer allocation and decode memset() */
+	unsigned short total_nrfields;	/* for buffer allocation */
+	unsigned short nrfields;
+	unsigned short nrsubs;
+	/* Note: the fields must be in ascending tag order */
+	const struct perfctr_field_desc *fields;
+	const struct perfctr_sub_struct_desc {
+		unsigned short offset;
+		const struct perfctr_struct_desc *sdesc;
+	} *subs;
+};
+
+struct perfctr_marshal_stream {
+	unsigned int size;
+	unsigned int *buffer;
+	unsigned int pos;
+	unsigned int error;
+};
+
+extern const struct perfctr_struct_desc perfctr_sum_ctrs_sdesc;
+extern const struct perfctr_struct_desc perfctr_cpu_control_sdesc;
+extern const struct perfctr_struct_desc perfctr_info_sdesc;
+extern const struct perfctr_struct_desc vperfctr_control_sdesc;
+extern const struct perfctr_struct_desc gperfctr_cpu_control_sdesc;
+extern const struct perfctr_struct_desc gperfctr_cpu_state_only_cpu_sdesc;
+extern const struct perfctr_struct_desc gperfctr_cpu_state_sdesc;
diff -ruN linux-2.6.6-mm2/drivers/perfctr/version.h linux-2.6.6-mm2.perfctr-2.7.2.core/drivers/perfctr/version.h
--- linux-2.6.6-mm2/drivers/perfctr/version.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.6-mm2.perfctr-2.7.2.core/drivers/perfctr/version.h	2004-05-14 14:32:54.718042192 +0200
@@ -0,0 +1 @@
+#define VERSION "2.7.2"
diff -ruN linux-2.6.6-mm2/include/linux/perfctr.h linux-2.6.6-mm2.perfctr-2.7.2.core/include/linux/perfctr.h
--- linux-2.6.6-mm2/include/linux/perfctr.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.6-mm2.perfctr-2.7.2.core/include/linux/perfctr.h	2004-05-14 14:32:54.708042034 +0200
@@ -0,0 +1,211 @@
+/* $Id: perfctr.h,v 1.72 2004/05/13 23:32:50 mikpe Exp $
+ * Performance-Monitoring Counters driver
+ *
+ * Copyright (C) 1999-2004  Mikael Pettersson
+ */
+#ifndef _LINUX_PERFCTR_H
+#define _LINUX_PERFCTR_H
+
+#ifdef CONFIG_PERFCTR	/* don't break archs without <asm/perfctr.h> */
+
+#include <asm/perfctr.h>
+
+struct perfctr_info {
+	unsigned int abi_version;
+	char driver_version[32];
+	unsigned int cpu_type;
+	unsigned int cpu_features;
+	unsigned int cpu_khz;
+	unsigned int tsc_to_cpu_mult;
+	unsigned int _reserved2;
+	unsigned int _reserved3;
+	unsigned int _reserved4;
+};
+
+struct perfctr_cpu_mask {
+	unsigned int nrwords;
+	unsigned int mask[1];	/* actually 'nrwords' */
+};
+
+/* abi_version values: Lower 16 bits contain the CPU data version, upper
+   16 bits contain the API version. Each half has a major version in its
+   upper 8 bits, and a minor version in its lower 8 bits. */
+#define PERFCTR_API_VERSION	0x0501	/* 5.1 */
+#define PERFCTR_ABI_VERSION	((PERFCTR_API_VERSION<<16)|PERFCTR_CPU_VERSION)
+
+/* cpu_type values */
+#define PERFCTR_X86_GENERIC	0	/* any x86 with rdtsc */
+#define PERFCTR_X86_INTEL_P5	1	/* no rdpmc */
+#define PERFCTR_X86_INTEL_P5MMX	2
+#define PERFCTR_X86_INTEL_P6	3
+#define PERFCTR_X86_INTEL_PII	4
+#define PERFCTR_X86_INTEL_PIII	5
+#define PERFCTR_X86_CYRIX_MII	6
+#define PERFCTR_X86_WINCHIP_C6	7	/* no rdtsc */
+#define PERFCTR_X86_WINCHIP_2	8	/* no rdtsc */
+#define PERFCTR_X86_AMD_K7	9
+#define PERFCTR_X86_VIA_C3	10	/* no pmc0 */
+#define PERFCTR_X86_INTEL_P4	11	/* model 0 and 1 */
+#define PERFCTR_X86_INTEL_P4M2	12	/* model 2 */
+#define PERFCTR_X86_AMD_K8	13
+#define PERFCTR_X86_INTEL_PENTM	14	/* Pentium M */
+#define PERFCTR_X86_AMD_K8C	15	/* Revision C */
+#define PERFCTR_X86_INTEL_P4M3	16	/* model 3 and above */
+
+/* cpu_features flag bits */
+#define PERFCTR_FEATURE_RDPMC	0x01
+#define PERFCTR_FEATURE_RDTSC	0x02
+#define PERFCTR_FEATURE_PCINT	0x04
+
+/* user's view of mmap:ed virtual perfctr */
+struct vperfctr_state {
+	struct perfctr_cpu_state cpu_state;
+};
+
+/* parameter in VPERFCTR_CONTROL command */
+struct vperfctr_control {
+	int si_signo;
+	struct perfctr_cpu_control cpu_control;
+	unsigned int preserve;
+	unsigned int _reserved1;
+	unsigned int _reserved2;
+	unsigned int _reserved3;
+	unsigned int _reserved4;
+};
+
+/* parameter in GPERFCTR_CONTROL command */
+struct gperfctr_cpu_control {
+	unsigned int cpu;
+	struct perfctr_cpu_control cpu_control;
+	unsigned int _reserved1;
+	unsigned int _reserved2;
+	unsigned int _reserved3;
+	unsigned int _reserved4;
+};
+
+/* returned by GPERFCTR_READ command */
+struct gperfctr_cpu_state {
+	unsigned int cpu;
+	struct perfctr_cpu_control cpu_control;
+	struct perfctr_sum_ctrs sum;
+	unsigned int _reserved1;
+	unsigned int _reserved2;
+	unsigned int _reserved3;
+	unsigned int _reserved4;
+};
+
+/* buffer for encodings of most of the above structs */
+struct perfctr_struct_buf {
+	unsigned int rdsize;
+	unsigned int wrsize;
+	unsigned int buffer[1]; /* actually 'max(rdsize,wrsize)' */
+};
+
+/*
+ * int sys_perfctr(unsigned int cmd, int whom, unsigned long arg);
+ *
+ *	cmd				whom, arg
+ */
+#define PERFCTR_ABI		0  /*	0, unsigned int* */
+#define PERFCTR_INFO		1  /*	0, struct perfctr_struct_buf* */
+#define PERFCTR_CPUS		2  /*	0, struct perfctr_cpu_mask* */
+#define PERFCTR_CPUS_FORBIDDEN	3  /*	0, struct perfctr_cpu_mask* */
+#define VPERFCTR_CREAT		6  /*	tid, NULL */
+#define VPERFCTR_OPEN		7  /*	tid, NULL */
+
+#define VPERFCTR_READ_SUM	8  /*	fd, struct perfctr_struct_buf* */
+#define VPERFCTR_UNLINK		9  /*	fd, NULL */
+#define VPERFCTR_CONTROL	10 /*	fd, struct perfctr_struct_buf* */
+#define VPERFCTR_IRESUME	11 /*	fd, NULL */
+#define VPERFCTR_READ_CONTROL	12 /*	fd, struct perfctr_struct_buf* */
+
+#define GPERFCTR_CONTROL	16 /*	0, struct perfctr_struct_buf* */
+#define GPERFCTR_READ		17 /*	0, struct perfctr_struct_buf* */
+#define GPERFCTR_STOP		18 /*	0, NULL */
+#define GPERFCTR_START		19 /*	0, unsigned int */
+
+#endif	/* CONFIG_PERFCTR */
+
+#ifdef __KERNEL__
+
+extern struct perfctr_info perfctr_info;
+
+#ifdef CONFIG_PERFCTR_VIRTUAL
+
+/*
+ * Virtual per-process performance-monitoring counters.
+ */
+struct vperfctr;	/* opaque */
+
+/* process management operations */
+extern struct vperfctr *__vperfctr_copy(struct vperfctr*);
+extern void __vperfctr_exit(struct vperfctr*);
+extern void __vperfctr_suspend(struct vperfctr*);
+extern void __vperfctr_resume(struct vperfctr*);
+extern void __vperfctr_sample(struct vperfctr*);
+extern void __vperfctr_set_cpus_allowed(struct task_struct*, struct vperfctr*, cpumask_t);
+
+static inline void perfctr_copy_thread(struct thread_struct *thread)
+{
+	thread->perfctr = NULL;
+}
+
+static inline void perfctr_exit_thread(struct thread_struct *thread)
+{
+	struct vperfctr *perfctr;
+	perfctr = thread->perfctr;
+	if( perfctr )
+		__vperfctr_exit(perfctr);
+}
+
+static inline void perfctr_suspend_thread(struct thread_struct *prev)
+{
+	struct vperfctr *perfctr;
+	perfctr = prev->perfctr;
+	if( perfctr )
+		__vperfctr_suspend(perfctr);
+}
+
+static inline void perfctr_resume_thread(struct thread_struct *next)
+{
+	struct vperfctr *perfctr;
+	perfctr = next->perfctr;
+	if( perfctr )
+		__vperfctr_resume(perfctr);
+}
+
+static inline void perfctr_sample_thread(struct thread_struct *thread)
+{
+	struct vperfctr *perfctr;
+	perfctr = thread->perfctr;
+	if( perfctr )
+		__vperfctr_sample(perfctr);
+}
+
+static inline void perfctr_set_cpus_allowed(struct task_struct *p, cpumask_t new_mask)
+{
+#if PERFCTR_CPUS_FORBIDDEN_MASK_NEEDED
+	struct vperfctr *perfctr;
+
+	task_lock(p);
+	perfctr = p->thread.perfctr;
+	if( perfctr )
+		__vperfctr_set_cpus_allowed(p, perfctr, new_mask);
+	task_unlock(p);
+#endif
+}
+
+#else	/* !CONFIG_PERFCTR_VIRTUAL */
+
+static inline void perfctr_copy_thread(struct thread_struct *t) { }
+static inline void perfctr_exit_thread(struct thread_struct *t) { }
+static inline void perfctr_suspend_thread(struct thread_struct *t) { }
+static inline void perfctr_resume_thread(struct thread_struct *t) { }
+static inline void perfctr_sample_thread(struct thread_struct *t) { }
+static inline void perfctr_set_cpus_allowed(struct task_struct *p, cpumask_t m) { }
+
+#endif	/* CONFIG_PERFCTR_VIRTUAL */
+
+#endif	/* __KERNEL__ */
+
+#endif	/* _LINUX_PERFCTR_H */
diff -ruN linux-2.6.6-mm2/kernel/sched.c linux-2.6.6-mm2.perfctr-2.7.2.core/kernel/sched.c
--- linux-2.6.6-mm2/kernel/sched.c	2004-05-14 14:02:13.000000000 +0200
+++ linux-2.6.6-mm2.perfctr-2.7.2.core/kernel/sched.c	2004-05-14 14:32:54.708042034 +0200
@@ -39,6 +39,7 @@
 #include <linux/rcupdate.h>
 #include <linux/cpu.h>
 #include <linux/percpu.h>
+#include <linux/perfctr.h>
 #include <linux/kthread.h>
 #include <linux/seq_file.h>
 #include <linux/times.h>
@@ -3463,6 +3464,8 @@
 	migration_req_t req;
 	runqueue_t *rq;
 
+	perfctr_set_cpus_allowed(p, new_mask);
+
 	rq = task_rq_lock(p, &flags);
 	if (any_online_cpu(new_mask) == NR_CPUS) {
 		ret = -EINVAL;
diff -ruN linux-2.6.6-mm2/kernel/sys.c linux-2.6.6-mm2.perfctr-2.7.2.core/kernel/sys.c
--- linux-2.6.6-mm2/kernel/sys.c	2004-05-14 14:02:13.000000000 +0200
+++ linux-2.6.6-mm2.perfctr-2.7.2.core/kernel/sys.c	2004-05-14 14:32:54.708042034 +0200
@@ -279,6 +279,7 @@
 cond_syscall(sys_pciconfig_read)
 cond_syscall(sys_pciconfig_write)
 cond_syscall(sys_pciconfig_iobase)
+cond_syscall(sys_perfctr)
 
 static int set_one_prio(struct task_struct *p, int niceval, int error)
 {
diff -ruN linux-2.6.6-mm2/kernel/timer.c linux-2.6.6-mm2.perfctr-2.7.2.core/kernel/timer.c
--- linux-2.6.6-mm2/kernel/timer.c	2004-05-14 14:02:13.000000000 +0200
+++ linux-2.6.6-mm2.perfctr-2.7.2.core/kernel/timer.c	2004-05-14 14:32:54.708042034 +0200
@@ -31,6 +31,7 @@
 #include <linux/time.h>
 #include <linux/jiffies.h>
 #include <linux/cpu.h>
+#include <linux/perfctr.h>
 
 #include <asm/uaccess.h>
 #include <asm/div64.h>
@@ -834,6 +835,7 @@
 	do_process_times(p, user, system);
 	do_it_virt(p, user);
 	do_it_prof(p);
+	perfctr_sample_thread(&p->thread);
 }	
 
 /*
