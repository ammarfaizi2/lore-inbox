Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266186AbUF3Bil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266186AbUF3Bil (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 21:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266187AbUF3Bil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 21:38:41 -0400
Received: from mail.shareable.org ([81.29.64.88]:58284 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S266186AbUF3Bii
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 21:38:38 -0400
Date: Wed, 30 Jun 2004 02:38:24 +0100
From: Jamie Lokier <jamie@shareable.org>
To: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       Ingo Molnar <mingo@elte.hu>
Subject: Do x86 NX and AMD prefetch check cause page fault infinite loop?
Message-ID: <20040630013824.GA24665@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was looking at the code which checks for prefetch instructions in
the page fault path on x86 and x86-64, due to the AMD bug where
prefetch sometimes causes unwanted faults.

I wondered if simply returning when *EIP points to a prefetch
instruction could cause an infinite loop of page faults, instead of
the wanted SIGSEGV or SIGBUS.  I know we went over it before, but I
had another look.

AMD already confirmed that the erroneous fault won't reoccur when a
prefetch instruction is returned to from the fault handler.  So a loop
can only occur if it's _not_ an erroneous fault, but instead the
__is_prefetch() code is preventing a normal signal from being ever
raised.

Can this happen?  For it to happen, returning must immediately raise
another fault, and that only happens if the page permission of *EIP
doesn't permit execution.

That can happen if another thread's changing permissions, but it's
only transient -- it's not a loop.  Can it happen otherwise?

For __is_prefetch() to say it's a prefetch instruction, it must
successfully read and decode the instruction.

That can only happen if the page containing the instruction is mapped
readable (i.e. on x86 that means anything other than PROT_NONE), and
the code segment limit is ok.

That means the answer to "can it get stuck in a loop" is _no_ on a
plain 32-bit x86.  That's because all such pages are executable and
within the bounds of the code segment, even if it's a user-setup code
segment.

But... what if the page is not executable?  When NX is enabled on
32-bit x86, and all x86-64 kernels, or even the exec-shield patch's
changes to the USER_CS limit (that limit isn't checked in
__is_prefetch) - those conditions all allow __is_prefetch() to read a
prefetch instruction, cause the fault handler to return, and repeat.

This can only happen when something branches to a page with PROT_EXEC
_not_ set, on a kernel which honours that, and the target address is a
prefetch instruction.

That can happen due to malicious code, a programming error, or
corruption.

The behaviour in such cases _should_ be SIGSEGV due to lack of execute
permission.  However, I think the behaviour will be an infinite loop.

I haven't tested this as I don't have the hardware for NX, and don't
want to apply the non-NX exec-shield or PaX patches on a working Athlon box.

Can anyone confirm this is a real bug, or that it isn't and I missed
the reason why not?

Thanks,
-- Jamie
