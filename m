Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751397AbWAEOwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbWAEOwF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbWAEOwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:52:05 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:37036 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1751399AbWAEOwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:52:04 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Heikki Orsila <shd@modeemi.cs.tut.fi>
Subject: Re: [OT] ALSA userspace API complexity
Date: Thu, 5 Jan 2006 14:49:36 +0000
User-Agent: KMail/1.9
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20060105140155.GC757@jolt.modeemi.cs.tut.fi>
In-Reply-To: <20060105140155.GC757@jolt.modeemi.cs.tut.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601051449.36083.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly, trimming CCs is quite rude and makes it very difficult for others to 
address your problems.

On Thursday 05 January 2006 14:01, Heikki Orsila wrote:
> Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> > On Tuesday 03 January 2006 23:10, Tomasz K?oczko wrote:
> > 2) ALSA API is to complicated: most applications opens single sound
> >    stream.
> >
> > FUD and nonsense. I've written many DSP applications and very often I can
> > recycle the same code for use in them.
>
> It's not FUD and it's very true. I've written ALSA support for many
> programs and I still can't remember the tricks that are needed to get
> even basic things working.

They're not really tricks, they're allowing developers to flexibly handle 
cases that they may care about, such as momentary communication problems 
(think USB soundcards, headsets), versus unrecoverable errors. For example, 
the code I wrote handles your example below somewhat more easily:

	// try to play data
	for (i = 0; i < PLAYBACK_RETRIES; i++) {
		if ((err = snd_pcm_writei (card->playback.fd, card->buffer, card->frames)) < 
0) {
			adebug ("Had to re-init playback.\n");
			if ((err = snd_pcm_prepare (card->playback.fd)) < 0)
				return -PCM_PREPARATION_FAILED;
		}
		break;
	}

	// we couldn't reprepare
	if (i == PLAYBACK_RETRIES)
		return -PCM_WRITE_FAILED;

	return ALSA_SUCCESS;

PLAYBACK_RETRIES is arbitrary. Less robust software, or programs that were 
very sensitive to any sort of intermittent unavailability would error out 
immediately, without the for loop.

However, the documentation makes it fairly clear that in the case where a 
writei() fails, you must "re-prepare" the card for PCM IO. This can be 
attempted numerous times before giving up.

I agree that some sort of layman's wrapper might be helpful here, but please 
don't go back to the ways of a crippled OSS API by preventing us from 
handling these cases

> alsa_error_recovery() expands to 30 lines of more logic. This is pretty
> insane considering that libao _only_ writes data to device and does
> nothing else. If ALSA was done properly, the main loop would simply be:

This is ridiculous. Why bother? If libao is so simple, just break out if 
re-preparation fails.

>
>                 err = internal->writei(internal->pcm_handle, ptr, len);
>
>                 /* it's possible that no data was transferred */
>                 if (err == -EAGAIN || err == -EINTR) {
>                         continue;
>                 }
>
> 		if (err < 0) {
> 			/* BAD BAD */
> 		}

This looks suspiciously like what I have above. Clear, simple, non-broken. 
ALSA does it already.

> 	err = alsa_simple_pcm_open(nchannels, sampleformat, samplingrate,
> frames_in_period /* 0 for automated default */ ); err =
> alsa_simple_writei(); /* handless signal brokeness automagically */
> alsa_simple_close();

simple_{open,setup}() I agree with. There's no reason for that to have to be a 
whole stack of separate functions. Use return codes to indicate the type of 
failure.

simple_writei() might be okay, but it's pretty inflexible for even mildly 
complex problems requiring more than "just write data". The old mechanisms 
need to persist.

simple_close(), uhm.. snd_pcm_close (fd). Don't need it. I'm not sure why you 
think that is necessary.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
