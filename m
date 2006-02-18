Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751847AbWBRA6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847AbWBRA6L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 19:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751834AbWBRA5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 19:57:55 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:58254 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S1751822AbWBRA5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 19:57:38 -0500
From: Roland Dreier <rolandd@cisco.com>
Subject: [PATCH 08/22] Generic ehca headers
Date: Fri, 17 Feb 2006 16:57:23 -0800
To: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       openib-general@openib.org
Cc: SCHICKHJ@de.ibm.com, RAISCH@de.ibm.com, HNGUYEN@de.ibm.com,
       MEDER@de.ibm.com
Message-Id: <20060218005723.13620.10389.stgit@localhost.localdomain>
In-Reply-To: <20060218005532.13620.79663.stgit@localhost.localdomain>
References: <20060218005532.13620.79663.stgit@localhost.localdomain>
X-OriginalArrivalTime: 18 Feb 2006 00:57:23.0593 (UTC) FILETIME=[4747D790:01C63426]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roland Dreier <rolandd@cisco.com>

The defines of TRUE and FALSE look rather useless.  Why are they needed?

What is struct ehca_cache for?  It doesn't seem to be used anywhere.

ehca_kv_to_g() looks completely horrible.  The whole idea of using
vmalloc()ed kernel memory to do DMA seems unacceptable to me.

It's usual to include all <linux/> headers before all <asm/> headers.
---

 drivers/infiniband/hw/ehca/ehca_flightrecorder.h |   74 ++++
 drivers/infiniband/hw/ehca/ehca_kernel.h         |  135 +++++++
 drivers/infiniband/hw/ehca/ehca_tools.h          |  431 ++++++++++++++++++++++
 3 files changed, 640 insertions(+), 0 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_flightrecorder.h b/drivers/infiniband/hw/ehca/ehca_flightrecorder.h
