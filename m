Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267722AbTAMJgb>; Mon, 13 Jan 2003 04:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267725AbTAMJgb>; Mon, 13 Jan 2003 04:36:31 -0500
Received: from mail.zmailer.org ([62.240.94.4]:49863 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S267722AbTAMJg1>;
	Mon, 13 Jan 2003 04:36:27 -0500
Date: Mon, 13 Jan 2003 11:45:15 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Rob Wilkens <robw@optonline.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: any chance of 2.6.0-test*?
Message-ID: <20030113094515.GT27709@mea-ext.zmailer.org>
References: <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com> <1042400094.1208.26.camel@RobsPC.RobertWilkens.com> <20030112211530.GP27709@mea-ext.zmailer.org> <1042406849.3162.121.camel@RobsPC.RobertWilkens.com> <20030112215949.GA2392@www.kroptech.com> <1042410059.1208.150.camel@RobsPC.RobertWilkens.com> <1850.4.64.197.173.1042420003.squirrel@www.osdl.org> <1042420910.3162.277.camel@RobsPC.RobertWilkens.com> <20030113015116.GA3433@hobbes.itsari.int> <1042424368.3162.322.camel@RobsPC.RobertWilkens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1042424368.3162.322.camel@RobsPC.RobertWilkens.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2003 at 09:19:28PM -0500, Rob Wilkens wrote:
> On Sun, 2003-01-12 at 20:51, Nuno Monteiro wrote:
> > You dont realistically expect to learn how to program reading 
> > Documentation/CodingStyle, do you? CodingStyle merely serves as general 
> 
> No, but I would expect rules of kernel coding to be in there.  For
> example, we were talking about using return mid-function.  I always
> considerred that perfectly OK.  Others were saying that's a no-no.  If
> it's a no-no, it should be documented.  That is, if it's a no-no.  That
> may be a situational thing though.


That document is short for several reasons.

- It has been written for particular needs, and updated rarely

- Most long-time kernel coders really don't need detailed guidelines,
  although newcomers (like yourself) apparently want something..



Things you need to understand include at least:

- Linux kernel is one of the most complicated codes that gcc compiler
  is ever put to work on, and over the years we have unearthed tons of
  optimizer bugs.    Many of somewhat odd looking coding details do
  originate from circumventions of those compiler bugs.

- Advanced optimizer hinting features, like   unlikely()  attribute
  are very new in (this) compiler, and while they in theory move the 
  "unlikely" codes out of the fast-path, such things have been buggy
  in the past, and we are worried of bug effects...

- Why code in a manner, where the optimizer needs to work very hard to
  produce fast code, when simplified structures, like those with 'goto'
  in them, can result the same with much less effort ?

- Knowing effects of those optimizations requires profiling, and studying
  produced assembly code on different target systems.

- Linux is multi-CPU-architecture kernel, looking at it via "intel-only,
  lattest Pentium-XIV" viewpoint is not going to cover all cases.  Making
  changes that bloat code will make system that much harder to fit into
  smaller embedded machines.

- Sometimes you need to code differently to achieve higher performance
  at different processors.  See   drivers/md/xor.c   and header files
  it includes.  Especially all  include/asm-*/xor.h  files, including
  include/asm-generic/xor.h ...   (That shows to you how different
  approaches work at different systems.  What works fast in register-
  rich processors does not necessarily be fast in register-poor things,
  like i386 series.)

- Adding function classifiers like "static inline" do change rules 
  somewhat. (Especially things like "mid-function return".)

- Larger code, either with manually replicated exit cleanup (which
  are pain to maintain, when some large-scale change is needed), or
  via excessive use of "static inline", will pressure caches, and
  makes it more likely to drop soon to be again needed code (or data)
  from cache.    Cases where cache-miss costs your tens, or hundreds
  of processor clock cycles that is really important question.

- Explaining things like GCC asm() statement syntaxes isn't a thing
  for Linux kernel documentation.  (Those vary from target processor
  to another!)


I repeat:

To understand effects of various coding details, you need to study produced
assembly code, and keep in mind that in modern processors a branch out of
straight-line execution path (after optimizations) is expensive (in time),
and cache-misses are even more expensive.

Then you need to benchmark those codes with different loads (where 
applicable) to find out what caches affect them -- and when you must
bypass caches (they are limited resource, after all) in order to give
overall improved system performance, when your code does not cause
actively used code or data to be evicted from caches unnecessarily.


> -Rob

/Matti Aarnio
