Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261585AbULNRrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbULNRrE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 12:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbULNRmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 12:42:53 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:61025 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261576AbULNRmI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 12:42:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=iP5zmEwM+I2ADORohbOa6WWJvx194grzSznuZ8PPRdDhhVzNbi65B47EorHHZjGyzBdLdqz9RLph7jcZefkMqfVhz0YqtRKpbHsVQLh3NjlbeDI9EXc0NGT3flF5/pH5R7G+W+4yx+O4m9d1qPdtHjGqar8pX6BBsGyst836saE=
Message-ID: <29495f1d04121409422add6024@mail.gmail.com>
Date: Tue, 14 Dec 2004 09:42:02 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: dynamic-hz
Cc: linux-os@analogic.com, Andrew Morton <akpm@osdl.org>, kernel@kolivas.org,
       pavel@suse.cz, linux-kernel@vger.kernel.org
In-Reply-To: <20041214171503.GG16322@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041211142317.GF16322@dualathlon.random>
	 <20041212222312.GN16322@dualathlon.random>
	 <41BCD5F3.80401@kolivas.org> <20041213030237.5b6f6178.akpm@osdl.org>
	 <20041213111741.GR16322@dualathlon.random>
	 <20041213032521.702efe2f.akpm@osdl.org>
	 <29495f1d041213195451677dab@mail.gmail.com>
	 <Pine.LNX.4.61.0412140914360.13406@chaos.analogic.com>
	 <29495f1d041214085457b8c725@mail.gmail.com>
	 <20041214171503.GG16322@dualathlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Dec 2004 18:15:03 +0100, Andrea Arcangeli <andrea@suse.de> wrote:
> On Tue, Dec 14, 2004 at 08:54:29AM -0800, Nish Aravamudan wrote:
> > Hmm, schedule_timeout(0) working that way is interesting. There is
> > also the option to use schedule_timeout(MAX_SCHEDULE_TIMEOUT) which
> > should sleep indefinitely (depending of course on the conditions of
> > the state). Oh but I think I understand what you're saying... the
> > driver needs to sleep indefinitely in total (potentially), but needs
> > to be able to return quite often (like yield() used to) so they could
> > check a condition...
> >
> > Thanks for the input!
> 
> what do you mean like yield() used to? yield() is still there in latest
> 2.6, just call yield() and you'll get the same effect of sched_yield in
> userspace. yields in the kernel are a bad thing though (they usually
> mean code is not well written, code should be event driven not polled
> driven).

Sorry for my lack of clarity :) I was referring more to the second
part of what you said, that the "meaning" of yield() changed for 2.6
and thus shouldn't be used to wait for short times (see kerneljanitors
TODO reference from Matthew Wilcox (search for yield in page):
http://www.kerneljanitors.org/TODO).
 
> Note that __set_current_state(..); schedule_timeout(0) is not like
> yield. yield will return immediatly if it's the only task running. A
> yielding loop will consume all available cpu, while the
> schedule_timeout(0) will wait less than 1/HZ sec. But really
> schedule_timeout(0) makes little sense, either use schedule_timeout(1)
> and explicitly wait 1msec, or use yield. schedule_timeout(0) just
> happens to work because the timer code has to approximate for excess and
> it will wait for the next timer irq for timeouts <= 0 and it will wait
> for two ticks for timeouts == 1 etc...

>From the context of the TODO, it seems yield() and schedule_timeout()
should not be considered alternatives for each other. Maybe someone
can clarify?

> I guess we could change schedule_timeout() to WARN_ON if 0 is being
> passed to it.

I will see if anyone is actually calling with 0 -- I don't remember
seeing this for my previous sets of patches, but it may happen if HZ
changes in value.

-Nish
