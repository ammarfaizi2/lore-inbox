Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270623AbTHAA1r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 20:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270625AbTHAA1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 20:27:47 -0400
Received: from smtp4.wanadoo.fr ([193.252.22.26]:49568 "EHLO
	mwinf0502.wanadoo.fr") by vger.kernel.org with ESMTP
	id S270623AbTHAA1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 20:27:44 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="DmntQB4pgf"
Content-Transfer-Encoding: 7bit
Date: Fri, 1 Aug 2003 02:29:10 +0200
From: Pascal Brisset <pascal.brisset-ml@wanadoo.fr>
To: linux-kernel@vger.kernel.org, swsusp-devel@lists.sourceforge.net
Subject: [PATCH] Allow initrd_load() before software_resume()
Message-Id: <20030801002742.1033FE8003AE@mwinf0502.wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DmntQB4pgf
Content-Type: text/plain; charset=us-ascii
Content-Description: message body text
Content-Transfer-Encoding: 7bit

This patch adds a boot parameter "resume_initrd".
If present, init will load the initrd before trying to resume.

This makes it posssible to resume from an encrypted suspend image.
The initrd should insmod cryptoloop.o or loop-AES.o and perform
losetup -e so that resume=/dev/loopX makes sense.
Note: software_resume() should not be allowed to complete if
initrd has altered disks (e.g. by flushing journals).

/initrd
|-- bin
|   |-- ash
|   |-- insmod
|   `-- losetup
|-- dev
|   |-- console
|   |-- hdaX
|   |-- loopX
|   |-- null
|   `-- tty
|-- linuxrc
|-- loop.o
`-- lost+found

Resuming works, but suspension seems to fail more frequently when
the swap is encrypted. I am using loop-AES-v1.7d + patch for 2.6.

Is it safe to suspend to loop devices ?

-- Pascal


--DmntQB4pgf
Content-Type: text/plain
Content-Disposition: inline;
	filename="resume_initrd.diff"
Content-Transfer-Encoding: 7bit

diff -ur linux-2.6.0-test1.orig/Documentation/kernel-parameters.txt linux-2.6.0-test1/Documentation/kernel-parameters.txt
--- linux-2.6.0-test1.orig/Documentation/kernel-parameters.txt	2003-07-14 05:39:36.000000000 +0200
+++ linux-2.6.0-test1/Documentation/kernel-parameters.txt	2003-08-01 01:19:46.000000000 +0200
@@ -816,6 +816,8 @@
 
 	resume=		[SWSUSP] Specify the partition device for software suspension
 
+	resume_initrd   [SWSUSP] Run initrd before resuming from software suspension
+
 	riscom8=	[HW,SERIAL]
 			Format: <io_board1>[,<io_board2>[,...<io_boardN>]]
 
diff -ur linux-2.6.0-test1.orig/init/do_mounts.c linux-2.6.0-test1/init/do_mounts.c
--- linux-2.6.0-test1.orig/init/do_mounts.c	2003-07-14 05:32:44.000000000 +0200
+++ linux-2.6.0-test1/init/do_mounts.c	2003-08-01 01:21:44.000000000 +0200
@@ -49,6 +49,15 @@
 __setup("ro", readonly);
 __setup("rw", readwrite);
 
+static int resume_initrd = 0;
+static int __init set_resume_initrd(char *str)
+{
+	resume_initrd = 1;
+	return 1;
+}
+
+__setup("resume_initrd", set_resume_initrd);
+
 static dev_t __init try_name(char *name, int part)
 {
 	char path[64];
@@ -365,12 +374,21 @@
 
 	is_floppy = MAJOR(ROOT_DEV) == FLOPPY_MAJOR;
 
-	/* This has to be before mounting root, because even readonly mount of reiserfs would replay
-	   log corrupting stuff */
-	software_resume();
+	/* software_resume() has to be before mounting root, because even
+	   readonly mount of reiserfs would replay log corrupting stuff.
+	   However, users may still want to run initrd first. */
+	if (resume_initrd) {
+		if (initrd_load()) {
+			software_resume();
+			goto out;
+		}
+	}
+	else {
+		software_resume();
 
-	if (initrd_load())
-		goto out;
+		if (initrd_load())
+			goto out;
+	}
 
 	if (is_floppy && rd_doload && rd_load_disk(0))
 		ROOT_DEV = Root_RAM0;

--DmntQB4pgf--

