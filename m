Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262377AbVEYPhd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262377AbVEYPhd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 11:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbVEYPhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 11:37:33 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:10739 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262377AbVEYPhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 11:37:17 -0400
Subject: Re: RT patch acceptance (scheduler) --- QUESTION
From: Steven Rostedt <rostedt@goodmis.org>
To: omb@bluewin.ch
Cc: "K.R. Foley" <kr@cybsft.com>, Esben Nielsen <simlo@phys.au.dk>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       john cooper <john.cooper@timesys.com>, sdietrich@mvista.com,
       akpm@osdl.org, mingo@elte.hu, dwalker@mvista.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <429495E5.3020909@khandalf.com>
References: <005801c560da$ec624f50$c800a8c0@mvista.com>
	 <429407B6.1000105@yahoo.com.au> <20050525060919.GA25959@nietzsche.lynx.com>
	 <4294228D.1040809@yahoo.com.au> <20050525092737.GA28976@nietzsche.lynx.com>
	 <429490BD.6070606@yahoo.com.au>  <429495E5.3020909@khandalf.com>
Content-Type: text/plain; charset=ISO-8859-1
Organization: Kihon Technologies
Date: Wed, 25 May 2005 11:36:43 -0400
Message-Id: <1117035403.10320.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Darn, I just got a chance to check my email, and I'm coming in very late
to this thread.  Well, I've tried to include everyone that is in on it
so that I can get direct emails too.  I'm very interested in this
thread.

On Wed, 2005-05-25 at 17:12 +0200, Brian O'Mahoney wrote:
> I havnt had time to look at thes patches so could someone
> who has answer the following questions
> 
> - what is the increase in kernel overhead with the full
>   patch enabled

There's a few and I'm sure that others will elaborate further.

wrt. IRQ threads:  Usually when a interrupt goes off, what ever is
running (presumably with interrupts enabled) gets interrupted and the
top level code is executed. With the RT patch, instead each top level
function is implemented by a separate thread.  So instead of just
executing the code at the time of the interrupt, you need to wake up the
corresponding thread instead. Now you have the overhead of a context
switch (two actually, one to get the the thread and another to get back
to what was interrupted). With lots of interrupts going off, you have
lots of context switches.  Not to mention the slight overhead of the
threads themselves.

With the priority inheritance, you have the overhead  of the spin locks
(which are now mutexes) having to do more to check if they are locked.
And if so, they get added to a priority list (if real time).

> 
> - can the patch be configured IN/OUT and if so BUILD/RUN time
> 

The patch is turned on with CONFIG options.  There's also an /proc
interface to change the actions of the kernel at run time if the CONFIGs
were turned on. You can change the way interrupts are preempted, and so
on.

> - I saw the mention of BUG catching, can someone elaborate
> 

I believe that you are talking about the catching problems that are hard
to find in the normal system.  The RT patch allows for much more
preemption and things that are not truly re-entrant but are expected to
be on a SMP system can be found much easier, since you have more context
switches happening at points that are usually protected by a spin lock.
The RT kernel makes the protection of spinlock areas just protected by
those that have the lock, as apposed to just disabling preemption.


Hope this helps,

Gruﬂ,

-- Steve


