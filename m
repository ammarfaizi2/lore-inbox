Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932753AbWF2Vg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932753AbWF2Vg3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932667AbWF2Vg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:36:29 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:19168 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932753AbWF2Vg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:36:28 -0400
Message-Id: <200606292136.k5TLaOjV010792@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 1/9] UML - Fix /proc/mounts parsing boundary condition 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 29 Jun 2006 17:36:23 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When parsing /proc/mounts looking for a tmpfs mount on /dev/shm, if
a string that we are looking for if split across reads, then it
won't be recognized.

Fix this by refilling the buffer whenever we advance the cursor.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16-rc-mm/arch/um/os-Linux/mem.c
===================================================================
--- linux-2.6.16-rc-mm.orig/arch/um/os-Linux/mem.c	2006-06-11 14:27:36.000000000 -0400
+++ linux-2.6.16-rc-mm/arch/um/os-Linux/mem.c	2006-06-28 13:07:35.000000000 -0400
@@ -55,7 +55,7 @@ static void __init find_tempdir(void)
  */
 static int next(int fd, char *buf, int size, char c)
 {
-	int n;
+	int n, len;
 	char *ptr;
 
 	while((ptr = strchr(buf, c)) == NULL){
@@ -69,7 +69,17 @@ static int next(int fd, char *buf, int s
 	}
 
 	ptr++;
-	memmove(buf, ptr, strlen(ptr) + 1);
+	len = strlen(ptr);
+	memmove(buf, ptr, len + 1);
+
+	/* Refill the buffer so that if there's a partial string that we care
+	 * about, it will be completed, and we can recognize it.
+	 */
+	n = read(fd, &buf[len], size - len - 1);
+	if(n < 0)
+		return -errno;
+
+	buf[len + n] = '\0';
 	return 1;
 }
 

