Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274894AbRJALcL>; Mon, 1 Oct 2001 07:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274890AbRJALcC>; Mon, 1 Oct 2001 07:32:02 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:776 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S274894AbRJALbs>; Mon, 1 Oct 2001 07:31:48 -0400
Date: Mon, 1 Oct 2001 13:32:15 +0200
From: Jan Hudec <bulb@ucw.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: Suggest TASK_KILLABLE state to overcome most D state trouble
Message-ID: <20011001133215.A3007@artax.karlin.mff.cuni.cz>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <20010927202435.A19466@artax.karlin.mff.cuni.cz> <19318.1001624450@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <19318.1001624450@redhat.com>; from dwmw2@infradead.org on Thu, Sep 27, 2001 at 10:00:50PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> bulb@ucw.cz said:
> >  Does a patch adding a TASK_KILLABLE state have a chance to get in (in
> > 2.5)? Or can anybody thik of more elegant solution?
> Often there's kernel state which needs to be kept consistent, and locks
> which need to be released - just bailing out (as if you got an oops) isn't
> sufficient.

No. It's not sufficient. It won't be sufficient even with KILLABLE state.
But the difference between SIGKILL and other signals is, that when you
get SIGKILL, you know, what's going to happen. With other signals, you
don't.

> What's wrong with the plan of just implementing the appropriate cleanup code
> in each buggy or lazy piece of code which sleeps in state
> TASK_UNINTERRUPTIBLE, and letting each be interruptible instead?

There are many situations, that could be interupted with
sigkill (you sent a request, then die from sigkill, so you know the reply
won't matter), while it's difficult to restart after signal, because you
already started a request and if you just started it again, the reply won't
be the same. So it's not about cleanup. But you need to maintain some state
to pass to the restarted syscall. And it's impossible with current signal
handling mechanism (the problem is garbage-collecting the state).

Little different problem is the page-fault, that could immediately occur
again if signal handler was invoked, but on sigkill no handler is run, so
you may safely abort.

--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
