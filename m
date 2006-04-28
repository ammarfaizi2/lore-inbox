Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbWD1RA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbWD1RA0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 13:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbWD1RA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 13:00:26 -0400
Received: from [198.99.130.12] ([198.99.130.12]:31192 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751399AbWD1RAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 13:00:25 -0400
Message-Id: <200604281601.k3SG17dn007532@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 4/6] UML - Clean up after MADVISE_REMOVE
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 28 Apr 2006 12:01:07 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The MADVISE_REMOVE-checking code didn't clean up after itself.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16/arch/um/os-Linux/process.c
===================================================================
--- linux-2.6.16.orig/arch/um/os-Linux/process.c	2006-04-27 20:51:58.000000000 -0400
+++ linux-2.6.16/arch/um/os-Linux/process.c	2006-04-28 12:20:55.000000000 -0400
@@ -206,29 +206,36 @@ int os_drop_memory(void *addr, int lengt
 int can_drop_memory(void)
 {
 	void *addr;
-	int fd;
+	int fd, ok = 0;
 
 	printk("Checking host MADV_REMOVE support...");
 	fd = create_mem_file(UM_KERN_PAGE_SIZE);
 	if(fd < 0){
 		printk("Creating test memory file failed, err = %d\n", -fd);
-		return 0;
+		goto out;
 	}
 
 	addr = mmap64(NULL, UM_KERN_PAGE_SIZE, PROT_READ | PROT_WRITE,
 		      MAP_SHARED, fd, 0);
 	if(addr == MAP_FAILED){
 		printk("Mapping test memory file failed, err = %d\n", -errno);
-		return 0;
+		goto out_close;
 	}
 
 	if(madvise(addr, UM_KERN_PAGE_SIZE, MADV_REMOVE) != 0){
 		printk("MADV_REMOVE failed, err = %d\n", -errno);
-		return 0;
+		goto out_unmap;
 	}
 
 	printk("OK\n");
-	return 1;
+	ok = 1;
+
+out_unmap:
+	munmap(addr, UM_KERN_PAGE_SIZE);
+out_close:
+	close(fd);
+out:
+	return ok;
 }
 
 void init_new_thread_stack(void *sig_stack, void (*usr1_handler)(int))

