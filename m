Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263271AbTECNHc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 09:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263281AbTECNHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 09:07:32 -0400
Received: from science.horizon.com ([192.35.100.1]:22853 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S263271AbTECNHb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 09:07:31 -0400
Date: 3 May 2003 13:19:52 -0000
Message-ID: <20030503131952.5560.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org
Subject: Re: [Announcement] "Exec Shield", new Linux security feature
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ingo Molnar wrote:
> On Fri, 2 May 2003, Carl-Daniel Hailfinger wrote:
>> If my math is correct,
>> 0x01000000 is 16 MB boundary
>> 0x01003fff is outside the ASCII-armor.
> 
> the ASCII-armor, more precisely, is between addresses 0x00000000 and
> 0x0100ffff. Ie. 16 MB + 64K. [in the remaining 64K the \0 character is in
> the second byte of the address.] So the 0x01003fff address is still inside 
> the ASCII-armor.

To be precise, the first addressible address is 0x01010101 (16M+64K+256+1).
Rounding this to a page boundary produces the figure above.

Just as a reminder, the standard stack-smashing attack for non-executable
stacks works by overwriting the current call frame's return address with

[entry address of interesting function, like system()]
[dummy return address]
[char *argument]
[string pointed to by above argument]

When the current function returns, the CPU will return to the entry
address of system() with the desired arguments on the stack.
(This is trickier on architectures which put arguments in registers,
so you have to find a "pop argument registers; return" sequence in the
standard library and return to that first.)

The ASCII string is then passed to some "interesting" function which
has interpreter powers and "executes" it without caring about the
processor's idea of execute permission.

If this is done by passing an unexpectedly long input to strcpy()
or gets(), then none of the arguments can have an embedded zero byte,
except the final string.

The stack address is needed to arrange for the char *argument to point
to the string.  If the string is an executable path, some uncertainty
can be resolved by using a path like:

/../../../../../../../../../../../../../../../../../bin/sh

Or, if you know the stack is 2-byte aligned (people aren't usually
willing to put up with the performance hit for odd stack pointers even
on architectures like x86 which can handle them), you can use

/./././././././././././././././././././././././././bin/sh

A pointer a little past the start of the string will still
end up referencing /bin/sh.



An interesting question arises: is the number of useful interpreter
functions (system, popen, exec*) sufficiently low that they could be
removed from libc.so entirely and only staticly linked, so processes
that didn't use them wouldn't even have them in their address space,
and ones that did would have them at less predictible addresses?

Right now, I'm thinking only of functions that end up calling execve();
are there any other sufficiently powerful interpreters hiding in common
system libraries?  regexec()?
