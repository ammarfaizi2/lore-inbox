Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbVKWUYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbVKWUYL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 15:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbVKWUYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 15:24:10 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:12496 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S932334AbVKWUYB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 15:24:01 -0500
Message-ID: <4384CFD9.1010106@fr.ibm.com>
Date: Wed, 23 Nov 2005 21:23:53 +0100
From: Greg <gkurz@fr.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Jacobowitz <dan@debian.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: sigsuspend() and ptrace()
References: <436B228D.2000309@fr.ibm.com> <20051119042240.GA31395@nevyn.them.org>
In-Reply-To: <20051119042240.GA31395@nevyn.them.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jacobowitz wrote:
> On Fri, Nov 04, 2005 at 09:57:49AM +0100, Greg wrote:
> 
>>Hi,
>>
>>My program uses gdb to attach to a process and make it execute a specific
>>function thanks to the gdb 'call' command. This works quite well unless the
>>attached process is sleeping in sigsuspend(). I peeked into the kernel sources
>>and saw that the typical sigsuspend() implementation is like this :
>>
>>while (1) {
>>	schedule();
>>	if (do_signal())
>>		return -EINTR;
>>}
>>
>>When using ptrace attach, the target process receives a SIGSTOP but there
>>isn't *of course* any handler to SIGSTOP. And no way for the process to return
>>to userland... is it implemented that way on purpose ? How can I make suspending
>>processes do some *alternative* work with gdb ?
> 
> 
> Sorry, I'm a bit behind on lkml.
> 

No problem. Everything's fine.

> What's _supposed_ to happen is that sigsuspend should be interrupted by
> the SIGSTOP even though there is no handler.  SIGSTOP can't be blocked.
> 

>From a POSIX user perspective, what's expected is that sigsuspend() shouldn't
be interrupted by uncatchable signal SIGSTOP. But let's forget SIGSTOP because
it's only used as a way to interrupt tasks when one is ptracing. My real
concern lies elsewhere.

First, suspending processes receiving a SIGSTOP because of ptrace_attach() go to
sleep in ptrace_stop() instead of being strictly stopped. Right ?

Step 1: the process was just attached by gdb

sigsuspend    t 00000000  1692  3584   3588          3590       (NOTLB)
f5de6eac 00000082 78af9163 00000000 00000000 00000000 f5ea34d0 fffcf000
       c1f15f20 f77059c4 c201dd60 00000000 00002d21 73e83c3e 00000239 c0316a60
       f7656b30 f7656c9c 00000000 00000002 f5de6000 00000013 00000013 f5de6000
Call Trace:
 [<c012baff>] ptrace_stop+0xa0/0xee
 [<c012bf2d>] get_signal_to_deliver+0x142/0x3e4
 [<c0105c22>] do_signal+0x55/0xd9
 [<c011caf1>] finish_task_switch+0x30/0x66
 [<c02c76a0>] schedule+0x844/0x87a
 [<c0105126>] sys_rt_sigsuspend+0xf8/0x108
 [<c02c9413>] syscall_call+0x7/0xb

When the attached process resumes execution in ptrace_stop() because the tracer
ask for it with ptrace(PTRACE_CONT), I see no way for her to go back to user
space. The process will loop directly back into schedule().

Step 2: the command 'call my_function()' is invoked in gdb

sigsuspend    S 0000000A  1692  3584   3588                     (NOTLB)
f5de6f9c 00000082 f7763438 0000000a 00000246 00000000 bff4095c 00000000
       f5de6f68 00000000 c201dd60 00000000 00002395 8ceccd36 0000025b c0316a60
       f7656b30 f7656c9c 00000000 00000002 f5de6000 f5de6fac bff40b60 f5de6000
Call Trace:
 [<c010511b>] sys_rt_sigsuspend+0xed/0x108
 [<c02c9413>] syscall_call+0x7/0xb

=> the process resumed sigsuspend() instead of executing my_function() in user
   space, as other programs do. Is this behaviour consistent ?

I would see something like this to work:

while (1) {
	schedule();
	if (do_signal())
		return -EINTR;
	if (some_condition)
		return some_return_value;
}

but I don't have any idea on what could be the condition and the return value.

> You didn't say what kernel version or architecture you were having
> trouble with; which is it?  It looks right in current 2.6 for i386 and
> ppc, which were the only ones I checked.
> 

I didn't mention any version or arch since it seems to be the *standard*
design for sigsuspend() and rt_sigsuspend() on i386, x86_64 and s390 since
2.4.

Thanks.

-G-
