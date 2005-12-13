Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932615AbVLMXG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932615AbVLMXG2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 18:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932608AbVLMXG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 18:06:28 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:19218 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932616AbVLMXG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 18:06:26 -0500
Date: Wed, 14 Dec 2005 00:06:25 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, Dave Kleikamp <shaggy@austin.ibm.com>,
       Andrew Morton <akpm@osdl.org>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [-mm patch] fs/nfsd/vfs.c: fix possible runtime stack corruption
Message-ID: <20051213230625.GW23349@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling 2.6.15-rc5-mm2 with CONFIG_NFSD_V4=n and CONFIG_NFSD_V2_ACL=y 
or CONFIG_NFSD_V3_ACL=y results due to 
add-vfs_-helpers-for-xattr-operations.patch in the following:

<--  snip  -->

...
  CC [M]  fs/nfsd/vfs.o
fs/nfsd/vfs.c: In function 'nfsd_getxattr':
fs/nfsd/vfs.c:376: warning: implicit declaration of function 'vfs_getxattr'
fs/nfsd/vfs.c: In function 'nfsd_set_posix_acl':
fs/nfsd/vfs.c:1931: warning: implicit declaration of function 'vfs_setxattr'
fs/nfsd/vfs.c:1936: warning: implicit declaration of function 'vfs_removexattr'
...

<--  snip  -->


The possible stack corruption if gcc guessed the types of the parameters 
of any of these functions wrong is obvious.


Given the -Werror-implicit-function-declaration flag, gcc would	
abort compilation in such cases:

<--  snip  -->

...
  CC [M]  fs/nfsd/vfs.o
fs/nfsd/vfs.c: In function 'nfsd_getxattr':
fs/nfsd/vfs.c:376: error: implicit declaration of function 'vfs_getxattr'
fs/nfsd/vfs.c: In function 'nfsd_set_posix_acl':
fs/nfsd/vfs.c:1931: error: implicit declaration of function 'vfs_setxattr'
fs/nfsd/vfs.c:1936: error: implicit declaration of function 'vfs_removexattr'
make[2]: *** [fs/nfsd/vfs.o] Error 1

<--  snip  -->



Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-rc5-mm2-modular/fs/nfsd/vfs.c.old	2005-12-13 22:05:39.000000000 +0100
+++ linux-2.6.15-rc5-mm2-modular/fs/nfsd/vfs.c	2005-12-13 22:05:55.000000000 +0100
@@ -48,8 +48,8 @@
 #include <linux/fsnotify.h>
 #include <linux/posix_acl.h>
 #include <linux/posix_acl_xattr.h>
-#ifdef CONFIG_NFSD_V4
 #include <linux/xattr.h>
+#ifdef CONFIG_NFSD_V4
 #include <linux/nfs4.h>
 #include <linux/nfs4_acl.h>
 #include <linux/nfsd_idmap.h>

