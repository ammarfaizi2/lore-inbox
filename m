Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750862AbWAEOCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbWAEOCF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWAEOCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:02:05 -0500
Received: from mail.cs.tut.fi ([130.230.4.42]:23246 "EHLO mail.cs.tut.fi")
	by vger.kernel.org with ESMTP id S1750862AbWAEOCC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:02:02 -0500
Date: Thu, 5 Jan 2006 16:01:55 +0200
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Subject: Re: [OT] ALSA userspace API complexity
Message-ID: <20060105140155.GC757@jolt.modeemi.cs.tut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <5rdrx-4Yl-43@gated-at.bofh.it>
User-Agent: Mutt/1.5.9i
From: shd@modeemi.cs.tut.fi (Heikki Orsila)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> On Tuesday 03 January 2006 23:10, Tomasz K?oczko wrote:
> 2) ALSA API is to complicated: most applications opens single sound
>    stream.

> FUD and nonsense. I've written many DSP applications and very often I can
> recycle the same code for use in them.

It's not FUD and it's very true. I've written ALSA support for many 
programs and I still can't remember the tricks that are needed to get 
even basic things working.

Just look at error handling of libao-0.8.6 for a great example how 
complicated it is to write code for ALSA. The following code is directly 
from the source:

                /* try to write the entire buffer at once */
                err = internal->writei(internal->pcm_handle, ptr, len);

                /* it's possible that no data was transferred */
                if (err == -EAGAIN) {
                        continue;
                }

                if (err < 0) {
                        /* this might be an error, or an exception */
                        err = alsa_error_recovery(internal, err);
                        if (err < 0) {
                                fprintf(stderr,"ALSA write error: %s\n",
                                                snd_strerror(err));
                                return 0;
                        }

                        /* abandon the rest of the buffer */
                        break;
                }

alsa_error_recovery() expands to 30 lines of more logic. This is pretty 
insane considering that libao _only_ writes data to device and does 
nothing else. If ALSA was done properly, the main loop would simply be:

                err = internal->writei(internal->pcm_handle, ptr, len);

                /* it's possible that no data was transferred */
                if (err == -EAGAIN || err == -EINTR) {
                        continue;
                }

		if (err < 0) {
			/* BAD BAD */
		}

When I originally ran into this signal handling brain damage of ALSA, I 
had to actually look into other programs how they handle signals because 
ALSA documentation is so bad. The core problem is of course the broken 
API, not the bad documentation.

A small note, libao can not handle EINTR properly. A patch has been 
submitted already.

I've long ago stopped using ALSA API because it is broken. But if you 
wanted to make ALSA usable by real people you might considering adding 3 
functions (there are ~300 already so not much loss):

	err = alsa_simple_pcm_open(nchannels, sampleformat, samplingrate, frames_in_period /* 0 for automated default */ );
	err = alsa_simple_writei(); /* handless signal brokeness automagically */
	alsa_simple_close();

Basically ogg123/mpg123 like applications would only need 3 alsa calls. 
Now everyone reimplementing their own buggy versions of simple mechanisms.

-- 
Heikki Orsila			Barbie's law:
heikki.orsila@iki.fi		"Math is hard, let's go shopping!"
http://www.iki.fi/shd
