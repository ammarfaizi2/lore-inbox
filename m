Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265385AbSJRTGp>; Fri, 18 Oct 2002 15:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265379AbSJRTC0>; Fri, 18 Oct 2002 15:02:26 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:41169 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S265376AbSJRTB6>; Fri, 18 Oct 2002 15:01:58 -0400
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com, viro@math.psu.edu
Subject: [PATCH][RFC] 2.5.42 (2/2): Filesystem capabilities user tool
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Date: Fri, 18 Oct 2002 21:07:39 +0200
Message-ID: <87smz3mupw.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the change capabilities tool. It is a first cut at "managing"
capabilities and not very comfortable.

You need to tell where the .capabilities file is. This must be located
in the mountpoint of the filesystem.

Given a filename, how can I locate the mountpoint of the associated
filesystem? If someone knows, how to do this, please tell me.

Example:

# chmod u-s /bin/ping
# chcap /.capabilities 0x2000 0 0x2000 /bin/ping

This sets the effective and permitted CAP_NET_RAW capability for /bin/ping.

Regards, Olaf.

--- /dev/null	Thu Mar 21 19:31:20 2002
+++ chcap.c	Fri Oct 18 21:02:15 2002
@@ -0,0 +1,74 @@
+#include <asm/types.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/fcntl.h>
+#include <stdio.h>
+#include <unistd.h>
+
+static const char *capfile;
+static struct stat capbuf;
+
+static void chcap(ino_t ino, __u32 *caps)
+{
+	int fd = open(capfile, O_WRONLY);
+	if (fd < 0) {
+		perror(capfile);
+		exit(1);
+	} else {
+		off_t rc = lseek(fd, ino * 3 * sizeof(*caps), SEEK_SET);
+		if (rc == -1)
+			perror(capfile);
+		else
+			write(fd, caps, 3 * sizeof(*caps));
+
+		close(fd);
+	}
+}
+
+int main(int argc, char **argv)
+{
+	__u32 caps[3];
+	int rc;
+	int i = 1;
+
+	if (argc < 6) {
+		fprintf(stderr, "usage: %s /path/to/.capabilities eff inh perm file ...\n", argv[0]);
+		exit(2);
+	}
+
+	capfile = argv[i++];
+	rc = access(capfile, F_OK);
+	if (rc != 0) {
+		int fd = open(capfile, O_CREAT | O_EXCL | O_RDONLY, 0600);
+		if (fd >= 0) {
+			close(fd);
+		} else {
+			perror(capfile);
+			exit(1);
+		}
+	}
+
+	rc = stat(capfile, &capbuf);
+	if (rc != 0) {
+		perror(capfile);
+	}
+
+	caps[0] = strtol(argv[i++], 0, 0);
+	caps[1] = strtol(argv[i++], 0, 0);
+	caps[2] = strtol(argv[i++], 0, 0);
+
+	for (; i < argc; ++i) {
+		struct stat buf;
+		rc = stat(argv[i], &buf);
+		if (rc == 0) {
+			if (buf.st_dev == capbuf.st_dev)
+				chcap(buf.st_ino, caps);
+			else
+				fprintf(stderr, "%s: %s is on different file system\n", argv[i], capfile);
+		} else {
+			perror(argv[i]);
+		}
+	}
+
+	return 0;
+}
