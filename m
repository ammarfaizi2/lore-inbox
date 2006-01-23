Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964846AbWAWHy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbWAWHy5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 02:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbWAWHy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 02:54:57 -0500
Received: from aun.it.uu.se ([130.238.12.36]:30198 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S964846AbWAWHy5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 02:54:57 -0500
Date: Mon, 23 Jan 2006 08:54:29 +0100 (MET)
Message-Id: <200601230754.k0N7sTce014819@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org, ulrich.windl@rz.uni-regensburg.de
Subject: Re: Fixes to compile 2.4.32 with gcc-4.0.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2006 08:07:42 +0100, Ulrich Windl wrote:
>I'm no real C guru, neither am I a kernel guru, but I managed to compile Linux-
>2.4.32 with gcc-4.0.2 (I also could boot that kernel, but couldn't load the 
>modules as SuSE 10.0 lacks the old mudutils required to do that).
>
>Please have a look at the attached diffs, as som of my fixes seem to wipe out some 
>real C nonsense, independent of the compiler issues.
>
>Note: gcc still produces a _lot_ of warnings, but at least the kernel compiles.

Well-tested fixes for gcc-4.0.x and recent 2.4 kernels on
i386, x86_64, and ppc(32) are available in
<http://www.csd.uu.se/~mikpe/linux/patches/2.4/>.
Look for the patch-gcc4-fixes-v<N>-<KERNELVERSION> file that
matches your kernel version.

There is also a patch-more-gcc4-fixes-v1-<KERNELVERSION> file
but those changes were only compile-tested once (due to me not
being able to test them at runtime).

I'd be happy to extend these patches if you find that something
important is missing from them.

2.4 is in deep feature freeze and gcc-4 fixes are not being
accepted into the standard 2.4 tree.

>Index: drivers/scsi/aic7xxx/Makefile
>===================================================================
>RCS file: /root/LinuxCVS/Kernel/drivers/scsi/aic7xxx/Makefile,v
>retrieving revision 1.1.1.6
>diff -u -r1.1.1.6 Makefile
>--- drivers/scsi/aic7xxx/Makefile	22 Jan 2005 20:43:25 -0000	1.1.1.6
>+++ drivers/scsi/aic7xxx/Makefile	20 Jan 2006 20:55:44 -0000
>@@ -13,7 +13,7 @@
> obj-$(CONFIG_SCSI_AIC79XX)	+= aic79xx.o
> endif
> 
>-EXTRA_CFLAGS += -I$(TOPDIR)/drivers/scsi -Werror
>+EXTRA_CFLAGS += -I$(TOPDIR)/drivers/scsi #-Werror
> #EXTRA_CFLAGS += -g
> 
> # Platform Specific Files

Better to find and fix the causes of those warnings.

>Index: drivers/sound/sound_firmware.c
>===================================================================
>RCS file: /root/LinuxCVS/Kernel/drivers/sound/sound_firmware.c,v
>retrieving revision 1.1.1.2
>diff -u -r1.1.1.2 sound_firmware.c
>--- drivers/sound/sound_firmware.c	11 Mar 2001 13:55:33 -0000	1.1.1.2
>+++ drivers/sound/sound_firmware.c	21 Jan 2006 22:27:06 -0000
>@@ -7,7 +7,6 @@
> #include <linux/unistd.h>
> #include <asm/uaccess.h>
> 
>-static int errno;
> static int do_mod_firmware_load(const char *fn, char **fp)
> {
> 	int fd;

This changes the semantics of the in-kernel system calls
called here so they now clobber a global errno. My solution
was to force the syscall wrappers to use a local variable
'my_errno'.

/Mikael
