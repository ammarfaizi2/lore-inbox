Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932586AbWCGBPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932586AbWCGBPS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 20:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932585AbWCGBPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 20:15:17 -0500
Received: from mournblade.cat.pdx.edu ([131.252.208.27]:35458 "EHLO
	mournblade.cat.pdx.edu") by vger.kernel.org with ESMTP
	id S932586AbWCGBPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 20:15:16 -0500
Date: Mon, 6 Mar 2006 17:14:40 -0800 (PST)
From: Suzanne Wood <suzannew@cs.pdx.edu>
Message-Id: <200603070114.k271Eers024539@adara.cs.pdx.edu>
To: dipankar@in.ibm.com
Cc: linux-kernel@vger.kernel.org, paulmck@us.ibm.com, walpole@cs.pdx.edu
Subject: Re: 2.6.16-rc regression: m68k CONFIG_RMW_INSNS=n compile broken
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello and thank you again.

 > From dipankar@in.ibm.com  Mon Mar  6 08:49:55 2006

 > On Mon, Mar 06, 2006 at 08:13:41AM -0800, Suzanne Wood wrote:
 > > Thank you very much.
 > >   > > struct file fastcall *fget_light(unsigned int fd, int *fput_needed)
 > >   > > {
 > >   > > 	struct file *file;
 > >   > > 	struct files_struct *files = current->files;
 > >   > > 
 > >   > > 	*fput_needed = 0;
 > >   > > 	if (likely((atomic_read(&files->count) == 1))) {
 > >   > > 		file = fcheck_files(files, fd);
 > >   > > 	} else {
 > > 
 > >   > This means that the fd table is not shared between threads. So,
 > >   > there can't be any race and no need to protect using
 > >   > rcu_read_lock()/rcu_read_unlock().
 > > 
 > > Then why call fcheck_files() with the rcu_dereference() which would flag 
 > > an automated check for the need to mark a read-side critical section?
 > > Would it make sense to introduce the function that doesn't?  The goal of
 > > keeping the kernel small is balanced with clarity.  The inconsistency of
 > > how fcheck_files() is used within a single function (fget_light()) was
 > > my opening question.

 > Because rcu_dereference() hurts only alpha and we don't care about
 > alpha :-)

 > Just kidding!

 > Good point about automated checkers. However, this isn't an
 > uncommon thing in multi-threaded programs - can't the checker 
 > rules be written to take into account sharing and non-sharing of 
 > the object in question ?

Henzinger, et al., UC Berkeley, describe race checking on a 
language for networked embedded systems NES-C using the atomic 
keyword to delimit sections.  (The rcu_read_lock() would be 
similar in disallowing interrupts.)  When flow-based analysis 
returned false positives, the programmer could annotate the 
code with "norace" and in practice all shared accesses were 
put in atomic sections even if there were no actual race 
conditions.  To limit the number of atomic sections, the 
UCB group modeled multiple threads, triggered hardware 
interrupts and interleaved tasks and checked for safe access
and did manual corrections to the unsafe code.

In fget_light(), the rcu_dereference() is apparently never 
intended in the "if true" of the conditional where 
(likely((atomic_read(&files->count) == 1), so only one file 
descriptor is open for the current task at that instant.  (A 
child process could share that descriptor, but an unrelated 
process would have its own file descriptor.)

But fget_light() does return the file pointer which _some_ of 
the time does require rcu-protection, so hypothetically, a 
checker flags it as unsafe if no rcu_read_lock() is in place 
in a caller at some level and checking can proceed to other 
locking.

The core premises have been that a path through the code 
that contains rcu_dereference() or rcu_assign_pointer() is 
matched to the assign/deref counterpart with the same struct 
object type and the rcu_dereference() is nested in a read-side 
critical section delimited by rcu_read_lock() and 
rcu_read_unlock() used to determine the extent of the duration 
of the struct at the address.

The pointer to the file struct that fcheck_files() returns is 
rcu_dereference(fdt->fd[fd]) and open.c has fd_install() call 
rcu_assign_pointer(fdt->fd[fd], file).  In file_table.c, 
file_free() calls call_rcu(&f->f_u.fu_rcuhead, file_free_rcu), 
where the fu_rcuhead is a field of the file struct and 
file_free_rcu() calls kmem_cache_free().

Thank you very much for your insights into the reasoning. 
Suzanne
