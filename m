Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312560AbSHVQgH>; Thu, 22 Aug 2002 12:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313563AbSHVQgH>; Thu, 22 Aug 2002 12:36:07 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:11164 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S312560AbSHVQgG>;
	Thu, 22 Aug 2002 12:36:06 -0400
Date: Thu, 22 Aug 2002 09:36:30 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Benjamin LaHaise <bcrl@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Pavel Machek <pavel@elf.ucw.cz>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: 32 bit arch with lots of RAM
Message-ID: <2632886270.1030008988@[10.10.2.3]>
In-Reply-To: <20020822163000.GS1117@dualathlon.random>
References: <20020822163000.GS1117@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> yes that's worse but that was meant to enlarge the ZONE_NORMAL, not to
> reduce the kmap overhead. Even with the per-task VM virtual zone that
> changes at every switch_to, you'd still have the ZONE_NORMAL shortage
> problem.

I disagree - the problem with ZONE_NORMAL is that we're stuffing
things that aren't global into a global space, and thus using up
space*NR_TASKS instead of space, which we would do if we remapped
things on a per-task basis. Effectively you're enlarging ZONE_NORMAL
by doing this - it's just not global any more.

> actually another way to do it is with .text replicated in the kernel
> image at different virtual addresses 2M naturally aligned. So then you
> can have each numa node kernel entry points set at different offsets,
> and during context switch across nodes you can adjust the regs->eip
> depending on the next node you're going to run on. Of course page faults
> fixup exceptions will need to learn about this replicated text offsets
> too.  I'm not 100% sure it's really doable but at the moment I don't see
> anything foundamental that forbids that. That would avoid the tlb
> flushes across switch_to.

This would be roughly the plan if we were to do segmentation tricks,
but I can't see how you'd avoid rewriting all the pointer stuff (like
jumps) within the kernel by just having different virtual addresses.
Segmentation (setting CS to the offset) deals with that problem for
you I think, but I'm sure you understand this whole area better that
I do. More of a problem for 32 bit machines with this is it consumes
virtual address space at a rate of kernel_size_rounded_up_to_2M *
NR_NODES. See discussion above re: ZONE_NORMAL consumption ;-)
Kernel text replication is going to be an arch specific hack for every
case anyway ... ia64 has some magic to shove fake entries into the TLB
I believe, but we don't have that ;-(

M.

