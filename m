Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317102AbSH0UhS>; Tue, 27 Aug 2002 16:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317107AbSH0UhS>; Tue, 27 Aug 2002 16:37:18 -0400
Received: from chaos.analogic.com ([204.178.40.224]:130 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S317102AbSH0UhR>; Tue, 27 Aug 2002 16:37:17 -0400
Date: Tue, 27 Aug 2002 16:44:34 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: yodaiken@fsmlabs.com
cc: Mark Hounschell <markh@compro.net>,
       "Wessler, Siegfried" <Siegfried.Wessler@de.hbm.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: interrupt latency
In-Reply-To: <20020827135400.A31990@hq.fsmlabs.com>
Message-ID: <Pine.LNX.3.95.1020827160243.11549A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Aug 2002 yodaiken@fsmlabs.com wrote:

> On Tue, Aug 27, 2002 at 02:01:43PM -0400, Richard B. Johnson wrote:
> > This cannot be. A stock kernel-2.4.18, running a 133 MHz AMD-SC520,
> > (like a i586) with a 33 MHz bus, handles interrupts off IRQ7 (the lowest
> > priority), from the 'printer port' at well over 75,000 per second without
> > skipping a beat or missing an edge. This means that latency is at least
> > as good as 1/57,000 sec = 0.013 microseconds.
> 
> Assuming you mean 75,000 then ... 
> Thats 0.013 MILLISECONDS which is 13 microseconds and its not likely.

Yes 13 microseconds.

> I bet that your data source drops data or looks at some handshake
> pins on the parallel connect.
> 

No. You can easily read into memory 75,000 bytes per second from the
parallel port, hell RS-232C will do 22,400++ bytes per second (224,000
baud) on a Windows machine, done all the while to feed a PROM burner. I
never measured Linux RS-232C, but it's got to be at least as good.

On a faster machine, i.e., an ordinary 400 MHz Pentium, we have a
complete Tomographic Imaging machine that gets triggers from the
parallel port.

Off the parallel port, hardware writes a byte and sets the interrupt
line. There is no hand-shake with incoming data. It comes off a
trigger board that will generate between 50 and 80 thousand
triggers per second, depending upon some wheel speed. FYI, these
triggers mark the position at which an X-Ray beam generated image
data. If we missed a trigger, we end up losing a whole ray of
image data, which would be a mess.

Software reads then writes the byte into memory and executes 
wake_up_interruptible() for somebody sleeping in poll(). There is a
fixed-length circular buffer with no dynamic allocation. This is
the only thing that could possibly make it fast.

At the same time, a high-speed data-link, interfacing to the PCI/Bus
gets 2k of data per trigger so the machine is not exactly idle
when the triggers are coming into the parallel port. Software
correlates the trigger data with the image data as part of a
tomographic reconstruction.

That's 2048 * 80,000 = ~163 MB/s over the PCI with 80,000 b/s over
the parallel port at the same time. We originally had a hardware
"funnel" to combine 4 bytes before generating an interrupt. This
turned out to be a synchronization nightmare and was scrapped once
it was found that Linux interrupted fast enough.

Make a simple module, create an ISR off the printer port, enable
the printer port (hardware) interrupt line, then use a function
generator to toggle the printer port interrupt line. You can then
do all kinds of diagnostics to find out the max rate you can
interrupt --and the maximum amount of code you can use in that
ISR before you get overruns. This is what I did before I ever
signed up to use a ^$@^$!(-@ printer-port for something important.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

