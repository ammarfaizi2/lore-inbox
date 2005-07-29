Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261948AbVG2KF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261948AbVG2KF6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 06:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262557AbVG2KFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 06:05:45 -0400
Received: from baythorne.infradead.org ([81.187.226.107]:26819 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S262555AbVG2KDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 06:03:21 -0400
Subject: Re: [PATCH] speed up on find_first_bit for i386 (let compiler do
	the work)
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
       "Maciej W. Rozycki" <macro@linux-mips.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Daniel Walker <dwalker@mvista.com>
In-Reply-To: <Pine.LNX.4.58.0507281018170.3227@g5.osdl.org>
References: <1122473595.29823.60.camel@localhost.localdomain>
	 <1122512420.5014.6.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <1122513928.29823.150.camel@localhost.localdomain>
	 <1122519999.29823.165.camel@localhost.localdomain>
	 <1122521538.29823.177.camel@localhost.localdomain>
	 <1122522328.29823.186.camel@localhost.localdomain>
	 <42E8564B.9070407@yahoo.com.au>
	 <1122551014.29823.205.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0507280823210.3227@g5.osdl.org>
	 <1122565640.29823.242.camel@localhost.localdomain>
	 <Pine.LNX.4.61L.0507281725010.31805@blysk.ds.pg.gda.pl>
	 <1122569848.29823.248.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0507281018170.3227@g5.osdl.org>
Content-Type: text/plain
Date: Fri, 29 Jul 2005 11:03:05 +0100
Message-Id: <1122631385.8317.26.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-28 at 10:25 -0700, Linus Torvalds wrote:
> Basic rule: inline assembly is _better_ than random compiler extensions. 
> It's better to have _one_ well-documented extension that is very generic 
> than it is to have a thousand specialized extensions.

Counterexample: FR-V and its __builtin_read8() et al. For FR-V you have
to issue a memory barrier before or after certain I/O instructions, but
in some circumstances you can omit them. The compiler knows this and can
omit the membar instructions as appropriate -- but doing the same
optimisations in inline assembly would be fairly much impossible.

Builtins can also allow the compiler more visibility into what's going
on and more opportunity to optimise. They can also set condition
registers, which you can't do from inline assembly -- if you want to
perform a test in inline asm, you have to put the result in a register
and then test the contents of that register. (You can't just branch from
the inline asm either, although we used to try).

Builtins are more portable and their implementation will improve to
match developments in the target CPU. Inline assembly, as we have seen,
remains the same for years while the technology moves on.

Although it's often the case that inline assembly _is_ better,
especially in code which is arch-specific in the first place, I wouldn't
necessarily assume that it's always the case.

-- 
dwmw2


