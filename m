Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262207AbSKRLD6>; Mon, 18 Nov 2002 06:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262214AbSKRLD6>; Mon, 18 Nov 2002 06:03:58 -0500
Received: from mx1.elte.hu ([157.181.1.137]:53386 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S262207AbSKRLD5>;
	Mon, 18 Nov 2002 06:03:57 -0500
Date: Mon, 18 Nov 2002 13:26:25 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: Ulrich Drepper <drepper@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] threading fix, tid-2.5.47-A3
In-Reply-To: <1037608252.1774.49.camel@ldb>
Message-ID: <Pine.LNX.4.44.0211181322281.1639-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


and we have VM_DONTCOPY already, which is used by the DRM code. So it
would only be a question of exporting this API to userspace. The attached
patch adds MAP_DONTCOPY. I made it unpriviledged, i doubt it has any
security impact.

	Ingo

--- linux/include/asm-i386/mman.h.orig2	2002-11-18 13:07:16.000000000 +0100
+++ linux/include/asm-i386/mman.h	2002-11-18 13:07:44.000000000 +0100
@@ -20,6 +20,7 @@
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_DONTCOPY	0x20000		/* do not block on IO */
 
 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_INVALIDATE	2		/* invalidate the caches */
--- linux/mm/mmap.c.orig2	2002-11-18 13:08:03.000000000 +0100
+++ linux/mm/mmap.c	2002-11-18 13:08:44.000000000 +0100
@@ -450,6 +450,11 @@
 	 */
 	vm_flags = calc_vm_flags(prot,flags) | mm->def_flags | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
 
+	/*
+	 * Copy the mapping on fork?
+	 */
+	if (flags & MAP_DONTCOPY)
+		vm_flags |= VM_DONTCOPY;
 	if (flags & MAP_LOCKED) {
 		if (!capable(CAP_IPC_LOCK))
 			return -EPERM;

