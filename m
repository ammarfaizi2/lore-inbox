Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030305AbWJTUzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030305AbWJTUzW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 16:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946498AbWJTUzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 16:55:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62178 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946481AbWJTUzU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 16:55:20 -0400
Date: Fri, 20 Oct 2006 13:54:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: tglx@linutronix.de, teunis <teunis@wintersgift.com>,
       linux-kernel@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>
Subject: Re: various laptop nagles - any suggestions?   (note:
 2.6.19-rc2-mm1 but applies to multiple kernels)
Message-Id: <20061020135450.6794a2bb.akpm@osdl.org>
In-Reply-To: <20061020203731.GA22407@elte.hu>
References: <4537A25D.6070205@wintersgift.com>
	<20061019194157.1ed094b9.akpm@osdl.org>
	<4538F9AD.8000806@wintersgift.com>
	<20061020110746.0db17489.akpm@osdl.org>
	<1161368034.5274.278.camel@localhost.localdomain>
	<20061020112627.04a4035a.akpm@osdl.org>
	<1161370015.5274.282.camel@localhost.localdomain>
	<20061020121537.dea13469.akpm@osdl.org>
	<20061020203731.GA22407@elte.hu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2006 22:37:31 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > > > I don't know how many machines will be affected by this, but I'd 
> > > > expect it's quite a few - the Vaio has a less-than-one-year-old 
> > > > Intel CPU in it.
> > > 
> > > Is this still the broken lapic issue ?
> > 
> > yup.  iirc the standard FC5 SMP kernel runs dog-slowly on that machine 
> > too.
> 
> hm. This is how lapic timer calibration works.
> 
> the lapic timer is really simple - it counts down from a value and 
> generates an irq if that counter reaches 0. Then it starts counting down 
> again.
> 
> the 'count down from' value is programmed via __setup_APIC_LVTT().
> 
> we first write a 'really large' number into it (1 billion):
> 
>         __setup_APIC_LVTT(1000000000);
> 
> the unit of counting is '16 system bus cycles'.
> 
> i.e. if your system has a system bus of 333 MHz, then a value of 1 
> billion takes 48 seconds to count down. (so the calibration ought to be 
> pretty robust in this regard.)
> 
> then we use the wait_timer_tick() function, which waits until the PIT 
> counter reaches 0 (which is attached to the PIT whose frequency we know 
> and thus the PIT is already programmed correctly). Hence by calling 
> wait_timer_tick() we can generate a delay of one jiffy - and we can read 
> out the current lapic timer count and determine the calibration factor.
> 
> then we calculate the result as:
> 
>         result = (tt1-tt2)*APIC_DIVISOR/LOOPS;
> 
> where tt1 is the counter before we start calibration, tt2 is the lapic 
> timer counter after we did calibration. (APIC_DIVISOR is 16)
> 
> i dont see where the error is - but there must be some calibration 
> problem as your system shows a systematic 1:60 difference between 
> expected and real lapic timer frequency.
> 

Oh.  I thought the problem was that the timer stops when the CPU is idle. 
Maybe I misremembered.  I'll try `idle=poll'.
