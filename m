Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265287AbUIDSVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265287AbUIDSVs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 14:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265331AbUIDSVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 14:21:47 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:37111 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S265287AbUIDSVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 14:21:45 -0400
Date: Sat, 4 Sep 2004 14:26:12 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Andi Kleen <ak@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Matt Mackall <mpm@selenic.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH][8/8] Arch agnostic completely out of line locks / x86_64
In-Reply-To: <20040904111605.GA12165@wotan.suse.de>
Message-ID: <Pine.LNX.4.58.0409041420590.11262@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0409021241291.4481@montezuma.fsmlabs.com>
 <20040904111605.GA12165@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Sep 2004, Andi Kleen wrote:

> On Thu, Sep 02, 2004 at 08:03:02PM -0400, Zwane Mwaikambo wrote:
> >  arch/x86_64/kernel/time.c        |   13 +++++++++++++
> >  arch/x86_64/kernel/vmlinux.lds.S |    1 +
> >  include/asm-x86_64/ptrace.h      |    4 ++++
> >  3 files changed, 18 insertions(+)
> >
> > Andi, i'm not so sure about that return address in profile_pc, i think i
> > need to read a bit more.
>
> When frame pointers are enabled the code is correct. But you don't
> even need frame pointers, because the spinlock code should not
> spill any registers and in such a function the return address
> is always *rsp. Same is true on i386 too.

How about the following?

000001f0 <_spin_lock_irqsave>:
 1f0:   55                      push   %ebp
 1f1:   89 e5                   mov    %esp,%ebp
 1f3:   56                      push   %esi
 1f4:   89 c6                   mov    %eax,%esi
 1f6:   53                      push   %ebx
 1f7:   51                      push   %ecx
 1f8:   51                      push   %ecx
 1f9:   9c                      pushf
 1fa:   5b                      pop    %ebx
 1fb:   fa                      cli
 1fc:   b8 00 e0 ff ff          mov    $0xffffe000,%eax
 201:   21 e0                   and    %esp,%eax
 203:   8b 50 14                mov    0x14(%eax),%edx
 206:   42                      inc    %edx

It was a lot easier with the spin stub only out of line (the first round
of patches for i386, x86_64) so there i used esp and didn't depend on
frame pointers.

Thanks,
	Zwane

