Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263963AbUAaIap (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 03:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263983AbUAaIap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 03:30:45 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:40129 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S263963AbUAaIaj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 03:30:39 -0500
Date: Sat, 31 Jan 2004 21:32:05 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: [Swsusp-devel] Software Suspend 2.0
In-reply-to: <20040131073848.GE7245@digitasaru.net>
To: trelane@digitasaru.net
Cc: Luke-Jr <luke7jr@yahoo.com>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1075537924.17730.88.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: multipart/mixed; boundary="=-hHR3Vdx3CCv3vfsBOaG8"
References: <1075436665.2086.3.camel@laptop-linux>
 <200401310622.17530.luke7jr@yahoo.com>
 <1075531042.18161.35.camel@laptop-linux>
 <20040131064757.GB7245@digitasaru.net>
 <1075532166.17727.41.camel@laptop-linux>
 <20040131071619.GD7245@digitasaru.net>
 <1075534088.18161.61.camel@laptop-linux> <20040131073848.GE7245@digitasaru.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hHR3Vdx3CCv3vfsBOaG8
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Okay. Attached is a patch that will let you use Software Suspend 2.0
with linux-2.6.2-rc3.

How to apply:

Get the latest 2.6.1 patch (revision 7) and latest core patch (2.0) from
http://swsusp.sf.net.

Apply the 2.6.1 patch to your rc3 kernel. You'll get some rejects; don't
worry about them. Apply the attached patch. It fixes up the rejects. Now
apply the core patch. Then configure and compile as per normal.

Regards,

Nigel
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

--=-hHR3Vdx3CCv3vfsBOaG8
Content-Disposition: attachment; filename=2.6.2-rc3-rejects-patch
Content-Type: text/x-patch; name=2.6.2-rc3-rejects-patch; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

diff -ruN software-suspend-linux-2.6.2-rc3-261patch7/drivers/media/video/msp3400.c software-suspend-linux-2.6.2-rc3/drivers/media/video/msp3400.c
--- software-suspend-linux-2.6.2-rc3-261patch7/drivers/media/video/msp3400.c	2004-01-31 21:27:04.000000000 +1300
+++ software-suspend-linux-2.6.2-rc3/drivers/media/video/msp3400.c	2004-01-31 21:22:50.000000000 +1300
@@ -808,7 +808,9 @@
 
 		/* some time for the tuner to sync */
 		set_current_state(TASK_INTERRUPTIBLE);
+		SWSUSP_ACTIVITY_PAUSING;
 		schedule_timeout(HZ/5);
+		SWSUSP_ACTIVITY_RESTARTING(PF_SYNCTHREAD);
 		if (signal_pending(current))
 			goto done;
 		
@@ -843,7 +845,9 @@
 			msp3400c_setcarrier(client, cd[this].cdo,cd[this].cdo);
 
 			set_current_state(TASK_INTERRUPTIBLE);
+			SWSUSP_ACTIVITY_PAUSING;
 			schedule_timeout(HZ/10);
+			SWSUSP_ACTIVITY_RESTARTING(PF_SYNCTHREAD);
 			if (signal_pending(current))
 				goto done;
 			if (msp->restart)
@@ -879,7 +883,9 @@
 		for (this = 0; this < count; this++) {
 			msp3400c_setcarrier(client, cd[this].cdo,cd[this].cdo);
 
+			SWSUSP_ACTIVITY_PAUSING;
 			set_current_state(TASK_INTERRUPTIBLE);
+			SWSUSP_ACTIVITY_RESTARTING(PF_SYNCTHREAD);
 			schedule_timeout(HZ/10);
 			if (signal_pending(current))
 				goto done;
diff -ruN software-suspend-linux-2.6.2-rc3-261patch7/fs/jffs/intrep.c software-suspend-linux-2.6.2-rc3/fs/jffs/intrep.c
--- software-suspend-linux-2.6.2-rc3-261patch7/fs/jffs/intrep.c	2004-01-31 21:27:05.000000000 +1300
+++ software-suspend-linux-2.6.2-rc3/fs/jffs/intrep.c	2004-01-31 21:22:51.000000000 +1300
@@ -3346,6 +3346,9 @@
 	DECLARE_SWSUSP_LOCAL_VAR;
 
 	daemonize("jffs_gcd");
+	current->flags |= PF_SYNCTHREAD;
+
+	SWSUSP_THREAD_FLAGS_RESET;
 
 	c->gc_task = current;
 
diff -ruN software-suspend-linux-2.6.2-rc3-261patch7/fs/stat.c software-suspend-linux-2.6.2-rc3/fs/stat.c
--- software-suspend-linux-2.6.2-rc3-261patch7/fs/stat.c	2004-01-31 21:27:05.000000000 +1300
+++ software-suspend-linux-2.6.2-rc3/fs/stat.c	2004-01-31 21:22:51.000000000 +1300
@@ -353,30 +353,42 @@
 {
 	struct kstat stat;
 	int error = vfs_stat(filename, &stat);
+	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(0);
 
 	if (!error)
 		error = cp_new_stat64(&stat, statbuf);
 
+	SWSUSP_ACTIVITY_END;
 	return error;
 }
 asmlinkage long sys_lstat64(char __user * filename, struct stat64 __user * statbuf)
 {
 	struct kstat stat;
 	int error = vfs_lstat(filename, &stat);
+	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(0);
 
 	if (!error)
 		error = cp_new_stat64(&stat, statbuf);
 
+	SWSUSP_ACTIVITY_END;
 	return error;
 }
 asmlinkage long sys_fstat64(unsigned long fd, struct stat64 __user * statbuf)
 {
 	struct kstat stat;
 	int error = vfs_fstat(fd, &stat);
+	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(0);
 
 	if (!error)
 		error = cp_new_stat64(&stat, statbuf);
 
+	SWSUSP_ACTIVITY_END;
 	return error;
 }
 
diff -ruN software-suspend-linux-2.6.2-rc3-261patch7/fs/xfs/linux/xfs_buf.c software-suspend-linux-2.6.2-rc3/fs/xfs/linux/xfs_buf.c
--- software-suspend-linux-2.6.2-rc3-261patch7/fs/xfs/linux/xfs_buf.c	2004-01-31 21:11:54.000000000 +1300
+++ software-suspend-linux-2.6.2-rc3/fs/xfs/linux/xfs_buf.c	2004-01-31 21:24:28.000000000 +1300
@@ -1709,10 +1709,14 @@
 	int			count;
 	page_buf_t		*pb;
 	struct list_head	*curr, *next, tmp;
+	DECLARE_SWSUSP_LOCAL_VAR;
 
 	/*  Set up the thread  */
 	daemonize("pagebufd");
-	current->flags |= PF_MEMALLOC;
+	current->flags |= PF_MEMALLOC | PF_SYNCTHREAD;
+
+	SWSUSP_THREAD_FLAGS_RESET;
+	SWSUSP_ACTIVITY_START(PF_SYNCTHREAD);
 
 	pagebuf_daemon_task = current;
 	pagebuf_daemon_active = 1;
@@ -1721,12 +1725,12 @@
 	INIT_LIST_HEAD(&tmp);
 	do {
 		/* swsusp */
-		if (current->flags & PF_FREEZE)
-			refrigerator(PF_IOTHREAD);
+		SWSUSP_ACTIVITY_SYNCTHREAD_PAUSING;
 
 		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(pb_params.flush_interval.val);
 
+		SWSUSP_ACTIVITY_RESTARTING(PF_SYNCTHREAD);
 		spin_lock(&pbd_delwrite_lock);
 
 		count = 0;
@@ -1771,6 +1775,7 @@
 		force_flush = 0;
 	} while (pagebuf_daemon_active);
 
+	SWSUSP_ACTIVITY_END;
 	complete_and_exit(&pagebuf_daemon_done, 0);
 }
 
diff -ruN software-suspend-linux-2.6.2-rc3-261patch7/kernel/workqueue.c software-suspend-linux-2.6.2-rc3/kernel/workqueue.c
--- software-suspend-linux-2.6.2-rc3-261patch7/kernel/workqueue.c	2004-01-31 21:27:07.000000000 +1300
+++ software-suspend-linux-2.6.2-rc3/kernel/workqueue.c	2004-01-31 21:22:59.000000000 +1300
@@ -169,7 +169,7 @@
 	struct k_sigaction sa;
 
 	daemonize("%s/%d", startup->name, cpu);
-	current->flags |= PF_IOTHREAD;
+	current->flags |= PF_NOFREEZE;
 	cwq->thread = current;
 
 	set_user_nice(current, -10);
diff -ruN software-suspend-linux-2.6.2-rc3-261patch7/net/bluetooth/rfcomm/core.c software-suspend-linux-2.6.2-rc3/net/bluetooth/rfcomm/core.c
--- software-suspend-linux-2.6.2-rc3-261patch7/net/bluetooth/rfcomm/core.c	2004-01-31 21:27:07.000000000 +1300
+++ software-suspend-linux-2.6.2-rc3/net/bluetooth/rfcomm/core.c	2004-01-31 21:22:59.000000000 +1300
@@ -52,6 +52,8 @@
 #include <net/bluetooth/l2cap.h>
 #include <net/bluetooth/rfcomm.h>
 
+#include <linux/suspend.h>
+
 #define VERSION "1.1"
 
 #ifndef CONFIG_BT_RFCOMM_DEBUG

--=-hHR3Vdx3CCv3vfsBOaG8--

