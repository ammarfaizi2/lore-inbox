Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262199AbUKBJdC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262199AbUKBJdC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 04:33:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262173AbUKBJci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 04:32:38 -0500
Received: from ozlabs.org ([203.10.76.45]:61849 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264527AbUKBJcL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 04:32:11 -0500
Subject: [PATCH] Don't ignore try_stop_module return
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 01 Nov 2004 18:01:45 +1100
Message-Id: <1099292505.25525.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Name: Fix Module Removal Bug: Don't Ignore try_stop_module Return
Status: Trivial
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

Since 2.6.4 we've been ignoring the failure of try_stop_module: it
will normally fail if the module reference count is non-zero.  This
would have been mainly unnoticed, since "modprobe -r" checks the usage
count before calling sys_delete_module(), however there is a race
which would cause a hang in this case.

Index: linux-2.6.10-rc1-bk10-Module/kernel/module.c
===================================================================
--- linux-2.6.10-rc1-bk10-Module.orig/kernel/module.c	2004-11-01 17:54:17.861349784 +1100
+++ linux-2.6.10-rc1-bk10-Module/kernel/module.c	2004-11-01 17:57:15.020417512 +1100
@@ -576,6 +576,8 @@
 
 	/* Stop the machine so refcounts can't move and disable module. */
 	ret = try_stop_module(mod, flags, &forced);
+	if (ret != 0)
+		goto out;
 
 	/* Never wait if forced. */
 	if (!forced && module_refcount(mod) != 0)

-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

