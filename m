Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268214AbTALDri>; Sat, 11 Jan 2003 22:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268215AbTALDri>; Sat, 11 Jan 2003 22:47:38 -0500
Received: from havoc.daloft.com ([64.213.145.173]:44505 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S268214AbTALDrh>;
	Sat, 11 Jan 2003 22:47:37 -0500
Date: Sat, 11 Jan 2003 22:56:20 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: rusty@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: [PATCH] fixup loop blkdev, add module_get
Message-ID: <20030112035620.GA25648@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes, we are absolutely certain that we have at least one module
reference "locked open" for us.  Loop is an example of such a case:  the
set-fd and clear-fd struct block_device_operations ioctls already have a
module reference from simply the block device being opened.

Therefore, we can just unconditionally increment the module refcount.
I added module_get to do this.

Implementing try_module_get in terms of module_get is left as an
exercise for the maintainer :)  I am too lazy to investigate whether it
is ok for try_module_get to call module_is_live outside of the
get_cpu/put_cpu pair, which is a prereq for try_module_get using
module_get.

Patch against latest Linus BK tree follows...  this also eliminates the
"deprecated" warnings for the loop device.



===== drivers/block/loop.c 1.78 vs edited =====
--- 1.78/drivers/block/loop.c	Thu Dec  5 10:52:06 2002
+++ edited/drivers/block/loop.c	Sat Jan 11 22:45:54 2003
@@ -642,7 +642,7 @@
 	int		lo_flags = 0;
 	int		error;
 
-	MOD_INC_USE_COUNT;
+	module_get(THIS_MODULE);
 
 	error = -EBUSY;
 	if (lo->lo_state != Lo_unbound)
@@ -742,7 +742,7 @@
  out_putf:
 	fput(file);
  out:
-	MOD_DEC_USE_COUNT;
+	module_put(THIS_MODULE);
 	return error;
 }
 
@@ -814,7 +814,7 @@
 	filp->f_dentry->d_inode->i_mapping->gfp_mask = gfp;
 	lo->lo_state = Lo_unbound;
 	fput(filp);
-	MOD_DEC_USE_COUNT;
+	module_put(THIS_MODULE);
 	return 0;
 }
 
===== include/linux/module.h 1.38 vs edited =====
--- 1.38/include/linux/module.h	Wed Jan  8 08:19:44 2003
+++ edited/include/linux/module.h	Sat Jan 11 22:43:20 2003
@@ -249,6 +249,20 @@
 #define local_dec(x) atomic_dec(x)
 #endif
 
+/* bump a module's refcount.
+ *
+ * called only when we are absolutely certain that
+ * module != NULL, and the locking / call chain
+ * guarantees that the module won't disappear out
+ * from underneath us.
+ */
+static inline void module_get(struct module *module)
+{
+	unsigned int cpu = get_cpu();
+	local_inc(&module->ref[cpu].count);
+	put_cpu();
+}
+
 static inline int try_module_get(struct module *module)
 {
 	int ret = 1;
@@ -277,6 +291,7 @@
 }
 
 #else /*!CONFIG_MODULE_UNLOAD*/
+static inline void module_get(struct module *module) {}
 static inline int try_module_get(struct module *module)
 {
 	return !module || module_is_live(module);
