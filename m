Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267256AbSLEHmM>; Thu, 5 Dec 2002 02:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267252AbSLEHlK>; Thu, 5 Dec 2002 02:41:10 -0500
Received: from holomorphy.com ([66.224.33.161]:55432 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267253AbSLEHlE>;
	Thu, 5 Dec 2002 02:41:04 -0500
Date: Wed, 04 Dec 2002 23:48:27 -0800
From: wli@holomorphy.com
To: linux-kernel@vger.kernel.org
Cc: mingo@elte.hu
Subject: [pidhash] [1/4] Make __do_SAK() use for_each_task_pid().
Message-ID: <0212042348.MagbHaKdKcEaTd3dPb5dTdIcCb8dWbca15950@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <0212042348.vaibscRdmcpcAbdcfb9d~c3c4bNczcIa15950@holomorphy.com>
X-Mailer: patchbomb 0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kill off the for_each_process() in __do_SAK(): it really just
wants to do a hangup using SIGKILL.

 tty_io.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)


diff -urpN mm1-2.5.50-1/drivers/char/tty_io.c mm1-2.5.50-2/drivers/char/tty_io.c
--- mm1-2.5.50-1/drivers/char/tty_io.c	2002-12-04 12:49:46.000000000 -0800
+++ mm1-2.5.50-2/drivers/char/tty_io.c	2002-12-04 13:06:20.000000000 -0800
@@ -1838,6 +1838,8 @@ static void __do_SAK(void *arg)
 #else
 	struct tty_struct *tty = arg;
 	struct task_struct *p;
+	struct list_head *l;
+	struct pid *pid;
 	int session;
 	int		i;
 	struct file	*filp;
@@ -1850,9 +1852,8 @@ static void __do_SAK(void *arg)
 	if (tty->driver.flush_buffer)
 		tty->driver.flush_buffer(tty);
 	read_lock(&tasklist_lock);
-	for_each_process(p) {
-		if ((p->tty == tty) ||
-		    ((session > 0) && (p->session == session))) {
+	for_each_task_pid(session, PIDTYPE_SID, p, l, pid) {
+		if (p->tty == tty || session > 0) {
 			printk(KERN_NOTICE "SAK: killed process %d"
 			    " (%s): p->session==tty->session\n",
 			    p->pid, p->comm);
