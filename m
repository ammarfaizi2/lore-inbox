Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270815AbTGVOQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 10:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270822AbTGVOQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 10:16:57 -0400
Received: from www.13thfloor.AT ([212.16.59.250]:27364 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S270815AbTGVOQz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 10:16:55 -0400
Date: Tue, 22 Jul 2003 16:32:05 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: noaltroot bootparam [was Floppy Fallback]
Message-ID: <20030722143205.GB16779@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Everyone!

Trond suggested to draft a patch to address the
Floppy Fallback issues (mentioned several times
on lkml) by adding a kernel boot parameter, to
disable the fallback, or to put it more general,
to disable alternate root device attempts ...

Currently the NFS-Root Floppy Fallback is the 
only _user_ of such a boot parameter, but in 
future, this could be used to limit multiple
root situations to a make-or-brake ...

please comment!

best,
Herbert

------------
diff -NurbBP --minimal linux-2.4.22-pre7-fix/Documentation/kernel-parameters.txt linux-2.4.22-pre7-ffb/Documentation/kernel-parameters.txt
--- linux-2.4.22-pre7-fix/Documentation/kernel-parameters.txt   2003-07-19 14:14:20.000000000 +0200
+++ linux-2.4.22-pre7-ffb/Documentation/kernel-parameters.txt   2003-07-21 23:13:56.000000000 +0200
@@ -389,6 +389,8 @@

        noalign         [KNL,ARM]

+	noaltroot	[NFS] disable alternate root devices (e.g. floppy)
+
        noapic          [SMP,APIC] Tells the kernel not to make use of any
                        APIC that may be present on the system.

diff -NurbBP --minimal linux-2.4.22-pre7-fix/init/do_mounts.c linux-2.4.22-pre7-ffb/init/do_mounts.c
--- linux-2.4.22-pre7-fix/init/do_mounts.c	2003-07-21 22:13:12.000000000 +0200
+++ linux-2.4.22-pre7-ffb/init/do_mounts.c	2003-07-21 23:26:18.000000000 +0200
@@ -48,6 +48,18 @@
 static int __initdata mount_initrd = 0;
 #endif

+static int __initdata no_alt_root;     /* 1 = disable alternate root */
+
+/*  Disable alternate root attempts (e.g. floppy on NFS) */
+static int __init noaltroot_setup(char *str)
+{
+        no_alt_root = 1;
+        return 1;
+}
+
+__setup("noaltroot", noaltroot_setup);
+
+
 int __initdata rd_doload;	/* 1 = load RAM disk, 0 = don't load */

 int root_mountflags = MS_RDONLY | MS_VERBOSE;
@@ -767,6 +779,9 @@
                       	printk("VFS: Mounted root (nfs filesystem).\n");
                       	return;
               	}  
+               if (no_alt_root)
+	                panic("VFS: Unable to mount root fs via NFS\n");
+
               	printk(KERN_ERR "VFS: Unable to mount root fs via NFS, trying floppy.\n");
               	ROOT_DEV = MKDEV(FLOPPY_MAJOR, 0);
       	}


