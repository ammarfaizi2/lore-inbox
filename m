Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272126AbSISRyq>; Thu, 19 Sep 2002 13:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272132AbSISRyq>; Thu, 19 Sep 2002 13:54:46 -0400
Received: from mxzilla3.xs4all.nl ([194.109.6.49]:47377 "EHLO
	mxzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S272126AbSISRyk>; Thu, 19 Sep 2002 13:54:40 -0400
Date: Thu, 19 Sep 2002 19:59:41 +0200
From: dvorak <dvorak@xs4all.nl>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Syscall changes registers beyond %eax, on linux-i386
Message-ID: <20020919175941.GA7851@xs4all.nl>
References: <3D8A04C0.6050508@didntduck.org> <Pine.LNX.3.95.1020919131927.15141A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1020919131927.15141A-100000@chaos.analogic.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 19, 2002 at 01:22:35PM -0400, Richard B. Johnson wrote:
> On Thu, 19 Sep 2002, Brian Gerst wrote:
> 
> > Richard B. Johnson wrote:
> > > On Thu, 19 Sep 2002, dvorak wrote:
> > > 
> > > 
> > >>Hi,
> > >>
> > >>recently i came across a situation were on linux-i386 not only %eax was
> > >>altered after a syscall but also %ebx. I tracked this problem down, to
> > >>gcc re-using a variable passed to a function.
> > >>
> > >>This was found on a debian system with a 2.4.17 kernel compiled with gcc
> > >>2.95.2 and verified on another system, kernel 2.4.18 compiled with 2.95.4 
> > >>Attached is small program to test for this 'bug'
> > >>
<SNIP part of the explanation>

> > >>It seems that gcc in certain cases optimizes in such a way that it changes
> > >>the variable ufds as placed on the stack directly. Which results in saved(ebx)
> > >>being overwritten and thus in a changed %ebx on return from the system call.
> > >>
> > > 
> > > 
> > > The 'C' compiler must make room on the stack for any local
> > > variables except register types. If it was doing as you state, you
> > > couldn't even execute a "hello world" program. Further, the local
> > > variables are after the return address. It would screw up the return
> > > address and you'd go off into hyper-space upon return.

The problem is it uses one of the _arguments_ passed to the function, 
that argument gets modified, normally this happens on a copy, but there
is no 'garantue' that is doesn't modify the original argument as
putted on the stack by the calling function.

> > > No. Various 'C' implementers have standardized calling methods even
> > > though it's not part of the 'C' standard. gcc and others assume that
> > > a called procedure is not going to change any segments or index registers.
> > > There are various optimization things, like "-fcaller-saves" where the
> > > called procedure can destroy anything. You may be using something that
> > > was wrongly compiled using that switch.
This is not what happens here, what happens is that one of the _arguments_
placed on the stack is being modified, normally a calling function discards
these values after use (addl $0x10, %esp or similar) but in this case they
are reused. (in the RESTORE_ALL call)

> > 
> > The bug is only with _some_ syscalls, and getpid() is not one of them, 
> > so your example is flawed.  It happens when a syscall modifies one of 
> > it's parameter values.  The solution is to assign the parameter to a 
> > local variable before modifying it.
> > 
and only with _some_ compiler + kernel combinations.

> int main()
> {
>     struct termios t;
> 
>     __asm__ __volatile__("movl	$0xdeadface, %ebx\n");
>     (void)ioctl(0, TCGETS, &t); 
>     (void)getpid();
>     __asm__ __volatile__("cmpl	$0xdeadface, %ebx\n"
>                          "jnz   barf\n");
> 
>     return 0;
> }

> Until you can show the syscall that doesn't follow the correct
> rules, then my example is not flawed. In fact a modified example can
> be used to find any broken calls.
I putted in some assembler code in my original post that uses the sys_poll
syscall of which i _know_ it modifies one of it's arguments, to be more
specific, it's first argument, which is %ebx on passing in:
asmlinkage int sys_poll(struct pollfd * ufds, unsigned int nfds, long timeout)
....
      for(i=0; i < (int)nfds; i++, ufds++, fds1++) {
....

and in fact we saw that the change in %ebx is proportional to the nfds
as passed to sys_poll.

now however for sys_ioctl:
it's first argument, fd (%ebx on passing) is never modifed in the code 
nowhere is there an fd++ or similar, so again this 'example' of yours is
flawed.

gtx.
   dvorak


P.S. i think my original was quite clear and INCLUDED example code that can
easily be checked by someone who reads asm, i attach an extra copy which
explains all the asm in there for easier reference.

--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reg-bug.c"

/*
 * usage is easy, though not very friendly:
 * gcc reg-bug.c
 * ./a.out | od -tx4
 * <ENTER>
 * if the values outputted by hexdump are different the 'bug' is present
 * else the bug is not present
 * on a system without the bug:

dvorak$ dmesg | head -1
Linux version 2.2.21 (kernel@debian) (gcc version 2.95.4 20011002 (Debian prerelease)) #6 Sat Sep 7 22:48:42 CEST 2002
dvorak$ gcc reg-bug.c
dvorak$ ./a.out | od -tx4

0000000 bff7de6c bff7de6c
 
 * on a 'buggy' system:
 *

(m4xx) dmesg | head -1
(m4xx) Linux version 2.4.18 (maxx@meuuh) (gcc version 2.95.4 20011002 (Debian
+prerelease)) #2 Mon Jul 29 17:01:30 CEST 2002
(m4xx) $ gcc reg-bug.c
(m4xx) $ ./a.out | od -tx4
(m4xx) 0000000 bffffdcc bffffdbc

 */
int main(void)
{
    __asm__("
        pushl   $0x00010001     # this is events and revents
        pushl   $0x0            # fd 0
        pushl   $0x00010001     # again events and revents
        pushl   $0x1            # fd 1
        movl    %esp, %ebx      # %ebx now contains a pointer to the
                                # pollfd structure i setted up,
                                # note that only pushes occur
                                # below so this structures stays on the stack
        pushl   %ebx            # we pushl %ebx to compare it later
        movl    $0x2, %ecx      # 2 = number of fd's
        movl    $0xa8, %eax     # __NR_sys_poll
        movl    $(-1), %edx     # no timeout
        int     $0x80           # call kernel
                                # sys_poll(%ebx, %ecx, %edx)
                                #  %ebx == ufds (address of the pollfd structs)o                                #  %ecx == num fd's (2)
                                #  %edx == timeout (-1)
        pushl   %ebx            # we push the returned %ebx on the stack
                                # as well
        movl    %esp, %ecx      # %ecx is now pointer to the 2 saved %ebx's
        movl    $0x08, %edx     # %edx = 8
        movl    $0x04, %eax     # %eax = 4 == __NR_sys_write
        movl    $0x01, %ebx     # %ebx = 1 == fd
        int     $0x80           # call kernel
                                # sys_write(%ebx, %ecx, %edx)
                                #  %ebx = fd (1)
                                #  %ecx = buf (pointer to the 2 saved %ebx's)   
                                #  %edx = len (8)
        movl    $0x01, %eax     # and an sys_exit(0);
        xorl    %ebx, %ebx
        int     $0x80
   ");
}

--Dxnq1zWXvFF0Q93v--
