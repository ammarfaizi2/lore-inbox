Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318572AbSIFNtL>; Fri, 6 Sep 2002 09:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318599AbSIFNtL>; Fri, 6 Sep 2002 09:49:11 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:9 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S318572AbSIFNtK>;
	Fri, 6 Sep 2002 09:49:10 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200209061353.g86Drcv06621@oboe.it.uc3m.es>
Subject: Re: (fwd) Re: [RFC] mount flag "direct"
In-Reply-To: <Pine.LNX.4.44L.0209061021280.1857-100000@imladris.surriel.com>
 from Rik van Riel at "Sep 6, 2002 10:22:43 am"
To: Rik van Riel <riel@conectiva.com.br>
Date: Fri, 6 Sep 2002 15:53:38 +0200 (MET DST)
Cc: "Peter T. Breuer" <ptb@it.uc3m.es>, Anton Altaparmakov <aia21@cantab.net>,
       Daniel Phillips <phillips@arcor.de>, Alexander Viro <viro@math.psu.edu>,
       Xavier Bestel <xavier.bestel@free.fr>, david.lang@digitalinsight.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Rik van Riel wrote:"
> On Fri, 6 Sep 2002, Peter T. Breuer wrote:
> 
> >    suppose that I make the FS twice as slow as before by meddling with
> >    it to make it sharable
> >
> >    then I simply share it among 4 nodes to get a two times _speed up_
> >    overall.
> >
> > That's the basic idea. Details left to reader.
> 
> The "detail" is lock contention. If you lock the filesystem

Assume that I don't make infantile mistakes and your arguments will look
more convincing too </rant ;->

> and invalidate the caches you'll be able to do one operation
> every disk seek, across all nodes.

EVEN if you do that, you will still get a two times speed up from the
naive sketch above.  Your argument rests on the suggestion that there is
contention.  But there most likely isn't!  The problem that having
shared access seeks to solve in the first place is _bandwidth_.  One cpu
writing to one disk can only go so fast, because it takes time to
process its inputs, time to do the (massively parallel) analysis, and
time to write its outputs.  There is lots of space in its execution
cycle (while the analysis happens) for other cpus to read or write to
the same disk.  And even better if we can get them all working on
different parts of the same data at a time (well, we can ..).

Let me tell you that the cpus are essentially doing "ray tracing"
for thousands of jets at a time, and that there are a good number
of originators of these jets every second .. enough per second
that we must analyse and store (or discard) the data in real time.
Yes, there are common data that we want stored once and read many
times, and then there is secondary data that we want stored once and
read once.

And we need the data to be duplicated and triplicated too. It cannot be
lost. Analysis is needed to determine if the full array is turned loose
on the data (i.e. discard or not). Then more analysis follows.

BTW, Network bandwidth itself and the computation cycles taken by the
cpus to handle the networking are also considerations. We need lots of
options.

> Chances are your 4-node system would have lower aggregate
> throughput than a single node system.

IF, and I say IF, it turned out to look that way, we would look for
finer locking instead of abandoning the idea, because the raw arithmetic
at the top of this post is so powerful.

That would also remove your arument about contention, but then
we are into the detail of the process then, and "it depends".

All I am asking is that you make the evaluation of such strategies
easier by allowing me to - or giving me clues that help me to - 
do rough implementations from which a further evaluation can proceed.
And to that end.

At the moment I would like a clue for how to vamoosh the dcache for
a given FS. Can't I set a flag on every dentry that means "kill me
now", so that d_alloc's never are more than trivial. Or am
I forced to to take the root dentry, and dput it after having first
walked through its children and dputted them? (gawd, I hate that
kind of inplace nonrecursive tree-walking).

Pointer? Clue? I'm happyto take all contributions in the clue
department :-).

Peter
