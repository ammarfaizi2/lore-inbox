Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311749AbSGBV26>; Tue, 2 Jul 2002 17:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311752AbSGBV25>; Tue, 2 Jul 2002 17:28:57 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.247.199]:9491 "EHLO
	mx2.cypherpunks.ca") by vger.kernel.org with ESMTP
	id <S311749AbSGBV24>; Tue, 2 Jul 2002 17:28:56 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: ptrace vs /proc
Date: 2 Jul 2002 21:16:50 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <aft582$mq0$1@abraham.cs.berkeley.edu>
References: <Pine.LNX.4.44.0206201742170.18444-100000@lin114-02.cise.ufl.edu> <1024609747.922.0.camel@sinai> <20020702004706.GB107@elf.ucw.cz>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1025644610 23360 128.32.153.211 (2 Jul 2002 21:16:50 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 2 Jul 2002 21:16:50 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek  wrote:
>I believe such proc interface is wrong thing to do. ptrace() is really
>very *very* special thing, and you don't want it hidden in some kind
>of /proc magic.

Five years ago I believed all that mattered was the functionality:
whether it was exposed via ptrace() and signals or via /proc and ioctls
was irrelevant.  Since then, having spent a lot of time using both Linux
ptrace() and Solaris /proc, I've learned that there is a huge difference
between the two.  The Solaris implementation, via /proc, is very clean.
The Linux implementation, via ptrace(), is icky.

For example, ptrace() uses signals as part of its interface; this
is a gross kludgy hack, and it breaks various things.  For instance,
overloading the meaning of signals causes wait4() to break in the traced
process, and you have to do all sorts of workarounds in the tracer
to make tracing transparent.  Go read the source code to strace(1).
I think if you spend the time to understand it all, you'll agree with
me that it is sadly hairy stuff.

The Solaris /proc implementation, in contrast, was much cleaner,
in my experience.  I suspect this is partially because the Solaris
implementation was more carefully thought-through, but also the interface
helped: by not overloading the meaning of signals, the Solaris /proc
interface avoids changing the semantics of signal-related functionality
in the traced process, and this makes for cleaner code.

Solaris /proc also had other nice features, like the ability to follow
fork() automatically and so on.  (Check out what strace has to do with
ptrace(): it actually does binary code-rewriting of the traced process
on the fly to work around lack of functionality in ptrace().)  Many of
these features, of course, were orthogonal to whether the process tracing
was implemented via ptrace() and signals or /proc and ioctls.
