Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751834AbWBRA6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834AbWBRA6N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 19:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbWBRA5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 19:57:50 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:35626 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S1751812AbWBRA5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 19:57:13 -0500
From: Roland Dreier <rolandd@cisco.com>
Subject: [PATCH 03/22] pHype specific stuff
Date: Fri, 17 Feb 2006 16:57:10 -0800
To: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       openib-general@openib.org
Cc: SCHICKHJ@de.ibm.com, RAISCH@de.ibm.com, HNGUYEN@de.ibm.com,
       MEDER@de.ibm.com
Message-Id: <20060218005709.13620.77409.stgit@localhost.localdomain>
In-Reply-To: <20060218005532.13620.79663.stgit@localhost.localdomain>
References: <20060218005532.13620.79663.stgit@localhost.localdomain>
X-OriginalArrivalTime: 18 Feb 2006 00:57:10.0734 (UTC) FILETIME=[3F9DB6E0:01C63426]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roland Dreier <rolandd@cisco.com>

It's not clear what the connection between hcp_phyp.c and hcp_phyp.h
really is -- they don't seem to very closely related.

Again, hcp_phyp.h has some rather large functions that belong in
a .c file and maybe shouldn't be inlined (although maybe the
generated assembly ends up being small because it's just
fiddling registers around).

For a change, hipz_galpa_load() and hipz_galpa_store() actually
look simple enough that they could probably become inline functions
in a header (and just kill hcp_phyp.c).  This would also make the
comments about them being inline in ehca_galpa.h true.

Is ehca_galpha.h needed at all, or can it be folded into another
file?  Why is its abstraction needed?
---

 drivers/infiniband/hw/ehca/ehca_galpa.h |   74 +++++++
 drivers/infiniband/hw/ehca/hcp_phyp.c   |   81 +++++++
 drivers/infiniband/hw/ehca/hcp_phyp.h   |  338 +++++++++++++++++++++++++++++++
 3 files changed, 493 insertions(+), 0 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_galpa.h b/drivers/infiniband/hw/ehca/ehca_galpa.h
