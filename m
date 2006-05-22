Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751558AbWEVD4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbWEVD4v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 23:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751564AbWEVD41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 23:56:27 -0400
Received: from xenotime.net ([66.160.160.81]:5079 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751195AbWEVD4X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 23:56:23 -0400
Date: Sun, 21 May 2006 20:57:37 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, axboe@suse.de
Subject: [PATCH 4/14/] Doc. sources: expose block/
Message-Id: <20060521205737.939aff71.rdunlap@xenotime.net>
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

Documentation/block/:
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
 Documentation/block/ionice.c   |  110 ++++++++++++++++++++++++++++++++++++++
 Documentation/block/ioprio.txt |  117 -----------------------------------------
 2 files changed, 111 insertions(+), 116 deletions(-)

--- /dev/null
+++ linux-2617-rc4g9-docsrc-split/Documentation/block/ionice.c
@@ -0,0 +1,110 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <getopt.h>
+#include <unistd.h>
+#include <sys/ptrace.h>
+#include <asm/unistd.h>
+
+extern int sys_ioprio_set(int, int, int);
+extern int sys_ioprio_get(int, int);
+
+#if defined(__i386__)
+#define __NR_ioprio_set		289
+#define __NR_ioprio_get		290
+#elif defined(__ppc__)
+#define __NR_ioprio_set		273
+#define __NR_ioprio_get		274
+#elif defined(__x86_64__)
+#define __NR_ioprio_set		251
+#define __NR_ioprio_get		252
+#elif defined(__ia64__)
+#define __NR_ioprio_set		1274
+#define __NR_ioprio_get		1275
+#else
+#error "Unsupported arch"
+#endif
+
+_syscall3(int, ioprio_set, int, which, int, who, int, ioprio);
+_syscall2(int, ioprio_get, int, which, int, who);
+
+enum {
+	IOPRIO_CLASS_NONE,
+	IOPRIO_CLASS_RT,
+	IOPRIO_CLASS_BE,
+	IOPRIO_CLASS_IDLE,
+};
+
+enum {
+	IOPRIO_WHO_PROCESS = 1,
+	IOPRIO_WHO_PGRP,
+	IOPRIO_WHO_USER,
+};
+
+#define IOPRIO_CLASS_SHIFT	13
+
+const char *to_prio[] = { "none", "realtime", "best-effort", "idle", };
+
+int main(int argc, char *argv[])
+{
+	int ioprio = 4, set = 0, ioprio_class = IOPRIO_CLASS_BE;
+	int c, pid = 0;
+
+	while ((c = getopt(argc, argv, "+n:c:p:")) != EOF) {
+		switch (c) {
+		case 'n':
+			ioprio = strtol(optarg, NULL, 10);
+			set = 1;
+			break;
+		case 'c':
+			ioprio_class = strtol(optarg, NULL, 10);
+			set = 1;
+			break;
+		case 'p':
+			pid = strtol(optarg, NULL, 10);
+			break;
+		}
+	}
+
+	switch (ioprio_class) {
+		case IOPRIO_CLASS_NONE:
+			ioprio_class = IOPRIO_CLASS_BE;
+			break;
+		case IOPRIO_CLASS_RT:
+		case IOPRIO_CLASS_BE:
+			break;
+		case IOPRIO_CLASS_IDLE:
+			ioprio = 7;
+			break;
+		default:
+			printf("bad prio class %d\n", ioprio_class);
+			return 1;
+	}
+
+	if (!set) {
+		if (!pid && argv[optind])
+			pid = strtol(argv[optind], NULL, 10);
+
+		ioprio = ioprio_get(IOPRIO_WHO_PROCESS, pid);
+
+		printf("pid=%d, %d\n", pid, ioprio);
+
+		if (ioprio == -1)
+			perror("ioprio_get");
+		else {
+			ioprio_class = ioprio >> IOPRIO_CLASS_SHIFT;
+			ioprio = ioprio & 0xff;
+			printf("%s: prio %d\n", to_prio[ioprio_class], ioprio);
+		}
+	} else {
+		if (ioprio_set(IOPRIO_WHO_PROCESS, pid, ioprio | ioprio_class << IOPRIO_CLASS_SHIFT) == -1) {
+			perror("ioprio_set");
+			return 1;
+		}
+
+		if (argv[optind])
+			execvp(argv[optind], &argv[optind]);
+	}
+
+	return 0;
+}
--- linux-2617-rc4g9-docsrc-split.orig/Documentation/block/ioprio.txt
+++ linux-2617-rc4g9-docsrc-split/Documentation/block/ioprio.txt
@@ -40,7 +40,7 @@ class data, since it doesn't really appl
 Tools
 -----
 
-See below for a sample ionice tool. Usage:
+See Documentation/block/ionice.c for a sample ionice tool.  Usage:
 
 # ionice -c<class> -n<level> -p<pid>
 
@@ -57,120 +57,5 @@ For a running process, you can give the 
 
 will change pid 100 to run at the realtime scheduling class, at priority 2.
 
----> snip ionice.c tool <---
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <errno.h>
-#include <getopt.h>
-#include <unistd.h>
-#include <sys/ptrace.h>
-#include <asm/unistd.h>
-
-extern int sys_ioprio_set(int, int, int);
-extern int sys_ioprio_get(int, int);
-
-#if defined(__i386__)
-#define __NR_ioprio_set		289
-#define __NR_ioprio_get		290
-#elif defined(__ppc__)
-#define __NR_ioprio_set		273
-#define __NR_ioprio_get		274
-#elif defined(__x86_64__)
-#define __NR_ioprio_set		251
-#define __NR_ioprio_get		252
-#elif defined(__ia64__)
-#define __NR_ioprio_set		1274
-#define __NR_ioprio_get		1275
-#else
-#error "Unsupported arch"
-#endif
-
-_syscall3(int, ioprio_set, int, which, int, who, int, ioprio);
-_syscall2(int, ioprio_get, int, which, int, who);
-
-enum {
-	IOPRIO_CLASS_NONE,
-	IOPRIO_CLASS_RT,
-	IOPRIO_CLASS_BE,
-	IOPRIO_CLASS_IDLE,
-};
-
-enum {
-	IOPRIO_WHO_PROCESS = 1,
-	IOPRIO_WHO_PGRP,
-	IOPRIO_WHO_USER,
-};
-
-#define IOPRIO_CLASS_SHIFT	13
-
-const char *to_prio[] = { "none", "realtime", "best-effort", "idle", };
-
-int main(int argc, char *argv[])
-{
-	int ioprio = 4, set = 0, ioprio_class = IOPRIO_CLASS_BE;
-	int c, pid = 0;
-
-	while ((c = getopt(argc, argv, "+n:c:p:")) != EOF) {
-		switch (c) {
-		case 'n':
-			ioprio = strtol(optarg, NULL, 10);
-			set = 1;
-			break;
-		case 'c':
-			ioprio_class = strtol(optarg, NULL, 10);
-			set = 1;
-			break;
-		case 'p':
-			pid = strtol(optarg, NULL, 10);
-			break;
-		}
-	}
-
-	switch (ioprio_class) {
-		case IOPRIO_CLASS_NONE:
-			ioprio_class = IOPRIO_CLASS_BE;
-			break;
-		case IOPRIO_CLASS_RT:
-		case IOPRIO_CLASS_BE:
-			break;
-		case IOPRIO_CLASS_IDLE:
-			ioprio = 7;
-			break;
-		default:
-			printf("bad prio class %d\n", ioprio_class);
-			return 1;
-	}
-
-	if (!set) {
-		if (!pid && argv[optind])
-			pid = strtol(argv[optind], NULL, 10);
-
-		ioprio = ioprio_get(IOPRIO_WHO_PROCESS, pid);
-
-		printf("pid=%d, %d\n", pid, ioprio);
-
-		if (ioprio == -1)
-			perror("ioprio_get");
-		else {
-			ioprio_class = ioprio >> IOPRIO_CLASS_SHIFT;
-			ioprio = ioprio & 0xff;
-			printf("%s: prio %d\n", to_prio[ioprio_class], ioprio);
-		}
-	} else {
-		if (ioprio_set(IOPRIO_WHO_PROCESS, pid, ioprio | ioprio_class << IOPRIO_CLASS_SHIFT) == -1) {
-			perror("ioprio_set");
-			return 1;
-		}
-
-		if (argv[optind])
-			execvp(argv[optind], &argv[optind]);
-	}
-
-	return 0;
-}
-
----> snip ionice.c tool <---
-
 
 March 11 2005, Jens Axboe <axboe@suse.de>


---
