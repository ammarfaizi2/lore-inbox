Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263631AbTEDPLn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 11:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263632AbTEDPLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 11:11:43 -0400
Received: from science.horizon.com ([192.35.100.1]:60974 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S263631AbTEDPLl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 11:11:41 -0400
Date: 4 May 2003 15:24:05 -0000
Message-ID: <20030504152405.7501.qmail@science.horizon.com>
From: linux@horizon.com
To: Valdis.Kletnieks@vt.edu
Subject: Re: [Announcement] "Exec Shield", new Linux security feature
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200305032300.h43N0UX9006675@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 03 May 2003 13:19:52 -0000, linux@horizon.com  said:
> An interesting question arises: is the number of useful interpreter
> functions (system, popen, exec*) sufficiently low that they could be
> removed from libc.so entirely and only staticly linked, so processes
> that didn't use them wouldn't even have them in their address space,
> and ones that did would have them at less predictible addresses?
> 
> Right now, I'm thinking only of functions that end up calling execve();
> are there any other sufficiently powerful interpreters hiding in common
> system libraries?  regexec()?

To which Valdis.Kletnieks replied:
> This does absolutely nothing to stop an exploit from providing its own
> inline version of execve().  There's nothing in libc that a process can't
> do itself, inline.

Ah, but with a non-executable stack, how do you arrange the inline code?
if you include it in the buffer overflow on the stack, it's in the
non-executable range.

You could arrange a return to memcpy(), with a stack like this:

[Address of memcpy()]
[Exploit target address (return address from memcpy)]
[Exploit target address (destination of memcpy)]
[Address of code on stack (source of memcpy)]
[Length of code on stack]
[Exploit code]

This would work if you had an "exploit target address" that was
writeable and executable, which this could copy the code to, but that's
hard to come by.

Now, we could stick a call to mprotect on the stack before that, but
it's hard to get the protection flags past the kernel test:

mm/mprotect.c, like 237:
        if (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM))
                return -EINVAL;

When your exploit can't include any null bytes.


Arjan's idea about a CAP_EXEC would be better, if it could be dropped
automagically by linker magic on existing code.

In fact, there are several other capabilities that would be nice to
have droppable:

- Ability to open an existing regular file or device (seekable,
  persistent storage) for writing.  An SMTP daemon could probably
  drop this.
- Ability to create an externally accessible listening socket
  (listen() on non-PF_UNIX)
- Ability to connect to an external address (connect() on non-PF_UNIX)

The PF_UNIX exception is for /dev/log.
