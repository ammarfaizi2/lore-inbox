Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266674AbUIAS5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266674AbUIAS5O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 14:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266730AbUIAS5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 14:57:13 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:12513 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266674AbUIAS5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 14:57:08 -0400
Subject: Re: [Unichrome-devel] Dragging window in
	X	causes	soundcard	interrupts to be lost
From: Lee Revell <rlrevell@joe-job.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1091317027.7443.29.camel@localhost.localdomain>
References: <1089952196.25689.7.camel@mindpipe>
	 <40F78D21.10305@shipmail.org>  <40F793C1.2080908@shipmail.org>
	 <1090001316.27995.3.camel@mindpipe>  <40F8298E.8080508@shipmail.org>
	 <1090010147.30435.2.camel@mindpipe> <1090107507.10795.1.camel@mindpipe>
	 <40FA3AEC.9050906@shipmail.org> <1090190244.22282.8.camel@mindpipe>
	 <40FB0092.3070800@shipmail.org>  <1091319939.20819.67.camel@mindpipe>
	 <1091317027.7443.29.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1094065029.1970.32.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 01 Sep 2004 14:57:10 -0400
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-07-31 at 19:37, Alan Cox wrote:
> On Sul, 2004-08-01 at 01:25, Lee Revell wrote:
> > Do you have the original driver source from VIA handy?  This is looking
> > more and more like a hardware bug - 2D acceleration engine activity
> > causes interrupts from the PCI slot to be disabled for long periods. 
> 
> I do. There is no code in the 2D engine that touches interrupt control
> at all. 
> 
> > Maybe it disables interrupts to prevent other processes writing to the
> > shared video/system RAM as it DMAs.  I would like to verify that the
> > problem still occurs with their driver, before I try to convince them
> > there's a hardware issue with the EPIA boards.
> 
> A similar problem occurs with some other chips when you write enough
> data to the chip that the FIFO fills and the PCI bus locks until the
> write can complete. Various vendors implemented this at one point for
> benchmarketing reasons and that would have a similar effect if so.
> 
> The 2D driver source is essentially the same as the source in Xorg CVS
> barring cleanups and the accelerator code has not changed at all. You
> might want to take a look at the fifo management side of things in that
> code.

OK, turns out that my (and your, and Thomas Hellstrom, the Unichrome
maintainer's) theory was correct - this is exactly what is happening:

On Wed, 2004-09-01 at 03:53, Thomas Hellström wrote: 
> 
> I've think I've found an answer to this, and it seems to be related to
> what I mentioned earlier, namely that any attemt to write over PCI to a
> busy video engine will halt the processor until the video accepts new
> data.
> 
> The wait-for-idle loop seems only to be used as a flush-and-sync, to make
> sure that accelerated rendering has completed. There is probably no check
> for ongoing engine activity before writing to the 2d engine. Same as for
> VIA's own mpeg2 code. Such a check will be implemented and will cause a
> very slight overhead compared to today's code.
> 
> I'm starting to fix this as part of compatibility with the new drm with
> AGP DMA transfers, when available. This will not go into "production" for
> about least two or three weeks, but if you are interested, I could send
> you an updated via_accel.c sooner to see if it cures your problem.
> 
> Regards
> Thomas
> 

So, it looks like vendors are still up to the same tricks...

Lee


