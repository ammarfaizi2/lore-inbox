Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964832AbWCAC2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbWCAC2f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 21:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964829AbWCAC2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 21:28:35 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:6892 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S964824AbWCAC2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 21:28:34 -0500
Date: Tue, 28 Feb 2006 21:29:44 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Add O_NONBLOCK support to FUSE
Message-ID: <20060301022944.GB9624@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds O_NONBLOCK support to FUSE.
I don't like duplicating the connected and list_empty tests in
fuse_dev_readv, but this seemed cleaner than adding the f_flags test
to request_wait.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: host-2.6.15-fuse/fs/fuse/dev.c
===================================================================
--- host-2.6.15-fuse.orig/fs/fuse/dev.c	2006-02-28 21:00:00.000000000 -0500
+++ host-2.6.15-fuse/fs/fuse/dev.c	2006-02-28 21:04:36.000000000 -0500
@@ -613,6 +613,12 @@ static ssize_t fuse_dev_readv(struct fil
 	err = -EPERM;
 	if (!fc)
 		goto err_unlock;
+
+	err = -EAGAIN;
+	if((file->f_flags & O_NONBLOCK) && fc->connected &&
+	   list_empty(&fc->pending))
+		goto err_unlock;
+
 	request_wait(fc);
 	err = -ENODEV;
 	if (!fc->connected)
