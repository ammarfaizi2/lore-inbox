Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbUDCOLe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 09:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbUDCOL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 09:11:27 -0500
Received: from mail.shareable.org ([81.29.64.88]:46998 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261745AbUDCOLY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 09:11:24 -0500
Date: Sat, 3 Apr 2004 15:11:12 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Tim Connors <tconnors+linuxkernel1080972247@astro.swin.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: solved (was Re: xterm scrolling speed - scheduling weirdness in 	2.6 ?!)
Message-ID: <20040403141112.GD4706@mail.shareable.org>
References: <1073227359.6075.284.camel@nosferatu.lan> <20040104225827.39142.qmail@web40613.mail.yahoo.com> <20040104233312.GA649@alpha.home.local> <20040104234703.GY1882@matchmail.com> <1073296227.8535.34.camel@tiger> <1080930132.1720.38.camel@localhost> <slrn-0.9.7.4-9426-9838-200404031530-tc@hexane.ssi.swin.edu.au> <slrn-0.9.7.4-25410-10302-200404031604-tc@hexane.ssi.swin.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <slrn-0.9.7.4-25410-10302-200404031604-tc@hexane.ssi.swin.edu.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Connors wrote:
> So this is much like the xterm situation - 2 CPU chewing things,
> interacting with a third short lived low CPU job (ls or some
> wwwoffle fork) that the other two are relying on (mozilla and xterm
> directly, X indirectly)
> 
> This is my reason for not thinking this is an xterm bug. The scheduler
> looks inherently fragile.

It looks like scheduler fragility to me too.

I see the same with Gnome Terminal.  Most of the time, ls or cat are
fast, with jump scrolling.  But occasionally they are much slower.

There are two stable scheduling modes here - rapid switching with a
few characters moved, or slow switching with lots of characters moved.

We'd like the former to decay spontaneously to the latter, quickly.

I like the observation that the terminal program can solve this
problem by introducing a short delay after receiving a few bytes.
However, that's not feasible for X itself, which must draw things very
soon after receiving the commands so that animations are smooth when
that's intended, which happens when a client deliberately sleeps
rather than being preempted by having just sent a command to X.

I think the problem is that the scheduler is aggressively preempting a
task which has just written through a pipe/terminal/socket, when the
task at the other end becomes ready to run as a result.

If the writing task is still runnable, usually you want the writing
task to continue for a little while more.  The scheduler is getting
that right most times on my box with ls+Gnome Terminal+X, but
occasionally gets stuck in a mode where it consistently gets it wrong
until all the programs become idle again.  Then it recovers.
This mode is quite rare, once every few days.

> To help you work out my datapoint in relation to someone elses, my box
> is a 500MHz AMD KII, now running 2.6.4. The video card is in no way
> accelarated (crappy old nvidia card), so X likes to chew CPU easily.

Dual Athlon 1500 MHz, Matrox Millenium video card.

-- Jamie
