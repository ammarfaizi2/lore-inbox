Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293655AbSCKJq3>; Mon, 11 Mar 2002 04:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293656AbSCKJqU>; Mon, 11 Mar 2002 04:46:20 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:49422 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S293655AbSCKJqN>;
	Mon, 11 Mar 2002 04:46:13 -0500
Date: Mon, 11 Mar 2002 10:44:45 +0100
From: Jens Axboe <axboe@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] BUG check in elevator.c:237
Message-ID: <20020311094445.GC31108@suse.de>
In-Reply-To: <Pine.LNX.4.44.0203081258500.5383-100000@netfinity.realnet.co.sz> <3C88A796.2070301@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C88A796.2070301@evision-ventures.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08 2002, Martin Dalecki wrote:
> After having a look at the oops I think that this may be very well a
> symptom of another problem in the ide-cd.c drivers overall
> way of working. Please let me elaborate a bit.
> 
> In ide.c there is one central interrupt handler, namely:
> 
> void ide_timer_expiry(unsigned long data)
> 
> This function is called upon finish of every command.

Eh? ide_timer_expiry is the timer handler called if a interrupt timeout
occurs.

> However for cd-rom there are commands, which can
> take quite a long time. Therefore there is the possiblity there
> to provide a polling function, which will be engaged after the
> interrupt happens in the above function:
> 
> 	/* continue */
> 				if ((wait = expiry(drive)) != 0) {

[snip]

That's nonsense too. I added the expiry hook to let lower levels decide
what should happen when an interrupt timeout occurs. So there's been
_no_ interrupt if we enter this from the timer handler.

> And plase guess whot? CD-ROM is the only driver which is using
> this facility. Please have a look at the last

Right, it was added to handle long commands like format unit etc.

> argument of ide_set_handler(). The second argument is the
> interrutp handler for a command. The third is supposed to be
> the poll timerout function. But if you look at the
> actual poll function found in ide-cd.c (and only there).
> You may as well feel to try to just execute its commands directly in
> ide_timer_expiry, thus reducing tons of possible races ind the
> overall intr handling found currently there.

I don't know what tangent you are going off on here, I think you should
re-read this code a lot more carefully. There's no polling going on
here.

-- 
Jens Axboe

