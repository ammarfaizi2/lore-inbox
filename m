Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265084AbTIDQJP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 12:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265089AbTIDQJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 12:09:15 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17927 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265084AbTIDQJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 12:09:10 -0400
Date: Thu, 4 Sep 2003 17:09:07 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@ftp.uk.linux.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] Don't #ifdef prototypes
Message-ID: <20030904170907.D8414@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Al Viro <viro@ftp.uk.linux.org>, Linus Torvalds <torvalds@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that changing CONFIG_BLK_DEV_INITRD causes the whole kernel to
rebuild due to an inappropriate ifdef in linux/fs.h - we should not
conditionalise prototypes.

In addition, real_root_dev is only used by two files (kernel/sysctl.c
and init/do_mounts_initrd.c) so it makes even less sense that it was in
linux/fs.h

--- orig/include/linux/fs.h	Thu Sep  4 16:37:56 2003
+++ linux/include/linux/fs.h	Thu Sep  4 16:34:09 2003
@@ -1372,10 +1372,6 @@
 extern int simple_pin_fs(char *name, struct vfsmount **mount, int *count);
 extern void simple_release_fs(struct vfsmount **mount, int *count);
 
-#ifdef CONFIG_BLK_DEV_INITRD
-extern unsigned int real_root_dev;
-#endif
-
 extern int inode_change_ok(struct inode *, struct iattr *);
 extern int inode_setattr(struct inode *, struct iattr *);
 
--- orig/include/linux/initrd.h	Mon May  5 17:40:12 2003
+++ linux/include/linux/initrd.h	Thu Sep  4 16:34:31 2003
@@ -16,3 +16,5 @@
 /* free_initrd_mem always gets called with the next two as arguments.. */
 extern unsigned long initrd_start, initrd_end;
 extern void free_initrd_mem(unsigned long, unsigned long);
+
+extern unsigned int real_root_dev;
--- orig/kernel/sysctl.c	Wed Aug 13 10:33:59 2003
+++ linux/kernel/sysctl.c	Thu Sep  4 16:34:00 2003
@@ -35,6 +35,7 @@
 #include <linux/writeback.h>
 #include <linux/hugetlb.h>
 #include <linux/security.h>
+#include <linux/initrd.h>
 #include <asm/uaccess.h>
 
 #ifdef CONFIG_ROOT_NFS

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core


