Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbVAHFQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbVAHFQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 00:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbVAHFQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 00:16:56 -0500
Received: from smtp100.rog.mail.re2.yahoo.com ([206.190.36.78]:55382 "HELO
	smtp100.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261631AbVAHFQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:16:53 -0500
Subject: Re: minor nit with decoding popf instruction - was Re: ptrace
	single-stepping change breaks Wine
From: John Kacur <jkacur@rogers.com>
Reply-To: jkacur@rogers.com
To: Linus Torvalds <torvalds@osdl.org>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Jesse Allen <the3dfxdude@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0501062238050.2272@ppc970.osdl.org>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com>
	 <1104401393.5128.24.camel@gamecube.scs.ch>
	 <1104411980.3073.6.camel@littlegreen> <200412311413.16313.sailer@scs.ch>
	 <1104499860.3594.5.camel@littlegreen>
	 <53046857041231074248b111d5@mail.gmail.com>
	 <Pine.LNX.4.58.0412310753400.10974@bigblue.dev.mdolabs.com>
	 <Pine.LNX.4.58.0412311359460.2280@ppc970.osdl.org>
	 <1105073464.8135.17.camel@linux.site>
	 <Pine.LNX.4.58.0501062238050.2272@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1105160748.5935.32.camel@linux.site>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 08 Jan 2005 00:05:48 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-07 at 01:48, Linus Torvalds wrote:
> On Thu, 6 Jan 2005, John Kacur wrote:
> > 
> > In order to avoid false positives, I think you should remove the line
> > case 0xf0: case 0xf2: case 0xf3:
> 
> False positives are ok with instructions that trap - if it traps, we won't 
> much care, since the debugger will get notified about that separately (and 
> unambiguously).
> 
True, I never thought of that, however, you still can drop the test,
there's no point continuing if you detected a lock prefix.

> Also:
> 
> > 0xf0 corresponds to the lock prefix which would trigger an invalid
> > opcode exception with a popf instruction.
> > 
> > 0xf2 and 0xf3 correspond to the repeat prefixes and are also not valid
> > with popf
> 
> I don't think either of those are necessarily true on older x86 chips. 
> Nonsensical prefixes used to be silently ignored. Only in later chips has 
> Intel been more strict about them, and given them meanings.
> 
> In fact, I'm pretty sure it's only "lock" that Intel got a lot more
> careful about.  Try it. I'm pretty sure a "rep" prefix is still accepted
> in front of pretty much all instructions. It just doesn't do anything.
> 
> Is it used? Probably not. But people have done some strange things to 
> "mark" instructions (ie for things like run-time exception handling you 
> can "mark" an instruction by prefixing it with a nonsensical "rep" prefix: 
> the CPU won't care, and you can check at trap time whether it was one of 
> your magic instructions.
> 
> Of course, I'd never admit to doing anything that obscure. Never.
> 
> 		Linus

You're right, in practice I've never seen a processor trigger an
exception when it encounters a nonsensical rep prefix, so dropping the
tests for 0xf2 and 0xf3 could potentially miss cases in the unlikely
event that a compiler generated them. Not relevant here, but that
strange technique to mark the instructions would backfire on 128-bit and
64-bit media instructions that use 0xf2 and 0xf3 in the encoding.

John

