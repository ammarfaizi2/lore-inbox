Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264542AbTGBCK3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 22:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264543AbTGBCK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 22:10:28 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:55487 "HELO
	develer.com") by vger.kernel.org with SMTP id S264542AbTGBCK1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 22:10:27 -0400
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer
To: Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] Kill div64.h dupes, parenthesize do_div() macro params
Date: Wed, 2 Jul 2003 04:24:47 +0200
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
References: <200307020232.20726.bernie@develer.com> <20030701173612.280d1296.akpm@digeo.com>
In-Reply-To: <20030701173612.280d1296.akpm@digeo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307020424.47629.bernie@develer.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 July 2003 02:36, Andrew Morton wrote:

 > > sorry for coming up with this patch in a short time frame, but
 > > it needs to be applied in order to fix real do_div() brokenness
 > > on many architectures.
 >
 > I included this in 2.5.73-mm2.  It will percolate through after I've
 > eyeballed it more thoroughly and run it past the arch maintainers.

 Thank you very much Andrew! I was already thinking of contacting either
you or davem to pick that one up from me.

 By the way, what do you think about getting rid of the do_div() macro
altogether? I've noticed that gcc 3.3 is quite capable of guessing the
optimal instruction pattern to use even for the generic do_div()
written in C:

    rem = (unsigned long)div % (unsigned)base;
    div = (unsigned long)div / (unsigned)base;

This code makes gcc select the "udivmodsi4" pattern on the m68k
backend, which computes both the quotient and remainder with a
single instruction on some architectures. The compiler is even
smart enough to optimize the case where the remainder isn't used:

  if (find_reg_note (insn, REG_UNUSED, operands[3]))
    return \"divu%.l %2,%0\";
  else
    return \"divul%.l %2,%3:%0\";

So I don't see a performance issue here. There are even places
in the kernel where do_div() is used even when the remainder
isn't used, so it's a potential performance hit (but GCC is
again smart enough to detect that dead code and discards it ;-).

If there are architectures where gcc doesn't implement divisions
correctly, this issue should be solved in gcc, not by adding a
silly macro to the kernel.

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

Please don't send Word attachments - http://www.gnu.org/philosophy/no-word-attachments.html


