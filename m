Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932558AbVLPXtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932558AbVLPXtN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 18:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbVLPXtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 18:49:13 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:119 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S932558AbVLPXtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 18:49:12 -0500
Subject: [PATCH 02/13]  [RFC] ipath debug header
In-Reply-To: <200512161548.aLjaDpGm5aqk0k0p@cisco.com>
X-Mailer: Roland's Patchbomber
Date: Fri, 16 Dec 2005 15:48:54 -0800
Message-Id: <200512161548.HbgfRzF2TysjsR2G@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, openib-general@openib.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <rolandd@cisco.com>
X-OriginalArrivalTime: 16 Dec 2005 23:48:56.0526 (UTC) FILETIME=[4740E6E0:01C6029B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Debugging macros for ipath driver

---

 drivers/infiniband/hw/ipath/ipath_debug.h |  211 +++++++++++++++++++++++++++++
 1 files changed, 211 insertions(+), 0 deletions(-)
 create mode 100644 drivers/infiniband/hw/ipath/ipath_debug.h

8f834f72344a3c7e9c5eafdf59b9fc96b4e08e5f
diff --git a/drivers/infiniband/hw/ipath/ipath_debug.h b/drivers/infiniband/hw/ipath/ipath_debug.h
new file mode 100644
index 0000000..c8b7374
--- /dev/null
+++ b/drivers/infiniband/hw/ipath/ipath_debug.h
@@ -0,0 +1,211 @@
+/*
+ * Copyright (c) 2003, 2004, 2005. PathScale, Inc. All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ *
+ * Patent licenses, if any, provided herein do not apply to
+ * combinations of this program with other software, or any other
+ * product whatsoever.
+ *
+ * $Id: ipath_debug.h 4504 2005-12-16 06:15:47Z rjwalsh $
+ */
+
+#ifndef _IPATH_DEBUG_H
+#define _IPATH_DEBUG_H
+
+/*
+ * This file contains tracing code that is lightweight, and can be
+ * called from both user and kernel mode
+ * _IPATH_DBG should have the same calling conventions and semantics
+ * for both user and kernel.
+ */
+#ifndef _IPATH_DEBUGGING	/* tracing enabled or not */
+#define _IPATH_DEBUGGING 1
+#endif
+
+/* This macros should only be used in the trace library code. */
+#define _IPATH_DEBUG_VARS_DECL unsigned infinipath_debug;
+extern unsigned infinipath_debug;
+extern const char *ipath_get_unit_name(int unit);
+
+/*
+ * These are always defined, because _IPATH_ERROR is always defined,
+ * unlike the other debugging calls.  It might make sense to change
+ * to using "fprintf(stderr", for the usermode version, but not now.
+ */
+#ifdef __KERNEL__
+#define __IPPRT printk
+#define __IPATH_UNIT_ERRID(unit) ipath_get_unit_name(unit)
+#define __IPATH_ERRID "infinipath"
+#else
+#define __IPPRT printf
+extern char *__progname;
+#define __IPATH_UNIT_ERRID(unit) __progname
+#define __IPATH_ERRID __progname
+#define KERN_ERR
+#endif
+
+#if _IPATH_DEBUGGING
+
+/*
+ * Mask values for debugging.  The scheme allows us to compile out any of
+ * the debug tracing stuff, and if compiled in, to enable or disable dynamically
+ * This can be set at modprobe time also:
+ *      modprobe infinipath.ko infinipath_debug=7
+ */
+#define __IPATH_INFO        0x1	/* generic low verbosity stuff */
+#define __IPATH_DBG         0x2	/* generic debug */
+#define __IPATH_TRSAMPLE    0x8	/* generate trace buffer sample entries */
+/* leave some low verbosity spots open */
+#define __IPATH_VERBDBG     0x40	/* very verbose debug */
+#define __IPATH_PKTDBG      0x80	/* print packet data */
+/* print process startup (init)/exit messages */
+#define __IPATH_PROCDBG     0x100
+/* print mmap/nopage stuff, not using VDBG any more */
+#define __IPATH_MMDBG       0x200
+#define __IPATH_USER_SEND   0x1000	/* use user mode send */
+#define __IPATH_KERNEL_SEND 0x2000	/* use kernel mode send */
+#define __IPATH_EPKTDBG     0x4000	/* print ethernet packet data */
+#define __IPATH_SMADBG      0x8000	/* sma packet debug */
+#define __IPATH_IPATHDBG    0x10000	/* Ethernet (IPATH) general debug on */
+#define __IPATH_IPATHWARN   0x20000	/* Ethernet (IPATH) warnings on */
+#define __IPATH_IPATHERR    0x40000	/* Ethernet (IPATH) errors on */
+#define __IPATH_IPATHPD     0x80000	/* Ethernet (IPATH) packet dump on */
+#define __IPATH_IPATHTABLE  0x100000	/* Ethernet (IPATH) table dump on */
+
+#ifdef __KERNEL__
+#define __IPIDENT
+#define __IPIDENT_ARG
+#define __IP_INFO_TAG __IPATH_ERRID
+#define _Pragma_unlikely
+#else
+#define KERN_INFO
+#define KERN_DEBUG
+#define __IPIDENT "%s"
+#define __IPIDENT_ARG __ipath_mylabel,
+#define __IP_INFO_TAG __func__
+extern char *__ipath_mylabel;
+extern void ipath_set_mylabel(char *);
+#define _Pragma_unlikely _Pragma("mips_frequency_hint never")
+#endif
+
+#define _IPATH_UNIT_ERROR(unit,fmt,...) do { \
+        _Pragma_unlikely \
+        __IPPRT (KERN_ERR  __IPIDENT "%s: " fmt, __IPIDENT_ARG __IPATH_UNIT_ERRID(unit), \
+                ##__VA_ARGS__); \
+        } while(0)
+
+#define _IPATH_ERROR(fmt,...) do { \
+        _Pragma_unlikely \
+        __IPPRT (KERN_ERR  __IPIDENT "%s: " fmt, __IPIDENT_ARG __IPATH_ERRID, \
+                ##__VA_ARGS__); \
+        } while(0)
+
+#define _IPATH_INFO(fmt,...) do { \
+        _Pragma_unlikely \
+        if(unlikely(infinipath_debug&__IPATH_INFO))  \
+            __IPPRT (KERN_INFO __IPIDENT "%s: " fmt,\
+              __IPIDENT_ARG __IP_INFO_TAG,##__VA_ARGS__); \
+        } while(0)
+
+#define  __IPATH_USER_MODE_SEND unlikely(infinipath_debug & __IPATH_USER_SEND)
+#define  __IPATH_KERNEL_MODE_SEND unlikely(infinipath_debug & __IPATH_KERNEL_SEND)
+#define  __IPATH_PKTDBG_ON unlikely(infinipath_debug & __IPATH_PKTDBG)
+
+#define  __IPATH_DBG_WHICH(which,fmt,...) do { \
+        _Pragma_unlikely \
+        if(unlikely(infinipath_debug&(which)))  __IPPRT (KERN_DEBUG __IPIDENT "%s: " fmt,\
+            __IPIDENT_ARG __func__,##__VA_ARGS__); \
+        } while(0)
+#define  _IPATH_DBG(fmt,...) __IPATH_DBG_WHICH(__IPATH_DBG,fmt,##__VA_ARGS__)
+#define  _IPATH_VDBG(fmt,...) __IPATH_DBG_WHICH(__IPATH_VERBDBG,fmt,##__VA_ARGS__)
+#define  _IPATH_PDBG(fmt,...) __IPATH_DBG_WHICH(__IPATH_PKTDBG,fmt,##__VA_ARGS__)
+#define  _IPATH_EPDBG(fmt,...) __IPATH_DBG_WHICH(__IPATH_EPKTDBG,fmt,##__VA_ARGS__)
+#define  _IPATH_PRDBG(fmt,...) __IPATH_DBG_WHICH(__IPATH_PROCDBG,fmt,##__VA_ARGS__)
+#define  _IPATH_MMDBG(fmt,...) __IPATH_DBG_WHICH(__IPATH_MMDBG,fmt,##__VA_ARGS__)
+#define  _IPATH_SMADBG(fmt,...) __IPATH_DBG_WHICH(__IPATH_SMADBG,fmt,##__VA_ARGS__)
+#define  _IPATH_IPATHDBG(fmt,...) __IPATH_DBG_WHICH(__IPATH_IPATHDBG,fmt,##__VA_ARGS__)
+#define  _IPATH_IPATHWARN(fmt,...) __IPATH_DBG_WHICH(__IPATH_IPATHWARN,fmt,##__VA_ARGS__)
+#define  _IPATH_IPATHERR(fmt,...) __IPATH_DBG_WHICH(__IPATH_IPATHERR ,fmt,##__VA_ARGS__)
+#define  _IPATH_IPATHPD(fmt,...) __IPATH_DBG_WHICH(__IPATH_IPATHPD  ,fmt,##__VA_ARGS__)
+#define  _IPATH_IPATHTABLE(fmt,...) __IPATH_DBG_WHICH(__IPATH_IPATHTABLE  ,fmt,##__VA_ARGS__)
+
+#else				/* ! _IPATH_DEBUGGING */
+
+#define _IPATH_UNIT_ERROR(unit,fmt,...) do { \
+        __IPPRT (KERN_ERR  "%s" fmt, "",##__VA_ARGS__); \
+        } while(0)
+
+#define _IPATH_ERROR(fmt,...) do { \
+        __IPPRT (KERN_ERR  "%s" fmt, "",##__VA_ARGS__); \
+        } while(0)
+
+#define _IPATH_INFO(fmt,...)
+#define _IPATH_DBG(fmt,...)
+#define _IPATH_PDBG(fmt,...)
+#define _IPATH_EPDBG(fmt,...)
+#define _IPATH_PRDBG(fmt,...)
+#define _IPATH_VDBG(fmt,...)
+#define _IPATH_MMDBG(fmt,...)
+#define _IPATH_SMADBG(fmt,...)
+#define _IPATH_IPATHDBG(fmt,...)
+#define _IPATH_IPATHWARN(fmt,...)
+#define _IPATH_IPATHERR(fmt,...)
+#define _IPATH_IPATHPD(fmt,...)
+#define _IPATH_IPATHTABLE(fmt,...)
+
+/*
+ * define all of these even with debugging off, for the few places that do
+ * if(infinipath_debug&_IPATH_xyzzy), but in a way that will make the
+ * compiler eliminate the code
+ */
+#define __IPATH_INFO      0x0	/* generic low verbosity stuff */
+#define __IPATH_DBG       0x0	/* generic debug */
+#define __IPATH_CALL      0x0	/* function call entrance/exit */
+#define __IPATH_TRSAMPLE  0x0	/* generate trace buffer sample entries */
+#define __IPATH_VCALL     0x0	/* function call entrance/exit */
+#define __IPATH_VERBDBG   0x0	/* very verbose debug */
+#define __IPATH_PKTDBG    0x0	/* print packet data */
+#define __IPATH_PROCDBG   0x0	/* print process startup (init)/exit messages */
+/* print mmap/nopage stuff, not using VDBG any more */
+#define __IPATH_MMDBG     0x0
+#define __IPATH_EPKTDBG   0x0	/* print ethernet packet data */
+#define __IPATH_SMADBG    0x0	/* print process startup (init)/exit messages */
+#define __IPATH_IPATHDBG  0x0	/* Ethernet (IPATH) table dump on */
+#define __IPATH_IPATHWARN 0x0	/* Ethernet (IPATH) warnings on   */
+#define __IPATH_IPATHERR  0x0	/* Ethernet (IPATH) errors on   */
+#define __IPATH_IPATHPD   0x0	/* Ethernet (IPATH) packet dump on   */
+#define __IPATH_IPATHTABLE 0x0	/* Ethernet (IPATH) packet dump on   */
+#define  __IPATH_USER_MODE_SEND 0
+#define  __IPATH_KERNEL_MODE_SEND 0
+#define  __IPATH_PKTDBG_ON 0
+
+#endif				/* _IPATH_DEBUGGING */
+
+#endif				/* _IPATH_DEBUG_H */
-- 
0.99.9n
