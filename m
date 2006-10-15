Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030214AbWJOSrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbWJOSrs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 14:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030216AbWJOSrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 14:47:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53213 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030214AbWJOSrr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 14:47:47 -0400
Date: Sun, 15 Oct 2006 11:47:37 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Ulrich Drepper <drepper@redhat.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] close mprotect noexec hole
In-Reply-To: <200610151834.k9FIYBK5015809@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.64.0610151141280.3952@g5.osdl.org>
References: <200610151834.k9FIYBK5015809@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 15 Oct 2006, Ulrich Drepper wrote:
>
> The following patch closes the hole in mprotect discovered during
> the noexec mount discussions.  Without this the protection is
> incomplete and pretty much useless.  With it and additional techniques
> like SELinux all holes can be plugged in a fine-grained way.

This patch seems totally buggy.

mprotect() can cover _multiple_ mappings, and this one only checks the 
very first one, as far as I can tell.

The place to do this is where we do the "security_file_mprotect()", not 
where you did it. 

Ie something like this instead. Totally untested, but at least it compiles 
with current -git (unlike Uli's version - needs <linux/mount.h>)

		Linus
---
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 3b8f3c0..09ed8de 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -21,6 +21,7 @@ #include <linux/personality.h>
 #include <linux/syscalls.h>
 #include <linux/swap.h>
 #include <linux/swapops.h>
+#include <linux/mount.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/cacheflush.h>
@@ -280,9 +281,14 @@ sys_mprotect(unsigned long start, size_t
 		newflags = vm_flags | (vma->vm_flags & ~(VM_READ | VM_WRITE | VM_EXEC));
 
 		/* newflags >> 4 shift VM_MAY% in place of VM_% */
-		if ((newflags & ~(newflags >> 4)) & (VM_READ | VM_WRITE | VM_EXEC)) {
-			error = -EACCES;
+		error = -EACCES;
+		if ((newflags & ~(newflags >> 4)) & (VM_READ | VM_WRITE | VM_EXEC))
 			goto out;
+
+		if (newflags & VM_EXEC) {
+			struct file *file = vma->vm_file;
+			if (file && (file->f_vfsmnt->mnt_flags & MNT_NOEXEC))
+				goto out;
 		}
 
 		error = security_file_mprotect(vma, reqprot, prot);
