Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262959AbVBCOi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262959AbVBCOi6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 09:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263336AbVBCOaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 09:30:20 -0500
Received: from gizmo03bw.bigpond.com ([144.140.70.13]:3726 "HELO
	gizmo03bw.bigpond.com") by vger.kernel.org with SMTP
	id S263291AbVBCOU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 09:20:56 -0500
From: pageexec@freemail.hu
To: Ingo Molnar <mingo@elte.hu>
Date: Fri, 04 Feb 2005 00:20:43 +1000
MIME-Version: 1.0
Subject: Re: Sabotaged PaXtest (was: Re: Patch 4/6  randomize the stack pointer)
Reply-to: pageexec@freemail.hu
CC: linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@redhat.com>,
       "Theodore Ts'o" <tytso@mit.edu>
Message-ID: <4202BFDB.24670.67046BC@localhost>
In-reply-to: <20050203094410.GB1065@elte.hu>
References: <4201DBE7.30569.2F5D446@localhost>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > dl_make_stack_executable() will nicely return into user_input
> > (at which time the stack has already become executable).
> 
> wrong, _dl_make_stack_executable() will not return into user_input() in
> your scenario, and your exploit will be aborted. Check the glibc sources
> and the implementation of _dl_make_stack_executable() in particular. 

oh, you mean the invincible __check_caller(). one possibility:

[...]
[field1 and other locals replaced with shellcode]
[value of __libc_stack_end]
[some space for the local variables of dl_make_stack_executable and others]
[saved EBP replaced with anything in this case]
[saved EIP replaced with address of a 'pop eax'/'retn' sequence]
[address of [value of __libc_stack_end], loads into eax]
[address of dl_make_stack_executable()]
[address of a suitable 'retn' insn in ld.so/libpthread.so]
[user_input left in place, i.e., overflows end before this]
[...]

this payload needs two overflows to construct the two 0 bytes needed
(a memcpy based one would easily get away with one of course) and an
extra condition in that in order to load eax we need to find an
addressable (executable memory outside the ascii armor, this may
very well include some library/main executable .data/.bss as well
under Exec-Shield) 2 byte sequence that encodes pop eax/retn or
popad/retn (for the latter the stack has to be filled appropriately
with more data of course). other sequences could do the job as well,
these two are just the trivial ones that come to mind and i found
in some binaries i checked quickly (my sshd also has a sequence of
pop eax/pop ebx/pop esi/pop edi/pop ebp/retn for example, suitable
as well). the question of whether you can get away with one overflow
(strcpy() or similar based) is open, i don't quite have the time to
hunt down all the nice insn sequences that can help loading registers
with proper content and execute dl_make_stack_executable() or a
suitable part of it. at least there's no explicit mechanism in this
system that would prevent it in a guaranteed way.

