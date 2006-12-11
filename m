Return-Path: <linux-kernel-owner+w=401wt.eu-S1762764AbWLKK2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762764AbWLKK2a (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 05:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762763AbWLKK2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 05:28:30 -0500
Received: from smtp.osdl.org ([65.172.181.25]:38780 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762762AbWLKK23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 05:28:29 -0500
Date: Mon, 11 Dec 2006 02:27:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>,
       Andrew MChuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Linus Torvalds orton <akpm@osdl.org>" <torvalds@osdl.org>
Subject: Re: [patch] pipe: Don't oops when pipe filesystem isn't mounted
Message-Id: <20061211022746.9ec80c03.akpm@osdl.org>
In-Reply-To: <20061211021718.a6954106.akpm@osdl.org>
References: <200612110330_MC3-1-D49B-BC0F@compuserve.com>
	<20061211005557.04643a75.akpm@osdl.org>
	<20061211011327.f9478117.akpm@osdl.org>
	<20061211092130.GB4587@ftp.linux.org.uk>
	<20061211012545.ed945cbd.akpm@osdl.org>
	<20061211093314.GC4587@ftp.linux.org.uk>
	<20061211014727.21c4ab25.akpm@osdl.org>
	<20061211100301.GD4587@ftp.linux.org.uk>
	<20061211021718.a6954106.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2006 02:17:18 -0800
Andrew Morton <akpm@osdl.org> wrote:

> > Said that, I think that pipes should be initialized early.
> 
> Judging by the comment there, the only reason we prepare the rootfs prior
> to running initcalls is for firmware.  So the sequence
> 
> 	run initcalls
> 	populate rootfs
> 	run initcalls which want to access files
> 
> fixes everything?

Like this...  The other part is hunting down all those drivers which want
to access the filesystem at init time.


 include/asm-generic/vmlinux.lds.h |    6 +++++-
 include/linux/init.h              |    5 +++++
 init/initramfs.c                  |    3 ++-
 init/main.c                       |    7 -------
 4 files changed, 12 insertions(+), 9 deletions(-)

diff -puN init/main.c~dont-run-userspace-until-initcalls-have-completed init/main.c
--- a/init/main.c~dont-run-userspace-until-initcalls-have-completed
+++ a/init/main.c
@@ -94,7 +94,6 @@ extern void pidmap_init(void);
 extern void prio_tree_init(void);
 extern void radix_tree_init(void);
 extern void free_initmem(void);
-extern void populate_rootfs(void);
 extern void driver_init(void);
 extern void prepare_namespace(void);
 #ifdef	CONFIG_ACPI
@@ -739,12 +738,6 @@ static int init(void * unused)
 
 	cpuset_init_smp();
 
-	/*
-	 * Do this before initcalls, because some drivers want to access
-	 * firmware files.
-	 */
-	populate_rootfs();
-
 	do_basic_setup();
 
 	/*
diff -puN include/linux/init.h~dont-run-userspace-until-initcalls-have-completed include/linux/init.h
--- a/include/linux/init.h~dont-run-userspace-until-initcalls-have-completed
+++ a/include/linux/init.h
@@ -115,6 +115,11 @@ extern void setup_arch(char **);
 #define device_initcall_sync(fn)	__define_initcall("6s",fn,6s)
 #define late_initcall(fn)		__define_initcall("7",fn,7)
 #define late_initcall_sync(fn)		__define_initcall("7s",fn,7s)
+#define populate_rootfs_initcall(fn)	__define_initcall("8",fn,8)
+#define populate_rootfs_initcall_sync(fn) __define_initcall("8s",fn,8s)
+#define rootfs_neeeded_initcall(fn)	__define_initcall("9",fn,9)
+#define rootfs_neeeded_initcall_sync(fn) __define_initcall("9s",fn,9s)
+
 
 #define __initcall(fn) device_initcall(fn)
 
diff -puN include/asm-generic/vmlinux.lds.h~dont-run-userspace-until-initcalls-have-completed include/asm-generic/vmlinux.lds.h
--- a/include/asm-generic/vmlinux.lds.h~dont-run-userspace-until-initcalls-have-completed
+++ a/include/asm-generic/vmlinux.lds.h
@@ -245,5 +245,9 @@
   	*(.initcall6.init)						\
   	*(.initcall6s.init)						\
   	*(.initcall7.init)						\
-  	*(.initcall7s.init)
+  	*(.initcall7s.init)						\
+  	*(.initcall8.init)						\
+  	*(.initcall8s.init)						\
+  	*(.initcall9.init)						\
+  	*(.initcall9s.init)
 
diff -puN init/initramfs.c~dont-run-userspace-until-initcalls-have-completed init/initramfs.c
--- a/init/initramfs.c~dont-run-userspace-until-initcalls-have-completed
+++ a/init/initramfs.c
@@ -526,7 +526,7 @@ static void __init free_initrd(void)
 
 #endif
 
-void __init populate_rootfs(void)
+static int __init populate_rootfs(void)
 {
 	char *err = unpack_to_rootfs(__initramfs_start,
 			 __initramfs_end - __initramfs_start, 0);
@@ -566,3 +566,4 @@ void __init populate_rootfs(void)
 	}
 #endif
 }
+populate_rootfs_initcall(populate_rootfs);
_

