Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261787AbVCaUab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbVCaUab (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 15:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261811AbVCaUaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 15:30:30 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:43790 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261787AbVCaUaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 15:30:12 -0500
Date: Thu, 31 Mar 2005 22:30:10 +0200
From: Adrian Bunk <bunk@stusta.de>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Yum Rayan <yum.rayan@gmail.com>, linux-kernel@vger.kernel.org,
       mvw@planets.elm.net
Subject: Stack usage tasks
Message-ID: <20050331203010.GF3185@stusta.de>
References: <df35dfeb05033023394170d6cc@mail.gmail.com> <20050331150548.GC19294@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050331150548.GC19294@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2005 at 05:05:48PM +0200, Jörn Engel wrote:
> On Wed, 30 March 2005 23:39:40 -0800, Yum Rayan wrote:
> > 
> > Before patch
> > ------------
> > check_free_space - 128
> > do_acct_process - 105
> > 
> > After patch
> > -----------
> > check_free_space - 36
> > do_acct_process - 44
> 
> It is always nice to see enthusiams, but in your case it might be a
> bit misguided.  None of the functions you worked on appear to be real
> problems wrt. stack usage.
> 
> But if you have time to tackle some of these functions, that may make
> a real difference:
> 
> http://wh.fh-wedel.de/~joern/stackcheck.2.6.11
> 
> In principle, all recursive paths should consume as little stack as
> possible.  Or the recursion itself could be avoided, even better.  And

Sometimes it's easy to prove that the recursion can't occur more than 
once.

Especially with a moderate stack usage, such cases are not a problem.

But auditing the recursive paths for problematic ones is still an open 
task.

> some of the call chains with ~3k of stack consumption may be
> problematic on other platforms, like the x86-64.  Taking care of those
> could result in smaller stacks for the respective platform.

There's also something different that can be done:

On i386, unit-at-a-time is disabled (the only currently released version 
of GNU gcc with unit-at-a-time is gcc 3.4 [1]) since gcc's stack 
handling isn't very good.

With unit-at-a-time, the highest stack usage within a single function is 
over 3kB.

While this is technically gcc's fault, workarounds were IMHO worth it 
since unit-at-a-time gives me kernel images that are smaller by 2% [2] 
and I was surprised if the speed effect wasn't positive [3].

The task I'm suggesting was therefore:
- remove the -fno-unit-at-a-time in arch/i386/Makefile in your private
  kernel sources
- use gcc 3.4
- reduce the stack usages in call paths > 3kB

Note that with unit-at-a-time, gcc inline several static functions, so 
the stack usage you see for a function might be accumulated from several 
functions.

It's IMHO the best doing this against -mm.

I do currently not have the time for doing this, but it was something 
with a real advantage for many users.

> Jörn

cu
Adrian

[1] SuSE "gcc 3.3" also supports this
[2] with -O2
[3] I do not claim it has to be measurable positive, but at least not
    negative

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