new file mode 100644
index 0000000..7c631ad
--- /dev/null
+++ b/drivers/infiniband/hw/ehca/ehca_flightrecorder.h
@@ -0,0 +1,74 @@
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *  flightrecorder macros
+ *
+ *  Authors: Christoph Raisch <raisch@de.ibm.com>
+ *
+ *  Copyright (c) 2005 IBM Corporation
+ *
+ *  All rights reserved.
+ *
+ *  This source code is distributed under a dual license of GPL v2.0 and OpenIB
+ *  BSD.
+ *
+ * OpenIB BSD License
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *
+ * Redistributions of source code must retain the above copyright notice, this
+ * list of conditions and the following disclaimer.
+ *
+ * Redistributions in binary form must reproduce the above copyright notice,
+ * this list of conditions and the following disclaimer in the documentation
+ * and/or other materials
+ * provided with the distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
+ * IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  $Id: ehca_flightrecorder.h,v 1.5 2006/02/06 10:17:34 schickhj Exp $
+ */
+/*****************************************************************************/
+#ifndef EHCA_FLIGHTRECORDER_H
+#define EHCA_FLIGHTRECORDER_H
+
+#define ED_EXTEND1(x,ar1...) \
+	unsigned long __EDEB_R2=(const unsigned long)x-0;ED_EXTEND2(ar1)
+#define ED_EXTEND2(x,ar1...) \
+	unsigned long __EDEB_R3=(const unsigned long)x-0;ED_EXTEND3(ar1)
+#define ED_EXTEND3(x,ar1...) \
+	unsigned long __EDEB_R4=(const unsigned long)x-0;ED_EXTEND4(ar1)
+#define ED_EXTEND4(x,ar1...)
+
+#define EHCA_FLIGHTRECORDER_SIZE 65536
+
+extern atomic_t ehca_flightrecorder_index;
+extern unsigned long ehca_flightrecorder[EHCA_FLIGHTRECORDER_SIZE];
+
+/* Not nice, but -O2 optimized */
+
+#define ED_FLIGHT_LOG(x,ar1...) {                                            \
+	u32 flight_offset = ((u32)					     \
+	atomic_add_return(4, &ehca_flightrecorder_index))		     \
+	% EHCA_FLIGHTRECORDER_SIZE;					     \
+	unsigned long *flight_trline = &ehca_flightrecorder[flight_offset];  \
+	unsigned long __EDEB_R1 = (unsigned long) x-0; ED_EXTEND1(ar1)	     \
+	flight_trline[0]=__EDEB_R1,flight_trline[1]=__EDEB_R2,		     \
+	flight_trline[2]=__EDEB_R3,flight_trline[3]=__EDEB_R4; }
+
+#define EHCA_FLIGHTRECORDER_BACKLOG 60
+
+void ehca_flight_to_printk(void);
+
+#endif
diff --git a/drivers/infiniband/hw/ehca/ehca_kernel.h b/drivers/infiniband/hw/ehca/ehca_kernel.h
new file mode 100644
index 0000000..f119149
--- /dev/null
+++ b/drivers/infiniband/hw/ehca/ehca_kernel.h
@@ -0,0 +1,135 @@
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *  generalized functions for code shared between kernel and userspace
+ *
+ *  Authors: Christoph Raisch <raisch@de.ibm.com>
+ *
+ *  Copyright (c) 2005 IBM Corporation
+ *
+ *  All rights reserved.
+ *
+ *  This source code is distributed under a dual license of GPL v2.0 and OpenIB
+ *  BSD.
+ *
+ * OpenIB BSD License
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *
+ * Redistributions of source code must retain the above copyright notice, this
+ * list of conditions and the following disclaimer.
+ *
+ * Redistributions in binary form must reproduce the above copyright notice,
+ * this list of conditions and the following disclaimer in the documentation
+ * and/or other materials
+ * provided with the distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
+ * IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  $Id: ehca_kernel.h,v 1.39 2006/02/06 11:45:10 schickhj Exp $
+ */
+
+#ifndef _EHCA_KERNEL_H_
+#define _EHCA_KERNEL_H_
+
+#define FALSE (1==0)
+#define TRUE (1==1)
+
+#define big_little_target 0	/* needed for simulation */
+#include <linux/version.h>
+
+#include <linux/types.h>
+#include "ehca_common.h"
+#include "ehca_kernel.h"
+
+/**
+ * Handle to be used for adress translation mechanisms, currently a placeholder.
+ */
+struct ehca_bridge_handle {
+	int handle;
+};
+
+inline static int ehca_adr_bad(void *adr)
+{
+	return (adr == 0);
+};
+
+#ifdef EHCA_USERDRIVER
+/* userspace replacement for kernel functions */
+#include "ehca_usermain.h"
+#else				/* USERDRIVER */
+/* kernel includes */
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/kernel.h>
+#include <linux/vmalloc.h>
+#include <linux/mm.h>
+#include <asm/current.h>
+#include <asm/io.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/sched.h>
+#include <linux/err.h>
+#include <linux/kthread.h>
+#include <linux/mman.h>
+#include <linux/delay.h>
+#include <asm/processor.h>
+#include <asm/ibmebus.h>
+#include <linux/pci.h>
+#include <linux/idr.h>
+#include <linux/rwsem.h>
+
+struct ehca_cache {
+	kmem_cache_t *cache;
+	int size;
+};
+
+#ifdef __powerpc64__
+#include <linux/spinlock.h>
+#include <asm/abs_addr.h>
+#include <asm/prom.h>
+#else
+#endif
+
+#include <ehca_tools.h>
+
+#include <asm/pgtable.h>
+
+
+/**
+ * ehca_kv_to_g - Converts a kernel virtual address to visible addresses
+ * (i.e. a physical/absolute address).
+ */
+inline static u64 ehca_kv_to_g(void *adr)
+{
+	u64 raddr;
+#ifndef CONFIG_PPC64
+	raddr = virt_to_phys((u64)adr);
+#else
+	/* we need to find not only the physical address
+	 * but the absolute to account for memory segmentation */
+	raddr = virt_to_abs((u64)adr);
+#endif
+	if (((u64)adr & VMALLOC_START) == VMALLOC_START) {
+		raddr = phys_to_abs((page_to_pfn(vmalloc_to_page(adr)) <<
+				     PAGE_SHIFT));
+	}
+	return (raddr);
+}
+
+#endif /* USERDRIVER */
+#include <linux/types.h>
+
+
+#endif /* _EHCA_KERNEL_H_ */
diff --git a/drivers/infiniband/hw/ehca/ehca_tools.h b/drivers/infiniband/hw/ehca/ehca_tools.h
new file mode 100644
index 0000000..915a0b7
--- /dev/null
+++ b/drivers/infiniband/hw/ehca/ehca_tools.h
@@ -0,0 +1,431 @@
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *  auxiliary functions
+ *
+ *  Authors: Christoph Raisch <raisch@de.ibm.com>
+ *           Khadija Souissi <souissik@de.ibm.com>
+ *           Waleri Fomin <fomin@de.ibm.com>
+ *           Heiko J Schick <schickhj@de.ibm.com>
+ *
+ *  Copyright (c) 2005 IBM Corporation
+ *
+ *  This source code is distributed under a dual license of GPL v2.0 and OpenIB
+ *  BSD.
+ *
+ * OpenIB BSD License
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *
+ * Redistributions of source code must retain the above copyright notice, this
+ * list of conditions and the following disclaimer.
+ *
+ * Redistributions in binary form must reproduce the above copyright notice,
+ * this list of conditions and the following disclaimer in the documentation
+ * and/or other materials
+ * provided with the distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
+ * IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  $Id: ehca_tools.h,v 1.43 2006/02/06 10:17:34 schickhj Exp $
+ */
+
+
+#ifndef EHCA_TOOLS_H
+#define EHCA_TOOLS_H
+
+#include "ehca_flightrecorder.h"
+#include "ehca_common.h"
+
+#define flightlog_value() mftb()
+
+#ifndef sizeofmember
+#define sizeofmember(TYPE, MEMBER) (sizeof( ((TYPE *)0)->MEMBER))
+#endif
+
+#define EHCA_EDEB_TRACE_MASK_SIZE 32
+extern u8 ehca_edeb_mask[EHCA_EDEB_TRACE_MASK_SIZE];
+#define EDEB_ID_TO_U32(str4) (str4[3] | (str4[2] << 8) | (str4[1] << 16) | \
+			      (str4[0] << 24))
+
+inline static u64 ehca_edeb_filter(const u32 level,
+				   const u32 id, const u32 line)
+{
+	u64 ret = 0;
+	u32 filenr = 0;
+	u32 filter_level = 9;
+	u32 dynamic_level = 0;
+	/* This is code written for the gcc -O2 optimizer which should colapse
+	 * to two single ints filter_level is the first level kicked out by
+	 * compiler means trace everythin below 6. */
+	if (id == EDEB_ID_TO_U32("ehav")) {
+		filenr = 0x01;
+		filter_level = 8;
+	}
+	if (id == EDEB_ID_TO_U32("clas")) {
+		filenr = 0x02;
+		filter_level = 8;
+	}
+	if (id == EDEB_ID_TO_U32("cqeq")) {
+		filenr = 0x03;
+		filter_level = 8;
+	}
+	if (id == EDEB_ID_TO_U32("shca")) {
+		filenr = 0x05;
+		filter_level = 8;
+	}
+	if (id == EDEB_ID_TO_U32("eirq")) {
+		filenr = 0x06;
+		filter_level = 8;
+	}
+	if (id == EDEB_ID_TO_U32("lMad")) {
+		filenr = 0x07;
+		filter_level = 8;
+	}
+	if (id == EDEB_ID_TO_U32("mcas")) {
+		filenr = 0x08;
+		filter_level = 8;
+	}
+	if (id == EDEB_ID_TO_U32("mrmw")) {
+		filenr = 0x09;
+		filter_level = 8;
+	}
+	if (id == EDEB_ID_TO_U32("vpd ")) {
+		filenr = 0x0a;
+		filter_level = 8;
+	}
+	if (id == EDEB_ID_TO_U32("e_qp")) {
+		filenr = 0x0b;
+		filter_level = 8;
+	}
+	if (id == EDEB_ID_TO_U32("uqes")) {
+		filenr = 0x0c;
+		filter_level = 8;
+	}
+	if (id == EDEB_ID_TO_U32("PHYP")) {
+		filenr = 0x0d;
+		filter_level = 8;
+	}
+	if (id == EDEB_ID_TO_U32("snse")) {
+		filenr = 0x0e;
+		filter_level = 8;
+	}
+	if (id == EDEB_ID_TO_U32("iptz")) {
+		filenr = 0x0f;
+		filter_level = 8;
+	}
+	if (id == EDEB_ID_TO_U32("spta")) {
+		filenr = 0x10;
+		filter_level = 8;
+	}
+	if (id == EDEB_ID_TO_U32("simp")) {
+		filenr = 0x11;
+		filter_level = 8;
+	}
+	if (id == EDEB_ID_TO_U32("reqs")) {
+		filenr = 0x12;
+		filter_level = 8;
+	}
+
+	if ((filenr - 1) > sizeof(ehca_edeb_mask)) {
+		filenr = 0;
+	}
+
+	if (filenr == 0) {
+		filter_level = 9;
+	}			/* default */
+	ret = filenr * 0x10000 + line;
+	if (filter_level <= level) {
+		return (ret | 0x100000000); /* this is the flag to not trace */
+	}
+	dynamic_level = ehca_edeb_mask[filenr];
+	if (likely(dynamic_level <= level)) {
+		ret = ret | 0x100000000;
+	};
+	return ret;
+}
+
+#ifdef EHCA_USE_HCALL_KERNEL
+#ifdef CONFIG_PPC_PSERIES
+
+#include <asm/paca.h>
+
+/**
+ * IS_EDEB_ON - Checks if debug is on for the given level.
+ */
+#define IS_EDEB_ON(level) \
+    ((ehca_edeb_filter(level, EDEB_ID_TO_U32(DEB_PREFIX), __LINE__) & 0x100000000)==0)
+
+#define EDEB_P_GENERIC(level,idstring,format,args...) \
+do { \
+	u64 ehca_edeb_filterresult =					\
+		ehca_edeb_filter(level, EDEB_ID_TO_U32(DEB_PREFIX), __LINE__);\
+	if ((ehca_edeb_filterresult & 0x100000000) == 0)		\
+		printk("PU%04x %08x:%s " idstring " "format "\n",	\
+		       get_paca()->paca_index, (u32)(ehca_edeb_filterresult), \
+		       __func__,  ##args);				\
+	if (unlikely(ehca_edeb_mask[0x1e]!=0))				\
+		ED_FLIGHT_LOG((((u64)(get_paca()->paca_index)<< 32) |	\
+			       ((u64)(ehca_edeb_filterresult & 0xffffffff)) << 40 | \
+			       (flightlog_value()&0xffffffff)), args);	\
+} while (1==0)
+
+#elif CONFIG_ARCH_S390
+
+#include <asm/smp.h>
+#define EDEB_P_GENERIC(level,idstring,format,args...) \
+do { \
+	u64 ehca_edeb_filterresult =					\
+		ehca_edeb_filter(level, EDEB_ID_TO_U32(DEB_PREFIX), __LINE__);\
+	if ((ehca_edeb_filterresult & 0x100000000) == 0)		\
+		printk("PU%04x %08x:%s " idstring " "format "\n",	\
+			smp_processor_id(), (u32)(ehca_edeb_filterresult), \
+			__func__,  ##args); \
+} while (1==0)
+
+#elif REAL_HCALL
+
+#define EDEB_P_GENERIC(level,idstring,format,args...) \
+do { \
+	u64 ehca_edeb_filterresult =					\
+		ehca_edeb_filter(level, EDEB_ID_TO_U32(DEB_PREFIX), __LINE__); \
+	if ((ehca_edeb_filterresult & 0x100000000) == 0)		\
+		printk("%08x:%s " idstring " "format "\n",	\
+			(u32)(ehca_edeb_filterresult), \
+			__func__,  ##args); \
+} while (1==0)
+
+#endif
+#else
+
+#define IS_EDEB_ON(level) (1)
+
+#define EDEB_P_GENERIC(level,idstring,format,args...) \
+do { \
+	printk("%s " idstring " "format "\n",	\
+	       __func__,  ##args);		\
+} while (1==0)
+
+#endif
+
+/**
+ * EDEB - Trace output macro.
+ * @level tracelevel
+ * @format optional format string, use "" if not desired
+ * @args printf like arguments for trace, use %Lx for u64, %x for u32
+ *       %p for pointer
+ */
+#define EDEB(level,format,args...) \
+	EDEB_P_GENERIC(level,"",format,##args)
+#define EDEB_ERR(level,format,args...) \
+	EDEB_P_GENERIC(level,"HCAD_ERROR ",format,##args)
+#define EDEB_EN(level,format,args...) \
+	EDEB_P_GENERIC(level,">>>",format,##args)
+#define EDEB_EX(level,format,args...) \
+	EDEB_P_GENERIC(level,"<<<",format,##args)
+
+/**
+ * EDEB macro to dump a memory block, whose length is n*8 bytes.
+ * Each line has the following layout:
+ * <format string> adr=X ofs=Y <8 bytes hex> <8 bytes hex>
+ */
+
+#define EDEB_DMP(level,adr,len,format,args...) \
+	do {				       \
+		unsigned int x;			      \
+		unsigned int l = (unsigned int)(len); \
+		unsigned char *deb = (unsigned char*)(adr);	\
+		for (x = 0; x < l; x += 16) { \
+		        EDEB(level, format " adr=%p ofs=%04x %016lx %016lx", \
+			     ##args, deb, x, *((u64 *)&deb[0]), *((u64 *)&deb[8])); \
+			deb += 16; \
+		} \
+	} while (0)
+
+#define LOCATION __FILE__  " "
+
+/* define a bitmask, little endian version */
+#define EHCA_BMASK(pos,length) (((pos)<<16)+(length))
+/* define a bitmask, the ibm way... */
+#define EHCA_BMASK_IBM(from,to) (((63-to)<<16)+((to)-(from)+1))
+/* internal function, don't use */
+#define EHCA_BMASK_SHIFTPOS(mask) (((mask)>>16)&0xffff)
+/* internal function, don't use */
+#define EHCA_BMASK_MASK(mask) (0xffffffffffffffffULL >> ((64-(mask))&0xffff))
+/* return value shifted and masked by mask\n
+ * variable|=HCA_BMASK_SET(MY_MASK,0x4711) ORs the bits in variable\n
+ * variable&=~HCA_BMASK_SET(MY_MASK,-1) clears the bits from the mask
+ * in variable
+ */
+#define EHCA_BMASK_SET(mask,value) \
+	((EHCA_BMASK_MASK(mask) & ((u64)(value)))<<EHCA_BMASK_SHIFTPOS(mask))
+/* extract a parameter from value by mask\n
+ * param=EHCA_BMASK_GET(MY_MASK,value)
+ */
+#define EHCA_BMASK_GET(mask,value) \
+	( EHCA_BMASK_MASK(mask)& (((u64)(value))>>EHCA_BMASK_SHIFTPOS(mask)))
+
+/**
+ * ehca_fixme - Dummy function which will be removed in production code
+ * to find all todos by compiler.
+ */
+void ehca_fixme(void);
+
+extern void exit(int);
+inline static void ehca_catastrophic(char *str)
+{
+#ifndef  EHCA_USERDRIVER
+	printk(KERN_ERR "HCAD_ERROR %s\n", str);
+	ehca_flight_to_printk();
+#else
+	exit(1);
+#endif
+}
+
+#define PARANOIA_MODE
+#ifdef PARANOIA_MODE
+
+#define EHCA_CHECK_ADR_P(adr)					\
+	if (unlikely(adr==0)) {					\
+		EDEB_ERR(4, "adr=%p check failed line %i", adr,	\
+			 __LINE__);				\
+		return ERR_PTR(-EFAULT); }
+
+#define EHCA_CHECK_ADR(adr)					\
+	if (unlikely(adr==0)) {					\
+		EDEB_ERR(4, "adr=%p check failed line %i", adr,	\
+			 __LINE__);				\
+		return -EFAULT; }
+
+#define EHCA_CHECK_DEVICE_P(device)				\
+	if (unlikely(device==0)) {				\
+		EDEB_ERR(4, "device=%p check failed", device);	\
+		return ERR_PTR(-EFAULT); }
+
+#define EHCA_CHECK_DEVICE(device)				\
+	if (unlikely(device==0)) {				\
+		EDEB_ERR(4, "device=%p check failed", device);	\
+		return -EFAULT; }
+
+#define EHCA_CHECK_PD(pd)				\
+	if (unlikely(pd==0)) {				\
+		EDEB_ERR(4, "pd=%p check failed", pd);	\
+		return -EFAULT; }
+
+#define EHCA_CHECK_PD_P(pd)				\
+	if (unlikely(pd==0)) {				\
+		EDEB_ERR(4, "pd=%p check failed", pd);	\
+		return ERR_PTR(-EFAULT); }
+
+#define EHCA_CHECK_AV(av)				\
+	if (unlikely(av==0)) {				\
+		EDEB_ERR(4, "av=%p check failed", av);	\
+		return -EFAULT; }
+
+#define EHCA_CHECK_AV_P(av)				\
+	if (unlikely(av==0)) {				\
+		EDEB_ERR(4, "av=%p check failed", av);	\
+		return ERR_PTR(-EFAULT); }
+
+#define EHCA_CHECK_CQ(cq)				\
+	if (unlikely(cq==0)) {				\
+		EDEB_ERR(4, "cq=%p check failed", cq);	\
+		return -EFAULT; }
+
+#define EHCA_CHECK_CQ_P(cq)				\
+	if (unlikely(cq==0)) {				\
+		EDEB_ERR(4, "cq=%p check failed", cq);	\
+		return ERR_PTR(-EFAULT); }
+
+#define EHCA_CHECK_EQ(eq)				\
+	if (unlikely(eq==0)) {				\
+		EDEB_ERR(4, "eq=%p check failed", eq);	\
+		return -EFAULT; }
+
+#define EHCA_CHECK_EQ_P(eq)				\
+	if (unlikely(eq==0)) {				\
+		EDEB_ERR(4, "eq=%p check failed", eq);	\
+		return ERR_PTR(-EFAULT); }
+
+#define EHCA_CHECK_QP(qp)				\
+	if (unlikely(qp==0)) {				\
+		EDEB_ERR(4, "qp=%p check failed", qp);	\
+		return -EFAULT; }
+
+#define EHCA_CHECK_QP_P(qp)				\
+	if (unlikely(qp==0)) {				\
+		EDEB_ERR(4, "qp=%p check failed", qp);	\
+		return ERR_PTR(-EFAULT); }
+
+#define EHCA_CHECK_MR(mr)				\
+	if (unlikely(mr==0)) {				\
+		EDEB_ERR(4, "mr=%p check failed", mr);	\
+		return -EFAULT; }
+
+#define EHCA_CHECK_MR_P(mr)				\
+	if (unlikely(mr==0)) {				\
+		EDEB_ERR(4, "mr=%p check failed", mr);	\
+		return ERR_PTR(-EFAULT); }
+
+#define EHCA_CHECK_MW(mw)				\
+	if (unlikely(mw==0)) {				\
+		EDEB_ERR(4, "mw=%p check failed", mw);	\
+		return -EFAULT; }
+
+#define EHCA_CHECK_MW_P(mw)				\
+	if (unlikely(mw==0)) {				\
+		EDEB_ERR(4, "mw=%p check failed", mw);	\
+		return ERR_PTR(-EFAULT); }
+
+#define EHCA_CHECK_FMR(fmr)					\
+	if (unlikely(fmr==0)) {					\
+		EDEB_ERR(4, "fmr=%p check failed", fmr);	\
+		return -EFAULT; }
+
+#define EHCA_CHECK_FMR_P(fmr)					\
+	if (unlikely(fmr==0)) {					\
+		EDEB_ERR(4, "fmr=%p check failed", fmr);	\
+		return ERR_PTR(-EFAULT); }
+
+#define EHCA_REGISTER_PD(device,pd)
+#define EHCA_REGISTER_AV(pd,av)
+#define EHCA_DEREGISTER_PD(PD)
+#define EHCA_DEREGISTER_AV(av)
+#else
+#define EHCA_CHECK_DEVICE_P(device)
+
+#define EHCA_CHECK_PD(pd)
+#define EHCA_REGISTER_PD(device,pd)
+#define EHCA_DEREGISTER_PD(PD)
+#endif
+
+/**
+ * ehca2ib_return_code - Returns ib return code corresponding to the given
+ * ehca return code.
+ */
+static inline int ehca2ib_return_code(u64 ehca_rc)
+{
+	switch (ehca_rc) {
+	case H_Success:
+		return 0;
+	case H_Busy:
+		return -EBUSY;
+	case H_NoMem:
+		return -ENOMEM;
+	default:
+		return -EINVAL;
+	}
+}
+
+#endif /* EHCA_TOOLS_H */
