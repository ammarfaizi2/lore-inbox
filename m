Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265663AbSJXUlZ>; Thu, 24 Oct 2002 16:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265664AbSJXUlZ>; Thu, 24 Oct 2002 16:41:25 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:16780 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265663AbSJXUlX>;
	Thu, 24 Oct 2002 16:41:23 -0400
Date: Thu, 24 Oct 2002 21:49:06 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: [CFT] faster athlon/duron memory copy implementation
Message-ID: <20021024204906.GC14351@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Ed Sweetman <ed.sweetman@wmich.edu>, Robert Love <rml@tech9.net>,
	linux-kernel@vger.kernel.org
References: <3DB82ABF.8030706@colorfullife.com> <200210242048.36859.earny@net4u.de> <3DB85385.6030302@wmich.edu> <1035490431.1501.101.camel@phantasy> <3DB858A3.10104@wmich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DB858A3.10104@wmich.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2002 at 04:31:31PM -0400, Ed Sweetman wrote:
 > which is almost a 30MB/s difference or 6% simply from compiler options 
 > of the same compiler.  It may not mean much in 1 second. But few things 
 > where we care about performance are only run for one second.

Looking at the assembly output of both optimised and unoptimised, we
see quite startling differences in the way the loops are done..
The unoptimised case..

    movl    $0, -12(%ebp)
.L75:
    cmpl    $63, -12(%ebp)
    jle .L78
    jmp .L76

	...
	movntq/movq inline asm bits
	...
    leal    12(%ebp), %eax
    addl    $64, (%eax)
    addl    $64, 8(%ebp)
    leal    -12(%ebp), %eax
    incl    (%eax)
    jmp .L75

Note it uses -12(%ebp) to keep track of how much its copied.
The optimised version is much more sensible..

    movl    $63, %ebx
    .p2align 2
.L98:
	...
    movntq/movq inline asm bits
    ...
    addl    $64, %ecx
    addl    $64, %edx
    decl    %ebx
    jns .L98

Keeping track of the count in an register, no indirect memory references,
leaving the only memory references to be the actual memory copies, which
let it achieve the full bandwidth of the memory bus.

Quite surprising. I doubt going over the top with CFLAGS buys you much.
The above optimisation comes in with just -O2.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
