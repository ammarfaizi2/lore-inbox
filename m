Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265250AbTB0PeP>; Thu, 27 Feb 2003 10:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265270AbTB0PeO>; Thu, 27 Feb 2003 10:34:14 -0500
Received: from chaos.analogic.com ([204.178.40.224]:5762 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265250AbTB0PeN>; Thu, 27 Feb 2003 10:34:13 -0500
Date: Thu, 27 Feb 2003 10:46:36 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Steve Kenton <skenton@ou.edu>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: pointer to .subsection and .previous usage in kernel?
In-Reply-To: <3E5E27A1.70BE4B30@ou.edu>
Message-ID: <Pine.LNX.3.95.1030227102855.8623A-100000@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Feb 2003, Steve Kenton wrote:

> Anyone have a pointer to what we are really trying to accomplish
> with .subsection and .previous in the in-line and asm stuff?
> 
> Like maybe a readme or coding style doc for in-line and asm code?
> 
> That was the main thing I tripped over while trying to build
> a 2.5 kernel using the cygwin toolchain with an eye towards
> uml under windows.  I found very little documentation about
> the directives themselves even in the gnu info stuff and nada,
> except one thread about abstracting them in spinlocks,
> bout how/why they are used in the kernel.  They appear to be
> elf specific which is why the i386pe stuff puked on them.  I
> assume that most of this is to maximize cache hits, but that's
> just a guess.  There are a largish handful of them scattered
> around the kernel outside of locks. Any pointers would be appreciated.
> 
> Steve
> -

The data storage exists in ".sections". The common ones are:

.text		Where the code is
.bss		Data initialized upon startup to zeros.
.data		Where non-local data are kept.
.rodata		Where non-writable strings are put.
.othernames	Defined by the implementor so that it can
		remain isolated.

The "othernames" are things like __ex_table and _text_lock.
A subsection is a finer-granularity section. They can't be
named, only numbered. Since each of the ".sections" are
separate, one can set up a specific trap on a section. For
instance, one can grab an out-of-bounds access in a ".section"
without seg-faulting the whole kernel. This helps provide
for a recovery mechanism should the kernel try to write to
an invalid user-provided buffer.

The keyword ".previous" is shorthand for just that. It tells
the assembler to emit data and/or code according to the previous
section.

If you are writing code under cygwin, you should not be encountering
spin-locks and kernel-specific things. Perhaps you are including
the wrong header files? You should never do:

	#include <linux/xxx.h>
	#include <asm/xxx.h>

... unless you are writing modules. And you don't do that in cygwin.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


