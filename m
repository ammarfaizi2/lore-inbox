Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267436AbUGNQ3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267436AbUGNQ3z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 12:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267445AbUGNQ3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 12:29:55 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:13212 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267436AbUGNQ3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 12:29:50 -0400
Subject: Re: [linux-audio-dev] Re: [announce] [patch]
	Voluntary	Kernel	Preemption Patch
From: Lee Revell <rlrevell@joe-job.com>
To: "The Linux Audio Developers' Mailing List" 
	<linux-audio-dev@music.columbia.edu>
Cc: Takashi Iwai <tiwai@suse.de>, Andrew Morton <akpm@osdl.org>,
       andrea@suse.de, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1089816747.2789.14.camel@mindpipe>
References: <20040712163141.31ef1ad6.akpm@osdl.org>
	 <200407130001.i6D01pkJ003489@localhost.localdomain>
	 <20040712170844.6bd01712.akpm@osdl.org>
	 <20040713162539.GD974@dualathlon.random>
	 <1089744137.20381.49.camel@mindpipe>
	 <20040713142923.568fa35e.akpm@osdl.org>
	 <1089755130.22175.21.camel@mindpipe> <s5hk6x79dk4.wl@alsa2.suse.de>
	 <1089797791.2336.3.camel@mindpipe>  <s5hbriiamq9.wl@alsa2.suse.de>
	 <1089816747.2789.14.camel@mindpipe>
Content-Type: text/plain
Message-Id: <1089822589.2104.27.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 14 Jul 2004 12:29:49 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-14 at 10:52, Lee Revell wrote:
> On Wed, 2004-07-14 at 06:48, Takashi Iwai wrote:
> > At Wed, 14 Jul 2004 05:36:31 -0400,
> > Lee Revell wrote:
> > > 
> > > On Wed, 2004-07-14 at 04:51, Takashi Iwai wrote:
> > > > At Tue, 13 Jul 2004 17:45:30 -0400,
> > > > Lee Revell wrote:
> > > > > 
> > > > > On Tue, 2004-07-13 at 17:29, Andrew Morton wrote:
> > > > > > Lee Revell <rlrevell@joe-job.com> wrote:
> > > > > > >
> > > > > > > Would this explain these?  When running JACK with settings that need
> > > > > > > sub-millisecond latencies, I get them when I generate any load at all on
> > > > > > > the system (typing, switching windows, etc).  I also get lots of these
> > > > > > > if I run JACK from an X terminal, but very few if I run it from a text
> > > > > > > console, even if X is running in the background.
> > > > > > > 
> > > > > > > Jul 13 14:36:16 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:199: Unexpected hw_pointer value [1] (stream = 0, delta: -25, max jitter = 32): wrong interrupt acknowledge?
> > > > > > 
> > > > > > I'm wondering what this message actually means.  "Unexpected hw_pointer
> > > > > > value"?
> > > > > > 
> > > > > > Does this actually indicate an underrun, or is the debug code screwy?
> > > > > 
> > > > > Not sure.  Here is what Takashi had to say about it:
> > > > > 
> > > > > "The message appears when an unexpected DMA pointer is read in the
> > > > > interrupt handler.  Either the handling of irq was delayed more than
> > > > > the buffer size, an irq is issued at the wrong timing, or the DMA
> > > > > pointer reigster is somehow screwed up.
> > > > > 
> > > > > Since you're using quite small buffer, I guess the former case."
> > > > > 
> > > > > My response:
> > > > > 
> > > > > "I thought this was what an XRUN was, when the handling of the irq is
> > > > > delayed more than the buffer size.  Sometimes these messages are
> > > > > associated with XRUNs, sometimes not."
> > > > > 
> > > > > Haven't heard back yet. 
> > > > > 
> > > > > Is it possible that I am simply pushing my hardware past its limits? 
> > > > > Keep in mind this is a 600Mhz C3 processor.
> > > > 
> > > > I think yes.  32 frames / 44.1kHz = 0.725 ms.
> > > > 
> > > 
> > > I am runnign at 48kHz so it's actually 0.666 ms.  But, the average
> > > response is quite good, 20-30 microseconds.  The spikes are infrequent
> > > enought that I think this is achievable.  If not then 64 frames
> > > definitely is.
> > > 
> > > So what is the difference between the above essage and an XRUN?  I
> > > thought an XRUN occurred when the handling of the IRQ is delayed more
> > > than the buffer size.
> > 
> > Yes, XRUN is so.
> > 
> > The message above is not directly related with XRUN.
> > It appears when an unexpected DMA pointer is returned.  This can
> > happen e.g. when the irq handler is called at the wrong timing,
> > or the register returns a bogus value.
> > 
> 
> I am still kind of confused.  It sounds like this is more serious than
> an XRUN.  What would cause this to happen?
> 

OK, I think I understand the distinction.  An XRUN is when a process is
writing (or reading) to a PCM device, the buffer half empty interrupt
occurs, and the interrupt handler runs, which makes the process ready to
run, but the scheduler does not run it in time to write the next block
of data to the buffer.

The "Unexpected hw_pointer" error would occur when the device generates
an interrupt, but there is a delay in running the interrupt handler, and
by the time the interrupt handler runs, the hardware pointer has moved
somewhere we don't expect it to be.  This would occur if we missed an
interrupt, or several, due to interrupts being disabled for longer than
the period size.  So the distinction is scheduler latency vs. interrupt
response latency.

What is the longest that the kernel disables interrupts?  I remember
hearing 500 microseconds, but this was a while back.

Lee

