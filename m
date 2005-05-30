Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbVE3R3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbVE3R3r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 13:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbVE3R3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 13:29:47 -0400
Received: from fire.osdl.org ([65.172.181.4]:18122 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261654AbVE3R3n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 13:29:43 -0400
Date: Mon, 30 May 2005 10:31:07 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
cc: Pekka Enberg <penberg@gmail.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PROBLEM] Machine Freezes while Running Crossover Office
In-Reply-To: <1117466611.9323.6.camel@localhost>
Message-ID: <Pine.LNX.4.58.0505301024080.10545@ppc970.osdl.org>
References: <1117291619.9665.6.camel@localhost>  <Pine.LNX.4.58.0505291059540.10545@ppc970.osdl.org>
  <84144f0205052911202863ecd5@mail.gmail.com>  <Pine.LNX.4.58.0505291143350.10545@ppc970.osdl.org>
  <1117399764.9619.12.camel@localhost>  <Pine.LNX.4.58.0505291543070.10545@ppc970.osdl.org>
 <1117466611.9323.6.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 30 May 2005, Pekka Enberg wrote:
> 
> On Sun, 2005-05-29 at 15:59 -0700, Linus Torvalds wrote:
> > However, I don't understand how wine can block the X server from doing 
> > even cursor updates. It might be a scheduler bug, of course. The one thing 
> > a bigger pipe buffer does is end up changing scheduling behaviour. 
> > 
> > (On the other hand, I would not be surprised if Wine does something that 
> > makes X pause, like use DGA or whatever and tells X not to update the 
> > screen, including cursors).
> 
> It is not just X. Running the following shell script when hitting the
> bug:

Ok, this implies that the scheduler is really screwed up, we're not 
scheduling anything else during that time.

Ingo, this sounds like you need to take a look.

Pekka, can you confirm that the SysRQ output in your original email was 
from a "hung" time? Because that clearly shows that stuff is happening in 
user space, which means that it's definitely not a kernel loop.

Also, pipes are a bit special from a scheduling standpoint because they 
use the magic "synchronous wakeup" thing, and it might be worthwhile 
trying to just change the two calls to "wake_up_interruptible_sync()" in 
fs/pipe.c to the non-sync version (ie just remove the "_sync" part).

> It looks like no other processes other than wineserver and
> wine-preloader get any CPU time (also evident from Sysrq-P traces).

Indeed. 

One more thing: are those processes given RT priority? Because if so, it 
likely boils down to a wine bug again - a busy-looping high-priority 
process is _supposed_ to do what you see.

		Linus
