Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263472AbTDSVMi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 17:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263473AbTDSVMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 17:12:37 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:17861 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263472AbTDSVMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 17:12:34 -0400
Date: Sat, 19 Apr 2003 23:24:17 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Paul Mackerras <paulus@samba.org>
Cc: Paul Larson <plars@linuxtestproject.org>,
       ltp-coverage@lists.sourceforge.net,
       lse-tech <lse-tech@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Ltp-coverage] 2.5.67-gcov and 2.4.20-gcov
Message-ID: <20030419212417.GB22013@wohnheim.fh-wedel.de>
References: <1050502803.8637.1094.camel@plars> <20030416164440.GB2305@wohnheim.fh-wedel.de> <1050511870.10732.1277.camel@plars> <20030417123111.GA29390@wohnheim.fh-wedel.de> <16031.13262.665030.500906@nanango.paulus.ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16031.13262.665030.500906@nanango.paulus.ozlabs.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 April 2003 09:07:58 +1000, Paul Mackerras wrote:
> =?iso-8859-1?Q?J=81=F6rn?= Engel writes:
> 
> > The bit in arch/ppc/kernel/entry.S was necessary for me to compile
> > this for a ppc 405gp based system, gcov would grow the kernel beyond
> > the relative jump distance for "bnel syscall_trace".
> > 
> > Paulus, Ben, is the relative jump a wanted optimization or unclean
> > code that went unnoticed so far? IOW should this go into mainline or
> > remain part of the gcov patch?
> 
> What's unclean about bnel?

Nothing, as long as it works. But the jump target may only be 1<<13
bytes away. With gcov, it is further. syscall_trace is in a different
source file, so the distance can grow quite large.

> I think ret_from_fork would be better like this:
> 
> 	.globl	ret_from_fork
> ret_from_fork:
> 	bl	schedule_tail
> 	lwz	r0,TASK_PTRACE(r2)
> 	andi.	r0,r0,PT_TRACESYS
> 	beq+	ret_from_except
> 	bl	syscall_trace
> 	b	ret_from_except
> 
> Unless of course you have bloated the kernel beyond 32MB, but then we
> would be in all sorts of difficulties.

Does bl leave 25 bits for the jump target? I don't have a ppc manual
or test hardware with me over the holidays. Will check next week.

32MB sounds quite sufficient. My current record is 28MB for vmlinux on
i386, after allyesconfig basically. This is for statical analysis
only, I would think about booting such a monster.

> > +.section ".ctors","aw"
> > +.globl  __CTOR_LIST__
> > +.type   __CTOR_LIST__,@object
> > +__CTOR_LIST__:
> > +.section ".dtors","aw"
> > +.globl  __DTOR_LIST__
> > +.type   __DTOR_LIST__,@object
> > +__DTOR_LIST__:
> 
> Can't you do this in arch/ppc/vmlinux.lds using PROVIDE() instead of
> making the same change to each of the head*.S files?

Maybe, but why bother. As long as the patch doesn't go into mainline,
the change is identical for arch/*/kernel/head*.S, which is easy to
understand.

If you think it would still be nicer, I will do the change.

Jörn

-- 
Data dominates. If you've chosen the right data structures and organized
things well, the algorithms will almost always be self-evident. Data
structures, not algorithms, are central to programming.
-- Rob Pike
