Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030513AbWI0SAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030513AbWI0SAG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 14:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030512AbWI0R77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 13:59:59 -0400
Received: from [198.99.130.12] ([198.99.130.12]:49331 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1030514AbWI0R7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 13:59:34 -0400
Message-Id: <200609271757.k8RHvtNK005742@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 4/5] UML - Close file descriptor leaks
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 27 Sep 2006 13:57:55 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Close two file descriptor leaks, one in the ubd driver and one to
/proc/mounts.  The ubd driver bug also leaked some vmalloc space.
The /proc/mounts leak was a descriptor that was just never closed.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
---

 arch/um/drivers/ubd_kern.c |    9 ++-------
 arch/um/os-Linux/mem.c     |    6 +++++-
 2 files changed, 7 insertions(+), 8 deletions(-)

Index: linux-2.6.18-mm/arch/um/drivers/ubd_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/ubd_kern.c	2006-09-26 16:28:58.000000000 -0400
+++ linux-2.6.18-mm/arch/um/drivers/ubd_kern.c	2006-09-26 16:31:24.000000000 -0400
@@ -667,18 +667,15 @@ static int ubd_add(int n)
 	if(dev->file == NULL)
 		goto out;
 
-	if (ubd_open_dev(dev))
-		goto out;
-
 	err = ubd_file_size(dev, &dev->size);
 	if(err < 0)
-		goto out_close;
+		goto out;
 
 	dev->size = ROUND_BLOCK(dev->size);
 
 	err = ubd_new_disk(MAJOR_NR, dev->size, n, &ubd_gendisk[n]);
 	if(err)
-		goto out_close;
+		goto out;
 
 	if(fake_major != MAJOR_NR)
 		ubd_new_disk(fake_major, dev->size, n,
@@ -690,8 +687,6 @@ static int ubd_add(int n)
 		make_ide_entries(ubd_gendisk[n]->disk_name);
 
 	err = 0;
-out_close:
-	ubd_close(dev);
 out:
 	return err;
 }
Index: linux-2.6.18-mm/arch/um/os-Linux/mem.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/os-Linux/mem.c	2006-09-26 16:28:50.000000000 -0400
+++ linux-2.6.18-mm/arch/um/os-Linux/mem.c	2006-09-26 16:31:24.000000000 -0400
@@ -132,6 +132,9 @@ err:
 	else if(found < 0)
 		printf("read returned errno %d\n", -found);
 
+out:
+	close(fd);
+
 	return;
 
 found:
@@ -141,11 +144,12 @@ found:
 
 	if(strncmp(buf, "tmpfs", strlen("tmpfs"))){
 		printf("not tmpfs\n");
-		return;
+		goto out;
 	}
 
 	printf("OK\n");
 	default_tmpdir = "/dev/shm";
+	goto out;
 }
 
 /*