new file mode 100644
index 0000000..d64115c
--- /dev/null
+++ b/drivers/infiniband/hw/ehca/ehca_galpa.h
@@ -0,0 +1,74 @@
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *  pSeries interface definitions
+ *
+ *  Authors: Waleri Fomin <fomin@de.ibm.com>
+ *           Christoph Raisch <raisch@de.ibm.com>
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
+ *  $Id: ehca_galpa.h,v 1.6 2006/02/06 10:17:34 schickhj Exp $
+ */
+
+#ifndef __EHCA_GALPA_H__
+#define __EHCA_GALPA_H__
+
+/* eHCA page (mapped into p-memory)
+    resource to access eHCA register pages in CPU address space
+*/
+struct h_galpa {
+	u64 fw_handle;
+	/* for pSeries this is a 64bit memory address where
+	   I/O memory is mapped into CPU address space (kv) */
+};
+
+/**
+   resource to access eHCA address space registers, all types
+*/
+struct h_galpas {
+	u32 pid;		/*PID of userspace galpa checking */
+	struct h_galpa user;	/* user space accessible resource,
+				   set to 0 if unused */
+	struct h_galpa kernel;	/* kernel space accessible resource,
+				   set to 0 if unused */
+};
+/** @brief store value at offset into galpa, will be inline function
+ */
+void hipz_galpa_store(struct h_galpa galpa, u32 offset, u64 value);
+
+/** @brief return value from offset in galpa, will be inline function
+ */
+u64 hipz_galpa_load(struct h_galpa galpa, u32 offset);
+
+#endif				/* __EHCA_GALPA_H__ */
diff --git a/drivers/infiniband/hw/ehca/hcp_phyp.c b/drivers/infiniband/hw/ehca/hcp_phyp.c
new file mode 100644
index 0000000..129e61b
--- /dev/null
+++ b/drivers/infiniband/hw/ehca/hcp_phyp.c
@@ -0,0 +1,81 @@
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *   load store abstraction for ehca register access
+ *
+ *  Authors:  Christoph Raisch <raisch@de.ibm.com>
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
+ *  $Id: hcp_phyp.c,v 1.10 2006/02/06 10:17:34 schickhj Exp $
+ */
+
+
+#define DEB_PREFIX "PHYP"
+
+#ifdef __KERNEL__
+#include "ehca_kernel.h"
+#include "hipz_hw.h"
+/* #include "hipz_structs.h" */
+/* TODO: still necessary */
+#include "ehca_classes.h"
+#else				/* !__KERNEL__ */
+#include "ehca_utools.h"
+#include "ehca_galpa.h"
+#endif
+
+#ifndef EHCA_USERDRIVER		/* TODO: is this correct */
+
+u64 hipz_galpa_load(struct h_galpa galpa, u32 offset)
+{
+	u64 addr = galpa.fw_handle + offset;
+	u64 out;
+	EDEB_EN(7, "addr=%lx offset=%x ", addr, offset);
+	out = *(u64 *) addr;
+	EDEB_EX(7, "addr=%lx value=%lx", addr, out);
+	return out;
+};
+
+void hipz_galpa_store(struct h_galpa galpa, u32 offset, u64 value)
+{
+	u64 addr = galpa.fw_handle + offset;
+	EDEB(7, "addr=%lx offset=%x value=%lx", addr,
+	     offset, value);
+	*(u64 *) addr = value;
+#ifdef EHCA_USE_HCALL
+	/* hipz_galpa_load(galpa, offset); */
+	/* synchronize explicitly */
+#endif
+};
+
+#endif				/* EHCA_USERDRIVER */
diff --git a/drivers/infiniband/hw/ehca/hcp_phyp.h b/drivers/infiniband/hw/ehca/hcp_phyp.h
new file mode 100644
index 0000000..c82fb4b
--- /dev/null
+++ b/drivers/infiniband/hw/ehca/hcp_phyp.h
@@ -0,0 +1,338 @@
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *  Firmware calls
+ *
+ *  Authors: Christoph Raisch <raisch@de.ibm.com>
+ *           Waleri Fomin <fomin@de.ibm.com>
+ *           Gerd Bayer <gerd.bayer@de.ibm.com>
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
+ *  $Id: hcp_phyp.h,v 1.16 2006/02/06 10:17:34 schickhj Exp $
+ */
+
+#ifndef __HCP_PHYP_H__
+#define __HCP_PHYP_H__
+
+#ifndef EHCA_USERDRIVER
+inline static int hcall_map_page(u64 physaddr, u64 * mapaddr)
+{
+	*mapaddr = (u64)(ioremap(physaddr, 4096));
+
+	EDEB(7, "ioremap physaddr=%lx mapaddr=%lx", physaddr, *mapaddr);
+	return 0;
+}
+
+inline static int hcall_unmap_page(u64 mapaddr)
+{
+	EDEB(7, "mapaddr=%lx", mapaddr);
+	iounmap((void *)(mapaddr));
+	return 0;
+}
+#else
+int hcall_map_page(u64 physaddr, u64 * mapaddr);
+int hcall_unmap_page(u64 mapaddr);
+#endif
+
+struct hcall {
+	u64 regs[11];
+};
+
+/**
+ * @brief returns time to wait in secs for the given long busy error code
+ */
+inline static u32 getLongBusyTimeSecs(int longBusyRetCode)
+{
+	switch (longBusyRetCode) {
+	case H_LongBusyOrder1msec:
+		return 1;
+	case H_LongBusyOrder10msec:
+		return 10;
+	case H_LongBusyOrder100msec:
+		return 100;
+	case H_LongBusyOrder1sec:
+		return 1000;
+	case H_LongBusyOrder10sec:
+		return 10000;
+	case H_LongBusyOrder100sec:
+		return 100000;
+	default:
+		return 1;
+	}			/* eof switch */
+}
+
+inline static long plpar_hcall_7arg_7ret(unsigned long opcode,
+					 unsigned long arg1,    /* <R4  */
+					 unsigned long arg2,	/* <R5  */
+					 unsigned long arg3,	/* <R6  */
+					 unsigned long arg4,	/* <R7  */
+					 unsigned long arg5,	/* <R8  */
+					 unsigned long arg6,	/* <R9  */
+					 unsigned long arg7,	/* <R10 */
+					 unsigned long *out1,	/* <R4  */
+					 unsigned long *out2,	/* <R5  */
+					 unsigned long *out3,	/* <R6  */
+					 unsigned long *out4,	/* <R7  */
+					 unsigned long *out5,	/* <R8  */
+					 unsigned long *out6,	/* <R9  */
+					 unsigned long *out7	/* <R10 */
+    )
+{
+	struct hcall hcall_in = {
+		.regs[0] = opcode,
+		.regs[1] = arg1,
+		.regs[2] = arg2,
+		.regs[3] = arg3,
+		.regs[4] = arg4,
+		.regs[5] = arg5,
+		.regs[6] = arg6,
+		.regs[7] = arg7	/*,
+				   .regs[8]=arg8 */
+	};
+	struct hcall hcall = hcall_in;
+	int i;
+	long ret;
+	int sleep_msecs;
+	EDEB(7, "HCALL77_IN r3=%lx r4=%lx r5=%lx r6=%lx r7=%lx r8=%lx"
+	     " r9=%lx r10=%lx r11=%lx", hcall.regs[0], hcall.regs[1],
+	     hcall.regs[2], hcall.regs[3], hcall.regs[4], hcall.regs[5],
+	     hcall.regs[6], hcall.regs[7], hcall.regs[8]);
+
+	/* if phype returns LongBusyXXX,
+	 * we retry several times, but not forever */
+	for (i = 0; i < 5; i++) {
+		__asm__ __volatile__("mr 3,%10\n"
+				     "mr 4,%11\n"
+				     "mr 5,%12\n"
+				     "mr 6,%13\n"
+				     "mr 7,%14\n"
+				     "mr 8,%15\n"
+				     "mr 9,%16\n"
+				     "mr 10,%17\n"
+				     "mr 11,%18\n"
+				     "mr 12,%19\n"
+				     ".long 0x44000022\n"
+				     "mr %0,3\n"
+				     "mr %1,4\n"
+				     "mr %2,5\n"
+				     "mr %3,6\n"
+				     "mr %4,7\n"
+				     "mr %5,8\n"
+				     "mr %6,9\n"
+				     "mr %7,10\n"
+				     "mr %8,11\n"
+				     "mr %9,12\n":"=r"(hcall.regs[0]),
+				     "=r"(hcall.regs[1]), "=r"(hcall.regs[2]),
+				     "=r"(hcall.regs[3]), "=r"(hcall.regs[4]),
+				     "=r"(hcall.regs[5]), "=r"(hcall.regs[6]),
+				     "=r"(hcall.regs[7]), "=r"(hcall.regs[8]),
+				     "=r"(hcall.regs[9])
+				     :"r"(hcall.regs[0]), "r"(hcall.regs[1]),
+				     "r"(hcall.regs[2]), "r"(hcall.regs[3]),
+				     "r"(hcall.regs[4]), "r"(hcall.regs[5]),
+				     "r"(hcall.regs[6]), "r"(hcall.regs[7]),
+				     "r"(hcall.regs[8]), "r"(hcall.regs[9])
+				     :"r0", "r2", "r3", "r4", "r5", "r6", "r7",
+				     "r8", "r9", "r10", "r11", "r12", "cc",
+				     "xer", "ctr", "lr", "cr0", "cr1", "cr5",
+				     "cr6", "cr7");
+
+		EDEB(7, "HCALL77_OUT r3=%lx r4=%lx r5=%lx r6=%lx r7=%lx r8=%lx"
+		     "r9=%lx r10=%lx r11=%lx", hcall.regs[0], hcall.regs[1],
+		     hcall.regs[2], hcall.regs[3], hcall.regs[4], hcall.regs[5],
+		     hcall.regs[6], hcall.regs[7], hcall.regs[8]);
+		ret = hcall.regs[0];
+		*out1 = hcall.regs[1];
+		*out2 = hcall.regs[2];
+		*out3 = hcall.regs[3];
+		*out4 = hcall.regs[4];
+		*out5 = hcall.regs[5];
+		*out6 = hcall.regs[6];
+		*out7 = hcall.regs[7];
+
+		if (!H_isLongBusy(ret)) {
+			if (ret<0) {
+				EDEB_ERR(4, "HCALL77_IN r3=%lx r4=%lx r5=%lx r6=%lx "
+					 "r7=%lx r8=%lx r9=%lx r10=%lx",
+					 opcode, arg1, arg2, arg3,
+					 arg4, arg5, arg6, arg7);
+				EDEB_ERR(4,
+					 "HCALL77_OUT r3=%lx r4=%lx r5=%lx "
+					 "r6=%lx r7=%lx r8=%lx r9=%lx r10=%lx ",
+					 hcall.regs[0], hcall.regs[1],
+					 hcall.regs[2], hcall.regs[3],
+					 hcall.regs[4], hcall.regs[5],
+					 hcall.regs[6], hcall.regs[7]);
+			}
+			return ret;
+		}
+
+		sleep_msecs = getLongBusyTimeSecs(ret);
+		EDEB(7, "Got LongBusy return code from phype. "
+		       "Sleep %dmsecs and retry...", sleep_msecs);
+		msleep_interruptible(sleep_msecs);
+		hcall = hcall_in;
+	}			/* eof for */
+	EDEB_ERR(4, "HCALL77_OUT ret=H_Busy");
+	return H_Busy;
+}
+
+inline static long plpar_hcall_9arg_9ret(unsigned long opcode,
+					 unsigned long arg1,	/* <R4  */
+					 unsigned long arg2,	/* <R5  */
+					 unsigned long arg3,	/* <R6  */
+					 unsigned long arg4,	/* <R7  */
+					 unsigned long arg5,	/* <R8  */
+					 unsigned long arg6,	/* <R9  */
+					 unsigned long arg7,	/* <R10 */
+					 unsigned long arg8,	/* <R11 */
+					 unsigned long arg9,	/* <R12 */
+					 unsigned long *out1,	/* <R4  */
+					 unsigned long *out2,	/* <R5  */
+					 unsigned long *out3,	/* <R6  */
+					 unsigned long *out4,	/* <R7  */
+					 unsigned long *out5,	/* <R8  */
+					 unsigned long *out6,	/* <R9  */
+					 unsigned long *out7,	/* <R10 */
+					 unsigned long *out8,	/* <R11 */
+					 unsigned long *out9	/* <R12 */
+    )
+{
+	struct hcall hcall_in = {
+		.regs[0] = opcode,
+		.regs[1] = arg1,
+		.regs[2] = arg2,
+		.regs[3] = arg3,
+		.regs[4] = arg4,
+		.regs[5] = arg5,
+		.regs[6] = arg6,
+		.regs[7] = arg7,
+		.regs[8] = arg8,
+		.regs[9] = arg9,
+	};
+	struct hcall hcall = hcall_in;
+	int i;
+	long ret;
+	int sleep_msecs;
+	EDEB(7,"HCALL99_IN  r3=%lx r4=%lx r5=%lx r6=%lx r7=%lx r8=%lx r9=%lx"
+	     " r10=%lx r11=%lx r12=%lx",
+	     hcall.regs[0], hcall.regs[1], hcall.regs[2], hcall.regs[3],
+	     hcall.regs[4], hcall.regs[5], hcall.regs[6], hcall.regs[7],
+	     hcall.regs[8], hcall.regs[9]);
+
+	/* if phype returns LongBusyXXX, we retry several times, but not forever */
+	for (i = 0; i < 5; i++) {
+		__asm__ __volatile__("mr 3,%10\n"
+				     "mr 4,%11\n"
+				     "mr 5,%12\n"
+				     "mr 6,%13\n"
+				     "mr 7,%14\n"
+				     "mr 8,%15\n"
+				     "mr 9,%16\n"
+				     "mr 10,%17\n"
+				     "mr 11,%18\n"
+				     "mr 12,%19\n"
+				     ".long 0x44000022\n"
+				     "mr %0,3\n"
+				     "mr %1,4\n"
+				     "mr %2,5\n"
+				     "mr %3,6\n"
+				     "mr %4,7\n"
+				     "mr %5,8\n"
+				     "mr %6,9\n"
+				     "mr %7,10\n"
+				     "mr %8,11\n"
+				     "mr %9,12\n":"=r"(hcall.regs[0]),
+				     "=r"(hcall.regs[1]), "=r"(hcall.regs[2]),
+				     "=r"(hcall.regs[3]), "=r"(hcall.regs[4]),
+				     "=r"(hcall.regs[5]), "=r"(hcall.regs[6]),
+				     "=r"(hcall.regs[7]), "=r"(hcall.regs[8]),
+				     "=r"(hcall.regs[9])
+				     :"r"(hcall.regs[0]), "r"(hcall.regs[1]),
+				     "r"(hcall.regs[2]), "r"(hcall.regs[3]),
+				     "r"(hcall.regs[4]), "r"(hcall.regs[5]),
+				     "r"(hcall.regs[6]), "r"(hcall.regs[7]),
+				     "r"(hcall.regs[8]), "r"(hcall.regs[9])
+				     :"r0", "r2", "r3", "r4", "r5", "r6", "r7",
+				     "r8", "r9", "r10", "r11", "r12", "cc",
+				     "xer", "ctr", "lr", "cr0", "cr1", "cr5",
+				     "cr6", "cr7");
+
+		EDEB(7,"HCALL99_OUT r3=%lx r4=%lx r5=%lx r6=%lx r7=%lx r8=%lx "
+		     "r9=%lx r10=%lx r11=%lx r12=%lx", hcall.regs[0],
+		     hcall.regs[1], hcall.regs[2], hcall.regs[3], hcall.regs[4],
+		     hcall.regs[5], hcall.regs[6], hcall.regs[7], hcall.regs[8],
+		     hcall.regs[9]);
+		ret = hcall.regs[0];
+		*out1 = hcall.regs[1];
+		*out2 = hcall.regs[2];
+		*out3 = hcall.regs[3];
+		*out4 = hcall.regs[4];
+		*out5 = hcall.regs[5];
+		*out6 = hcall.regs[6];
+		*out7 = hcall.regs[7];
+		*out8 = hcall.regs[8];
+		*out9 = hcall.regs[9];
+
+		if (!H_isLongBusy(ret)) {
+			if (ret<0) {
+				EDEB_ERR(4, "HCALL99_IN r3=%lx r4=%lx r5=%lx r6=%lx "
+					 "r7=%lx r8=%lx r9=%lx r10=%lx "
+					 "r11=%lx r12=%lx",
+					 opcode, arg1, arg2, arg3,
+					 arg4, arg5, arg6, arg7,
+					 arg8, arg9);
+				EDEB_ERR(4,
+					 "HCALL99_OUT r3=%lx r4=%lx r5=%lx "
+					 "r6=%lx r7=%lx r8=%lx r9=%lx r10=%lx "
+					 "r11=%lx r12=lx",
+					 hcall.regs[0], hcall.regs[1],
+					 hcall.regs[2], hcall.regs[3],
+					 hcall.regs[4], hcall.regs[5],
+					 hcall.regs[6], hcall.regs[7],
+					 hcall.regs[8]);
+			}
+			return ret;
+		}
+		sleep_msecs = getLongBusyTimeSecs(ret);
+		EDEB(7, "Got LongBusy return code from phype. "
+		     "Sleep %dmsecs and retry...", sleep_msecs);
+		msleep_interruptible(sleep_msecs);
+		hcall = hcall_in;
+	}			/* eof for */
+	EDEB_ERR(4, "HCALL99_OUT ret=H_Busy");
+	return H_Busy;
+}
+
+#endif
