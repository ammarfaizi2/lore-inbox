Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287918AbSAPVfD>; Wed, 16 Jan 2002 16:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287932AbSAPVet>; Wed, 16 Jan 2002 16:34:49 -0500
Received: from mx2.elte.hu ([157.181.151.9]:43974 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S287939AbSAPVeg>;
	Wed, 16 Jan 2002 16:34:36 -0500
Date: Thu, 17 Jan 2002 00:31:56 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Robert Love <rml@tech9.net>
Cc: Justin Carlson <justincarlson@cmu.edu>,
        Rusty Russell <rusty@rustcorp.com.au>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] I3 sched tweaks...
In-Reply-To: <1011216429.1083.95.camel@phantasy>
Message-ID: <Pine.LNX.4.33.0201170021550.21473-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 16 Jan 2002, Robert Love wrote:

> current is stored in a register (esp) in x86, too. [...]

it's stored in a register, but then it also needs to do some more work to
get at the true pointer. The typical way to load 'current' on x86 into
%eax:

        b8 00 e0 ff ff          mov    $0xffffe000,%eax
        21 e0                   and    %esp,%eax

7 bytes icache footprint.

while the cost of moving an already calculated 'current' pointer to the
stack is:

        50                      push   %eax

1 byte instruction.

and in addition, consider that for larger functions, the 'current' value
will be moved to a gcc spill register anyway, it will end up looking like
this:

        b8 00 e0 ff ff          mov    $0xffffe000,%edi
        21 e0                   and    %esp,%edi
        89 7c 24 14             mov    %edi,0x14(%esp,1)

while in the function-call variant the pointer is on the stack already, so
accessing it is easy:

        89 7c 24 14             mov    0x10(%esp,1), %eax

so on x86, considering the sched_tick() case, it's slightly faster to pass
the argument. But there isnt any big difference.

but add an instruction or two to the 'current' calculation method, and the
icache footprint and actual overhead will be more clearly in favor of
function calls.

i agree that on architectures where 'current' is stored in a register it's
better to use 'current' explicitly.

	Ingo

