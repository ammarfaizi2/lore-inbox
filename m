Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261664AbSJ1W4j>; Mon, 28 Oct 2002 17:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261665AbSJ1W4j>; Mon, 28 Oct 2002 17:56:39 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:13777 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261664AbSJ1W4g>; Mon, 28 Oct 2002 17:56:36 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH][RFC] 2.5.44 (2/2): Filesystem capabilities user tool
 (inhcaps)
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Date: Tue, 29 Oct 2002 00:02:52 +0100
Message-ID: <87n0oynp43.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This tool allows changing uid and inheriting capabilities across an
exec, thus restricting the privileges a system daemon is running with.
This is similar to sucap and execcap, which come with libcap, but is
designed to work with fs capability support.

You can use it in system startup scripts, for example:

# chcap cap_net_bind_service=ei /usr/sbin/sendmail

This sets the effective and inheritable capabilities of sendmail.

# inhcaps cap_net_bind_service=i mail:mail /usr/sbin/sendmail

This sets the inheritable set to CAP_NET_BIND_SERVICE, which is needed
in order to bind to port 25, and runs sendmail as user mail with group
mail.

This allows running sendmail with needed restricted privileges, if the
parent process (root) owns them already. When started by regular
users, sendmail runs without any privileges.

Regards, Olaf.

--- /dev/null	Thu Mar 21 19:31:20 2002
+++ inhcaps.c	Mon Oct 28 17:51:27 2002
@@ -0,0 +1,107 @@
+/*
+ * Copyright (c) 2002 Olaf Dietsche
+ *
+ * Filesystem capabilities for linux, user space tool.
+ *
+ * This tool uses libcap. Compile as:
+ * gcc -Wall -o inhcaps incaps.c -lcap
+ *
+ * usage: inhcaps capabilities uid[:gid] program [args]
+ * example:
+ * # chcap cap_net_bind_service=ei /usr/sbin/sendmail
+ * # inhcaps cap_net_bind_service=i smmta:mail /usr/sbin/sendmail
+ * 
+ */
+
+#include <sys/capability.h>
+#include <sys/prctl.h>
+#include <pwd.h>
+#include <grp.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+static void usage(char **argv)
+{
+	fprintf(stderr, "usage: %s capabilities uid[:gid] program [args]\n", argv[0]);
+	exit(1);
+}
+
+static void fatal(const char *msg)
+{
+	perror(msg);
+	exit(1);
+}
+
+static void changecaps(const char *capstxt)
+{
+	static cap_value_t needed[] = { CAP_SETGID, CAP_SETUID };
+	cap_t caps;
+	caps = cap_from_text(capstxt);
+	if (!caps)
+		fatal("Unable to create capability set");
+
+	cap_set_flag(caps, CAP_EFFECTIVE, 2, needed, CAP_SET);
+	cap_set_flag(caps, CAP_PERMITTED, 2, needed, CAP_SET);
+	if (cap_set_proc(caps))
+		fatal("Unable to set capabilities");
+
+	cap_free(caps);
+	
+	if (prctl(PR_SET_KEEPCAPS, 1))
+		fatal("Unable to keep capabilities");
+}
+
+static void changeuid(const char *userspec)
+{
+	char *user, *grp, *endp;
+	int uid = -1, gid = -1;
+	user = strdup(userspec);
+	user = strtok(user, ":");
+	grp = strtok(NULL, ":");
+	if (grp) {
+		gid = strtol(grp, &endp, 0);
+		if (*endp != 0) {
+			struct group *g = getgrnam(grp);
+			if (!g)
+				fatal(grp);
+
+			gid = g->gr_gid;
+		}
+	}
+	
+	uid = strtol(user, &endp, 0);
+	if (*endp != 0) {
+		struct passwd *pw = getpwnam(user);
+		if (!pw)
+			fatal(user);
+
+		uid = pw->pw_uid;
+		if (grp == NULL)
+			gid = pw->pw_gid;
+	}
+
+	if (gid >= 0) {
+		if (setgid(gid))
+			fatal("setgid");
+
+		if (initgroups(user, gid))
+			fatal("initgroups");
+	}
+
+	if (setuid(uid))
+		fatal("setuid");
+}
+
+int main(int argc, char **argv)
+{
+	if (argc < 3)
+		usage(argv);
+
+	changecaps(argv[1]);
+	changeuid(argv[2]);
+
+	execvp(argv[3], argv + 3);
+	perror(argv[3]);
+	return 1;
+}
