Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261473AbVC0IqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbVC0IqP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 03:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbVC0IqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 03:46:15 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:57545 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261473AbVC0Iph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 03:45:37 -0500
Subject: Re: [PATCH] no need to check for NULL before calling kfree()
	-fs/ext2/
From: Arjan van de Ven <arjan@infradead.org>
To: linux-os@analogic.com
Cc: Jesper Juhl <juhl-lkml@dif.dk>, ext2-devel@lists.sourceforge.net,
       Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0503261811001.9945@chaos.analogic.com>
References: <Pine.LNX.4.62.0503252307010.2498@dragon.hyggekrogen.localhost>
	 <Pine.LNX.4.61.0503251726010.6354@chaos.analogic.com>
	 <1111825958.6293.28.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.61.0503261811001.9945@chaos.analogic.com>
Content-Type: text/plain
Date: Sun, 27 Mar 2005 10:45:30 +0200
Message-Id: <1111913130.6297.24.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-03-26 at 18:21 -0500, linux-os wrote:
> On Sat, 26 Mar 2005, Arjan van de Ven wrote:
> 
> > On Fri, 2005-03-25 at 17:29 -0500, linux-os wrote:
> >> Isn't it expensive of CPU time to call kfree() even though the
> >> pointer may have already been freed?
> >
> > nope
> >
> > a call instruction is effectively half a cycle or less, the branch
> 
> Wrong!

oh? a call is "push eip + a new eip" effectively. the new eip is
entirely free, the push eip takes half a cycle (or 1 full cycle but only
one of the two/three pipelines).

> 
> > predictor of the cpu can predict perfectly where the next instruction is
> > from. The extra if() you do in front is a different matter, that can
> > easily cost 100 cycles+. (And those are redundant cycles because kfree
> > will do the if again anyway). So what you propose is to spend 100+
> > cycles to save half a cycle. Not a good tradeoff ;)
> >
> 
> Wrong!

Is it wrong that the cpu can predict the target perfectly? No. Unless
you use function pointers (then it's a  whole different ballgame).

> 
> Pure unmitigated bull-shit. I measure (with hardware devices)
> the execution time of real code in modern CPUs. I do this for
> a living so you don't have to stand in line for a couple of
> hours to have your baggage scanned at the airport.

Ok I used to do this kind of performance work for a living too and
measuring it to death as well.

> Always, always, a call will be more expensive than a branch
> on condition. 

It is not on modern Out of order cpus. 

> It's impossible to be otherwise. A call requires
> that the return address be written to memory (the stack),
> using register indirection (the stack-pointer).

and it's a so common pattern that it's optimized to death. Internally a
call gets transformed to 2 uops or so, one is push eip, the other is the
jmp (which gets then just absorbed by the "what is the next eip" logic,
just as a "jmp"s are 0 cycles)

> If somebody said; "I think that the code will look better
> and the few cycles lost will not be a consequence with modern
> CPUs...", then there is a point. But coming up with this
> disingenuous bullshit is something else.

I don't have to take this from you and I don't. You're calling me a liar
with zero evidence. Lets get some facts straight
1) On a modern cpu, a miss of the branch predictor is quite expensive.
   The entire pipeline needs flushing if this happens, and on a p4 this
   will be in the order of 50 to 100 cycles at minimum.
2) absolute "jmp" is free on modern OOO cpus. Instead of taking an
   actual execution slot, all that happens is that the "what is the next
   EIP" logic gets a different value. (you can argue what happens if you
   have a sequence of jmps and that it's not free then, and I'll grant
   you that, but that corner case is not relevant here)
3) a "call" instruction gets translated into what basically is 
   "push EIP" and "jmp" uops.
4) modern processors have special logic to optimize push/pop
   instructions; for example a "push eax ; push ebx" sequence will
   execute in parallel in the same cycle even though there is a data
   dependency on esp, the cpu can perfectly predict the esp effect and
   will do so.
5) modern processors have a call/ret fifo cache they use to do branch
   prediction for the target of "ret" instructions. Unless you do
   misbalanced call/ret pairs the prediction will be perfect.

Based on this the conclusion "a function call is really cheap versus a
conditional branch" is justified imo. Now you better come with proof
about which of the 5 things above I'm totally lying to you or you better
come with an apology.


 

