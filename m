Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262937AbVDAVyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262937AbVDAVyi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 16:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262935AbVDAVxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 16:53:14 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:22668 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262915AbVDAVnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 16:43:23 -0500
Date: Fri, 1 Apr 2005 23:43:22 +0200
From: Jan Hubicka <hubicka@ucw.cz>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Gerold Jury <gerold.ml@inode.at>, jakub@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       gcc@gcc.gnu.org
Subject: Re: memcpy(a,b,CONST) is not inlined by gcc 3.4.1 in Linux kernel
Message-ID: <20050401214322.GA7175@atrey.karlin.mff.cuni.cz>
References: <200503291542.j2TFg4ER027715@earth.phy.uc.edu> <200503300427.26253.gerold.ml@inode.at> <200503300916.00781.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503300916.00781.vda@ilport.com.ua>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wednesday 30 March 2005 05:27, Gerold Jury wrote:
> > 
> > >> On Tue, Mar 29, 2005 at 05:37:06PM +0300, Denis Vlasenko wrote:
> > >> > /*
> > >> >  * This looks horribly ugly, but the compiler can optimize it totally,
> > >> >  * as the count is constant.
> > >> >  */
> > >> > static inline void * __constant_memcpy(void * to, const void * from,
> > >> > size_t n) {
> > >> >         if (n <= 128)
> > >> >                 return __builtin_memcpy(to, from, n);
> > >>
> > >> The problem is that in GCC < 4.0 there is no constant propagation
> > >> pass before expanding builtin functions, so the __builtin_memcpy
> > >> call above sees a variable rather than a constant.
> > >
> > >or change "size_t n" to "const size_t n" will also fix the issue.
> > >As we do some (well very little and with inlining and const values)
> > >const progation before 4.0.0 on the trees before expanding the builtin.
> > >
> > >-- Pinski
> > >-
> > I used the following "const size_t n" change on x86_64
> > and it reduced the memcpy count from 1088 to 609 with my setup and gcc 3.4.3.
> > (kernel 2.6.12-rc1, running now)
> 
> What do you mean, 'reduced'?
> 
> (/me is checking....)
> 
> Oh shit... It still emits half of memcpys, to be exact - for
> struct copies:
> 
> arch/i386/kernel/process.c:
> 
> int copy_thread(int nr, unsigned long clone_flags, unsigned long esp,
>         unsigned long unused,
>         struct task_struct * p, struct pt_regs * regs)
> {
>         struct pt_regs * childregs;
>         struct task_struct *tsk;
>         int err;
> 
>         childregs = ((struct pt_regs *) (THREAD_SIZE + (unsigned long) p->thread_info)) - 1;
>         *childregs = *regs;
>         ^^^^^^^^^^^^^^^^^^^
>         childregs->eax = 0;
>         childregs->esp = esp;
> 
> # make arch/i386/kernel/process.s
> 
> copy_thread:
>         pushl   %ebp
>         movl    %esp, %ebp
>         pushl   %edi
>         pushl   %esi
>         pushl   %ebx
>         subl    $20, %esp
>         movl    24(%ebp), %eax
>         movl    4(%eax), %esi
>         pushl   $60
>         leal    8132(%esi), %ebx
>         pushl   28(%ebp)
>         pushl   %ebx
>         call    memcpy  <=================
>         movl    $0, 24(%ebx)
>         movl    16(%ebp), %eax
>         movl    %eax, 52(%ebx)
>         movl    24(%ebp), %edx
>         addl    $8192, %esi
>         movl    %ebx, 516(%edx)
>         movl    %esi, -32(%ebp)
>         movl    %esi, 504(%edx)
>         movl    $ret_from_fork, 512(%edx)
> 
> Jakub, is there a way to instruct gcc to inine this copy, or better yet,
> to use user-supplied inline version of memcpy?

You can't inline struct copy as it is not function call at first place.
You can experiment with -minline-all-stringops where GCC will use it's
own memcpy implementation for this.

Honza
> --
> vda
