Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbTHYOam (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 10:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbTHYOam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 10:30:42 -0400
Received: from verein.lst.de ([212.34.189.10]:55709 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261909AbTHYOaj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 10:30:39 -0400
Date: Mon, 25 Aug 2003 16:29:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: marcelo@hera.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix copy_namespace()
Message-ID: <20030825142948.GA17740@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, marcelo@hera.kernel.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -2.5 () USER_AGENT_MUTT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Originally by aeb, in 2.5 for ages.

Fix far too small kmalloc in copy_namespace and promote errors properly.


--- linux/fs/namespace.c	2003-06-13 22:07:33.000000000 +0200
+++ linux/fs/namespace.c	2003-06-18 02:48:47.000000000 +0200
@@ -763,7 +763,7 @@ int copy_namespace(int flags, struct tas
 		return -EPERM;
 	}
 
-	new_ns = kmalloc(sizeof(struct namespace *), GFP_KERNEL);
+	new_ns = kmalloc(sizeof(struct namespace), GFP_KERNEL);
 	if (!new_ns)
 		goto out;
 
--- linux/kernel/fork.c	2003-06-18 02:36:34.000000000 +0200
+++ linux/kernel/fork.c	2003-06-18 02:49:22.000000000 +0200
@@ -793,7 +793,8 @@ int do_fork(unsigned long clone_flags, u
 		goto bad_fork_cleanup_fs;
 	if (copy_mm(clone_flags, p))
 		goto bad_fork_cleanup_sighand;
-	if (copy_namespace(clone_flags, p))
+	retval = copy_namespace(clone_flags, p);
+	if (retval)
 		goto bad_fork_cleanup_mm;
 	retval = copy_thread(0, clone_flags, stack_start, stack_size, p, regs);
 	if (retval)
