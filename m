Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261518AbUKODbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbUKODbs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 22:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbUKOD3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 22:29:49 -0500
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:39093 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261518AbUKODZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 22:25:54 -0500
Date: Sun, 14 Nov 2004 19:25:41 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>,
       user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH] uml: fail xterm_open when we have no $DISPLAY
Message-ID: <20041115032541.GA13077@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If UML wants to open an xterm channel and the xterm does not run
properly (eg. terminates soon after starting) we will get a hang.
This avoids the most common cause for this and adds a comment (which
long term will go away with a rewrite of that code I guess?)

Signed-off-by: Chris Wedgwood <cw@f00f.org>
---

 arch/um/drivers/xterm.c      |    7 +++++++
 arch/um/drivers/xterm_kern.c |    3 +++
 2 files changed, 10 insertions(+)

Index: cw-current/arch/um/drivers/xterm.c
===================================================================
--- cw-current.orig/arch/um/drivers/xterm.c	2004-11-14 17:52:05.955194653 -0800
+++ cw-current/arch/um/drivers/xterm.c	2004-11-14 17:52:23.048945524 -0800
@@ -94,6 +94,13 @@
 			 "/usr/lib/uml/port-helper", "-uml-socket",
 			 file, NULL };
 
+	/* Check that DISPLAY is set, this doesn't guarantee the xterm
+	 * will work but w/o it we can be pretty sure it won't. */
+	if (!getenv("DISPLAY")) {
+		printk("xterm_open: $DISPLAY not set.\n");
+		return -ENODEV;
+	}
+
 	if(os_access(argv[4], OS_ACC_X_OK) < 0)
 		argv[4] = "port-helper";
 
Index: cw-current/arch/um/drivers/xterm_kern.c
===================================================================
--- cw-current.orig/arch/um/drivers/xterm_kern.c	2004-11-14 17:52:51.484194558 -0800
+++ cw-current/arch/um/drivers/xterm_kern.c	2004-11-14 17:53:09.197972625 -0800
@@ -61,6 +61,9 @@
 		ret = err;
 		goto out;
 	}
+
+	/* XXX Note, if the xterm doesn't work for some reason
+	 * (eg. DISPLAY isn't set this will hang... */
 	down(&data->sem);
 
 	free_irq_by_irq_and_dev(XTERM_IRQ, data);
