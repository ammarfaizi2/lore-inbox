Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265083AbTFYVVZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 17:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265084AbTFYVVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 17:21:25 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:5640 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S265083AbTFYVVU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 17:21:20 -0400
Date: Wed, 25 Jun 2003 23:41:19 +0200
To: Bill Davidsen <davidsen@tmr.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: O(1) scheduler & interactivity improvements
Message-ID: <20030625214119.GA2753@hh.idb.hist.no>
References: <20030623164743.GB1184@hh.idb.hist.no> <Pine.LNX.3.96.1030624140933.6519A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1030624140933.6519A-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 24, 2003 at 02:12:20PM -0400, Bill Davidsen wrote:
> On Mon, 23 Jun 2003, Helge Hafting wrote:
> 
> > On Mon, Jun 23, 2003 at 12:18:29PM +0200, Felipe Alfaro Solana wrote:
> 
> > > I don't consider compiling the kernel an interactive process as it's
> > > done almost automatically without any user intervention. XMMS is not a
> > > complete interactive application as it spends most of the time decoding
> > > and playing sound.
> > > 
> > A kernel compile isn't interactive - sure.  It may get some boosts
> > anyway for io waiting.  This quite correctly puts it above a
> > pure cpu hog like a mandelbrot calculation.
> 
> Why? Not why does the scheduler do that, but why *should* a compile be in
> any way more deserving that a Mandelbrot? It isn't obvious to me that
> either are interacting with the user, and if they are it would be the
> Mandelbrot doing realtime display.

This has nothing to do with "interacting with the user", the sleep-based
priority system solves other problems as well.  A pure cpu hog
utilizes all the cpu it gets.  A compile will end up waiting a lot for io
because it reads input files.  This starves the compile, the cpu hog
utilizes all of its timeslices plus the time the compile waits.
This is rectified by giving the compile a boost whenever it waits
(and lets someone else have the cpu).  This avoids penalizing processes
just because they do io or lots of io.  Readers would otherwise
progress very slowly in the precense of cpu hogs.

Incidentally, this also helps interactivity a lot because interactive
programs tend to wait for user input in the form of io, and when
they get it they get a boost and process the user input quickly.


As for my mandelbrot/compile example - the kernel cannot know
wether you:
* are busy watching fractals and just do a background compile,
or:
* wait for an important compile and pass some time rendering fractals
  when the compiler stall reading.

But you can tell it using explicit "nice"

Helge Hafting
