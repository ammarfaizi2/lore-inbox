Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbUCCIq7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 03:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbUCCIq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 03:46:59 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:52970 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262422AbUCCIq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 03:46:57 -0500
Date: Wed, 3 Mar 2004 09:46:54 +0100 (MET)
From: Armin Schindler <aml@melware.de>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
cc: Armin Schindler <armin@melware.de>
Subject: [PATCH 2.4] sys_select() return error on bad file
Message-ID: <Pine.LNX.4.31.0403030936570.9608-100000@phoenix.one.melware.de>
Organization: Cytronics & Melware
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:4f0aeee4703bc17a8237042c4702a75a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the following patch now returns -EBADF in sys_select()/do_select()
if all specified file-descriptors are bad (e.g. were closed by another
thread).

Without this patch, the for-loop in do_select() won't stop if there are no
valid files any more. It stops only if a specified timeout occured or a
signal arrived.

If there are no objections on this patch, I would also create a patch for
kernel 2.6 and the poll() code. I didn't have a closer look at this yet.

Armin

--- linux/fs/select.c_orig	2004-03-02 19:06:44.000000000 +0100
+++ linux/fs/select.c	2004-03-03 09:25:24.000000000 +0100
@@ -183,6 +183,8 @@
 		wait = NULL;
 	retval = 0;
 	for (;;) {
+		int file_err = 1;
+
 		set_current_state(TASK_INTERRUPTIBLE);
 		for (i = 0 ; i < n; i++) {
 			unsigned long bit = BIT(i);
@@ -199,6 +201,7 @@
 						  i /*  The fd*/,
 						  __timeout,
 						  NULL);
+				file_err = 0;
 				mask = DEFAULT_POLLMASK;
 				if (file->f_op && file->f_op->poll)
 					mask = file->f_op->poll(file, wait);
@@ -227,6 +230,10 @@
 			retval = table.error;
 			break;
 		}
+		if (file_err) {
+			retval = -EBADF;
+			break;
+		}
 		__timeout = schedule_timeout(__timeout);
 	}
 	current->state = TASK_RUNNING;

