Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753749AbWKFSMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753749AbWKFSMT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 13:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753758AbWKFSMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 13:12:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:10712 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1753755AbWKFSMR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 13:12:17 -0500
Subject: [PATCH] make last_inode counter in new_inode 32-bit on kernels
	that offer x86 compatability
From: Jeff Layton <jlayton@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 06 Nov 2006 13:12:05 -0500
Message-Id: <1162836725.6952.28.camel@dantu.rdu.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some (generally not disk-based) filesystems use the new_inode() function
to allocate and populate inode structs. This function uses a static
unsigned long counter to populate i_ino. On most 64-bit platforms, this
is a 64-bit integer, but on ia32, this is a 32-bit int.

If stat() is called from a 32-bit program that was not compiled with
-D_FILE_OFFSET_BITS=64 on one of these inodes, then glibc will generate
an EOVERFLOW error in userspace (since the st_ino returned by the stat64
call won't fit in the old-style stat struct).

This creates a situation where these programs will run just fine on a
32-bit kernel, but will eventually start falling down with EOVERFLOW
errors on a 64-bit kernel. One way to reproduce this is to write a
program that repeatedly calls pipe() and then does an fstat() on one of
the pipe filehandles, and compile the program as a 32-bit app w/o
-D_FILE_OFFSET_BITS=64. Eventually, the fstat will consistently fail
with an EOVERFLOW.

The attached patch remedies this by making the last_inode counter be an
unsigned int on kernels that have ia32 compatability mode enabled.

My rationale is that we're eventually going to overflow this counter
regardless. This does make it happen sooner, but this is no worse that
what already happens on ia32.

Signed-off-by: Jeff Layton <jlayton@redhat.com>

--- linux-2.6/fs/inode.c.lastino
+++ linux-2.6/fs/inode.c
@@ -524,7 +524,11 @@ repeat:
  */
 struct inode *new_inode(struct super_block *sb)
 {
+#if (defined CONFIG_IA32_EMULATION || defined CONFIG_IA32_SUPPORT)
+	static unsigned int last_ino;
+#else
 	static unsigned long last_ino;
+#endif
 	struct inode * inode;
 
 	spin_lock_prefetch(&inode_lock);


