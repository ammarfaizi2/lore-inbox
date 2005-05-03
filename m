Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261923AbVECXq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbVECXq1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 19:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbVECXq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 19:46:27 -0400
Received: from mailfe08.swip.net ([212.247.154.225]:747 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261923AbVECXqU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 19:46:20 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: 2.6.12-rc3 OOPS  in vanilla source (once more)
From: Alexander Nyberg <alexn@telia.com>
To: Stas Sergeev <stsp@aknet.ru>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       Mateusz Berezecki <mateuszb@gmail.com>, linux-kernel@vger.kernel.org,
       zwane@arm.linux.org.uk
In-Reply-To: <4277B2EC.70605@aknet.ru>
References: <42763388.1030008@gmail.com>
	 <20050502200545.266b4e55.akpm@osdl.org>
	 <1115120050.945.39.camel@localhost.localdomain>  <4277B2EC.70605@aknet.ru>
Content-Type: text/plain
Date: Wed, 04 May 2005 01:45:58 +0200
Message-Id: <1115163958.945.76.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > So, my solution is to instead of just adjusting esp0 that creates an
> > inconsitent state I adjust where the user-space registers are saved with
> > -8 bytes.
> When I did that offending patch,
> I was thinking the following way:
> - Do we need to adjust that initial
> copy of child regs by the 8 bytes too?
> - Well, we need that 8 bytes only
> when the "struct pt_regs" is incomplete.
> Here we copy the *complete* "struct pt_regs",
> so shifting that here makes no sense.
> 
> And so I adjusted only esp0 and
> nothing else. I think this may
> actually still be valid.

No I don't think it's valid. esp0 indicates the start of the stack and
right before it you copy the saved registers to a position that does not
correspond to this. And at this point, like you say we know the size of
what will be copied onto the stack so it makes even more sense to make
it correct from the beginning. Having inconsistent states is just asking
for more trouble.

> > This gives us the wanted extra bytes on the start of the stack
> > and esp0 is now correct.
> Yes, it is now correct by the mean
> that it points to the top of the
> "struct pt_regs" on the thread startup.
> However, it is not *always* points
> to the top of the "struct pt_regs".
> This -8 means exactly that esp0 can
> also point 8 bytes below the top of
> the "struct pt_regs" - that's what
> we've seen on a sysenter path, and
> that's what used crash either.
> So I think using esp0 to locate the
> top of the "struct pt_regs" is wrong.
> It doesn't always point to the top
> of that struct. Sometimes it does,
> but sometimes points 8 bytes lower.
> IMHO the ptrace.c have to be fixed
> instead so to not use this wrong
> assumption any more. What do you think?

>From my reading a task that is scheduled away cannot have a partial
saved pt_regs. If this is correct then ptrace won't suffer from this
problem as the traced child is scheduled away before the parent
investigates its status.

I need to look at the partial stack issue closer, don't think I fully
understand it yet.

