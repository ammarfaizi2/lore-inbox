Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261536AbVBHOeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbVBHOeN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 09:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbVBHOeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 09:34:13 -0500
Received: from mx1.redhat.com ([66.187.233.31]:36548 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261536AbVBHOdu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 09:33:50 -0500
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: [PATCH] NOMMU: Documentation of no-MMU mmap
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Tue, 08 Feb 2005 14:33:44 +0000
Message-ID: <19311.1107873224@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch adds documentation for the behaviour of the no-MMU mmap.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 nommu-doc-2611rc3.diff
 Documentation/nommu-mmap.txt |  141 +++++++++++++++++++++++++++++++++++++++++++
 mm/nommu.c                   |    4 -
 2 files changed, 144 insertions(+), 1 deletion(-)

diff -uNrp /warthog/kernels/linux-2.6.11-rc3/Documentation/nommu-mmap.txt linux-2.6.11-rc3-frv/Documentation/nommu-mmap.txt
--- /warthog/kernels/linux-2.6.11-rc3/Documentation/nommu-mmap.txt	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.11-rc3-frv/Documentation/nommu-mmap.txt	2005-02-08 13:51:43.584581868 +0000
@@ -0,0 +1,141 @@
+			 =============================
+			 NO-MMU MEMORY MAPPING SUPPORT
+			 =============================
+
+The kernel has limited support for memory mapping under no-MMU conditions, such
+as are used in uClinux environments. From the userspace point of view, memory
+mapping is made use of in conjunction with the mmap() system call, the shmat()
+call and the execve() system call. From the kernel's point of view, execve()
+mapping is actually performed by the binfmt drivers, which call back into the
+mmap() routines to do the actual work.
+
+Memory mapping behaviour also involves the way fork(), vfork(), clone() and
+ptrace() work. Under uClinux there is no fork(), and clone() must be supplied
+the CLONE_VM flag.
+
+The behaviour is similar between the MMU and no-MMU cases, but not identical;
+and it's also much more restricted in the latter case:
+
+ (*) Anonymous mapping, MAP_PRIVATE
+
+	In the MMU case: VM regions backed by arbitrary pages; copy-on-write
+	across fork.
+
+	In the no-MMU case: VM regions backed by arbitrary contiguous runs of
+	pages.
+
+ (*) Anonymous mapping, MAP_SHARED
+
+	These behave very much like private mappings, except that they're
+	shared across fork() or clone() without CLONE_VM in the MMU case. Since
+	the no-MMU case doesn't support these, behaviour is identical to
+	MAP_PRIVATE there.
+
+ (*) File, MAP_PRIVATE, PROT_READ / PROT_EXEC, !PROT_WRITE
+
+	In the MMU case: VM regions backed by pages read from file; changes to
+	the underlying file are reflected in the mapping; copied across fork.
+
+	In the no-MMU case: VM regions backed by arbitrary contiguous runs of
+	pages into which the appropriate bit of the file is read; any remaining
+	bit of the mapping is cleared; such mappings are shared if possible;
+	writes to the file do not affect the mapping; writes to the mapping are
+	visible in other processes (no MMU protection), but should not happen.
+
+ (*) File, MAP_PRIVATE, PROT_READ / PROT_EXEC, PROT_WRITE
+
+	In the MMU case: like the non-PROT_WRITE case, except that the pages in
+	question get copied before the write actually happens. From that point
+	on writes to that page in the file no longer get reflected into the
+	mapping's backing pages.
+
+	In the no-MMU case: works exactly as for the non-PROT_WRITE case.
+
+ (*) Regular file / blockdev, MAP_SHARED, PROT_READ / PROT_EXEC / PROT_WRITE
+
+	In the MMU case: VM regions backed by pages read from file; changes to
+	pages written back to file; writes to file reflected into pages backing
+	mapping; shared across fork.
+
+	In the no-MMU case: not supported.
+
+ (*) Memory backed regular file, MAP_SHARED, PROT_READ / PROT_EXEC / PROT_WRITE
+
+	In the MMU case: As for ordinary regular files.
+
+	In the no-MMU case: The filesystem providing the memory-backed file
+	(such as ramfs or tmpfs) may choose to honour an open, truncate, mmap
+	sequence by providing a contiguous sequence of pages to map. In that
+	case, a shared-writable memory mapping will be possible. It will work
+	as for the MMU case. If the filesystem does not provide any such
+	support, then the mapping request will be denied.
+
+ (*) Memory backed chardev, MAP_SHARED, PROT_READ / PROT_EXEC / PROT_WRITE
+
+	In the MMU case: As for ordinary regular files.
+
+	In the no-MMU case: The character device driver may choose to honour
+	the mmap() by providing direct access to the underlying device if it
+	provides memory or quasi-memory that can be accessed directly. Examples
+	of such are frame buffers and flash devices. If the driver does not
+	provide any such support, then the mapping request will be denied.
+
+
+============================
+FURTHER NOTES ON NO-MMU MMAP
+============================
+
+ (*) A request for a private mapping of less than a page in size may not return
+     a page-aligned buffer. This is because the kernel calls kmalloc() to
+     allocate the buffer, not get_free_page().
+
+ (*) A list of all the mappings on the system is visible through /proc/maps in
+     no-MMU mode.
+
+ (*) Supplying MAP_FIXED or a requesting a particular mapping address will
+     result in an error.
+
+ (*) Files mapped privately must have a read method provided by the driver or
+     filesystem so that the contents can be read into the memory allocated. An
+     error will result if they don't. This is most likely to be encountered
+     with character device files, pipes, fifos and sockets.
+
+
+============================================
+PROVIDING SHAREABLE CHARACTER DEVICE SUPPORT
+============================================
+
+To provide shareable character device support, a driver must provide a
+file->f_op->get_unmapped_area() operation. The mmap() routines will call this
+to get a proposed address for the mapping. This may return an error if it
+doesn't wish to honour the mapping because it's too long, at a weird offset,
+under some unsupported combination of flags or whatever.
+
+The vm_ops->close() routine will be invoked when the last mapping on a chardev
+is removed. An existing mapping will be shared, partially or not, if possible
+without notifying the driver.
+
+It is permitted also for the file->f_op->get_unmapped_area() operation to
+return -ENOSYS. This will be taken to mean that this operation just doesn't
+want to handle it, despite the fact it's got an operation. For instance, it
+might try directing the call to a secondary driver which turns out not to
+implement it. Such is the case for the framebuffer driver which attempts to
+direct the call to the device-specific driver.
+
+
+==============================================
+PROVIDING SHAREABLE MEMORY-BACKED FILE SUPPORT
+==============================================
+
+Provision of shared mappings on memory backed files is similar to the provision
+of support for shared mapped character devices. The main difference is that the
+filesystem providing the service will probably allocate a contiguous collection
+of pages and permit mappings to be made on that.
+
+It is recommended that a truncate operation applied to such a file that
+increases the file size, if that file is empty, be taken as a request to gather
+enough pages to honour a mapping. This is required to support POSIX shared
+memory.
+
+Memory backed devices are indicated by the mapping's backing device info having
+the memory_backed flag set.
diff -uNrp /warthog/kernels/linux-2.6.11-rc3/mm/nommu.c linux-2.6.11-rc3-frv/mm/nommu.c
--- /warthog/kernels/linux-2.6.11-rc3/mm/nommu.c	2005-02-04 11:50:28.000000000 +0000
+++ linux-2.6.11-rc3-frv/mm/nommu.c	2005-02-08 13:54:18.816577889 +0000
@@ -4,7 +4,9 @@
  *  Replacement code for mm functions to support CPU's that don't
  *  have any form of memory management unit (thus no virtual memory).
  *
- *  Copyright (c) 2004      David Howells <dhowells@redhat.com>
+ *  See Documentation/nommu-mmap.txt
+ *
+ *  Copyright (c) 2004-2005 David Howells <dhowells@redhat.com>
  *  Copyright (c) 2000-2003 David McCullough <davidm@snapgear.com>
  *  Copyright (c) 2000-2001 D Jeff Dionne <jeff@uClinux.org>
  *  Copyright (c) 2002      Greg Ungerer <gerg@snapgear.com>
