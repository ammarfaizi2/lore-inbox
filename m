Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751058AbWGKL2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbWGKL2X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 07:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbWGKL2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 07:28:22 -0400
Received: from sunrise.pg.gda.pl ([153.19.40.230]:21488 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP id S1751043AbWGKL2G convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 07:28:06 -0400
Date: Tue, 11 Jul 2006 13:29:46 +0200
From: Adam =?ISO-8859-2?B?VGxhs2th?= <atlka@pg.gda.pl>
To: Jaroslav Kysela <perex@suse.cz>
Cc: rlrevell@joe-job.com, galibert@pobox.com, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [Alsa-devel] OSS driver removal, 2nd round (v2)
Message-Id: <20060711132946.890d7941.atlka@pg.gda.pl>
In-Reply-To: <Pine.LNX.4.61.0607111110280.9147@tm8103.perex-int.cz>
References: <20060707231716.GE26941@stusta.de>
	<p737j2potzr.fsf@verdi.suse.de>
	<1152458300.28129.45.camel@mindpipe>
	<20060710132810.551a4a8d.atlka@pg.gda.pl>
	<1152571717.19047.36.camel@mindpipe>
	<44B2E4FF.9000502@pg.gda.pl>
	<20060710235934.GC26528@dspnet.fr.eu.org>
	<1152578344.21909.12.camel@mindpipe>
	<20060711085952.f1254229.atlka@pg.gda.pl>
	<Pine.LNX.4.61.0607110937160.9147@tm8103.perex-int.cz>
	<20060711110811.947e15ed.atlka@pg.gda.pl>
	<Pine.LNX.4.61.0607111110280.9147@tm8103.perex-int.cz>
Organization: Gdansk University of Technology
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2006 11:52:56 +0200 (CEST)
Jaroslav Kysela <perex@suse.cz> wrote:

> On Tue, 11 Jul 2006, Adam Tla³ka wrote:
> 
> > OSS kernel compatibility is only partial and aoss method is not fully 
> 
> Partial? Elaborate please. And talk about OSS drivers in 2.6 kernel.

I don't remember the case exactly - original OSS as stated in pdf describing
its behaviour locks buffer size after some ioctls. So you can't change parameters
unless you do reset or reopen the device. aoss does it differently.
Also aoss has no mixer ioctls working with audio stream fd implemented.

> > > b) you're requestion to avoid scheduler participation in the audio 
> > >    processing and yes, we have this solution already (dmix), but not in 
> > >    kernel
> > 
> > just the contrary - scheduler participation is needed to avoid sound 
> > distortion and missing samples
> 
> Nope. You're missing that dmix does not add any extra latencies, because
> samples are written directly to the DMA buffer.

That is true but it is a process (thread exactly but in Linux world it is a special kind of process) so it can be scheduled down or swapped off.
 
> > > c) as you said, the kernel should contain only critical code to drive
> > >    hardware, sample rate conversion, sample format conversions and so on
> > >    are NOT part of this code in my opinion
> > 
> > if doing this operations behind application back can lead to not delivering
> > data to kernel driver in time then these are time critical operations too!
> 
> Sorry, but you have limited resources (CPU power). It's completely 
> irrelevant, if you do processing in the user space or in kernel (in my 
> opinion it's even worse to do such things in the interrupt context).
> It's probably better to think how to instruct scheduler to wake up
> the sound applications as soon as possible.

If I have enough resources to do this in kernel space and obtain good results
why not do it?

> > > > ALSA in lib way has its limitations and drawbacks and adding more 
> > > > feaures this way leads to more complications only IMHO.
> > > 
> > > Which limitations? We can do all things like OSS API. The whole point of 
> > > all problems is that OSS has the API entry point in syscalls which is 
> > > quite bad so the redirection is problematic.
> > 
> > Yes but what a complicated way. And you cannot use kernel OSS emulation
> > and ALSA aware apps at the same time. Also aoss with dmix are in
> > conflict with jackd for example.
> 
> ??? Elaborate. It should work.

There was reports of jack mixing problems with dmix active. Proposed solution was to use jack attached directly to alsa hw device and not to the default.

> 
> > Kernel redirector is not a bad solution - there should be some kind of 
> > interface for such redirectors for different purposes. netlink device 
> > maybe? For example you should redirect all these traffic to some RT 
> > daemon doing all job.
> 
> I would prefer probably a network lowlevel ALSA driver. You'll get the 
> network transparency as benefit.
>

Quite nice conception.
 
> > Same with filesystem redirections. I hate these special gnomevfs or kdeio
> > helpers which forces to rebuilding apps with more and more libs.
> > Change LD_PRELOAD or LD_LIBRARY_PATH and you app will go to hell.
> > This is the Windows way of doing uncontrolled mess.
> > This plugin architecture without mandatory kernel access control leads
> > to serious security risc.
> 
> Unfortunately, more functionality requires more code. You have to deal 
> with bloating the user or kernel space.

Of course.

As I said it could be done by a small kernel message passing redirector connected
to a bloated user space RT process which does the rest. But some kernel support for proper waking up, rescheduling etc. is a must.

Regards
-- 
Adam Tla³ka       mailto:atlka@pg.gda.pl    ^v^ ^v^ ^v^
Computer Center,  Gdañsk University of Technology, Poland
PGP public key:   finger atlka@sunrise.pg.gda.pl
