Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263491AbTBMEJR>; Wed, 12 Feb 2003 23:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267778AbTBMEJR>; Wed, 12 Feb 2003 23:09:17 -0500
Received: from mnh-1-21.mv.com ([207.22.10.53]:10757 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S263491AbTBMEJQ>;
	Wed, 12 Feb 2003 23:09:16 -0500
Message-Id: <200302130412.XAA05507@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: ebiederm@xmission.com
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.60
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 12 Feb 2003 23:12:38 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com said:
> Or it can use the linker to play games with symbol names to move the
> kernel off into it's own separate name space.
>
> This sounds like a good opportunity to figure out which makes most
> sense  and future proof UML. 

OK, I thought I had a cunning plan to deal with this problem, but it falls
apart when you actually think about it some.

The problem is this -
	2.5.60 introduces sigprocmask as a kernel function
	UML calls sigprocmask from its userspace code (the stuff that interacts
with libc rather than the kernel) and it expects to get the libc sigprocmask
which makes a system call into the host kernel
	Instead, it gets the new kernel sigprocmask, and things go downhill
rapidly from there

My cunning plan was this -
	link UML's userspace code into a single .o (call it userspace.o), 
similarly link its kernel code into a single .o (kernel.o)
	do an incremental link of userspace.o against libc, thereby resolving
sigprocmask to the libc version
	link all of UML together, kernel code and userspace code.  Any remaining
references to sigprocmask will be in kernel code, and will resolve to the new
kernel sigprocmask.

This falls apart for a couple of reasons -
	I get a duplicate definition of sscanf which I can't get rid of (libc
vs. lib/vsprintf.c)
	More seriously, this assumes a static link and breaks the dynamic build
of UML

In order for this to work, references from userspace.o which can be resolved
in libc must somehow survive the link against the kernel code unresolved.
That is, references to things not in libc must be resolved from kernel code
and references to things in libc must be resolved from libc even if there is
a symbol with the same name in the kernel.  I don't see any way of doing this.

The only other solution I see is to rename the kernel sigprocmask.  Oleg Drokin
has done with this with a 
	-Dsigprocmask=__sigprocmask
on kernel code compiles, and I've done it at link time with objcopy.  This 
sucks, but it does have the great advantage that it actually works.

Anyway, if there's something better, I really want to know about it.

				Jeff

