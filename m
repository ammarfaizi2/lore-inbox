Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268056AbUHQA7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268056AbUHQA7r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 20:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268057AbUHQA7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 20:59:47 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:17312 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268056AbUHQA7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 20:59:44 -0400
Subject: Re: [Jackit-devel] Re: [patch] voluntary-preempt-2.6.8-rc2-M5
From: Lee Revell <rlrevell@joe-job.com>
To: "Jack O'Quin" <joq@io.com>
Cc: Ingo Molnar <mingo@elte.hu>, Takashi Iwai <tiwai@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Scott Wood <scott@timesys.com>,
       jackit-devel <jackit-devel@lists.sourceforge.net>
In-Reply-To: <87n00vcd2e.fsf@sulphur.joq.us>
References: <20040726124059.GA14005@elte.hu>
	 <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu>
	 <1091141622.30033.3.camel@mindpipe> <20040730064431.GA17777@elte.hu>
	 <1091228074.805.6.camel@mindpipe> <s5hfz75sh30.wl@alsa2.suse.de>
	 <1091847265.949.8.camel@mindpipe> <s5h8ycfbc5c.wl@alsa2.suse.de>
	 <1092652981.13981.11.camel@krustophenia.net>
	 <20040816104811.GA24747@elte.hu>
	 <1092653547.13981.15.camel@krustophenia.net>
	 <1092654488.13981.20.camel@krustophenia.net>
	 <87n00vcd2e.fsf@sulphur.joq.us>
Content-Type: text/plain
Message-Id: <1092704438.13981.125.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 16 Aug 2004 21:00:38 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-16 at 11:33, Jack O'Quin wrote:
> Lee Revell <rlrevell@joe-job.com> writes:
> 
> > On Mon, 2004-08-16 at 06:52, Lee Revell wrote:
> > > On Mon, 2004-08-16 at 06:48, Ingo Molnar wrote:
> > >  if the former then does jackd set itself up (does an mlockall, etc.) 
> > > > before it opens the audio device? If the audio device has an event for
> > > > jackd the moment the device is opened, and jackd opens the audio device
> > > > early during startup, then jackd might not be able to process this event
> > > > until it has started up (which can take milliseconds).
> > > 
> > > This is probably what is happening, the kernel-side issue seems fixed,
> > 
> > It looks like this is what happens - jackd calls snd_pcm_start, then
> > does several other thinks like malloc'ing memory for the array of fd's
> > to poll() before entering the polling loop, by which time there has been
> > data ready for a while.  This may or may not be worth fixing, I am
> > adding jackit-devel to the cc: list.
> 
> Yep.  This looks like a bug to me.  While jackd, itself, seems to
> allocate everything before calling driver->start(), the ALSA driver
> internally calls malloc() *after* calling snd_pcm_start().  I doubt
> anyone has ever made a concerted effort to clean up this path for
> realtime safety.
> 
> I think it should be fixed (I need to study the code in more detail).
> There's probably nothing to prevent us moving the free() and malloc()
> calls up nearer the top of alsa_driver_start().  That will probably
> require an extra error test and free in case snd_pcm_start() fails.

I made this change and it seems to work fine, snd_pcm_start is now the
very last thing that happens in alsa_driver_start, and we free() if
snd_pcm_start fails.

I still get the xruns at startup, but they were ~100ms before, now they
are more like 20ms.  Unfortunately the OO-ness of the code makes it hard
for me to figure out where alsa_driver_start gets called from, so I'm
not sure what else happens before we enter the polling loop.

Lee  

