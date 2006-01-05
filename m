Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751395AbWAEOvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbWAEOvI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbWAEOvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:51:08 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:59911 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1751392AbWAEOvH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:51:07 -0500
Date: Thu, 5 Jan 2006 15:51:01 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Heikki Orsila <shd@modeemi.cs.tut.fi>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>
Subject: Re: [OT] ALSA userspace API complexity
Message-ID: <20060105145101.GB28611@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Jaroslav Kysela <perex@suse.cz>,
	Heikki Orsila <shd@modeemi.cs.tut.fi>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Alistair John Strachan <s0348365@sms.ed.ac.uk>
References: <20060105140155.GC757@jolt.modeemi.cs.tut.fi> <Pine.LNX.4.61.0601051518370.10350@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601051518370.10350@tm8103.perex-int.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 03:24:18PM +0100, Jaroslav Kysela wrote:
> This sentence makes this in my mind: real people = lazy people. The error 
> codes are documented well.

Actual alsa reference documentation:

  int snd_pcm_prepare(snd_pcm_t *pcm)   	
  	
Prepare PCM for use.

Parameters:
    pcm 	PCM handle

Returns:
    0 on success otherwise a negative error code 

[Beautifully documented error codes and causes]

snd_pcm_sframes_t snd_pcm_writei(snd_pcm_t * pcm,
		const void *buffer,
		snd_pcm_uframes_t size
	)  	
  	
Write interleaved frames to a PCM.

Parameters:
    pcm 	PCM handle
    buffer 	frames containing buffer
    size 	frames to be written

Returns:
    a positive number of frames actually written otherwise a negative error code 

Return values:
    -EBADFD 	PCM is not in the right state (SND_PCM_STATE_PREPARED or SND_PCM_STATE_RUNNING)
    -EPIPE 	an underrun occurred
    -ESTRPIPE 	a suspend event occurred (stream is suspended and waiting for an application recovery)

If the blocking behaviour is selected, then routine waits until all requested bytes are played or put to the playback ring buffer. The count of bytes can be less only if a signal or underrun occurred.

If the non-blocking behaviour is selected, then routine doesn't wait at all.

[Count of bytes less than the frame count when an underrun, which
returns -EPIPE, happened?  -EBADFD when the state is XRUN (not it
doesn't)?  Cause and handling of suspend events?]

Anybody who says the alsa documentation is good never had to use it.
At that point I know my simple playing code is incorrect and I have no
clue on how to fix it.


> Also, aplay in the alsa-utils package has
> good error recovery code including test pcm.c utility in alsa-lib.

A sleep(1) in the error recovery path?  Are you people nuts?

Incidentally:

- "A small demo which sends a simple sinusoidal wave to the speakers"
  requiring close to 900 lines is demented.  That's the size of
  glxgears.c, with 50% of that one being printer support.  A complete
  smartflow example getting a sound stream on the network and playing
  it with oss takes 160 lines, with 20 lines of copyright-ish at the
  start.  The actual sound part of that is _30_ lines.


- Error and state handling after writei changes depending on the call.
  We're supposed to guess which one is correct?


Make simple things simple, guys.

  OG.
