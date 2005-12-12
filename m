Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbVLLSbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbVLLSbS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 13:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbVLLSbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 13:31:18 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:49055
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932126AbVLLSbS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 13:31:18 -0500
Subject: Re: [patch 00/21] hrtimer - High-resolution timer subsystem
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       rostedt@goodmis.org, johnstul@us.ibm.com, mingo@elte.hu
In-Reply-To: <1134405768.4205.190.camel@tglx.tec.linutronix.de>
References: <20051206000126.589223000@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0512061628050.1610@scrub.home>
	 <1133908082.16302.93.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0512070347450.1609@scrub.home>
	 <1134148980.16302.409.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0512120007010.1609@scrub.home>
	 <1134405768.4205.190.camel@tglx.tec.linutronix.de>
Content-Type: text/plain
Organization: linutronix
Date: Mon, 12 Dec 2005 19:37:53 +0100
Message-Id: <1134412673.4205.230.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 2005-12-12 at 14:39 +0100, Roman Zippel wrote:
> > > Actually the change adds more code lines and removes one field of the
> > > hrtimer structure, but it has exactly the same functionality: Fast
> > > access to the first expiring timer without walking the rb_tree.
> > 
> > Together with the state field this would save 12 bytes, which is IMO very 
> > well worth considering.
> > You seem to have some plans for it, the best hint I've found for it is:
> > 
> > + (This seperate list is also useful for high-resolution timers where we
> > + need seperate pending and expired queues while keeping the time-order
> > + intact.)"
> > 
> > Could you please elaborate on this?
> 
> Sure. I have already removed the list_head for the non high resolution
> case as it turned out that it does not hurt the high resolution
> implementation.
> 
> For the high resolution implementation we have to move the expired
> timers to a seperate list, as we do not want to do complex callback
> functions from the event interrupt itself. But we have to reprogramm the
> next event interrupt, so we need simple access to the timer which
> expires first.
> 
> The initial implementation did simply move the timer from the pending
> list to the expired list without doing the rb_tree removal inside of the
> event interrupt handler. That way the next event for reprogramming was
> the first event in the pending list.
> 
> The new rebased version with the pending list removed does the rb_tree
> removal inside the event interrupt and enqueues the timer, for which the
> callback function has to be executed in the softirq, to the expired
> list. One exception are simple wakeup callback functions, as they are
> reasonably fast and we save two context switches. The next event for
> reprogramming the event interrupt is retrieved by the pointer in the
> base structure.
> 
> This way the list head is only necessary for the high resolution case.
> 
> The state field is not removed

Oops, I somehow managed to remove the rest of this paragraph :(

The state field is not removed because I'm not a big fan of those
overloaded fields and I prefer to pay the 4 byte penalty for the
seperation.
Of course if there is the absolute requirement to reduce the size, I'm
not insisting on keeping it.

	tglx


