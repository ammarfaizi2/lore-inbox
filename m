Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262549AbVAVGNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262549AbVAVGNq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 01:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262562AbVAVGNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 01:13:46 -0500
Received: from mail.joq.us ([67.65.12.105]:2737 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S262549AbVAVGNo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 01:13:44 -0500
To: Con Kolivas <kernel@kolivas.org>
Cc: utz lehmann <lkml@s2y4n2c.de>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, rlrevell@joe-job.com,
       paul@linuxaudiosystems.com, CK Kernel <ck@vds.kolivas.org>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft	rt
	scheduling
References: <41EEE1B1.9080909@kolivas.org>
	<1106350245.4442.5.camel@segv.aura.of.mankind>
	<41F194DC.40603@kolivas.org>
	<1106353715.4442.20.camel@segv.aura.of.mankind>
	<41F1CE11.6010307@kolivas.org>
From: "Jack O'Quin" <joq@io.com>
Date: Sat, 22 Jan 2005 00:15:04 -0600
In-Reply-To: <41F1CE11.6010307@kolivas.org> (Con Kolivas's message of "Sat,
 22 Jan 2005 14:52:49 +1100")
Message-ID: <87r7kec7mf.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> writes:

> As for priority support, I have been working on it. While the test
> cases I've been involved in show no need for it, I can understand why
> it would be desirable.

Yes.  Rui's jack_test3.2 does not require multiple realtime
priorities, but I can point to applications that do.  Their reasons
for working that way make sense and should be supported.

For example, the JACK Audio Mastering interface (JAMin) does a Fast
Fourier Transform on the audio for phase-neutral frequency domain
crossover and EQ processing.  This is very CPU intensive, but modern
processors can handle it and the sound is outstanding.  The FFT
algorithm uses a moving window with a natural block size of 256
frames.  When the JACK buffer size is large enough, JAMin performs
this operation directly in the process callback.

When the JACK buffer size is smaller than 256 frames that won't work.
So, JAMin queues the audio to a realtime helper thread running at a
priority one less than the JACK process thread.  So, when JACK is
running at 64 frames per cycle (the jack_test3.2 default), JAMin's FFT
thread will have four process cycles in which to compute its next FFT
window.  This adds latency, but permits the application to work even
when the overall JACK graph is running at rather low latencies.  If
the scheduler were to run that thread at the same priority as the JACK
process thread, it would practically guarantee xruns.  This would
cause JAMin to be unfairly ejected from the JACK graph for failing to
meet its realtime deadlines.

So, there are legitimate examples of realtime applications needing to
use more than one scheduler priority.
-- 
  joq
