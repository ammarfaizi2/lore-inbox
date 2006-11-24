Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966190AbWKXV6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966190AbWKXV6L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 16:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966209AbWKXV6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 16:58:11 -0500
Received: from tomts16.bellnexxia.net ([209.226.175.4]:8895 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S966190AbWKXV6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 16:58:07 -0500
Date: Fri, 24 Nov 2006 16:58:05 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       Karim Yaghmour <karim@opersys.com>, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>, Richard J Moore <richardj_moore@uk.ibm.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Douglas Niehaus <niehaus@eecs.ku.edu>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com
Subject: [PATCH 7/16] LTTng 0.6.36 for 2.6.18 : Core facility loader
Message-ID: <20061124215805.GH25048@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 16:57:13 up 93 days, 19:05,  4 users,  load average: 0.30, 0.59, 0.41
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Facility (event group) "core". Dynamic registration.

patch07-2.6.18-lttng-core-0.6.36-facility-loader-core.diff

Signed-off-by : Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

--BEGIN--
--- /dev/null
+++ b/ltt/facilities/ltt-facility-loader-core.c
@@ -0,0 +1,66 @@
+/*
+ * ltt-facility-loader-core.c
+ *
+ * (C) Copyright  2005 - 
+ *          Mathieu Desnoyers (mathieu.desnoyers@polymtl.ca)
+ *
+ * Contains the LTT facility loader.
+ *
+ */
+
+
+#include <linux/ltt-facilities.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/config.h>
+#include "ltt-facility-loader-core.h"
+
+
+#ifdef CONFIG_LTT
+
+EXPORT_SYMBOL(LTT_FACILITY_SYMBOL);
+EXPORT_SYMBOL(LTT_FACILITY_CHECKSUM_SYMBOL);
+
+static const char ltt_facility_name[] = LTT_FACILITY_NAME;
+
+#define SYMBOL_STRING(sym) #sym
+
+static struct ltt_facility facility = {
+	.name = ltt_facility_name,
+	.num_events = LTT_FACILITY_NUM_EVENTS,
+	.checksum = LTT_FACILITY_CHECKSUM,
+	.symbol = SYMBOL_STRING(LTT_FACILITY_SYMBOL),
+};
+
+static int __init facility_init(void)
+{
+	printk(KERN_INFO "LTT : ltt-facility-core init in kernel\n");
+
+	LTT_FACILITY_SYMBOL = ltt_facility_kernel_register(&facility);
+	LTT_FACILITY_CHECKSUM_SYMBOL = LTT_FACILITY_SYMBOL;
+	
+	return LTT_FACILITY_SYMBOL;
+}
+
+#ifndef MODULE
+__initcall(facility_init);
+#else
+module_init(facility_init);
+static void __exit facility_exit(void)
+{
+	int err;
+
+	err = ltt_facility_unregister(LTT_FACILITY_SYMBOL);
+	if (err != 0)
+		printk(KERN_ERR "LTT : Error in unregistering facility.\n");
+
+}
+module_exit(facility_exit)
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Mathieu Desnoyers");
+MODULE_DESCRIPTION("Linux Trace Toolkit Facility");
+
+#endif //MODULE
+
+#endif //CONFIG_LTT
--- /dev/null
+++ b/ltt/facilities/ltt-facility-loader-core.h
@@ -0,0 +1,20 @@
+#ifndef _LTT_FACILITY_LOADER_CORE_H_
+#define _LTT_FACILITY_LOADER_CORE_H_
+
+#ifdef CONFIG_LTT
+
+#include <linux/ltt-facilities.h>
+#include <ltt/ltt-facility-id-core.h>
+
+ltt_facility_t	ltt_facility_core;
+ltt_facility_t	ltt_facility_core_1A8DE486;
+
+#define LTT_FACILITY_SYMBOL		ltt_facility_core
+#define LTT_FACILITY_CHECKSUM_SYMBOL	ltt_facility_core_1A8DE486
+#define LTT_FACILITY_CHECKSUM		0x1A8DE486
+#define LTT_FACILITY_NAME		"core"
+#define LTT_FACILITY_NUM_EVENTS	facility_core_num_events
+
+#endif //CONFIG_LTT
+
+#endif //_LTT_FACILITY_LOADER_CORE_H_
--- /dev/null
+++ b/ltt/facilities/Makefile
@@ -0,0 +1,3 @@
+# LTT facilities makefile
+
+obj-$(CONFIG_LTT)			+= ltt-facility-loader-core.o
--END--

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
