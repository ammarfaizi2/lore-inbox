Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbTJABql (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 21:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbTJABql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 21:46:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:11484 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261837AbTJABqk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 21:46:40 -0400
Date: Tue, 30 Sep 2003 18:46:38 -0700
From: Chris Wright <chrisw@osdl.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] call_usermodehelper fix
Message-ID: <20030930184638.C722@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This gives the wait_for_helper thread its own sighand struct, so that
it's not stomping on it's parent's SIGCHLD handler (which is intended to
be SIG_IGN).  Now the parent keventd thread properly reaps children.
Look ok?

thanks,
-chris

--- 2.6.0-test6-mm1-clean/kernel/kmod.c	2003-09-29 17:46:22.000000000 -0700
+++ 2.6.0-test6-mm1/kernel/kmod.c	2003-09-30 18:17:04.000000000 -0700
@@ -217,7 +217,7 @@
 	 * until that is done.  */
 	if (sub_info->wait)
 		pid = kernel_thread(wait_for_helper, sub_info,
-				    CLONE_KERNEL | SIGCHLD);
+				    CLONE_FS | CLONE_FILES | SIGCHLD);
 	else
 		pid = kernel_thread(____call_usermodehelper, sub_info,
 				    CLONE_VFORK | SIGCHLD);
