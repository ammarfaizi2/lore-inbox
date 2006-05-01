Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbWEARnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbWEARnO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 13:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbWEARnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 13:43:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15078 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932175AbWEARnM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 13:43:12 -0400
Date: Mon, 1 May 2006 13:54:03 -0400 (EDT)
From: Jason Baron <jbaron@redhat.com>
X-X-Sender: jbaron@dhcp83-105.boston.redhat.com
To: Sergey Vlasov <vsu@altlinux.ru>
cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, stable@kernel.org,
       Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [patch 03/24] make vm86 call audit_syscall_exit
In-Reply-To: <20060429203405.1cc6f2b6.vsu@altlinux.ru>
Message-ID: <Pine.LNX.4.61.0605011352090.20710@dhcp83-105.boston.redhat.com>
References: <20060428001226.204293000@quad.kroah.org> <20060428001652.GD18750@kroah.com>
 <20060429203405.1cc6f2b6.vsu@altlinux.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 29 Apr 2006, Sergey Vlasov wrote:

> On Thu, 27 Apr 2006 17:16:52 -0700 Greg KH wrote:
> 
> > -stable review patch.  If anyone has any objections, please let us know.
> > 
> > ------------------
> > hi,
> > 
> > The motivation behind the patch below was to address messages in
> > /var/log/messages such as:
> > 
> > Jan 31 10:54:15 mets kernel: audit(:0): major=252 name_count=0: freeing
> > multiple contexts (1)
> > Jan 31 10:54:15 mets kernel: audit(:0): major=113 name_count=0: freeing
> > multiple contexts (2)
> > 
> > I can reproduce by running 'get-edid' from:
> > http://john.fremlin.de/programs/linux/read-edid/.
> > 
> > These messages come about in the log b/c the vm86 calls do not exit via
> > the normal system call exit paths and thus do not call
> > 'audit_syscall_exit'. The next system call will then free the context for
> > itself and for the vm86 context, thus generating the above messages. This
> > patch addresses the issue by simply adding a call to 'audit_syscall_exit'
> > from the vm86 code.
> > 
> > Besides fixing the above error messages the patch also now allows vm86
> > system calls to become auditable. This is useful since strace does not
> > appear to properly record the return values from sys_vm86.
> 
> I don't understand how this is supposed to log the sys_vm86 return value
> properly - the return value for userspace would be known only in
> return_to_32bit(), and here audit_syscall_exit() is called in
> do_sys_vm86(), before the VM86-mode code has even started to run.
> 
> > I think this patch is also a step in the right direction in terms of
> > cleaning up some core auditing code. If we can correct any other paths
> > that do not properly call the audit exit and entries points, then we can
> > also eliminate the notion of context chaining.
> > 
> > I've tested this patch by verifying that the log messages no longer
> > appear, and that the audit records for sys_vm86 appear to be correct.
> 
> And what return values are logged?
> 

the xorl of eax with itself produces 0.

> > Also, 'read_edid' produces itentical output.
> > 
> > thanks,
> > 
> > -Jason
> > 
> > Signed-off-by: Jason Baron <jbaron@redhat.com>
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> > 
> > ---
> > ---
> >  arch/i386/kernel/vm86.c |   12 ++++++++++--
> >  kernel/auditsc.c        |    5 -----
> >  2 files changed, 10 insertions(+), 7 deletions(-)
> > 
> > --- linux-2.6.16.11.orig/arch/i386/kernel/vm86.c
> > +++ linux-2.6.16.11/arch/i386/kernel/vm86.c
> > @@ -43,6 +43,7 @@
> >  #include <linux/smp_lock.h>
> >  #include <linux/highmem.h>
> >  #include <linux/ptrace.h>
> > +#include <linux/audit.h>
> >  
> >  #include <asm/uaccess.h>
> >  #include <asm/io.h>
> > @@ -252,6 +253,7 @@ out:
> >  static void do_sys_vm86(struct kernel_vm86_struct *info, struct task_struct *tsk)
> >  {
> >  	struct tss_struct *tss;
> > +	long eax;
> >  /*
> >   * make sure the vm86() system call doesn't try to do anything silly
> >   */
> > @@ -305,13 +307,19 @@ static void do_sys_vm86(struct kernel_vm
> >  	tsk->thread.screen_bitmap = info->screen_bitmap;
> >  	if (info->flags & VM86_SCREEN_BITMAP)
> >  		mark_screen_rdonly(tsk->mm);
> > +	__asm__ __volatile__("xorl %eax,%eax; movl %eax,%fs; movl %eax,%gs\n\t");
> > +	__asm__ __volatile__("movl %%eax, %0\n" :"=r"(eax));
> 
> This fetches whatever value happened to be in the EAX register at this
> point, and stuffs it into the eax variable.  Most likely EAX will
> contain 0 from the previous asm commands.  I'm not sure whether gcc
> could insert some code of its own between two "asm volatile" statements,
> but this asm statement looks like a bug by itself.
> 
> > +
> > +	/*call audit_syscall_exit since we do not exit via the normal paths */
> > +	if (unlikely(current->audit_context))
> > +		audit_syscall_exit(current, AUDITSC_RESULT(eax), eax);
> 
> Then this probably always records 0 as the syscall result.
> 
> However, looks like moving audit_syscall_exit() into return_to_32bit()
> (where the syscall result is known) would not work because of issues
> with signal handling...  So maybe we are stuck with partially wrong
> audit records for vm86, but at least the broken asm should be removed.
> 

agreed. I've been meaning to post a patch to clean this up...how does this 
look?

--- linux-2.6/arch/i386/kernel/vm86.c.bak	2006-04-30 21:00:21.000000000 -0400
+++ linux-2.6/arch/i386/kernel/vm86.c	2006-04-30 21:08:32.000000000 -0400
@@ -253,7 +253,6 @@ out:
 static void do_sys_vm86(struct kernel_vm86_struct *info, struct task_struct *tsk)
 {
 	struct tss_struct *tss;
-	long eax;
 /*
  * make sure the vm86() system call doesn't try to do anything silly
  */
@@ -307,19 +306,18 @@ static void do_sys_vm86(struct kernel_vm
 	tsk->thread.screen_bitmap = info->screen_bitmap;
 	if (info->flags & VM86_SCREEN_BITMAP)
 		mark_screen_rdonly(tsk->mm);
-	__asm__ __volatile__("xorl %eax,%eax; movl %eax,%fs; movl %eax,%gs\n\t");
-	__asm__ __volatile__("movl %%eax, %0\n" :"=r"(eax));
 
 	/*call audit_syscall_exit since we do not exit via the normal paths */
 	if (unlikely(current->audit_context))
-		audit_syscall_exit(current, AUDITSC_RESULT(eax), eax);
+		audit_syscall_exit(current, AUDITSC_RESULT(0), 0);
 
 	__asm__ __volatile__(
+		"xorl %%eax,%%eax; movl %%eax,%%fs; movl %%eax,%%gs\n\t"
 		"movl %0,%%esp\n\t"
 		"movl %1,%%ebp\n\t"
 		"jmp resume_userspace"
 		: /* no outputs */
-		:"r" (&info->regs), "r" (task_thread_info(tsk)));
+		:"r" (&info->regs), "r" (task_thread_info(tsk)) : "ax");
 	/* we never return here */
 }
 
