Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271844AbSISREy>; Thu, 19 Sep 2002 13:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271850AbSISREy>; Thu, 19 Sep 2002 13:04:54 -0400
Received: from quark.didntduck.org ([216.43.55.190]:60934 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S271844AbSISREv>; Thu, 19 Sep 2002 13:04:51 -0400
Message-ID: <3D8A04C0.6050508@didntduck.org>
Date: Thu, 19 Sep 2002 13:09:20 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: dvorak <dvorak@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: Syscall changes registers beyond %eax, on linux-i386
References: <Pine.LNX.3.95.1020919115049.14758A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> On Thu, 19 Sep 2002, dvorak wrote:
> 
> 
>>Hi,
>>
>>recently i came across a situation were on linux-i386 not only %eax was
>>altered after a syscall but also %ebx. I tracked this problem down, to
>>gcc re-using a variable passed to a function.
>>
>>This was found on a debian system with a 2.4.17 kernel compiled with gcc
>>2.95.2 and verified on another system, kernel 2.4.18 compiled with 2.95.4 
>>Attached is small program to test for this 'bug'
>>
>>a syscall gets his data off the stack, the stack looks like:
>>
>>saved(edx)
>>saved(ecx)
>>saved(ebx)
>>return_addres 	(somewhere in entry.S)
>>
>>When the syscall is called.
>>
>>the register came there through use of 'SAVE_ALL'.
>>
>>After the syscall returns these registers are restored using RESTORE_ALL
>>and execution is transferred to userland again.
>>
>>A short snippet of sys_poll, with irrelavant data removed.
>>
>>sys_poll(struct pollfd *ufds, .. , ..) {
>>    ...
>>    ufds++;
>>    ...
>>}
>>
>>It seems that gcc in certain cases optimizes in such a way that it changes
>>the variable ufds as placed on the stack directly. Which results in saved(ebx)
>>being overwritten and thus in a changed %ebx on return from the system call.
>>
> 
> 
> The 'C' compiler must make room on the stack for any local
> variables except register types. If it was doing as you state, you
> couldn't even execute a "hello world" program. Further, the local
> variables are after the return address. It would screw up the return
> address and you'd go off into hyper-space upon return.
> 
> 
> 
>>I don't know if this is considered a bug, and if it is, from whom.
>>If it's not a bug it means low-level userland programs need to be rewritten
>>to store all registers on a syscall and restore them on return.
>>
> 
> 
> No. Various 'C' implementers have standardized calling methods even
> though it's not part of the 'C' standard. gcc and others assume that
> a called procedure is not going to change any segments or index registers.
> There are various optimization things, like "-fcaller-saves" where the
> called procedure can destroy anything. You may be using something that
> was wrongly compiled using that switch.
> 
>  
> 
>>It shouldn't be a bug in gcc, since the C-standard doesn't talk about how to 
>>pass variables and stuff. So it seems like a kernel(-gcc-interaction) bug.
>>
>>To solve this issue 2 solutions spring to mind
>>1) add a flag to gcc to tell it that it shouldn't do this optimization, this
>>   won't work with the gcc's already out there.
>>2) When calling a syscall explicitly push all variable an extra time, since
>>   the code in entry.S doesn't know the amount of variables to a syscall it
>>   needs to push all theoretical 6 parameters every time, a not so nice
>>   overhead.
>>
>>
> 
> 
> There is a bug in some other code. Try this. It will show
> that ebx is not being killed in a syscall. You can prove
> that this code works by changing ebx to eax, which will
> get destroyed and print "Broken" before exit.

The bug is only with _some_ syscalls, and getpid() is not one of them, 
so your example is flawed.  It happens when a syscall modifies one of 
it's parameter values.  The solution is to assign the parameter to a 
local variable before modifying it.

--
				Brian Gerst

