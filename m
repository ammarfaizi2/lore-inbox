Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264278AbUGAIJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264278AbUGAIJa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 04:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264286AbUGAIJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 04:09:30 -0400
Received: from mail4.speakeasy.net ([216.254.0.204]:10676 "EHLO
	mail4.speakeasy.net") by vger.kernel.org with ESMTP id S264278AbUGAIJ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 04:09:27 -0400
Date: Thu, 1 Jul 2004 01:09:24 -0700
Message-Id: <200407010809.i6189O6O019944@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Andrew Cagney <cagney@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86 single-step (TF) vs system calls & traps
In-Reply-To: Linus Torvalds's message of  Monday, 28 June 2004 22:15:51 -0700 <Pine.LNX.4.58.0406282209070.28764@ppc970.osdl.org>
X-Fcc: ~/Mail/linus
X-Shopping-List: (1) Incredulous squeeze detention
   (2) Conspicuous suction bogs
   (3) Flippant incongruous auditions
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> They are "user-mode" only in theory.

And in every practical sense that userland ever contemplates code, except
its supplier.  When you take an asynchronous signal, your PC value might be
anywhere in the middle of the code; even when you take a synchronous signal
produced inside the system call, your PC value will be somewhere in the
middle of the code.  Hence the need for the vsyscall DSO with unwind
information.  The code does memory accesses via your stack pointer to your
normal memory, and these can fault or overflow in all the normal ways.  I
just can't see the basis for an argument that it "makes more sense" for
single-stepping these instructions to work differently than others.

Now, if single-stepping the call to the vsyscall entry point treated the
whole thing as an atomic unit and came immediately out the other side to
the return-address of that call, then we would be on the same page.  That's
actually pretty damn easy to implement with a special case for the vsyscall
PC address in do_debug.  But it would be inconsistent with the fact that
signals don't also automagically roll your PC back or forward out of the
vsyscall code section.  If we made the vsyscall entry point code truly
"virtually atomic", then I would be 100% with you on calling it "kernel code".
I somehow doubt that is what you want to do.  

That said, I don't really know why you would object to the change I've
suggested to do_debug.  It only adds code when the case of single-stepping
into sysenter actually happens.


Thanks,
Roland

