Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263204AbUEaE2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263204AbUEaE2P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 00:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264412AbUEaE2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 00:28:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:23708 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263204AbUEaE2N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 00:28:13 -0400
Date: Sun, 30 May 2004 21:28:09 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: How to use floating point in a module?
In-Reply-To: <yw1xbrk5baq3.fsf@kth.se>
Message-ID: <Pine.LNX.4.58.0405302121440.1730@ppc970.osdl.org>
References: <200405310152.i4V1qNk03732@mailout.despammed.com> <yw1xbrk5baq3.fsf@kth.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 31 May 2004, Måns Rullgård wrote:
> 
> Floating point is forbidden in kernel code since the floating point
> registers (and other floating point context) is not saved/restored
> during system calls, for efficiency.  I'm speculating here, but it
> might be possible to manually save the floating point context while
> doing some floating point operations.  The problem arises if this code
> is interrupted midway.  Using a preemptive 2.6 kernel would easily
> break here.

You can do it "safely" on x86 using

	kernel_fpu_begin();
	...
	kernel_fpu_end();

and make sure that _all_ the FP stuff is in between those two things, and 
that you don't do _anything_ that might fault or sleep.

The kernel_fpu_xxx() macros make sure that preemption is turned off etc, 
so the above should always be safe.

Even then, of course, using FP in the kernel assumes that you actually
_have_ an FPU, of course. The in-kernel FP emulation package is _not_
supposed to work with kernel FP instructions.

Oh, and since the kernel doesn't link with libc, you can't use anything 
even remotely fancy. It all has to be stuff that gcc can do in-line, 
without any function calls.

In other words: the rule is that you really shouldn't use FP in the 
kernel. There are ways to do it, but they tend to be for some _real_ 
special cases, notably for doing MMX/XMM work. Ie the only "proper" FPU 
user is actually the RAID checksumming MMX stuff.

		Linus
