Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263626AbUGABsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263626AbUGABsc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 21:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263665AbUGABsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 21:48:32 -0400
Received: from mail.shareable.org ([81.29.64.88]:36781 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263626AbUGABsa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 21:48:30 -0400
Date: Thu, 1 Jul 2004 02:48:18 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: Do x86 NX and AMD prefetch check cause page fault infinite loop?
Message-ID: <20040701014818.GE32560@mail.shareable.org>
References: <20040630013824.GA24665@mail.shareable.org> <20040630055041.GA16320@elte.hu> <20040630143850.GF29285@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040630143850.GF29285@mail.shareable.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo, I think I now know what must be added to your 32-bit NX patch to
prevent the "infinite loop without a signal" problem.

It appears the correct way to prevent that one possibility I thought
of, with no side effects, is to add this test in
i386/mm/fault.c:is_prefetch():

        /* Catch an obscure case of prefetch inside an NX page. */
        if (error_code & 16)
                return 0;

That means that it doesn't count as a prefetch fault if it's an
_instruction_ fault.  I.e. an instruction fault will always raise a
signal.  Bit 4 of error_code was kindly added alongside the NX feature
by AMD.

(Tweak: Because early Intel 64-bit chips don't have NX, perhaps it
should say "if ((error_code & 16) && boot_cpu_has(X86_FEATURE_NX))"
instead -- if we find the bit isn't architecturally set to 0 for those
chips).

This test isn't needed in the plain, non-NX i386 kernel, because the
condition can never occur.  (Actually it can once, a really obscure
condition due to separate ITLB and DTLB loading and page table races
with other CPUs, but it's transient so won't loop infinitely).

Enjoy,
-- Jamie
