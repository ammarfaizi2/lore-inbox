Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbVFNOpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVFNOpN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 10:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVFNOow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 10:44:52 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:52693 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261244AbVFNOe3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 10:34:29 -0400
Date: Tue, 14 Jun 2005 20:02:03 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] files: files locking doc
Message-ID: <20050614143203.GG4557@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20050614142612.GA4557@in.ibm.com> <20050614142735.GB4557@in.ibm.com> <20050614142818.GC4557@in.ibm.com> <20050614142928.GD4557@in.ibm.com> <20050614143019.GE4557@in.ibm.com> <20050614143110.GF4557@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050614143110.GF4557@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Add documentation describing the new locking scheme for file
descriptor table.

Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>


 Documentation/filesystems/files.txt |  103 ++++++++++++++++++++++++++++++++++++
 1 files changed, 103 insertions(+)

diff -puN /dev/null Documentation/filesystems/files.txt
--- /dev/null	2003-01-30 15:54:37.000000000 +0530
+++ linux-2.6.12-rc6-fd-dipankar/Documentation/filesystems/files.txt	2005-06-14 14:05:07.000000000 +0530
@@ -0,0 +1,103 @@
+File management in the Linux kernel
+-----------------------------------
+
+This document describes how locking for files (struct file)
+and file descriptor table (struct files) works.
+
+Up until 2.6.12, the file descriptor table has been protected
+with a lock (files->file_lock) and reference count (files->count).
+->file_lock protected accesses to all the file related fields
+of the table. ->count was used for sharing the file descriptor
+table between tasks cloned with CLONE_FILES flag. Typically
+this would be the case for posix threads. As with the common
+refcounting model in the kernel, the last task doing 	
+a put_files_struct() frees the file descriptor (fd) table.
+The files (struct file) themselves are protected using
+reference count (->f_count).
+
+In the new lock-free model of file descriptor management,
+the reference counting is similar, but the locking is
+based on RCU. The file descriptor table contains multiple
+elements - the fd sets (open_fds and close_on_exec, the
+array of file pointers, the sizes of the sets and the array
+etc.). In order for the updates to appear atomic to
+a lock-free reader, all the elements of the file descriptor
+table are in a separate structure - struct fdtable.
+files_struct contains a pointer to struct fdtable through
+which the actual fd table is accessed. Initially the
+fdtable is embedded in files_struct itself. On a subsequent
+expansion of fdtable, a new fdtable structure is allocated
+and files->fdtab points to the new structure. The fdtable
+structure is freed with RCU and lock-free readers either
+see the old fdtable or the new fdtable making the update
+appear atomic. Here are the locking rules for
+the fdtable structure -
+
+1. All references to the fdtable must be done through
+   the files_fdtable() macro :
+
+	struct fdtable *fdt;
+
+	rcu_read_lock();
+
+	fdt = files_fdtable(files);
+	....
+	if (n <= fdt->max_fds)
+		....
+	...
+	rcu_read_unlock();
+
+   files_fdtable() uses rcu_dereference() macro which takes care of
+   the memory barrier requirements for lock-free dereference.
+   The fdtable pointer must be read within the read-side
+   critical section.
+
+2. Reading of the fdtable as described above must be protected
+   by rcu_read_lock()/rcu_read_unlock().
+
+3. For any update to the the fd table, files->file_lock must
+   be held.
+
+4. To look up the file structure given an fd, a reader
+   must use either fcheck() or fcheck_files() APIs. These
+   take care of barrier requirements due to lock-free lookup.
+   An example :
+
+	struct file *file;
+
+	rcu_read_lock();
+	file = fcheck(fd);
+	if (file) {
+		...
+	}
+	....
+	rcu_read_unlock();
+
+5. Handling of the file structures is special. Since the look-up
+   of the fd (fget()/fget_light()) are lock-free, it is possible
+   that look-up may race with the last put() operation on the
+   file structure. This is avoided using the rcuref APIs
+   on ->f_count :
+
+	rcu_read_lock();
+	file = fcheck_files(files, fd);
+	if (file) {
+		if (rcuref_inc_lf(&file->f_count))
+			*fput_needed = 1;
+		else
+		/* Didn't get the reference, someone's freed */
+			file = NULL;
+	}
+	rcu_read_unlock();
+	....
+	return file;
+
+   rcuref_inc_lf() detects if refcounts is already zero or
+   goes to zero during increment. If it does, we fail
+   fget()/fget_light().
+
+6. Since both fdtable and file structures can be looked up
+   lock-free, they must be installed using rcu_assign_pointer()
+   API. If they are looked up lock-free, rcu_dereference()
+   must be used. However it is advisable to use files_fdtable()
+   and fcheck()/fcheck_files() which take care of these issues.

_
