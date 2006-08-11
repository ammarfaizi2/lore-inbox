Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750902AbWHKIqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbWHKIqU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 04:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750903AbWHKIqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 04:46:20 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:18310
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S1750897AbWHKIqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 04:46:19 -0400
Date: Fri, 11 Aug 2006 01:46:03 -0700
To: Esben Nielsen <nielsen.esben@gogglemail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Robert Crocombe <rcrocomb@gmail.com>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhltc@us.ibm.com>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: [Patch] restore the RCU callback to defer put_task_struct() Re: Problems with 2.6.17-rt8
Message-ID: <20060811084603.GA27068@gnuppy.monkey.org>
References: <e6babb600608012237g60d9dfd7ga11b97512240fb7b@mail.gmail.com> <1154541079.25723.8.camel@localhost.localdomain> <e6babb600608030448y7bb0cd34i74f5f632e4caf1b1@mail.gmail.com> <1154615261.32264.6.camel@localhost.localdomain> <20060808025615.GA20364@gnuppy.monkey.org> <20060808030524.GA20530@gnuppy.monkey.org> <Pine.LNX.4.64.0608090050500.23474@frodo.shire> <20060810021835.GB12769@gnuppy.monkey.org> <20060811010646.GA24434@gnuppy.monkey.org> <Pine.LNX.4.64.0608111010420.11448@frodo.shire>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0608111010420.11448@frodo.shire>
User-Agent: Mutt/1.5.11+cvs20060403
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2006 at 10:16:56AM +0200, Esben Nielsen wrote:
> On Thu, 10 Aug 2006, Bill Huey wrote:
...
> >This extends the mmdrop logic with desched_thread() to also handle 
> >free_task() requests as well. I believe this address your concerns and
> >I'm open to review of this patch.

> Without applying the patch and only skimming it it looks like what Paul 
> and I concluded :-)
> 
> But is there really no generic way of defering this kind of thing? It 
> looks like a hell of a lot work where a kind of "message" infrastructure 
> could have solved it in a few lines.

You can composite it out of a generic kernel APIs to fake it or special
case these things so it behaves like a message. Doing it this way also 
cleaned up the code a bit. Messaging also wouldn't have directly solved
the per-CPU aspects of this reaping, so this was the right facility to
use. The only question left in my mind is the proper choice of priority
for that thread.

Another note, the schedule() path is shorten by this as well since this
deallocation and reaping stuff (calling to the mm system) was done with
preemption turned off and inline to the child itself exiting. This patch
should help shorted the maximal schedule path. It's one of the last
remining long paths like this in the kernel. It seems to be an all
around win if I'm not mistaken.

bill

