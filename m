Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274337AbRJEXF0>; Fri, 5 Oct 2001 19:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274351AbRJEXFQ>; Fri, 5 Oct 2001 19:05:16 -0400
Received: from smi-105.smith.uml.edu ([129.63.206.105]:47110 "HELO
	buick.pennace.org") by vger.kernel.org with SMTP id <S274337AbRJEXFC>;
	Fri, 5 Oct 2001 19:05:02 -0400
Date: Fri, 5 Oct 2001 19:05:23 -0400
From: Alex Pennace <alex@pennace.org>
To: Bernd Eckenfels <ecki@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Desperately missing a working "pselect()" or similar...
Message-ID: <20011005190523.A6516@buick.pennace.org>
Mail-Followup-To: Bernd Eckenfels <ecki@lina.inka.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3BBDD37D.56D7B359@isg.de> <E15pbid-0007fi-00@calista.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15pbid-0007fi-00@calista.inka.de>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2001 at 10:36:53PM +0200, Bernd Eckenfels wrote:
> In article <3BBDD37D.56D7B359@isg.de> you wrote:
> > Without a proper pselect() implementation (the one in glibc is just
> > a mock-up that doesn't prevent the race condition) I'm currently
> > unable to come up with a good idea on how to wait on both types
> > of events.
> 
> Isnt select() returning with EINTR?

The select system call doesn't return EINTR when the signal is caught
prior to entry into select.

The problem is if you have a select loop and small signal handlers
setting flags for the loop, a signal could come in after the flag is
tested but before select is called. Instead of acting on this signal
right away, the process blocks in select.

The pselect system call offers a solution. The process blocks signals
in the select loop; pselect unblocks those signals and does a
select. The race condition mentioned earlier disappears: the signal
that arrives after the flag test is blocked. The pselect system call
unblocks the signal, so the deferred signal acts just like it arrived
while the process is blocked in select.

> > A somewhat bizarre solution would be to have the process create
> > a pipe-pair, select on the reading end, and let the signal-handler
> > write a byte to the pipe - but this has at least the drawback
> > you always spoil one "select-cycle" for each signal you get
> 
> Well, you can use the pipe instead of the signal. What kind of signal do you
> try to trap? Looks like you want to do critical high load stuff with a
> signal.

He just wants to handle signals properly 100% of the time.
