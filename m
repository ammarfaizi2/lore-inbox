Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbUCKOCb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 09:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbUCKOCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 09:02:31 -0500
Received: from dire.bris.ac.uk ([137.222.10.60]:8385 "EHLO dire.bris.ac.uk")
	by vger.kernel.org with ESMTP id S261340AbUCKOC1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 09:02:27 -0500
Date: Thu, 11 Mar 2004 14:03:50 +0000 (GMT)
From: Bart Oldeman <bartoldeman@users.sourceforge.net>
X-X-Sender: enbeo@enm-bo-lt.enm.bris.ac.uk
To: linux-kernel@vger.kernel.org
Subject: [PATCH][RFC] introduce a mmap MAP_DONTEXPAND flag
Message-ID: <Pine.LNX.4.44.0403111355080.5328-100000@enm-bo-lt.enm.bris.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes it is advantageous to mmap a special portion of /dev/mem
(framebuffer, ...) before dropping root priviliges. However right now a
program can simply mremap that area even after dropping root and if the
/dev/mem file descriptor is closed, thus being able to access arbitrary
portions of /dev/mem beyond the initial VMA start.

An idea to get around this is to expose the VM_DONTEXPAND flag to user
space via a MAP_DONTEXPAND flag, to be able to get failure in the
following example program (when it's suid-root):

#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include <sys/mman.h>

#define MAP_DONTEXPAND 0x20000

int main(void)
{
	int fd = open("/dev/mem", O_RDWR);
	mmap((char *)0xb8000, 0x8000, PROT_READ | PROT_WRITE,
          MAP_SHARED|MAP_FIXED|MAP_DONTEXPAND, fd, 0xb8000);
	close(fd);
	setuid(getuid());
	printf("%x\n", mremap((char *)0xb8000, 0x8000, 0x1000000, 0));
}


The patch below (for 2.6.3) is for i386 only but is easy to adjust
for other architectures, just because each of them has their own asm/mman.h.

Unless I'm completely overlooking something here ....

Bart

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
--- include/asm-i386/mman.h~	Sat Oct 25 19:42:58 2003
+++ include/asm-i386/mman.h	Thu Mar 11 13:37:33 2004
@@ -22,6 +22,7 @@
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_DONTEXPAND	0x20000		/* do not allow mremap to expand */

 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_INVALIDATE	2		/* invalidate the caches */

