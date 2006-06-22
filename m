Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030474AbWFVBDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030474AbWFVBDv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 21:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030476AbWFVBDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 21:03:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47520 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030474AbWFVBDu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 21:03:50 -0400
Message-Id: <200606220106.k5M16KGd028541@pasta.boston.redhat.com>
To: Chuck Ebbert <76306.1226@compuserve.com>, Andrew Morton <akpm@osdl.org>
cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] binfmt_elf: fix checks for bad address
In-Reply-To: Your message of "Wed, 21 Jun 2006 08:24:31 EDT."
             <200606210828_MC3-1-C30B-9D84@compuserve.com>
Date: Wed, 21 Jun 2006 21:06:20 -0400
From: Ernie Petrides <petrides@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 21-Jun-2006 at 8:24 EDT, Chuck Ebbert wrote:

> In-Reply-To: <20060619222512.58ba3e48.akpm@osdl.org>
> 
> On Mon, 19 Jun 2006 22:25:12 -0700, Andrew Morton wrote:
> 
> > On Tue, 20 Jun 2006 00:55:24 -0400
> > Chuck Ebbert <76306.1226@compuserve.com> wrote:
> > 
> > > @@ -84,7 +84,7 @@ static struct linux_binfmt elf_format = 
> > >  		.min_coredump	= ELF_EXEC_PAGESIZE
> > >  };
> > >  
> > > -#define BAD_ADDR(x) ((unsigned long)(x) > TASK_SIZE)
> > > +#define BAD_ADDR(x) ((unsigned long)(x) >= TASK_SIZE)
> > >  
> > >  static int set_brk(unsigned long start, unsigned long end)
> > >  {
> > > @@ -394,7 +394,7 @@ static unsigned long load_elf_interp(str
> > >  			 * <= p_memsize so it's only necessary to check p_memsz.
> > >  			 */
> > >  			k = load_addr + eppnt->p_vaddr;
> > > -			if (k > TASK_SIZE ||
> > > +			if (BAD_ADDR(k) ||
> > >  			    eppnt->p_filesz > eppnt->p_memsz ||
> > >  			    eppnt->p_memsz > TASK_SIZE ||
> > >  			    TASK_SIZE - eppnt->p_memsz < k) {
> > > @@ -888,7 +888,7 @@ static int load_elf_binary(struct linux_
> > >  		 * allowed task size. Note that p_filesz must always be
> > >  		 * <= p_memsz so it is only necessary to check p_memsz.
> > >  		 */
> > > -		if (k > TASK_SIZE || elf_ppnt->p_filesz > elf_ppnt->p_memsz ||
> > > +		if (BAD_ADDR(k) || elf_ppnt->p_filesz > elf_ppnt->p_memsz ||
> > >  		    elf_ppnt->p_memsz > TASK_SIZE ||
> > >  		    TASK_SIZE - elf_ppnt->p_memsz < k) {
> > >  			/* set_brk can never work. Avoid overflows. */
> >
> > Convince us that this is correct for all the other users of BAD_ADDR() in
> > this file.
> 
> Can I just wave my arms while asserting it's obvious?  It seemed that
> way to me...
> 
> There are two more logical pieces to that patch in RHEL4 but those I
> really didn't understand enough to post. Who's the binfmt_elf expert?


Hi, Chuck.  I did the RHEL3 and RHEL4 versions of those fixes, and I was
waiting for 2.6.17 to be released before testing and posting the changes
upstream (and I've been tied up this week and so hadn't gotten around to
it yet).

For background, the BAD_ADDR() macro should return TRUE if the address
is TASK_SIZE, because that's the lowest address that is *not* valid for
user-space mappings.  The macro was correct in binfmt_aout.c but was
wrong for the "equal to" case in binfmt_elf.c.  There were two in-line
validations of user-space addresses in binfmt_elf.c, which have been
appropriately converted to use the corrected BAD_ADDR() macro in the
patch you posted yesterday.  Note that the size checks against
TASK_SIZE are okay as coded.


The additional changes that I propose are below.  These are in the error
paths for bad ELF entry addresses once load_elf_binary() has already
committed to exec'ing the new image (following the tearing down of the
task's original address space).

The 1st hunk deals with the interp-side of the outer "if".  There were
two problems here.  The printk() should be removed because this path
can be triggered at will by a bogus interpreter image created and used
by a malicious user.  Further, the error code should not be ENOEXEC,
because that causes the loop in search_binary_handler() to continue
trying other exec handlers (twice, in fact).  But it's too late for
this to work correctly, because the user address space has already
been torn down, and an exec() failure cannot be returned to the user
code because the code no longer exists.  The only recovery is to force
a SIGSEGV, but it's best to terminate the search loop immediately.  I
somewhat arbitrarily chose EINVAL as a fallback error code, but any
error returned by load_elf_interp() will override that (but this value
will never be seen by user-space).

The 2nd hunk deals with the non-interp-side of the outer "if".  There
were two problems here as well.  The SIGSEGV needs to be forced,
because a prior sigaction() syscall might have set the associated
disposition to SIG_IGN.  And the ENOEXEC should be changed to EINVAL
as described above.

Sorry for the verbose explanations.


So Andrew, I support Chuck's changes as quoted above and suggest that
the changes below also be applied (which I've just now compile-tested).

Cheers.  -ernie



Signed-off-by: Ernie Petrides <petrides@redhat.com>

--- linux-2.6.17/fs/binfmt_elf.c.orig
+++ linux-2.6.17/fs/binfmt_elf.c
@@ -930,10 +930,9 @@ static int load_elf_binary(struct linux_
 						    interpreter,
 						    &interp_load_addr);
 		if (BAD_ADDR(elf_entry)) {
-			printk(KERN_ERR "Unable to load interpreter %.128s\n",
-				elf_interpreter);
 			force_sig(SIGSEGV, current);
-			retval = -ENOEXEC; /* Nobody gets to see this, but.. */
+			retval = IS_ERR((void *)elf_entry) ?
+					(int)elf_entry : -EINVAL;
 			goto out_free_dentry;
 		}
 		reloc_func_desc = interp_load_addr;
@@ -944,8 +943,8 @@ static int load_elf_binary(struct linux_
 	} else {
 		elf_entry = loc->elf_ex.e_entry;
 		if (BAD_ADDR(elf_entry)) {
-			send_sig(SIGSEGV, current, 0);
-			retval = -ENOEXEC; /* Nobody gets to see this, but.. */
+			force_sig(SIGSEGV, current);
+			retval = -EINVAL;
 			goto out_free_dentry;
 		}
 	}
