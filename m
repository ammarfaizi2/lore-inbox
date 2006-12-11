Return-Path: <linux-kernel-owner+w=401wt.eu-S936932AbWLKQCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936932AbWLKQCz (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 11:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936935AbWLKQCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 11:02:55 -0500
Received: from smtp.osdl.org ([65.172.181.25]:38819 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936932AbWLKQCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 11:02:54 -0500
Date: Mon, 11 Dec 2006 08:01:40 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
cc: Andrew Morton <akpm@osdl.org>,
       Andrew MChuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] pipe: Don't oops when pipe filesystem isn't mounted
In-Reply-To: <20061211104556.GF4587@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0612110748570.12500@woody.osdl.org>
References: <200612110330_MC3-1-D49B-BC0F@compuserve.com>
 <20061211005557.04643a75.akpm@osdl.org> <20061211011327.f9478117.akpm@osdl.org>
 <20061211092130.GB4587@ftp.linux.org.uk> <20061211012545.ed945cbd.akpm@osdl.org>
 <20061211093314.GC4587@ftp.linux.org.uk> <20061211014727.21c4ab25.akpm@osdl.org>
 <20061211100301.GD4587@ftp.linux.org.uk> <20061211021718.a6954106.akpm@osdl.org>
 <20061211022746.9ec80c03.akpm@osdl.org> <20061211104556.GF4587@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Dec 2006, Al Viro wrote:

> On Mon, Dec 11, 2006 at 02:27:46AM -0800, Andrew Morton wrote:
> > @@ -115,6 +115,11 @@ extern void setup_arch(char **);
> >  #define device_initcall_sync(fn)	__define_initcall("6s",fn,6s)
> >  #define late_initcall(fn)		__define_initcall("7",fn,7)
> >  #define late_initcall_sync(fn)		__define_initcall("7s",fn,7s)
> > +#define populate_rootfs_initcall(fn)	__define_initcall("8",fn,8)
> > +#define populate_rootfs_initcall_sync(fn) __define_initcall("8s",fn,8s)
> > +#define rootfs_neeeded_initcall(fn)	__define_initcall("9",fn,9)
> > +#define rootfs_neeeded_initcall_sync(fn) __define_initcall("9s",fn,9s)
> 
> Ewww....  After module_init()?  Please, don't.  Come on, if it can
> be a module, it _must_ be ready to run late in the game.

Yeah, I think you should just run "populate_rootfs()" just before 
"module_init" (which is the same as "device_initcall()").

So perhaps somethign like this? (totally untested)

Btw, if the linker sorts sections some way (does it?) we could probably 
just make the vmlinux.lds.S file do

	*(.initcall*.init)

or something, and then just let special cases like this use

	__initcall(myfn, 5.1);

to show that it's between levels 5 and 6. But that would depend on the 
linker section beign sorted alphabetically. Does anybody know if the 
linker sorts these things somehow?

This patch is totally untested, but it looks obvious. It just says that 
we'll populate rootfs _after_ we've done the fs-level initcalls, but 
before we do any actual "device" initcalls.

If any really core stuff needs user-land - tough titties, as they say.

		Linus
----
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 6e9fceb..7437cca 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -242,6 +242,7 @@
   	*(.initcall4s.init)						\
   	*(.initcall5.init)						\
   	*(.initcall5s.init)						\
+	*(.initcallrootfs.init)						\
   	*(.initcall6.init)						\
   	*(.initcall6s.init)						\
   	*(.initcall7.init)						\
diff --git a/include/linux/init.h b/include/linux/init.h
index 5eb5d24..5a593a1 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -111,6 +111,7 @@ extern void setup_arch(char **);
 #define subsys_initcall_sync(fn)	__define_initcall("4s",fn,4s)
 #define fs_initcall(fn)			__define_initcall("5",fn,5)
 #define fs_initcall_sync(fn)		__define_initcall("5s",fn,5s)
+#define rootfs_initcall(fn)		__define_initcall("rootfs",fn,rootfs)
 #define device_initcall(fn)		__define_initcall("6",fn,6)
 #define device_initcall_sync(fn)	__define_initcall("6s",fn,6s)
 #define late_initcall(fn)		__define_initcall("7",fn,7)
diff --git a/init/initramfs.c b/init/initramfs.c
index 85f0403..4fa0f79 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -526,7 +526,7 @@ static void __init free_initrd(void)
 
 #endif
 
-void __init populate_rootfs(void)
+static int __init populate_rootfs(void)
 {
 	char *err = unpack_to_rootfs(__initramfs_start,
 			 __initramfs_end - __initramfs_start, 0);
@@ -544,7 +544,7 @@ void __init populate_rootfs(void)
 			unpack_to_rootfs((char *)initrd_start,
 				initrd_end - initrd_start, 0);
 			free_initrd();
-			return;
+			return 0;
 		}
 		printk("it isn't (%s); looks like an initrd\n", err);
 		fd = sys_open("/initrd.image", O_WRONLY|O_CREAT, 0700);
@@ -565,4 +565,6 @@ void __init populate_rootfs(void)
 #endif
 	}
 #endif
+	return 0;
 }
+rootfs_initcall(populate_rootfs);
diff --git a/init/main.c b/init/main.c
index 036f97c..ae12fa3 100644
--- a/init/main.c
+++ b/init/main.c
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
