Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267769AbUI1OTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267769AbUI1OTj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 10:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267536AbUI1OTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 10:19:39 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:35248 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S267851AbUI1OTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 10:19:18 -0400
Date: Tue, 28 Sep 2004 16:19:14 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Hui Huang <Hui.Huang@Sun.COM>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: heap-stack-gap for 2.6
Message-ID: <20040928141914.GE2412@dualathlon.random>
References: <20040925162252.GN3309@dualathlon.random> <415903E4.1030808@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <415903E4.1030808@sun.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2004 at 11:25:40PM -0700, Hui Huang wrote:
> Andrea Arcangeli wrote:
> >This patch enforces a gap between heap and stack, both on the mmap side
> >(for heap) and on the growsdown page faults for stack. the gap is in
> >page units and it's sysctl configurable. Against CVS head.
> >
> >This is needed for some critical app, that wants an higher degree of
> >protection against potential stack overflows from the kernel. This is
> >mostly a 32bit matter of course, since on 32bit those apps are using
> >a few gigs of heap and they get as near as they can to the stack (but if
> >something goes wrong a page fault must happen).
> >
> >
> >the default value of 1 avoids userspace apps like java to break,
> 
> Ok, I'm a JVM guy and I worked on heap-stack-gap issue many moons ago.
> The reason that heap-stack-gap on SuSE Linux used to crash Java is
> because we are explicitly setting up a guard page to prevent heap-stack
> collision (a stack guard is also required in order to throw stack
> overflow exception). So in a java program, prev_vma in your patch does
> not point to regular heap memory but the guard page. The hidden gap
> would cause SIGSEGV to occur before the thread actually hits the guard,

this however doesn't offer the protection on the mmap side, but maybe
you limit the amount of mmaps with another logic.

> that confused JVM. We had to work around it by reading the gap size from
> /proc.

cool, so you're already using this heap-stack-gap API. Then maybe we
could increase the size to more than 1 page. 1 page is the minimum,
infact those apps asking for the feature have to increase it by hand in
/proc.

> I'd recommend adding an extra check to see if prev_vma is read/write,
> and ignoring heap-stack-gap if prev_vma is guard page. Having a hidden
> gap does not offer any extra protection, it only confuses an application
> if it manages stack guard.

you recommendation is valid, and this should work, the stack cannot be
read before it's written to. In theory userspace could track the size of
the stack and know it is supposed to be 0 and avoid a potential
memset(0) on local variables the first run, but I don't think gcc is
capable of doing that.


My only worry is that this mess up things with mprotect, I mean I can't
just check only for read-only vmas, I've also to trap when this
read-only vma infact becomes read-write again. So for simplicity of the
implementation I would prefer not to track readonly pages. If you've a
strong reason for tracking readonly pages let me know of course. I think
java already does fine by checking the heap-stack-gap.
