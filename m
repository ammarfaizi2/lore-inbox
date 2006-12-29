Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1755073AbWL2WYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755073AbWL2WYH (ORCPT <rfc822;akpm@zip.com.au>);
	Fri, 29 Dec 2006 17:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755070AbWL2WYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 17:24:07 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:38293 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755067AbWL2WYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 17:24:05 -0500
Date: Fri, 29 Dec 2006 23:20:31 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Ollie Wild <aaw@google.com>,
        linux-kernel@vger.kernel.org, parisc-linux@lists.parisc-linux.org,
        Arjan van de Ven <arjan@infradead.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
        linux-arch@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ulrich Drepper <drepper@redhat.com>
Subject: Re: [patch] remove MAX_ARG_PAGES
Message-ID: <20061229222031.GA23724@elte.hu>
References: <65dd6fd50610101705t3db93a72sc0847cd120aa05d3@mail.gmail.com> <1160572460.2006.79.camel@taijtu> <65dd6fd50610111448q7ff210e1nb5f14917c311c8d4@mail.gmail.com> <65dd6fd50610241048h24af39d9ob49c3816dfe1ca64@mail.gmail.com> <20061229200357.GA5940@elte.hu> <20061229204904.GI20596@flint.arm.linux.org.uk> <Pine.LNX.4.64.0612291322150.4473@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612291322150.4473@woody.osdl.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Cc:-ed Ulrich too]

* Linus Torvalds <torvalds@osdl.org> wrote:

> On Fri, 29 Dec 2006, Russell King wrote:
> > 
> > Suggest you test (eg) a rebuild of libX11 to see how it reacts to 
> > this patch.
> 
> Also: please rebuild "xargs" and install first. Otherwise, a lot of 
> build script etc that use "xargs" won't ever trigger the new limits 
> (or lack thereof), because xargs will have been installed with some 
> old limits.

yeah, and i think the default chunking of xargs should still remain 
128K.

If it's fine for a script to get chunked input, and if the script has no 
security relevance (xargs is fundamentally unsafe if any portion of the 
VFS namespace it gets used is untrusted), then there's no problem for 
the xargs limit to stay at 128K.

> Perhaps more worrying is if compiling xargs under a new kernel then 
> means that it won't work correctly under an old one.

xargs has its limit hardcoded AFAICS, it's based on:

#define ARG_MAX       131072    /* # bytes of args + environ for exec() */

i'd not change that just yet. The sysconf(3) manpage says it's generally 
unreliable:

  BUGS
       It is difficult to use ARG_MAX because it is not specified how much  of
       the  argument  space  for  exec() is consumed by the user's environment
       variables.

but ... as it is with every limit, it is always possible to write an 
application that hardcodes a larger limit and then doesnt work when 
running with the lower limit. Would that have been a correct argument 
against say raising the user stack limit from the historic 1MB?

right now some of my (more stupid) scripts occasionally break if any 
random portion of my VFS namespace grows over the silly 128K limit. (and 
it rarely has the tendency to shrink, sadly) I think that is just as 
much of a legitimate problem as any naive newly written script not 
working on an older kernel on a huge VFS namespace. (in fact i could 
argue for it to be a more legitimate problem than other stupid scripts 
not being backwards compatible, not the least because it is a problem 
with /my/ scripts ;-)

we could try something like adding an ARG_MAX rlimit, but i think that 
would be overdoing it ... we could also do a sysctl as a global limit - 
equally pointless because distros will likely tweak it up anyway, and in 
any case neither measure really prevents the writing of stupid scripts.

	Ingo
