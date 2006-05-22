Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbWEVD4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbWEVD4v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 23:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751565AbWEVD43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 23:56:29 -0400
Received: from xenotime.net ([66.160.160.81]:7127 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751558AbWEVD4Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 23:56:25 -0400
Date: Sun, 21 May 2006 20:57:44 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH 7/14/] Doc. sources: expose rtc
Message-Id: <20060521205744.d3b891c1.rdunlap@xenotime.net>
In-Reply-To: <20060521203349.40b40930.rdunlap@xenotime.net>
References: <20060521203349.40b40930.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Documentation/rtc.txt:
Expose example and tool source files in the Documentation/ directory in
their own files instead of being buried (almost hidden) in readme/txt files.

This will make them more visible/usable to users who may need
to use them, to developers who may need to test with them, and
to janitors who would update them if they were more visible.

Also, if any of these possibly should not be in the kernel tree at
all, it will be clearer that they are here and we can discuss if
they should be removed.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/rtc-test.c |  214 ++++++++++++++++++++++++++++++++++++++++++++++
 Documentation/rtc.txt    |  218 -----------------------------------------------
 2 files changed, 216 insertions(+), 216 deletions(-)

--- /dev/null
+++ linux-2617-rc4g9-docsrc-split/Documentation/rtc-test.c
@@ -0,0 +1,214 @@
+/*
+ *	Real Time Clock Driver Test/Example Program
+ *
+ *	Compile with:
+ *		gcc -s -Wall -Wstrict-prototypes rtctest.c -o rtctest
+ *
+ *	Copyright (C) 1996, Paul Gortmaker.
+ *
+ *	Released under the GNU General Public License, version 2,
+ *	included herein by reference.
+ *
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <linux/rtc.h>
+#include <sys/ioctl.h>
+#include <sys/time.h>
+#include <sys/types.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <errno.h>
+
+int main(void) {
+
+int i, fd, retval, irqcount = 0;
+unsigned long tmp, data;
+struct rtc_time rtc_tm;
+
+fd = open ("/dev/rtc", O_RDONLY);
+
+if (fd ==  -1) {
+	perror("/dev/rtc");
+	exit(errno);
+}
+
+fprintf(stderr, "\n\t\t\tRTC Driver Test Example.\n\n");
+
+/* Turn on update interrupts (one per second) */
+retval = ioctl(fd, RTC_UIE_ON, 0);
+if (retval == -1) {
+	perror("ioctl");
+	exit(errno);
+}
+
+fprintf(stderr, "Counting 5 update (1/sec) interrupts from reading /dev/rtc:");
+fflush(stderr);
+for (i=1; i<6; i++) {
+	/* This read will block */
+	retval = read(fd, &data, sizeof(unsigned long));
+	if (retval == -1) {
+		perror("read");
+		exit(errno);
+	}
+	fprintf(stderr, " %d",i);
+	fflush(stderr);
+	irqcount++;
+}
+
+fprintf(stderr, "\nAgain, from using select(2) on /dev/rtc:");
+fflush(stderr);
+for (i=1; i<6; i++) {
+	struct timeval tv = {5, 0};	/* 5 second timeout on select */
+	fd_set readfds;
+
+	FD_ZERO(&readfds);
+	FD_SET(fd, &readfds);
+	/* The select will wait until an RTC interrupt happens. */
+	retval = select(fd+1, &readfds, NULL, NULL, &tv);
+	if (retval == -1) {
+		perror("select");
+		exit(errno);
+	}
+	/* This read won't block unlike the select-less case above. */
+	retval = read(fd, &data, sizeof(unsigned long));
+	if (retval == -1) {
+		perror("read");
+		exit(errno);
+	}
+	fprintf(stderr, " %d",i);
+	fflush(stderr);
+	irqcount++;
+}
+
+/* Turn off update interrupts */
+retval = ioctl(fd, RTC_UIE_OFF, 0);
+if (retval == -1) {
+	perror("ioctl");
+	exit(errno);
+}
+
+/* Read the RTC time/date */
+retval = ioctl(fd, RTC_RD_TIME, &rtc_tm);
+if (retval == -1) {
+	perror("ioctl");
+	exit(errno);
+}
+
+fprintf(stderr, "\n\nCurrent RTC date/time is %d-%d-%d, %02d:%02d:%02d.\n",
+	rtc_tm.tm_mday, rtc_tm.tm_mon + 1, rtc_tm.tm_year + 1900,
+	rtc_tm.tm_hour, rtc_tm.tm_min, rtc_tm.tm_sec);
+
+/* Set the alarm to 5 sec in the future, and check for rollover */
+rtc_tm.tm_sec += 5;
+if (rtc_tm.tm_sec >= 60) {
+	rtc_tm.tm_sec %= 60;
+	rtc_tm.tm_min++;
+}
+if  (rtc_tm.tm_min == 60) {
+	rtc_tm.tm_min = 0;
+	rtc_tm.tm_hour++;
+}
+if  (rtc_tm.tm_hour == 24)
+	rtc_tm.tm_hour = 0;
+
+retval = ioctl(fd, RTC_ALM_SET, &rtc_tm);
+if (retval == -1) {
+	perror("ioctl");
+	exit(errno);
+}
+
+/* Read the current alarm settings */
+retval = ioctl(fd, RTC_ALM_READ, &rtc_tm);
+if (retval == -1) {
+	perror("ioctl");
+	exit(errno);
+}
+
+fprintf(stderr, "Alarm time now set to %02d:%02d:%02d.\n",
+	rtc_tm.tm_hour, rtc_tm.tm_min, rtc_tm.tm_sec);
+
+/* Enable alarm interrupts */
+retval = ioctl(fd, RTC_AIE_ON, 0);
+if (retval == -1) {
+	perror("ioctl");
+	exit(errno);
+}
+
+fprintf(stderr, "Waiting 5 seconds for alarm...");
+fflush(stderr);
+/* This blocks until the alarm ring causes an interrupt */
+retval = read(fd, &data, sizeof(unsigned long));
+if (retval == -1) {
+	perror("read");
+	exit(errno);
+}
+irqcount++;
+fprintf(stderr, " okay. Alarm rang.\n");
+
+/* Disable alarm interrupts */
+retval = ioctl(fd, RTC_AIE_OFF, 0);
+if (retval == -1) {
+	perror("ioctl");
+	exit(errno);
+}
+
+/* Read periodic IRQ rate */
+retval = ioctl(fd, RTC_IRQP_READ, &tmp);
+if (retval == -1) {
+	perror("ioctl");
+	exit(errno);
+}
+fprintf(stderr, "\nPeriodic IRQ rate was %ldHz.\n", tmp);
+
+fprintf(stderr, "Counting 20 interrupts at:");
+fflush(stderr);
+
+/* The frequencies 128Hz, 256Hz, ... 8192Hz are only allowed for root. */
+for (tmp=2; tmp<=64; tmp*=2) {
+
+	retval = ioctl(fd, RTC_IRQP_SET, tmp);
+	if (retval == -1) {
+		perror("ioctl");
+		exit(errno);
+	}
+
+	fprintf(stderr, "\n%ldHz:\t", tmp);
+	fflush(stderr);
+
+	/* Enable periodic interrupts */
+	retval = ioctl(fd, RTC_PIE_ON, 0);
+	if (retval == -1) {
+		perror("ioctl");
+		exit(errno);
+	}
+
+	for (i=1; i<21; i++) {
+		/* This blocks */
+		retval = read(fd, &data, sizeof(unsigned long));
+		if (retval == -1) {
+			perror("read");
+			exit(errno);
+		}
+		fprintf(stderr, " %d",i);
+		fflush(stderr);
+		irqcount++;
+	}
+
+	/* Disable periodic interrupts */
+	retval = ioctl(fd, RTC_PIE_OFF, 0);
+	if (retval == -1) {
+		perror("ioctl");
+		exit(errno);
+	}
+}
+
+fprintf(stderr, "\n\n\t\t\t *** Test complete ***\n");
+fprintf(stderr, "\nTyping \"cat /proc/interrupts\" will show %d more events on IRQ 8.\n\n",
+								 irqcount);
+
+close(fd);
+return 0;
+
+} /* end main */
--- linux-2617-rc4g9-docsrc-split.orig/Documentation/rtc.txt
+++ linux-2617-rc4g9-docsrc-split/Documentation/rtc.txt
@@ -63,220 +63,6 @@ how to use them, and demonstrates the fe
 probably a lot more useful to people interested in writing applications
 that will be using this driver.
 
