Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbUCKPWI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 10:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbUCKPWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 10:22:08 -0500
Received: from dirf.bris.ac.uk ([137.222.10.72]:44270 "EHLO dirf.bris.ac.uk")
	by vger.kernel.org with ESMTP id S261413AbUCKPVQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 10:21:16 -0500
Date: Thu, 11 Mar 2004 15:22:17 +0000 (GMT)
From: Bart Oldeman <bartoldeman@users.sourceforge.net>
X-X-Sender: enbeo@enm-bo-lt.enm.bris.ac.uk
To: Andi Kleen <ak@muc.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] introduce a mmap MAP_DONTEXPAND flag
In-Reply-To: <m3d67bas4l.fsf@averell.firstfloor.org>
Message-ID: <Pine.LNX.4.44.0403111519410.5887-100000@enm-bo-lt.enm.bris.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Mar 2004, Andi Kleen wrote:

> Bart Oldeman <bartoldeman@users.sourceforge.net> writes:
>
> >  			return -EPERM;
> > --- include/asm-i386/mman.h~	Sat Oct 25 19:42:58 2003
> > +++ include/asm-i386/mman.h	Thu Mar 11 13:37:33 2004
> > @@ -22,6 +22,7 @@
> >  #define MAP_NORESERVE	0x4000		/* don't check for reservations */
> >  #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
> >  #define MAP_NONBLOCK	0x10000		/* do not block on IO */
> > +#define MAP_DONTEXPAND	0x20000		/* do not allow mremap to expand */
>
> *always* when you change something in asm-i386 check if other architectures
> need changing too. Your patch would break compilation for everybody !i386

that's the reason for my i386 comment and the "RFC". Just asking if people
do or do not like the idea. Anyway, I've done the whole bunch now.

--- mm/mmap.c~	Wed Feb 25 19:21:10 2004
+++ mm/mmap.c	Thu Mar 11 13:39:52 2004
@@ -511,6 +511,10 @@
 	vm_flags = calc_vm_prot_bits(prot) | calc_vm_flag_bits(flags) |
 			mm->def_flags | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;

