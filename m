Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269499AbUINSnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269499AbUINSnL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 14:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269604AbUINSlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 14:41:24 -0400
Received: from [12.177.129.25] ([12.177.129.25]:30403 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S269699AbUINS37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 14:29:59 -0400
Message-Id: <200409141933.i8EJXm4W003547@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] - UML - iomem fix
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 14 Sep 2004 15:33:48 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch rounds up the size of a file used for iomem emulation up to the
nearest page.  This makes mmap work much better on the last page of the
file.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9-rc2/arch/um/kernel/mem_user.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/kernel/mem_user.c	2004-09-14 13:43:32.000000000 -0400
+++ 2.6.9-rc2/arch/um/kernel/mem_user.c	2004-09-14 13:53:25.000000000 -0400
@@ -143,7 +143,7 @@
 	struct iomem_region *new;
 	struct uml_stat buf;
 	char *file, *driver;
-	int fd, err;
+	int fd, err, size;
 
 	driver = str;
 	file = strchr(str,',');
@@ -171,10 +171,12 @@
 		goto out_close;
 	}
 
+	size = (buf.ust_size + UM_KERN_PAGE_SIZE) & ~(UM_KERN_PAGE_SIZE - 1);
+
 	*new = ((struct iomem_region) { .next		= iomem_regions,
 					.driver		= driver,
 					.fd		= fd,
-					.size		= buf.ust_size,
+					.size		= size,
 					.phys		= 0,
 					.virt		= 0 });
 	iomem_regions = new;

