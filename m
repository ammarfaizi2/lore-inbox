Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313070AbSHVQYf>; Thu, 22 Aug 2002 12:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313563AbSHVQYe>; Thu, 22 Aug 2002 12:24:34 -0400
Received: from [195.223.140.120] ([195.223.140.120]:3946 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S313070AbSHVQYd>; Thu, 22 Aug 2002 12:24:33 -0400
Date: Thu, 22 Aug 2002 18:30:00 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Benjamin LaHaise <bcrl@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Pavel Machek <pavel@elf.ucw.cz>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: 32 bit arch with lots of RAM
Message-ID: <20020822163000.GS1117@dualathlon.random>
References: <Pine.LNX.4.44.0208170953190.3062-100000@home.transmeta.com> <2218410796.1029594453@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2218410796.1029594453@[10.10.2.3]>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2002 at 02:27:34PM -0700, Martin J. Bligh wrote:
> Not good for heavy threading. But bear in mind the alternative we
> were talking about (well, Ben was talking about, and you didn't want
> to talk about ;-)) is TLB flushing every system call, not every
> context switch between threads. Personally, I think that's worse.

yes that's worse but that was meant to enlarge the ZONE_NORMAL, not to
reduce the kmap overhead. Even with the per-task VM virtual zone that
changes at every switch_to, you'd still have the ZONE_NORMAL shortage
problem.

> looking at is kernel text replication for ia32, and that's hard too.
> This actually solves both problems, which is probably the only feather
> in its cap. If anyone has any other ways to solve the replication
> problem I'd be most interested ... (people muttered things about using
> segmentation once in a dark and dingy corner, but refuse to admit who
> they were).

actually another way to do it is with .text replicated in the kernel
image at different virtual addresses 2M naturally aligned. So then you
can have each numa node kernel entry points set at different offsets,
and during context switch across nodes you can adjust the regs->eip
depending on the next node you're going to run on. Of course page faults
fixup exceptions will need to learn about this replicated text offsets
too.  I'm not 100% sure it's really doable but at the moment I don't see
anything foundamental that forbids that. That would avoid the tlb
flushes across switch_to.

Andrea
