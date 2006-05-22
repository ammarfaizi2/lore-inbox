Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbWEVDzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbWEVDzk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 23:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbWEVDzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 23:55:40 -0400
Received: from xenotime.net ([66.160.160.81]:55766 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751182AbWEVDzj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 23:55:39 -0400
Date: Sun, 21 May 2006 20:58:10 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, wim@iguana.be
Subject: [PATCH 1/14/] Doc. sources: expose watchdog
Message-Id: <20060521205810.64b631e2.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Documentation/watchdog/:
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
 Documentation/watchdog/pcwd-watchdog.txt |   73 -------------------------------
 Documentation/watchdog/watchdog-api.txt  |   17 -------
 Documentation/watchdog/watchdog-simple.c |   15 ++++++
 Documentation/watchdog/watchdog-test.c   |   68 ++++++++++++++++++++++++++++
 Documentation/watchdog/watchdog.txt      |   23 ---------
 5 files changed, 87 insertions(+), 109 deletions(-)

--- linux-2617-rc4g9-docsrc-split.orig/Documentation/watchdog/pcwd-watchdog.txt
+++ linux-2617-rc4g9-docsrc-split/Documentation/watchdog/pcwd-watchdog.txt
@@ -22,78 +22,9 @@
  to run the program with an "&" to run it in the background!)
 
  If you want to write a program to be compatible with the PC Watchdog
- driver, simply do the following:
+ driver, simply use of modify the watchdog test program:
+ Documentation/watchdog/watchdog-test.c
 
--- Snippet of code --
-/*
- * Watchdog Driver Test Program
- */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <sys/ioctl.h>
-#include <linux/types.h>
-#include <linux/watchdog.h>
-
-int fd;
-
-/*
- * This function simply sends an IOCTL to the driver, which in turn ticks
- * the PC Watchdog card to reset its internal timer so it doesn't trigger
- * a computer reset.
- */
-void keep_alive(void)
-{
-    int dummy;
-
-    ioctl(fd, WDIOC_KEEPALIVE, &dummy);
-}
-
-/*
- * The main program.  Run the program with "-d" to disable the card,
- * or "-e" to enable the card.
- */
-int main(int argc, char *argv[])
-{
-    fd = open("/dev/watchdog", O_WRONLY);
-
-    if (fd == -1) {
-	fprintf(stderr, "Watchdog device not enabled.\n");
-	fflush(stderr);
-	exit(-1);
-    }
-
-    if (argc > 1) {
-	if (!strncasecmp(argv[1], "-d", 2)) {
-	    ioctl(fd, WDIOC_SETOPTIONS, WDIOS_DISABLECARD);
-	    fprintf(stderr, "Watchdog card disabled.\n");
-	    fflush(stderr);
-	    exit(0);
-	} else if (!strncasecmp(argv[1], "-e", 2)) {
-	    ioctl(fd, WDIOC_SETOPTIONS, WDIOS_ENABLECARD);
-	    fprintf(stderr, "Watchdog card enabled.\n");
-	    fflush(stderr);
-	    exit(0);
-	} else {
-	    fprintf(stderr, "-d to disable, -e to enable.\n");
-	    fprintf(stderr, "run by itself to tick the card.\n");
-	    fflush(stderr);
-	    exit(0);
-	}
-    } else {
-	fprintf(stderr, "Watchdog Ticking Away!\n");
-	fflush(stderr);
-    }
-
-    while(1) {
-	keep_alive();
-	sleep(1);
-    }
-}
--- End snippet --
 
  Other IOCTL functions include:
 
--- linux-2617-rc4g9-docsrc-split.orig/Documentation/watchdog/watchdog-api.txt
+++ linux-2617-rc4g9-docsrc-split/Documentation/watchdog/watchdog-api.txt
@@ -34,22 +34,7 @@ activates as soon as /dev/watchdog is op
 the watchdog is pinged within a certain time, this time is called the
 timeout or margin.  The simplest way to ping the watchdog is to write
 some data to the device.  So a very simple watchdog daemon would look
