Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267788AbUHPPla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267788AbUHPPla (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 11:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267787AbUHPPkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 11:40:43 -0400
Received: from mail.joq.us ([67.65.12.105]:219 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S267788AbUHPPdl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 11:33:41 -0400
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, Takashi Iwai <tiwai@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Scott Wood <scott@timesys.com>,
       jackit-devel <jackit-devel@lists.sourceforge.net>
Subject: Re: [Jackit-devel] Re: [patch] voluntary-preempt-2.6.8-rc2-M5
References: <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu>
	<20040729222657.GA10449@elte.hu> <1091141622.30033.3.camel@mindpipe>
	<20040730064431.GA17777@elte.hu> <1091228074.805.6.camel@mindpipe>
	<s5hfz75sh30.wl@alsa2.suse.de> <1091847265.949.8.camel@mindpipe>
	<s5h8ycfbc5c.wl@alsa2.suse.de>
	<1092652981.13981.11.camel@krustophenia.net>
	<20040816104811.GA24747@elte.hu>
	<1092653547.13981.15.camel@krustophenia.net>
	<1092654488.13981.20.camel@krustophenia.net>
From: "Jack O'Quin" <joq@io.com>
Date: 16 Aug 2004 10:33:45 -0500
In-Reply-To: <1092654488.13981.20.camel@krustophenia.net>
Message-ID: <87n00vcd2e.fsf@sulphur.joq.us>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> writes:

> On Mon, 2004-08-16 at 06:52, Lee Revell wrote:
> > On Mon, 2004-08-16 at 06:48, Ingo Molnar wrote:
> >  if the former then does jackd set itself up (does an mlockall, etc.) 
> > > before it opens the audio device? If the audio device has an event for
> > > jackd the moment the device is opened, and jackd opens the audio device
> > > early during startup, then jackd might not be able to process this event
> > > until it has started up (which can take milliseconds).
> > 
> > This is probably what is happening, the kernel-side issue seems fixed,
> 
> It looks like this is what happens - jackd calls snd_pcm_start, then
> does several other thinks like malloc'ing memory for the array of fd's
> to poll() before entering the polling loop, by which time there has been
> data ready for a while.  This may or may not be worth fixing, I am
> adding jackit-devel to the cc: list.

Yep.  This looks like a bug to me.  While jackd, itself, seems to
allocate everything before calling driver->start(), the ALSA driver
internally calls malloc() *after* calling snd_pcm_start().  I doubt
anyone has ever made a concerted effort to clean up this path for
realtime safety.

I think it should be fixed (I need to study the code in more detail).
There's probably nothing to prevent us moving the free() and malloc()
calls up nearer the top of alsa_driver_start().  That will probably
require an extra error test and free in case snd_pcm_start() fails.
-- 
  joq
