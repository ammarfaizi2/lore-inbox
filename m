Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261571AbUJ3BiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbUJ3BiM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 21:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263312AbUJ2Tgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 15:36:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:62393 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261159AbUJ2Smp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 14:42:45 -0400
Date: Fri, 29 Oct 2004 11:42:24 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: linux-os@analogic.com
cc: Richard Henderson <rth@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>,
       Jan Hubicka <jh@suse.cz>
Subject: Re: Semaphore assembly-code bug
In-Reply-To: <Pine.LNX.4.61.0410291416040.4844@chaos.analogic.com>
Message-ID: <Pine.LNX.4.58.0410291133220.28839@ppc970.osdl.org>
References: <417550FB.8020404@drdos.com> <1098218286.8675.82.camel@mentorng.gurulabs.com>
 <41757478.4090402@drdos.com> <20041020034524.GD10638@michonline.com>
 <1098245904.23628.84.camel@krustophenia.net> <1098247307.23628.91.camel@krustophenia.net>
 <Pine.LNX.4.61.0410200744310.10521@chaos.analogic.com>
 <Pine.LNX.4.61.0410290805570.11823@chaos.analogic.com>
 <Pine.LNX.4.58.0410290740120.28839@ppc970.osdl.org>
 <Pine.LNX.4.61.0410291316470.3945@chaos.analogic.com> <20041029175527.GB25764@redhat.com>
 <Pine.LNX.4.61.0410291416040.4844@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Oct 2004, linux-os wrote:

> On Fri, 29 Oct 2004, Richard Henderson wrote:
> >
> > Also not necessarily correct.  Intel cpus special-case pop
> > instructions; two pops can be dual issued, whereas a different
> > kind of stack pointer manipulation will not.
> >
> 
> Then I guess the Intel documentation is incorrect, too.

Where?

It definitely depends on the CPU. Some CPU's dual-issue pops, some don't.

I think the Pentium can dual-issue, while the PPro/P4 does not. And AMD
has some other rules, and I think older ones dual-issue stack accesses
only if esp doesn't change. Haven't looked at K8 rules.

And Pentium M is to some degree more interesting than P4 and Ppro, because
it's apparently the architecture Intel is going forward with for the
future of x86, and it is a "improved PPro" core that has a special stack
engine, iirc.

Anyway, it's quite likely that for several CPU's the fastest sequence ends 
up actually being 

	movl 4(%esp),%ecx
	movl 8(%esp),%edx
	movl 12(%esp),%eax
	addl $16,%esp

which is also one of the biggest alternatives.

Anyway, making "asmlinkage" imply "regparm(3)" would make the whole 
discussion moot, so I'm wondering if anybody has the patches to try it 
out? It requires pretty big changes to all the x86 asm code, but I do know 
that people _had_ patches like that at least long ago (from when people 
like Jan were playing with -mregaparm=3 originally). Maybe some of them 
still exist..

		Linus
