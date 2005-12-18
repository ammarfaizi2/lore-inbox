Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965237AbVLRRaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965237AbVLRRaN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 12:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965236AbVLRRaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 12:30:13 -0500
Received: from relais.videotron.ca ([24.201.245.36]:64338 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S965235AbVLRRaL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 12:30:11 -0500
Date: Sun, 18 Dec 2005 12:29:56 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 1/12]: MUTEX: Implement mutexes
In-reply-to: <Pine.LNX.4.64.0512172227280.3698@g5.osdl.org>
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Howells <dhowells@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
       linux-arch@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
       mingo@redhat.com, Andrew Morton <akpm@osdl.org>
Message-id: <Pine.LNX.4.64.0512181221510.26663@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <Pine.LNX.4.64.0512162334440.3698@g5.osdl.org>
 <dhowells1134774786@warthog.cambridge.redhat.com>
 <200512162313.jBGND7g4019623@warthog.cambridge.redhat.com>
 <1134791914.13138.167.camel@localhost.localdomain>
 <14917.1134847311@warthog.cambridge.redhat.com>
 <Pine.LNX.4.64.0512171201200.3698@g5.osdl.org>
 <Pine.LNX.4.64.0512172018410.26663@localhost.localdomain>
 <Pine.LNX.4.64.0512171803580.3698@g5.osdl.org>
 <Pine.LNX.4.64.0512172150260.26663@localhost.localdomain>
 <Pine.LNX.4.64.0512172227280.3698@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Dec 2005, Linus Torvalds wrote:

> 
> 
> On Sat, 17 Dec 2005, Nicolas Pitre wrote:
> > 
> > Now if you don't disable interrupts then nothing prevents an interrupt 
> > handler, or another thread if kernel preemption is allowed
> 
> Preemption, yes. Interrupts no.
> 
> >							 to come 
> > along right between (2) and (4) to call up() or down() which will 
> > make the sem count inconsistent as soon as the interrupted down() or 
> > up() is resumed.
> 
> An interrupt can never change the value without changing it back, except 
> for the old-fashioned use of "up()" as a completion (which I don't think 
> we do any more - we used to do it for IO completion a looong time ago).

Maybe, but I would not bet anything on that statement.  I'm sure there 
are people still using semaphores for IO completion, calling up() from 
interrupt handlers.  And the fact is that it still works fine.

> So I think the interrupt disable could be removed for UP, at least for
> non-preemption.

This is IMHO too fragile and too easy to screw up.  And it puts extra 
conditions on the usage of semaphores that don't exist today.

This is why I think spliting counting semaphores and mutexes _is_ a good 
thing.  There is no special "no from interrupt" issue to care about with 
the unlock operation, it has better performances where the count is not 
important (the vast majority of all semaphores) and it produces even 
smaller code (and we're all for smaller kernels, right?).


Nicolas