+	if (flags & MAP_DONTEXPAND) {
+		vm_flags |= VM_DONTEXPAND;
+	}
+
 	if (flags & MAP_LOCKED) {
 		if (!capable(CAP_IPC_LOCK))
 			return -EPERM;
diff -ur include_old/asm-alpha/mman.h include/asm-alpha/mman.h
--- include_old/asm-alpha/mman.h	Sat Oct 25 19:42:47 2003
+++ include/asm-alpha/mman.h	Thu Mar 11 15:09:03 2004
@@ -28,6 +28,7 @@
 #define MAP_NORESERVE	0x10000		/* don't check for reservations */
 #define MAP_POPULATE	0x20000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x40000		/* do not block on IO */
+#define MAP_DONTEXPAND	0x80000		/* do not allow mremap to expand */

 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_SYNC		2		/* synchronous memory sync */
diff -ur include_old/asm-arm/mman.h include/asm-arm/mman.h
--- include_old/asm-arm/mman.h	Sat Oct 25 19:43:19 2003
+++ include/asm-arm/mman.h	Thu Mar 11 15:09:09 2004
@@ -22,6 +22,7 @@
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
 #define MAP_POPULATE	0x8000		/* populate (prefault) page tables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_DONTEXPAND	0x20000		/* do not allow mremap to expand */

 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_INVALIDATE	2		/* invalidate the caches */
diff -ur include_old/asm-arm26/mman.h include/asm-arm26/mman.h
--- include_old/asm-arm26/mman.h	Sat Oct 25 19:42:49 2003
+++ include/asm-arm26/mman.h	Thu Mar 11 15:09:15 2004
@@ -22,6 +22,7 @@
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
 #define MAP_POPULATE    0x8000          /* populate (prefault) page tables */
 #define MAP_NONBLOCK    0x10000         /* do not block on IO */
+#define MAP_DONTEXPAND	0x20000		/* do not allow mremap to expand */

 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_INVALIDATE	2		/* invalidate the caches */
diff -ur include_old/asm-cris/mman.h include/asm-cris/mman.h
--- include_old/asm-cris/mman.h	Sat Oct 25 19:44:49 2003
+++ include/asm-cris/mman.h	Thu Mar 11 15:09:19 2004
@@ -24,6 +24,7 @@
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_DONTEXPAND	0x20000		/* do not allow mremap to expand */

 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_INVALIDATE	2		/* invalidate the caches */
diff -ur include_old/asm-h8300/mman.h include/asm-h8300/mman.h
--- include_old/asm-h8300/mman.h	Sat Oct 25 19:43:51 2003
+++ include/asm-h8300/mman.h	Thu Mar 11 15:09:40 2004
@@ -19,6 +19,7 @@
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_LOCKED	0x2000		/* pages are locked */
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
+#define MAP_DONTEXPAND	0x8000		/* do not allow mremap to expand */

 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_INVALIDATE	2		/* invalidate the caches */
diff -ur include_old/asm-i386/mman.h include/asm-i386/mman.h
--- include_old/asm-i386/mman.h	Sat Oct 25 19:42:58 2003
+++ include/asm-i386/mman.h	Thu Mar 11 15:08:26 2004
@@ -22,6 +22,7 @@
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_DONTEXPAND	0x20000		/* do not allow mremap to expand */

 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_INVALIDATE	2		/* invalidate the caches */
diff -ur include_old/asm-ia64/mman.h include/asm-ia64/mman.h
--- include_old/asm-ia64/mman.h	Wed Feb 25 19:21:01 2004
+++ include/asm-ia64/mman.h	Thu Mar 11 15:11:10 2004
@@ -30,6 +30,7 @@
 #define MAP_NORESERVE	0x04000		/* don't check for reservations */
 #define MAP_POPULATE	0x08000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_DONTEXPAND	0x20000		/* do not allow mremap to expand */

 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_INVALIDATE	2		/* invalidate the caches */
diff -ur include_old/asm-m68k/mman.h include/asm-m68k/mman.h
--- include_old/asm-m68k/mman.h	Sat Oct 25 19:43:02 2003
+++ include/asm-m68k/mman.h	Thu Mar 11 15:11:06 2004
@@ -22,6 +22,7 @@
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_DONTEXPAND	0x20000		/* do not allow mremap to expand */

 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_INVALIDATE	2		/* invalidate the caches */
diff -ur include_old/asm-ppc/mman.h include/asm-ppc/mman.h
--- include_old/asm-ppc/mman.h	Sat Oct 25 19:45:07 2003
+++ include/asm-ppc/mman.h	Thu Mar 11 15:10:54 2004
@@ -23,6 +23,7 @@
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_DONTEXPAND	0x20000		/* do not allow mremap to expand */

 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_INVALIDATE	2		/* invalidate the caches */
diff -ur include_old/asm-ppc64/mman.h include/asm-ppc64/mman.h
--- include_old/asm-ppc64/mman.h	Sat Oct 25 19:43:30 2003
+++ include/asm-ppc64/mman.h	Thu Mar 11 15:10:50 2004
@@ -28,6 +28,7 @@
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
+#define MAP_DONTEXPAND	0x2000		/* do not allow mremap to expand */

 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_INVALIDATE	2		/* invalidate the caches */
diff -ur include_old/asm-s390/mman.h include/asm-s390/mman.h
--- include_old/asm-s390/mman.h	Sat Oct 25 19:42:53 2003
+++ include/asm-s390/mman.h	Thu Mar 11 15:10:42 2004
@@ -30,6 +30,7 @@
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_DONTEXPAND	0x20000		/* do not allow mremap to expand */

 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_INVALIDATE	2		/* invalidate the caches */
diff -ur include_old/asm-sh/mman.h include/asm-sh/mman.h
--- include_old/asm-sh/mman.h	Sat Oct 25 19:44:35 2003
+++ include/asm-sh/mman.h	Thu Mar 11 15:10:37 2004
@@ -22,6 +22,7 @@
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
 #define MAP_POPULATE	0x8000		/* populate (prefault) page tables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_DONTEXPAND	0x20000		/* do not allow mremap to expand */

 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_INVALIDATE	2		/* invalidate the caches */
diff -ur include_old/asm-sparc/mman.h include/asm-sparc/mman.h
--- include_old/asm-sparc/mman.h	Sat Oct 25 19:44:48 2003
+++ include/asm-sparc/mman.h	Thu Mar 11 15:10:30 2004
@@ -26,6 +26,7 @@
 #define MAP_GROWSDOWN	0x0200		/* stack-like segment */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
+#define MAP_DONTEXPAND	0x2000		/* do not allow mremap to expand */

 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_INVALIDATE	2		/* invalidate the caches */
diff -ur include_old/asm-sparc64/mman.h include/asm-sparc64/mman.h
--- include_old/asm-sparc64/mman.h	Sat Oct 25 19:43:36 2003
+++ include/asm-sparc64/mman.h	Thu Mar 11 15:10:21 2004
@@ -26,6 +26,7 @@
 #define MAP_GROWSDOWN	0x0200		/* stack-like segment */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
+#define MAP_DONTEXPAND	0x2000		/* do not allow mremap to expand */

 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_INVALIDATE	2		/* invalidate the caches */
diff -ur include_old/asm-v850/mman.h include/asm-v850/mman.h
--- include_old/asm-v850/mman.h	Sat Oct 25 19:44:34 2003
+++ include/asm-v850/mman.h	Thu Mar 11 15:10:00 2004
@@ -19,6 +19,7 @@
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_LOCKED	0x2000		/* pages are locked */
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
+#define MAP_DONTEXPAND	0x8000		/* do not allow mremap to expand */

 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_INVALIDATE	2		/* invalidate the caches */
diff -ur include_old/asm-x86_64/mman.h include/asm-x86_64/mman.h
--- include_old/asm-x86_64/mman.h	Sat Oct 25 19:44:05 2003
+++ include/asm-x86_64/mman.h	Thu Mar 11 15:08:38 2004
@@ -23,6 +23,7 @@
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_DONTEXPAND	0x20000		/* do not allow mremap to expand */

 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_INVALIDATE	2		/* invalidate the caches */

