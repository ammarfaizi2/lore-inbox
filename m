Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269665AbSISOkc>; Thu, 19 Sep 2002 10:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269702AbSISOkb>; Thu, 19 Sep 2002 10:40:31 -0400
Received: from mxzilla2.xs4all.nl ([194.109.6.50]:17676 "EHLO
	mxzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S269665AbSISOka>; Thu, 19 Sep 2002 10:40:30 -0400
Date: Thu, 19 Sep 2002 16:45:33 +0200
From: dvorak <dvorak@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: Syscall changes registers beyond %eax, on linux-i386
Message-ID: <20020919144533.GB2976@xs4all.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

recently i came across a situation were on linux-i386 not only %eax was
altered after a syscall but also %ebx. I tracked this problem down, to
gcc re-using a variable passed to a function.

This was found on a debian system with a 2.4.17 kernel compiled with gcc
2.95.2 and verified on another system, kernel 2.4.18 compiled with 2.95.4 
Attached is small program to test for this 'bug'

a syscall gets his data off the stack, the stack looks like:

saved(edx)
saved(ecx)
saved(ebx)
return_addres 	(somewhere in entry.S)

When the syscall is called.

the register came there through use of 'SAVE_ALL'.

After the syscall returns these registers are restored using RESTORE_ALL
and execution is transferred to userland again.

A short snippet of sys_poll, with irrelavant data removed.

sys_poll(struct pollfd *ufds, .. , ..) {
    ...
    ufds++;
    ...
}

It seems that gcc in certain cases optimizes in such a way that it changes
the variable ufds as placed on the stack directly. Which results in saved(ebx)
being overwritten and thus in a changed %ebx on return from the system call.

I don't know if this is considered a bug, and if it is, from whom.
If it's not a bug it means low-level userland programs need to be rewritten
to store all registers on a syscall and restore them on return.

It shouldn't be a bug in gcc, since the C-standard doesn't talk about how to 
pass variables and stuff. So it seems like a kernel(-gcc-interaction) bug.

To solve this issue 2 solutions spring to mind
1) add a flag to gcc to tell it that it shouldn't do this optimization, this
   won't work with the gcc's already out there.
2) When calling a syscall explicitly push all variable an extra time, since
   the code in entry.S doesn't know the amount of variables to a syscall it
   needs to push all theoretical 6 parameters every time, a not so nice
   overhead.


I hope someone can shed some light on this issue, i am not myself reading
the linux-kernel mailing list, and would like to be cc'd if possible (i'll
also check the archives so it's not 100% needed).

Thanks in advance,
  Dvorak

--5mCyUwZo2JvN/JJP
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
        pushl   $0x00010001 
        pushl   $0x0
        pushl   $0x00010001 
        pushl   $0x1
        movl    %esp, %ebx
        pushl   %ebx
        movl    $0x2, %ecx
        movl    $0xa8, %eax
        movl    $(-1), %edx
        int     $0x80
        pushl   %ebx
        movl    %esp, %ecx
        movl    $0x08, %edx
        movl    $0x04, %eax
        movl    $0x01, %ebx
        int     $0x80
        movl    $0x01, %eax
        xorl    %ebx, %ebx
        int     $0x80
   ");
}

--5mCyUwZo2JvN/JJP--
