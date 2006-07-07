Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbWGGAdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWGGAdn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 20:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbWGGAdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 20:33:43 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:47555 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751110AbWGGAdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 20:33:42 -0400
Message-Id: <200607070033.k670Xlvt008717@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 12/19] UML - Fix exitcall ordering bug
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 06 Jul 2006 20:33:47 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes an exitcall ordering bug - calls to ignore_sigio_fd can
come from exitcalls that come after the sigio thread has been killed.
This would cause shutdown to hang or crash.

Fixed by having ignore_sigio_fd check that the thread is present
before trying to communicate with it.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17/arch/um/os-Linux/sigio.c
===================================================================
--- linux-2.6.17.orig/arch/um/os-Linux/sigio.c	2006-07-06 13:44:26.000000000 -0400
+++ linux-2.6.17/arch/um/os-Linux/sigio.c	2006-07-06 14:46:10.000000000 -0400
@@ -191,6 +191,13 @@ int ignore_sigio_fd(int fd)
 	struct pollfd *p;
 	int err = 0, i, n = 0;
 
+	/* This is called from exitcalls elsewhere in UML - if
+	 * sigio_cleanup has already run, then update_thread will hang
+	 * or fail because the thread is no longer running.
+	 */
+	if(write_sigio_pid == -1)
+		return -EIO;
+
 	sigio_lock();
 	for(i = 0; i < current_poll.used; i++){
 		if(current_poll.poll[i].fd == fd) break;
@@ -215,7 +222,7 @@ int ignore_sigio_fd(int fd)
 	update_thread();
  out:
 	sigio_unlock();
-	return(err);
+	return err;
 }
 
 static struct pollfd *setup_initial_poll(int fd)