-like this:
-
-#include <stdlib.h>
-#include <fcntl.h>
-
-int main(int argc, const char *argv[]) {
-	int fd=open("/dev/watchdog",O_WRONLY);
-	if (fd==-1) {
-		perror("watchdog");
-		exit(1);
-	}
-	while(1) {
-		write(fd, "\0", 1);
-		sleep(10);
-	}
-}
+like this source file:  see Documentation/watchdog/watchdog-simple.c
 
 A more advanced driver could for example check that a HTTP server is
 still responding before doing the write call to ping the watchdog.
--- /dev/null
+++ linux-2617-rc4g9-docsrc-split/Documentation/watchdog/watchdog-simple.c
@@ -0,0 +1,15 @@
+#include <stdlib.h>
+#include <fcntl.h>
+
+int main(int argc, const char *argv[]) {
+	int fd = open("/dev/watchdog", O_WRONLY);
+	if (fd == -1) {
+		perror("watchdog");
+		exit(1);
+	}
+	while (1) {
+		write(fd, "\0", 1);
+		fsync(fd);
+		sleep(10);
+	}
+}
--- /dev/null
+++ linux-2617-rc4g9-docsrc-split/Documentation/watchdog/watchdog-test.c
@@ -0,0 +1,68 @@
+/*
+ * Watchdog Driver Test Program
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <sys/ioctl.h>
+#include <linux/types.h>
+#include <linux/watchdog.h>
+
+int fd;
+
+/*
+ * This function simply sends an IOCTL to the driver, which in turn ticks
+ * the PC Watchdog card to reset its internal timer so it doesn't trigger
+ * a computer reset.
+ */
+void keep_alive(void)
+{
+    int dummy;
+
+    ioctl(fd, WDIOC_KEEPALIVE, &dummy);
+}
+
+/*
+ * The main program.  Run the program with "-d" to disable the card,
+ * or "-e" to enable the card.
+ */
+int main(int argc, char *argv[])
+{
+    fd = open("/dev/watchdog", O_WRONLY);
+
+    if (fd == -1) {
+	fprintf(stderr, "Watchdog device not enabled.\n");
+	fflush(stderr);
+	exit(-1);
+    }
+
+    if (argc > 1) {
+	if (!strncasecmp(argv[1], "-d", 2)) {
+	    ioctl(fd, WDIOC_SETOPTIONS, WDIOS_DISABLECARD);
+	    fprintf(stderr, "Watchdog card disabled.\n");
+	    fflush(stderr);
+	    exit(0);
+	} else if (!strncasecmp(argv[1], "-e", 2)) {
+	    ioctl(fd, WDIOC_SETOPTIONS, WDIOS_ENABLECARD);
+	    fprintf(stderr, "Watchdog card enabled.\n");
+	    fflush(stderr);
+	    exit(0);
+	} else {
+	    fprintf(stderr, "-d to disable, -e to enable.\n");
+	    fprintf(stderr, "run by itself to tick the card.\n");
+	    fflush(stderr);
+	    exit(0);
+	}
+    } else {
+	fprintf(stderr, "Watchdog Ticking Away!\n");
+	fflush(stderr);
+    }
+
+    while(1) {
+	keep_alive();
+	sleep(1);
+    }
+}
--- linux-2617-rc4g9-docsrc-split.orig/Documentation/watchdog/watchdog.txt
+++ linux-2617-rc4g9-docsrc-split/Documentation/watchdog/watchdog.txt
@@ -65,28 +65,7 @@ The external event interfaces on the WDT
 Minor numbers are however allocated for it.
 
 
-Example Watchdog Driver
------------------------
-
-#include <stdio.h>
-#include <unistd.h>
-#include <fcntl.h>
-
-int main(int argc, const char *argv[])
-{
-	int fd=open("/dev/watchdog",O_WRONLY);
-	if(fd==-1)
-	{
-		perror("watchdog");
-		exit(1);
-	}
-	while(1)
-	{
-		write(fd,"\0",1);
-		fsync(fd);
-		sleep(10);
-	}
-}
+Example Watchdog Driver:  see Documentation/watchdog/watchdog-simple.c
 
 
 Contact Information


---
