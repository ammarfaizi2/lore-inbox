Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751219AbWFEQzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbWFEQzy (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 12:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbWFEQzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 12:55:54 -0400
Received: from [207.35.253.199] ([207.35.253.199]:15057 "EHLO
	smtp.discreet.com") by vger.kernel.org with ESMTP id S1751049AbWFEQzx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 12:55:53 -0400
Message-ID: <44846210.4080602@discreet.com>
Date: Mon, 05 Jun 2006 12:55:44 -0400
From: Martin Bisson <bissonm@discreet.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.4.1 (X11/20050719)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: x86_64 system call entry points
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, (first post)

I am trying to trace system calls (entry + exit) on x86_64 architecture, 
so I am basically working on arch/x86_64/kernel/entry.S and 
arch/x86_64/ia32/ia32entry.S (for 32-bit compatibility).  I want to test 
that my code works for all possible ways to enter a system call, which 
are (to my knowledge) the three following instructions:
- int $0x80
- sysenter
- syscall

So these three ways in, used in a 32 or 64 bits executable, makes 6 
possible ways to enter a system call that I need to test.  However, I 
have problems:

- sysenter/32 bits, executed on a 32 bit machine: I get a segfault on 
the sysenter instruction.  I use the following code to enter the system 
call:
pid_t getpid32()
{
    pid_t resultvar;

    asm volatile (
    "push    %%ebp\n\t"
    "push    %%ecx\n\t"
    "push    %%edx\n\t"
    "mov     %%esp,%%ebp\n\t"
    "sysenter\n\t"
    ".space 20,0x90\n\t"
    "pop     %%edx\n\t"
    "pop     %%ecx\n\t"
    "pop     %%ebp\n\t"
    : "=a" (resultvar)   
    : "0" (__NR_getpid)
    : "memory");

    return resultvar;
}

Is there something wrong in the way I pass the parameters?  I know this 
instruction can be tricky because of the way it messes different 
registers...


- int $0x80/64 bits: All system calls return -1 (EINTR).  Is there 
something wrong in the way I call it:
pid_t getpid64()
{
    pid_t resultvar;

    asm volatile (
    "int $0x80\n\t"
    : "=a" (resultvar)   
    : "0" (__NR_getpid)
    : "memory");

    return resultvar;
}


- sysenter/64 bits: I get an illegal instruction.  I've read that it's 
not implemented on AMD-64 (which is what I have).  Is there ANY x86_64 
machine on which this instruction is implemented?  Does this mean that 
the code that handles this case in entry.S has never been run?

- syscall/64 bits: works fine
- int $0x80/32 bits: works fine
- syscall/32 bits: illegal instruction, but I guess that's all right 
because of the machine I use.

Can someone help with any of my issues (entering a system call with 
sysenter/32 bits, int $0x80/64 bits or sysenter/64 bits)?

Thanks in advance,

Mart

P.S.  First post on this list, please reply in private if I did 
something wrong so that I won't do it again.
