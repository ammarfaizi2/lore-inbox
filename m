Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270359AbTHGPwk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 11:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270375AbTHGPwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 11:52:31 -0400
Received: from chaos.analogic.com ([204.178.40.224]:60288 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S270359AbTHGPvf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 11:51:35 -0400
Date: Thu, 7 Aug 2003 11:55:43 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
cc: Pavel Machek <pavel@suse.cz>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [BROKEN PATCH] syscalls leak data via registers?
In-Reply-To: <1060269116.20515.14.camel@ixodes.goop.org>
Message-ID: <Pine.LNX.4.53.0308071134180.5319@chaos>
References: <1059815183.18860.55.camel@ixodes.goop.org>  <20030807103043.GB211@elf.ucw.cz>
 <1060269116.20515.14.camel@ixodes.goop.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Aug 2003, Jeremy Fitzhardinge wrote:

> On Thu, 2003-08-07 at 03:30, Pavel Machek wrote:
> > I believe userspace depends on registers to be preserved over system
> > call, except for eax.
>
> That's what I was wondering.  Does it?  Is that a documented part of the
> syscall interface?
>
> >  So what you found is not only security problem,
> > but also crasher bug.
>
> In these sense that it crashes userspace?
>
> 	J
>

The kernel interface preserves the registers that GCC needs
preserved, i.e., index registers such as EBX, ESI, and EDI.
It may not preserve registers that convey information for
the call unless they are index registers. For instance,
a system call that takes two parameters has those parameters
put into EBX and ECX. Register EAX always contains the
function number. In the case described, only EBX is
guaranteed to be preserved, this because it's an index
register.

Typically parameters are passed as:

	No parameters		EAX
	1 parameter		EAX EBX
	2 parameters		EAX EBX ECX
	3 parameters		EAX EBX ECX EDX
	4 parameters		EAX EBX ECX EDX ESI
	5 parameters		EAX EBX ECX EDX ESI EDI
	6 parameters		EAX EBX ECX EDX ESI EDI EBP

Upon return only the index registers plus segments and stack
will be preserved. The other registers can contain anything.
However, this is hardly an 'information' leak. Even if the
address of something in the kernel was returned, it can't
be accessed, and the 'information' is all about the methods
used to perform a function upon behalf of the caller, not
some other task. In other words, if you are reading from
a file, and some register contains 42, you only know that
that value was used somewhere while helping you get the
file data. It is never some data from somebody else's file.
To get to somebody else's data requires a context switch and
all registers and restored are saved across a context switch.
In Unix, the kernel performs functions on behalf of the caller,
within the context of the caller, so register information
is not an information leak.

But, there is the possibility of having data left in memory
by another task, accessed by the current task. These possibilities
are constantly reviewed and fixed when found.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.

