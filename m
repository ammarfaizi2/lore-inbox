Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbULNDyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbULNDyu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 22:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbULNDyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 22:54:49 -0500
Received: from rproxy.gmail.com ([64.233.170.207]:43338 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261292AbULNDyV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 22:54:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=NZtYzGPSkBFWw2LGJqEqwnOjPYP24QP6mVwWP8eOmNhTufG71AZFRIbvJkzeWH9CzNdHnYr1jIOiglVZYjWvxvK7HqI/NE7nRWJdrBwd9CgNYdlkEgAtNp9Lzc2AcFJR8TNWkoEDn5lCBX817U9Gh/tOkGUw3jm6aIL2SG0kTxg=
Message-ID: <29495f1d041213195451677dab@mail.gmail.com>
Date: Mon, 13 Dec 2004 19:54:19 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: dynamic-hz
Cc: Andrea Arcangeli <andrea@suse.de>, kernel@kolivas.org, pavel@suse.cz,
       linux-kernel@vger.kernel.org
In-Reply-To: <20041213032521.702efe2f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041211142317.GF16322@dualathlon.random>
	 <20041212163547.GB6286@elf.ucw.cz>
	 <20041212222312.GN16322@dualathlon.random>
	 <41BCD5F3.80401@kolivas.org> <20041213030237.5b6f6178.akpm@osdl.org>
	 <20041213111741.GR16322@dualathlon.random>
	 <20041213032521.702efe2f.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2004 03:25:21 -0800, Andrew Morton <akpm@osdl.org> wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > The patch only does HZ at dynamic time. But of course it's absolutely
> >  trivial to define it at compile time, it's probably a 3 liner on top of
> >  my current patch ;). However personally I don't think the three liner
> >  will worth the few seconds more spent configuring the kernel ;).
> 
> We still have 1000-odd places which do things like
> 
>         schedule_timeout(HZ/10);

Yes, yes, we do :) I replaced far more than I ever thought I could...
There are a few issues I have with the remaining schedule_timeout()
calls which I think fit ok with this thread... I'd especially like
your input, Andrew, as you end up getting most of my patches from KJ.

Many drivers use

set_current_state(TASK_{UN,}INTERRUPTIBLE);
schedule_timeout(1); // or some other small value < 10

This may or may not hide a dependency on a particular HZ value. If the
code is somewhat old, perhaps the author intended the task to sleep
for 1 jiffy when HZ was equal to 100. That meants that they ended up
sleeping for 10 ms. If the code is new, the author intends that the
task sleeps for 1 ms (HZ==1000). The question is, what should the
replacement be?

If they really meant to use schedule_timeout(1) in the sense of
highest resolution delay possible (the latter above), then they
probably should just call schedule() directly. schedule_timeout(1)
simply sets up a timer to fire off after 1 jiffy & then calls
schedule() itself. The overhead of setting up a timer and the
execution of schedule() itself probably means that the timer will go
off in the middle of the schedule() call or very shortly thereafter (I
think). In which case, it makes more sense to use schedule()
directly...

If they meant to schedule a delay of 10ms, then msleep() should be
used in those cases. msleep() will also resolve the issues with 0-time
timeouts because of rounding, as it adds 1 to the converted parameter.

Obviously, changing more and more sleeps to msecs & secs will really
help make the changing of HZ more transparent. And specifying the time
in real time units just seems so much clearer to me.

What do people think?

-Nish
