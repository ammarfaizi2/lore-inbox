Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbWGaG1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbWGaG1k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 02:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWGaG1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 02:27:40 -0400
Received: from liaag1ae.mx.compuserve.com ([149.174.40.31]:15835 "EHLO
	liaag1ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750816AbWGaG1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 02:27:39 -0400
Date: Mon, 31 Jul 2006 02:21:56 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: ptrace bugs and related problems
To: Albert Cahalan <acahalan@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andi Kleen <ak@suse.de>, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Roland Dreier <roland@redhat.com>
Message-ID: <200607310224_MC3-1-C689-D6DC@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <787b0d920607262355x3f669f0ap544e3166be2dca21@mail.gmail.com>

On Thu, 27 Jul 2006 02:55:17 -0400, Albert Cahalan wrote:

> Both i386 and x86-64 PTRACE_SINGLESTEP only check for popf, not iret.
> Yes, really, iret can be used by normal apps.

Well there's a FIXME in the x86_64 code for that, anyway. (lahf/sahf
can't cause problems, so iret is the only remaining problem.)

> There is also no check
> for failure, as when the popf or iret takes an alignment exception
> or hits an unmapped page.

Can that happen?  Singlestep traps happen after the instruction has
already executed.  Or are you talking about starting to singlestep
after hitting a code breakpoint fault?

> There is the pushf problem. Single-stepping this simple code
> does not work:   pushf ; popf

The debugger needs to mask TF in the pushed flags.  Read the comment
in is_at_popf().

> The is_at_popf function on x86-64 fails to account for instruction
> set differences. Many prefixes are only valid in 32-bit mode, and
> many others are only valid in 64-bit mode.

I only see one bug here: the REX prefixes are 'inc' instructions
in compatibility mode.  Otherwise, prefixes that are only valid in
32-bit mode are ignored in 64-bit mode.

> The debugger has no way to reliably stop a process without causing
> confusion. The SIGSTOP signal is not queued. The app under debug might
> use SIGSTOP and rely on SIGSTOP to work. The debugger can't steal this.

I sort of got this working some time ago but I forget what the
problems were.  The idea was to decide whether or not a SIGSTOP was
meant for the debugger or not, and forward the unwanted ones to the
app.  But yeah, the interface really sucks and that probably can't be
made to work.

What Linux needs is a fresh new design for a debugging interface to
sit on top if utrace, one that solves the current inherent problems.
Just making a list of these problems is probably the place to start.

-- 
Chuck

