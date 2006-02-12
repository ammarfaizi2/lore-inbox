Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbWBLPQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWBLPQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 10:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWBLPQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 10:16:27 -0500
Received: from science.horizon.com ([192.35.100.1]:44093 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1750790AbWBLPQ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 10:16:27 -0500
Date: 12 Feb 2006 10:16:16 -0500
Message-ID: <20060212151616.26381.qmail@science.horizon.com>
From: linux@horizon.com
To: lkml@tlinx.org
Subject: Re: max symlink = 5? ?bug? ?feature deficit?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That limit should be a *recursion* limit only.
Symlinks in the last component of a path are looked up
iteratively (to save kernel stack space), but a symlink in
the middle of a path can't be done tail-recursively.

E.g. in your example

 > namei cpu/args.t
f: cpu/args.t
 d cpu
 l args.t -> ../op/args.t
   d ..
   l op -> ../t/op/
     d ..
     l t -> perldir/t
       l perldir -> perl-5.8.6
         l perl-5.8.6 -> ../build/perl-5.8.6
           d ..
           l build -> BUILD
             d BUILD
           d perl-5.8.6
       d t
     d op
   - args.t

Wow, what a symlink maze.  The args.t -> ../op/args.t
symlink is no problems, but it's the mess of directory links
that the system has to traverse:

cpu/args.t
cpu/../op/args.t		Tail-recursive expansion
cpu/../(../t/op)/args.t
cpu/../(../(perldir/t)/op)/args.t
cpu/../(../((perl-5.8.6)/t)/op)/args.t
cpu/../(../((../build/perl-5.8.6)/t)/op)/args.t
cpu/../(../((../(BUILD)/perl-5.8.6)/t)/op)/args.t

I'm supposing the initial level counts as 1, so 1+5 = 6 and blows the
limit.

There's also an iteration limit, to stop a -> b -> c -> a cycles,
but that's much higher.  The recursion limit is a stack space issue.
