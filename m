Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbTFORGc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 13:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbTFORES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 13:04:18 -0400
Received: from zero.aec.at ([193.170.194.10]:61457 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262423AbTFORDz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 13:03:55 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix undefined/miscompiled construct in kernel
 parameters
From: Andi Kleen <ak@muc.de>
Date: Sun, 15 Jun 2003 19:17:40 +0200
In-Reply-To: <20030615170013$4ebc@gated-at.bofh.it> (Linus Torvalds's
 message of "Sun, 15 Jun 2003 19:00:13 +0200")
Message-ID: <m3of0zdzuz.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <20030615131004$6a85@gated-at.bofh.it>
	<20030615170013$4ebc@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On Sun, 15 Jun 2003, Andi Kleen wrote:
>> 
>> The parse_args call in init/main.c does pointer arithmetic between two 
>> different external symbols. This is undefined in C (only pointer arthmetic
>> in the same symbol is defined) and gets miscompiled on AMD64 with gcc 3.2,
>
> That's silly. You're making the code less readable, with some silly 
> parameters. Why does it get miscompiled on amd64, and let's just fix that 
> one.

Because &arbitary_symbol_a - &arbitary_symbol_b is undefined in C and
the amd64 gcc 3.2 choses to miscompile it (it results in a very big  
number because it converts the 56/40 division to an inversed multiplication
in a wrong way). I actually wrote a compiler bug report first, but the 
compiler developers rightly pointed out that it is undefined.

Note this is not the first time we had such problems, it happened
with __pa(&symbol) too (amd64 has a special macro to work around that).
I don't know why it happens more often on amd64 than on i386, perhaps
it has something to do with the RIP relative addressing or the
negative kernel code model. ppc seems to have similar problems.

Passing an end pointer is not too different from passing an 
max index in my opinion.

Another way would be to use the anonymous asm trick proposed by rth
some time ago for a similar problem (asm("" : "=g" (output) : "0" (input))
to hide the symbols from the compiler), but I didn't do that because
it looked more ugly to me.

If you prefer to do it with the anonymous asm I can do it, but I don't
see a big problem with passing an end pointer.

-Andi
