Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262190AbUFSIex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbUFSIex (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 04:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265302AbUFSIex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 04:34:53 -0400
Received: from holomorphy.com ([207.189.100.168]:41868 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262190AbUFSIev (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 04:34:51 -0400
Date: Sat, 19 Jun 2004 01:34:46 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] flexible-mmap-2.6.7-D5
Message-ID: <20040619083446.GP1863@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
References: <20040618213814.GA589@elte.hu> <20040618231631.GO1863@holomorphy.com> <20040619074612.GB12020@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040619074612.GB12020@elte.hu>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 19, 2004 at 09:46:12AM +0200, Ingo Molnar wrote:
> the patch already takes care of this via two mechanisms:
> - the top of the mmaps is moved down by the expected maximum size of the
>   stack (the stack rlimit).
> - we maintain a minimum 128 MB 'gap' between stack top and mmap top. 
> moving it to 0x08040000 is asking for trouble, there are people who need
> 1GB stacks (dont ask why). This approach has been in production use for
> ~2 years and it works fine for a wide range of applications and VM
> needs.

I'm not terribly convinced the stack's virtual placement helps in the
case where 1GB stacks are needed as within rlimits, it's usually lazily
expanded. I suppose the users in need of it adjust their rlimits, say,
in the shell spawning the process wanting it to precisely what they
need in this scheme, which is awkward, but doesn't require code
modification for the offending apps.

Also, I suspect some more graceful fallback would make sense
particularly for the case of RLIM_INFINITY, which would leave users
that run with, say, all rlimits at RLIM_INFINITY in the interest of
having full access to system resources with a mere 512MB of
virtualspace for the heap, which IIRC glibc is intelligent enough to
circumvent for malloc(), but not for mmap(NULL, ...). If it's been in
production that long, I find it hard to believe that's never been
tripped over. This is one of the reasons that when I thought about this
and split off an isolated patch for top-down vma allocation from
execshield, I gave up immediately on the rlimits and said "let them
malloc() their own stacks", and shoved the default down low (also, that
128MB is currently wasted); the rlimits appeared to need too precise of
tuning and be easy to mis-tune. But that was a matter of thinking about
it, not experience.

These are questions whose answers largely do not affect me personally
or anything I work on. If the answer is "it suffices as-is" I won't get
worked up about it. I didn't raise the RLIM_INFINITY point in my prior
post (b/c I missed the rlimit bit), so for the sake of completeness I
droned on and on about it here.

Last and definitely least, the declaration in sched.h of functions only
used in mmap.c set off some warning flags; it may make sense to just
declare the things in mm/mmap.c, possibly with __attribute__((weak)) or
some such (AIUI this is now allowed, the last buggy arches' toolchains
were fixed, and it's already used now with cond_syscall() etc.). There
is a bit of nastiness with sched.h being a "garbage can" header it'd be
nice to avoid aggravating.

Thanks.


-- wli
