Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267132AbSLREk3>; Tue, 17 Dec 2002 23:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267134AbSLREk3>; Tue, 17 Dec 2002 23:40:29 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:44304 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267132AbSLREk2>; Tue, 17 Dec 2002 23:40:28 -0500
Date: Tue, 17 Dec 2002 20:49:17 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: Ulrich Drepper <drepper@redhat.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <3DFFFBF1.7000507@transmeta.com>
Message-ID: <Pine.LNX.4.44.0212172043540.1749-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Dec 2002, H. Peter Anvin wrote:
>
> This confuses me -- there seems to be no reason this shouldn't work as
> long as %esp == %ebp on sysexit.  The SYSEXIT-trashed GPRs seem like a
> bigger problem.

The thing is, the argument save area == the kernel stack frame. This is
part of the reason why Linux has very fast system calls - there is
absolutely _zero_ extraneous setup. No argument fetching and marshalling,
it's all part of just setting up the regular kernel stack.

So to get the right argument in arg6, the argument _needs_ to be saved in
the %ebp entry on the kernel stack. Which means that on return from the
system call (which may not actually be through a "sysenter" at all, if
signals happen it will go through the generic paths), %ebp will have been
updated as part of the kernel stack unwinding.

Which is ok for a regular fast system call (ebp will get restored
immediately), but it is NOT ok for the system call restart case, since in
that case we want %ebp to contain the old stack pointer, not the sixth
argument.

If we just save the stack pointer value (== the initial %ebx value), the
right thing will get restored, but then system calls will see the stack
pointer value as arg6 - because of the 1:1 relationship between arguments
and stack save.

		Linus

