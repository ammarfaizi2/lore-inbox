Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315439AbSHBQdP>; Fri, 2 Aug 2002 12:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315485AbSHBQdO>; Fri, 2 Aug 2002 12:33:14 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:23424
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S315439AbSHBQdL>; Fri, 2 Aug 2002 12:33:11 -0400
Date: Fri, 2 Aug 2002 09:36:30 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>
Subject: [PATCH][RESEND] A generic RTC driver [2/3]
Message-ID: <20020802163630.GD695@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is part 2 of 3 of the genrtc driver work.  This is the PPC portion
of the patch, which creates include/asm-ppc/rtc.h.  This has been in the
PPC bitkeeper tree for over a month now.  I can have Paul Mackerras send
this to you instead, if you prefer.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linux-2.5/include/asm-ppc/rtc.h	2002-07-23 09:20:47.000000000 -0700
@@ -0,0 +1,92 @@
+/* 
+ * inclue/asm-ppc/rtc.h
+ *
+ * Copyright 2002 MontaVista Software Inc.
+ * Author: Tom Rini <trini@mvista.com>
+ *
+ * Based on:
+ * include/asm-m68k/rtc.h
+ *
+ * Copyright Richard Zidlicky
+ * implementation details for genrtc/q40rtc driver
+ *
+ * And the old drivers/macintosh/rtc.c which was heavily based on:
+ * Linux/SPARC Real Time Clock Driver
+ * Copyright (C) 1996 Thomas K. Dyas (tdyas@eden.rutgers.edu)
+ *
+ * With additional work by Paul Mackerras and Franz Sirl.
+ */
+/* permission is hereby granted to copy, modify and redistribute this code
+ * in terms of the GNU Library General Public License, Version 2 or later,
+ * at your option.
+ */
+
+#ifndef __ASM_RTC_H__
+#define __ASM_RTC_H__
+
+#ifdef __KERNEL__
+
+#include <linux/rtc.h>
+
+#include <asm/machdep.h>
+#include <asm/time.h>
+
+#define RTC_PIE 0x40		/* periodic interrupt enable */
+#define RTC_AIE 0x20		/* alarm interrupt enable */
+#define RTC_UIE 0x10		/* update-finished interrupt enable */
+
+extern void gen_rtc_interrupt(unsigned long);
+
+/* some dummy definitions */
+#define RTC_SQWE 0x08		/* enable square-wave output */
+#define RTC_DM_BINARY 0x04	/* all time/date values are BCD if clear */
+#define RTC_24H 0x02		/* 24 hour mode - else hours bit 7 means pm */
+#define RTC_DST_EN 0x01	        /* auto switch DST - works f. USA only */
+
+static inline void get_rtc_time(struct rtc_time *time)
+{
+	if (ppc_md.get_rtc_time) {
+		unsigned long nowtime;
+
+		nowtime = (ppc_md.get_rtc_time)();
+
+		to_tm(nowtime, time);
+
+		time->tm_year -= 1900;
+		time->tm_mon -= 1; /* Make sure userland has a 0-based month */
+	}
+}
+
+/* Set the current date and time in the real time clock. */
+static inline void set_rtc_time(struct rtc_time *time)
+{
+	if (ppc_md.get_rtc_time) {
+		unsigned long nowtime;
+
+		nowtime = mktime(time->tm_year+1900, time->tm_mon+1,
+				time->tm_mday, time->tm_hour, time->tm_min,
+				time->tm_sec);
+
+		(ppc_md.set_rtc_time)(nowtime);
+	}
+}
+
+static inline unsigned int get_rtc_ss(void)
+{
+	struct rtc_time h;
+
+	get_rtc_time(&h);
+	return h.tm_sec;
+}
+
+static inline int get_rtc_pll(struct rtc_pll_info *pll)
+{
+	return -EINVAL;
+}
+static inline int set_rtc_pll(struct rtc_pll_info *pll)
+{
+	return -EINVAL;
+}
+
+#endif /* __KERNEL__ */
+#endif /* __ASM_RTC_H__ */
