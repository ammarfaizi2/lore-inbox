Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262296AbSLQC11>; Mon, 16 Dec 2002 21:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262838AbSLQC10>; Mon, 16 Dec 2002 21:27:26 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:39684 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262296AbSLQC10>; Mon, 16 Dec 2002 21:27:26 -0500
Date: Mon, 16 Dec 2002 18:36:20 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dave Jones <davej@codemonkey.org.uk>
cc: Ingo Molnar <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <20021217010321.GD31294@suse.de>
Message-ID: <Pine.LNX.4.44.0212161832420.12062-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Dec 2002, Dave Jones wrote:
>
> I'm sure I recall seeing errata on at least 1 CPU re sysenter.
> If we do decide to go this route, we'll need to blacklist ones
> with any really icky problems.

The errata is something like "all P6's report SEP, but it doesn't
actually _work_ on anything before the third stepping".

However, that should _not_ be handled by magic sysenter-specific code.
That's what the per-vendor cpu feature fixups are there for, so that these
kinds of bugs get fixed in _one_ place (initialization) and not in all the
users of the feature flags.

In fact, we already have that code in the proper place, namely
arch/i386/kernel/cpu/intel.c:

        /* SEP CPUID bug: Pentium Pro reports SEP but doesn't have it */
        if ( c->x86 == 6 && c->x86_model < 3 && c->x86_mask < 3 )
                clear_bit(X86_FEATURE_SEP, c->x86_capability);

so the stuff I sent out should work on everything.

(Modulo the missing syscall page I already mentioned and potential bugs
in the code itself, of course ;)

		Linus

