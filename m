Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261399AbVE2Ssa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbVE2Ssa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 14:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbVE2Ssa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 14:48:30 -0400
Received: from fire.osdl.org ([65.172.181.4]:50575 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261399AbVE2SsZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 14:48:25 -0400
Date: Sun, 29 May 2005 11:49:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Pekka Enberg <penberg@gmail.com>
cc: Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM] Machine Freezes while Running Crossover Office
In-Reply-To: <84144f0205052911202863ecd5@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0505291143350.10545@ppc970.osdl.org>
References: <1117291619.9665.6.camel@localhost>  <Pine.LNX.4.58.0505291059540.10545@ppc970.osdl.org>
 <84144f0205052911202863ecd5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 29 May 2005, Pekka Enberg wrote:
> 
> Looking at output of lsof, I can see that Crossover is using pipes. I
> am not very familiar with wine internals but there seems to be two
> processes, wine_preloader and wine, that talk to each other through
> pipes. Unfortunately, stracing either one of the processes masks the
> problem. That is, I cannot reproduce the hang while doing strace.

Ahh.

I suspect that the _real_ change is that the pipe can now fill up with
sixteen times more data (ie 64kB of data in one read() or write()  
operation rather than 4kB), and that as a result Crossover may be doing a
lot bigger requests to the X server too.

Alternatively, it's possible that Crossover has taken mouse focus (does 
the mouse move around while the machine is "frozen"?) and Crossover itself 
is confused by the bigger buffers and pauses due to some bug while it is 
holding on to the mouse focus - making the system unusable. It's probably 
some race that triggers this (getting data at the right speed), and 
tracing it just changes timing enough that you won't see it.

(Btw, if you didn't already, I'd suggest forcing strace output to a file,
not the screen, since that at least changes timings and X interactions
_less_)

The pipe_poll() thing was possibly true even before - if the two main
processes are communicating over a pipe, it's quite possible that
pipe_poll() ends up being the most common op by far. See if the poll 
timeout changes (or is zero).

		Linus
