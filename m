Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272116AbSISRqb>; Thu, 19 Sep 2002 13:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272119AbSISRqb>; Thu, 19 Sep 2002 13:46:31 -0400
Received: from quark.didntduck.org ([216.43.55.190]:64518 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S272116AbSISRqa>; Thu, 19 Sep 2002 13:46:30 -0400
Message-ID: <3D8A0E90.9000005@didntduck.org>
Date: Thu, 19 Sep 2002 13:51:12 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: dvorak <dvorak@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: Syscall changes registers beyond %eax, on linux-i386
References: <Pine.LNX.3.95.1020919131927.15141A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> On Thu, 19 Sep 2002, Brian Gerst wrote:
>>Richard B. Johnson wrote:
>>>There is a bug in some other code. Try this. It will show
>>>that ebx is not being killed in a syscall. You can prove
>>>that this code works by changing ebx to eax, which will
>>>get destroyed and print "Broken" before exit.
>>
>>The bug is only with _some_ syscalls, and getpid() is not one of them, 
>>so your example is flawed.  It happens when a syscall modifies one of 
>>it's parameter values.  The solution is to assign the parameter to a 
>>local variable before modifying it.
>>
> 
> 
> Well which one?  Here is an ioctl(). It certainly modifies one
> of its parameter values.
> 
> #include <stdio.h>
> #include <unistd.h>
> #include <sys/ioctl.h>
> #include <termios.h>
> 
> void barf(void);
> void barf()
> {
>     puts("Broken\n");
>     exit(0);
> }
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
> 
> 
> Until you can show the syscall that doesn't follow the correct
> rules, then my example is not flawed. In fact a modified example can
> be used to find any broken calls.

Well the original poster gave one valid example: sys_poll().  We're not 
talking about it modifying userspace though a pointer.  We're talking 
about it taking it's parameter on the kernel stack (which is really the 
pt_regs structure saved from user space) and modifying it.  Which then 
gets restored to the user registers upon syscall exit.

This is how the kernel stack looks like inside a syscall (x86):
OLDSS
OLDESP
EFLAGS
CS
EIP
ORIG_EAX
ES
DS
EAX	<- syscall number
EBP	<- syscall arg6
EDI	<- syscall arg5
ESI	<- syscall arg4
EDX	<- syscall arg3
ECX	<- syscall arg2
EBX	<- syscall arg1
(return address)
(local variables)

Everything above the return address is the pt_regs struct that gets 
restored to user space.  If the syscall modifies any of its args (*not 
memory pointed to by the args*), they get written back to the stack in 
the pt_regs area, and then get restored to userspace modified. 
Understand now?

--
				Brian Gerst

