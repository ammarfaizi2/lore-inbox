Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262648AbUKRGzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262648AbUKRGzn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 01:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262646AbUKRGzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 01:55:43 -0500
Received: from 209-128-68-124.bayarea.net ([209.128.68.124]:36487 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262648AbUKRGwy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 01:52:54 -0500
Message-ID: <419C46C7.4080206@zytor.com>
Date: Wed, 17 Nov 2004 22:52:55 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: PATCH: Altivec support for RAID-6
Content-Type: multipart/mixed;
 boundary="------------010208060405060601040702"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010208060405060601040702
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds Altivec support for RAID-6, if appropriately configured 
on the ppc or ppc64 architectures.  Note that it changes the compile 
flags for ppc64 in order to handle -maltivec correctly; this change was 
vetted on the ppc64 mailing list and OK'd by paulus.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

--------------010208060405060601040702
Content-Type: text/x-patch;
 name="raid6altivec.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="raid6altivec.diff"

Index: raid6/arch/ppc64/Makefile
===================================================================
RCS file: /home/hpa/kernel/bkcvs/linux-2.5/arch/ppc64/Makefile,v
retrieving revision 1.42
diff -u -r1.42 Makefile
--- raid6/arch/ppc64/Makefile	26 Oct 2004 14:53:34 -0000	1.42
+++ raid6/arch/ppc64/Makefile	18 Nov 2004 06:01:37 -0000
@@ -35,7 +35,11 @@
 CFLAGS		+= -msoft-float -pipe -mminimal-toc -mtraceback=none
 
 ifeq ($(CONFIG_POWER4_ONLY),y)
+ifeq ($(CONFIG_ALTIVEC),y)
+	CFLAGS += $(call cc-option,-mcpu=970)
+else
 	CFLAGS += $(call cc-option,-mcpu=power4)
+endif
 else
 	CFLAGS += $(call cc-option,-mtune=power4)
 endif
Index: raid6/drivers/md/Makefile
===================================================================
RCS file: /home/hpa/kernel/bkcvs/linux-2.5/drivers/md/Makefile,v
retrieving revision 1.23
diff -u -r1.23 Makefile
--- raid6/drivers/md/Makefile	11 Nov 2004 21:49:10 -0000	1.23
+++ raid6/drivers/md/Makefile	18 Nov 2004 06:01:38 -0000
@@ -9,6 +9,8 @@
 raid6-objs	:= raid6main.o raid6algos.o raid6recov.o raid6tables.o \
 		   raid6int1.o raid6int2.o raid6int4.o \
 		   raid6int8.o raid6int16.o raid6int32.o \
+		   raid6altivec1.o raid6altivec2.o raid6altivec4.o \
+		   raid6altivec8.o \
 		   raid6mmx.o raid6sse1.o raid6sse2.o
 hostprogs-y	:= mktables
 
@@ -36,6 +38,10 @@
       cmd_unroll = $(PERL) $(srctree)/$(src)/unroll.pl $(UNROLL) \
                    < $< > $@ || ( rm -f $@ && exit 1 )
 
+ifeq ($(CONFIG_ALTIVEC),y)
+altivec_flags := -maltivec -mabi=altivec
+endif
+
 targets += raid6int1.c
 $(obj)/raid6int1.c:   UNROLL := 1
 $(obj)/raid6int1.c:   $(src)/raid6int.uc $(src)/unroll.pl FORCE
@@ -66,6 +72,30 @@
 $(obj)/raid6int32.c:  $(src)/raid6int.uc $(src)/unroll.pl FORCE
 	$(call if_changed,unroll)
 
+CFLAGS_raid6altivec1.o += $(altivec_flags)
+targets += raid6altivec1.c
+$(obj)/raid6altivec1.c:   UNROLL := 1
+$(obj)/raid6altivec1.c:   $(src)/raid6altivec.uc $(src)/unroll.pl FORCE
+	$(call if_changed,unroll)
+
+CFLAGS_raid6altivec2.o += $(altivec_flags)
+targets += raid6altivec2.c
+$(obj)/raid6altivec2.c:   UNROLL := 2
+$(obj)/raid6altivec2.c:   $(src)/raid6altivec.uc $(src)/unroll.pl FORCE
+	$(call if_changed,unroll)
+
+CFLAGS_raid6altivec4.o += $(altivec_flags)
+targets += raid6altivec4.c
+$(obj)/raid6altivec4.c:   UNROLL := 4
+$(obj)/raid6altivec4.c:   $(src)/raid6altivec.uc $(src)/unroll.pl FORCE
+	$(call if_changed,unroll)
+
+CFLAGS_raid6altivec8.o += $(altivec_flags)
+targets += raid6altivec8.c
+$(obj)/raid6altivec8.c:   UNROLL := 8
+$(obj)/raid6altivec8.c:   $(src)/raid6altivec.uc $(src)/unroll.pl FORCE
+	$(call if_changed,unroll)
+
 quiet_cmd_mktable = TABLE   $@
       cmd_mktable = $(obj)/mktables > $@ || ( rm -f $@ && exit 1 )
 
Index: raid6/drivers/md/raid6algos.c
===================================================================
RCS file: /home/hpa/kernel/bkcvs/linux-2.5/drivers/md/raid6algos.c,v
retrieving revision 1.4
diff -u -r1.4 raid6algos.c
--- raid6/drivers/md/raid6algos.c	23 Jan 2004 16:04:36 -0000	1.4
+++ raid6/drivers/md/raid6algos.c	18 Nov 2004 06:01:38 -0000
@@ -37,6 +37,10 @@
 extern const struct raid6_calls raid6_sse2x1;
 extern const struct raid6_calls raid6_sse2x2;
 extern const struct raid6_calls raid6_sse2x4;
+extern const struct raid6_calls raid6_altivec1;
+extern const struct raid6_calls raid6_altivec2;
+extern const struct raid6_calls raid6_altivec4;
+extern const struct raid6_calls raid6_altivec8;
 
 const struct raid6_calls * const raid6_algos[] = {
 	&raid6_intx1,
@@ -60,6 +64,12 @@
 	&raid6_sse2x2,
 	&raid6_sse2x4,
 #endif
+#ifdef CONFIG_ALTIVEC
+	&raid6_altivec1,
+	&raid6_altivec2,
+	&raid6_altivec4,
+	&raid6_altivec8,
+#endif
 	NULL
 };
 
Index: raid6/drivers/md/raid6altivec.uc
===================================================================
RCS file: raid6/drivers/md/raid6altivec.uc
diff -N raid6/drivers/md/raid6altivec.uc
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ raid6/drivers/md/raid6altivec.uc	18 Nov 2004 06:01:38 -0000
@@ -0,0 +1,122 @@
+/* -*- linux-c -*- ------------------------------------------------------- *
+ *
+ *   Copyright 2002-2004 H. Peter Anvin - All Rights Reserved
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation, Inc., 53 Temple Place Ste 330,
+ *   Bostom MA 02111-1307, USA; either version 2 of the License, or
+ *   (at your option) any later version; incorporated herein by reference.
+ *
+ * ----------------------------------------------------------------------- */
+
+/*
+ * raid6altivec$#.c
+ *
+ * $#-way unrolled portable integer math RAID-6 instruction set
+ *
+ * This file is postprocessed using unroll.pl
+ *
+ * <benh> hpa: in process,
+ * you can just "steal" the vec unit with enable_kernel_altivec() (but
+ * bracked this with preempt_disable/enable or in a lock)
+ */
+
+#include "raid6.h"
+
+#ifdef CONFIG_ALTIVEC
+
+#include <altivec.h>
+#include <asm/system.h>
+#include <asm/cputable.h>
+
+/*
+ * This is the C data type to use
+ */
+
+typedef vector unsigned char unative_t;
+
+#define NBYTES(x) ((vector unsigned char) {x,x,x,x, x,x,x,x, x,x,x,x, x,x,x,x})
+#define NSIZE	sizeof(unative_t)
+
+/*
+ * The SHLBYTE() operation shifts each byte left by 1, *not*
+ * rolling over into the next byte
+ */
+static inline __attribute_const__ unative_t SHLBYTE(unative_t v)
+{
+	return vec_add(v,v);
+}
+
+/*
+ * The MASK() operation returns 0xFF in any byte for which the high
+ * bit is 1, 0x00 for any byte for which the high bit is 0.
+ */
+static inline __attribute_const__ unative_t MASK(unative_t v)
+{
+	unative_t zv = NBYTES(0);
+
+	/* vec_cmpgt returns a vector bool char; thus the need for the cast */
+	return (unative_t)vec_cmpgt(zv, v);
+}
+
+
+/* This is noinline to make damned sure that gcc doesn't move any of the
+   Altivec code around the enable/disable code */
+static void noinline
+raid6_altivec$#_gen_syndrome_real(int disks, size_t bytes, void **ptrs)
+{
+	u8 **dptr = (u8 **)ptrs;
+	u8 *p, *q;
+	int d, z, z0;
+
+	unative_t wd$$, wq$$, wp$$, w1$$, w2$$;
+	unative_t x1d = NBYTES(0x1d);
+
+	z0 = disks - 3;		/* Highest data disk */
+	p = dptr[z0+1];		/* XOR parity */
+	q = dptr[z0+2];		/* RS syndrome */
+
+	for ( d = 0 ; d < bytes ; d += NSIZE*$# ) {
+		wq$$ = wp$$ = *(unative_t *)&dptr[z0][d+$$*NSIZE];
+		for ( z = z0-1 ; z >= 0 ; z-- ) {
+			wd$$ = *(unative_t *)&dptr[z][d+$$*NSIZE];
+			wp$$ = vec_xor(wp$$, wd$$);
+			w2$$ = MASK(wq$$);
+			w1$$ = SHLBYTE(wq$$);
+			w2$$ = vec_and(w2$$, x1d);
+			w1$$ = vec_xor(w1$$, w2$$);
+			wq$$ = vec_xor(w1$$, wd$$);
+		}
+		*(unative_t *)&p[d+NSIZE*$$] = wp$$;
+		*(unative_t *)&q[d+NSIZE*$$] = wq$$;
+	}
+}
+
+static void raid6_altivec$#_gen_syndrome(int disks, size_t bytes, void **ptrs)
+{
+	preempt_disable();
+	enable_kernel_altivec();
+
+	raid6_altivec$#_gen_syndrome_real(disks, bytes, ptrs);
+	
+	preempt_enable();
+}
+
+int raid6_have_altivec(void);
+#if $# == 1
+int raid6_have_altivec(void)
+{
+	/* This assumes either all CPUs have Altivec or none does */
+	return cur_cpu_spec->cpu_features & CPU_FTR_ALTIVEC;
+}
+#endif
+
+const struct raid6_calls raid6_altivec$# = {
+	raid6_altivec$#_gen_syndrome,
+	raid6_have_altivec,
+	"altivecx$#",
+	0
+};
+
+#endif /* CONFIG_ALTIVEC */

--------------010208060405060601040702--
