Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271374AbSISQEj>; Thu, 19 Sep 2002 12:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271499AbSISQEj>; Thu, 19 Sep 2002 12:04:39 -0400
Received: from chaos.analogic.com ([204.178.40.224]:386 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S271374AbSISQEi>; Thu, 19 Sep 2002 12:04:38 -0400
Date: Thu, 19 Sep 2002 12:11:58 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: dvorak <dvorak@xs4all.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: Syscall changes registers beyond %eax, on linux-i386
In-Reply-To: <20020919144533.GB2976@xs4all.nl>
Message-ID: <Pine.LNX.3.95.1020919115049.14758A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Sep 2002, dvorak wrote:

> Hi,
> 
> recently i came across a situation were on linux-i386 not only %eax was
> altered after a syscall but also %ebx. I tracked this problem down, to
> gcc re-using a variable passed to a function.
> 
> This was found on a debian system with a 2.4.17 kernel compiled with gcc
> 2.95.2 and verified on another system, kernel 2.4.18 compiled with 2.95.4 
> Attached is small program to test for this 'bug'
> 
> a syscall gets his data off the stack, the stack looks like:
> 
> saved(edx)
> saved(ecx)
> saved(ebx)
> return_addres 	(somewhere in entry.S)
> 
> When the syscall is called.
> 
> the register came there through use of 'SAVE_ALL'.
> 
> After the syscall returns these registers are restored using RESTORE_ALL
> and execution is transferred to userland again.
> 
> A short snippet of sys_poll, with irrelavant data removed.
> 
> sys_poll(struct pollfd *ufds, .. , ..) {
>     ...
>     ufds++;
>     ...
> }
> 
> It seems that gcc in certain cases optimizes in such a way that it changes
> the variable ufds as placed on the stack directly. Which results in saved(ebx)
> being overwritten and thus in a changed %ebx on return from the system call.
> 

The 'C' compiler must make room on the stack for any local
variables except register types. If it was doing as you state, you
couldn't even execute a "hello world" program. Further, the local
variables are after the return address. It would screw up the return
address and you'd go off into hyper-space upon return.


> I don't know if this is considered a bug, and if it is, from whom.
> If it's not a bug it means low-level userland programs need to be rewritten
> to store all registers on a syscall and restore them on return.
>

No. Various 'C' implementers have standardized calling methods even
though it's not part of the 'C' standard. gcc and others assume that
a called procedure is not going to change any segments or index registers.
There are various optimization things, like "-fcaller-saves" where the
called procedure can destroy anything. You may be using something that
was wrongly compiled using that switch.

 
> It shouldn't be a bug in gcc, since the C-standard doesn't talk about how to 
> pass variables and stuff. So it seems like a kernel(-gcc-interaction) bug.
> 
> To solve this issue 2 solutions spring to mind
> 1) add a flag to gcc to tell it that it shouldn't do this optimization, this
>    won't work with the gcc's already out there.
> 2) When calling a syscall explicitly push all variable an extra time, since
>    the code in entry.S doesn't know the amount of variables to a syscall it
>    needs to push all theoretical 6 parameters every time, a not so nice
>    overhead.
> 
>

There is a bug in some other code. Try this. It will show
that ebx is not being killed in a syscall. You can prove
that this code works by changing ebx to eax, which will
get destroyed and print "Broken" before exit.


#include <stdio.h>
#include <unistd.h>

void barf(void);
void barf()
{
    puts("Broken\n");
    exit(0);
}

int main()
{
    __asm__ __volatile__("movl	$0xdeadface, %ebx\n");
    (void)getpid();
    __asm__ __volatile__("cmpl	$0xdeadface, %ebx\n"
                         "jnz   barf\n");

    return 0;
}


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

