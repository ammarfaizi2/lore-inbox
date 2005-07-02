Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbVGBCgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbVGBCgJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 22:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbVGBCgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 22:36:09 -0400
Received: from opersys.com ([64.40.108.71]:62727 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261682AbVGBCf1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 22:35:27 -0400
Message-ID: <42C60001.5050609@opersys.com>
Date: Fri, 01 Jul 2005 22:46:25 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: LTT-Dev <ltt-dev@shafik.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Robert Wisniewski <bob@watson.ibm.com>,
       Mathieu Desnoyers <compudj@krystal.dyndns.org>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Michael Raymond <mraymond@sgi.com>
Subject: [PATCH/RFC] Significantly reworked LTT core
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A few months back, there was a very large thread of discussion
about the inclusion of the ltt code by Andrew in -mm. Following this
discussion, relayfs was quite heavily trimmed down. However, unlike
what I had promised, I never got around to actually do the same to
the ltt code. Part of it was my not being ready to actually gut 5
years of coding ... that was just kind of difficult. Lately though,
through active discussion on the ltt-dev list, this issue has
resurfaced and a few pieces of revamped code started going around.
Thanks to Mathieu Desnoyers (Ecole Polytechnique) and Michael
Raymond (SGI) getting things moving again, I got back to thinking
about the best way to get the LTT code down to a palatable structure.
And this time around, I gave simplicity a chance ...

Which brings me to the patch below. This is a significantly cut down
version of the ltt core. It's now 5K instead of the initial 100K.
While the size has been trimmed down, much of the functionality can
still be easily obtained through the introduction of a new method:
the ltt multiplexer (ltt_mux). Basically, this is the function that
controls the tracing behavior. If none is provided, no tracing goes
on. Typically, such a function would be implemented as part of a
loadable "control" module. Said module would be responsible for:
- Allocating and managing relayfs buffers for storing events
- Allowing the user-space tracing daemon to control tracing, such as
  by controling event masks, etc.
- Communicate with the user-space daemon for committing buffered data
- Providing primitives for having multiple tracing streams, including
  flight-recording.
- Provide abstractions for registering new facilities and events.
- Maintaining overall sanity of tracing functionality.
IOW, much of what was purged can now be modularized and loaded
separately. Obviously this doesn't preclude having those modules
still packaged with the rest of the kernel, but it does make things
much cleaner.

This patch isn't definitive, it's truely experimental. I've only
compile-tested it for now. I'm posting it here mostly as a preview.
Of course, your feedback is welcome.

Signed-off-by: Karim Yaghmour <karim@opersys.com>

-----

 MAINTAINERS              |   10 +++++
 include/linux/ltt-core.h |   35 ++++++++++++++++++
 init/Kconfig             |   19 ++++++++++
 kernel/Makefile          |    1
 kernel/ltt-core.c        |   88 +++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 153 insertions(+)


diff -urpN linux-2.6.12-rc4-mm2/include/linux/ltt-core.h linux-2.6.12-rc4-mm2-ltt/include/linux/ltt-core.h
--- linux-2.6.12-rc4-mm2/include/linux/ltt-core.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.12-rc4-mm2-ltt/include/linux/ltt-core.h	2005-07-01 22:00:56.000000000 -0400
@@ -0,0 +1,35 @@
+/*
+ * linux/include/linux/ltt-core.h
+ *
+ * Copyright (C) 1999-2005 Karim Yaghmour (karim@opersys.com)
+ *
+ * Definitions for the Linux Trace Toolkit core.
+ */
+
+#ifndef _LTT_CORE_H
+#define _LTT_CORE_H
+
+#include <linux/types.h>
+#include <linux/relayfs_fs.h>
+
+#define LTT_RELAYFS_ROOT "ltt"
+
+struct ltt_event_header {
+	struct timeval time;
+	u8 eid;
+	uint32_t length;
+};
+
+struct ltt_chan_buf {
+	struct rchan_buf* rbuf;
+
+	struct ltt_chan_buf* next;
+};
+
+extern struct ltt_chan_buf* (*ltt_mux)(uint8_t cpuid, uint8_t eid, uint32_t length, char* buf);
+
+extern struct dentry* ltt_root_dentry; /* Root of the directory tree */
+
+extern void ltt_log_event(uint8_t eid, uint32_t length, char* buf);
+
+#endif /* _LTT_CORE_H */
diff -urpN linux-2.6.12-rc4-mm2/init/Kconfig linux-2.6.12-rc4-mm2-ltt/init/Kconfig
--- linux-2.6.12-rc4-mm2/init/Kconfig	2005-05-18 15:12:03.000000000 -0400
+++ linux-2.6.12-rc4-mm2-ltt/init/Kconfig	2005-07-01 21:28:03.000000000 -0400
@@ -238,6 +238,25 @@ config CPUSETS

 	  Say N if unsure.

+config LTT_CORE
+	bool "Support for LTT core"
+	depends on RELAYFS_FS
+	default n
+	help
+	  The Linux Trace Toolkit (LTT) is a combination of kernel
+	  components and user-space control and visualization tools for
+	  tracing the kernel and analyzing its dynamic behavior.
+
+	  For more information, please visit:
+		http://www.opersys.com/ltt
+
+	  Experimental code for next-generation user-space tools
+	  can be found here:
+		http://ltt.polymtl.ca
+
+	  Say N if unsure.
+	
+
 menuconfig EMBEDDED
 	bool "Configure standard kernel features (for small systems)"
 	help
diff -urpN linux-2.6.12-rc4-mm2/kernel/ltt-core.c linux-2.6.12-rc4-mm2-ltt/kernel/ltt-core.c
--- linux-2.6.12-rc4-mm2/kernel/ltt-core.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.12-rc4-mm2-ltt/kernel/ltt-core.c	2005-07-01 22:00:30.000000000 -0400
@@ -0,0 +1,88 @@
+/*
+ * ltt-core.c
+ *
+ * (C) Copyright, 1999, 2000, 2001, 2002, 2003, 2004, 2005 -
+ *              Karim Yaghmour (karim@opersys.com)
+ *
+ * Contains the core kernel functionality for the Linux Trace Toolkit.
+ *
+ * Authors:
+ *	Karim Yaghmour (karim@opersys.com)
+ *	Tom Zanussi (zanussi@us.ibm.com)
+ *	Bob Wisniewski (bob@watson.ibm.com)
+ *	Mathieu Desnoyers (mathieu.desnoyers@polymtl.ca)
+ *	Michael A. Raymond (mraymond@sgi.com)
+ */
+#include <linux/types.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/ltt-core.h>
+#include <linux/module.h>
+#include <linux/relayfs_fs.h>
+#include <linux/spinlock.h>
+
+/* Main multiplexer */
+struct ltt_chan_buf* (*ltt_mux)(uint8_t, uint8_t, uint32_t, char*) = NULL;
+
+/* LTT root in relayfs */
+struct dentry* ltt_root_dentry = NULL;
+
+/* This is the base function that all event specific functions will use to
+   actually write the log record. */
+void ltt_log_event(uint8_t eid,
+		   uint32_t length,
+		   char* buf)
+{
+	uint8_t cpu;
+	unsigned long flags;
+	struct timeval event_time;
+	struct ltt_chan_buf* ltt_buf = NULL;
+	struct ltt_event_header* header;
+
+	/* Can't go further without an active multiplexer, do this ASAP not to
+	   impact performance */
+	if (!ltt_mux)
+		return;
+
+	local_irq_save(flags);
+
+	cpu = smp_processor_id();
+
+	/* Do we log the event? */
+	if (!(ltt_buf = ltt_mux(cpu, eid, length, buf)))
+		goto log_done;
+
+	/* Get timestamp just once */
+	do_gettimeofday(&event_time);
+
+	/* Loop through the returned list of rchans and write to each one. */
+	do {
+		if ((header = relay_reserve(ltt_buf->rbuf->chan,
+					    sizeof(header) + length))) {
+			memcpy(&header->time, &event_time, sizeof(event_time));
+			header->eid = eid;
+			header->length = length;
+			memcpy(header + sizeof(header), buf, length);
+
+			relay_commit(ltt_buf->rbuf, header, sizeof(header) + length);
+		}
+	} while ((ltt_buf = ltt_buf->next));
+
+log_done:
+	local_irq_restore(flags);
+}
+
+/* Initialize the LTT state at boot time */
+static int __init ltt_init(void)
+{
+	/* Create the basic RelayFS directory tree */
+	if (!(ltt_root_dentry = relayfs_create_dir(LTT_RELAYFS_ROOT, NULL)))
+		return -1;
+
+	return 0;
+}
+__initcall(ltt_init);
+
+EXPORT_SYMBOL(ltt_root_dentry);
+EXPORT_SYMBOL(ltt_mux);
+EXPORT_SYMBOL(ltt_log_event);
diff -urpN linux-2.6.12-rc4-mm2/kernel/Makefile linux-2.6.12-rc4-mm2-ltt/kernel/Makefile
--- linux-2.6.12-rc4-mm2/kernel/Makefile	2005-05-18 15:12:03.000000000 -0400
+++ linux-2.6.12-rc4-mm2-ltt/kernel/Makefile	2005-07-01 21:17:31.000000000 -0400
@@ -31,6 +31,7 @@ obj-$(CONFIG_DETECT_SOFTLOCKUP) += softl
 obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
 obj-$(CONFIG_CRASH_DUMP) += crash_dump.o
 obj-$(CONFIG_SECCOMP) += seccomp.o
+obj-$(CONFIG_LTT_CORE) += ltt-core.o

 ifneq ($(CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff -urpN linux-2.6.12-rc4-mm2/MAINTAINERS linux-2.6.12-rc4-mm2-ltt/MAINTAINERS
--- linux-2.6.12-rc4-mm2/MAINTAINERS	2005-05-18 15:12:03.000000000 -0400
+++ linux-2.6.12-rc4-mm2-ltt/MAINTAINERS	2005-07-01 21:28:36.000000000 -0400
@@ -1444,6 +1444,16 @@ L:	linux-security-module@wirex.com
 W:	http://lsm.immunix.org
 S:	Supported

+LINUX TRACE TOOLKIT
+P:     Karim Yaghmour
+M:     karim@opersys.com
+P:     Mathieu Desnoyers
+M:     mathieu.desnoyers@polymtl.ca
+W:     http://www.opersys.com/LTT
+W:     http://ltt.polymtl.ca
+L:     ltt-dev@listserv.shafik.org
+S:     Maintained
+
 LM83 HARDWARE MONITOR DRIVER
 P:	Jean Delvare
 M:	khali@linux-fr.org

