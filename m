Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312503AbSC3ToZ>; Sat, 30 Mar 2002 14:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312505AbSC3ToQ>; Sat, 30 Mar 2002 14:44:16 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:12653 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S312503AbSC3ToE>; Sat, 30 Mar 2002 14:44:04 -0500
Date: Sat, 30 Mar 2002 20:44:44 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, gerrit@us.ibm.com
Subject: Re: Backport of Ingo/Arjan highpte to 2.4.18 (+O1 scheduler)
Message-ID: <20020330204444.A1264@dualathlon.random>
In-Reply-To: <242250000.1016752254@flay> <20020326180841.C13052@dualathlon.random> <13110000.1017442147@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2002 at 02:49:07PM -0800, Martin J. Bligh wrote:
> > I'm not considering to drop pte-highmem from 2.4 and to only support the
> > user-fixmaps in 2.5 because it is a showstopper bugfix for lots of
> > important users that definitely cannot wait 2.6. I'm also not
> > considering backporting the user-fixmaps because that would be a quite
> > invasive change messing also with the alignment of the user stack (I
> > know it could stay into kernel space, but right after the user stack it
> > will be more optimized and cleaner/simpler, so I prefer to put the few
> > virtual pages there).
> 
> Can you explain the problem with the aligment of the user stack? I can't
> see what the problem is here .... and we need to start thinking about how
> to fix it if you've seen a problem that we haven't ....

the user stack never started on a non power of two, so far, so some
buggy app may do assumptions on that, and bugs could trigger than. No
app should break in theory. If somebody is doing a map fixed near the
stack using a and-mask (instead of a minus) on %esp to calculate the
offset of the map-fixed, that could break if we eat a copule of virtual
pages of stack. I triggered something related when I was using a bit
larger heap-stack-gap, I know there are apps putting mappings very near
the stack (the one I've in mind isn't even open source so I don't know
how it chooses the address), but most probably correctly none of them
makes assumption on the alignment of the top of the stack, so it's
should be safe, but you know you never know :). Also given the
complexity of the patch, and also given it's definitely not necessary
in 2.4 just to get the scalability bit I recommend it for 2.5 only (my
new scalable pte-highmem using atomics in the fast paths and persistent
in the slow paths where 2.5 is also currently broken is just working
just fine on top of pre4).  I was ready to release it today (just
running for one day of stress testing), but pre5 came out so I'll have
to spend some more hour to slowly resync and rediff.

Andrea
