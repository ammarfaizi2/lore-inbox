Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317381AbSFMAX3>; Wed, 12 Jun 2002 20:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317380AbSFMAX2>; Wed, 12 Jun 2002 20:23:28 -0400
Received: from [209.237.59.50] ([209.237.59.50]:48209 "EHLO
	zinfandel.topspincom.com") by vger.kernel.org with ESMTP
	id <S317381AbSFMAXX>; Wed, 12 Jun 2002 20:23:23 -0400
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: David Brownell <david-b@pacbell.net>, Oliver Neukum <oliver@neukum.name>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4 add __dma_buffer alignment macro
In-Reply-To: <20020611.202553.28822742.davem@redhat.com>
	<20020611173347.21348@smtp.adsl.oleane.com>
	<20020612.024224.60294929.davem@redhat.com>
	<3D075739.7010506@pacbell.net> <52zny049r7.fsf@topspin.com>
	<3D079D44.4000701@pacbell.net>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 12 Jun 2002 17:23:19 -0700
Message-ID: <52wut42fig.fsf_-_@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following up on the "PCI DMA to small buffers on cache-incoherent
arch" discussion, here is a patch that adds <asm/dma_buffer.h>, which
contains a __dma_buffer alignment macro for DMA into buffers in the
middle of structures.

I only implemented for i386 and ppc, I don't know enough about other
architectures to get them right.

Thanks,
  Roland

 Documentation/DMA-mapping.txt    |   27 +++++++++++++++++++++++++++
 include/asm-alpha/dma_buffer.h   |   22 ++++++++++++++++++++++
 include/asm-arm/dma_buffer.h     |   22 ++++++++++++++++++++++
 include/asm-cris/dma_buffer.h    |   22 ++++++++++++++++++++++
 include/asm-i386/dma_buffer.h    |   23 +++++++++++++++++++++++
 include/asm-ia64/dma_buffer.h    |   22 ++++++++++++++++++++++
 include/asm-m68k/dma_buffer.h    |   22 ++++++++++++++++++++++
 include/asm-mips/dma_buffer.h    |   22 ++++++++++++++++++++++
 include/asm-mips64/dma_buffer.h  |   22 ++++++++++++++++++++++
 include/asm-parisc/dma_buffer.h  |   22 ++++++++++++++++++++++
 include/asm-ppc/dma_buffer.h     |   38 ++++++++++++++++++++++++++++++++++++++
 include/asm-s390/dma_buffer.h    |   22 ++++++++++++++++++++++
 include/asm-s390x/dma_buffer.h   |   22 ++++++++++++++++++++++
 include/asm-sh/dma_buffer.h      |   22 ++++++++++++++++++++++
 include/asm-sparc/dma_buffer.h   |   22 ++++++++++++++++++++++
 include/asm-sparc64/dma_buffer.h |   22 ++++++++++++++++++++++
 16 files changed, 374 insertions(+)

diff -Naur linux-2.4.18.orig/Documentation/DMA-mapping.txt linux-2.4.18/Documentation/DMA-mapping.txt
--- linux-2.4.18.orig/Documentation/DMA-mapping.txt	Mon Feb 25 11:37:51 2002
+++ linux-2.4.18/Documentation/DMA-mapping.txt	Wed Jun 12 13:38:30 2002
@@ -67,6 +67,33 @@
 networking subsystems make sure that the buffers they use are valid
 for you to DMA from/to.
 
+Note that on non-cache-coherent architectures, having a DMA buffer
+that shares a cache line with other data can lead to memory
+corruption.  The __dma_buffer macro defined in <asm/dma_buffer.h>
+exists to allow safe DMA buffers to be declared easily and portably as
+part of larger structures without causing bloat on cache-coherent
+architectures.  Of course these structures must be contained in memory
+that can be used for DMA as described above.
+
+To use __dma_buffer, just declare a struct like:
+
+	struct mydevice {
+		    int field1;
+		    char buffer[BUFFER_SIZE] __dma_buffer;
+		    int field2;
+	};
+	
+If this is used in code like:
+
+	struct mydevice *dev;
+	dev = kmalloc(sizeof *dev, GFP_KERNEL);
+
+then dev->buffer will be safe for DMA on all architectures.  On a
+cache-coherent architecture the members of dev will be aligned exactly
+as they would have been without __dma_buffer; on a non-cache-coherent
+architecture buffer and field2 will be aligned so that buffer does not
+share a cache line with any other data.
+
 			DMA addressing limitations
 
 Does your device have any DMA addressing limitations?  For example, is
diff -Naur linux-2.4.18.orig/include/asm-alpha/dma_buffer.h linux-2.4.18/include/asm-alpha/dma_buffer.h
--- linux-2.4.18.orig/include/asm-alpha/dma_buffer.h	Wed Dec 31 16:00:00 1969
+++ linux-2.4.18/include/asm-alpha/dma_buffer.h	Wed Jun 12 13:38:30 2002
@@ -0,0 +1,22 @@
+/*
+ *  __dma_buffer macro for safe DMA into struct members
+ *
+ *  See "What memory is DMA'able?" in Documentation/DMA-mapping.txt
+ *  for more information.
+ *
+ *  Copyright (c) 2002  Roland Dreier <roland@digitalvampire.org>
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+
+#ifdef __KERNEL__
+#ifndef _ASM_ALPHA_DMA_BUFFER_H
+#define _ASM_ALPHA_DMA_BUFFER_H
+
+#warning <asm/dma_buffer.h> is not implemented yet for alpha
+
+#endif /* _ASM_ALPHA_DMA_BUFFER_H */
+#endif /* __KERNEL__ */
diff -Naur linux-2.4.18.orig/include/asm-arm/dma_buffer.h linux-2.4.18/include/asm-arm/dma_buffer.h
--- linux-2.4.18.orig/include/asm-arm/dma_buffer.h	Wed Dec 31 16:00:00 1969
+++ linux-2.4.18/include/asm-arm/dma_buffer.h	Wed Jun 12 13:45:45 2002
@@ -0,0 +1,22 @@
+/*
+ *  __dma_buffer macro for safe DMA into struct members
+ *
+ *  See "What memory is DMA'able?" in Documentation/DMA-mapping.txt
+ *  for more information.
+ *
+ *  Copyright (c) 2002  Roland Dreier <roland@digitalvampire.org>
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+
+#ifdef __KERNEL__
+#ifndef _ASM_ARM_DMA_BUFFER_H
+#define _ASM_ARM_DMA_BUFFER_H
+
+#warning <asm/dma_buffer.h> is not implemented yet for arm
+
+#endif /* _ASM_ARM_DMA_BUFFER_H */
+#endif /* __KERNEL__ */
diff -Naur linux-2.4.18.orig/include/asm-cris/dma_buffer.h linux-2.4.18/include/asm-cris/dma_buffer.h
--- linux-2.4.18.orig/include/asm-cris/dma_buffer.h	Wed Dec 31 16:00:00 1969
+++ linux-2.4.18/include/asm-cris/dma_buffer.h	Wed Jun 12 13:38:30 2002
@@ -0,0 +1,22 @@
+/*
+ *  __dma_buffer macro for safe DMA into struct members
+ *
+ *  See "What memory is DMA'able?" in Documentation/DMA-mapping.txt
+ *  for more information.
+ *
+ *  Copyright (c) 2002  Roland Dreier <roland@digitalvampire.org>
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+
+#ifdef __KERNEL__
+#ifndef _ASM_CRIS_DMA_BUFFER_H
+#define _ASM_CRIS_DMA_BUFFER_H
+
+#warning <asm/dma_buffer.h> is not implemented yet for cris
+
+#endif /* _ASM_CRIS_DMA_BUFFER_H */
+#endif /* __KERNEL__ */
diff -Naur linux-2.4.18.orig/include/asm-i386/dma_buffer.h linux-2.4.18/include/asm-i386/dma_buffer.h
--- linux-2.4.18.orig/include/asm-i386/dma_buffer.h	Wed Dec 31 16:00:00 1969
+++ linux-2.4.18/include/asm-i386/dma_buffer.h	Wed Jun 12 13:38:30 2002
@@ -0,0 +1,23 @@
+/*
+ *  __dma_buffer macro for safe DMA into struct members
+ *
+ *  See "What memory is DMA'able?" in Documentation/DMA-mapping.txt
+ *  for more information.
+ *
+ *  Copyright (c) 2002  Roland Dreier <roland@digitalvampire.org>
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+
+#ifdef __KERNEL__
+#ifndef _ASM_I386_DMA_BUFFER_H
+#define _ASM_I386_DMA_BUFFER_H
+
+/* We have cache-coherent DMA so __dma_buffer is defined to be a NOP */
+#define __dma_buffer
+
+#endif /* _ASM_I386_DMA_BUFFER_H */
+#endif /* __KERNEL__ */
diff -Naur linux-2.4.18.orig/include/asm-ia64/dma_buffer.h linux-2.4.18/include/asm-ia64/dma_buffer.h
--- linux-2.4.18.orig/include/asm-ia64/dma_buffer.h	Wed Dec 31 16:00:00 1969
+++ linux-2.4.18/include/asm-ia64/dma_buffer.h	Wed Jun 12 13:38:30 2002
@@ -0,0 +1,22 @@
+/*
+ *  __dma_buffer macro for safe DMA into struct members
+ *
+ *  See "What memory is DMA'able?" in Documentation/DMA-mapping.txt
+ *  for more information.
+ *
+ *  Copyright (c) 2002  Roland Dreier <roland@digitalvampire.org>
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+
+#ifdef __KERNEL__
+#ifndef _ASM_IA64_DMA_BUFFER_H
+#define _ASM_IA64_DMA_BUFFER_H
+
+#warning <asm/dma_buffer.h> is not implemented yet for ia64
+
+#endif /* _ASM_IA64_DMA_BUFFER_H */
+#endif /* __KERNEL__ */
diff -Naur linux-2.4.18.orig/include/asm-m68k/dma_buffer.h linux-2.4.18/include/asm-m68k/dma_buffer.h
--- linux-2.4.18.orig/include/asm-m68k/dma_buffer.h	Wed Dec 31 16:00:00 1969
+++ linux-2.4.18/include/asm-m68k/dma_buffer.h	Wed Jun 12 13:38:30 2002
@@ -0,0 +1,22 @@
+/*
+ *  __dma_buffer macro for safe DMA into struct members
+ *
+ *  See "What memory is DMA'able?" in Documentation/DMA-mapping.txt
+ *  for more information.
+ *
+ *  Copyright (c) 2002  Roland Dreier <roland@digitalvampire.org>
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+
+#ifdef __KERNEL__
+#ifndef _ASM_M68K_DMA_BUFFER_H
+#define _ASM_M68K_DMA_BUFFER_H
+
+#warning <asm/dma_buffer.h> is not implemented yet for m68k
+
+#endif /* _ASM_M68K_DMA_BUFFER_H */
+#endif /* __KERNEL__ */
diff -Naur linux-2.4.18.orig/include/asm-mips/dma_buffer.h linux-2.4.18/include/asm-mips/dma_buffer.h
--- linux-2.4.18.orig/include/asm-mips/dma_buffer.h	Wed Dec 31 16:00:00 1969
+++ linux-2.4.18/include/asm-mips/dma_buffer.h	Wed Jun 12 13:38:30 2002
@@ -0,0 +1,22 @@
+/*
+ *  __dma_buffer macro for safe DMA into struct members
+ *
+ *  See "What memory is DMA'able?" in Documentation/DMA-mapping.txt
+ *  for more information.
+ *
+ *  Copyright (c) 2002  Roland Dreier <roland@digitalvampire.org>
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+
+#ifdef __KERNEL__
+#ifndef _ASM_MIPS_DMA_BUFFER_H
+#define _ASM_MIPS_DMA_BUFFER_H
+
+#warning <asm/dma_buffer.h> is not implemented yet for mips
+
+#endif /* _ASM_MIPS_DMA_BUFFER_H */
+#endif /* __KERNEL__ */
diff -Naur linux-2.4.18.orig/include/asm-mips64/dma_buffer.h linux-2.4.18/include/asm-mips64/dma_buffer.h
--- linux-2.4.18.orig/include/asm-mips64/dma_buffer.h	Wed Dec 31 16:00:00 1969
+++ linux-2.4.18/include/asm-mips64/dma_buffer.h	Wed Jun 12 13:38:30 2002
@@ -0,0 +1,22 @@
+/*
+ *  __dma_buffer macro for safe DMA into struct members
+ *
+ *  See "What memory is DMA'able?" in Documentation/DMA-mapping.txt
+ *  for more information.
+ *
+ *  Copyright (c) 2002  Roland Dreier <roland@digitalvampire.org>
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+
+#ifdef __KERNEL__
+#ifndef _ASM_MIPS64_DMA_BUFFER_H
+#define _ASM_MIPS64_DMA_BUFFER_H
+
+#warning <asm/dma_buffer.h> is not implemented yet for mips64
+
+#endif /* _ASM_MIPS64_DMA_BUFFER_H */
+#endif /* __KERNEL__ */
diff -Naur linux-2.4.18.orig/include/asm-parisc/dma_buffer.h linux-2.4.18/include/asm-parisc/dma_buffer.h
--- linux-2.4.18.orig/include/asm-parisc/dma_buffer.h	Wed Dec 31 16:00:00 1969
+++ linux-2.4.18/include/asm-parisc/dma_buffer.h	Wed Jun 12 13:38:30 2002
@@ -0,0 +1,22 @@
+/*
+ *  __dma_buffer macro for safe DMA into struct members
+ *
+ *  See "What memory is DMA'able?" in Documentation/DMA-mapping.txt
+ *  for more information.
+ *
+ *  Copyright (c) 2002  Roland Dreier <roland@digitalvampire.org>
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+
+#ifdef __KERNEL__
+#ifndef _ASM_PARISC_DMA_BUFFER_H
+#define _ASM_PARISC_DMA_BUFFER_H
+
+#warning <asm/dma_buffer.h> is not implemented yet for parisc
+
+#endif /* _ASM_PARISC_DMA_BUFFER_H */
+#endif /* __KERNEL__ */
diff -Naur linux-2.4.18.orig/include/asm-ppc/dma_buffer.h linux-2.4.18/include/asm-ppc/dma_buffer.h
--- linux-2.4.18.orig/include/asm-ppc/dma_buffer.h	Wed Dec 31 16:00:00 1969
+++ linux-2.4.18/include/asm-ppc/dma_buffer.h	Wed Jun 12 13:38:30 2002
@@ -0,0 +1,38 @@
+/*
+ *  __dma_buffer macro for safe DMA into struct members
+ *
+ *  See "What memory is DMA'able?" in Documentation/DMA-mapping.txt
+ *  for more information.
+ *
+ *  Copyright (c) 2002  Roland Dreier <roland@digitalvampire.org>
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.  */
+
+#ifdef __KERNEL__
+#ifndef _ASM_PPC_DMA_BUFFER_H
+#define _ASM_PPC_DMA_BUFFER_H
+
+#include <linux/config.h>
+
+#ifdef CONFIG_NOT_COHERENT_CACHE
+
+#include <asm/cache.h>
+
+#define __dma_buffer __dma_buffer_line(__LINE__)
+#define __dma_buffer_line(line) __dma_buffer_expand_line(line)
+#define __dma_buffer_expand_line(line) \
+	__attribute__ ((aligned(L1_CACHE_BYTES))); \
+	char __dma_pad_ ## line [0] __attribute__ ((aligned(L1_CACHE_BYTES)))
+
+#else  /* CONFIG_NOT_COHERENT_CACHE */
+
+/* We have cache-coherent DMA so __dma_buffer is defined to be a NOP */
+#define __dma_buffer
+
+#endif /* CONFIG_NOT_COHERENT_CACHE */
+
+#endif /* _ASM_PPC_DMA_BUFFER_H */
+#endif /* __KERNEL__ */
diff -Naur linux-2.4.18.orig/include/asm-s390/dma_buffer.h linux-2.4.18/include/asm-s390/dma_buffer.h
--- linux-2.4.18.orig/include/asm-s390/dma_buffer.h	Wed Dec 31 16:00:00 1969
+++ linux-2.4.18/include/asm-s390/dma_buffer.h	Wed Jun 12 13:38:30 2002
@@ -0,0 +1,22 @@
+/*
+ *  __dma_buffer macro for safe DMA into struct members
+ *
+ *  See "What memory is DMA'able?" in Documentation/DMA-mapping.txt
+ *  for more information.
+ *
+ *  Copyright (c) 2002  Roland Dreier <roland@digitalvampire.org>
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+
+#ifdef __KERNEL__
+#ifndef _ASM_S390_DMA_BUFFER_H
+#define _ASM_S390_DMA_BUFFER_H
+
+#warning <asm/dma_buffer.h> is not implemented yet for s390
+
+#endif /* _ASM_S390_DMA_BUFFER_H */
+#endif /* __KERNEL__ */
diff -Naur linux-2.4.18.orig/include/asm-s390x/dma_buffer.h linux-2.4.18/include/asm-s390x/dma_buffer.h
--- linux-2.4.18.orig/include/asm-s390x/dma_buffer.h	Wed Dec 31 16:00:00 1969
+++ linux-2.4.18/include/asm-s390x/dma_buffer.h	Wed Jun 12 13:38:30 2002
@@ -0,0 +1,22 @@
+/*
+ *  __dma_buffer macro for safe DMA into struct members
+ *
+ *  See "What memory is DMA'able?" in Documentation/DMA-mapping.txt
+ *  for more information.
+ *
+ *  Copyright (c) 2002  Roland Dreier <roland@digitalvampire.org>
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+
+#ifdef __KERNEL__
+#ifndef _ASM_S390X_DMA_BUFFER_H
+#define _ASM_S390X_DMA_BUFFER_H
+
+#warning <asm/dma_buffer.h> is not implemented yet for s390x
+
+#endif /* _ASM_S390X_DMA_BUFFER_H */
+#endif /* __KERNEL__ */
diff -Naur linux-2.4.18.orig/include/asm-sh/dma_buffer.h linux-2.4.18/include/asm-sh/dma_buffer.h
--- linux-2.4.18.orig/include/asm-sh/dma_buffer.h	Wed Dec 31 16:00:00 1969
+++ linux-2.4.18/include/asm-sh/dma_buffer.h	Wed Jun 12 13:38:30 2002
@@ -0,0 +1,22 @@
+/*
+ *  __dma_buffer macro for safe DMA into struct members
+ *
+ *  See "What memory is DMA'able?" in Documentation/DMA-mapping.txt
+ *  for more information.
+ *
+ *  Copyright (c) 2002  Roland Dreier <roland@digitalvampire.org>
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+
+#ifdef __KERNEL__
+#ifndef _ASM_SH_DMA_BUFFER_H
+#define _ASM_SH_DMA_BUFFER_H
+
+#warning <asm/dma_buffer.h> is not implemented yet for sh
+
+#endif /* _ASM_SH_DMA_BUFFER_H */
+#endif /* __KERNEL__ */
diff -Naur linux-2.4.18.orig/include/asm-sparc/dma_buffer.h linux-2.4.18/include/asm-sparc/dma_buffer.h
--- linux-2.4.18.orig/include/asm-sparc/dma_buffer.h	Wed Dec 31 16:00:00 1969
+++ linux-2.4.18/include/asm-sparc/dma_buffer.h	Wed Jun 12 13:38:30 2002
@@ -0,0 +1,22 @@
+/*
+ *  __dma_buffer macro for safe DMA into struct members
+ *
+ *  See "What memory is DMA'able?" in Documentation/DMA-mapping.txt
+ *  for more information.
+ *
+ *  Copyright (c) 2002  Roland Dreier <roland@digitalvampire.org>
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+
+#ifdef __KERNEL__
+#ifndef _ASM_SPARC_DMA_BUFFER_H
+#define _ASM_SPARC_DMA_BUFFER_H
+
+#warning <asm/dma_buffer.h> is not implemented yet for sparc
+
+#endif /* _ASM_SPARC_DMA_BUFFER_H */
+#endif /* __KERNEL__ */
diff -Naur linux-2.4.18.orig/include/asm-sparc64/dma_buffer.h linux-2.4.18/include/asm-sparc64/dma_buffer.h
--- linux-2.4.18.orig/include/asm-sparc64/dma_buffer.h	Wed Dec 31 16:00:00 1969
+++ linux-2.4.18/include/asm-sparc64/dma_buffer.h	Wed Jun 12 13:38:30 2002
@@ -0,0 +1,22 @@
+/*
+ *  __dma_buffer macro for safe DMA into struct members
+ *
+ *  See "What memory is DMA'able?" in Documentation/DMA-mapping.txt
+ *  for more information.
+ *
+ *  Copyright (c) 2002  Roland Dreier <roland@digitalvampire.org>
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+
+#ifdef __KERNEL__
+#ifndef _ASM_SPARC64_DMA_BUFFER_H
+#define _ASM_SPARC64_DMA_BUFFER_H
+
+#warning <asm/dma_buffer.h> is not implemented yet for sparc64
+
+#endif /* _ASM_SPARC64_DMA_BUFFER_H */
+#endif /* __KERNEL__ */
