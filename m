Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262590AbUCJMcq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 07:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262593AbUCJMcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 07:32:45 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:1807
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262590AbUCJMcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 07:32:08 -0500
Date: Wed, 10 Mar 2004 13:32:50 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Arjan van de Ven <arjanv@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: objrmap-core-1 (rmap removal for file mappings to avoid 4:4 in <=16G machines)
Message-ID: <20040310123250.GG30940@dualathlon.random>
References: <20040308202433.GA12612@dualathlon.random> <1078781318.4678.9.camel@laptop.fenrus.com> <20040308230845.GD12612@dualathlon.random> <20040309074747.GA8021@elte.hu> <20040309152121.GD8193@dualathlon.random> <20040309153620.GA9012@elte.hu> <20040309163345.GK8193@dualathlon.random> <20040309195752.GA16519@elte.hu> <20040309202744.GS8193@dualathlon.random> <20040310113501.GA1112@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040310113501.GA1112@elte.hu>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2004 at 12:35:01PM +0100, Ingo Molnar wrote:
> 
> * Andrea Arcangeli <andrea@suse.de> wrote:
> 
> > the quality of such objrmap patch is still better than rmap. The DoS
> > thing is doable with vmtruncate too in any kernel out there.
> 
> objrmap for now has a serious problem: test-mmap3.c locked up my box (i
> couldnt switch text consoles for 30 minutes when i turned the box off).
> 
> I'm sure you'll fix it and i'm looking forward seeing it.  However, i'd
> like to see the full fix instead of a promise to have this fixed
> sometime the future.  There are valid application workloads that trigger
> _worse_ vma patterns than test-mmap3.c does (UML being one such thing,
> Oracle with indirect buffer-cache another - i'm sure there are other
> apps too.).  Calling these applications 'exploits' doesnt help in
> getting this thing fixed.  There's no problem with keeping this patchset
> separate until it's regression-free.
> 
> > merging objrmap is the first step. Any other effort happens on top of
> > it.
> 
> i'd like to see that effort combined with this code, and the full
> picture.  Since this 'DoS property' is created by the current concept of
> the patch, it's not a 'bug' that is easily fixed so we must not (and
> cannot) sign up for it blindly, without seeing the full impact.  But
> yes, it might be fixable.  Anyway - the 2.6 kernel is a stable tree and
> i'm sure you know that avoiding regression is more important than
> anything else.

I'm fine to wait the whole work to be finished and to merge it all at
once (still from separate incremental patches) instead of merging it in
steps in mainline and your longer term confidence in our work is
promising, thanks.

since I need this fixed fast, I may have to go the rbtree way to go
safe (mainline could go with prio_trees in the long run instead).

however I still disagree the objrmap I posted is a regression for
applications like Oracle (dunno about uml). It's an obvious regression
for your test-mmap3.c and that's why I call test-mmap3.c an exploit and
not a "real app". Nobody would map 1 page per vma, get real, you have an
hard time to convince me a real app is going to scatter vma with 4k
aperture each. you wrote the very worst case that everybody is aware
about, a real app scenario would not do that. Note that there's quite an
huge amount of merging of file-vmas, you absolutely prevent that too.

Furthmore you said Oracle needs mlock to work "safe" with rmap. But with
2.6 if you use mlock it will still not work. If you use 2.6+objrmap
mlock will fix your DoS secenario too, and Oracle will work as fast as
rmap+mlock in your rmap 2.4 implementation.

Also you're advocating for the "merging in steps" and keeing "2.6
optimal", but you're ignoring the single reason you are forced to ship a
2.4 kernel with 4:4 for every >4G machine. 2.6 mainline (the current
2.6.3 step) has no way to be compiled with 4:4 model. So the current
great 2.6 kernel has no way to work with any machine >4G (if you ship
all PAE kernels with rmap compiled with 4:4 you must agree 2.6 mainline
has no way to work on any kernel with >4G of ram, so you should not be
surprised that I'm dealing with those issues currently). Is 2.6 an high
end kernel with rmap? I supported 4G on x86 the first time with bigmem
in 2.2.

Solving the problem by merging 4:4 instead of removing rmap is not the
way to go IMHO since it doesn't fix the memory waste for 64bit archs
compared to what we can do with 2.4 _mainline_ (64bit doesn't need
pte-highmem and there are no highmem issues to solve there).

At least with objrmap applied to 2.6, there would be a chance to survive
the load on >4G boxes in a 2.6 mainline kernel.  Sure, you'd better be
careful not to swapout heavy or it would risk to hang badly (if the app
isn't using mlock, if the app uses mlock 2.6 will fly), but without
objrmap it would lockup before you can worry about reaching swap (mlock
or not).

So in practice I think it would been ok to merge objrmap as an
intermediate step (it's not that I didn't evaluate those possibilities
when I submitted it).

As for the DoS thing in security terms, truncate has the same issue. It
maybe easier to kill the "exploit" since it returns to userspace every
time, and userspace is not swapped out when it happens, but it would
still waste an indefinite amount of time in kernel space. So providing
an efficient means of the i_mmap vma lookup is a problem irrelevant to
the objrmap patch for the vm, I think we agree on this. Doing that will
fix all users (so the vm too).
