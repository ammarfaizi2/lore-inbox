Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261989AbVEaR1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbVEaR1s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 13:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261980AbVEaR1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 13:27:48 -0400
Received: from fire.osdl.org ([65.172.181.4]:46007 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262009AbVEaRXf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 13:23:35 -0400
Date: Tue, 31 May 2005 10:24:58 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
cc: Ingo Molnar <mingo@elte.hu>, Pekka Enberg <penberg@gmail.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Machine Freezes while Running Crossover Office
In-Reply-To: <1117558435.9228.7.camel@localhost>
Message-ID: <Pine.LNX.4.58.0505311010410.1876@ppc970.osdl.org>
References: <1117291619.9665.6.camel@localhost>  <Pine.LNX.4.58.0505291059540.10545@ppc970.osdl.org>
  <84144f0205052911202863ecd5@mail.gmail.com>  <Pine.LNX.4.58.0505291143350.10545@ppc970.osdl.org>
  <1117399764.9619.12.camel@localhost>  <Pine.LNX.4.58.0505291543070.10545@ppc970.osdl.org>
  <1117466611.9323.6.camel@localhost>  <Pine.LNX.4.58.0505301024080.10545@ppc970.osdl.org>
  <courier.429C05C1.00005CC5@courier.cs.helsinki.fi>  <20050531065456.GA21948@elte.hu>
 <1117558435.9228.7.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 31 May 2005, Pekka Enberg wrote:
> 
> On Tue, 2005-05-31 at 08:54 +0200, Ingo Molnar wrote:
> > - apply the patch below and check whether doing:
> > 
> >    echo 0 > /proc/sys/kernel/interactive
> > 
> >   makes the hang go away.
> 
> It's actually /proc/sys/vm/interactive but yes, 0 makes the hang go away
> while 1 makes it come back.

Ok, it's a scheduler bug.

The pipe thing is probably implicated only because it ends up changing
some timing just enough to make the interactivity tester trigger (ie doing
reads/writes in bigger blocks makes the frequency of the ping-pong between
wineserver and wine different, and then it ends up hitting some harmonic
sweet spot with the timer that makes the scheduler believe it's
interactive).

In fact, I suspect it ends up marking things "interactive" because they do
sleep longer - both of the parties sleep longer because the other end ends
up spending more time handling the work, since the pipe buffers are bigger
(so they sleep longer because they are _awake_ longer).

Ingo, any ideas? This is bothersome, because it could hit any number of
people, and we'd never have realized because it's not usually repeatable
and not usually quite that extreme. But if it can trigger 15-second dead
periods in very specific circumstances, it can probably trigger 
half-second dead periods much more easily. Things that people would assume 
were due to disk IO or VM badness..

		Linus
