Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263298AbTFPOEh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 10:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263865AbTFPOEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 10:04:37 -0400
Received: from www.13thfloor.AT ([212.16.59.250]:54657 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S263298AbTFPOEg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 10:04:36 -0400
Date: Mon, 16 Jun 2003 16:18:33 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: linux-kernel@vger.kernel.org
Cc: Rusty Russell <rusty@rustcorp.com.au>
Subject: 2.4.21 Floppy Fallback with NFS root ...
Message-ID: <20030616141832.GG23590@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

I'm curious, is it intentional that, if you select
NFS support and NFS Root support, that the fact, that
no nfs is available, or selected via boot options,
automatically leads to a floppy boot?

I would suggest the following trivial patch, to give
the kernel compiler a chance to disable this 'feature'.

please correct me if I'm talking nonsense ...

best,
Herbert



diff -NurbP --minimal linux-2.4.21/fs/Config.in linux-2.4.21-ffb/fs/Config.in
--- linux-2.4.21/fs/Config.in   Tue Dec 10 03:25:19 2002
+++ linux-2.4.21-ffb/fs/Config.in       Mon Jun 16 15:05:09 2003
@@ -103,6 +103,7 @@
    dep_tristate 'NFS file system support' CONFIG_NFS_FS $CONFIG_INET
    dep_mbool '  Provide NFSv3 client support' CONFIG_NFS_V3 $CONFIG_NFS_FS
    dep_bool '  Root file system on NFS' CONFIG_ROOT_NFS $CONFIG_NFS_FS $CONFIG_IP_PNP
+   dep_bool '    Floppy Fallback' CONFIG_FLOPPY_FALLBACK $CONFIG_ROOT_NFS
 
    dep_tristate 'NFS server support' CONFIG_NFSD $CONFIG_INET
    dep_mbool '  Provide NFSv3 server support' CONFIG_NFSD_V3 $CONFIG_NFSD
diff -NurbP --minimal linux-2.4.21/init/do_mounts.c linux-2.4.21-ffb/init/do_mounts.c
--- linux-2.4.21/init/do_mounts.c       Fri Jun 13 17:49:28 2003
+++ linux-2.4.21-ffb/init/do_mounts.c   Mon Jun 16 15:00:23 2003
@@ -754,8 +754,10 @@
                        printk("VFS: Mounted root (nfs filesystem).\n");
                        return;
                }
+# ifdef CONFIG_FLOPPY_FALLBACK         
                printk(KERN_ERR "VFS: Unable to mount root fs via NFS, trying floppy.\n");
                ROOT_DEV = MKDEV(FLOPPY_MAJOR, 0);
+# endif
        }
 #endif
        devfs_make_root(root_device_name);

