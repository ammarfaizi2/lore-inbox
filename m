Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbVI2P6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbVI2P6N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 11:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbVI2P6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 11:58:13 -0400
Received: from jade.aracnet.com ([216.99.193.136]:45020 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S932174AbVI2P6N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 11:58:13 -0400
Message-ID: <433C0F21.8070104@BitWagon.com>
Date: Thu, 29 Sep 2005 08:58:25 -0700
From: John Reiser <jreiser@BitWagon.com>
Organization: -
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ptrace unexpected SIGTRAP (trace bit) on x86, x86_64  kernel 2.6.13.2
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ptrace is giving unexpected SIGTRAP (trace bit) in kernel 2.6.13.2
on both x86 and x86_64.

The 8-instruction program below just execve()s itself over and over.
When run under gdb, the first user-visible SIGTRAP is expected due to
the 'int3'.  But the second user-visible SIGTRAP is unexpected, as
there is no reason to trap.

Changing the line "nop; int3" to "nop; nop" gives a program that
just spins merrily when run under /bin/bash.  But gdb sees a SIGTRAP,
with the $pc pointing after the second 'nop'.  When run under strace
(strace gdb ./execve; (gdb) run), the process spins merrily with
no unexpected SIGTRAP.


-----execve.S
#include <asm/unistd.h>

/*
gcc -o execve -nostartfiles -nostdlib execve.S
gdb ./execve
run
p/x $ps
   # 0x202
c
p/x $ps
   # 0x302  TF (0x100) set, but should not be
*/

_start: .globl _start
        nop; int3
        popl %ebp  # argc
        movl (%esp),%ebx  # same filename from argv[0]
        movl %esp,%ecx    # same argv
        lea 4(%esp,%ebp,4),%edx  # same envp
        movl $__NR_execve,%eax   # here we go 'round the mulberry bush, ...
        int $0x80
-----end of execve.S

Previous history, and translation for x86_64 are at:
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=144805#c23

-- 
John Reiser, jreiser@BitWagon.com
