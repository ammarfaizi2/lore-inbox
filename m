Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750980AbWCFQVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbWCFQVk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 11:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbWCFQVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 11:21:39 -0500
Received: from lead.cat.pdx.edu ([131.252.208.91]:7373 "EHLO lead.cat.pdx.edu")
	by vger.kernel.org with ESMTP id S1750980AbWCFQVj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 11:21:39 -0500
Date: Mon, 6 Mar 2006 08:13:41 -0800 (PST)
From: Suzanne Wood <suzannew@cs.pdx.edu>
Message-Id: <200603061613.k26GDfD0017783@wezen.cs.pdx.edu>
To: dipankar@in.ibm.com
Cc: bunk@stusta.de, linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       paulmck@us.ibm.com
Subject: Re: 2.6.16-rc regression: m68k CONFIG_RMW_INSNS=n compile broken
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you very much.

  > From dipankar@in.ibm.com  Mon Mar  6 07:36:50 2006

  > On Sun, Mar 05, 2006 at 08:44:15PM -0800, Suzanne Wood wrote:
  > > > From: Adrian Bunk Fri Mar 03 2006 - 18:40:57 EST 
  > > >
  > > Do kernel coders value the marking of the rcu read-side critical 
  > > section for consistency?  In fs/file_table.c, fcheck_files() 

  > Generally speaking, yes.

  > > is called by fget_light() without rcu_read_lock() in one case, 
  > > but with the apparently necessary rcu_read_lock() in place 
  > > otherwise.  The struct file pointer that fcheck_files() returns 
  > > is rcu_dereference(fdt->fd[fd]) or NULL. Does the _commented_guarantee 
  > > of the current task holding the refcnt assure there's no need to 
  > > check for NULL or to mark the rcu readside section around the first
  > > call to fcheck_files()?
  > > 
  > > This is the code sample:
  > > /*
  > >  * Lightweight file lookup - no refcnt increment if fd table isn't shared.
  > >  * You can use this only if it is guranteed that the current task already
  > >  * holds a refcnt to that file. That check has to be done at fget() only
  > >  * and a flag is returned to be passed to the corresponding fput_light().
  > >  * There must not be a cloning between an fget_light/fput_light pair.
  > >  */
  > > struct file fastcall *fget_light(unsigned int fd, int *fput_needed)
  > > {
  > > 	struct file *file;
  > > 	struct files_struct *files = current->files;
  > > 
  > > 	*fput_needed = 0;
  > > 	if (likely((atomic_read(&files->count) == 1))) {
  > > 		file = fcheck_files(files, fd);
  > > 	} else {

  > This means that the fd table is not shared between threads. So,
  > there can't be any race and no need to protect using
  > rcu_read_lock()/rcu_read_unlock().

Then why call fcheck_files() with the rcu_dereference() which would flag 
an automated check for the need to mark a read-side critical section?
Would it make sense to introduce the function that doesn't?  The goal of
keeping the kernel small is balanced with clarity.  The inconsistency of
how fcheck_files() is used within a single function (fget_light()) was
my opening question.

  > > The attached patch would superficially address the rcu 
  > > discrepancy, but another underlying question is about the 
  > > desired extent of the rcu read-side critical section in that 
  > > fget_light() returns the pointer to the file struct that was 
  > > flagged for rcu protection by rcu_dereference() in 
  > > fcheck_files().  In this application, does it make sense to 
  > > push the rcu_read_lock() into fcheck_files() or add it there
  > > or to extend it to the calling function?

  > I think a comment there explaining why rcu_read_lock/unlock
  > pair is not there should be sufficient. While the are NOP
  > for non-PREEMPT kernels, they do have a cost otherwise.
  > Avoiding them if we can is a good idea, IMO.

  > > Up the call tree, we note that fcheck() uses fcheck_files(), 
  > > but the only call to fcheck() nested in rcu_read_lock() is 
  > > in the disparaged irixioctl.c.
  > > 
  > > Are the other calls to fcheck() under circumstances that give 
  > > reason for the rcu_read_lock elision, like 
  > > spin_lock(&files->file_lock) in fs/fcntl.c, or being in the 
  > > context of applying locks in fs/locks.c, or calls from assembly 
  > > code in arch/sparc/kernel/sunos_ioctl.c & solaris/socksys.c.  
  > > If there is reason to pursue the insertion of the 
  > > rcu_read_lock/unlock() pairs in these circumstances, any 
  > > suggestions would be appreciated in order to dispel the question
  > > altogether or to try to submit a more extensive patch.

  > It depends on whether the fdtable is shared or not and if
  > shared whether we are already holding the ->files_lock or
  > not. The key is that if it is lock-free and if the fdtable
  > is shared, they rcu_read_lock()/unlock() pair must be
  > there, otherwise it is a bug.

  > Thanks
  > Dipankar

Many thanks again.
Suzanne
