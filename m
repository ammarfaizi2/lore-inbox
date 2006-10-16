Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbWJPPEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWJPPEN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 11:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbWJPPEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 11:04:13 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:27337 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932112AbWJPPEM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 11:04:12 -0400
Subject: [PATCH] ide: add sanity checking to ide taskfile ioctl
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Oct 2006 16:31:02 +0100
Message-Id: <1161012662.24237.76.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Without this the user can feed in bogus values and get very bogus
results. Security impact is minimal as this ioctl isn't available to
unpriviledged processes anyway.

Reported to the l/k list and found with an auditing tool.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc1-mm1/drivers/ide/ide-taskfile.c linux-2.6.19-rc1-mm1/drivers/ide/ide-taskfile.c
--- linux.vanilla-2.6.19-rc1-mm1/drivers/ide/ide-taskfile.c	2006-10-13 15:09:30.000000000 +0100
+++ linux-2.6.19-rc1-mm1/drivers/ide/ide-taskfile.c	2006-10-14 19:27:11.000000000 +0100
@@ -524,8 +524,8 @@
 	task_ioreg_t *hobsptr	= args.hobRegister;
 	int err			= 0;
 	int tasksize		= sizeof(struct ide_task_request_s);
-	int taskin		= 0;
-	int taskout		= 0;
+	unsigned int taskin	= 0;
+	unsigned int taskout	= 0;
 	u8 io_32bit		= drive->io_32bit;
 	char __user *buf = (char __user *)arg;
 
@@ -538,8 +538,13 @@
 		return -EFAULT;
 	}
 
-	taskout = (int) req_task->out_size;
-	taskin  = (int) req_task->in_size;
+	taskout = req_task->out_size;
+	taskin  = req_task->in_size;
+	
+	if (taskin > 65536 || taskout > 65536) {
+		err = -EINVAL;
+		goto abort;
+	}
 
 	if (taskout) {
 		int outtotal = tasksize;

