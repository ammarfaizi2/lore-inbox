Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262679AbTJNT15 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 15:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbTJNT15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 15:27:57 -0400
Received: from chaos.analogic.com ([204.178.40.224]:39296 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262679AbTJNT1z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 15:27:55 -0400
Date: Tue, 14 Oct 2003 15:28:55 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Chris Lattner <sabre@nondot.org>
cc: Davide Libenzi <davidel@xmailserver.org>, linux-kernel@vger.kernel.org
Subject: Re: [x86] Access off the bottom of stack causes a segfault?
In-Reply-To: <Pine.LNX.4.44.0310141358420.4165-100000@nondot.org>
Message-ID: <Pine.LNX.4.53.0310141521130.2240@chaos>
References: <Pine.LNX.4.44.0310141358420.4165-100000@nondot.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Oct 2003, Chris Lattner wrote:

> > > Generated code:
> > >         .intel_syntax
> > > ...
> > > main:
> > >         mov DWORD PTR [%ESP - 16004], %EBP    # Save EBP to stack
> >                          ^^^^^^^^^^^^
> >
> > Yes, this is the problem (even Windows does that IIRC).
>
> Ok, I realize what's going on here.  The question is, why does the linux
> kernel consider this to be a bug?  Where (in the X86 specs) is it
> documented that it's illegal to access off the bottom of the stack?
>
> My compiler does a nice leaf function optimization where it does not even
> bother to adjust the stack for leaf functions, which eliminates the adds
> and subtracts entirely from these (common) functions.  This completely
> invalidates the optimization.
>
> Since I'm going to have to live with lots of preexisting kernels, it looks
> like I'm going to have to disable it entirely, which is disappointing.
> I'm still curious though why this is thought to be illegal.
>
> -Chris

Any interrupt causes the return address to be pushed onto the
stack. This will overwrite any data you've put there. In principle,
in user-mode, you can write below the stack-pointer because an
interrupt uses the kernel stack. However, your data will still
get corrupted by signal delivery, etc. So as to not corrupt your
user-mode stack, the kernel calls your signal code, just like
a nested call. This means the new return address will be below
the non-signal user-mode stack-pointer value. This will surely
corrupt anything you have written below the stack-pointer.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


