Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbUCVIPp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 03:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbUCVIPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 03:15:45 -0500
Received: from ns.suse.de ([195.135.220.2]:60591 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261667AbUCVIPk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 03:15:40 -0500
Date: Mon, 22 Mar 2004 09:15:39 +0100
From: Olaf Hering <olh@suse.de>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][2.6-mm] defer free_initmem() if we have no /init
Message-ID: <20040322081539.GD15682@suse.de>
References: <Pine.LNX.4.58.0403220132060.28727@montezuma.fsmlabs.com> <20040322074929.GB15682@suse.de> <Pine.LNX.4.58.0403220311420.28727@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0403220311420.28727@montezuma.fsmlabs.com>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Mar 22, Zwane Mwaikambo wrote:

> On Mon, 22 Mar 2004, Olaf Hering wrote:
> 
> >  On Mon, Mar 22, Zwane Mwaikambo wrote:
> >
> > > In the absence of /init and other nice boot goodies, we fall through to
> > > prepare_namespace() so we shall require initmem to complete boot.
> >
> > Andrew, please restore the previous version of the patch. The 3 liner is
> > much more obvious.
> 
> Olaf, what does the previous patch look like?


.../people/akpm/patches/2.6/2.6.5-rc1/2.6.5-rc1-mm1/broken-out/initramfs-search-for-init.patch

From: Olaf Hering <olh@suse.de>

initramfs can not be used in current 2.6 kernels, the files will never be
executed because prepare_namespace doesn't care about them.  The only way to
workaround that limitation is a root=0:0 cmdline option to force rootfs as
root filesystem.  This will break further booting because rootfs is not the
final root filesystem.

This patch checks for the presence of /init which comes from the cpio archive
(and thats the only way to store files into the rootfs).  This binary/script
has to do all the work of prepare_namespace().



---

 25-akpm/Documentation/early-userspace/README |   26 ++++++++++++++++++++++++++
 25-akpm/init/main.c                          |    7 +++++++
 2 files changed, 33 insertions(+)

diff -puN init/main.c~initramfs-search-for-init init/main.c
--- 25/init/main.c~initramfs-search-for-init	Tue Mar  9 17:00:46 2004
+++ 25-akpm/init/main.c	Tue Mar  9 17:00:46 2004
@@ -604,6 +604,13 @@ static int init(void * unused)
 	sched_init_smp();
 	do_basic_setup();
 
+       /*
+        * check if there is an early userspace init, if yes
+        * let it do all the work
+        */
+       if (sys_access("/init", 0) == 0)
+               execute_command = "/init";
+       else
 	prepare_namespace();
 
 	/*
diff -puN Documentation/early-userspace/README~initramfs-search-for-init Documentation/early-userspace/README
--- 25/Documentation/early-userspace/README~initramfs-search-for-init	Tue Mar  9 17:00:46 2004
+++ 25-akpm/Documentation/early-userspace/README	Tue Mar  9 17:00:46 2004
@@ -71,5 +71,31 @@ custom initramfs images that meet your n
 For questions and help, you can sign up for the early userspace
 mailing list at http://www.zytor.com/mailman/listinfo/klibc
 
+How does it work?
+=================
+
+The kernel has currently 3 ways to mount the root filesystem:
+
+a) all required device and filesystem drivers compiled into the kernel, no
+   initrd.  init/main.c:init() will call prepare_namespace() to mount the
+   final root filesystem, based on the root= option and optional init= to run
+   some other init binary than listed at the end of init/main.c:init().
+
+b) some device and filesystem drivers built as modules and stored in an
+   initrd.  The initrd must contain a binary '/linuxrc' which is supposed to
+   load these driver modules.  It is also possible to mount the final root
+   filesystem via linuxrc and use the pivot_root syscall.  The initrd is
+   mounted and executed via prepare_namespace().
+
+c) using initramfs.  The call to prepare_namespace() must be skipped.
+   This means that a binary must do all the work.  Said binary can be stored
+   into initramfs either via modifying usr/gen_init_cpio.c or via the new
+   initrd format, an cpio archive.  It must be called "/init".  This binary
+   is responsible to do all the things prepare_namespace() would do.
+
+   To remain backwards compatibility, the /init binary will only run if it
+   comes via an initramfs cpio archive.  If this is not the case,
+   init/main.c:init() will run prepare_namespace() to mount the final root
+   and exec one of the predefined init binaries.
 
 Bryan O'Sullivan <bos@serpentine.com>

_

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
