Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbULWFlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbULWFlS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 00:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbULWFlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 00:41:18 -0500
Received: from pool-141-154-204-248.bos.east.verizon.net ([141.154.204.248]:10756
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S261153AbULWFkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 00:40:36 -0500
Message-Id: <200412230759.iBN7xEBG005840@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: An apparent x86_64 ptrace bug
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 23 Dec 2004 02:59:14 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing some odd ptrace behavior on x86_64.  Namely,
	singlestep hitting the same IP twice,
	r11 and rcx changing values to those in eflags and rip, respectively

Singlestep stopping at the same instruction twice is suspicious in itself.
In looking through entry.S, I notice that the r11/eflags and rcx/rip pairs
have the same relation, namely that one member is stored in the stack slot
reserved for the other.

It looks like this is not being fixed up correctly in all cases before
returning to userspace.

Does this ring any bells?  The kernel here is stock FC3, 
config-2.6.9-1.681_FC3smp.

Below is the gdb session in question.  The first stepi seems to be gdb seeing
the queued SIGSTOP, which it has been told not to pass along to the process.
There are no register changes here.  The next stepi is the interesting one.
Here we get the same IP again, plus the rip/rcx and eflags/r11 copying.

				Jeff


Attaching to program: /home/jdike/linux/linux-2.6.9-rc/linux, process 5664
0x00000000004a39ac in ?? ()
(gdb) handle SIGSTOP nopass
Signal        Stop      Print   Pass to program Description
SIGSTOP       Yes       Yes     No              Stopped (signal)
(gdb) i reg
rax            0x6010c0 6295744
rbx            0x2      2
rcx            0x6010c0 6295744
rdx            0xa4     164
rsi            0x1      1
rdi            0x50     80
rbp            0x7fbfffdbe0     0x7fbfffdbe0
rsp            0x7fbfffdbc0     0x7fbfffdbc0
r8             0x0      0
r9             0x4dda00 5102080
r10            0xa      10
r11            0x601001 6295553
r12            0x6010a0 6295712
r13            0x0      0
r14            0x1      1
r15            0x0      0
rip            0x4a39ac 0x4a39ac
eflags         0x246    582
cs             0x33     51
ss             0x2b     43
ds             0x0      0
es             0x0      0
fs             0x0      0
gs             0x0      0
(gdb) x/x 0x6010c0
0x6010c0:       0x00000000
(gdb) stepi

Program received signal SIGSTOP, Stopped (signal).
0x00000000004a39ac in ?? ()
(gdb) i reg
rax            0x6010c0 6295744
rbx            0x2      2
rcx            0x6010c0 6295744
rdx            0xa4     164
rsi            0x1      1
rdi            0x50     80
rbp            0x7fbfffdbe0     0x7fbfffdbe0
rsp            0x7fbfffdbc0     0x7fbfffdbc0
r8             0x0      0
r9             0x4dda00 5102080
r10            0xa      10
r11            0x601001 6295553
r12            0x6010a0 6295712
r13            0x0      0
r14            0x1      1
r15            0x0      0
rip            0x4a39ac 0x4a39ac
eflags         0x346    838
cs             0x33     51
ss             0x2b     43
ds             0x0      0
es             0x0      0
fs             0x0      0
gs             0x0      0
(gdb) disas 0x4a3990 0x4a3a00
Dump of assembler code from 0x4a3990 to 0x4a3a00:
0x00000000004a3990:     add    %cl,0xffffffffffffff89(%rax)
0x00000000004a3993:     add    $0x15d158,%eax
0x00000000004a3998:     mov    %rax,%rcx
0x00000000004a399b:     mov    $0x4dda00,%r9d
0x00000000004a39a1:     lea    0x0(,%r10,8),%rdi
0x00000000004a39a9:     xor    %r8d,%r8d
0x00000000004a39ac:     mov    0x4dd9f0(,%r8,8),%r11
0x00000000004a39b4:     mov    %r9,0x18(%rcx)
0x00000000004a39b8:     xor    %eax,%eax
0x00000000004a39ba:     mov    %rcx,(%r12)
0x00000000004a39be:     add    $0x8,%r12
0x00000000004a39c2:     movq   $0x4dda6a,0x8(%rcx)
0x00000000004a39ca:     movq   $0x0,0x10(%rcx)
0x00000000004a39d2:     lea    0x1(%r11,%r9,1),%r9
0x00000000004a39d7:     mov    %r11,0x20(%rcx)
0x00000000004a39db:     jmp    0x4a39eb
0x00000000004a39dd:     data16
0x00000000004a39de:     data16
0x00000000004a39df:     nop    
0x00000000004a39e0:     movl   $0x0,0x28(%rcx,%rax,4)
0x00000000004a39e8:     inc    %rax
0x00000000004a39eb:     cmp    %rsi,%rax
0x00000000004a39ee:     jb     0x4a39e0
0x00000000004a39f0:     inc    %r8
0x00000000004a39f3:     lea    (%rdi,%rcx,1),%rdx
0x00000000004a39f7:     xor    %eax,%eax
0x00000000004a39f9:     cmp    $0x2,%r8
0x00000000004a39fd:     cmovne %rdx,%rax
End of assembler dump.
(gdb) x/x 0x4dd9f0
0x4dd9f0:       0x00000007
(gdb) stepi
0x00000000004a39ac in ?? ()
(gdb) i reg
rax            0x6010c0 6295744
rbx            0x2      2
rcx            0x4a39ac 4864428
rdx            0xa4     164
rsi            0x1      1
rdi            0x50     80
rbp            0x7fbfffdbe0     0x7fbfffdbe0
rsp            0x7fbfffdbc0     0x7fbfffdbc0
r8             0x0      0
r9             0x4dda00 5102080
r10            0xa      10
r11            0x346    838
r12            0x6010a0 6295712
r13            0x0      0
r14            0x1      1
r15            0x0      0
rip            0x4a39ac 0x4a39ac
eflags         0x346    838
cs             0x33     51
ss             0x2b     43
ds             0x0      0
es             0x0      0
fs             0x0      0
gs             0x0      0


