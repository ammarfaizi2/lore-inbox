Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbVFPNRC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbVFPNRC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 09:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbVFPNRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 09:17:01 -0400
Received: from ext-ch1gw-7.online-age.net ([64.37.194.15]:64646 "EHLO
	ext-ch1gw-7.online-age.net") by vger.kernel.org with ESMTP
	id S261673AbVFPNQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 09:16:56 -0400
Date: Thu, 16 Jun 2005 08:15:13 -0500
From: Rich Coe <Richard.Coe@med.ge.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.11.11 x86_64 gdb passes ERESTARTNOHAND to user process
Message-ID: <20050616081513.00780068@godzilla>
Organization: CSE
X-Mailer: Sylpheed-Claws 0.9.13 (GTK+ 1.2.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm chasing a problem on linux 2.6.11.11 x86_64 where when you attach gdb,
select() returns ERESTARTNOHAND (errno 514) to the user process.
The same problem occurs whether it is a 32bit or 64bit process being debugged.

I'd be interested in any comments you may have.

How to reproduce:
    - attach to a process with gdb, or stop the running process within gdb
    - call a function, eg 'call sleep(1)'
    - continue program execution

On i386, it seems as if the EIP is backed up 2 insn's to execute the
'jmp' insn that causes the system call to be restarted. 

On x86_64, the EIP is not backed up, the system call is not restarted, and
the internal kernel errno is passed on to the user process.

Thanks.

:::: calling a function on x86_64 ::::
Program received signal SIGINT, Interrupt.
0xffffe405 in __kernel_vsyscall ()
1: x/i $pc  0xffffe405 <__kernel_vsyscall+5>:   mov    $0x2b,%ecx
(gdb) call doNothing()
(gdb) x/i $pc
0xffffe405 <__kernel_vsyscall+5>:       mov    $0x2b,%ecx
(gdb) x/8i 0xffffe400
0xffffe400 <__kernel_vsyscall>:         push   %ebp
0xffffe401 <__kernel_vsyscall+1>:       mov    %ecx,%ebp
0xffffe403 <__kernel_vsyscall+3>:       syscall
0xffffe405 <__kernel_vsyscall+5>:       mov    $0x2b,%ecx
0xffffe40a <__kernel_vsyscall+10>:      movl   %ecx,%ss
0xffffe40c <__kernel_vsyscall+12>:      mov    %ebp,%ecx
0xffffe40e <__kernel_vsyscall+14>:      pop    %ebp
0xffffe40f <__kernel_vsyscall+15>:      ret
(gdb) stepi
0xffffe40a in __kernel_vsyscall ()
1: x/i $pc  0xffffe40a <__kernel_vsyscall+10>:  movl   %ecx,%ss
(gdb) stepi
0xffffe40e in __kernel_vsyscall ()
1: x/i $pc  0xffffe40e <__kernel_vsyscall+14>:  pop    %ebp

:::: calling a function on i386 ::::
Program received signal SIGINT, Interrupt.
0xffffe410 in __kernel_vsyscall ()
1: x/i $pc  0xffffe410 <__kernel_vsyscall+16>:  pop    %ebp
(gdb) x/8i 0xffffe400
0xffffe400 <__kernel_vsyscall>:         push   %ecx
0xffffe401 <__kernel_vsyscall+1>:       push   %edx
0xffffe402 <__kernel_vsyscall+2>:       push   %ebp
0xffffe403 <__kernel_vsyscall+3>:       mov    %esp,%ebp
0xffffe405 <__kernel_vsyscall+5>:       sysenter
0xffffe407 <__kernel_vsyscall+7>:       nop
0xffffe408 <__kernel_vsyscall+8>:       nop
0xffffe409 <__kernel_vsyscall+9>:       nop
0xffffe40a <__kernel_vsyscall+10>:      nop
0xffffe40b <__kernel_vsyscall+11>:      nop
0xffffe40c <__kernel_vsyscall+12>:      nop
0xffffe40d <__kernel_vsyscall+13>:      nop
0xffffe40e <__kernel_vsyscall+14>:      jmp    0xffffe403 <__kernel_vsyscall+3>
0xffffe410 <__kernel_vsyscall+16>:      pop    %ebp
0xffffe411 <__kernel_vsyscall+17>:      pop    %edx
0xffffe412 <__kernel_vsyscall+18>:      pop    %ecx
0xffffe413 <__kernel_vsyscall+19>:      ret
(gdb) call doNothing()
(gdb) stepi
0xffffe403 in __kernel_vsyscall ()
1: x/i $pc  0xffffe403 <__kernel_vsyscall+3>:   mov    %esp,%ebp
(gdb) c
Continuing.

Program received signal SIGINT, Interrupt.
0xffffe410 in __kernel_vsyscall ()
1: x/i $pc  0xffffe410 <__kernel_vsyscall+16>:  pop    %ebp
(gdb) call doNothing()
(gdb) x/i $pc
0xffffe410 <__kernel_vsyscall+16>:      pop    %ebp
(gdb) stepi
0xffffe403 in __kernel_vsyscall ()
1: x/i $pc  0xffffe403 <__kernel_vsyscall+3>:   mov    %esp,%ebp

-- 
Rich Coe		richard.coe@med.ge.com
General Electric Healthcare Technologies
Global Software Platforms, Computer Technology Team