-						Paul Gortmaker
-
--------------------- 8< ---------------- 8< -----------------------------
-
-/*
- *	Real Time Clock Driver Test/Example Program
- *
- *	Compile with:
- *		gcc -s -Wall -Wstrict-prototypes rtctest.c -o rtctest
- *
- *	Copyright (C) 1996, Paul Gortmaker.
- *
- *	Released under the GNU General Public License, version 2,
- *	included herein by reference.
- *
- */
-
-#include <stdio.h>
-#include <linux/rtc.h>
-#include <sys/ioctl.h>
-#include <sys/time.h>
-#include <sys/types.h>
-#include <fcntl.h>
-#include <unistd.h>
-#include <errno.h>
-
-int main(void) {
-
-int i, fd, retval, irqcount = 0;
-unsigned long tmp, data;
-struct rtc_time rtc_tm;
-
-fd = open ("/dev/rtc", O_RDONLY);
-
-if (fd ==  -1) {
-	perror("/dev/rtc");
-	exit(errno);
-}
-
-fprintf(stderr, "\n\t\t\tRTC Driver Test Example.\n\n");
-
-/* Turn on update interrupts (one per second) */
-retval = ioctl(fd, RTC_UIE_ON, 0);
-if (retval == -1) {
-	perror("ioctl");
-	exit(errno);
-}
-
-fprintf(stderr, "Counting 5 update (1/sec) interrupts from reading /dev/rtc:");
-fflush(stderr);
-for (i=1; i<6; i++) {
-	/* This read will block */
-	retval = read(fd, &data, sizeof(unsigned long));
-	if (retval == -1) {
-		perror("read");
-		exit(errno);
-	}
-	fprintf(stderr, " %d",i);
-	fflush(stderr);
-	irqcount++;
-}
-
-fprintf(stderr, "\nAgain, from using select(2) on /dev/rtc:");
-fflush(stderr);
-for (i=1; i<6; i++) {
-	struct timeval tv = {5, 0};	/* 5 second timeout on select */
-	fd_set readfds;
-
-	FD_ZERO(&readfds);
-	FD_SET(fd, &readfds);
-	/* The select will wait until an RTC interrupt happens. */
-	retval = select(fd+1, &readfds, NULL, NULL, &tv);
-	if (retval == -1) {
-		perror("select");
-		exit(errno);
-	}
-	/* This read won't block unlike the select-less case above. */
-	retval = read(fd, &data, sizeof(unsigned long));
-	if (retval == -1) {
-		perror("read");
-		exit(errno);
-	}
-	fprintf(stderr, " %d",i);
-	fflush(stderr);
-	irqcount++;
-}
-
-/* Turn off update interrupts */
-retval = ioctl(fd, RTC_UIE_OFF, 0);
-if (retval == -1) {
-	perror("ioctl");
-	exit(errno);
-}
-
-/* Read the RTC time/date */
-retval = ioctl(fd, RTC_RD_TIME, &rtc_tm);
-if (retval == -1) {
-	perror("ioctl");
-	exit(errno);
-}
-
-fprintf(stderr, "\n\nCurrent RTC date/time is %d-%d-%d, %02d:%02d:%02d.\n",
-	rtc_tm.tm_mday, rtc_tm.tm_mon + 1, rtc_tm.tm_year + 1900,
-	rtc_tm.tm_hour, rtc_tm.tm_min, rtc_tm.tm_sec);
-
-/* Set the alarm to 5 sec in the future, and check for rollover */
-rtc_tm.tm_sec += 5;
-if (rtc_tm.tm_sec >= 60) {
-	rtc_tm.tm_sec %= 60;
-	rtc_tm.tm_min++;
-}
-if  (rtc_tm.tm_min == 60) {
-	rtc_tm.tm_min = 0;
-	rtc_tm.tm_hour++;
-}
-if  (rtc_tm.tm_hour == 24)
-	rtc_tm.tm_hour = 0;
+See Documenation/rtc-test.c .
 
-retval = ioctl(fd, RTC_ALM_SET, &rtc_tm);
-if (retval == -1) {
-	perror("ioctl");
-	exit(errno);
-}
-
-/* Read the current alarm settings */
-retval = ioctl(fd, RTC_ALM_READ, &rtc_tm);
-if (retval == -1) {
-	perror("ioctl");
-	exit(errno);
-}
-
-fprintf(stderr, "Alarm time now set to %02d:%02d:%02d.\n",
-	rtc_tm.tm_hour, rtc_tm.tm_min, rtc_tm.tm_sec);
-
-/* Enable alarm interrupts */
-retval = ioctl(fd, RTC_AIE_ON, 0);
-if (retval == -1) {
-	perror("ioctl");
-	exit(errno);
-}
-
-fprintf(stderr, "Waiting 5 seconds for alarm...");
-fflush(stderr);
-/* This blocks until the alarm ring causes an interrupt */
-retval = read(fd, &data, sizeof(unsigned long));
-if (retval == -1) {
-	perror("read");
-	exit(errno);
-}
-irqcount++;
-fprintf(stderr, " okay. Alarm rang.\n");
-
-/* Disable alarm interrupts */
-retval = ioctl(fd, RTC_AIE_OFF, 0);
-if (retval == -1) {
-	perror("ioctl");
-	exit(errno);
-}
-
-/* Read periodic IRQ rate */
-retval = ioctl(fd, RTC_IRQP_READ, &tmp);
-if (retval == -1) {
-	perror("ioctl");
-	exit(errno);
-}
-fprintf(stderr, "\nPeriodic IRQ rate was %ldHz.\n", tmp);
-
-fprintf(stderr, "Counting 20 interrupts at:");
-fflush(stderr);
-
-/* The frequencies 128Hz, 256Hz, ... 8192Hz are only allowed for root. */
-for (tmp=2; tmp<=64; tmp*=2) {
-
-	retval = ioctl(fd, RTC_IRQP_SET, tmp);
-	if (retval == -1) {
-		perror("ioctl");
-		exit(errno);
-	}
-
-	fprintf(stderr, "\n%ldHz:\t", tmp);
-	fflush(stderr);
-
-	/* Enable periodic interrupts */
-	retval = ioctl(fd, RTC_PIE_ON, 0);
-	if (retval == -1) {
-		perror("ioctl");
-		exit(errno);
-	}
-
-	for (i=1; i<21; i++) {
-		/* This blocks */
-		retval = read(fd, &data, sizeof(unsigned long));
-		if (retval == -1) {
-			perror("read");
-			exit(errno);
-		}
-		fprintf(stderr, " %d",i);
-		fflush(stderr);
-		irqcount++;
-	}
-
-	/* Disable periodic interrupts */
-	retval = ioctl(fd, RTC_PIE_OFF, 0);
-	if (retval == -1) {
-		perror("ioctl");
-		exit(errno);
-	}
-}
-
-fprintf(stderr, "\n\n\t\t\t *** Test complete ***\n");
-fprintf(stderr, "\nTyping \"cat /proc/interrupts\" will show %d more events on IRQ 8.\n\n",
-								 irqcount);
-
-close(fd);
-return 0;
-
-} /* end main */
+						Paul Gortmaker


---
