Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265410AbSJXMZR>; Thu, 24 Oct 2002 08:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265412AbSJXMZR>; Thu, 24 Oct 2002 08:25:17 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:37828 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S265410AbSJXMZO>; Thu, 24 Oct 2002 08:25:14 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] 2.5.44 (2/2): Filesystem capabilities user tool
References: <87smz3mupw.fsf@goat.bogus.local>
From: Olaf Dietsche <olaf.dietsche@gmx.net>
Date: Thu, 24 Oct 2002 14:31:11 +0200
Message-ID: <87znt4vx0w.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de> writes:

> This is the change capabilities tool. It is a first cut at "managing"
> capabilities and not very comfortable.
>
> You need to tell where the .capabilities file is. This must be located
> in the mountpoint of the filesystem.
>
> Given a filename, how can I locate the mountpoint of the associated
> filesystem? If someone knows, how to do this, please tell me.

Thanks to Steve Baur, it's not necessary anymore to provide the
.capabilities file. Furthermore, chcap uses libcap now. This means,
you can give capabilities in cleartext.

Example:

# chmod u-s /bin/ping
# chcap cap_net_raw+ep /bin/ping

Regards, Olaf.

--- /dev/null	Thu Mar 21 19:31:20 2002
+++ chcap.c	Mon Oct 21 19:53:08 2002
@@ -0,0 +1,131 @@
+/*
+ * Copyright (c) 2002 Olaf Dietsche
+ *
+ * Filesystem capabilities for linux, user space tool.
+ *
+ * This tool uses libcap. Compile as:
+ * gcc -Wall -o chcap chcap.c -lcap
+ *
+ * usage: chcap capabilities file ...
+ * example: chcap cap_net_raw+ep /bin/ping
+ *
+ * Thanks to Steve Baur for the idea to locate_mountpoint().
+ */
+
+#include <asm/types.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/fcntl.h>
+#include <sys/capability.h>
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+static void fatal(const char *s)
+{
+	perror(s);
+	exit(1);
+}
+
+static char *locate_mountpoint(char *dir, const char *file)
+{
+	char *slash;
+	struct stat buf;
+	dev_t dev;
+	int err = stat(file, &buf);
+	if (err)
+		return NULL;
+
+	dev = buf.st_dev;
+	strcpy(dir, file);
+	do {
+		slash = strrchr(dir, '/');
+		*slash = 0;
+		err = stat(slash == dir ? "/" : dir, &buf);
+		if (err)
+			return NULL;
+	} while (buf.st_dev == dev && slash != dir);
+
+	*slash = '/';
+	if (buf.st_dev == dev)
+		dir[1] = 0;
+
+	return dir;
+}
+
+static int open_capabilities(const char *name)
+{
+	char file[PATH_MAX], mnt[PATH_MAX];
+	if (!realpath(name, file))
+		return -1;
+
+	if (!locate_mountpoint(mnt, file))
+		return -1;
+
+	strcat(mnt, "/.capabilities");
+	return open(mnt, O_CREAT | O_WRONLY, 0600);
+}
+
+static void chcap(const char *name, __u32 *caps)
+{
+	struct stat buf;
+	int fd = open_capabilities(name);
+	if (fd < 0) {
+		perror(name);
+		return;
+	}
+
+	if (access(name, W_OK) || stat(name, &buf)) {
+		perror(name);
+	} else {
+		off_t rc = lseek(fd, buf.st_ino * 3 * sizeof(*caps), SEEK_SET);
+		if (rc == -1)
+			perror(name);
+		else
+			write(fd, caps, 3 * sizeof(*caps));
+	}
+
+	close(fd);
+}
+
+static __u32 cap_to_u32(cap_t cap, cap_flag_t flag)
+{
+	__u32 c = 0;
+	int i;
+	for (i = 0; i <= 28; ++i) {
+		cap_flag_value_t on;
+		int err = cap_get_flag(cap, i, flag, &on);
+		if (err)
+			fatal("cap_to_u32()");
+
+		if (on)
+			c |= 1 << i;
+	}
+
+	return c;
+}
+
+int main(int argc, char **argv)
+{
+	cap_t cap;
+	__u32 caps[3];
+	int i;
+
+	if (argc < 3) {
+		fprintf(stderr, "usage: %s capabilities file ...\n", argv[0]);
+		exit(2);
+	}
+
+	cap = cap_from_text(argv[1]);
+	caps[0] = cap_to_u32(cap, CAP_EFFECTIVE);
+	caps[1] = cap_to_u32(cap, CAP_INHERITABLE);
+	caps[2] = cap_to_u32(cap, CAP_PERMITTED);
+
+	for (i = 2; i < argc; ++i) {
+		chcap(argv[i], caps);
+	}
+
+	return 0;
+}
