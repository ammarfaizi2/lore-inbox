Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262445AbVAEOZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262445AbVAEOZF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 09:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbVAEOZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 09:25:05 -0500
Received: from dfw-gate4.raytheon.com ([199.46.199.233]:51953 "EHLO
	dfw-gate4.raytheon.com") by vger.kernel.org with ESMTP
	id S262445AbVAEOYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 09:24:53 -0500
Subject: Re: [Alsa-devel] Re: 2.6.10-mm1: ALSA ac97 compile error with CONFIG_PM=n
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, alsa-devel@alsa-project.org,
       Adrian Bunk <bunk@stusta.de>, lkml <linux-kernel@vger.kernel.org>,
       perex@suse.cz
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFB0B3CD59.F6AC2867-ON86256F80.004CECD3@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Wed, 5 Jan 2005 08:21:20 -0600
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 01/05/2005 08:21:41 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> At Tue, 4 Jan 2005 13:25:40 -0600,
> Mark_H_Johnson@raytheon.com wrote:
> > [snip - how to get to the problem]
> > At this point, I get the window asking if I heard the sound (I did
not). If
> > I repeat the test after waiting a short period, it eventually succeeds.
>
> The default blocking behavior of OSS devices was changed recently.
> When the device is in use, open returns -EBUSY immediately in the
> latest version while it was blocked until released in the former
> version.
I suppose there was a "good reason" for changing the user level
interface in this way. Could you [or someone else] explain that and
if you would consider changing it back (to stop breaking old applications)?
Otherwise - is there some way (other than running lsmod and grep) to find
out if the interface is busy and which application is using it?

> > [2] When running latencytest (from
> > http://www.gardena.net/benno/linux/audio/) the sound is not consistent
> > (like it was on 2.4 with OSS) and occasionally I hear "rapid playback"
> > where the repeating audio pattern is much faster than it should be.
>
> It's hard to tell.  The cause could be in the general interrupt
> handling, the difference of HZ, the driver's interrupt setting, or
> whatever.  This must depend on the hardware, anyway.
Well, to a certain extent, I agree but let me repeat the symptoms
I am seeing [repeated below]
> >   a. The time between write() calls to the audio interface varies from
> > roughly 1.16 msec to 2.0 msec. If you add code to dump out the
durations
> > you can see it is a sawtooth pattern, some periods it returns too
quickly
> > and some periods it returns too slowly.
What you describe can certainly explain this first behavior. For example,
if the ALSA code waits for the next clock tick (1 msec resolution)
to return from the write() call, the behavior I see can be explained. I do
not necessarily LIKE this behavior (it makes the analysis of latency and
explanations to other people more difficult) but I understand it and when
this happens - the sound is OK.

> >   b. The time between write() calls is roughly 1.2 msec. I believe this
> > behavior occurs at the same time the audio pattern repeats too quickly.
This behavior on the other hand does not appear reasonable to me. The
latencytest application writes a series of audio fragments, each 1.45 msec
long.
It should never get an extended period (many seconds) where the loop doing
that
gets done at a 1.2 msec rate. What I hear from the speakers (the rapid
playback) does not sound right either. This looks like a bug to me that
needs to be corrected.

I can generally trigger it by running latencytest while reading (or
copying)
a large disk file with the kernels I have been building. Perhaps a long
latency
(> 1 audio fragment - 1.45 msec) is getting the ALSA code into a "hurry up"
mode
which it never leaves. That would explain the symptom but I certainly don't
know the code good enough to tell if that is feasible (or if something else
is causing the symptom).

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

