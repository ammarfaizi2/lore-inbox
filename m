Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264502AbTLVVuM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 16:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264508AbTLVVuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 16:50:12 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:25015 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S264502AbTLVVt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 16:49:59 -0500
Date: Mon, 22 Dec 2003 22:49:52 +0100
From: Christophe Saout <christophe@saout.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Fruhwirth Clemens <clemens@endorphin.org>,
       Joe Thornber <thornber@sistina.com>
Subject: [PATCH 1/2] Add dm-daemon
Message-ID: <20031222214952.GA13103@leto.cs.pocnet.net>
References: <1072129379.5570.73.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1072129379.5570.73.camel@leto.cs.pocnet.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The first patch adds dm-daemon.c/.h.

The code is from Joe Thornbers current unstable device-mapper patchset.


diff -Nur linux-2.6.0/drivers/md/dm-daemon.c linux-2.6.0~dm-daemon/drivers/md/dm-daemon.c
--- linux-2.6.0/drivers/md/dm-daemon.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0~dm-daemon/drivers/md/dm-daemon.c	2003-12-22 13:16:55.000000000 +0100
@@ -0,0 +1,103 @@
+/*
+ * Copyright (C) 2003 Sistina Software
+ *
+ * This file is released under the LGPL.
+ */
+
+#include "dm.h"
+#include "dm-daemon.h"
+
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/suspend.h>
+#include <linux/completion.h>
+
+static int daemon(void *arg)
+{
+	struct dm_daemon *dd = (struct dm_daemon *) arg;
+	DECLARE_WAITQUEUE(wq, current);
+
+	daemonize("%s", dd->name);
+
+	atomic_set(&dd->please_die, 0);
+
+	add_wait_queue(&dd->job_queue, &wq);
+
+	complete(&dd->start);
+
+	/*
+	 * dd->fn() could do anything, very likely it will
+	 * suspend.  So we can't set the state to
+	 * TASK_INTERRUPTIBLE before calling it.  In order to
+	 * prevent a race with a waking thread we do this little
+	 * dance with the dd->woken variable.
+	 */
+	while (1) {
+		if (atomic_read(&dd->please_die))
+			goto out;
+
+		if (current->flags & PF_FREEZE)
+			refrigerator(PF_IOTHREAD);
+
+		do {
+			set_current_state(TASK_RUNNING);
+			atomic_set(&dd->woken, 0);
+			dd->fn();
+			set_current_state(TASK_INTERRUPTIBLE);
+
+		} while (atomic_read(&dd->woken));
+
+		schedule();
+	}
+
+ out:
+	remove_wait_queue(&dd->job_queue, &wq);
+	complete_and_exit(&dd->run, 0);
+}
+
+int dm_daemon_start(struct dm_daemon *dd, const char *name, jiffy_t (*fn)(void))
+{
+	pid_t pid = 0;
+
+	/*
+	 * Initialise the dm_daemon.
+	 */
+	dd->fn = fn;
+	strncpy(dd->name, name, sizeof(dd->name) - 1);
+	init_completion(&dd->start);
+	init_completion(&dd->run);
+	init_waitqueue_head(&dd->job_queue);
+
+	/*
+	 * Start the new thread.
+	 */
+	pid = kernel_thread(daemon, dd, CLONE_KERNEL);
+	if (pid <= 0) {
+		DMERR("Failed to start %s thread", name);
+		return -EAGAIN;
+	}
+
+	/*
+	 * wait for the daemon to up this mutex.
+	 */
+	wait_for_completion(&dd->start);
+
+	return 0;
+}
+
+void dm_daemon_stop(struct dm_daemon *dd)
+{
+	atomic_set(&dd->please_die, 1);
+	dm_daemon_wake(dd);
+	wait_for_completion(&dd->run);
+}
+
+void dm_daemon_wake(struct dm_daemon *dd)
+{
+	atomic_set(&dd->woken, 1);
+	wake_up_interruptible(&dd->job_queue);
+}
+
+EXPORT_SYMBOL(dm_daemon_start);
+EXPORT_SYMBOL(dm_daemon_stop);
+EXPORT_SYMBOL(dm_daemon_wake);
diff -Nur linux-2.6.0/drivers/md/dm-daemon.h linux-2.6.0~dm-daemon/drivers/md/dm-daemon.h
--- linux-2.6.0/drivers/md/dm-daemon.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0~dm-daemon/drivers/md/dm-daemon.h	2003-12-22 13:16:56.000000000 +0100
@@ -0,0 +1,33 @@
+/*
+ * Copyright (C) 2003 Sistina Software
+ *
+ * This file is released under the LGPL.
+ */
+
+#ifndef DM_DAEMON_H
+#define DM_DAEMON_H
+
+#include <asm/atomic.h>
+#include <linux/completion.h>
+
+/*
+ * The daemons work function returns a *hint* as to when it
+ * should next be woken up.
+ */
+struct dm_daemon {
+	jiffy_t (*fn)(void);
+	char name[16];
+	atomic_t please_die;
+	struct completion start;
+	struct completion run;
+
+	atomic_t woken;
+	wait_queue_head_t job_queue;
+};
+
+int dm_daemon_start(struct dm_daemon *dd, const char *name, jiffy_t (*fn)(void));
+void dm_daemon_stop(struct dm_daemon *dd);
+void dm_daemon_wake(struct dm_daemon *dd);
+int dm_daemon_running(struct dm_daemon *dd);
+
+#endif
diff -Nur linux-2.6.0/drivers/md/Makefile linux-2.6.0~dm-daemon/drivers/md/Makefile
--- linux-2.6.0/drivers/md/Makefile	2003-11-24 02:32:03.000000000 +0100
+++ linux-2.6.0~dm-daemon/drivers/md/Makefile	2003-12-22 13:17:35.000000000 +0100
@@ -3,7 +3,7 @@
 #
 
 dm-mod-objs	:= dm.o dm-table.o dm-target.o dm-linear.o dm-stripe.o \
-		   dm-ioctl.o
+		   dm-ioctl.o dm-daemon.o
 
 # Note: link order is important.  All raid personalities
 # and xor.o must come before md.o, as they each initialise 
diff -Nur linux-2.6.0.orig/drivers/md/dm.h linux-2.6.0/drivers/md/dm.h
--- linux-2.6.0.orig/drivers/md/dm.h	2003-11-24 02:31:53.000000000 +0100
+++ linux-2.6.0/drivers/md/dm.h	2003-12-22 17:56:05.000000000 +0100
@@ -20,6 +20,12 @@
 #define DMINFO(f, x...) printk(KERN_INFO DM_NAME ": " f "\n" , ## x)
 
 /*
+ * FIXME: There must be a better place for this.
+ */
+typedef typeof(jiffies) jiffy_t;
+
+
+/*
  * FIXME: I think this should be with the definition of sector_t
  * in types.h.
  */

