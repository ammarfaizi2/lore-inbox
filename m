Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282978AbSBGGPb>; Thu, 7 Feb 2002 01:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284144AbSBGGPW>; Thu, 7 Feb 2002 01:15:22 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46354 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S282978AbSBGGPF>;
	Thu, 7 Feb 2002 01:15:05 -0500
Message-ID: <3C621B44.10C424B9@zip.com.au>
Date: Wed, 06 Feb 2002 22:14:28 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: Manfred Spraul <manfred@colorfullife.com>,
        Andrea Arcangeli <andrea@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: [patch] VM_IO fixes
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We've had a few bugs recently where device drivers were forgetting
to set vma->vm_flags:VM_IO in their mmap() methods.

This causes kernel deadlocks when applications which have the
relevant device mapped try to dump core (the pagefault handler
deadlocks on mmap_sem).

Failing to set VM_IO also causes kernel oopses when PTRACE_PEEKUSR
tries to read the device mapping - the region has no page structs,
but access_process_vm() acts as if it does.

This patch doesn't fix the PTRACE_PEEKUSR bug - for that we need
this patch as well as the patch Andrea, Manfred and I pieced
together - it's at http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.18pre7aa2/00_get_user_pages-2
I understand that Manfred will be sending you a version of that patch.

The drivers which are forgetting to set VM_IO include a whole bunch
of fbmem drivers, one or more AGP drivers and I don't know what else.

It's simpler to make VM_IO default to `on', and to only clear it
in places where we know that it's safe to dump the memory to a
core file, and where it's safe to PTRACE_PEEKUSR it.  That's
what this patch does.  We only clear VM_IO in generic_file_mmap()
and in ncp_mmap() and in coda_file_mmap().

Any filesystem which implements its own mmap() method, and which
does not call generic_file_mmap() needs to be changed to clear
VM_IO inside its mmap function.  All in-kernel filesystems are
OK, as is XFS.  And the only breakage this can cause to out-of-kernel
filesystems is failure to include mappings in core files, and
inability to use PEEKUSR.

With this patch in place we can go through and remove the setting of
VM_IO in all the drivers which _do_ remember to set it.  But that's
a cleanup which can await 2.4.19-pre.


--- linux-2.4.18-pre8/mm/mmap.c	Mon Nov  5 21:01:12 2001
+++ linux-akpm/mm/mmap.c	Sat Feb  2 17:36:55 2002
@@ -534,6 +534,11 @@ munmap_back:
 		}
 		vma->vm_file = file;
 		get_file(file);
+		/*
+		 * Subdrivers can clear VM_IO if their mappings are
+		 * valid pages inside mem_map[]
+		 */
+		vma->vm_flags |= VM_IO;
 		error = file->f_op->mmap(file, vma);
 		if (error)
 			goto unmap_and_free_vma;
--- linux-2.4.18-pre8/mm/filemap.c	Tue Feb  5 00:33:05 2002
+++ linux-akpm/mm/filemap.c	Sat Feb  2 17:36:55 2002
@@ -2111,6 +2111,7 @@ int generic_file_mmap(struct file * file
 		return -ENOEXEC;
 	UPDATE_ATIME(inode);
 	vma->vm_ops = &generic_file_vm_ops;
+	vma->vm_flags &= ~VM_IO;
 	return 0;
 }
 
--- linux-2.4.18-pre8/fs/coda/file.c	Tue Feb  5 00:33:05 2002
+++ linux-akpm/fs/coda/file.c	Wed Feb  6 21:50:16 2002
@@ -97,6 +97,7 @@ coda_file_mmap(struct file *file, struct
 	if (!cfile->f_op || !cfile->f_op->mmap)
 		return -ENODEV;
 
+	vma->vm_flags &= ~VM_IO;
 	down(&inode->i_sem);
 	ret = cfile->f_op->mmap(cfile, vma);
 	UPDATE_ATIME(inode);
--- linux-2.4.18-pre8/fs/ncpfs/mmap.c	Mon Sep 10 09:04:53 2001
+++ linux-akpm/fs/ncpfs/mmap.c	Wed Feb  6 21:49:28 2002
@@ -119,5 +119,6 @@ int ncp_mmap(struct file *file, struct v
 	}
 
 	vma->vm_ops = &ncp_file_mmap;
+	vma->vm_flags &= ~VM_IO;
 	return 0;
 }
