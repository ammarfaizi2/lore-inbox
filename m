Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262028AbVEQXjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbVEQXjH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 19:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbVEQXgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 19:36:55 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:19646 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261998AbVEQXef
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 19:34:35 -0400
Date: Tue, 17 May 2005 16:34:25 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org
Subject: [RFC][PATCH 1/4] move arch-specific timeofday core to asm
Message-ID: <20050517233425.GF2735@us.ibm.com>
References: <1116029796.26454.2.camel@cog.beaverton.ibm.com> <20050517233300.GE2735@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050517233300.GE2735@us.ibm.com>
X-Operating-System: Linux 2.6.12-rc4 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.05.2005 [16:33:00 -0700], Nishanth Aravamudan wrote:
> On 13.05.2005 [17:16:35 -0700], john stultz wrote:
> > All,
> > 	This patch implements the architecture independent portion of the new
> > time of day subsystem. For a brief description on the rework, see here:
> > http://lwn.net/Articles/120850/ (Many thanks to the LWN team for that
> > easy to understand writeup!)
> > 
> > 	I intend this to be the last RFC release and to submit this patch to
> > Andrew for for testing near the end of this month. So please, if you
> > have any complaints, suggestions, or blocking issues, let me know.
> 
> I have been working closely with John to re-work the soft-timer subsytem
> to use the new timeofday() subsystem. The following patches attempts to
> begin this process. I would greatly appreciate any comments.

Description: Updates the timeofday-rework to move arch-specific code
into asm headers files.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

diff -urpN 2.6.12-rc4-tod-lkml/arch/i386/kernel/time.c 2.6.12-rc4-tod/arch/i386/kernel/time.c
--- 2.6.12-rc4-tod-lkml/arch/i386/kernel/time.c	2005-05-17 15:30:06.000000000 -0700
+++ 2.6.12-rc4-tod/arch/i386/kernel/time.c	2005-05-17 13:01:12.000000000 -0700
@@ -56,6 +56,7 @@
 #include <asm/uaccess.h>
 #include <asm/processor.h>
 #include <asm/timer.h>
+#include <asm/timeofday.h>
 
 #include "mach_time.h"
 
@@ -68,8 +69,6 @@
 
 #include "io_ports.h"
 
-#include <linux/timeofday.h>
-
 extern spinlock_t i8259A_lock;
 int pit_latch_buggy;              /* extern */
 
diff -urpN 2.6.12-rc4-tod-lkml/include/asm-generic/timeofday.h 2.6.12-rc4-tod/include/asm-generic/timeofday.h
--- 2.6.12-rc4-tod-lkml/include/asm-generic/timeofday.h	1969-12-31 16:00:00.000000000 -0800
+++ 2.6.12-rc4-tod/include/asm-generic/timeofday.h	2005-05-17 13:01:12.000000000 -0700
@@ -0,0 +1,26 @@
+/*  linux/include/asm-generic/timeofday.h
+ *
+ *  This file contains the asm-generic interface
+ *  to the arch specific calls used by the time of day subsystem
+ */
+#ifndef _ASM_GENERIC_TIMEOFDAY_H
+#define _ASM_GENERIC_TIMEOFDAY_H
+#include <linux/types.h>
+#include <linux/time.h>
+#include <linux/timex.h>
+#include <asm/div64.h>
+#ifdef CONFIG_NEWTOD
+
+/* Required externs */
+extern nsec_t read_persistent_clock(void);
+extern void sync_persistent_clock(struct timespec ts);
+
+#ifdef CONFIG_NEWTOD_VSYSCALL
+extern void arch_update_vsyscall_gtod(nsec_t wall_time, cycle_t offset_base,
+				struct timesource_t* timesource, int ntp_adj);
+#else
+#define arch_update_vsyscall_gtod(x,y,z,w) {}
+#endif /* CONFIG_NEWTOD_VSYSCALL */
+
+#endif /* CONFIG_NEWTOD */
+#endif
diff -urpN 2.6.12-rc4-tod-lkml/include/asm-i386/timeofday.h 2.6.12-rc4-tod/include/asm-i386/timeofday.h
--- 2.6.12-rc4-tod-lkml/include/asm-i386/timeofday.h	1969-12-31 16:00:00.000000000 -0800
+++ 2.6.12-rc4-tod/include/asm-i386/timeofday.h	2005-05-17 13:01:12.000000000 -0700
@@ -0,0 +1,4 @@
+#ifndef _ASM_I386_TIMEOFDAY_H
+#define _ASM_I386_TIMEOFDAY_H
+#include <asm-generic/timeofday.h>
+#endif
diff -urpN 2.6.12-rc4-tod-lkml/include/asm-ia64/timeofday.h 2.6.12-rc4-tod/include/asm-ia64/timeofday.h
--- 2.6.12-rc4-tod-lkml/include/asm-ia64/timeofday.h	1969-12-31 16:00:00.000000000 -0800
+++ 2.6.12-rc4-tod/include/asm-ia64/timeofday.h	2005-05-17 13:01:12.000000000 -0700
@@ -0,0 +1,4 @@
+#ifndef _ASM_IA64_TIMEOFDAY_H
+#define _ASM_IA64_TIMEOFDAY_H
+#include <asm-generic/timeofday.h>
+#endif
diff -urpN 2.6.12-rc4-tod-lkml/include/asm-ppc/timeofday.h 2.6.12-rc4-tod/include/asm-ppc/timeofday.h
--- 2.6.12-rc4-tod-lkml/include/asm-ppc/timeofday.h	1969-12-31 16:00:00.000000000 -0800
+++ 2.6.12-rc4-tod/include/asm-ppc/timeofday.h	2005-05-17 13:01:12.000000000 -0700
@@ -0,0 +1,4 @@
+#ifndef _ASM_PPC_TIMEOFDAY_H
+#define _ASM_PPC_TIMEOFDAY_H
+#include <asm-generic/timeofday.h>
+#endif
diff -urpN 2.6.12-rc4-tod-lkml/include/asm-ppc64/timeofday.h 2.6.12-rc4-tod/include/asm-ppc64/timeofday.h
--- 2.6.12-rc4-tod-lkml/include/asm-ppc64/timeofday.h	1969-12-31 16:00:00.000000000 -0800
+++ 2.6.12-rc4-tod/include/asm-ppc64/timeofday.h	2005-05-17 13:01:12.000000000 -0700
@@ -0,0 +1,4 @@
+#ifndef _ASM_PPC64_TIMEOFDAY_H
+#define _ASM_PPC64_TIMEOFDAY_H
+#include <asm-generic/timeofday.h>
+#endif
diff -urpN 2.6.12-rc4-tod-lkml/include/asm-s390/timeofday.h 2.6.12-rc4-tod/include/asm-s390/timeofday.h
--- 2.6.12-rc4-tod-lkml/include/asm-s390/timeofday.h	1969-12-31 16:00:00.000000000 -0800
+++ 2.6.12-rc4-tod/include/asm-s390/timeofday.h	2005-05-17 13:01:12.000000000 -0700
@@ -0,0 +1,4 @@
+#ifndef _ASM_S390_TIMEOFDAY_H
+#define _ASM_S390_TIMEOFDAY_H
+#include <asm-generic/timeofday.h>
+#endif
diff -urpN 2.6.12-rc4-tod-lkml/include/asm-x86_64/timeofday.h 2.6.12-rc4-tod/include/asm-x86_64/timeofday.h
--- 2.6.12-rc4-tod-lkml/include/asm-x86_64/timeofday.h	1969-12-31 16:00:00.000000000 -0800
+++ 2.6.12-rc4-tod/include/asm-x86_64/timeofday.h	2005-05-17 13:01:12.000000000 -0700
@@ -0,0 +1,4 @@
+#ifndef _ASM_X86_64_TIMEOFDAY_H
+#define _ASM_X86_64_TIMEOFDAY_H
+#include <asm-generic/timeofday.h>
+#endif
diff -urpN 2.6.12-rc4-tod-lkml/include/linux/timeofday.h 2.6.12-rc4-tod/include/linux/timeofday.h
--- 2.6.12-rc4-tod-lkml/include/linux/timeofday.h	2005-05-17 15:29:29.000000000 -0700
+++ 2.6.12-rc4-tod/include/linux/timeofday.h	2005-05-17 13:01:12.000000000 -0700
@@ -7,7 +7,6 @@
 #include <linux/types.h>
 #include <linux/time.h>
 #include <linux/timex.h>
-#include <linux/timesource.h>
 #include <asm/div64.h>
 
 #ifdef CONFIG_NEWTOD
@@ -23,19 +22,6 @@ extern int do_adjtimex(struct timex *tx)
 
 extern void timeofday_init(void);
 
-
-/* Required externs */
-/* XXX - should this go elsewhere? */
-extern nsec_t read_persistent_clock(void);
-extern void sync_persistent_clock(struct timespec ts);
-#ifdef CONFIG_NEWTOD_VSYSCALL
-extern void arch_update_vsyscall_gtod(nsec_t wall_time, cycle_t offset_base,
-				struct timesource_t* timesource, int ntp_adj);
-#else
-#define arch_update_vsyscall_gtod(x,y,z,w) {}
-#endif
-
-
 /* Inline helper functions */
 static inline struct timeval ns_to_timeval(nsec_t ns)
 {
diff -urpN 2.6.12-rc4-tod-lkml/kernel/timeofday.c 2.6.12-rc4-tod/kernel/timeofday.c
--- 2.6.12-rc4-tod-lkml/kernel/timeofday.c	2005-05-17 15:29:29.000000000 -0700
+++ 2.6.12-rc4-tod/kernel/timeofday.c	2005-05-17 13:01:12.000000000 -0700
@@ -58,6 +58,7 @@
 #include <linux/sched.h> /* Needed for capable() */
 #include <linux/sysdev.h>
 #include <linux/jiffies.h>
+#include <asm/timeofday.h>
 
 /* XXX - remove later */
 #define TIME_DBG 0
