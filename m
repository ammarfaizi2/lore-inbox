Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbWGKJGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbWGKJGa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 05:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWGKJGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 05:06:30 -0400
Received: from sunrise.pg.gda.pl ([153.19.40.230]:13778 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP id S1750787AbWGKJG3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 05:06:29 -0400
Date: Tue, 11 Jul 2006 11:08:10 +0200
From: Adam =?ISO-8859-2?B?VGxhs2th?= <atlka@pg.gda.pl>
To: Jaroslav Kysela <perex@suse.cz>
Cc: rlrevell@joe-job.com, galibert@pobox.com, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [Alsa-devel] OSS driver removal, 2nd round (v2)
Message-Id: <20060711110811.947e15ed.atlka@pg.gda.pl>
In-Reply-To: <Pine.LNX.4.61.0607110937160.9147@tm8103.perex-int.cz>
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
Organization: Gdansk University of Technology
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2006 09:58:26 +0200 (CEST)
Jaroslav Kysela <perex@suse.cz> wrote:

> On Tue, 11 Jul 2006, Adam Tla³ka wrote:
> 
> > On Mon, 10 Jul 2006 20:39:03 -0400
> > Lee Revell <rlrevell@joe-job.com> wrote:
> > 
> > > On Tue, 2006-07-11 at 01:59 +0200, Olivier Galibert wrote:
> > > > ALSA lib has something like 7 different methods just to play a sound.
> > > > Their view of "low level" is quite interesting.  Using it is pure
> > > > hell.  Debugging what you've done is worse.  And don't bother to hope
> > > > that your code will still work in six months.
> > > > 
> > > 
> > > A small FAQ:
> > > 
> > > Q: But OSS is kewl and ALSA sucks!
> > > A: The decision for the OSS->ALSA move was four years ago.
> > >    If ALSA sucks, please help to improve ALSA.
> > 
> > The problem is that ALSA is done a Windows way with too many not always 
> > working ways of obtaining sound and lack of user docs. So there is still 
> 
> The docs are available: 
> http://www.alsa-project.org/alsa-doc/alsa-lib/pcm.html
> 
> If you have some comment or idea to improve it, please, post it to 
> the relevant mailing list.
>

I posted some ideas in the past but with current design it's no go.
 
> > the general question: Is it the proper way? How I can help improve ALSA 
> > if I just dislike its design?
> 
> Then it is your problem. I've not seen a single problematic technical 
> information from your mails.

Pity. Me and probably many users have this problem.

> 
> > I spent some time improving dmix and aoss in the past. I have a version 
> > of aoss which uses callbacks and works properly with some not properly 
> > written OSS apps. It's very interesting that with some apps aoss method 
> > gives better sound A/V synchronization then using native ALSA app 
> > support ;-). But callbacks not always work and LD_PRELOAD method is 
> > generally not secure and some kind of a hack. So I just don't think it 
> > could be improved with it's current design. In my opinion it should work 
> > out of the box without need to rewrite old or proprietary apps and 
> > messing with LD_PRELOAD. So /dev/dsp compatibility is a must. But with 
> > all input/output mixing of course. Userspace thread method leads to many 
> > problems - swapping and rescheduling leads to bad acustic effects. Of 
> > course if an app can't supply data when it should we can't do anything 
> > but if scheduling or swapping causes problems the design seems to be 
> > bad.
> >
> > There are many devices which need to be served at the some critical 
> > point in time
> > - sound cards, video and tv grabbers, some dedicated lab cards, i/o 
> >   ports etc.  Generally on the really low level this is a kernel driver 
> >   which sticks to the hardware and should ``know'' how critical is to 
> >   serve hw requests just in time. If we have data in a buffer programing 
> >   DMA transfer is a quite quick operation but must be done at the proper 
> >   moment.  So maybe we should delay a bit other io for example and just 
> >   do it. But it must be done in kernel because kernel should know these 
> >   critical time parameters for all devices in the system and decide 
> >   which to serve and when. Maybe this is not needed for all devices but 
> >   for audio/video devices it's a must. Better kernel support for these 
> >   kind of devices is absolutely needed.
> 
> You're a bit mixing things:
> 
> a) we're not trying to be more compatible than OSS code in kernel, if you 
>    like to do the mixing in kernel, simply write a new ALSA lowlevel 
>    driver which will do it; I'm sure when the quality of your code will be 
>    good,  we'll include it to the ALSA tree, but we are not going this
>    way unless someone else will maintain this code

OSS kernel compatibility is only partial and aoss method is not fully compatible either
I will try to write some code but I have very little free time for that so I am trying
to convince people to rethinking the case 
 
> b) you're requestion to avoid scheduler participation in the audio 
>    processing and yes, we have this solution already (dmix), but not in 
>    kernel

just the contrary - scheduler participation is needed to avoid sound distortion
and missing samples 

> c) as you said, the kernel should contain only critical code to drive
>    hardware, sample rate conversion, sample format conversions and so on
>    are NOT part of this code in my opinion

if doing this operations behind application back can lead to not delivering
data to kernel driver in time then these are time critical operations too!

> 
> > ALSA in lib way has its limitations and drawbacks and adding more 
> > feaures this way leads to more complications only IMHO.
> 
> Which limitations? We can do all things like OSS API. The whole point of 
> all problems is that OSS has the API entry point in syscalls which is 
> quite bad so the redirection is problematic.

Yes but what a complicated way. And you cannot use kernel OSS emulation
and ALSA aware apps at the same time. Also aoss with dmix are in
conflict with jackd for example.

Kernel redirector is not a bad solution - there should be some kind
of interface for such redirectors for different purposes. netlink device maybe?
For example you should redirect all these traffic to some RT daemon
doing all job.

Same with filesystem redirections. I hate these special gnomevfs or kdeio
helpers which forces to rebuilding apps with more and more libs.
Change LD_PRELOAD or LD_LIBRARY_PATH and you app will go to hell.
This is the Windows way of doing uncontrolled mess.
This plugin architecture without mandatory kernel access control leads
to serious security risc.

Regards
-- 
Adam Tla³ka       mailto:atlka@pg.gda.pl    ^v^ ^v^ ^v^
Computer Center,  Gdañsk University of Technology, Poland
PGP public key:   finger atlka@sunrise.pg.gda.pl
