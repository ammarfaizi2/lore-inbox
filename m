Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267660AbUIMPMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267660AbUIMPMa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 11:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268578AbUIMPJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 11:09:00 -0400
Received: from mail3.iserv.net ([204.177.184.153]:25277 "EHLO mail3.iserv.net")
	by vger.kernel.org with ESMTP id S268172AbUIMPAW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 11:00:22 -0400
Message-ID: <4145B606.5080505@didntduck.org>
Date: Mon, 13 Sep 2004 11:00:22 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Constantine Gavrilov <constg@qlusters.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Calling syscalls from x86-64 kernel results in a crash on Opteron
 machines
References: <4145A8E1.8010409@qlusters.com>
In-Reply-To: <4145A8E1.8010409@qlusters.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Constantine Gavrilov wrote:
> Hello:
> 
> We have a piece of kernel code that calls some system calls in kernel 
> context (from a process with mm and a daemonized kernel thread that does 
> not have mm). This works fine on IA64 and i386 architectures.
> 
> When I try this on x86-64 kernel on Opteron machines, it results in 
> immediate crash. I have tried standard _syscall() macros from 
> asm/unistd.h. The system panics when returning from the system call.
> The disassembled code shows that gcc has often a hard time deciding 
> which registers (32-bit or 64-bit) it will use. For example, it puts the 
> system call number to eax, while it should put it to rax. However, this 
> register thing is not a problem. I have tried my own gcc hand-crafted 
> inline assembly and glibc inline syscall assembly that results in 
> "correct" disassembled code. The result is always the same -- kernel 
> crash when calling a function defined by _syscall() macros or when using 
> an "inline" block defined by glibc macros.
> 
> Attached please find a test module that tries to call the umask() (JUST 
> TO DEMONSTRATE a problem) via the syscall machanism. Both methods (the 
> _syscall1() marco and GLIBC INLINE_SYCALL() were used.
> 
> The assembly dump of the umask() called via _syscall(1) and via 
> INLINE_SYSCALL() as well as the disassembly of umask() from glibc are 
> provided in a separate attachement. The crash dump (captured with a 
> serial console) is provided along with disassembly of the main module 
> function.
> 
> It seems that segmentation is changed during the syscall and not 
> restored properly, or some other REALLY BAD THING happens. The entry.S 
> for x86_64 architecture is very informative, but I am not an expert in 
> Opteron architecture and I do not know how the syscall instruction is 
> supposed to work.
> 
> Can someone explain the reason for the crash? Can you think of a 
> workaround? Comments and ideas are very welcome (except of the kind that 
> it can be implemented in the user space or with a help of a user proxy 
> process).

You should never use the unistd.h macros from kernel space.  Call 
sys_foo() directly.  This may mean you have to export it.  The reason it 
crashes is that the "syscall" opcode used by the x86-64 macros (unlike 
the "int $0x80" for i386) causes a fault when already running in kernel 
space.

--
				Brian Gerst
