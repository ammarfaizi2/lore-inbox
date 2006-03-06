Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751028AbWCFEwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbWCFEwQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 23:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbWCFEwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 23:52:16 -0500
Received: from iron.cat.pdx.edu ([131.252.208.92]:35059 "EHLO iron.cat.pdx.edu")
	by vger.kernel.org with ESMTP id S1750829AbWCFEwP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 23:52:15 -0500
Date: Sun, 5 Mar 2006 20:44:15 -0800 (PST)
From: Suzanne Wood <suzannew@cs.pdx.edu>
Message-Id: <200603060444.k264iFeM026843@murzim.cs.pdx.edu>
To: bunk@stusta.de
Cc: linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au, paulmck@us.ibm.com
Subject: Re: 2.6.16-rc regression: m68k CONFIG_RMW_INSNS=n compile broken
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Adrian Bunk Fri Mar 03 2006 - 18:40:57 EST 
>
> On Fri, Mar 03, 2006 at 03:22:42PM -0800, Linus Torvalds wrote:
>> 
>> On Sat, 4 Mar 2006, Adrian Bunk wrote:
>> > 
>> > It seems the problem is that in the CONFIG_RMW_INSNS=n 
>> > case, there's no 
>> > cmpxchg #define in include/asm-m68k/system.h required for the 
>> > atomic_add_unless #define in include/asm-m68k/atomic.h.
>> 
>> Hmm. It seems like it never has been there.. Do you know what brought this 
>> on? Was it Nick's RCU changes from "rcuref_dec_and_test()" to 
>> "atomic_dec_and_test()" and friends? 
>
> It was Nick's commit 8426e1f6af0fd7f44d040af7263750c5a52f3cc3 that added 
> atomic_inc_not_zero(), and Nick's patch that changed fs/file_table.c 
> from rcuref_dec_and_test() to atomic_dec_and_test() exposed this 
> problem.

Do kernel coders value the marking of the rcu read-side critical 
section for consistency?  In fs/file_table.c, fcheck_files() 
is called by fget_light() without rcu_read_lock() in one case, 
but with the apparently necessary rcu_read_lock() in place 
otherwise.  The struct file pointer that fcheck_files() returns 
is rcu_dereference(fdt->fd[fd]) or NULL. Does the _commented_guarantee 
of the current task holding the refcnt assure there's no need to 
check for NULL or to mark the rcu readside section around the first
call to fcheck_files()?

This is the code sample:
/*
 * Lightweight file lookup - no refcnt increment if fd table isn't shared.
 * You can use this only if it is guranteed that the current task already
 * holds a refcnt to that file. That check has to be done at fget() only
 * and a flag is returned to be passed to the corresponding fput_light().
 * There must not be a cloning between an fget_light/fput_light pair.
 */
struct file fastcall *fget_light(unsigned int fd, int *fput_needed)
{
	struct file *file;
	struct files_struct *files = current->files;

	*fput_needed = 0;
	if (likely((atomic_read(&files->count) == 1))) {
		file = fcheck_files(files, fd);
	} else {
		rcu_read_lock();
		file = fcheck_files(files, fd);
		if (file) {
			if (atomic_inc_not_zero(&file->f_count))
				*fput_needed = 1;
			else
				/* Didn't get the reference, someone's freed */
				file = NULL;
		}
		rcu_read_unlock();
	}

	return file;
}

The attached patch would superficially address the rcu 
discrepancy, but another underlying question is about the 
desired extent of the rcu read-side critical section in that 
fget_light() returns the pointer to the file struct that was 
flagged for rcu protection by rcu_dereference() in 
fcheck_files().  In this application, does it make sense to 
push the rcu_read_lock() into fcheck_files() or add it there
or to extend it to the calling function?

Up the call tree, we note that fcheck() uses fcheck_files(), 
but the only call to fcheck() nested in rcu_read_lock() is 
in the disparaged irixioctl.c.

Are the other calls to fcheck() under circumstances that give 
reason for the rcu_read_lock elision, like 
spin_lock(&files->file_lock) in fs/fcntl.c, or being in the 
context of applying locks in fs/locks.c, or calls from assembly 
code in arch/sparc/kernel/sunos_ioctl.c & solaris/socksys.c.  
If there is reason to pursue the insertion of the 
rcu_read_lock/unlock() pairs in these circumstances, any 
suggestions would be appreciated in order to dispel the question
altogether or to try to submit a more extensive patch.

Thank you.
Suzanne

-
 file_table.c |    2 ++
 1 files changed, 2 insertions(+)
---------------------------------

--- /testbed2/linux-2.6.16-rc5/fs/file_table.c	2006-02-26 21:09:35.000000000 -0800
+++ /testbed1/linux-2.6.16-rc5/fs/file_table.c	2006-03-05 14:36:46.000000000 -0800
@@ -194,7 +194,9 @@ struct file fastcall *fget_light(unsigne
 
 	*fput_needed = 0;
 	if (likely((atomic_read(&files->count) == 1))) {
+		rcu_read_lock();
 		file = fcheck_files(files, fd);
+		rcu_read_unlock();
 	} else {
 		rcu_read_lock();
 		file = fcheck_files(files, fd);
