Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261678AbVC3GRB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbVC3GRB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 01:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbVC3GRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 01:17:01 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:5124 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261678AbVC3GQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 01:16:44 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Gerold Jury <gerold.ml@inode.at>, jakub@redhat.com
Subject: Re: memcpy(a,b,CONST) is not inlined by gcc 3.4.1 in Linux kernel
Date: Wed, 30 Mar 2005 09:15:59 +0300
User-Agent: KMail/1.5.4
References: <200503291542.j2TFg4ER027715@earth.phy.uc.edu> <200503300427.26253.gerold.ml@inode.at>
In-Reply-To: <200503300427.26253.gerold.ml@inode.at>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, gcc@gcc.gnu.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503300916.00781.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 March 2005 05:27, Gerold Jury wrote:
> 
> >> On Tue, Mar 29, 2005 at 05:37:06PM +0300, Denis Vlasenko wrote:
> >> > /*
> >> >  * This looks horribly ugly, but the compiler can optimize it totally,
> >> >  * as the count is constant.
> >> >  */
> >> > static inline void * __constant_memcpy(void * to, const void * from,
> >> > size_t n) {
> >> >         if (n <= 128)
> >> >                 return __builtin_memcpy(to, from, n);
> >>
> >> The problem is that in GCC < 4.0 there is no constant propagation
> >> pass before expanding builtin functions, so the __builtin_memcpy
> >> call above sees a variable rather than a constant.
> >
> >or change "size_t n" to "const size_t n" will also fix the issue.
> >As we do some (well very little and with inlining and const values)
> >const progation before 4.0.0 on the trees before expanding the builtin.
> >
> >-- Pinski
> >-
> I used the following "const size_t n" change on x86_64
> and it reduced the memcpy count from 1088 to 609 with my setup and gcc 3.4.3.
> (kernel 2.6.12-rc1, running now)

What do you mean, 'reduced'?

(/me is checking....)

Oh shit... It still emits half of memcpys, to be exact - for
struct copies:

arch/i386/kernel/process.c:

int copy_thread(int nr, unsigned long clone_flags, unsigned long esp,
        unsigned long unused,
        struct task_struct * p, struct pt_regs * regs)
{
        struct pt_regs * childregs;
        struct task_struct *tsk;
        int err;

        childregs = ((struct pt_regs *) (THREAD_SIZE + (unsigned long) p->thread_info)) - 1;
        *childregs = *regs;
        ^^^^^^^^^^^^^^^^^^^
        childregs->eax = 0;
        childregs->esp = esp;

# make arch/i386/kernel/process.s

copy_thread:
        pushl   %ebp
        movl    %esp, %ebp
        pushl   %edi
        pushl   %esi
        pushl   %ebx
        subl    $20, %esp
        movl    24(%ebp), %eax
        movl    4(%eax), %esi
        pushl   $60
        leal    8132(%esi), %ebx
        pushl   28(%ebp)
        pushl   %ebx
        call    memcpy  <=================
        movl    $0, 24(%ebx)
        movl    16(%ebp), %eax
        movl    %eax, 52(%ebx)
        movl    24(%ebp), %edx
        addl    $8192, %esi
        movl    %ebx, 516(%edx)
        movl    %esi, -32(%ebp)
        movl    %esi, 504(%edx)
        movl    $ret_from_fork, 512(%edx)

Jakub, is there a way to instruct gcc to inine this copy, or better yet,
to use user-supplied inline version of memcpy?
--
vda

