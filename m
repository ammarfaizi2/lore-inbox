Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932748AbWF2Vga@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932748AbWF2Vga (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932754AbWF2Vga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:36:30 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:19680 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932748AbWF2Vg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:36:28 -0400
Message-Id: <200606292136.k5TLaR27010797@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 2/9] UML - Fix off-by-one bug in VM file creation
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 29 Jun 2006 17:36:27 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix an off-by-one bug in temp file creation.  Seeking to the desired
length and writing a byte resulted in the file being one byte longer
than expected.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17/arch/um/os-Linux/mem.c
===================================================================
--- linux-2.6.17.orig/arch/um/os-Linux/mem.c	2006-06-29 10:42:11.000000000 -0400
+++ linux-2.6.17/arch/um/os-Linux/mem.c	2006-06-29 11:42:23.000000000 -0400
@@ -210,8 +210,11 @@ int create_tmp_file(unsigned long long l
 		exit(1);
 	}
 
-        if (lseek64(fd, len, SEEK_SET) < 0) {
- 		perror("os_seek_file");
+	/* Seek to len - 1 because writing a character there will
+	 * increase the file size by one byte, to the desired length.
+	 */
+	if (lseek64(fd, len - 1, SEEK_SET) < 0) {
+		perror("os_seek_file");
 		exit(1);
 	}
 

