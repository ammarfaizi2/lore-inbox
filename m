Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266063AbUAFFp4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 00:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266065AbUAFFp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 00:45:56 -0500
Received: from modemcable178.89-70-69.mc.videotron.ca ([69.70.89.178]:25475
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S266063AbUAFFpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 00:45:53 -0500
Date: Tue, 6 Jan 2004 00:44:54 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Alexander Hoogerhuis <alexh@ihatent.com>
cc: earny@net4u.de, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 under vmware ?
In-Reply-To: <87u13aaas7.fsf@lapper.ihatent.com>
Message-ID: <Pine.LNX.4.58.0401060043450.3405@montezuma.fsmlabs.com>
References: <1073297203.12550.30.camel@bip.parateam.prv> <200401051221.30398.earny@net4u.de>
 <87u13aaas7.fsf@lapper.ihatent.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jan 2004, Alexander Hoogerhuis wrote:

> Ernst Herzberg <earny@net4u.de> writes:
>
> > On Montag, 5. Januar 2004 11:06, Xavier Bestel wrote:
> > > Hi,
> > >
> > > I have problems running 2.6.0 under vmware (4.02 and 4.05). I did a
> > > basic debian/sid install, then installed various 2.6.0 kernel images
> > > (with or without initrd, from debian (-test9 and -test11) or self-made
> > > (stock 2.6.0).
> > > They all make /sbin/init (from sysvinit 2.85) segfault at a particular
> > > address (I haven't yet recompiled it with -g to see where, but a
> > > dissassembly shows it's a "ret").
> > > I try booting to /bin/sh from the initrd, and there I can play with the
> > > shell, mount the alternate root, play with commands there, and then exec
> > > /sbin/init, but it segfaults at the same point.
> > >
> > > Has anyone managed to make a basic debian with 2.6 work under vmware ?
> > > Has anyone managed to make another distro with 2.6 work under vmware ?
> >
> > Same problem here. Tried gentoo with 2.6.0 and 2.6.1-rc1: /sbin/init will
> > segfault. Testet vmware on a Dual PIII 2.4.23-pre3 and a Athlon XP with
> > 2.6.1-rc1.
> >
>
> Ack that, P4 with 2.6.0-mmX and 2.6.1-rc1-mmX :)

Does the following make a difference for you? Please note that
an updated VMWare 4 doesn't have this problem.

Index: linux-2.5.69-mm5/Documentation/kernel-parameters.txt
===================================================================
RCS file: /build/cvsroot/linux-2.5.69/Documentation/kernel-parameters.txt,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 kernel-parameters.txt
--- linux-2.5.69-mm5/Documentation/kernel-parameters.txt	6 May 2003 12:21:18 -0000	1.1.1.1
+++ linux-2.5.69-mm5/Documentation/kernel-parameters.txt	15 May 2003 15:14:23 -0000
@@ -1063,6 +1063,10 @@ running once the system is up.

 	sym53c8xx=	[HW,SCSI]
 			See Documentation/scsi/ncr53c8xx.txt.
+
+	nosysenter	[IA-32]
+			Disable SYSENTER for syscalls, does not clear the SEP
+			capabilities bit.

 	t128=		[HW,SCSI]
 			See header of drivers/scsi/t128.c.
Index: linux-2.5.69-mm5/arch/i386/kernel/sysenter.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.69/arch/i386/kernel/sysenter.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 sysenter.c
--- linux-2.5.69-mm5/arch/i386/kernel/sysenter.c	6 May 2003 12:20:51 -0000	1.1.1.1
+++ linux-2.5.69-mm5/arch/i386/kernel/sysenter.c	15 May 2003 07:46:05 -0000
@@ -20,6 +20,7 @@
 #include <asm/unistd.h>

 extern asmlinkage void sysenter_entry(void);
+static int nosysenter __initdata;

 /*
  * Create a per-cpu fake "SEP thread" stack, so that we can
@@ -51,6 +52,13 @@ void enable_sep_cpu(void *info)
 	put_cpu();
 }

+static int __init do_nosysenter(char *s)
+{
+	nosysenter = 1;
+	return 1;
+}
+__setup("nosysenter", do_nosysenter);
+
 /*
  * These symbols are defined by vsyscall.o to mark the bounds
  * of the ELF DSO images included therein.
@@ -64,7 +72,7 @@ static int __init sysenter_setup(void)

 	__set_fixmap(FIX_VSYSCALL, __pa(page), PAGE_READONLY);

-	if (!boot_cpu_has(X86_FEATURE_SEP)) {
+	if (nosysenter || !boot_cpu_has(X86_FEATURE_SEP)) {
 		memcpy((void *) page,
 		       &vsyscall_int80_start,
 		       &vsyscall_int80_end - &vsyscall_int80_start);
