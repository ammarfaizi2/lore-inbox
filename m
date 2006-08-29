Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbWH2LGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbWH2LGW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 07:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbWH2LGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 07:06:22 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:33205 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932276AbWH2LGV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 07:06:21 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm] PM: Add pm_trace switch
Date: Tue, 29 Aug 2006 13:09:57 +0200
User-Agent: KMail/1.9.3
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>,
       Greg KH <greg@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608291309.57404.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the pm_trace attribute in /sys/power which has to be explicitly set to one
to really enable the "PM tracing" code compiled in when CONFIG_PM_TRACE is
set (which modifies the machine's CMOS clock in unpredictable ways).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 include/linux/resume-trace.h |   24 ++++++++++++++----------
 kernel/power/main.c          |   30 ++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 10 deletions(-)

Index: linux-2.6.18-rc4-mm1/include/linux/resume-trace.h
===================================================================
--- linux-2.6.18-rc4-mm1.orig/include/linux/resume-trace.h	2006-08-13 14:54:42.000000000 +0200
+++ linux-2.6.18-rc4-mm1/include/linux/resume-trace.h	2006-08-17 12:27:34.000000000 +0200
@@ -3,21 +3,25 @@
 
 #ifdef CONFIG_PM_TRACE
 
+extern int pm_trace_enabled;
+
 struct device;
 extern void set_trace_device(struct device *);
 extern void generate_resume_trace(void *tracedata, unsigned int user);
 
 #define TRACE_DEVICE(dev) set_trace_device(dev)
-#define TRACE_RESUME(user) do {				\
-	void *tracedata;				\
-	asm volatile("movl $1f,%0\n"			\
-		".section .tracedata,\"a\"\n"		\
-		"1:\t.word %c1\n"			\
-		"\t.long %c2\n"				\
-		".previous"				\
-		:"=r" (tracedata)			\
-		: "i" (__LINE__), "i" (__FILE__));	\
-	generate_resume_trace(tracedata, user);		\
+#define TRACE_RESUME(user) do {					\
+	if (pm_trace_enabled) {					\
+		void *tracedata;				\
+		asm volatile("movl $1f,%0\n"			\
+			".section .tracedata,\"a\"\n"		\
+			"1:\t.word %c1\n"			\
+			"\t.long %c2\n"				\
+			".previous"				\
+			:"=r" (tracedata)			\
+			: "i" (__LINE__), "i" (__FILE__));	\
+		generate_resume_trace(tracedata, user);		\
+	}							\
 } while (0)
 
 #else
Index: linux-2.6.18-rc4-mm1/kernel/power/main.c
===================================================================
--- linux-2.6.18-rc4-mm1.orig/kernel/power/main.c	2006-08-14 20:51:47.000000000 +0200
+++ linux-2.6.18-rc4-mm1/kernel/power/main.c	2006-08-17 12:34:23.000000000 +0200
@@ -17,6 +17,7 @@
 #include <linux/pm.h>
 #include <linux/console.h>
 #include <linux/cpu.h>
+#include <linux/resume-trace.h>
 
 #include "power.h"
 
@@ -285,10 +286,39 @@ static ssize_t state_store(struct subsys
 
 power_attr(state);
 
+#ifdef CONFIG_PM_TRACE
+int pm_trace_enabled;
+
+static ssize_t pm_trace_show(struct subsystem * subsys, char * buf)
+{
+	return sprintf(buf, "%d\n", pm_trace_enabled);
+}
+
+static ssize_t
+pm_trace_store(struct subsystem * subsys, const char * buf, size_t n)
+{
+	int val;
+
+	if (sscanf(buf, "%d", &val) == 1) {
+		pm_trace_enabled = !!val;
+		return n;
+	}
+	return -EINVAL;
+}
+
+power_attr(pm_trace);
+
+static struct attribute * g[] = {
+	&state_attr.attr,
+	&pm_trace_attr.attr,
+	NULL,
+};
+#else
 static struct attribute * g[] = {
 	&state_attr.attr,
 	NULL,
 };
+#endif /* CONFIG_PM_TRACE */
 
 static struct attribute_group attr_group = {
 	.attrs = g,
