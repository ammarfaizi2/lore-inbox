Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422858AbWJOTlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422858AbWJOTlG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 15:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbWJOTlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 15:41:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43755 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932142AbWJOTlD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 15:41:03 -0400
Date: Sun, 15 Oct 2006 12:40:54 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Ulrich Drepper <drepper@redhat.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] close mprotect noexec hole
In-Reply-To: <4532889B.1030908@redhat.com>
Message-ID: <Pine.LNX.4.64.0610151226140.3952@g5.osdl.org>
References: <200610151834.k9FIYBK5015809@devserv.devel.redhat.com>
 <Pine.LNX.4.64.0610151141280.3952@g5.osdl.org> <4532889B.1030908@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 15 Oct 2006, Ulrich Drepper wrote:

> Linus Torvalds wrote:
> > Ie something like this instead. Totally untested, but at least it compiles
> > with current -git (unlike Uli's version - needs <linux/mount.h>)
> 
> This works fine with my test case and is of course more correct.

The thing is, I think even my version is wrong.

Why? Because this whole case _should_ have been handled by mprotect 
already.

The way we handle VM_WRITE getting set in mprotect() etc is not by 
checking that the file is writable, but checking that VM_MAYWRITE is set.

And that's what we did with VM_EXEC too.

So I think that the _real_ bug is that VM_MAYEXEC is set, even though it 
clearly should not be.

In other words, I think the _real_ fix is actually to do this at mmap() 
time, something like the following..

This is equally untested as the previous version, but I think this is 
really conceptually the Right Thing(tm).

		Linus
---
diff --git a/mm/mmap.c b/mm/mmap.c
index eea8eef..497e502 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -900,17 +900,6 @@ unsigned long do_mmap_pgoff(struct file 
 	int accountable = 1;
 	unsigned long charged = 0, reqprot = prot;
 
-	if (file) {
-		if (is_file_hugepages(file))
-			accountable = 0;
-
-		if (!file->f_op || !file->f_op->mmap)
-			return -ENODEV;
-
-		if ((prot & PROT_EXEC) &&
-		    (file->f_vfsmnt->mnt_flags & MNT_NOEXEC))
-			return -EPERM;
-	}
 	/*
 	 * Does the application expect PROT_READ to imply PROT_EXEC?
 	 *
@@ -1000,6 +989,16 @@ unsigned long do_mmap_pgoff(struct file 
 		case MAP_PRIVATE:
 			if (!(file->f_mode & FMODE_READ))
 				return -EACCES;
+			if (file->f_vfsmnt->mnt_flags & MNT_NOEXEC) {
+				if (vm_flags & VM_EXEC)
+					return -EPERM;
+				vm_flags &= ~VM_MAYEXEC;
+			}
+			if (is_file_hugepages(file))
+				accountable = 0;
+
+			if (!file->f_op || !file->f_op->mmap)
+				return -ENODEV;
 			break;
 
 		default:
