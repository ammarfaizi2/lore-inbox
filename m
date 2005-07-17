Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261783AbVGQCgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbVGQCgx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 22:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbVGQCgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 22:36:52 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:26244 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261783AbVGQCgA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 22:36:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uEwNp6qAeg4Yq5ytWaVIgqG0XeKMNK7s6lkl8hRUfHXk9wBlN0eJixgj3ypFcCOAQLQ+sMt0ibn10LBoLv45R1V7fgOgJR5rUb1aZ01nkyGeAuCVDtm6fZwg85IAzO2GXc8Ws8tTLipFflQ8arPXvT5xeLeo7+oSwNznwmzsVwo=
Message-ID: <29495f1d0507161935218d798@mail.gmail.com>
Date: Sat, 16 Jul 2005 19:35:59 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Cc: Linus Torvalds <torvalds@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
       vojtech@suse.cz, david.lang@digitalinsight.com, davidsen@tmr.com,
       kernel@kolivas.org, linux-kernel@vger.kernel.org, mbligh@mbligh.org,
       diegocg@gmail.com, azarah@nosferatu.za.org, christoph@lameter.com
In-Reply-To: <9a874849050716191324d2f8b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42D3E852.5060704@mvista.com>
	 <20050713134857.354e697c.akpm@osdl.org>
	 <20050713211650.GA12127@taniwha.stupidest.org>
	 <9a874849050714170465c979c3@mail.gmail.com>
	 <1121386505.4535.98.camel@mindpipe>
	 <Pine.LNX.4.58.0507141718350.19183@g5.osdl.org>
	 <42D731A4.40504@gmail.com>
	 <Pine.LNX.4.58.0507142158010.19183@g5.osdl.org>
	 <9a874849050715061247ab4fd8@mail.gmail.com>
	 <9a874849050716191324d2f8b4@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/05, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 7/15/05, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> > On 7/15/05, Linus Torvalds <torvalds@osdl.org> wrote:
> > >
> > > On Fri, 15 Jul 2005, Jesper Juhl wrote:
> > > >
> > > > It's buggy, that I know. setting kernel_hz (the new boot parameter) to
> > > > 250 causes my system clock to run at something like 4-5 times normal
> > > > speed
> > >
> > > 4 times normal. You don't actually make the timer interrupt happen at
> > > 250Hz, so the timer will be programmed to run at the full 1kHz.
> > >
> > Right, that's the basic problem. I increase jiffies at a higher rate
> > but didn't slow the timer interrupt down at the same time.
> >
> > > You also need to actually change the LATCH define (in
> > > include/linux/jiffies.h) to take this into account (there might be
> > > something else too).
> > >
> > [...]
> > > and you might be getting closer.
> > >
> > > Of course, you need to make sure that LATCH is used only after
> > > jiffies_increment is set up. See "setup_pit_timer(void)" in
> > > arch/i386/kernel/timers/timer_pit.c for more details.
> > >
> >
> > Thank you for all the pointers and hints. This is a new area of code
> > for me, so I'll need some time to poke around - the above helps a lot.
> > Unfortunately I won't have any time to work on this today, but I'll
> > see if I can get a working implementation together tomorrow.
> >
> 
> Ok, I'm afraid I'm going to need another hint or two.
> 
> I've been looking at the timer code and getting thoroughly confused.
> I've tried to find out where we actually program the interrupt
> controller to say "this is the frequency I want you to interrupt me
> at", but I can't seem to find it.
> I'm aware that there are multiple possible time sources, and I've been
> looking at the 8259 code, the ioapic code, the hpet code and various
> other bits in arch/i386/kernel/ and arch/i386/kernel/timers/ , but I
> seem to end up getting confused about all the different defines like
> CLOCK_TICK_RATE, ACTHZ, TICK_NSEC, TICK_USEC, etc...
> 
> Where do we actually program the tick rate we want?

As you've seen, I think it depends on the timesource: for the PIT, it
would be arch/i386/kernel/timers/timer_pit.c::setup_pit_timer(). In
that function, you'll notice we outb() the LATCH value. I think there
are similar functions in the other timesources, e.g. the
arch/i386/kernel/apic.c::setup_APIC_timer().

Does that help some?

Thanks,
Nish
